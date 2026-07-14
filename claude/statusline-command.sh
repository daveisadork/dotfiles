#!/bin/sh
# Claude Code status line: context token count + context window percentage

input=$(cat)

total_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Format token count with at most 3 significant digits
if [ "$total_tokens" -lt 1000 ] 2>/dev/null; then
	token_str="${total_tokens}"
elif [ "$total_tokens" -lt 10000 ] 2>/dev/null; then
	# e.g. 9.99k
	token_str=$(awk "BEGIN { printf \"%.2fk\", $total_tokens/1000 }")
elif [ "$total_tokens" -lt 100000 ] 2>/dev/null; then
	# e.g. 99.9k
	token_str=$(awk "BEGIN { printf \"%.1fk\", $total_tokens/1000 }")
else
	# e.g. 999k
	token_str=$(awk "BEGIN { printf \"%.0fk\", $total_tokens/1000 }")
fi

# Choose color based on token count
if [ "$total_tokens" -lt 50000 ] 2>/dev/null; then
	color="\033[32m" # green
elif [ "$total_tokens" -lt 100000 ] 2>/dev/null; then
	color="\033[33m" # yellow
else
	color="\033[31m" # red
fi
reset="\033[0m"
gray="\033[2;37m" # dim gray

# Build output
if [ -n "$used_pct" ]; then
	pct_str=$(awk "BEGIN { printf \"%.1f%%\", $used_pct }")
	printf "${color}%s${reset} ${gray}(%s)${reset}" "$token_str" "$pct_str"
else
	printf "${color}%s${reset}" "$token_str"
fi
