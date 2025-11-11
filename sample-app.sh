#!/bin/bash

# Étape 1 : Créer la structure temporaire
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Étape 2 : Copier les fichiers de l'application vers le dossier temporaire
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Étape 3 : Créer le Dockerfile dans tempdir
echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 8080" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile

# Étape 4 : Construire l'image Docker
cd tempdir
docker build -t sampleapp .

# Étape 5 : Lancer le conteneur et vérifier son état
docker run -t -d -p 8080:8080 --name samplerunning sampleapp
docker ps -a
