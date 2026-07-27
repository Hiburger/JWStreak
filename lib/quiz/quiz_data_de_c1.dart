import 'quiz_data.dart';

const Map<String, List<QuizQuestion>> authoredQuizzesDeC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text: 'An wie vielen Schöpfungstagen beschreibt die Bibel Gottes '
          'Wirken?',
      options: <String>['Sechs Tage', 'Sieben Tage', 'Drei Tage', 'Vierzig Tage'],
      correctIndex: 0,
      explanation:
          '1. Mose beschreibt sechs Schöpfungstage; am siebten ruht Gott '
          '(1. Mose 1 und 2).',
    ),
    QuizQuestion(
      text: 'Wer waren der erste Mann und die erste Frau?',
      options: <String>['Adam und Eva', 'Kain und Abel', 'Noah und seine Frau', 'Abraham und Sara'],
      correctIndex: 0,
      explanation: 'Adam und Eva sind die ersten Menschen (1. Mose 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Kain', 'Noah', 'Sara'],
    ),
    QuizQuestion(
      text: 'Wer tötete seinen Bruder Abel?',
      options: <String>['Kain', 'Set', 'Noah', 'Ham'],
      correctIndex: 0,
      explanation: 'Kain tötet seinen Bruder Abel aus Neid (1. Mose 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Warum ließ Gott die Sintflut kommen?',
      options: <String>[
        'Wegen der Schlechtigkeit der Menschen',
        'Wegen einer Dürre',
        'Um die Meere größer zu machen',
        'Es wird kein Grund genannt',
      ],
      correctIndex: 0,
      explanation:
          'Die Schlechtigkeit der Menschen war groß auf der Erde '
          '(1. Mose 6).',
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Zeichen gab Gott als Zusage, die Erde nie wieder '
          'durch eine Flut zu vernichten?',
      options: <String>['Der Regenbogen', 'Ein Stern', 'Ein Olivenbaum', 'Donner'],
      correctIndex: 0,
      explanation:
          'Der Regenbogen ist das Zeichen des Bundes (1. Mose 9).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Regenbogen'],
    ),
    QuizQuestion(
      text: 'Wie hieß der Turm, den die Menschen bauen wollten?',
      options: <String>['Der Turm von Babel', 'Der Turm von Zion', 'Der Turm Davids', 'Der Turm von Ur'],
      correctIndex: 0,
      explanation:
          'In Babel verwirrt Gott ihre Sprache (1. Mose 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Zion', 'David', 'Ur'],
    ),
    QuizQuestion(
      text: 'Wen rief Gott dazu auf, Ur zu verlassen?',
      options: <String>['Abram (Abraham)', 'Lot', 'Isaak', 'Jakob'],
      correctIndex: 0,
      explanation:
          'Gott ruft Abram und gibt ihm Verheißungen (1. Mose 12).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum versklavten die Ägypter die Israeliten?',
      options: <String>[
        'Sie fürchteten, die Israeliten würden zu zahlreich',
        'Sie wollten ihr Land',
        'Eine unbezahlte Schuld',
        'Ein verlorener Krieg',
      ],
      correctIndex: 0,
      explanation:
          'Ein neuer König fürchtet die wachsende Zahl der Israeliten '
          '(2. Mose 1).',
    ),
    QuizQuestion(
      text: 'Worin versteckte Moses Mutter ihn als Baby?',
      options: <String>[
        'In einem Binsenkorb auf dem Nil',
        'In einer Höhle',
        'In einem Zelt',
        'In einem Brunnen',
      ],
      correctIndex: 0,
      explanation:
          'Mose wird in einem Binsenkorb zwischen dem Schilf ausgesetzt '
          '(2. Mose 2).',
    ),
    QuizQuestion(
      text: 'Wie erschien Gott Mose am Berg Horeb?',
      options: <String>[
        'Als Dornbusch, der brannte, aber nicht verbrannte',
        'Als Wolkensäule',
        'Als sichtbarer Engel',
        'Als Erdbeben',
      ],
      correctIndex: 0,
      explanation:
          'Gott spricht aus einem brennenden Dornbusch zu Mose (2. Mose 3).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Fest führte Gott ein, bevor er Israel aus Ägypten '
          'führte?',
      options: <String>['Das Passah', 'Pfingsten', 'Das Laubhüttenfest', 'Der Sabbat'],
      correctIndex: 0,
      explanation:
          'Das Passah erinnert an den Schutz der Israeliten während der '
          'letzten Plage (2. Mose 12).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Passah'],
    ),
    QuizQuestion(
      text: 'Wie öffnete Gott Israel einen Weg?',
      options: <String>[
        'Indem er das Wasser des Roten Meeres teilte',
        'Indem er den Jordan austrocknete',
        'Indem er einen Tunnel grub',
        'Indem er eine Steinbrücke schickte',
      ],
      correctIndex: 0,
      explanation:
          'Das Rote Meer teilt sich, damit Israel hindurchziehen kann '
          '(2. Mose 14).',
    ),
    QuizQuestion(
      text: 'Welche Speise ließ Gott in der Wüste vom Himmel fallen?',
      options: <String>['Manna', 'Gerstenbrot', 'Feigen', 'Honig'],
      correctIndex: 0,
      explanation: 'Manna erscheint jeden Morgen (2. Mose 16).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wer riet Mose, das Schlichten von Streitigkeiten zu '
          'delegieren?',
      options: <String>['Jethro, sein Schwiegervater', 'Aaron', 'Josua', 'Mirjam'],
      correctIndex: 0,
      explanation:
          'Jethro schlägt vor, Vorsteher für alltägliche Fälle einzusetzen '
          '(2. Mose 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Jethro'],
    ),
    QuizQuestion(
      text: 'Wo gab Gott die Zehn Gebote?',
      options: <String>['Am Berg Sinai', 'Am Berg Nebo', 'In Kadesch', 'In Bethel'],
      correctIndex: 0,
      explanation: 'Das Gesetz wird am Berg Sinai gegeben (2. Mose 19-20).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Berg Sinai', 'Sinai'],
    ),
    QuizQuestion(
      text: 'Welches Gebot verbietet es, zu begehren, was anderen '
          'gehört?',
      options: <String>[
        'Das zehnte („Du sollst nicht begehren“)',
        'Das erste',
        'Das fünfte',
        'Das siebte',
      ],
      correctIndex: 0,
      explanation:
          'Das zehnte Gebot verbietet das Begehren (2. Mose 20:17).',
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Was sollte nach den Anweisungen gebaut werden, die Gott '
          'Mose gab?',
      options: <String>['Die Stiftshütte', 'Ein Palast', 'Eine Mauer', 'Ein Steintempel'],
      correctIndex: 0,
      explanation:
          'Gott gibt genaue Pläne für die Stiftshütte (2. Mose 25).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Stiftshütte'],
    ),
    QuizQuestion(
      text: 'Was machte das Volk, während Mose auf dem Berg war?',
      options: <String>['Ein goldenes Kalb', 'Eine Steinstatue', 'Einen Holzaltar', 'Einen Tempel'],
      correctIndex: 0,
      explanation:
          'Das Volk fertigt ein goldenes Kalb an und betet es an '
          '(2. Mose 32).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Bronze', 'Stier', 'Götze'],
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Was bedeckte die Stiftshütte, als sie fertig war, als '
          'Zeichen der Gegenwart Gottes?',
      options: <String>['Eine Wolke', 'Ein am helllichten Tag sichtbares Feuer', 'Ein Regenbogen', 'Ein Stern'],
      correctIndex: 0,
      explanation:
          'Die Wolke bedeckt das Zelt der Zusammenkunft, und die '
          'Herrlichkeit Jehovas erfüllt es (2. Mose 40).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Wolke'],
    ),
    QuizQuestion(
      text: 'Wer hieb schließlich neue Steintafeln aus, nachdem Mose '
          'die ersten zerbrochen hatte?',
      options: <String>['Mose, auf Gottes Befehl', 'Aaron', 'Josua', 'Bezalel'],
      correctIndex: 0,
      explanation:
          'Gott befiehlt Mose, zwei neue Tafeln auszuhauen (2. Mose 34).',
    ),
  ],
  'Leviticus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche Art von Opfer wurde vollständig auf dem Altar '
          'verbrannt?',
      options: <String>[
        'Das Brandopfer',
        'Das Gemeinschaftsopfer',
        'Das Getreideopfer',
        'Das Sündopfer',
      ],
      correctIndex: 0,
      explanation:
          'Das Brandopfer wird vollständig auf dem Altar verzehrt '
          '(3. Mose 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Getreide', 'Sünde', 'Frieden'],
    ),
    QuizQuestion(
      text: 'Wie viele Hauptarten von Opfern werden in diesen ersten '
          'Kapiteln beschrieben?',
      options: <String>['Fünf', 'Zwei', 'Zehn', 'Drei'],
      correctIndex: 0,
      explanation:
          'Brandopfer, Getreideopfer, Gemeinschaftsopfer, Sündopfer und '
          'Schuldopfer (3. Mose 1-7).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Wer sollte die Opfer zum Eingang des Zeltes der '
          'Zusammenkunft bringen?',
      options: <String>[
        'Die Person selbst, mit Hilfe der Priester',
        'Nur die Priester',
        'Nur die Ältesten',
        'Ein Vertreter des Königs',
      ],
      correctIndex: 0,
      explanation:
          'Der Opfernde bringt das Tier selbst, und die Priester '
          'amtieren (3. Mose 1-7).',
    ),
  ],
  'Leviticus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum starben Nadab und Abihu?',
      options: <String>[
        'Sie brachten unerlaubtes Feuer vor Jehova dar',
        'Sie gehorchten Mose nicht',
        'Sie aßen unreine Speisen',
        'Sie weigerten sich zu dienen',
      ],
      correctIndex: 0,
      explanation:
          'Aarons Söhne bringen „fremdes Feuer“ dar und sterben '
          '(3. Mose 10).',
    ),
    QuizQuestion(
      text: 'Welche Merkmale machten ein Landtier zum Essen rein?',
      options: <String>[
        'Gespaltene Hufe und Wiederkäuen',
        'Nur in der Wüste zu leben',
        'Ein Haustier zu sein',
        'Federn zu haben',
      ],
      correctIndex: 0,
      explanation:
          'Reine Tiere käuen wieder und haben gespaltene Hufe '
          '(3. Mose 11).',
    ),
    QuizQuestion(
      text: 'Welche Hautkrankheit wird in diesen Kapiteln von den '
          'Priestern genau untersucht?',
      options: <String>['Aussatz', 'Pocken', 'Nur Verbrennungen', 'Akne'],
      correctIndex: 0,
      explanation:
          'Die Priester untersuchen Anzeichen von Aussatz an Haut, '
          'Kleidung und Häusern (3. Mose 13-14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Leviticus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'An welchem feierlichen Tag wurden einmal im Jahr die '
          'Sünden der Nation gesühnt?',
      options: <String>[
        'Am Sühnetag (Jom Kippur)',
        'Am Passah',
        'Am Sabbat',
        'An Pfingsten',
      ],
      correctIndex: 0,
      explanation:
          'Der Hohe Priester bringt einmal im Jahr Sühne für die Nation '
          '(3. Mose 16).',
    ),
    QuizQuestion(
      text: 'Welches bekannte Gebot steht im „Heiligkeitsgesetz“ von '
          '3. Mose 19?',
      options: <String>[
        'Liebe deinen Nächsten wie dich selbst',
        'Stiehl kein Vieh',
        'Ruhe sieben Jahre lang',
        'Ehre den König',
      ],
      correctIndex: 0,
      explanation:
          '3. Mose 19:18 wird später von Jesus selbst zitiert.',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Herz', 'Fremder', 'vergeben'],
    ),
    QuizQuestion(
      text: 'Was war laut 3. Mose 17 beim Essen zu vermeiden?',
      options: <String>[
        'Blut zu essen',
        'Nachts zu essen',
        'Allein zu essen',
        'Brot zu essen',
      ],
      correctIndex: 0,
      explanation:
          'Blut zu essen ist verboten (3. Mose 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Blut'],
    ),
  ],
  'Leviticus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche jährlichen Feste werden in 3. Mose 23 aufgezählt?',
      options: <String>[
        'Passah, Pfingsten, Posaunenfest, Sühnetag, Laubhüttenfest',
        'Nur das Passah',
        'Nur das Neujahr',
        'Nur Fastentage',
      ],
      correctIndex: 0,
      explanation:
          'Der Festkalender umfasst das ganze religiöse Jahr '
          '(3. Mose 23).',
    ),
    QuizQuestion(
      text: 'Was sollte alle 50 Jahre im Jubeljahr geschehen?',
      options: <String>[
        'Das Land zurückgeben und hebräische Sklaven freilassen',
        'Die Ernte vernichten',
        'Einen neuen Hohen Priester wählen',
        'Das Gesetz überarbeiten',
      ],
      correctIndex: 0,
      explanation:
          'Das Jubeljahr stellt Land und Freiheit wieder her (3. Mose 25).',
    ),
    QuizQuestion(
      text: 'Was verspricht 3. Mose 26 für Treue zum Bund?',
      options: <String>[
        'Segen; Ungehorsam bringt Unglück',
        'Nichts Bestimmtes',
        'Sofortigen Reichtum ohne Bedingung',
        'Ständigen Krieg',
      ],
      correctIndex: 0,
      explanation:
          'Bedingte Segnungen und Flüche werden ausführlich beschrieben '
          '(3. Mose 26).',
    ),
  ],
  'Numbers#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum führte Israel in der Wüste Sinai eine Zählung durch?',
      options: <String>[
        'Um die wehrfähigen Männer zu zählen',
        'Um jede Familie zu besteuern',
        'Um einen König zu wählen',
        'Um Land aufzuteilen',
      ],
      correctIndex: 0,
      explanation:
          'Die Zählung erfasst wehrfähige Männer ab 20 Jahren '
          '(4. Mose 1).',
    ),
    QuizQuestion(
      text: 'Wer war für den Transport und den Dienst an der '
          'Stiftshütte zuständig?',
      options: <String>['Die Leviten', 'Nur die Priester', 'Die Ältesten', 'Die Krieger'],
      correctIndex: 0,
      explanation:
          'Die Leviten erhalten bestimmte Aufgaben für die Stiftshütte '
          '(4. Mose 3-4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Leviten'],
    ),
    QuizQuestion(
      text: 'Wozu war jemand verpflichtet, der das Nasiräergelübde '
          'ablegte?',
      options: <String>[
        'Auf Wein zu verzichten und sein Haar nicht zu schneiden',
        '40 Tage zu fasten',
        'Allein in der Wüste zu leben',
        'Sein ganzes Vieh zu opfern',
      ],
      correctIndex: 0,
      explanation:
          'Das Nasiräergelübde bringt besondere Einschränkungen mit sich '
          '(4. Mose 6).',
    ),
  ],
  'Numbers#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wen setzte Gott ein, um Mose die Last des Volkes tragen zu '
          'helfen?',
      options: <String>[
        '70 Älteste',
        'Die 12 Kundschafter',
        'Nur Aaron',
        'Nur Josua',
      ],
      correctIndex: 0,
      explanation:
          '70 Älteste erhalten den Geist, um die Verantwortung zu teilen '
          '(4. Mose 11).',
    ),
    QuizQuestion(
      text: 'Was geschah mit Mirjam und Aaron, nachdem sie Mose '
          'kritisiert hatten?',
      options: <String>[
        'Mirjam wurde aussätzig',
        'Sie wurden für immer verbannt',
        'Ihnen geschah nichts',
        'Sie verloren ihre Stimme',
      ],
      correctIndex: 0,
      explanation: 'Mirjam wird sieben Tage lang aussätzig (4. Mose 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aaron', 'Mose', 'Wolke'],
    ),
    QuizQuestion(
      text: 'Wie viele Kundschafter gaben einen ermutigenden Bericht '
          'über Kanaan?',
      options: <String>['Zwei (Josua und Kaleb)', 'Zwölf', 'Keiner', 'Fünf'],
      correctIndex: 0,
      explanation:
          'Nur Josua und Kaleb ermutigen das Volk hineinzugehen '
          '(4. Mose 13-14).',
    ),
  ],
  'Numbers#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wer lehnte sich gegen die Autorität von Mose und Aaron auf?',
      options: <String>['Korah und seine Anhänger', 'Josua', 'Kaleb', 'Bileam'],
      correctIndex: 0,
      explanation:
          'Korahs Aufstand wird von der Erde verschlungen '
          '(4. Mose 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Mose', 'Aaron', 'Erde'],
    ),
    QuizQuestion(
      text: 'Welches Zeichen bestätigte Aarons Auswahl als Hoher '
          'Priester?',
      options: <String>[
        'Sein Stab blühte',
        'Eine Stimme vom Himmel',
        'Feuer auf dem Altar',
        'Ein Stern',
      ],
      correctIndex: 0,
      explanation: 'Aarons Stab treibt aus und blüht (4. Mose 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aaron', 'Mandel', 'Zweig'],
    ),
    QuizQuestion(
      text: 'Warum durfte Mose das Land der Verheißung nicht betreten?',
      options: <String>[
        'Er schlug auf den Felsen, statt zu ihm zu sprechen',
        'Er missachtete einen militärischen Befehl',
        'Er betete einen Götzen an',
        'Er war zu alt',
      ],
      correctIndex: 0,
      explanation:
          'Mose schlägt im Zorn auf den Felsen und ehrt so Gottes '
          'Heiligkeit nicht (4. Mose 20).',
    ),
  ],
  'Numbers#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Wen heuerte Balak an, um Israel zu verfluchen?',
      options: <String>['Bileam', 'Korah', 'Og', 'Sihon'],
      correctIndex: 0,
      explanation:
          'Bileam wird gerufen, um Israel zu verfluchen, segnet es aber '
          '(4. Mose 23-24).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Wer handelte eifrig, um die Plage beim Abfall in Baal-Peor '
          'zu stoppen?',
      options: <String>['Pinehas', 'Josua', 'Nur Eleasar', 'Kaleb'],
      correctIndex: 0,
      explanation:
          'Pinehas greift ein und die Plage hört auf (4. Mose 25).',
    ),
    QuizQuestion(
      text: 'Wen setzte Mose als seinen Nachfolger ein?',
      options: <String>['Josua', 'Kaleb', 'Eleasar', 'Pinehas'],
      correctIndex: 0,
      explanation:
          'Josua wird vor Eleasar und der Versammlung eingesetzt '
          '(4. Mose 27).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Numbers#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Gegen welches Volk führte Israel einen Strafkrieg?',
      options: <String>['Midian', 'Edom', 'Ganz Moab', 'Ägypten'],
      correctIndex: 0,
      explanation: 'Der Krieg gegen Midian wird berichtet (4. Mose 31).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Welche Stämme baten darum, sich östlich des Jordan '
          'niederzulassen?',
      options: <String>[
        'Ruben, Gad und der halbe Stamm Manasse',
        'Juda und Benjamin',
        'Levi und Simeon',
        'Nur Ephraim',
      ],
      correctIndex: 0,
      explanation:
          'Diese Stämme erhalten Land im Osten, unter der Bedingung, bei '
          'der Eroberung zu helfen (4. Mose 32).',
    ),
    QuizQuestion(
      text: 'Wozu sollten die Zufluchtsstädte dienen?',
      options: <String>[
        'Als Zuflucht nach einer unabsichtlichen Tötung',
        'Als Regionalhauptstädte',
        'Als Handelszentren',
        'Nur als Anbetungsstätten',
      ],
      correctIndex: 0,
      explanation:
          'Zufluchtsstädte schützen jemanden, der ohne Absicht getötet '
          'hat (4. Mose 35).',
    ),
  ],
  'Deuteronomy#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches große Gebot wiederholt Mose in 5. Mose 6, bekannt '
          'als das Schema?',
      options: <String>[
        'Jehova ist einer, liebe ihn mit ganzem Herzen',
        'Iss kein Schweinefleisch',
        'Feiere jeden Neumond',
        'Arbeite niemals',
      ],
      correctIndex: 0,
      explanation:
          'Das Schema (5. Mose 6:4, 5) ist zentral für Israels Glauben.',
    ),
    QuizQuestion(
      text: 'Woran erinnert Mose in diesen Kapiteln bezüglich der Zehn '
          'Gebote?',
      options: <String>[
        'Er wiederholt sie vor dem Volk vor dem Einzug in Kanaan',
        'Er hebt sie auf',
        'Er fügt zehn weitere hinzu',
        'Er behält sie den Priestern vor',
      ],
      correctIndex: 0,
      explanation:
          'Mose wiederholt die Zehn Gebote (5. Mose 5).',
    ),
    QuizQuestion(
      text: 'Warum musste Israel vor den Nationen Kanaans auf der Hut '
          'sein?',
      options: <String>[
        'Wegen der Gefahr des Götzendienstes',
        'Wegen ihres Reichtums',
        'Wegen ihrer Sprache',
        'Wegen ihres Königs',
      ],
      correctIndex: 0,
      explanation:
          'Die Gefahr, ihre Götter zu übernehmen, wird betont '
          '(5. Mose 7).',
    ),
  ],
  'Deuteronomy#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Woran sollte die Erinnerung an das Manna in der Wüste '
          'Israel erinnern?',
      options: <String>[
        'Dass der Mensch nicht von Brot allein lebt, sondern vom Wort Gottes',
        'Dass Gott immer straft',
        'Dass die Wüste verflucht ist',
        'Dass Essen keine Rolle spielt',
      ],
      correctIndex: 0,
      explanation: '5. Mose 8:3, später von Jesus zitiert.',
    ),
    QuizQuestion(
      text: 'An welches Ereignis in der Wüste erinnert Mose, um vor '
          'Stolz zu warnen?',
      options: <String>[
        'Das goldene Kalb',
        'Der Durchzug durch das Rote Meer',
        'Die Gabe des Manna',
        'Der Bau der Stiftshütte',
      ],
      correctIndex: 0,
      explanation:
          'Das goldene Kalb steht für frühere Auflehnung (5. Mose 9).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['goldene Kalb', 'goldenes Kalb'],
    ),
    QuizQuestion(
      text: 'Wohin sollten die Israeliten laut 5. Mose 12 ihre Opfer '
          'bringen?',
      options: <String>[
        'Nur an den Ort, den Jehova erwählen würde',
        'Wohin sie wollten',
        'In jedes Dorf',
        'Nur nach Hause',
      ],
      correctIndex: 0,
      explanation:
          'Ein einziger Anbetungsort wird vorgeschrieben (5. Mose 12).',
    ),
  ],
  'Deuteronomy#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was sollte alle sieben Jahre mit Schulden geschehen?',
      options: <String>[
        'Sie erlassen (das Erlassjahr)',
        'Sie verdoppeln',
        'Sie an die Kinder weitergeben',
        'Nichts Besonderes',
      ],
      correctIndex: 0,
      explanation:
          'Das Erlassjahr tilgt die Schulden (5. Mose 15).',
    ),
    QuizQuestion(
      text: 'Welcher künftige Prophet wie Mose wird in 5. Mose 18 '
          'vorausgesagt?',
      options: <String>[
        'Ein Prophet, den Gott erwecken würde',
        'Ein fremder König',
        'Ein Engel',
        'Ein einzelner Richter',
      ],
      correctIndex: 0,
      explanation:
          'Diese Prophezeiung wird in den Christlichen Griechischen '
          'Schriften auf Christus angewandt (5. Mose 18).',
    ),
    QuizQuestion(
      text: 'Wie viele Zeugen waren nötig, um eine Anklage zu '
          'bestätigen?',
      options: <String>['Zwei oder drei', 'Einer genügte', 'Zehn', 'Keiner war nötig'],
      correctIndex: 0,
      explanation:
          'Das Gesetz verlangt mehrere Zeugen (5. Mose 19).',
    ),
  ],
  'Deuteronomy#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche jährliche Opfergabe erinnerte an die Befreiung aus '
          'Ägypten?',
      options: <String>[
        'Das Opfer der Erstlinge',
        'Das Jubeljahropfer',
        'Nur das Zehntenopfer',
        'Das Gedächtnismahl',
      ],
      correctIndex: 0,
      explanation:
          'Die Erklärung über die Erstlinge erinnert an den Auszug aus '
          'Ägypten (5. Mose 26).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Zehnter', 'Leviten', 'Korb'],
    ),
    QuizQuestion(
      text: 'Was sollten die Israeliten beim Einzug in Kanaan auf dem '
          'Berg Ebal tun?',
      options: <String>[
        'Einen Altar bauen und Segen und Flüche verkünden',
        'Einen Palast bauen',
        'Die Hauptstadt gründen',
        'Alle Bäume vernichten',
      ],
      correctIndex: 0,
      explanation:
          'Die Zeremonie auf den Bergen Garizim und Ebal wird eingesetzt '
          '(5. Mose 27).',
    ),
    QuizQuestion(
      text: 'Welcher Grundsatz bestimmte in diesen Kapiteln die Gesetze '
          'über Scheidung?',
      options: <String>[
        'Ein schriftlicher Scheidungsschein war erforderlich',
        'Scheidung war in jeder Form verboten',
        'Nur die Frau konnte sich scheiden lassen',
        'Es gab keine Regel',
      ],
      correctIndex: 0,
      explanation:
          'Das Gesetz regelt die Scheidung durch ein förmliches Dokument '
          '(5. Mose 24).',
    ),
  ],
  'Deuteronomy#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Was verspricht Kapitel 28 für Treue zum Bund?',
      options: <String>[
        'Segen; Ungehorsam bringt Flüche',
        'Nichts Konkretes',
        'Sofortigen Krieg',
        'Reichtum ohne Bedingung',
      ],
      correctIndex: 0,
      explanation:
          'Ausführliche Segnungen und Flüche (5. Mose 28).',
    ),
    QuizQuestion(
      text: 'Welche Wahl stellt Mose dem Volk in 5. Mose 30 vor?',
      options: <String>[
        'Leben und Tod, Segen und Fluch',
        'Bleiben oder nach Ägypten zurückkehren',
        'Aaron oder Josua zu dienen',
        'Eine Steuer zu zahlen oder nicht',
      ],
      correctIndex: 0,
      explanation:
          'Das Volk wird aufgefordert, „das Leben zu wählen“ '
          '(5. Mose 30:19).',
    ),
    QuizQuestion(
      text: 'Wo starb Mose, ohne das Land der Verheißung zu betreten?',
      options: <String>[
        'Auf dem Berg Nebo',
        'In Jericho',
        'Auf dem Berg Sinai',
        'In Bethlehem',
      ],
      correctIndex: 0,
      explanation:
          'Mose sieht das Land vom Gipfel des Nebo, bevor er stirbt '
          '(5. Mose 34).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Berg Nebo', 'Nebo'],
    ),
  ],
  'Joshua#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche Anweisung wiederholt Jehova zu Beginn des Buches '
          'gegenüber Josua?',
      options: <String>[
        'Sei stark und mutig',
        'Bleib verborgen',
        'Warte zehn Jahre',
        'Kehre nach Ägypten zurück',
      ],
      correctIndex: 0,
      explanation:
          'Jehova ermutigt Josua mehrfach (Josua 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ängstlich', 'Mose', 'Gesetz'],
    ),
    QuizQuestion(
      text: 'Wer versteckte die israelitischen Kundschafter in Jericho?',
      options: <String>['Rahab', 'Eine Prophetin', 'Der König selbst', 'Niemand'],
      correctIndex: 0,
      explanation: 'Rahab versteckt die Kundschafter auf ihrem Dach (Josua 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Wie fielen die Mauern von Jericho?',
      options: <String>[
        'Nach einem Umzug und dem Klang der Hörner',
        'Durch ein natürliches Erdbeben',
        'Nach einer monatelangen Belagerung',
        'Durch den Verrat eines Einwohners',
      ],
      correctIndex: 0,
      explanation:
          'Nach sieben Umrundungen und dem Klang der Hörner fallen die '
          'Mauern (Josua 6).',
    ),
  ],
  'Joshua#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie entgingen die Gibeoniter der Vernichtung?',
      options: <String>[
        'Indem sie sich als Reisende aus einem fernen Land ausgaben',
        'Indem sie zuerst angriffen',
        'Indem sie sofort Tribut zahlten',
        'Indem sie öffentlich übertraten',
      ],
      correctIndex: 0,
      explanation:
          'Ihre List bringt Israel dazu, einen Friedensvertrag mit ihnen '
          'zu schließen (Josua 9).',
    ),
    QuizQuestion(
      text: 'Was Außergewöhnliches geschah während der Schlacht gegen '
          'die fünf Amoriterkönige?',
      options: <String>[
        'Die Sonne stand still',
        'Es gab eine totale Finsternis',
        'Feuer regnete herab',
        'Ein Erdbeben trennte sie',
      ],
      correctIndex: 0,
      explanation:
          'Jehova kämpft für Israel und die Sonne steht still '
          '(Josua 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Mond', 'Hagel', 'Gibeon'],
    ),
    QuizQuestion(
      text: 'Welches Stück Land forderte Kaleb mit 85 Jahren?',
      options: <String>['Hebron', 'Jericho', 'Silo', 'Bethel'],
      correctIndex: 0,
      explanation:
          'Kaleb bleibt treu und erhält Hebron (Josua 14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Joshua#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wo wurde die Stiftshütte nach der ersten Eroberung '
          'aufgestellt?',
      options: <String>['In Silo', 'In Jerusalem', 'In Hebron', 'In Bethel'],
      correctIndex: 0,
      explanation:
          'Das Zelt der Zusammenkunft wird in Silo aufgestellt (Josua 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Silo'],
    ),
    QuizQuestion(
      text: 'Warum errichteten die östlichen Stämme einen Altar in der '
          'Nähe des Jordan?',
      options: <String>[
        'Als Zeuge dafür, dass sie zu Israel gehörten',
        'Um ihre Unabhängigkeit zu erklären',
        'Um einen anderen Gott anzubeten',
        'Auf Befehl eines fremden Königs',
      ],
      correctIndex: 0,
      explanation:
          'Der Altar ist ein Zeuge, keine konkurrierende Opferstätte '
          '(Josua 22).',
    ),
    QuizQuestion(
      text: 'Welche berühmte Erklärung gibt Josua vor seinem Tod in '
          'Sichem ab?',
      options: <String>[
        'Ich aber und mein Haus, wir werden Jehova dienen',
        'Wir kehren nach Ägypten zurück',
        'Ein König wird über uns herrschen',
        'Der Krieg wird immer weitergehen',
      ],
      correctIndex: 0,
      explanation:
          'Josua fordert das Volk auf zu wählen, wem es dienen will '
          '(Josua 24).',
    ),
  ],
  'Judges#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welcher Kreislauf wiederholt sich im ganzen Buch Richter?',
      options: <String>[
        'Untreue, Unterdrückung, Rufen zu Gott, Befreiung',
        'Immerwährender Friede',
        'Ständiger Bürgerkrieg',
        'Ständige Wanderung',
      ],
      correctIndex: 0,
      explanation:
          'Dieser Kreislauf strukturiert das ganze Buch (Richter 2).',
    ),
    QuizQuestion(
      text: 'Wer besiegte Sisera mit Deboras Hilfe?',
      options: <String>['Barak', 'Ehud', 'Otniel', 'Gideon'],
      correctIndex: 0,
      explanation:
          'Debora und Barak führen Israel zum Sieg (Richter 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Wie verkleinerte Gideon sein Heer auf 300 Mann?',
      options: <String>[
        'Indem er beobachtete, wie sie Wasser tranken',
        'Durch das Los',
        'Indem er die Jüngsten wählte',
        'Indem er die Reichsten wählte',
      ],
      correctIndex: 0,
      explanation:
          'Die Wasserprobe wählt 300 Mann aus (Richter 7).',
    ),
  ],
  'Judges#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was geschah, nachdem Abimelech sich zum König ausgerufen '
          'hatte?',
      options: <String>[
        'Er ermordete seine Brüder und kam später selbst um',
        'Er regierte lange in Frieden',
        'Er wurde ohne Gewalt vertrieben',
        'Er gründete eine dauerhafte Dynastie',
      ],
      correctIndex: 0,
      explanation:
          'Abimelech stirbt durch einen Mühlstein, den eine Frau wirft '
          '(Richter 9).',
    ),
    QuizQuestion(
      text: 'Welches tragische Gelübde legte Jephta vor der Schlacht ab?',
      options: <String>[
        'Den Ersten zu opfern, der aus seinem Haus käme',
        'Ein Jahr lang zu fasten',
        'Sein Haus zu zerstören',
        'Niemals zu heiraten',
      ],
      correctIndex: 0,
      explanation:
          'Seine Tochter kommt ihm als Erste entgegen (Richter 11).',
    ),
    QuizQuestion(
      text: 'Woran erkannte man die Ephraimiter am Jordanübergang?',
      options: <String>[
        'Sie konnten „Schibboleth“ nicht richtig aussprechen',
        'An ihrer Kleidung',
        'An ihrem singenden Akzent',
        'An ihren Waffen',
      ],
      correctIndex: 0,
      explanation:
          'Das Kennwort entlarvt die Fliehenden (Richter 12).',
    ),
  ],
  'Judges#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Mit welcher improvisierten Waffe besiegte Simson tausend '
          'Philister?',
      options: <String>[
        'Dem Kinnbacken eines Esels',
        'Einem Schwert',
        'Einer Schleuder',
        'Einem Stab',
      ],
      correctIndex: 0,
      explanation:
          'Simson erschlägt sie mit dem Kinnbacken eines Esels '
          '(Richter 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Schwert', 'Löwe', 'Philister'],
    ),
    QuizQuestion(
      text: 'Wer verriet den Philistern das Geheimnis von Simsons '
          'Kraft?',
      options: <String>['Delila', 'Seine Mutter', 'Ein rivalisierender Richter', 'Ein Priester'],
      correctIndex: 0,
      explanation:
          'Delila findet heraus, dass seine Kraft von seinem Haar kommt '
          '(Richter 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Welcher Satz fasst den Zustand Israels am Ende des Buches '
          'zusammen?',
      options: <String>[
        'Jeder tat, was in seinen eigenen Augen recht war',
        'Ein gerechter König regierte',
        'Überall herrschte Friede',
        'Die Priester regierten gut',
      ],
      correctIndex: 0,
      explanation:
          'Diese Bemerkung schließt mehrere Berichte des Buches ab '
          '(Richter 17, 21).',
    ),
  ],
  'Ruth#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum gingen Noomi und ihre Familie nach Moab?',
      options: <String>[
        'Wegen einer Hungersnot in Bethlehem',
        'Um vor einem Krieg zu fliehen',
        'Für Geschäfte',
        'Auf Befehl eines Richters',
      ],
      correctIndex: 0,
      explanation:
          'Die Hungersnot treibt Elimelech zur Auswanderung (Ruth 1).',
    ),
    QuizQuestion(
      text: 'Welche Entscheidung trifft Ruth in Bezug auf Noomi?',
      options: <String>[
        'Bei ihr zu bleiben: „Wohin du gehst, gehe ich“',
        'Zu ihrem eigenen Volk zurückzukehren',
        'Sofort in Moab neu zu heiraten',
        'Allein in Moab zu bleiben',
      ],
      correctIndex: 0,
      explanation:
          'Ruth drückt eine berühmte, treue Ergebenheit aus (Ruth 1:16).',
    ),
    QuizQuestion(
      text: 'Was wurde aus den Männern von Noomi und ihren '
          'Schwiegertöchtern?',
      options: <String>[
        'Sie starben alle in Moab',
        'Sie kehrten nach Bethlehem zurück',
        'Sie kamen in Moab zu Wohlstand',
        'Sie gründeten eine Stadt',
      ],
      correctIndex: 0,
      explanation:
          'Elimelech und dann seine beiden Söhne sterben in Moab (Ruth 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Bethlehem', 'Noomi', 'Hungersnot'],
    ),
  ],
  'Ruth#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was tat Ruth auf den Feldern von Boas?',
      options: <String>[
        'Sie las die von den Schnittern übrig gelassenen Ähren auf',
        'Sie verkaufte Stoffe',
        'Sie hütete Herden',
        'Sie lehrte das Gesetz',
      ],
      correctIndex: 0,
      explanation:
          'Ruth liest Ähren auf, um Noomi und sich zu ernähren (Ruth 2).',
    ),
    QuizQuestion(
      text: 'Wie zeigte Boas Ruth gegenüber Freundlichkeit?',
      options: <String>[
        'Indem er sie sicher auflesen ließ und sein Mahl mit ihr teilte',
        'Indem er sie höflich übersah',
        'Indem er sie vom Feld wegschickte',
        'Indem er Bezahlung verlangte',
      ],
      correctIndex: 0,
      explanation:
          'Boas beschützt Ruth und behandelt sie mit Gunst (Ruth 2).',
    ),
    QuizQuestion(
      text: 'Was rät Noomi Ruth in Bezug auf Boas?',
      options: <String>[
        'Zur Tenne zu gehen und sich ihm zu erkennen zu geben',
        'Ihn völlig zu meiden',
        'Nach Moab aufzubrechen',
        'Einen anderen Mann zu heiraten',
      ],
      correctIndex: 0,
      explanation:
          'Noomi führt Ruth zu einer möglichen Rückkaufung (Ruth 3).',
    ),
  ],
  'Ruth#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie regelte Boas die Frage des Rückkaufrechts vor den '
          'Ältesten?',
      options: <String>[
        'Ein näherer Verwandter verzichtete öffentlich auf sein Recht',
        'Ein Losentscheid regelte es',
        'Der König entschied',
        'Niemand wurde befragt',
      ],
      correctIndex: 0,
      explanation:
          'Die rechtliche Verhandlung findet am Stadttor statt (Ruth 4).',
    ),
    QuizQuestion(
      text: 'Wer war der Sohn von Ruth und Boas?',
      options: <String>['Obed', 'David', 'Isai', 'Salomo'],
      correctIndex: 0,
      explanation: 'Obed wird der Großvater Davids (Ruth 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Warum endet das Buch Ruth mit einem Geschlechtsregister?',
      options: <String>[
        'Um Ruth mit der Linie zu verbinden, die zu David führt',
        'Einfach als literarische Tradition',
        'Um eine Rechtsfrage abzuschließen',
        'Um Moab zu ehren',
      ],
      correctIndex: 0,
      explanation:
          'Das Geschlechtsregister verbindet Ruth mit David '
          '(Ruth 4:17-22).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesDeC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welcher Baum in der Mitte des Gartens Eden war Adam und '
          'Eva verboten?',
      options: <String>[
        'Der Baum der Erkenntnis von Gut und Böse',
        'Nur der Baum des Lebens',
        'Ein Feigenbaum',
        'Ein Olivenbaum',
      ],
      correctIndex: 0,
      explanation: 'Gott verbietet allein diesen einen Baum (1. Mose 2:17).',
    ),
    QuizQuestion(
      text: 'Wer verleitete Eva dazu, die verbotene Frucht zu essen?',
      options: <String>['Die Schlange', 'Kain', 'Ein Engel', 'Adam'],
      correctIndex: 0,
      explanation: 'Die Schlange verleitet sie zum Ungehorsam (1. Mose 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Schlange'],
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Welcher Vogel, den Noah aussandte, kam mit einem '
          'Olivenblatt zurück?',
      options: <String>['Die Taube', 'Der Rabe', 'Der Adler', 'Der Sperling'],
      correctIndex: 0,
      explanation:
          'Die Taube zeigt, dass das Wasser zurückging (1. Mose 8).',
    ),
    QuizQuestion(
      text: 'Wer segnete Abram als König von Salem und Priester des '
          'höchsten Gottes?',
      options: <String>['Melchisedek', 'Lot', 'Pharao', 'Isaak'],
      correctIndex: 0,
      explanation:
          'Melchisedek segnet Abram nach einem Sieg (1. Mose 14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Genesis#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Zeichen des Bundes gab Gott Abraham?',
      options: <String>['Die Beschneidung', 'Eine Tätowierung', 'Einen Ring', 'Einen Stab'],
      correctIndex: 0,
      explanation: 'Die Beschneidung kennzeichnet den Bund (1. Mose 17).',
    ),
    QuizQuestion(
      text: 'Wie hieß der Sohn von Abraham und Hagar?',
      options: <String>['Ismael', 'Isaak', 'Esau', 'Jakob'],
      correctIndex: 0,
      explanation:
          'Ismael wird der Magd Hagar geboren (1. Mose 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Welche Städte vernichtete Gott wegen ihrer Schlechtigkeit?',
      options: <String>['Sodom und Gomorra', 'Babel und Ur', 'Ninive und Tyrus', 'Bethel und Ai'],
      correctIndex: 0,
      explanation:
          'Feuer vernichtet diese Städte; Lot wird gerettet (1. Mose 19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Lot', 'Ägypten', 'Ninive'],
    ),
  ],
  'Genesis#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Was sollte Abraham nach Gottes Aufforderung auf dem Berg '
          'Moria darbringen?',
      options: <String>['Seinen Sohn Isaak', 'Einen Widder', 'Sein Zelt', 'Seine Herden'],
      correctIndex: 0,
      explanation:
          'Gott hält Abraham auf und stellt einen Widder bereit '
          '(1. Mose 22).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Isaak'],
    ),
    QuizQuestion(
      text: 'Wofür verkaufte Esau Jakob sein Erstgeburtsrecht?',
      options: <String>['Für ein Linsengericht', 'Für Gold', 'Für eine Herde', 'Für ein Zelt'],
      correctIndex: 0,
      explanation: 'Esau verachtet sein Erstgeburtsrecht (1. Mose 25).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Brot', 'Eintopf', 'Esau'],
    ),
    QuizQuestion(
      text: 'Was sah Jakob in Bethel in einem Traum?',
      options: <String>[
        'Eine Treppe bis zum Himmel mit Engeln darauf',
        'Ein tobendes Meer',
        'Einen brennenden Dornbusch',
        'Eine Stadt in Trümmern',
      ],
      correctIndex: 0,
      explanation:
          'Gott bestätigt Jakob seine Verheißungen (1. Mose 28).',
    ),
  ],
  'Genesis#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Welchen neuen Namen erhielt Jakob, nachdem er mit dem '
          'Engel gerungen hatte?',
      options: <String>['Israel', 'Edom', 'Abraham', 'Ephraim'],
      correctIndex: 0,
      explanation:
          'Der Name Israel bedeutet „er ringt mit Gott“ (1. Mose 32).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Wie viele Söhne hatte Jakob, die zu Stammvätern der Stämme '
          'Israels wurden?',
      options: <String>['Zwölf', 'Zehn', 'Sieben', 'Vierzehn'],
      correctIndex: 0,
      explanation:
          'Seine zwölf Söhne begründen die Stämme Israels (1. Mose 35).',
    ),
    QuizQuestion(
      text: 'Mit wem versöhnte sich Jakob nach Jahren der Trennung?',
      options: <String>['Seinem Bruder Esau', 'Laban', 'Pharao', 'Isaak'],
      correctIndex: 0,
      explanation:
          'Die beiden Brüder begegnen einander wieder in Frieden '
          '(1. Mose 33).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jakob', 'Laban', 'Josef'],
    ),
  ],
  'Genesis#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Was taten Josefs Brüder aus Neid?',
      options: <String>[
        'Sie verkauften ihn als Sklaven',
        'Sie krönten ihn zum König',
        'Sie ließen ihn in Ägypten zurück',
        'Sie ignorierten ihn',
      ],
      correctIndex: 0,
      explanation:
          'Josef wird verkauft und nach Ägypten gebracht (1. Mose 37).',
    ),
    QuizQuestion(
      text: 'Welches besondere Kleidungsstück hatte Jakob Josef '
          'gegeben?',
      options: <String>['Ein schönes Gewand', 'Eine Krone', 'Eine Rüstung', 'Einen Priestermantel'],
      correctIndex: 0,
      explanation:
          'Dieses Geschenk weckt den Neid seiner Brüder (1. Mose 37).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Mantel', 'Ring', 'Sandalen'],
    ),
    QuizQuestion(
      text: 'Was deutete Josef dem Pharao und sagte damit sieben '
          'Hungerjahre voraus?',
      options: <String>['Seine Träume', 'Ein altes Buch', 'Die Sterne', 'Ein Orakel'],
      correctIndex: 0,
      explanation:
          'Josef deutet die Träume des Pharao (1. Mose 41).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Träume'],
    ),
  ],
  'Genesis#6': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie behandelte Josef seine Brüder, als er sich ihnen zu '
          'erkennen gab?',
      options: <String>[
        'Er vergab ihnen',
        'Er sperrte sie lebenslang ein',
        'Er vertrieb sie',
        'Er ignorierte sie',
      ],
      correctIndex: 0,
      explanation:
          'Josef vergibt ihnen und sorgt für sie (1. Mose 45).',
    ),
    QuizQuestion(
      text: 'Wo ließen sich Jakob und seine Familie in Ägypten nieder?',
      options: <String>['Im Land Goschen', 'In Memphis', 'In Theben', 'Im Sinai'],
      correctIndex: 0,
      explanation:
          'Pharao gibt ihnen die Gegend Goschen (1. Mose 47).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Kanaan', 'Ägypten', 'Nil'],
    ),
    QuizQuestion(
      text: 'Wie sah Josef das Unrecht, das ihm seine Brüder angetan '
          'hatten?',
      options: <String>[
        'Gott hatte es zum Guten gewendet, um Leben zu retten',
        'Als ein Unrecht, das zu rächen war',
        'Als unbedeutend',
        'Als bloßen Zufall',
      ],
      correctIndex: 0,
      explanation: 'Eine berühmte Glaubensaussage (1. Mose 50:20).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wer war Moses Bruder, der als sein Sprecher eingesetzt '
          'wurde?',
      options: <String>['Aaron', 'Josua', 'Jethro', 'Kaleb'],
      correctIndex: 0,
      explanation: 'Aaron spricht für Mose zum Volk (2. Mose 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Mit welchem Namen stellte sich Gott Mose am brennenden '
          'Dornbusch vor?',
      options: <String>[
        '„Ich werde werden, was ich werden will“',
        '„Allein der Allmächtige“',
        '„Der verborgene Gott“',
        '„Der König der Könige“',
      ],
      correctIndex: 0,
      explanation:
          'Gott offenbart die Bedeutung seines Namens (2. Mose 3:14).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was war die zehnte und letzte Plage über Ägypten?',
      options: <String>[
        'Der Tod der Erstgeborenen',
        'Die Heuschrecken',
        'Die Finsternis',
        'Der Hagel',
      ],
      correctIndex: 0,
      explanation:
          'Diese Plage bringt Pharao endlich dazu, Israel ziehen zu '
          'lassen (2. Mose 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Plage', 'Heuschrecken', 'Hagel'],
    ),
    QuizQuestion(
      text: 'Was sollten die Israeliten beim Passah an ihre Türen '
          'streichen?',
      options: <String>['Lammblut', 'Öl', 'Mehl', 'Ein Aschezeichen'],
      correctIndex: 0,
      explanation:
          'Das Blut schützt ihre Erstgeborenen (2. Mose 12).',
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie kam am Horeb Wasser für das durstige Volk hervor?',
      options: <String>[
        'Mose schlug auf den Felsen',
        'Eine Quelle entsprang von selbst',
        'Es regnete stark',
        'Ein Brunnen wurde gegraben',
      ],
      correctIndex: 0,
      explanation:
          'Auf Gottes Befehl schlägt Mose auf den Felsen (2. Mose 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aaron', 'Stab', 'Wasser'],
    ),
    QuizQuestion(
      text: 'Aus wie vielen Geboten besteht der Dekalog, der am Sinai '
          'gegeben wurde?',
      options: <String>['Zehn', 'Sieben', 'Zwölf', 'Fünf'],
      correctIndex: 0,
      explanation:
          'Die Zehn Gebote werden am Sinai gegeben (2. Mose 20).',
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Was sollte die Bundeslade enthalten?',
      options: <String>[
        'Die Tafeln des Gesetzes',
        'Gold und Silber',
        'Prophetenrollen',
        'Speiseopfer',
      ],
      correctIndex: 0,
      explanation:
          'Die Tafeln der Gebote werden hineingelegt (2. Mose 25).',
    ),
    QuizQuestion(
      text: 'Wer machte das goldene Kalb, während Mose fort war?',
      options: <String>['Aaron', 'Josua', 'Hur', 'Bezalel'],
      correctIndex: 0,
      explanation:
          'Aaron gibt der Forderung des Volkes nach (2. Mose 32).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Was war an Moses Gesicht besonders, nachdem er mit Gott '
          'gesprochen hatte?',
      options: <String>['Es strahlte', 'Es war vor Trauer verhüllt', 'Es war gealtert', 'Nichts Besonderes'],
      correctIndex: 0,
      explanation:
          'Mose musste sein strahlendes Gesicht verhüllen (2. Mose 34).',
    ),
    QuizQuestion(
      text: 'Was erfüllte die Stiftshütte, als sie fertiggestellt war?',
      options: <String>[
        'Die Herrlichkeit Jehovas (eine Wolke)',
        'Nur Weihrauchrauch',
        'Künstliches Licht',
        'Nichts Sichtbares',
      ],
      correctIndex: 0,
      explanation:
          'Die Wolke zeigt die göttliche Gegenwart an (2. Mose 40).',
    ),
  ],
};
