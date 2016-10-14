<?php 

$path='/home/vc/root/voctomix/example-scripts/control-server';

if ($_GET['w']=='pip') $cmd='set_composite_mode picture_in_picture';
if ($_GET['w']=='fs') $cmd='set_composite_mode fullscreen';
if ($_GET['w']=='ss') $cmd='set_composite_mode side_by_side_equal';
if ($_GET['w']=='ssp') $cmd='set_composite_mode side_by_side_preview';

$fp=fsockopen('localhost', 9999, $errno, $errstr, 30);
if (!$fp) {
    echo "$errstr ($errno)<br />\n";
} else {
    fwrite($fp, $cmd."\n");
    fclose($fp);
}

//header('Location: /show.html');
