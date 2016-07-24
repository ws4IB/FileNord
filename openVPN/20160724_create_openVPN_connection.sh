# Skript aus der Zertifikatgruppe zum generieren des CSR Zertifikats geholt

wget http://ca-nord.fachpraktikum-1599.de/files/generate.sh

# beim ausführen des Skripts wird ein Passwort mit min. 8 Stellen gefordert. Hier wird '00000000' als Passwort eigesetzt

sudo ./generate.sh FileNord "Mayer Brot" CSR/

# der per Skript erstellte Zertifikat musste auf den lokalen Rechner geladen werden, damit ein Upload unter der Zertifikat-Webseite möglich ist.

sudo tar cvzf CSR.tar.gz CSR/

# Wie Tobias beschrieben hat, ist unter der Webseite der Zertifikat-Gruppe das Zertifikat im User Modus angeforert worden. Dazu musste außerdem u.a. eine E-Mail angegeben und die CSR Datei (ohne private key) hochgeladen werden.

# Es kamm anschließend eine E-Mail, die als Anhang die eine ca-chain sowie persönliches Zertifikat enthielt.

# die CA chain Datei wurde in den Ordner mit dem anderen Zertifikat abgelegt.

# Wie Tobias beschrieben hat, soll der private Key ohne Passphrase erzeugt sein. Da eine Passworteingabe erforderlich war, wurde das Passwort im Nachhinein mit dem folgendem Kommando wieder entfernt:

openssl rsa -in gen.key.pem -out gen.key_nocrypt.pem 
Enter pass phrase for gen.key.pem:
writing RSA key

# Im Anschluss werden alle Dateien gezippt wieder auf den Server uebertragen:

scp CSR.tar.gz 5.45.103.136:~/connection_with_openVPN/certificates/

# Da openVPN auf dem Server noch nicht installiert ist, wird dieser Schritt nachgeholt.

dpkg -l | grep openvpn
sudo apt-get install openvpn

# Die openVPN Konfigurationsdatei ist nach Anleitung angelegt worden und konnten erfolgreich mit openVPN geladen bzw. gestartet werden.

Stand 24.07.2016 ca. 17 Uhr:
# Irrtum: Nach genauerer Beobachtung von Patrick haben sich einige Fehler bei der Konfiguration eingeschlichen, die nach Patricks Anleitung wie folgt behoben werden konnten:

Beim manuellen Test mittels

   sudo openvpn --config client.conf

kam es zu einem Fehler:
 
   Options error: You must define TUN/TAP device (--dev)

Hier musste noch der Eintrag

   dev tun

in der OpenVPN-Konfiguration ergänzt werden.

Danach gab es einen weiteren Fehler:

...
Sun Jul 24 16:44:24 2016 Cannot load private key file /etc/openvpn/mayerbrot/client.key: error:0B080074:x509 certificate routines:X509_check_private_key:key values mismatch
...

In der E-Mail für die Zertifikatsanfrage sollte eine ca-chain sowie das persönliche Zertifikat (in dem Fall das Zertifikat des Servers) enthalten sein.
Der /etc/openvpn/mayerbrot/client.crt muss das Zertifikat mit aehnlicher Bezeichnung wie WaldemarSchmidt_14693xxxxx.cert.pem sein. Das ca-chain kann erst mal in diesem Fall ignoriert werden.

Zur Ueberpruefung, ob das Zertifikat zu dem Key Passt, koennen folgende Befehle helfen:

openssl x509 -noout -modulus -in /etc/openvpn/mayerbrot/client.key | openssl md5
openssl x509 -noout -modulus -in /etc/openvpn/mayerbrot/client.crt | openssl md5

hier sollten die Hashwerte gleich sein.

Wenn alles gut läuft, müsste der Befehl

  sudo openvpn --config client.conf

dann signalisieren, dass der VPN-Zugang funktioniert. Laut Anleitung von Tobias sollten die Routen automatisch mit erfolgreichem Verbindungsaufbau erstellt werden; dies lässt sich z.B. mit

  ip route

prüfen.

