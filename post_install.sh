#!/bin/local/bin/bash

# Enable the service
sysrc -f /etc/rc.conf php_fpm_enable="YES"

config = '/usr/local/etc/php-fpm.conf'
user = 'www'

#sed -i '' 's/.*opcache.enable=.*/opcache.enable=1/' /usr/local/etc/php-fpm.conf
# sed -i '' 's/^//' /usr/local/etc/php-fpm.conf
sed -i '' -E 's#^;?emergency_restart_threshold .*$#emergency_restart_threshold = 10#' /usr/local/etc/php-fpm.conf
sed -i '' -E 's#^;?emergency_restart_interval.*$#emergency_restart_interval = 1m#' /usr/local/etc/php-fpm.conf
sed -i '' -E 's#^;?process_control_timeout.*$#process_control_timeout = 10s#' /usr/local/etc/php-fpm.conf
sed -i '' -E 's#^;?include.*$#include=/usr/local/etc/php-fpm.d/*/*.conf#' /usr/local/etc/php-fpm.conf


mkdir -p /var/run/php-fpm/www
mkdir /usr/local/etc/php-fpm.d/www
mv /usr/local/etc/php-fpm.conf/www.conf* /usr/local/etc/php-fpm.d/www
sed -i '' -E 's#^;?listen ?=.*$#listen = /var/run/php-fpm/www/php-fpm.sock#' /usr/local/etc/php-fpm.d/www/www.conf
sed -i '' -E 's#^;?listen.owner ?=.*$#listen.owner = www#' /usr/local/etc/php-fpm.d/www/www.conf
sed -i '' -E 's#^;?listen.group ?=.*$#listen.group = www#' /usr/local/etc/php-fpm.d/www/www.conf

service php-fpm start

exit


grep listen /usr/local/etc/php-fpm.d/www/www.conf | sed -E 's#^;?listen ?=.*$#listen = /xxx/php-fpm_www.sock#'
