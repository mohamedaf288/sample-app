#!/bin/bash

# Nettoyer les anciens conteneurs et répertoires
docker stop samplerunning 2>/dev/null
docker rm samplerunning 2>/dev/null
rm -rf tempdir

# Créer les répertoires
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Copier les fichiers
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Créer le Dockerfile (utiliser > pour la première ligne pour écraser)
echo "FROM python" > tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile

# Construire et exécuter
cd tempdir
docker build -t sampleapp .
docker run -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a
