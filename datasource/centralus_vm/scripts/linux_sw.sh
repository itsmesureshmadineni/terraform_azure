#!/bin/bash

sudo apt-get update -y
sudo apt install -y apache2
sudo echo "<h1> this is created from custom script </h1>" >> /var/www/html/index.html


