#!/bin/bash

sudo apt-get update
sudo apt-get install curl libpcre3 libpcre3-dev zlib1g-dev libssl-dev build-essential git libxslt-dev libgd2-xpm-dev libgeoip-dev libpam-dev libperl-dev libxml2 libxml2-dev libxml2-utils libaprutil1 libaprutil1-dev apache2-prefork-dev libtool automake -y
wget https://nginx.org/download/nginx-1.11.3.tar.gz && tar zxvf nginx-1.11.3.tar.gz
#PageSpeed
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-1.11.33.2-beta.zip -O pagespeed.zip
unzip pagespeed.zip
cd ngx_pagespeed-*
wget https://dl.google.com/dl/page-speed/psol/1.11.33.2.tar.gz
tar -xzvf 1.11.33.2.tar.gz
cd ..
#openSSL 1.0.2 stable
git clone https://github.com/cloudflare/sslconfig
wget -O openssl.zip -c https://github.com/openssl/openssl/archive/OpenSSL_1_0_2h.zip
unzip openssl.zip
mv openssl-OpenSSL_1_0_2h/ openssl
cd openssl && patch -p1 < ../sslconfig/patches/openssl__chacha20_poly1305_draft_and_rfc_ossl102g.patch
cd ../
wget -O nginx-ct.zip -c https://github.com/grahamedgecombe/nginx-ct/archive/v1.3.0.zip
unzip nginx-ct.zip
cd nginx-1.11.3
./configure --add-module=../nginx-ct-1.3.0 --with-openssl=../openssl --add-module=../ngx_pagespeed-release-1.11.33.2-beta --prefix=/etc/nginx --conf-path=/etc/nginx/nginx.conf --sbin-path=/usr/bin/nginx --pid-path=/run/nginx.pid --lock-path=/run/lock/nginx.lock --user=http --group=http --http-log-path=/var/log/nginx/access.log --error-log-path=stderr --http-client-body-temp-path=/var/lib/nginx/client-body --http-proxy-temp-path=/var/lib/nginx/proxy --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-ipv6 --with-pcre-jit --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_degradation_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_realip_module --with-http_secure_link_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_ssl_module --with-threads 
make
