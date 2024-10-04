!/bin/bash

# Arrêter tous les conteneurs
echo "Arrêt de tous les conteneurs..."
docker stop $(docker ps -q)

# Supprimer tous les conteneurs
echo "Suppression de tous les conteneurs..."
docker rm $(docker ps -aq)

# Supprimer toutes les images
echo "Suppression de toutes les images..."
docker rmi $(docker images -q)

echo "Tous les conteneurs et toutes les images ont été supprimés."
