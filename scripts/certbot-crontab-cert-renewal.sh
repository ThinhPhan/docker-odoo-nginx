#!/bin/sh

sudo crontab -e

# Add the following line at the bottom of the crontab and replace compose.yml
# Cronjob run at 8am every Sunday -> config to match expire duration
DOCKER_COMPOSE_PATH = /path/to/your/compose.yml
0 8 * * 0 docker compose -f $DOCKER_COMPOSE_PATH run --rm certbot renew && docker compose -f $DOCKER_COMPOSE_PATH exec nginx nginx -s reload
