#!/usr/bin/env sh

set -ex
# e flag : exit immediately if a command generates an error
# x flag : display in terminal the executed commands ("+" at beginning of line)

unseal () {
vault operator unseal $(grep 'Key 1:' /vault/file/keys | awk '{print $NF}') #
vault operator unseal $(grep 'Key 2:' /vault/file/keys | awk '{print $NF}')
vault operator unseal $(grep 'Key 3:' /vault/file/keys | awk '{print $NF}')
}
# awk docs : https://www.shellunix.com/awk.html
# awk '{print $NF}' prints the last field of a line

init () {
vault operator init > /vault/file/keys
}

log_in () {
   export ROOT_TOKEN=$(grep 'Initial Root Token:' /vault/file/keys | awk '{print $NF}')
   vault login $ROOT_TOKEN
}

create_token () {
   vault token create -id $MY_VAULT_TOKEN
}

if [ -s /vault/file/keys ]; then
   unseal
   # [ command ] = test command
   # -s flag : check if file size > 0 
else
   init
   unseal
   log_in
   create_token
fi

vault status > /vault/file/status