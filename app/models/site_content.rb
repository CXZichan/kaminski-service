class SiteContent
  BENEFITS = [
    {
      title: "Persönliche Abstimmung",
      text: "Sie schildern uns Ihr Objekt, die genutzten Bereiche und Ihre Erwartungen. Daraus entsteht ein Leistungsumfang, der wirklich zu Ihrem Bedarf passt."
    },
    {
      title: "Klare Aufgabenliste",
      text: "Vor dem Start ist festgelegt, welche Flächen, Räume und Zusatzarbeiten enthalten sind. So bleibt das Angebot nachvollziehbar."
    },
    {
      title: "Planbare Termine",
      text: "Ob einmalige Reinigung oder regelmäßiger Turnus: Wir stimmen Termine so ab, dass sie zu Nutzung, Öffnungszeiten und Alltag passen."
    },
    {
      title: "Saubere Ausführung",
      text: "Wir arbeiten strukturiert, achten auf Details und melden zurück, wenn vor Ort etwas angepasst oder zusätzlich geklärt werden sollte."
    },
    {
      title: "Privat und gewerblich",
      text: "Anfragen sind für Wohnungen, Häuser, Büros, Praxen, Treppenhäuser, Ladenflächen und weitere Objekte in Celle und Wietze möglich."
    },
    {
      title: "Direkte Kommunikation",
      text: "Kurze Wege, klare Rückfragen und eine verbindliche Abstimmung helfen, Missverständnisse vor und während der Reinigung zu vermeiden."
    }
  ].freeze

  PROCESS_STEPS = [
    {
      title: "Anfrage senden",
      text: "Sie nennen Objektart, Ort, gewünschte Leistung und einen passenden Rückmeldeweg."
    },
    {
      title: "Bedarf klären",
      text: "Wir besprechen Fläche, Rhythmus, besondere Anforderungen und falls nötig eine Besichtigung."
    },
    {
      title: "Angebot erhalten",
      text: "Sie bekommen ein nachvollziehbares Angebot mit klar beschriebenem Leistungsumfang."
    },
    {
      title: "Termin vereinbaren",
      text: "Nach Ihrer Freigabe stimmen wir Start, Ablauf und regelmäßige Termine verbindlich ab."
    }
  ].freeze

  REFERENCES = [
    {
      type: "Beispielreferenz",
      title: "Büroflächen in Celle",
      description: "Regelmäßige Reinigung von Arbeitsbereichen, Besprechungsraum, Küche und Sanitärbereich nach abgestimmtem Turnus.",
      details: [ "Unterhaltsreinigung", "Abendtermine", "Gewerbekunde" ]
    },
    {
      type: "Beispielreferenz",
      title: "Treppenhaus in Wietze",
      description: "Pflege von Eingangsbereich, Treppenstufen, Handläufen und Fluren für ein Mehrparteienhaus.",
      details: [ "Treppenhausreinigung", "Fester Rhythmus", "Hausverwaltung" ]
    },
    {
      type: "Beispielreferenz",
      title: "Fensterreinigung im Privathaushalt",
      description: "Einmalige Glas- und Rahmenreinigung für ein Einfamilienhaus inklusive persönlicher Terminabstimmung.",
      details: [ "Glasreinigung", "Privatkunde", "Einzeltermin" ]
    }
  ].freeze

  FAQS = [
    [ "Welche Reinigungsleistungen bieten wir an?", "Wir nehmen Anfragen für Gebäude-, Unterhalts-, Büro-, Glas- und Fenster-, Treppenhaus-, Grund-, Sonder- sowie Bauendreinigung entgegen. Vor einem Angebot klären wir gemeinsam, was Ihr Objekt konkret braucht." ],
    [ "Können Privat- und Gewerbekunden eine Anfrage stellen?", "Ja. Sie können als Privatperson, Unternehmen, Praxis, Hausverwaltung oder Gewerbetreibender eine unverbindliche Anfrage stellen." ],
    [ "Bringen Sie Reinigungsmittel und Geräte mit?", "Das stimmen wir passend zur Fläche und zur gewünschten Reinigung ab. Teilen Sie uns gern mit, was vorhanden ist und was gestellt werden soll." ],
    [ "Wie wird der Preis berechnet?", "Der Preis richtet sich nach Objekt, Fläche, Verschmutzungsgrad, gewünschtem Intervall und Leistungsumfang. Sie erhalten vorab ein nachvollziehbares Angebot." ],
    [ "Sind regelmäßige Reinigungstermine möglich?", "Ja, regelmäßige Reinigungstermine können individuell geplant werden – zum Beispiel wöchentlich, zweiwöchentlich oder nach einem Objektplan." ],
    [ "In welchem Gebiet sind wir tätig?", "Wir sind rund um Celle, Wietze und Umgebung tätig. Ob Ihr Objekt im Einsatzgebiet liegt, klären wir direkt mit Ihrer Anfrage." ],
    [ "Wie schnell erhalte ich eine Rückmeldung?", "Wir melden uns nach Eingang Ihrer Anfrage so zeitnah wie möglich, um offene Fragen, Besichtigung und Angebotsumfang zu klären." ],
    [ "Ist die Anfrage kostenlos und unverbindlich?", "Ja. Das Absenden des Formulars löst keinen kostenpflichtigen Vertrag aus." ]
  ].freeze

  def self.faqs
    FAQS
  end

  def self.benefits
    BENEFITS
  end

  def self.process_steps
    PROCESS_STEPS
  end

  def self.references
    REFERENCES
  end
end
