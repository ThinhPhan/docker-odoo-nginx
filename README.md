# Odoo ERP, PostgreSQL and Nginx with Docker Compose 🔥

+ Odoo: Latest (17.0)
+ PostgreSQL: 15
+ Nginx as a Reverse Proxy
+ Certbot Letsencrypt SSL

## Odoo ERP 🖥️

![project-image](https://user-images.githubusercontent.com/59855397/216739166-c91ef374-50d4-4b9e-bfb4-987954f5f0f2.png)

### Clone this repository

    git clone --recurse-submodules --remote-submodules https://github.com/DanielNery/odoo-docker-compose-nginx-postgresql.git --branch=master

### Steps To Live

    # On odoo-docker-compose-nginx-postgresql directory

    sudo mkdir ./odoo-web-data && sudo mkdir ./addons && sudo chmod -R 777 ./addons &&  sudo chmod -R 777 ./odoo-web-data && sudo docker-compose up -d

    # Check container id from odoo
    `sudo docker ps`

    # Copy default addons (Optional)
    `sudo docker cp <odoo_container_id>:/usr/lib/python3/dist-packages/odoo/addons ./addons`

### Commands

    # Check services running on ports of interest
    sudo lsof -i -P -n | grep 80

    # Kill process running on port of interest
    sudo service apache2 stop

    # Containers Up
    sudo docker-compose up -d
    # Obs: 'd' is from detached

    # Allow permissions to read filestore
    sudo chmod 777 ./odoo-web-data

    # Down containers (Alert: This deletes all config your containers)
    sudo docker-compose down

    # See Logs
    sudo docker-compose logs --tail=100 -f

    # Start, Stop and check containers
    sudo docker-compose start
    sudo docker-compose stop
    sudo docker-compose ps

    # Init database with base modules
    sudo docker-compose stop odoo && \
    sudo docker-compose run --rm odoo odoo -c /etc/odoo/odoo.conf -i base --stop-after-init && \
    sudo docker-compose restart

    # Up Odoo updating modules
    sudo docker-compose stop odoo && \
    sudo docker-compose run --rm odoo odoo -c /etc/odoo/odoo.conf -u modules_name --stop-after-init && \
    sudo docker-compose restart

    # Generate database backup
    export DATABASE=your_database && sudo docker-compose run --rm -e PGPASSWORD=odoo -e DATABASE=$DATABASE db pg_dump -h db -U odoo $DATABASE > /tmp/db-${DATABASE}-$(date +%Y%m%d%H%M).dump

    # Restore your database
    cat your_file_name.dump | docker exec -i postgresql psql -U odoo -d your_database_name


    # Security copy 'dumps files' from server to your local machine
    scp server_user@link_server:/tmp/db-your_db_name.dump ~/Downloads/db-your_db_name.dump &&
    scp -r server_user@link_server:/home/ubuntu/projects/your-erp/odoo-web-data/filestore/your_filestore_name ~/Downloads/your_filestore_name

    # List databases on postgres container
    docker exec postgresql psql -U odoo -l

    # Delete databases on postgres container
    docker exec postgresql psql -U odoo drop database your_database_name

### Nginx SSL config example

    See `config/nginx/default.conf`

## Documentation 📜

+ <https://docs.docker.com/>
+ <https://docs.docker.com/compose/>
+ <https://www.odoo.com/documentation/14.0/>
+ <https://nginx.org/en/docs/>
+ <https://www.postgresql.org/docs/>

### Linux Basic Commands 🐧

` sudo apt update && sudo apt upgrade -y `

` sudo apt install docker docker-compose -y `

` git clone https://github.com/DanielNery/odoo-docker-compose-nginx-postgresql.git `

` cd odoo-docker-compose-nginx-postgresql `
` sudo docker-compose up -d `

### Windowns or Mac Tutorial 🍎

+ Install Docker Desktop <https://www.docker.com/products/docker-desktop/>

  ` git clone https://github.com/DanielNery/odoo-docker-compose-nginx-postgresql.git `

  ` cd odoo-docker-compose-nginx-postgresql `

  ` docker-compose up -d `

### Update or custom modules 🍺

  ` docker-compose stop odoo && sudo docker-compose run --rm odoo odoo -c /etc/odoo/odoo.conf -u your_module
  --stop-after-init && docker-compose start odoo `
