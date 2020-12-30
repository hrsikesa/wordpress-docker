# Welcome to wordpress-docker
An handy script that helps you to create and run a docker local environment for WordPress developing.

## Requirements

This script works on Debian based OS.

## What Docker Containers are included?

This script will make the process of creating a local WordPress environment based on docker fast and less prone to errors. 

[WordPress on Apache](https://hub.docker.com/_/wordpress/), a webserver based on alpine linux capable of switching between different PHP and WordPress versions.

[MySQL Docker Container](https://hub.docker.com/_/mysql), a MySQL database.


## How-to

### Basics

Just clone this repo, it contains a simple bash script & other necessary files.

```bash
  chmod +x wordpress_docker.sh
```

To create environment just type `./wordpress_docker.sh create_environment`.
It will first check whether docker & docker-compose is installed on server, if not it will install them. Also map example.com to localhost & put this entry in hosts file


If you want to start site just type `./wordpress_docker.sh start_site`.
It will start containers(mysql & wordpress)
After this step you can simply point your browser & open example.com. They are mapped like this:

- WordPress is on `localhost:80` or `0.0.0.0:80`

If you want start to stop site just type `./wordpress_docker.sh stop_site`.
It will stop containers

If you want to start again stopped site just type `./wordpress_docker.sh start_stopped_site`.
It will again start stopped containers

If you want to destroy the site just type `./wordpress_docker.sh destroy_site`.
It will remove the containers

If you want to check usage of script just type `./wordpress_docker.sh usage`.
