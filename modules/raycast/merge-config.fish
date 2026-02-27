#!/usr/bin/env fish

set overlay_file $argv[1]
set config_dir $argv[2]
set password $argv[3]
set merge_jq $argv[4]

if test -z "$merge_jq"
    set merge_jq (status dirname)/merge.jq
end

set tmpdir (mktemp -d)
trap "rm -rf $tmpdir" EXIT

function log
    echo "[raycast-merge]" $argv
end

set -l configs $config_dir/*.rayconfig
set rayconfig ""
set -l newest 0
for f in $configs
    if test -f "$f"
        set -l mtime (stat -f %m "$f")
        if test "$mtime" -gt "$newest"
            set newest $mtime
            set rayconfig "$f"
        end
    end
end
if test -z "$rayconfig"
    log "No .rayconfig found in $config_dir — skipping merge"
    exit 0
end

log "Using config: $rayconfig"

openssl enc -d -aes-256-cbc -nosalt -k "$password" -in "$rayconfig" 2>/dev/null > "$tmpdir/decrypted.bin"
if test $status -ne 0
    log "ERROR: Failed to decrypt $rayconfig"
    exit 1
end

head -c 16 "$tmpdir/decrypted.bin" > "$tmpdir/header.bin"
tail -c +17 "$tmpdir/decrypted.bin" | gunzip > "$tmpdir/current.json" 2>/dev/null
if test $status -ne 0
    log "ERROR: Failed to decompress decrypted config"
    exit 1
end

log "Decrypted OK — "(wc -c < "$tmpdir/current.json" | string trim)" bytes"

killall Raycast 2>/dev/null
sleep 0.5

jq --slurpfile overlay "$overlay_file" -f "$merge_jq" "$tmpdir/current.json" > "$tmpdir/merged.json"
if test $status -ne 0
    log "ERROR: jq merge failed"
    exit 1
end

jq '.raycast_version' "$tmpdir/merged.json" > /dev/null 2>&1
if test $status -ne 0
    log "ERROR: Merged JSON is invalid"
    exit 1
end

set merged_count (jq '[.builtin_package_rootSearch.rootSearch[] | select(.hotkey)] | length' "$tmpdir/merged.json")
log "Merged OK — $merged_count items with hotkeys"

gzip -c "$tmpdir/merged.json" | cat "$tmpdir/header.bin" - | \
    openssl enc -e -aes-256-cbc -nosalt -k "$password" -out "$tmpdir/output.rayconfig" 2>/dev/null
if test $status -ne 0
    log "ERROR: Failed to encrypt merged config"
    exit 1
end

set timestamp (date +"%Y-%m-%d %H.%M.%S")
set output_path "$config_dir/Raycast $timestamp.rayconfig"
cp "$tmpdir/output.rayconfig" "$output_path"
log "Wrote: $output_path"

open "$output_path"
log "Done — import dialog opened. Enter password to apply."
