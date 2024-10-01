#!/bin/bash
function mensajes(){
    case $1 in
        "error")
            echo -e "\e[31m$2\e[0m"
            ;;
        "error_b")
            echo -e "\e[1m\e[31m$2\e[0m"
            ;;
        "info")
            echo -e "\e[32m$2\e[0m"
            ;;
        "info_b")
            echo -e "\e[1m\e[32m$2\e[0m"
            ;;
        "warning")
            echo -e "\e[33m$2\e[0m"
            ;;
        "warning_b")
            echo -e "\e[1m\e[33m$2\e[0m"
            ;;
        "sky")
            echo -e "\e[36m$2\e[0m"
            ;;
        "sky_b")
            echo -e "\e[1m\e[36m$2\e[0m"
            ;;
        "grey")
            echo -e "\e[0m\e[37m$2\e[0m"
            ;;
        "grey_b")
            echo -e "\e[1m\e[37m$2\e[0m"
            ;;
        "s/n")
            echo -e "\e[1m\e[35m(s/n): \e[0m"
            ;;
        *)
            echo -e "\e[32m$2\e[0m"
            ;;
    esac
}

function install_programs(){
    local faltantes=()
    local faltantes_c=0
    local instalados=()

    for programa in "$@"; do
        if ! command -v $programa &>/dev/null; then
            faltantes+=($programa) && ((faltantes_c++))
        else
            instalados+=($programa)
        fi
    done

    if [[ $faltantes_c -ne 0 ]]; then
        clear
        mensajes "warning_b" "Selección de programas para instalar:\n"
        
        for i in ${!instalados[@]}; do
            mensajes "info_b" "[X]: $(mensajes "grey_b" "${instalados[$i]}")"
        done

        for i in ${!faltantes[@]}; do
            mensajes "warning_b" "[$i]: $(mensajes "grey_b" "${faltantes[$i]}")"
        done

        mensajes "grey" "\nEscribe el numero de la aplicación que desea instalar."
        mensajes "warning" "Si desea instalar varios programas, escriba los numeros correspondietes separados '$(mensajes "grey" ",")' $(mensajes "warning" "coma y presione $(mensajes "warning_b" "ENTER")$(mensajes "warning" ".\nEn caso que no desee continuar pulse Ctrl + C para detener la ejecución.")\n")"
        read -p "$(mensajes "warning" "Instalar: ")" respuesta
        
        if [[ $respuesta != "" ]]; then
            for i in $(echo $respuesta | tr "," "\n"); do
                if [[ "${faltantes[$i],,}" == "docker" ]]; then
                    install_docker
                elif [[ "${faltantes[$i],,}" == "postgres" ]]; then
                    install_postgresql
                elif [[ $i -ge 0 ]] && [[ $i -lt ${#faltantes[@]} ]]; then
                    mensajes "info_b" "Instalando: $(mensajes "grey_b" "${faltantes[$i]}")"
                    sudo apt-get install -y ${faltantes[$i]}
                else
                    mensajes "error" "No se instalaron los programas faltantes."
                    mensajes "grey" "Por favor instala los programas faltantes para continuar.\nSe ha finalizado el proceso.\n"
                    mensajes "error" "El número $i no es válido."
                    return 1  # Retorna un estado de error si falta algún programa
                fi
            done
        fi
    
    else
        mensajes "info" "\nTodos los programas están instalados.\n"
        return 0  # Todo en orden
    fi
}

function install_docker(){
    if ! command -v docker &>/dev/null; then
        mensajes "sky_b" "Instalando Docker..."
        
        sudo apt-get update && \
        sudo apt-get install -y ca-certificates curl && \ 
        sudo install -m 0755 -d /etc/apt/keyrings && \
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
        sudo chmod a+r /etc/apt/keyrings/docker.asc && \
        
        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
        
        sudo apt-get update && \
        
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
        mensajes "sky_b" "Docker instalado correctamente."
    
    else
        mensajes "info" "Docker ya está instalado."
    fi
}

function install_postgresql(){
    sudo apt-get install -y postgresql postgresql-contrib && \
    return 0
}