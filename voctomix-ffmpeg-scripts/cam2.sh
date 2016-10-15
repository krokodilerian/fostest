#!/bin/sh
confdir="`dirname "$0"`/../"
. $confdir/default-config.sh
if [ -f $confdir/config.sh ]; then
	. $confdir/config.sh
fi

echo 81921024 > /proc/sys/net/core/wmem_max
echo 81921024 > /proc/sys/net/core/wmem_default

echo 81921024 > /proc/sys/net/core/rmem_max
echo 81921024 > /proc/sys/net/core/rmem_default

if [ -z "$1" ]; then
	src="udp://239.255.42.42:5004?overrun_nonfatal=1&buffer_size=81921024&fifo_size=178481"
else
	src="$1"
fi

ffmpeg -y -nostdin \
	-re -i "$src" \
	-ac 2 \
	-threads 2 \
	-r $FRAMERATE \
	-analyzeduration 50000000 -probesize 50000000 \
	-s ${WIDTH}x${HEIGHT} \
	-ar $AUDIORATE \
	-pix_fmt yuv420p \
	-c:v rawvideo \
	-c:a pcm_s16le \
	-f matroska \
	tcp://localhost:10002
