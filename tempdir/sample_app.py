from flask import Flask
from flask import request
from flask import render_template

# Créer une instance de Flask
sample = Flask(__name__)

# Définir la route principale "/"
@sample.route("/")
def main():
     return render_template("index.html")

# Lancer le serveur Flask sur le port 8080
if __name__ == "__main__":
    sample.run(host="0.0.0.0", port=5050)
