#!/bin/sh
input=$(cat)
total=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

format_tokens() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000) printf "%.1fk", n/1000
    else printf "%d", n
  }'
}

token_color() {
  awk -v n="$1" 'BEGIN {
    if (n >= 100000) printf "\033[31m"
    else if (n >= 50000) printf "\033[33m"
    else printf "\033[32m"
  }'
}

if [ -n "$total" ] && [ -n "$pct" ]; then
  printf "%s%s\033[0m \033[2m(%.0f%%)\033[0m" "$(token_color "$total")" "$(format_tokens "$total")" "$pct"
elif [ -n "$total" ]; then
  printf "%s%s\033[0m" "$(token_color "$total")" "$(format_tokens "$total")"
fi
