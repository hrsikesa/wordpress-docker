#!/bin/bash

function usage() {
  echo "~~~~~~~~~~~"
  echo " U S A G E"
  echo "~~~~~~~~~~~"
  echo "Usage: ./wordpress_docker.sh [option]"
  echo "  options:"
  echo "    create_environment : Create environment"
  echo "    start_site : Create Site"
  echo "    stop_site : Stop Site"
  echo "    start_stopped_site : Start stopped Site"
  echo "    destroy_site : Destroy Site"
  echo ""
  exit
}

function create_environment(){
    echo "Create Environment for Site"
    for a in `cat package_file.txt`
    do      
            which $a > /dev/null 2>&1
            if [ $? -eq "0" ]
            then
                    echo "$a is already installed. "
            else
                    echo "$a is not installed"
                    cat /etc/hosts
                    # docker
                    echo "Install docker"
                    sudo apt remove --yes docker docker-engine docker.io containerd runc
                    sudo apt update
                    sudo apt --yes --no-install-recommends install apt-transport-https ca-certificates
                    wget --quiet --output-document=- https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                    sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable"
                    sudo apt update
                    sudo apt --yes --no-install-recommends install docker-ce docker-ce-cli containerd.io
                    sudo usermod --append --groups docker "$USER"
                    sudo systemctl enable docker
                    printf '\nDocker installed successfully\n\n'

                    printf 'Waiting for Docker to start...\n\n'
                    sleep 5

                    # Docker Compose
                    echo "Install docker-compose"
                    sudo wget --output-document=/usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/$(wget --quiet --output-document=- https://api.github.com/repos/docker/compose/releases/latest | grep --perl-regexp --only-matching '"tag_name": "\K.*?(?=")')/run.sh"
                    sudo chmod +x /usr/local/bin/docker-compose
                    sudo wget --output-document=/etc/bash_completion.d/docker-compose "https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose"
                    printf '\nDocker Compose installed successfully\n\n'

            fi
    done
    echo "Adding entry for site in hosts file"
    echo "127.0.0.1 example.com" >> /etc/hosts
    
}


function start_site(){
    echo "Starting Containers"
    docker-compose up -d
    echo "~~~~~~~~~~~"
    echo "open example.com in a browser"
    echo "~~~~~~~~~~~"
}

function stop_site(){
    echo "Stopping Containers"
    docker-compose stop

}

function start_stopped_site(){
    echo "Start stopped containers"
    docker-compose start
}

function destroy_site(){
    echo "Deleting containers"
    docker-compose down -v
}

"$@"