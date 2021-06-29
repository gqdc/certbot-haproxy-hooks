# certbot-haproxy-hooks
Certbot hooks to simplify certificates deployment on Haproxy

It merge privkey.pem and fullchain.pem into one file (domain.tld.pem) on a defined folder, and reload Hapropxy.

Fill the variable $SYSADMIN_EMAIL and $CRT_FOLDER and copy renew.sh into /etc/letsencrypt/renewal-hooks/
