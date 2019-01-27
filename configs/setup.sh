#!/bin/bash
set -x
mv /etc/apache2/sites-available/site.conf /etc/apache2/sites-available/$APACHE_VHOST.conf

sed -i 's/$APACHE_VHOST/'$APACHE_VHOST'/g'                      /etc/apache2/sites-available/$APACHE_VHOST.conf
sed -i 's/$APACHE_VHOST/'$APACHE_VHOST'/g'                      /etc/apache2/sites-available/$APACHE_VHOST.conf
sed -i 's/$APACHE_SRV_ADMIN/'$APACHE_SRV_ADMIN'/g'              /etc/apache2/sites-available/$APACHE_VHOST.conf
sed -i 's/$HTTP_PORT/'$HTTP_PORT'/g'                            /etc/apache2/sites-available/$APACHE_VHOST.conf
sed -i 's/$HTTPS_PORT/'$HTTPS_PORT'/g'                          /etc/apache2/sites-available/$APACHE_VHOST.conf
sed -i 's/$CERT_FILE/'$CERT_FILE'/g'                            /etc/apache2/sites-available/$APACHE_VHOST.conf
sed -i 's/$CERT_KEY/'$CERT_KEY'/g'                              /etc/apache2/sites-available/$APACHE_VHOST.conf
sed -i 's/$APACHE_VHOST/'$APACHE_VHOST'/g'                      /etc/apache2/apache2.conf

sed -i 's|$TZ|'$TZ'|g'                                          /etc/php/7.0/apache2/php.ini
sed -i 's/$MAX_EXECUTION_TIME/'$MAX_EXECUTION_TIME'/g'          /etc/php/7.0/apache2/php.ini
sed -i 's/$MEMORY_LIMIT/'$MEMORY_LIMIT'/g'                      /etc/php/7.0/apache2/php.ini
sed -i 's/$POST_MAX_SIZE/'$POST_MAX_SIZE'/g'                    /etc/php/7.0/apache2/php.ini
sed -i 's/$UPLOAD_MAX_FILESIZE/'$UPLOAD_MAX_FILESIZE'/g'        /etc/php/7.0/apache2/php.ini
sed -i 's/$CGI_FIX_PATHINFO/'$CGI_FIX_PATHINFO'/g'              /etc/php/7.0/apache2/php.ini

sed -i 's/$MYSQL_HOST/'$MYSQL_HOST'/g'                          /srv/www/html/public_html/glpi/config/config_db.php
sed -i 's/$GLPI_USER/'$GLPI_USER'/g'                            /srv/www/html/public_html/glpi/config/config_db.php
sed -i 's/$GLPI_PASS/'$GLPI_PASS'/g'                            /srv/www/html/public_html/glpi/config/config_db.php
sed -i 's/$GLPI_DB/'$GLPI_DB'/g'                                /srv/www/html/public_html/glpi/config/config_db.php

sed -i 's/$HTTP_PORT/'$HTTP_PORT'/g'                            /etc/apache2/ports.conf
sed -i 's/$HTTPS_PORT/'$HTTPS_PORT'/g'                          /etc/apache2/ports.conf

# CONFIGURANDO HOSTS
IP=`cat /etc/hosts| grep 172 | awk '{print$1}'`
echo "$IP       $APACHE_VHOST" >> /etc/hosts

# ATUALIZANDO TABELAS DO BANCO PARA INNODB
php /srv/www/html/public_html/glpi/scripts/innodb_migration.php

# REMOVENDO ARQUIVO DE INSTALACAO
rm -rfv /srv/www/html/public_html/glpi/install/install.php

# HABILITANDO SSL
$(which a2enmod) ssl

# CONFIGURANDO VIRTUAL HOSTS
$(which a2ensite) $APACHE_VHOST.conf

# INICIANDO A POSTFIX
$(which service) postfix start

# INICIANDO A CRON
$(which service) cron start

# INICIANDO O APACHE
$(which service) apache2 start && bash


set +x
