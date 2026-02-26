# Merge preferences
(if ($overlay[0].preferences | length) > 0 then
  .builtin_package_raycastPreferences as $prefs |
  reduce ($overlay[0].preferences | to_entries[]) as $section (
    .;
    .builtin_package_raycastPreferences[$section.key] = (
      ($prefs[$section.key] // {}) + $section.value
    )
  )
else . end) |

# Merge rootSearch items
(if ($overlay[0].rootSearch | length) > 0 then
  .builtin_package_rootSearch.rootSearch as $current |
  ($overlay[0].rootSearch | group_by(.match) |
    map({(.[0].match): .}) | add) as $byMatch |

  # Hotkeys claimed by the overlay — used to clear conflicts
  [$overlay[0].rootSearch[].hotkey] as $claimedHotkeys |

  # Update existing items
  .builtin_package_rootSearch.rootSearch = [
    $current[] |
    . as $item |
    ([$byMatch.exact // [] | .[] | select(.key == $item.key)] | first) as $exactMatch |
    ([$byMatch.prefix // [] | .[] | . as $pfx |
      select($item.key | startswith($pfx.key))] | first) as $prefixMatch |
    ($exactMatch // $prefixMatch) as $match |
    if $match then
      # Overlay match: apply declared hotkey
      . + {hotkey: $match.hotkey} +
      (if $match.type then {type: $match.type} else {} end)
    elif (.hotkey // null) != null and ($claimedHotkeys | index($item.hotkey)) != null then
      # No overlay match but hotkey conflicts with an overlay-claimed hotkey: clear it
      del(.hotkey)
    else . end
  ] |

  # Append overlay items with no match in current config
  .builtin_package_rootSearch.rootSearch += [
    $overlay[0].rootSearch[] |
    . as $oi |
    if $oi.match == "exact" then
      if [$current[] | select(.key == $oi.key)] | length == 0 then
        {key: $oi.key, hotkey: $oi.hotkey, type: $oi.type}
      else empty end
    else
      if [$current[] | . as $c | select($c.key | startswith($oi.key))] | length == 0 then
        {key: $oi.key, hotkey: $oi.hotkey, type: $oi.type}
      else empty end
    end
  ]
else . end)
