![alt tag](https://glpi-project.org/wp-content/uploads/2017/03/logo-glpi-bleu-1.png)

Stack de servicos do GLPI para execução do GLPI, além da instalação a mesma conta com a instalação dos seguintes plugins:

Para o funcionamento do serviço e necessário  uma maquina virtual com o Mysql previamente instalado e configurado.

# NOTAS DE VERSÃO
 °  Versão 1.0 - 15/07/2018 ==> Criação do Dockerfile e do Docker composse.\
 °  Versão 1.1 - 30/08/2018 ==> Atualizacao da versão do Zabbix Server.\
 °  Versão 1.2 - 05/10/2018 ==> Configuração do Timezone America/Sao_Paulo.\
 °  Versão 1.3 - 29/10/2018 ==> Configuracao da locales pt-BR.

 Versão do GLPI: 9.3.1

# PRÉ-REQUISITO
Os pre-requisitos necessários para execução da stack de serviço:
 1) Docker Instalado e configurado.
 2) Docker Swarm configurado.
 3) Maquins virtual com 2 vCPU's e 4 GB de RAM.
 4) Maquina virtal com Mysql instalado e configurado.

# PLUGINS INSTALADOS
 • Fusioninventory
 • Behaviors
 • Dashboard
 • Data Injection
 • Escalade
 • Formcreator
 
Para mais plugins acesse o link abaixo:
https://plugins.glpi-project.org/

# INSTALANDO E CONFIGURANDO DOCKER
 curl -fsSL https://get.docker.com | bash

# INSTALANDO DOCKER SWARM
 docker swarm init --advertise-addr  <IP_DO_SERVIDOR>

 Onde:\
 <IP_DO_SERVIDOR> deve ser substituído pelo ip do seu servidor.

# BAIXANDO A IMAGEM
 docker pull leandromoreirajfa/glpi-apache:1.3
                                                 
# SERVIÇO GLPI SERVER
Para configurar o serviço do GLPI, editar o arquivo glpi.config alterando as variáveis:

MYSQL_HOST=<IP_SERVIDDOR_MYSQL>\
GLPI_USER=<USUARIO_DATABASE_GLPI>\
GLPI_PASS=<USUARIO_DATABASE_GLPI_PASSWORD>\
GLPI_DB=<GLPI_DATABASE>\
APACHE_VHOST=<APACHE_VHOST_HOST>\
HTTP_PORT=80
HTTPS_PORT=443
APACHE_SRV_ADMIN=<APACHE_SRV_ADMIN_EMAIL>\
CERT_FILE=<NOME_ARQUIVO_CERTIFICADO>\
CERT_KEY=<NOME_ARQUIVO_KEY>

# INICIANDO O SERVICO
 docker stack deploy -c docker-compose.yml glpi 
