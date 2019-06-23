FROM debian:stretch-slim
LABEL maintainer Leandro Moreira <leandro@leandromoreirati.com.br>

ARG  DEBIAN_VERSION=stretch
ARG  KEY=ABF5BD827BD9BF62

COPY configs/   /tmp/configs/

WORKDIR /srv/www/html/public_html

RUN echo "deb http://ftp.de.debian.org/debian stretch main non-free" >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install --no-install-recommends ca-certificates apache2 libapache2-mod-php7.0 php7.0-cli php7.0 php7.0-gd php7.0-imap php7.0-ldap php7.0-mysql php7.0-soap php7.0-xmlrpc zip unzip bzip2 unrar-free php7.0-snmp php7.0-curl php7.0-json php-memcached php7.0-dev php7.0-mbstring php-apcu-bc php-cas php7.0-xml curl wget cron -y cron snmp snmp-mibs-downloader locales exim4 && \
    a2enmod xml2enc && \
    a2enmod ldap && \
    mv -v /tmp/configs/setup.sh /usr/bin/ && \
    chmod +x /usr/bin/setup.sh && \
    mv -v /tmp/configs/site.conf /etc/apache2/sites-available/ && \
    mv -v /tmp/configs/php.ini /etc/php/7.0/apache2/ && \
    mv -v /tmp/configs/ports.conf /etc/apache2/ && \
    mv -v /tmp/configs/apache2.conf /etc/apache2/ && \
    mv -v /tmp/configs/update-exim4.conf.conf /etc/exim4/ && \
    mv -v /tmp/configs/passwd.client /etc/exim4/ && \
    echo "#CRON GLPI" >> /var/spool/cron/crontabs/root && \
    echo "*/1 * * * * /usr/bin/php7.0 /srv/www/html/public_html/glpi/front/cron.php > /var/log/glpi.log 2>&1" >> /var/spool/cron/crontabs/root && \
    chown root.crontab /var/spool/cron/crontabs/root && \
    chmod 600 /var/spool/cron/crontabs/root && \
    tar xvf /tmp/configs/glpi-9.4.2.tgz -C /srv/www/html/public_html && \
    tar xvf /tmp/configs/fusioninventory-9.3.1.1.tar.bz2 -C /srv/www/html/public_html/glpi/plugins && \
    tar xvf /tmp/configs/GLPI-dashboard_plugin-0.9.3.tar.gz -C /srv/www/html/public_html/glpi/plugins && \
    tar xvf /tmp/configs/glpi-datainjection-2.6.3.tar.bz2 -C /srv/www/html/public_html/glpi/plugins && \
    tar xvf /tmp/configs/glpi-escalade-2.3.2.tar.bz2 -C /srv/www/html/public_html/glpi/plugins && \
    tar xvf /tmp/configs/glpi-tag-2.2.2.tar.bz2 -C /srv/www/html/public_html/glpi/plugins && \
    tar xvf /tmp/configs/glpi-formcreator-2.6.4.tar -C /srv/www/html/public_html/glpi/plugins && \  
    tar xvf /tmp/configs/glpi-behaviors-2.1.1.tar.gz -C /srv/www/html/public_html/glpi/plugins && \  
    tar xvf /tmp/configs/glpi-tasklists-1.4.1.tar.gz -C /srv/www/html/public_html/glpi/plugins && \
    unzip /tmp/configs/Plugin_Modifications_1.2.4_GLPI_9.3.2.zip -d /srv/www/html/public_html/glpi/plugins && \  
    mv -v /tmp/configs/config_db.php /srv/www/html/public_html/glpi/config/config_db.php && \
    chown -R www-data:www-data /srv/www/html/public_html/glpi/ && \
    chmod -R 755 /srv/www/html/public_html/glpi && \
    chmod -R 777 /srv/www/html/public_html/glpi/plugins && \
    chmod -R 777 /srv/www/html/public_html/glpi/files/ && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    apt-get clean && \ 
    sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen pt_BR.UTF-8 && \
    update-locale LANG=pt_BR.UTF-8 && \ 
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /etc/apache2/sites-enabled/* && \
    rm -rf /tmp/* 

ENV LANG='pt_BR.UTF-8'

EXPOSE 80 443
