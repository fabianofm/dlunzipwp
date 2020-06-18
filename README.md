# dlunzipwp
This script helps you to download, unzip the WordPress and added your database information.
Finish run the WordPress installation script by accessing the URL in a web browser.

My modifications for personal use in a development environment.

    *Choice Language
    *WordPress Version
    *DB Host
    *Directory and files permissions
    *Calculates and verifies SHA-1 hashes - link automatically generated to get the code
----
How do I run .sh file shell script in Linux?

`sudo bash dlunzipwp.sh`

-----
NOTE:

(Español / Português PT)
In the current version of WordPress 5.4.2, into wp-config.php, some values ​​such as: ('pon aquí tu phraseandom'); they are not in the correct language, but in English. Therefore, when downloading a previous version, some values ​​are likely to have the phrase in Spanish / Portuguese pt, therefore, the script may not correctly execute some necessary configuration changes. Because I took the latest version as a base. A quick edit in the script, replacing the English values ​​for the desired language, will resolve this lack of standard in the wp-config.php file. This problem does not happen for the translation of Portuguese BR and the English standard


based on the scritpt: bgallagh3r/wp.sh
