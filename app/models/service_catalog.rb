class ServiceCatalog
  Service = Data.define(:slug, :title, :short_title, :description, :tasks, :image, :summary)

  SERVICES = [
    Service.new(
      slug: "gebaeudereinigung",
      title: "Gebäudereinigung",
      short_title: "Gebäudereinigung",
      description: "Für gepflegte Immobilien, saubere Eingangsbereiche und Flächen, die bei Besuchern, Mietern und Mitarbeitern einen ordentlichen Eindruck hinterlassen.",
      summary: "Gebäudereinigung in Celle, Wietze und Umgebung mit abgestimmtem Leistungsumfang, klaren Intervallen und persönlicher Rücksprache.",
      image: "placeholder-gebaeudereinigung.svg",
      tasks: [ "Objektbegehung und Abstimmung", "Gemeinschafts- und Nutzflächen", "Regelmäßige Qualitätskontrolle" ]
    ),
    Service.new(
      slug: "unterhaltsreinigung",
      title: "Unterhaltsreinigung",
      short_title: "Unterhaltsreinigung",
      description: "Regelmäßige Reinigung für Räume, die dauerhaft sauber, hygienisch und nutzbar bleiben sollen – passend zu Ihrem Alltag oder Betriebsablauf.",
      summary: "Wiederkehrende Reinigungstermine für Büros, Praxen, Treppenhäuser und private Objekte mit planbaren Abläufen.",
      image: "placeholder-unterhaltsreinigung.svg",
      tasks: [ "Feste Reinigungsintervalle", "Sanitär- und Oberflächenpflege", "Anpassung an Öffnungs- und Nutzungszeiten" ]
    ),
    Service.new(
      slug: "bueroreinigung",
      title: "Büroreinigung",
      short_title: "Büroreinigung",
      description: "Saubere Arbeitsplätze, gepflegte Besprechungsräume und ordentliche Sanitärbereiche für ein professionelles Arbeitsumfeld.",
      summary: "Büroreinigung für Unternehmen in Celle, Wietze und Umgebung – diskret, planbar und auf Ihre Räumlichkeiten abgestimmt.",
      image: "placeholder-bueroreinigung.svg",
      tasks: [ "Arbeitsplätze und Oberflächen", "Küchen- und Sanitärbereiche", "Abfallentsorgung nach Vereinbarung" ]
    ),
    Service.new(
      slug: "glas-und-fensterreinigung",
      title: "Glas- und Fensterreinigung",
      short_title: "Glasreinigung",
      description: "Streifenfreie Fenster und gepflegte Glasflächen für Wohnhäuser, Büros, Praxen und Ladenflächen.",
      summary: "Glas- und Fensterreinigung nach Objekt, Zugänglichkeit und gewünschtem Rhythmus – einmalig oder regelmäßig.",
      image: "placeholder-glasreinigung.svg",
      tasks: [ "Fenster und Glasflächen", "Rahmen und Falze nach Absprache", "Einmalige oder regelmäßige Termine" ]
    ),
    Service.new(
      slug: "treppenhausreinigung",
      title: "Treppenhausreinigung",
      short_title: "Treppenhäuser",
      description: "Treppenhäuser, Eingänge und Flure bleiben der erste Eindruck eines Gebäudes – wir sorgen für einen gepflegten Standard.",
      summary: "Treppenhausreinigung für Mehrfamilienhäuser, Hausverwaltungen und Gewerbeobjekte mit verlässlichen Intervallen.",
      image: "placeholder-treppenhaus.svg",
      tasks: [ "Stufen, Handläufe und Geländer", "Eingangsbereiche und Flure", "Keller- und Nebenflächen nach Absprache" ]
    ),
    Service.new(
      slug: "grund-und-sonderreinigung",
      title: "Grund- und Sonderreinigung",
      short_title: "Sonderreinigung",
      description: "Wenn normale Unterhaltsreinigung nicht reicht: intensive Reinigung vor Übergaben, nach Umzügen oder bei stark beanspruchten Flächen.",
      summary: "Grund- und Sonderreinigung für besondere Situationen – Umfang, Aufwand und Materialeinsatz werden vorab abgestimmt.",
      image: "placeholder-sonderreinigung.svg",
      tasks: [ "Intensive Flächenreinigung", "Umzugs- und Anlassreinigung", "Individuell vereinbarte Sonderaufgaben" ]
    ),
    Service.new(
      slug: "bau-und-bauendreinigung",
      title: "Bau- und Bauendreinigung",
      short_title: "Baureinigung",
      description: "Reinigung nach Bau- und Renovierungsarbeiten, damit Räume sauber übergeben oder wieder genutzt werden können.",
      summary: "Baureinigung und Bauendreinigung in der Region Celle/Wietze nach konkreter Abstimmung von Umfang, Zugang und Zeitplan.",
      image: "placeholder-baureinigung.svg",
      tasks: [ "Baugrobe Verschmutzungen nach Absprache", "Staub- und Feinreinigung", "Vorbereitung zur Übergabe" ]
    )
  ].freeze

  def self.all
    SERVICES
  end

  def self.find!(slug)
    SERVICES.find { |service| service.slug == slug } || raise(ActiveRecord::RecordNotFound)
  end

  def self.options
    SERVICES.map { |service| [ service.title, service.slug ] }
  end
end
