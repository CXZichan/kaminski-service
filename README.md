# Kaminski Service

Ruby-on-Rails-Website für Kaminski Service, einen Anbieter für Gebäude- und Reinigungsservice. Ziel ist eine schnelle, vertrauenswürdige Anfrageführung mit Formular direkt im Hero, lokalen Inhalten, Datenschutzvorbereitung und sauberem Go-live-Check.

## Stack

Ruby 3.4.5, Rails 8.1.3, PostgreSQL, Slim, Tailwind CSS, Hotwire/Turbo/Stimulus, Importmap, Propshaft, Solid Queue, Action Mailer, Active Record Encryption, RSpec, Capybara, Factory Bot, Rack::Attack, RuboCop Rails Omakase und Brakeman.

## Lokale Installation

Empfohlen ist der Docker-Compose-Workflow:

```bash
docker compose up --build
```

Die App läuft danach unter `http://localhost:3000`; PostgreSQL läuft intern im Service `db` und belegt keinen Host-Port `5432`. Einmalige Befehle kannst du so ausführen:

```bash
docker compose run --rm web bin/rails db:prepare
docker compose run --rm web bundle exec rspec
docker compose run --rm web bin/rubocop
docker compose run --rm web bin/brakeman --no-pager
```

Ohne Docker geht es weiterhin lokal, wenn PostgreSQL passend installiert ist:

```bash
cp .env.example .env
bundle install
bin/setup
bin/rails db:prepare
bin/dev
```

Für lokale Nicht-Docker-Nutzung muss dein PostgreSQL-User Datenbanken anlegen dürfen oder die Datenbanken müssen vorher existieren. Setze `DATABASE_HOST=db` nicht in einer lokalen `.env`, weil dieser Hostname nur innerhalb des Compose-Netzwerks existiert.

## Umgebungsvariablen

Siehe `.env.example`. Wichtig sind SMTP-Daten, `CONTACT_RECIPIENT_EMAIL`, `DEFAULT_FROM_EMAIL`, `CONTACT_RETENTION_DAYS` und die Active-Record-Encryption-Schlüssel. Erzeuge produktive Schlüssel mit Rails-Bordmitteln und committe keine Secrets.

## Mailer und Solid Queue

Kontaktanfragen werden als `ContactRequest` gespeichert, personenbezogene Felder verschlüsselt und anschließend per `ContactRequestDeliveryJob` an `CONTACT_RECIPIENT_EMAIL` verschickt. Solid Queue wird in Produktion als separater Prozess über `bin/jobs` betrieben.

## Kontaktformular

Das Formular validiert Pflichtfelder, normalisiert E-Mail/Telefon, filtert sensible Parameter aus Logs, nutzt CSRF-Schutz, Honeypot, Mindestdauer zwischen Anzeige und Versand und Rack::Attack-Rate-Limits.

## Cookie- und Consent-System

Notwendige Cookies sind immer aktiv. Statistik und externe Medien sind standardmäßig deaktiviert (`ENABLE_ANALYTICS=false`, `ENABLE_EXTERNAL_MEDIA=false`). Die Entscheidung wird in einem verschlüsselten First-Party-Cookie mit Version, Kategorien und Zeitpunkt gespeichert. Nicht notwendige Dienste dürfen erst nach Aktivierung und passender Datenschutzerklärung eingebunden werden.

## Datenschutz und Impressum

Unternehmensdaten werden zentral in `config/company.yml` gepflegt. Platzhalter wie `[BITTE EINTRAGEN]` müssen vor Veröffentlichung ersetzt werden. Die Datenschutzerklärung blendet optionale Abschnitte nur ein, wenn Features aktiviert sind.

## Legal-Go-live-Check

```bash
bin/rails site:legal_check
```

Standardmäßig gibt der Task Warnungen aus. Bei `LEGAL_RELEASE_READY=true` führt jeder offene Platzhalter oder Konsistenzfehler zum Abbruch. Der Check ersetzt keine anwaltliche Prüfung.

## Content und Bilder

Alle sichtbaren Inhalte sind deutsch. Leistungsbeschreibungen und Einsatzgebiet müssen durch Kaminski Service fachlich bestätigt werden. Lokale SVG-Platzhalter liegen in `app/assets/images` und müssen vor dem Go-live durch freigegebene Bilder ersetzt werden. Details stehen in `docs/content-checklist.md` und `docs/image-requirements.md`.

## Tests und Prüfungen

```bash
bundle exec rspec
bin/rubocop
bin/brakeman --no-pager
bin/rails site:legal_check
```

CI führt zusätzlich `bin/rails db:prepare` aus.

## Produktion

Vorbereitet für Puma, Nginx Reverse Proxy, systemd, PostgreSQL, Let’s Encrypt, `RAILS_SERVE_STATIC_FILES=true` und einen separaten Solid-Queue-Worker. Beispiele liegen in `docs/examples/`; ausführliche Hinweise in `docs/deployment.md`.

## Backup und Löschkonzept

Datenbank-Backups müssen regelmäßig außerhalb des Repositories erfolgen und verschlüsselte personenbezogene Felder berücksichtigen. Gewöhnliche Website-Anfragen werden über `ContactRequestRetentionJob` gemäß `CONTACT_RETENTION_DAYS` gelöscht. Siehe `docs/data-retention.md`.

## Go-live-Checkliste

- Alle Platzhalter in `config/company.yml` ersetzen.
- Impressum und Datenschutzerklärung rechtlich prüfen lassen.
- SMTP und Empfängeradresse produktiv setzen.
- Active-Record-Encryption-Schlüssel produktiv setzen.
- Echte Bilder und Alt-Texte einpflegen.
- Leistungsumfang und Einsatzgebiet bestätigen.
- `LEGAL_RELEASE_READY=true bin/rails site:legal_check` erfolgreich ausführen.
