# Deployment auf VPS

Vorgesehen ist ein klassischer Betrieb mit Puma, PostgreSQL, Nginx Reverse Proxy, systemd, Let’s Encrypt und Solid Queue als separatem Worker.

Umgebungsvariablen liegen außerhalb des Repositories. `RAILS_SERVE_STATIC_FILES=true` ist für statische Assets vorgesehen. SMTP-Zugangsdaten und Active-Record-Encryption-Keys dürfen nicht commitet werden.

Für Entwicklung steht `compose.yaml` bereit. Produktion sollte nicht direkt mit der Development-Compose-Datei betrieben werden.

Vor dem Go-live:

1. Ruby 3.4.5 installieren.
2. PostgreSQL-Datenbank und Benutzer anlegen.
3. `bundle install --deployment` ausführen.
4. `bin/rails db:prepare` ausführen.
5. `bin/rails assets:precompile` ausführen.
6. Puma-App und Solid-Queue-Worker via systemd starten.
7. Nginx mit TLS terminieren lassen.
