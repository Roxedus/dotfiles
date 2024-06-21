
#! /usr/bin/env sh
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}
echo "${1}"
if [ -n "$1" ]; then
	echo "${1}"
{{- if .integration.eza.enabled }}
elif [ -d "$1" ]; then
	eza --git -hl --color=always --icons "$1"
{{- end }}
elif [ "$category" = application ]; then
	MANWIDTH=$FZF_PREVIEW_COLUMNS man "$1"
{{- if lookPath "bat" }}
elif [ "$category" = text ]; then
	bat --color=always "$1"
{{- end }}
else
	lesspipe.sh "$1"
fi
