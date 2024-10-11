#!/bin/bash

# Arrêter tous les conteneurs
echo "Arrêt de tous les conteneurs..."
if [ "$(docker ps -q)" ]; then
    sudo docker stop $(docker ps -q)
else
    echo "Aucun conteneur en cours d'exécution."
fi

# Supprimer tous les conteneurs
echo "Suppression de tous les conteneurs..."
if [ "$(docker ps -aq)" ]; then
    sudo docker rm $(docker ps -aq)
else
    echo "Aucun conteneur à supprimer."
fi

# Supprimer toutes les images
echo "Suppression de toutes les images..."
if [ "$(docker images -q)" ]; then
    sudo docker rmi $(docker images -q)
else
    echo "Aucune image à supprimer."
fi

echo "Tous les conteneurs et toutes les images ont été supprimés."

