#! /bin/bash

# 1st method using a .cnf conf file
# create a certificate and private key with an additional IP SAN (Subject Alternative Name)
# https://medium.com/@antelle/how-to-generate-a-self-signed-ssl-certificate-for-an-ip-address-f0dd8dddf754
# openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout cert/key.pem -out cert/cert.pem -config san.cnf
# openssl x509 -in cert/cert.pem -text -noout

# 2nd method running CLI command directly
# https://letsencrypt.org/docs/certificates-for-localhost/#making-and-trusting-your-own-certificates
openssl req -x509 -out localhost.crt -keyout localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=vault' -extensions EXT -config <( \
   printf "[dn]\nCN=vault\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:vault\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

# 3d method
# https://gist.github.com/cecilemuller/9492b848eb8fe46d462abeb26656c4f8