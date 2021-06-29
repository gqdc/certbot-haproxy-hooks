#!/bin/sh
# Sysadmin e-mail
SYSADMIN_EMAIL="user@domain.tld"
# The folder where to store the final .pem ( which containt the sum of privkey.pem and fullchain.pem)
CRT_FOLDER="/etc/ssl/private"
# Define IFS to a "space" character, to parse $RENEWED_DOMAINS which has the format "domain1.tld domain2.tld"
IFS=' '

for domain in $RENEWED_DOMAINS; do
    # move to the correct let's encrypt domain's directory
    cd $RENEWED_LINEAGE
    # cat fullchain.pem and privkey.pem files to make a combined $domain.pem file for haproxy
    cat fullchain.pem privkey.pem > $CRT_FOLDER/$domain.pem
done

# reload haproxy to load the new certificate(s)
systemctl reload haproxy

# Send an e-mail to $SYSADMIN_EMAIL to tell him/her if Haproxy reloaded successfully
if test $? -eq 0
then
    echo "Haproxy successfully reloaded" |mail -s "[CERTBOT] ${domain} : certificate renewed" ${SYSADMIN_EMAIL}
else
    echo "Haproxy not reloaded" |mail -s "[CERTBOT] ${domain} : certificate not renewed" ${SYSADMIN_EMAIL}
fi
