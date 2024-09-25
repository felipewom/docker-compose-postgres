#!/bin/bash

# Verzeichnis erstellen, falls es nicht existiert
if [ ! -d "${PWD}/tmp/db_data" ]; then
  mkdir -p -m 777 ${PWD}/tmp/db_data 
fi

# Verzeichnis erstellen, falls es nicht existiert
if [ ! -d "${PWD}/tmp/pgadmin_data" ]; then
  mkdir -p  -m 777 ${PWD}/tmp/pgadmin_data
fi

# Docker Compose starten
docker compose up
