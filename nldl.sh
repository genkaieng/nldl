#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: nldl <URL>"
  exit 1
fi

DIRNAME="$(dirname "$(readlink -f "$0")")"
if [ -f "$DIRNAME/.env" ]; then
  source "$DIRNAME/.env"
fi

lv=$(echo "$1" | grep -oP 'lv\d+')

html=$(wget -qO- "$1" | tr -d '\n')
title=$(echo "$html" | grep -oP '(?<=<title>)(.*?)(?=</title>)')
name=$(echo "$html" | grep -oP '"@type":"Person","name":"\K[^"]+')

echo "$name - $title - $lv"

IFS="-" read -ra parts <<< "$title"
title=$(echo "${parts[0]}" | xargs)
date=$(echo "${parts[1]}" | xargs | grep -oP '\d+\/\d+\/\d+' | xargs -I{} date -d {} +%Y%m%d)

filename="$date $title $name $lv"
filename=${filename//\//-}
filename=${filename// /_}
filename="${filename}.mp4"

streamlink --niconico-user-session="$NICOLIVE_SESSION" "$1" best -O | ffmpeg -i - -c copy -f mp4 -y "$filename"
