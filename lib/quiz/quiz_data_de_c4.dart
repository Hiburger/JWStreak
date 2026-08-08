import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesDeC4 = <String, List<QuizQuestion>>{
  'Lamentations#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie beschreibt Klagelieder 1 Jerusalem nach seinem Fall?',
      options: <String>[
        'Als eine einst volle Stadt, die nun einsam dasitzt',
        'Als eine blühende, wohlhabende Stadt',
        'Als eine unberührte Hauptstadt',
        'Als einen Ort endlosen Feierns',
      ],
      correctIndex: 0,
      explanation:
          '„Wie einsam sitzt sie da!“ eröffnet das Buch (Klagelieder 1:1).',
    ),
    QuizQuestion(
      text: 'Was beschreibt Klagelieder 2 bezüglich Jehovas Zorn?',
      options: <String>[
        'Er ergoss sich über Zion wegen ihrer Untreue',
        'Er verschonte die Stadt vollständig',
        'Er traf nur die Nachbarnationen',
        'Er hatte keine sichtbare Wirkung',
      ],
      correctIndex: 0,
      explanation:
          'Die Zerstörung wird als verdientes Gericht dargestellt (Klagelieder 2).',
    ),
    QuizQuestion(
      text: 'Welcher Ton prägt diese ersten beiden Kapitel insgesamt?',
      options: <String>[
        'Tiefe Trauer über die zerstörte Stadt',
        'Freudiges Feiern',
        'Völlige Gleichgültigkeit',
        'Militärischer Triumph',
      ],
      correctIndex: 0,
      explanation: 'Das Buch ist eine Totenklage (Klagelieder 1-2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Freude', 'Tempel', 'Mauern'],
    ),
  ],
  'Lamentations#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Hoffnungsaussage steht trotz des Leidens im Zentrum von Kapitel 3?',
      options: <String>[
        'Jehovas liebende Güte ist jeden Morgen neu',
        'Es gibt überhaupt keine Hoffnung',
        'Das Leiden wird nie enden',
        'Gott hat sein Volk völlig verlassen',
      ],
      correctIndex: 0,
      explanation: '„Groß ist deine Treue“ (Klagelieder 3:22, 23).',
    ),
    QuizQuestion(
      text: 'Wie beschreibt sich der Schreiber selbst in Kapitel 3?',
      options: <String>[
        'Als einen Mann, der Elend gesehen hat',
        'Als einen triumphierenden König',
        'Als einen bloßen außenstehenden Beobachter',
        'Als einen Priester bei einem Festmahl',
      ],
      correctIndex: 0,
      explanation:
          'Eine persönliche Leiderfahrung wird geteilt (Klagelieder 3:1).',
    ),
    QuizQuestion(
      text: 'Welche Haltung empfiehlt Kapitel 3 angesichts der Prüfung?',
      options: <String>[
        'Still und hoffnungsvoll auf Jehova warten',
        'Sofort Rache zu üben',
        'Jeden Glauben aufzugeben',
        'Weit von jeder Gemeinschaft zu fliehen',
      ],
      correctIndex: 0,
      explanation:
          'Zuversichtliche Geduld wird ermutigt (Klagelieder 3:25, 26).',
    ),
  ],
  'Lamentations#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'An welches extreme Leiden erinnert Kapitel 4 während der Belagerung?',
      options: <String>[
        'Eine schwere Hungersnot unter den Bewohnern',
        'Einen Überfluss an Nahrung',
        'Einen unerwarteten Frieden',
        'Eine Flut von Reichtum',
      ],
      correctIndex: 0,
      explanation:
          'Die Hungersnot der Belagerung wird mit schonungslosem Realismus beschrieben (Klagelieder 4).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Plage', 'Schwert', 'Feuer'],
    ),
    QuizQuestion(
      text: 'Um was bittet das abschließende Gebet von Kapitel 5?',
      options: <String>[
        'Dass Jehova sein Volk wie in der Vergangenheit wiederherstelle',
        'Dass die Stadt für immer in Trümmern bleibe',
        'Dass niemals eine Rückkehr möglich sei',
        'Dass das Volk seine Vergangenheit vergesse',
      ],
      correctIndex: 0,
      explanation:
          '„Bring uns zu dir zurück“ beschließt das Buch (Klagelieder 5:21).',
    ),
    QuizQuestion(
      text: 'Welches Gefühl prägt das gemeinsame Gebet des letzten Kapitels?',
      options: <String>[
        'Demütiges Flehen trotz der Scham über die Vergangenheit',
        'Erneuerter Stolz',
        'Gleichgültigkeit gegenüber der Zukunft',
        'Zorn gegen Gott',
      ],
      correctIndex: 0,
      explanation:
          'Das Volk erkennt seine Lage an und fleht um Wiederherstellung (Klagelieder 5).',
    ),
  ],
  'Ezekiel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Was sieht Hesekiel in seiner Anfangsvision in Kapitel 1?',
      options: <String>[
        'Jehovas himmlischen Wagen mit lebenden Geschöpfen',
        'Einen einfachen Sandsturm',
        'Einen brennenden Tempel',
        'Ein marschierendes Heer',
      ],
      correctIndex: 0,
      explanation: 'Eine eindrucksvolle Vision eröffnet das Buch (Hesekiel 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Thron', 'Räder', 'Tempel'],
    ),
    QuizQuestion(
      text: 'Was muss Hesekiel mit der Buchrolle tun, die ihm gegeben wird?',
      options: <String>[
        'Sie essen',
        'Sie verbrennen',
        'Sie verstecken',
        'Sie verkaufen',
      ],
      correctIndex: 0,
      explanation:
          'Ein symbolisches Zeichen für das Aufnehmen der Botschaft (Hesekiel 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['die Buchrolle essen'],
    ),
    QuizQuestion(
      text:
          'Welchen heimlichen Götzendienst sieht Hesekiel im Tempel selbst praktiziert?',
      options: <String>[
        'Sonnenanbetung und Götzenbilder, verborgen von den Ältesten',
        'Es wird gar kein Götzendienst gefunden',
        'Nur ein leerer Altar wird gesehen',
        'Ein rechtmäßiges öffentliches Fest',
      ],
      correctIndex: 0,
      explanation:
          'Eine Vision enthüllt die verborgene Verderbtheit (Hesekiel 8).',
    ),
  ],
  'Ezekiel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wer erhält ein Schutzzeichen vor dem Gericht über Jerusalem?',
      options: <String>[
        'Diejenigen, die über die abscheulichen Praktiken seufzen',
        'Alle Bewohner ohne Unterschied',
        'Nur die Priester',
        'Nur die Reichen',
      ],
      correctIndex: 0,
      explanation:
          'Ein Unterschied wird je nach Herzenshaltung gemacht (Hesekiel 9).',
    ),
    QuizQuestion(
      text:
          'Was Bedeutsames geschieht mit Jehovas Herrlichkeit in Hesekiel 10-11?',
      options: <String>[
        'Sie verlässt den Tempel und die Stadt',
        'Sie lässt sich dort dauerhaft nieder',
        'Sie wird noch stärker',
        'Es ändert sich nichts',
      ],
      correctIndex: 0,
      explanation:
          'Ein ernstes Zeichen des kommenden Gerichts (Hesekiel 10-11).',
    ),
    QuizQuestion(
      text: 'Womit wird Jerusalem im Gleichnis von Kapitel 16 verglichen?',
      options: <String>[
        'Mit einer untreuen Frau, die Gott seit ihrer Geburt aufzog',
        'Mit einer stets treuen Königin',
        'Mit einem mächtigen König',
        'Mit einer Stadt, die nie gegründet wurde',
      ],
      correctIndex: 0,
      explanation: 'Eine eindrucksvolle Allegorie der Untreue (Hesekiel 16).',
    ),
  ],
  'Ezekiel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was erklärt Hesekiel 18 über die individuelle Verantwortung?',
      options: <String>[
        'Die Seele, die sündigt, ist es, die sterben wird',
        'Kinder tragen immer die Schuld ihrer Eltern',
        'Niemand ist für sein eigenes Handeln verantwortlich',
        'Nur Könige werden gerichtet',
      ],
      correctIndex: 0,
      explanation:
          'Ein Grundsatz individueller Gerechtigkeit wird aufgestellt (Hesekiel 18:20).',
    ),
    QuizQuestion(
      text: 'Wonach sucht Jehova in Hesekiel 22, ohne es zu finden?',
      options: <String>[
        'Einen Mann, der in die Bresche tritt',
        'Einen neuen König',
        'Einen Tempel, den er wiederaufbauen könnte',
        'Einen fremden Propheten',
      ],
      correctIndex: 0,
      explanation:
          'Das Fehlen eines Fürsprechers verschlimmert das Gericht (Hesekiel 22:30).',
    ),
    QuizQuestion(
      text:
          'Welches schmerzhafte persönliche Zeichen erlebt Hesekiel in Kapitel 24?',
      options: <String>[
        'Den Tod seiner Frau, um die er nicht öffentlich trauern durfte',
        'Den Verlust seines Hauses',
        'Ein sofortiges Exil',
        'Eine schwere Krankheit',
      ],
      correctIndex: 0,
      explanation:
          'Dieses Zeichen veranschaulicht das Ausmaß des kommenden Schocks (Hesekiel 24).',
    ),
  ],
  'Ezekiel#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Gegen welche Nachbarnationen richten sich die Sprüche dieser Kapitel?',
      options: <String>[
        'Ammon, Moab, Edom, die Philister und Tyrus',
        'Nur gegen Ägypten',
        'Nur gegen Babylon',
        'Gegen keine fremde Nation',
      ],
      correctIndex: 0,
      explanation:
          'Eine Reihe von Gerichten gegen die Nationen (Hesekiel 25-28).',
    ),
    QuizQuestion(
      text: 'Wie wird Tyrus in der poetischen Klage über sie beschrieben?',
      options: <String>[
        'Als ein prächtiges Handelsschiff',
        'Als eine Stadt ohne Handel',
        'Als eine friedliche Nation',
        'Als ein treuer Verbündeter Israels',
      ],
      correctIndex: 0,
      explanation:
          'Ein nautisches Bild veranschaulicht ihre vergangene Pracht (Hesekiel 27).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tyrus', 'Meer', 'Zeder'],
    ),
    QuizQuestion(
      text: 'Womit wird Ägypten im Gericht über es verglichen?',
      options: <String>[
        'Mit einer großen Zeder, die schließlich gefällt wird',
        'Mit einem unerschütterlichen Fels',
        'Mit einem ruhigen Meer',
        'Mit einer leeren Wüste',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild von Größe, gefolgt von einem Fall (Hesekiel 31).',
    ),
  ],
  'Ezekiel#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche Rolle wird Hesekiel gegenüber seinem Volk zugewiesen?',
      options: <String>[
        'Die eines Wächters, der warnen soll',
        'Die eines Königs',
        'Die eines bloßen Schreibers',
        'Die eines militärischen Richters',
      ],
      correctIndex: 0,
      explanation:
          'Seine Verantwortung als Wächter wird festgelegt (Hesekiel 33).',
    ),
    QuizQuestion(
      text:
          'Was sieht Hesekiel in der berühmten Vision vom Tal der trockenen Gebeine?',
      options: <String>[
        'Gebeine, die zum Leben zurückkehren, ein Bild von Israels Wiederherstellung',
        'Eine blutige Schlacht im Gange',
        'Eine hoffnungslose Wüste',
        'Eine wohlhabende Stadt',
      ],
      correctIndex: 0,
      explanation: 'Ein starkes Bild nationaler Auferstehung (Hesekiel 37).',
    ),
    QuizQuestion(
      text:
          'Wofür stehen die beiden zu einem verbundenen Hölzer in Hesekiel 37?',
      options: <String>[
        'Für die Wiedervereinigung von Juda und Israel',
        'Für ein Bündnis mit Ägypten',
        'Für die dauerhafte Spaltung des Volkes',
        'Für die Zerstörung des Tempels',
      ],
      correctIndex: 0,
      explanation:
          'Ein Volk, wiedervereint unter einem Hirten (Hesekiel 37:19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Hölzer', 'Gebeine', 'Tempel'],
    ),
  ],
  'Ezekiel#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Was tut Jehovas Herrlichkeit in der Vision des neuen Tempels?',
      options: <String>[
        'Sie erfüllt das Haus erneut',
        'Sie bleibt für immer abwesend',
        'Sie erscheint nur anderswo',
        'Es geschieht nichts',
      ],
      correctIndex: 0,
      explanation:
          'Eine symbolische Rückkehr der göttlichen Gegenwart (Hesekiel 43).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Herrlichkeit', 'Fluss', 'Tor'],
    ),
    QuizQuestion(
      text:
          'Was bewirkt laut Hesekiel 47 der Fluss, der aus dem Tempel fließt?',
      options: <String>[
        'Wasser, das heilt und Leben spendet, wohin es auch fließt',
        'Eine zerstörerische Flut',
        'Eine bloße Kuriosität ohne Wirkung',
        'Wasser, das nur den Priestern vorbehalten ist',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild reicher Wiederherstellung (Hesekiel 47:9).',
    ),
    QuizQuestion(
      text: 'Wie heißt die Stadt am Ende des Buches?',
      options: <String>[
        '„Jehova ist dort“',
        '„Die ewige Stadt“',
        '„Neu-Babylon“',
        'Nur „Die heilige Stadt“',
      ],
      correctIndex: 0,
      explanation:
          'Dieser Name fasst die Hoffnung des Buches zusammen (Hesekiel 48:35).',
    ),
  ],
  'Daniel#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Warum weigerten sich Daniel und seine Gefährten, die Speise des Königs zu essen?',
      options: <String>[
        'Um ihren Grundsätzen treu zu bleiben',
        'Weil sie keinen Hunger hatten',
        'Weil ihnen die Mittel fehlten',
        'Auf ausdrücklichen Befehl des Königs',
      ],
      correctIndex: 0,
      explanation:
          'Ihre Lauterkeit wird mit guter Gesundheit belohnt (Daniel 1).',
    ),
    QuizQuestion(
      text:
          'Wofür steht die von Daniel gedeutete Statue in Nebukadnezars Traum?',
      options: <String>[
        'Für eine Abfolge von Weltreichen',
        'Für ein einfaches Kunstwerk',
        'Für einen bedeutungslosen Traum',
        'Für eine Prophezeiung über Daniel persönlich',
      ],
      correctIndex: 0,
      explanation:
          'Ein von Gott errichtetes letztes Königreich übertrifft alle anderen (Daniel 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Statue', 'Traum', 'Löwen'],
    ),
    QuizQuestion(
      text:
          'Was geschah, als Schadrach, Meschach und Abed-Nego sich weigerten, die goldene Statue anzubeten?',
      options: <String>[
        'Sie wurden im brennenden Feuerofen beschützt',
        'Sie wurden sofort hingerichtet',
        'Sie gaben schließlich nach',
        'Sie flohen aus dem Königreich',
      ],
      correctIndex: 0,
      explanation: 'Ein Wunder zeigt göttlichen Schutz (Daniel 3).',
    ),
  ],
  'Daniel#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche geheimnisvolle Botschaft erscheint an der Wand während Belsazars Festmahl?',
      options: <String>[
        'Eine Schrift, die den Fall des Königreichs ankündigt',
        'Ein Freudengedicht',
        'Eine Liste von Schätzen',
        'Eine Botschaft des Friedens',
      ],
      correctIndex: 0,
      explanation: 'Babylon fällt noch in derselben Nacht (Daniel 5).',
    ),
    QuizQuestion(
      text: 'Warum wurde Daniel in die Löwengrube geworfen?',
      options: <String>[
        'Er betete trotz eines Erlasses weiter, der es verbot',
        'Er hatte vom König gestohlen',
        'Er hatte das Königreich verraten',
        'Er weigerte sich zu arbeiten',
      ],
      correctIndex: 0,
      explanation:
          'Seine Treue im Gebet wird auf die Probe gestellt (Daniel 6).',
    ),
    QuizQuestion(
      text: 'Was sieht Daniel in seiner Vision von den vier Tieren?',
      options: <String>[
        'Aufeinanderfolgende Königreiche, dann ein ewiges Königreich, gegeben „einem Menschensohn“',
        'Eine einfache Hirtenszene',
        'Das unmittelbare Ende der Welt',
        'Einen Krieg ohne prophetische Bedeutung',
      ],
      correctIndex: 0,
      explanation:
          'Eine Schlüsselvision über die verheißene ewige Herrschaft (Daniel 7).',
    ),
  ],
  'Daniel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was tut Daniel, bevor er die Prophezeiung der „70 Wochen“ erhält?',
      options: <String>[
        'Er betet und bekennt die Sünden seines Volkes',
        'Er hält ein Festmahl ab',
        'Er verlässt Babylon',
        'Er befragt Wahrsager',
      ],
      correctIndex: 0,
      explanation:
          'Sein aufrichtiges Gebet geht Gabriels Antwort voraus (Daniel 9).',
    ),
    QuizQuestion(
      text:
          'Wer erscheint Daniel am Tigris, um ihm einen himmlischen Konflikt zu erklären?',
      options: <String>[
        'Ein himmlischer Bote, gesandt nach einem geistigen Kampf',
        'Nur ein menschlicher König',
        'Ein bloßer Traum ohne Boten',
        'Nebukadnezar selbst',
      ],
      correctIndex: 0,
      explanation: 'Ein geistiger Kampf wird Daniel enthüllt (Daniel 10).',
    ),
    QuizQuestion(
      text: 'Welche letzte Hoffnung beschließt das Buch Daniel?',
      options: <String>[
        'Eine Auferstehung wird verheißen, zusammen mit der Läuterung des Volkes',
        'Das Ende ohne jede Hoffnung',
        'Völlige Zerstörung ohne Zukunft',
        'Gottes endgültiges Schweigen',
      ],
      correctIndex: 0,
      explanation:
          'Michael steht auf, und Hoffnung auf eine Auferstehung wird gegeben (Daniel 12).',
    ),
  ],
  'Hosea#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was verlangte Jehova von Hosea, um Israels Untreue zu veranschaulichen?',
      options: <String>[
        'Eine untreue Frau, Gomer, zu heiraten',
        'Einen neuen Altar zu bauen',
        'Freiwillig ins Exil zu gehen',
        'Ein Jahr lang zu fasten',
      ],
      correctIndex: 0,
      explanation:
          'Hoseas Ehe veranschaulicht die Beziehung zwischen Gott und Israel (Hosea 1).',
    ),
    QuizQuestion(
      text: 'Welchen Mangel wirft Jehova seinem Volk in Kapitel 4 vor?',
      options: <String>[
        'Einen Mangel an Erkenntnis Gottes',
        'Einen Mangel an Reichtum',
        'Einen Mangel an fähigen Königen',
        'Einen Mangel an Land',
      ],
      correctIndex: 0,
      explanation:
          '„Mein Volk geht wegen Mangels an Erkenntnis zugrunde“ (Hosea 4:6).',
    ),
  ],
  'Hosea#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was zieht Jehova laut Hosea 6 dem Opfer vor?',
      options: <String>[
        'Liebende Güte (herzliche Freundlichkeit)',
        'Reichliche Opfergaben',
        'Einen größeren Tempel',
        'Längere Zeremonien',
      ],
      correctIndex: 0,
      explanation:
          '„Ich habe Wohlgefallen an Loyalität, nicht am Opfer“ (Hosea 6:6).',
    ),
    QuizQuestion(
      text: 'Was erntet Israel laut Hosea 8, nachdem es „den Wind gesät“ hat?',
      options: <String>[
        'Den Sturm',
        'Dauerhaften Frieden',
        'Reichtum',
        'Nichts Besonderes',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild der Folgen von Untreue (Hosea 8:7).',
    ),
  ],
  'Hosea#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie drückt Jehova in Hosea 11 seine väterliche Zuneigung zu Ephraim aus?',
      options: <String>[
        '„Wie könnte ich dich aufgeben, Ephraim?“',
        'Er erklärt, ihn für immer vergessen zu wollen',
        'Er verweigert jedes Mitgefühl',
        'Er ignoriert sein Schicksal völlig',
      ],
      correctIndex: 0,
      explanation: 'Väterliche Zärtlichkeit trotz der Auflehnung (Hosea 11:8).',
    ),
    QuizQuestion(
      text: 'Welche letzte Verheißung beschließt das Buch Hosea?',
      options: <String>[
        'Jehova wird ihre Untreue heilen und sie freiwillig lieben',
        'Israel wird für immer bestraft bleiben',
        'Keine Wiederherstellung wird verheißen',
        'Das Volk wird völlig ausgelöscht werden',
      ],
      correctIndex: 0,
      explanation: 'Ein letzter Aufruf zur Reue und Hoffnung (Hosea 14).',
    ),
  ],
  'Joel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche Katastrophe trifft das Land zu Beginn des Buches Joel?',
      options: <String>[
        'Eine Heuschreckeninvasion',
        'Ein Bürgerkrieg',
        'Eine zehnjährige Dürre',
        'Eine Seuche',
      ],
      correctIndex: 0,
      explanation: 'Eine beispiellose Katastrophe wird beschrieben (Joel 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Heuschrecken'],
    ),
    QuizQuestion(
      text: 'Zu welchem Aufruf ruft Joel angesichts dieser Katastrophe auf?',
      options: <String>[
        'Zu trauern und zu fasten',
        'Ein Fest zu feiern',
        'Das Ereignis zu ignorieren',
        'Sofort auszuwandern',
      ],
      correctIndex: 0,
      explanation: 'Ein Aufruf zu gemeinsamer Reue (Joel 1).',
    ),
  ],
  'Joel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wonach ruft Joel 2, anstatt nur nach einem äußerlichen Ritus?',
      options: <String>[
        'Das Herz zu zerreißen, nicht die Kleider',
        'Mehr Opfer darzubringen',
        'Einen neuen Tempel zu bauen',
        'Eine Geldbuße zu zahlen',
      ],
      correctIndex: 0,
      explanation: 'Aufrichtige Reue wird gefordert (Joel 2:13).',
    ),
    QuizQuestion(
      text: 'Welche Verheißung aus Joel 2 zitiert Petrus am Pfingsttag?',
      options: <String>[
        'Ich werde meinen Geist über Menschen aller Art ausgießen',
        'Ich werde den Tempel zerstören',
        'Ich werde nur die Priester segnen',
        'Keine bemerkenswerte Verheißung',
      ],
      correctIndex: 0,
      explanation: 'Zitiert in Apostelgeschichte 2 an Pfingsten (Joel 2:28).',
    ),
  ],
  'Joel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wo werden laut Joel 3 die Nationen gerichtet?',
      options: <String>[
        'Im Tal der Entscheidung',
        'In Babylon',
        'In Ninive',
        'In Ägypten',
      ],
      correctIndex: 0,
      explanation: 'Ein gemeinsames Gericht wird dort angekündigt (Joel 3:14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jerusalem', 'Zion', 'Ägypten'],
    ),
    QuizQuestion(
      text: 'Was verheißt Joel 3 Juda nach dem Gericht über die Nationen?',
      options: <String>[
        'Segen und Wiederherstellung',
        'Endgültige Zerstörung',
        'Ein weiteres Exil',
        'Nichts Besonderes',
      ],
      correctIndex: 0,
      explanation: 'Ein hoffnungsvoller Schluss (Joel 3).',
    ),
  ],
  'Amos#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Gegen welche Nationen spricht Amos zu Beginn des Buches Gerichte aus?',
      options: <String>[
        'Damaskus, Gaza, Tyrus, Edom, Ammon, Moab, dann Juda und Israel',
        'Nur gegen Ägypten',
        'Nur gegen Babylon',
        'Gegen keine fremde Nation',
      ],
      correctIndex: 0,
      explanation:
          'Eine Reihe von Sprüchen geht der zentralen Botschaft voraus (Amos 1-2).',
    ),
    QuizQuestion(
      text: 'Was erklärt Amos 3 über Gottes Handlungsweise?',
      options: <String>[
        'Er tut nichts, ohne es seinen Propheten zu offenbaren',
        'Er handelt stets in völliger Heimlichkeit',
        'Er greift nie in die Geschichte ein',
        'Er braucht keine Boten',
      ],
      correctIndex: 0,
      explanation: 'Die prophetische Rolle wird betont (Amos 3:7).',
    ),
  ],
  'Amos#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wen kritisiert Amos 4, indem er sie mit den „Kühen von Baschan“ vergleicht?',
      options: <String>[
        'Die wohlhabenden Frauen, die die Armen unterdrücken',
        'Nur die Priester',
        'Fremde Propheten',
        'Nachbarkönige',
      ],
      correctIndex: 0,
      explanation: 'Eine direkte gesellschaftliche Kritik (Amos 4:1).',
    ),
    QuizQuestion(
      text: 'Um was bittet Amos 5 das Volk bezüglich der Gerechtigkeit?',
      options: <String>[
        'Dass Gerechtigkeit dahinströme wie Wasser',
        'Dass Gerechtigkeit unbegrenzt aufgeschoben werde',
        'Dass nur die Reichen gerichtet werden',
        'Dass Gerechtigkeit bloß symbolisch bleibe',
      ],
      correctIndex: 0,
      explanation: 'Ein berühmter Aufruf zu echter Gerechtigkeit (Amos 5:24).',
    ),
  ],
  'Amos#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welches symbolische Instrument benutzt Gott in einer Vision, um Israel zu richten?',
      options: <String>[
        'Ein Senklot',
        'Eine leere Waage',
        'Eine zerbrochene Trompete',
        'Ein königliches Zepter',
      ],
      correctIndex: 0,
      explanation: 'Das Bild prüft, ob eine Mauer gerade ist (Amos 7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Senklot', 'ein Senklot'],
    ),
    QuizQuestion(
      text: 'Was verheißt Amos 9 trotz des angekündigten Gerichts?',
      options: <String>[
        'Die Wiederherstellung der „gefallenen Hütte“ Davids',
        'Endgültige Zerstörung ohne Hoffnung',
        'Das völlige Vergessen des Volkes',
        'Das Ende jeder göttlichen Verheißung',
      ],
      correctIndex: 0,
      explanation: 'Ein Hoffnungsschimmer beschließt das Buch (Amos 9:11).',
    ),
  ],
  'Obadiah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Gegen wen richtet sich das kurze Buch Obadja?',
      options: <String>['Edom', 'Babylon', 'Ninive', 'Ägypten'],
      correctIndex: 0,
      explanation:
          'Edom wird für seine Gewalt gegen seinen Bruder Jakob gerichtet (Obadja 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Mit welcher Aussage endet das Buch Obadja?',
      options: <String>[
        'Das Königreich wird Jehova gehören',
        'Edom wird für immer herrschen',
        'Israel wird für immer verschwinden',
        'Kein Gericht wird stattfinden',
      ],
      correctIndex: 0,
      explanation: 'Eine Aussage göttlicher Souveränität (Obadja 21).',
    ),
  ],
  'Jonah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum floh Jona nach Tarsis, anstatt nach Ninive zu gehen?',
      options: <String>[
        'Er wollte der von Jehova gegebenen Aufgabe entkommen',
        'Er wusste nichts von der Aufgabe',
        'Er hatte seine Aufgabe bereits erfüllt',
        'Ninive hatte ihn persönlich eingeladen',
      ],
      correctIndex: 0,
      explanation: 'Jona versucht, seiner Aufgabe zu entfliehen (Jona 1).',
    ),
    QuizQuestion(
      text: 'Was geschah, als Jona ins Meer geworfen wurde?',
      options: <String>[
        'Er wurde von einem großen Fisch verschlungen',
        'Er schwamm allein ans Ufer',
        'Er ertrank sofort',
        'Ein Schiff nahm ihn sofort auf',
      ],
      correctIndex: 0,
      explanation: 'Ein außergewöhnliches Ereignis rettet ihn (Jona 1:17).',
    ),
  ],
  'Jonah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was tut Jona im Inneren des Fisches?',
      options: <String>[
        'Er betet zu Jehova',
        'Er schläft tief',
        'Er protestiert zornig',
        'Er bleibt still',
      ],
      correctIndex: 0,
      explanation: 'Ein Gebet der Not und der Dankbarkeit (Jona 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Fisch', 'Ninive', 'Sacktuch'],
    ),
    QuizQuestion(
      text: 'Wie reagierte Ninive auf Jonas Botschaft?',
      options: <String>[
        'Die ganze Stadt bereute, vom König bis zum Volk',
        'Sie ignorierte die Botschaft völlig',
        'Sie vertrieb Jona sofort',
        'Sie erklärte Israel den Krieg',
      ],
      correctIndex: 0,
      explanation: 'Eine überraschende gemeinsame Reue (Jona 3).',
    ),
  ],
  'Jonah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum war Jona nach Ninives Reue verärgert?',
      options: <String>[
        'Er hätte lieber gesehen, dass Gott die Stadt zerstört',
        'Er wollte mehr Geld',
        'Er wollte in Ninive bleiben',
        'Er war überhaupt nicht verärgert',
      ],
      correctIndex: 0,
      explanation:
          'Jona tut sich schwer, göttliche Barmherzigkeit zu akzeptieren (Jona 4).',
    ),
    QuizQuestion(
      text: 'Was möchte Jehova Jona mit der verdorrenden Pflanze lehren?',
      options: <String>[
        'Die Bedeutung von Mitgefühl, auch gegenüber Fremden',
        'Die Nutzlosigkeit jeglichen Mitgefühls',
        'Den rein materiellen Wert von Pflanzen',
        'Eine einfache botanische Tatsache',
      ],
      correctIndex: 0,
      explanation: 'Eine Lektion über göttliches Mitgefühl (Jona 4).',
    ),
  ],
  'Micah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Gegen welche Städte wird Michas Gericht zu Beginn des Buches angekündigt?',
      options: <String>[
        'Samaria und Jerusalem',
        'Ninive und Babylon',
        'Tyrus und Sidon',
        'Nur Damaskus',
      ],
      correctIndex: 0,
      explanation:
          'Die beiden Hauptstädte werden ins Visier genommen (Micha 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Babylon', 'Ninive', 'Bethlehem'],
    ),
    QuizQuestion(
      text: 'Welchen gesellschaftlichen Missbrauch prangert Micha 2 an?',
      options: <String>[
        'Das Begehren nach Feldern und Häusern, die den Armen gestohlen werden',
        'Einen Mangel an Opfern',
        'Das Fehlen religiöser Feste',
        'Einen Mangel an Priestern',
      ],
      correctIndex: 0,
      explanation:
          'Eine gesellschaftliche Ungerechtigkeit wird verurteilt (Micha 2).',
    ),
  ],
  'Micah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was verheißt Micha 5 bezüglich eines künftigen Herrschers?',
      options: <String>[
        'Er wird aus Bethlehem kommen',
        'Er wird aus Babylon kommen',
        'Er wird aus Ägypten kommen',
        'Kein Ort wird genannt',
      ],
      correctIndex: 0,
      explanation: 'Eine genaue messianische Prophezeiung (Micha 5:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jerusalem', 'Juda', 'Ägypten'],
    ),
    QuizQuestion(
      text: 'Welche Friedensvision teilt Micha 4, ähnlich wie Jesaja?',
      options: <String>[
        'Schwerter, umgeschmiedet zu Pflugscharen',
        'Einen endlosen Krieg',
        'Die Zerstörung aller Nationen',
        'Völliges Schweigen über die Zukunft',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild universellen Friedens (Micha 4:3).',
    ),
  ],
  'Micah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was verlangt Jehova laut Micha 6 vom Menschen?',
      options: <String>[
        'Recht zu üben, Güte zu lieben und demütig mit Gott zu wandeln',
        'Nur kostbare Opfer darzubringen',
        'Große Tempel zu bauen',
        'Jede öffentliche Tätigkeit zu meiden',
      ],
      correctIndex: 0,
      explanation:
          'Eine berühmte Zusammenfassung wahrer Gottesfurcht (Micha 6:8).',
    ),
    QuizQuestion(
      text:
          'Welche Hoffnung drückt Micha trotz der umgebenden Verderbtheit aus?',
      options: <String>[
        'Gott wird erneut sein Mitgefühl zeigen',
        'Keine Hoffnung ist möglich',
        'Das Gericht wird endgültig sein, ohne Vergebung',
        'Das Volk muss sich selbst rächen',
      ],
      correctIndex: 0,
      explanation: 'Erneuertes Vertrauen beschließt das Buch (Micha 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Zorn', 'Gericht', 'Meer'],
    ),
  ],
  'Nahum#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie beschreibt Nahum 1 Jehovas Charakter?',
      options: <String>[
        'Geduldig und doch mächtig in seiner Gerechtigkeit',
        'Gleichgültig gegenüber Ungerechtigkeit',
        'Schwach gegenüber den Nationen',
        'Ohne jegliche Gefühlsregung',
      ],
      correctIndex: 0,
      explanation: 'Ein Gleichgewicht zwischen Geduld und Macht (Nahum 1).',
    ),
    QuizQuestion(
      text: 'Wem bietet Nahum trotz des angekündigten Gerichts Trost?',
      options: <String>[
        'Denen, die bei ihm Zuflucht suchen',
        'Nur den Bewohnern Ninives',
        'Fremden Königen',
        'Niemandem',
      ],
      correctIndex: 0,
      explanation: 'Ein Trost für die Treuen (Nahum 1:7).',
    ),
  ],
  'Nahum#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was beschreibt Nahum 2 mit solcher Eindringlichkeit?',
      options: <String>[
        'Die Belagerung und den Fall Ninives',
        'Den Bau eines Tempels',
        'Ein Erntefest',
        'Eine königliche Krönung',
      ],
      correctIndex: 0,
      explanation: 'Eine lebhafte Schlachtbeschreibung (Nahum 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Samaria', 'Babylon', 'Juda'],
    ),
    QuizQuestion(
      text: 'Welcher Ton prägt diese Beschreibung von Ninives Fall?',
      options: <String>[
        'Ein unvermeidliches und vollständiges Gericht',
        'Eine milde Warnung',
        'Eine Hoffnung auf dauerhaften Frieden',
        'Eine laufende Verhandlung',
      ],
      correctIndex: 0,
      explanation: 'Ninives Ende wird als gewiss dargestellt (Nahum 2).',
    ),
  ],
  'Nahum#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie beschreibt Nahum 3 Ninive?',
      options: <String>[
        'Die blutbefleckte Stadt',
        'Die heilige Stadt',
        'Die Stadt des Friedens',
        'Die gesegnete Stadt',
      ],
      correctIndex: 0,
      explanation: 'Ein strenges Gericht für ihre Gewalt (Nahum 3:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Ninive', 'zerstört', 'stolz'],
    ),
    QuizQuestion(
      text: 'Welches endgültige Schicksal wird für Ninive angekündigt?',
      options: <String>[
        'Vollständige Zerstörung',
        'Eine künftige Wiederherstellung',
        'Ein Bündnis mit Israel',
        'Eine bloße Warnung ohne Folgen',
      ],
      correctIndex: 0,
      explanation:
          'Das Buch endet mit dem unwiderruflichen Fall der Stadt (Nahum 3).',
    ),
  ],
  'Habakkuk#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Worüber beklagt sich Habakuk zu Beginn des Buches?',
      options: <String>[
        'Über Ungerechtigkeit und Gewalt, die ohne Antwort andauern',
        'Über einen Mangel an Nahrung',
        'Nur über eine bevorstehende Invasion',
        'Über einen persönlichen Konflikt mit einem Priester',
      ],
      correctIndex: 0,
      explanation:
          'Eine aufrichtige Klage angesichts der Ungerechtigkeit (Habakuk 1).',
    ),
    QuizQuestion(
      text: 'Welche überraschende Antwort gibt Gott Habakuk?',
      options: <String>[
        'Er wird die Chaldäer (Babylonier) benutzen, um Gericht zu bringen',
        'Er wird überhaupt nichts tun',
        'Er wird Babylon sofort zerstören',
        'Er wird die Lage ignorieren',
      ],
      correctIndex: 0,
      explanation:
          'Eine Antwort, die den Propheten noch mehr beunruhigt (Habakuk 1).',
    ),
  ],
  'Habakkuk#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche berühmte Wahrheit bekräftigt Habakuk 2 über den Gerechten?',
      options: <String>[
        'Der Gerechte wird wegen seiner Treue leben',
        'Der Gerechte muss immer zweifeln',
        'Nur Reichtum rettet den Gerechten',
        'Der Gerechte hat keine Hoffnung',
      ],
      correctIndex: 0,
      explanation:
          'Eine Aussage, die später in den Christlichen Griechischen Schriften zitiert wird (Habakuk 2:4).',
    ),
    QuizQuestion(
      text: 'Was wird laut Habakuk 2 die ganze Erde erfüllen?',
      options: <String>[
        'Die Erkenntnis von Jehovas Herrlichkeit',
        'Der Reichtum der Nationen',
        'Vollständiges Schweigen',
        'Babylons Herrschaft für immer',
      ],
      correctIndex: 0,
      explanation: 'Eine universelle Hoffnungsverheißung (Habakuk 2:14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Wasser', 'Meer', 'Erde'],
    ),
  ],
  'Habakkuk#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Haltung nimmt Habakuk in seinem letzten Gebet ein, obwohl es keine Ernte gibt?',
      options: <String>[
        'Er wird sich dennoch an Jehova freuen',
        'Er wird seinen Glauben aufgeben',
        'Er wird Gott verfluchen',
        'Er wird weit weg aus seinem Land fliehen',
      ],
      correctIndex: 0,
      explanation:
          'Eine Zuversicht, die über die Umstände hinausgeht (Habakuk 3:17, 18).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Feige', 'Herde', 'Weinstock'],
    ),
    QuizQuestion(
      text: 'Wie schließt das Buch Habakuk?',
      options: <String>[
        'Mit einem Lied des Vertrauens auf die Kraft, die Gott gibt',
        'Mit einem hoffnungslosen Gericht',
        'Mit einer Liste von Gesetzen',
        'Mit völligem Schweigen',
      ],
      correctIndex: 0,
      explanation: 'Ein Glaubenspsalm beschließt das Buch (Habakuk 3).',
    ),
  ],
  'Zephaniah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches zentrale Ereignis kündigt Zephanja 1 an?',
      options: <String>[
        'Den großen Tag Jehovas, einen Tag des Gerichts',
        'Ein Erntefest',
        'Den Bau eines neuen Palastes',
        'Ein Handelsbündnis',
      ],
      correctIndex: 0,
      explanation: 'Ein universelles Gericht wird angekündigt (Zephanja 1).',
    ),
    QuizQuestion(
      text: 'Wen betrifft dieses Gericht zuallererst?',
      options: <String>[
        'Juda und Jerusalem',
        'Nur Ägypten',
        'Nur Ninive',
        'Nur Edom',
      ],
      correctIndex: 0,
      explanation: 'Das Gericht beginnt bei Gottes eigenem Volk (Zephanja 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Ninive', 'Moab', 'Ägypten'],
    ),
  ],
  'Zephaniah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wozu rät Zephanja 2 vor dem Eintreffen des Gerichts?',
      options: <String>[
        'Jehova und Demut zu suchen',
        'Sich sorglos zu freuen',
        'Die Warnungen zu ignorieren',
        'Unüberlegt zu fliehen',
      ],
      correctIndex: 0,
      explanation: 'Ein dringender Aufruf zur Reue (Zephanja 2:3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Stolz', 'Nationen', 'Reichtum'],
    ),
    QuizQuestion(
      text: 'Welche Nationen werden in diesem Kapitel ebenfalls gerichtet?',
      options: <String>[
        'Nachbarnationen wie Moab und Ammon',
        'Nur Israel',
        'Keine andere Nation',
        'Nur Babylon',
      ],
      correctIndex: 0,
      explanation:
          'Das Gericht erstreckt sich auf die umliegenden Nationen (Zephanja 2).',
    ),
  ],
  'Zephaniah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche freudige Verheißung beschließt das Buch Zephanja?',
      options: <String>[
        'Jehova wird sich mit Gesang über sein Volk freuen',
        'Das Gericht wird dauerhaft bleiben',
        'Keine Wiederherstellung wird verheißen',
        'Das Volk wird für immer vergessen werden',
      ],
      correctIndex: 0,
      explanation: 'Ein berührendes Bild göttlicher Freude (Zephanja 3:17).',
    ),
    QuizQuestion(
      text: 'Was verheißt Zephanja 3 bezüglich eines treuen Überrests?',
      options: <String>[
        'Er wird geläutert und gesammelt werden',
        'Er wird vollständig verschwinden',
        'Er wird für immer verbannt',
        'Er wird keine Zukunft haben',
      ],
      correctIndex: 0,
      explanation:
          'Eine Hoffnung auf Wiederherstellung für die Treuen (Zephanja 3).',
    ),
  ],
  'Haggai#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welchen Vorwurf macht Haggai dem aus dem Exil zurückgekehrten Volk?',
      options: <String>[
        'Sie hatten den Wiederaufbau des Tempels vernachlässigt',
        'Sie hatten zu viel am Tempel gearbeitet',
        'Ihnen fehlte verständlicherweise das Geld',
        'Sie hatten zu viele Tempel gebaut',
      ],
      correctIndex: 0,
      explanation:
          'Das Volk stellte seine eigenen Häuser in den Vordergrund (Haggai 1).',
    ),
    QuizQuestion(
      text: 'Welche Verheißung ermutigt zur Wiederaufnahme des Tempelbaus?',
      options: <String>[
        'Die Herrlichkeit dieses Hauses wird die des früheren übertreffen',
        'Der Tempel wird nie fertiggestellt werden',
        'Es wird keine Ermutigung gegeben',
        'Der Tempel wird dauerhaft aufgegeben',
      ],
      correctIndex: 0,
      explanation:
          'Eine starke Ermutigung für Serubbabel und das Volk (Haggai 2:9).',
    ),
  ],
  'Zechariah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Art von Offenbarungen erhält Sacharja zu Beginn des Buches?',
      options: <String>[
        'Eine Reihe symbolischer Nachtvisionen',
        'Eine einfache öffentliche Rede',
        'Einen Brief eines fremden Königs',
        'Nur einen königlichen Erlass',
      ],
      correctIndex: 0,
      explanation:
          'Acht Nachtvisionen strukturieren diese Kapitel (Sacharja 1-5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Träume', 'Engel', 'Tempel'],
    ),
    QuizQuestion(
      text:
          'Wofür steht die Reinigung des Hohen Priesters Josua in einer dieser Visionen?',
      options: <String>[
        'Für Vergebung und die Erneuerung des Priestertums',
        'Für die endgültige Verurteilung der Priester',
        'Für das Ende des Priestertums',
        'Für einen bloßen Kleiderwechsel ohne Bedeutung',
      ],
      correctIndex: 0,
      explanation:
          'Seine schmutzigen Gewänder werden durch Festkleidung ersetzt (Sacharja 3).',
    ),
  ],
  'Zechariah#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie wird der künftige messianische König in Sacharja 9 beschrieben?',
      options: <String>[
        'Demütig, reitend auf einem jungen Esel',
        'Siegreich auf einem Kriegswagen',
        'Unsichtbar und ohne Gestalt',
        'Begleitet von einem großen Heer',
      ],
      correctIndex: 0,
      explanation:
          'Eine Prophezeiung, erfüllt bei Jesu triumphalem Einzug (Sacharja 9:9).',
    ),
    QuizQuestion(
      text:
          'Was antworten Sacharja 7-8 auf die Frage nach ritualisiertem Fasten?',
      options: <String>[
        'Gerechtigkeit und Barmherzigkeit zählen mehr als das Ritual',
        'Fasten allein genügt immer',
        'Fasten muss sofort abgeschafft werden',
        'Es wird keine Antwort gegeben',
      ],
      correctIndex: 0,
      explanation:
          'Eine Betonung der Herzenshaltung statt des Rituals (Sacharja 7-8).',
    ),
  ],
  'Zechariah#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Prophezeiung aus Sacharja 11 wird mit Judas\' Verrat in Verbindung gebracht?',
      options: <String>[
        'Die dreißig Silberstücke',
        'Die Zerstörung des Tempels',
        'Der Fall Babylons',
        'Ein Gericht gegen Ägypten',
      ],
      correctIndex: 0,
      explanation:
          'Dieses Detail wird in den Evangelienberichten aufgegriffen (Sacharja 11:12, 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gold', 'Hirte', 'Töpfer'],
    ),
    QuizQuestion(
      text: 'Wie schließt das Buch Sacharja bezüglich der Zukunft?',
      options: <String>[
        'Jehova wird König über die ganze Erde werden',
        'Die Welt wird für immer geteilt bleiben',
        'Keine endgültige Hoffnung wird gegeben',
        'Jerusalem wird für immer verschwinden',
      ],
      correctIndex: 0,
      explanation:
          'Eine universelle Vision göttlichen Königtums (Sacharja 14:9).',
    ),
  ],
  'Malachi#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welchen Vorwurf macht Maleachi den Priestern in Kapitel 1?',
      options: <String>[
        'Jehova mangelhafte Opfer darzubringen',
        'Niemals Opfer darzubringen',
        'Zu viel zu beten',
        'Einen zweiten Tempel zu bauen',
      ],
      correctIndex: 0,
      explanation:
          'Verachtung gegenüber den Opfergaben wird angeprangert (Maleachi 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Zehnten', 'Räucherwerk', 'Altar'],
    ),
    QuizQuestion(
      text: 'Wie veranschaulicht Maleachi 1 Jehovas Liebe zu seinem Volk?',
      options: <String>[
        'Durch den Gegensatz zwischen Jakob und Esau',
        'Indem er Israel völlig ignoriert',
        'Indem er eine andere Nation begünstigt',
        'Indem er überhaupt keinen Unterschied macht',
      ],
      correctIndex: 0,
      explanation:
          'Ein Gegensatz hebt die Gunst hervor, die Jakob erwiesen wird (Maleachi 1:2, 3).',
    ),
  ],
  'Malachi#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Worum bittet Maleachi 3 bezüglich der Zehnten?',
      options: <String>[
        'Den ganzen Zehnten zu bringen und „Gott auf die Probe zu stellen“',
        'Den Zehnten vollständig abzuschaffen',
        'Ihn nur den Reichen vorzubehalten',
        'Ihn nur einmal im Leben darzubringen',
      ],
      correctIndex: 0,
      explanation:
          'Eine Herausforderung, Gott praktisch zu vertrauen (Maleachi 3:10).',
    ),
    QuizQuestion(
      text: 'Welchen Boten kündigt Maleachi 3 vor dem Kommen des Herrn an?',
      options: <String>[
        'Einen Boten, der den Weg bereiten wird',
        'Einen fremden König',
        'Nur einen neuen Priester',
        'Es wird kein Bote erwähnt',
      ],
      correctIndex: 0,
      explanation:
          'Eine Prophezeiung, verbunden mit Johannes dem Täufer (Maleachi 3:1).',
    ),
  ],
  'Malachi#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welchen furchterregenden Tag kündigt Maleachi 4 an?',
      options: <String>[
        'Den großen und furchterregenden Tag Jehovas',
        'Einen folgenlosen Festtag',
        'Einen bloßen Markttag',
        'Keinen besonderen Tag',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild des endgültigen Gerichts (Maleachi 4:1).',
    ),
    QuizQuestion(
      text: 'Wer soll laut Maleachi vor jenem Tag zurückkehren?',
      options: <String>['Elia', 'Mose', 'David', 'Salomo'],
      correctIndex: 0,
      explanation:
          'Diese Prophezeiung wird in den Evangelien mit Johannes dem Täufer verbunden (Maleachi 4:5).',
      type: QuizAnswerType.freeText,
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesDeC4 =
    <String, List<QuizQuestion>>{};
