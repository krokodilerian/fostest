#! /bin/bash

../ffmpeg/ffmpeg -y -loglevel verbose \
  -i 'udp://227.0.0.1:9000?overrun_nonfatal=1&buffer_size=81921024&fifo_size=178481' \
  -i 'udp://227.0.0.2:9000?overrun_nonfatal=1&buffer_size=81921024&fifo_size=178481' \
  -loop 1 -i './bg.png' \
-filter_complex "[1:1] asetpts=PTS-STARTPTS, channelmap=map=FL|FL [maina];
[2:0] setpts=PTS-STARTPTS, scale=800:450 [pres];
[1:0] setpts=PTS-STARTPTS, scale=544:306:force_original_aspect_ratio=1 [cam];
[0:0] setsar=1/1, setpts=PTS-STARTPTS [bg];
[bg_c][pres] overlay=x=16:y=16:eof_action=endall [bg_pc];
[bg][cam] overlay=x=736:y=414:eof_action=endall [bg_c];
[bg_pc][maina] concat=n=1:v=1:a=1 [outv][outa]" \
 -map '[outv]:v' -map '[outa]:a' \
 -pix_fmt yuv420p \
 -vcodec libx264 -threads 4 -preset veryfast -b:v 1000k -acodec aac -aq 80 -strict -2 \
 -f flv rtmp://strm.ludost.net/st/test
 #-f tee '[flv]rtmp://strm.ludost.net/st/tarnovoconf-fd|[flv]log.'`date +%s`'.flv'
