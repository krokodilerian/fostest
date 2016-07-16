#!/bin/bash

if [ -z "$1" ]; then
	echo usage: $0 streamlist
	exit
fi

xsize=480
ysize=272

xscreen=1200


x=0
y=0

( while read name url; do
	if [ -z "$name" ]; then
		break
	fi
	mpv --mute=yes --geometry=${xsize}x${ysize}+$x+$y --window-scale=0.2 --osd-level=3  --osd-back-color=#000000 --osd-align-x=center --osd-margin-y=300 --osd-font-size=100 --osd-msg3="$name" --title="$name" --lavfi-complex='[aid1] asplit [t1] [ao] ; [t1] showvolume=w=1000:h=100 [t2] ; [vid1]  [t2]  overlay  [vo]' $url &
	let x=$x+$xsize
	if [ $x -gt $xscreen ]; then
		x=0
		let y=$y+$ysize
	fi

done

) < "$1"
