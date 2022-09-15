#!/bin/bash

# 1 - parar container convida
docker stop convida-web

# 2 - remover container atual
docker container rm convida-web

# 3 - pull da master
git pull

# 4 - build
docker-compose build --no-cache

# 5 - abrir tmux & subir aplicacao
tmux new -n:convida 'docker-compose up --force-recreate'

# 6 - subir aplicacao 
#docker-compose up --force-recreate
