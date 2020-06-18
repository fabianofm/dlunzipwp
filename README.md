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

Note:
(Spanish and Portuguese Portugal) - In the current version of WordPress 5.4.2, inside wp-config.php, different from some previous versions, the default values such as ('pon aquí tu phraseandom'), no is in current language, but in English. Therefore, when downloading a previous version, which has the sentence in Spanish, the script will not carry out the necessary configuration changes. Because I'm relying on the latest version.


based on the scritpt: bgallagh3r/wp.sh
