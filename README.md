# Vault & Docker Case study

## Objectif
Déploiement en mode docker-compose
- déployer un serveur HC Vault
- utiliser un volume docker pour faire persister les données et configuration du serveur
- exposer le serveur Vault en mode TLS avec certificat auto signé

## Comment run le serveur
1. Si votre OS n'est pas Linux, installer Docker Desktop.
2. Cloner ce repo en local.
3. Cd dans le dossier du projet.
4. Générer un certificat auto-signé et une clé privée avec `./create_certificate.sh` ou `/bin/bash create_certificate.sh`.
5. `docker compose up -d`
6. Le container "client" initialise Vault puis range les 5 clés et le root token dans `/vault/file/keys`.
7. Tester l'UI Vault en se connectant à Vault via le navigateur à l'adresse `https://localhost:8200`. Par exemple, créer un nouveau secret engine pour kv et créer un secret.
8. Shutdown le serveur avec `docker compose down`, puis le relancer avec `docker compose up -d`. Vérifier que le secret est toujours présent, indiquant que les données sont bien persistantes grâce au volume `vault-data`.

## Bugs éventuels
Si le navigateur refuse d'ouvrir l'UI de Vault à cause d'une erreur HSTS, réinitialiser les paramètres HSTS de localhost sur le navigateur (voir https://www.thesslstore.com/blog/clear-hsts-settings-chrome-firefox/).

## Sources
- Fortement inspiré d'un autre projet (https://github.com/ahmetkaftan/docker-vault) pour la configuration du serveur Vault et le docker-compose, auquel j'ai ajouté les fonctionnalités TLS.
- Pour pouvoir ouvrir l'UI de Vault sur le navigateur, il faudra probablement enregistrer le certificat généré (dans /cert/localhost.crt) sur la machine hôte. Sur MacOS, ouvrir l'app **Trousseaux d'accès**, aller dans la section **session**, double-cliquer sur le certificat auto-signé. Dans **Se fier**, changer en **Toujours approuver** puis enregistrer.