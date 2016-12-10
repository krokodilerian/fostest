<?php 

if ($_GET['w']=='ssp-p') $cmd[]= ('set_video_a cam1', 'set_video_b grab', 'set_composite_mode picture_in_picture');
if ($_GET['w']=='ssp-s') $cmd[]= ('set_video_b cam1', 'set_video_a grab', 'set_composite_mode picture_in_picture');
if ($_GET['w']=='fs-p') $cmd[]= ('set_video_a cam1', 'set_composite_mode fullscreen')
if ($_GET['w']=='fs-s') $cmd[]= ('set_video_a grab', 'set_composite_mode fullscreen')

$fp=fsockopen('localhost', 9999, $errno, $errstr, 30);

if (!$fp) {
	echo "$errstr ($errno)<br />\n";
	exit(1);

foreach ($cmd as $command) 
	fwrite($fp, $command."\n");

fclose($fp);

//header('Location: /show.html');
