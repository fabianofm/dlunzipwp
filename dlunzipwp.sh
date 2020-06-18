#!/bin/bash

clear
echo "======================https://github.com/fabianofm/dlunzipwp==============================="
echo "This script helps you to download, unzip the WordPress and added your database information."
echo "Finish run the WordPress installation script by accessing the URL in a web browser."
echo "==========================================================================================="
echo "WordPress Version (e.g.: 5.4.2): "
read WORDPRESS_VERSION
echo "Database Name: "
read dbname
echo "Database User: "
read dbuser
echo "Database Password: "
read dbpass
echo "Database Hostname: "
read dbhostname

echo "select the language"
echo "  1) English"
echo "  2) Português pt_BR"
echo "  3) Português pt_PT"
echo "  4) Español es_ES"
read nlang

case $nlang in
1)
    URL=https://wordpress.org/wordpress-$WORDPRESS_VERSION.tar.gz
    setlanguage="en"
    ;;
2)
    URL=https://br.wordpress.org/wordpress-$WORDPRESS_VERSION-pt_BR.tar.gz
    setlanguage="pt_BR"
    ;;
3)
    URL=https://pt.wordpress.org/wordpress-$WORDPRESS_VERSION-pt_PT.tar.gz
    setlanguage="pt_PT"
    ;;
4)
    URL=https://es.wordpress.org/wordpress-$WORDPRESS_VERSION-es_ES.tar.gz
    setlanguage="es_ES"
    ;;
*) echo "invalid option" ;;
esac

echo "For $setlanguage WP $WORDPRESS_VERSION ($URL.sha1)"
echo "Calculates and verifies SHA-1 hashes? (y/n)"
read answerverifies

if [ "$answerverifies" != "${answerverifies#[Yy]}" ]; then
    echo "Enter the code sha1: "
    read WORDPRESS_SHA1
fi

echo "run install? (y/n)"
read run
if [ "$run" = n ]; then # POSIX sh
    exit

else

    echo "============================================"
    echo " Installing WordPress"
    echo "============================================"

    #download wordpress
    curl -o wordpress.tar.gz -fSL "$URL"

    [ ! -z "$WORDPRESS_SHA1" ] && echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -

    #extract the contents - wordpress
    tar -xzf wordpress.tar.gz

    #change dir to wordpress
    cd wordpress
    #copy file to parent dir
    cp -rf . ..
    #move back to parent dir
    cd ..
    #remove files from wordpress folder
    rm -R wordpress
    #create wp config
    cp wp-config-sample.php wp-config.php

    if [ "$setlanguage" = "pt_BR" ]; then
        txtDatabaseName="nome_do_banco_de_dados_aqui"
        txtUsername="nome_de_usuario_aqui"
        txtPassword="senha_aqui"
        txtLocalhost="localhost"

        txtSalt="coloque a sua frase única aqui"
    else
        txtDatabaseName="database_name_here"
        txtUsername="username_here"
        txtPassword="password_here"
        txtLocalhost="localhost"

        txtSalt="put your unique phrase here"
    fi

    #set database details with perl find and replace
    perl -pi -e "s/$txtDatabaseName/$dbname/g" wp-config.php
    perl -pi -e "s/$txtUsername/$dbuser/g" wp-config.php
    perl -pi -e "s/$txtPassword/$dbpass/g" wp-config.php
    perl -pi -e "s/$txtLocalhost/$dbhostname/g" wp-config.php

    #set WP salts
    perl -i -pe'
    BEGIN {
        @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
        push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
        sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
    }
    s/'"$txtSalt"'/salt()/ge
    ' wp-config.php

    mkdir wp-content/uploads

    find . -type d | xargs chmod -v 755 # Change directory permissions rwxr-xr-x
    find . -type f | xargs chmod -v 644 # Change file permissions rw-r--r--

    #$SUDO_USER - To get the current "logged in" user (no root)
    chown -R $SUDO_USER:www-data *
    chmod -R 775 wp-content

    echo "Cleaning..."
    #remove tar
    rm wordpress.tar.gz
    #remove bash script
    rm dlunzipwp.sh
    echo "========================="
    echo "Installation is complete."
    echo "========================="
fi
