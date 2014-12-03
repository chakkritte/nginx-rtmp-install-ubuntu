nginx-rtmp-php-install-ubuntu
=========================
Installing nginx with RTMP module and PHP on ubuntu

## Basic Install [1] ##
    sudo apt-get update
    sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev unzip
    
    wget http://nginx.org/download/nginx-1.7.8.tar.gz
    wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
    
    tar -zxvf nginx-1.7.8.tar.gz
    unzip master.zip
    cd nginx-1.7.8
    
    ./configure --add-module=../nginx-rtmp-module-master
    make
    sudo make install
    
    sudo /usr/local/nginx/sbin/nginx
    
    sudo nano /usr/local/nginx/conf/nginx.conf
    
## Config nginx ##
  Add the following at the very end of the file:
    
    rtmp {
        server {
                listen 1935;
                chunk_size 4096;
                application live {
                        live on;
                        record off;
                }
        }
    }
    
  Restart nginx with:
  
    sudo /usr/local/nginx/sbin/nginx -s stop
    sudo /usr/local/nginx/sbin/nginx
    
## Test ##
  Streaming Service: Custom
  
  Server: rtmp://<your server ip>/live
  
  Play Path/Stream Key: test
  
  
## Install PHP [2] [3] [4] ##
    sudo apt-get install php5-fpm
  
## Configure php ##
    sudo nano /etc/php5/fpm/php.ini
    
  Find the line, cgi.fix_pathinfo=1, and change the 1 to 0.
  
    cgi.fix_pathinfo=0
    
  Making PHP-FPM Use A TCP Connection
  
    sudo nano /etc/php5/fpm/pool.d/www.conf
  
  and make the listen line look as follows:
  
    ;listen = /var/run/php5-fpm.sock
    listen = 127.0.0.1:9000
    
  Restart php-fpm:
  
    sudo service php5-fpm restart
    
  Configure nginx
  
    sudo nano /usr/local/nginx/conf/nginx.conf
    
  Edit
  
    index index.php index.html index.htm;
    
  Add
  
    # Pass PHP scripts to PHP-FPM
    location ~* \.php$ {
      fastcgi_index   index.php;
      fastcgi_pass    127.0.0.1:9000;
      #fastcgi_pass   unix:/var/run/php-fpm/php-fpm.sock;
      include         fastcgi_params;
      fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
      fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
    }
    
  Restart nginx with:
  
    sudo /usr/local/nginx/sbin/nginx -s stop
    sudo /usr/local/nginx/sbin/nginx
    
## nginx-init-ubuntu [5] ##

    #copy/download/curl/wget the init script
    sudo wget https://raw.github.com/chakkritte/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
    sudo chmod +x /etc/init.d/nginx
    
    service nginx status  # to poll for current status
    service nginx stop    # to stop any servers if any
    service nginx start   # to start the server
    
    #[optional] 
    sudo update-rc.d -f nginx defaults

    #[optional remove the upstart script]
    sudo update-rc.d -f nginx remove

    
## Reference ##
  [1] [How to Live Stream to Multiple Services with a RTMP Server](http://linustechtips.com/main/topic/174603-how-to-live-stream-to-multiple-services-with-a-rtmp-server/)
  
  [2] [How To Install Linux, nginx, MySQL, PHP (LEMP) stack on Ubuntu 12.04](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-12-04)
  
  [3] [Installing Nginx With PHP5 (And PHP-FPM) And MySQL Support (LEMP) On Ubuntu 14.04 LTS](http://www.howtoforge.com/installing-nginx-with-php5-fpm-and-mysql-on-ubuntu-14.04-lts-lemp)
  
  [4] [Nginx and PHP-FPM Configuration and Optimizing Tips and Tricks](http://www.if-not-true-then-false.com/2011/nginx-and-php-fpm-configuration-and-optimizing-tips-and-tricks/)
  
  [5] [nginx-init-ubuntu](https://github.com/JasonGiedymin/nginx-init-ubuntu)
  
  
  

  
