#!/bin/sh

echo "Installing nginx + nginx-rtmp module..."
sleep 5
echo "update packeges libruary..."
sudo apt-get update
echo "done"
sleep 2
echo "Installing libruary and packages..."
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev unzip
echo "done"
sleep 2


echo "Get module source..."
sleep 2
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip

echo "done"
sleep 2

echo "Get nginx source..."
sleep 2

wget http://nginx.org/download/nginx-1.7.8.tar.gz
echo "done"
sleep 2

echo "Untar nginx source..."
sleep 2

tar -zxvf nginx-1.7.8.tar.gz
unzip master.zip
cd nginx-1.7.8

echo "done"
sleep 2

echo "Compiling nginx source..."
sleep 2

./configure --add-module=../nginx-rtmp-module-master
make
sudo make install

echo "done"
sleep 2


echo "Edit nginx config..."
sleep 2
sudo nano /usr/local/nginx/conf/nginx.conf
echo "done"
sleep 2

echo "Start nginx ..."
sleep 2

sudo /usr/local/nginx/sbin/nginx
echo "done"
sleep 2

