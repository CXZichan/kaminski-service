# Löschkonzept für Website-Anfragen

Gewöhnliche Kontaktanfragen aus dem Website-Formular werden nur so lange gespeichert, wie sie für Bearbeitung, Rückfragen und Nachvollziehbarkeit erforderlich sind.

Die Aufbewahrungsdauer wird über `CONTACT_RETENTION_DAYS` konfiguriert, Standard: 90 Tage. `ContactRequestRetentionJob` löscht ältere gewöhnliche Website-Anfragen regelmäßig über Solid Queue.

Der Job betrifft ausschließlich normale Website-Anfragen. Vertragsunterlagen, steuerrechtlich relevante Dokumente oder außerhalb der Website entstandene Geschäftsunterlagen dürfen nicht pauschal durch diesen Job gelöscht werden.
