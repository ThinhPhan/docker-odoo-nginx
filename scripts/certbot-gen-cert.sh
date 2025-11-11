#!/bin/sh
docker compose run --rm certbot certonly --webroot --webroot-path=/var/www/certbot -d example.com --email user@gmail.com --agree-tos --no-eff-email
