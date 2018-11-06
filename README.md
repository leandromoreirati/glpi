![alt tag](https://glpi-project.org/wp-content/uploads/2017/03/logo-glpi-bleu-1.png)

Stack de servicos do GLPI para execução do GLPI, além da instalação a mesma conta com a instalação dos seguintes plugins:

Para o funcionamento do serviço e necessário  uma maquina virtual com o Mysql previamente instalado e configurado.

# NOTAS DE VERSÃO
 °  Versão 1.0 - 15/07/2018 ==> Criação do Dockerfile e do Docker composse.\
 °  Versão 1.1 - 30/08/2018 ==> Atualizacao da versão do Zabbix Server.\
 °  Versão 1.2 - 05/10/2018 ==> Configuração do Timezone America/Sao_Paulo.

 Versão do Zabbix: 9.3.0

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

# BAIXANDO AS IMAGENS
 docker pull leandromoreirajfa/zabbix-server:1.2
                                                 
# SERVIÇO ZABBIX SERVER
Para configurar o serviço do Zabbix Server, editar o arquivo server.config que localiza-se no diretório configs, alterando as variáveis:

PGSQL_HOST=<IP_DO_SERVIDOR>\
PGSQL_ZABBIX_USER=<USUARIO_ZABBIX>\
PGSQL_ZABBIX_BD=<ZABBIX_DATABASE>\
PGSQL_ZABBIX_PASS=<SENHA_ZABBIX_USER>

# INICIANDO O SERVICO
 docker stack deploy -c docker-compose.yml zabbix-server
