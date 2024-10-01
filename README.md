# Despliegue de servidores Linux

## Despliegue Normal
### 1. Abrimos una Terminal de Linux
Presionamos la tecla de Menu/Windows y escribimos terminal.
### 2. Iniciamos el despliegue
#### Copia el siguiente texto:
~~~
mkdir deploy && \
cd deploy && \
wget https://raw.githubusercontent.com/GithubNfq/linux_deploy/refs/heads/main/programs.list && \
wget https://raw.githubusercontent.com/GithubNfq/linux_deploy/refs/heads/main/start.sh && \
wget https://raw.githubusercontent.com/GithubNfq/linux_deploy/refs/heads/main/tools.sh && \
sudo chmod +x ./* && \
echo -e "\e[1m\e[32mTodo se ha descargado de forma correcta\e[0m" && \
./start.sh

~~~
#### Una vez lo tenemos hemos pegado presionamos ***\"ENTER\"***








## Despliegue con GIT
### Paso 1:
Descargar este repositorio con el siguiete comando.

`git clone --depth 1 git@github.com:GithubNfq/linux_deploy.git ./despliegue_inicial`

### Paso 2:
Ejecutamos el script inicial.

Copiamos y pegamos la siguiente linea: `./despliegue_inicial/start.sh`
