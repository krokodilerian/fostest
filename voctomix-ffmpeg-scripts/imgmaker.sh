#1/bin/bash

DST=/var/www/output.png

while /bin/true; do
	ffmpeg -y -i tcp://localhost:11000 -map 0:v -an -vframes 1 tmp.png
	mv tmp.png $DST
	sleep 1
done
