# Skript aus der Zertifikatgruppe zum generieren des CSR Zertifikats geholt

# beim ausführen des Skripts wird ein Passwort mit min. 8 Stellen gefordert. Hier wird '00000000' als Passwort eigesetzt

# der per Skript erstellte Zertifikat musste auf den lokalen Rechner geladen werden, damit ein Upload unter der Zertifikat-Webseite möglich ist.

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

# Die openVPN Konfigurationsdatei ist nach Anleitung angelegt worden und konnten erfolgreich mit openVPN geladen bzw. gestartet werden.

