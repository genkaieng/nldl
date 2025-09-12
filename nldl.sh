#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: nldl <URL>"
  exit 1
fi

DIRNAME="$(dirname "$(readlink -f "$0")")"
if [ -f "$DIRNAME/.env" ]; then
  source "$DIRNAME/.env"
fi

html=$(wget -qO- "$1" | tr -d '\n')
title=$(echo "$html" | sed -nE 's/.*<title>([^<]*)<\/title>.*/\1/p')
lvid=$(echo "$html" | awk 'match($0,/lv[0-9]+/){print substr($0,RSTART,RLENGTH); exit}')
name=$(echo "$html" | sed -nE 's/.*"@type":"Person","name":"([^"]*)".*/\1/p')

echo "$name - $title - $lvid"

IFS="-" read -ra parts <<< "$title"
title=$(echo "${parts[0]}" | xargs)
date=$(echo "${parts[1]}" | xargs |
  awk '{
    if (match($0,/[0-9]{4}\/[0-9]{1,2}\/[0-9]{1,2}/)) {
      date = substr($0, RSTART, RLENGTH)
      split(date,a,"/")
      printf("%04d%02d%02d",a[1],a[2],a[3])
    }
  }'
)

filename="$date $title $name $lvid"
filename=${filename//\//-}
filename=${filename// /_}
filename="${filename}.mp4"

if [ -z "$NICOLIVE_SESSION" ]; then
  streamlink "$1" best -O | ffmpeg -i - -c copy -f mp4 -y "$filename"
else
  streamlink --niconico-user-session="$NICOLIVE_SESSION" "$1" best -O | ffmpeg -i - -c copy -f mp4 -y "$filename"
fi
