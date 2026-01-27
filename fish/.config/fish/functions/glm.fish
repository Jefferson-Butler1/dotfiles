function glm
    env ANTHROPIC_DEFAULT_HAIKU_MODEL=glm-4.5-air \
        ANTHROPIC_DEFAULT_SONNET_MODEL=glm-4.7 \
        ANTHROPIC_DEFAULT_OPUS_MODEL=glm-4.7 \
        ANTHROPIC_AUTH_TOKEN=887ed99d1f914564a50eabb17d99c669.bzwtv5GaqyYXeEfV \
        ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic \
        claude $argv
end
