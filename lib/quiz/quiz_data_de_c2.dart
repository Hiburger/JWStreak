import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesDeC2 = <String, List<QuizQuestion>>{
  '1 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Was versprach Hanna Jehova, wenn sie einen Sohn bekäme?',
      options: <String>[
        'Ihn Gott sein ganzes Leben lang zum Dienst zu weihen',
        'Ihm die Hälfte ihres Besitzes zu opfern',
        'Einen Tempel zu bauen',
        'Selbst Priesterin zu werden',
      ],
      correctIndex: 0,
      explanation:
          'Hanna weiht Samuel dem Dienst an der Stiftshütte (1. Samuel 1).',
    ),
    QuizQuestion(
      text: 'Wie rief Jehova den jungen Samuel?',
      options: <String>[
        'Indem er nachts mehrmals seinen Namen rief',
        'Durch einen sichtbaren Engel',
        'Durch einen einzigen Traum',
        'Durch eine öffentliche Stimme',
      ],
      correctIndex: 0,
      explanation: 'Samuel denkt zuerst, Eli rufe ihn (1. Samuel 3).',
    ),
    QuizQuestion(
      text: 'Warum baten die Israeliten Samuel um einen König?',
      options: <String>[
        'Um wie die anderen Nationen zu sein',
        'Auf Jehovas direkten Befehl',
        'Wegen einer unmittelbaren Invasion',
        'Weil Samuel es vorschlug',
      ],
      correctIndex: 0,
      explanation: 'Das Volk verwirft Gottes direkte Herrschaft (1. Samuel 8).',
    ),
  ],
  '1 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wen salbte Samuel heimlich zu Israels erstem König?',
      options: <String>['Saul', 'David', 'Jonathan', 'Abner'],
      correctIndex: 0,
      explanation: 'Samuel salbt Saul unter vier Augen (1. Samuel 9-10).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Was tat Saul in Gilgal, ohne auf Samuel zu warten?',
      options: <String>[
        'Er brachte das Opfer selbst dar',
        'Er verlor eine Schlacht',
        'Er weigerte sich zu regieren',
        'Er floh vor dem Feind',
      ],
      correctIndex: 0,
      explanation:
          'Saul ist ungehorsam und bringt das Opfer selbst dar '
          '(1. Samuel 13).',
    ),
    QuizQuestion(
      text: 'Warum wurde Saul von Jehova endgültig als König verworfen?',
      options: <String>[
        'Er war ungehorsam und verschonte Agag und das beste Vieh',
        'Er verlor eine kleine Schlacht',
        'Er alterte zu schnell',
        'Er bat Samuel um Hilfe',
      ],
      correctIndex: 0,
      explanation:
          'Sein Ungehorsam im Fall Amalek besiegelt seine Verwerfung '
          '(1. Samuel 15).',
    ),
  ],
  '1 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Mit welcher Waffe besiegte David Goliath?',
      options: <String>[
        'Eine Schleuder und ein Stein',
        'Ein Schwert',
        'Ein Speer',
        'Seine bloßen Hände',
      ],
      correctIndex: 0,
      explanation:
          'David lehnt die Rüstung ab und benutzt seine Schleuder '
          '(1. Samuel 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Schwert', 'Schild', 'Speer'],
    ),
    QuizQuestion(
      text:
          'Welches Gefühl trieb Saul dazu, David nach seinem Sieg töten '
          'zu wollen?',
      options: <String>[
        'Neid',
        'Angst vor den Philistern',
        'Samuels Zorn',
        'Jonathans Rat',
      ],
      correctIndex: 0,
      explanation:
          'Die Loblieder auf David machen Saul neidisch (1. Samuel 18).',
    ),
    QuizQuestion(
      text:
          'Wer half David, Saul zu entkommen, indem er ihn vor der '
          'Gefahr warnte?',
      options: <String>[
        'Jonathan',
        'Abner',
        'Nur Samuel',
        'Ein unbekannter Priester',
      ],
      correctIndex: 0,
      explanation:
          'Jonathan warnt David mit einem vereinbarten Zeichen '
          '(1. Samuel 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  '1 Samuel#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was tut David, als er die Gelegenheit hat, Saul in einer '
          'Höhle zu töten?',
      options: <String>[
        'Er verschont ihn und schneidet nur einen Zipfel seines Gewandes ab',
        'Er tötet ihn sofort',
        'Er flieht, ohne zu handeln',
        'Er verhandelt Frieden',
      ],
      correctIndex: 0,
      explanation:
          'David weigert sich, „den Gesalbten Jehovas“ anzutasten '
          '(1. Samuel 24).',
    ),
    QuizQuestion(
      text:
          'Wer verhinderte durch ihre Klugheit einen Konflikt zwischen '
          'David und Nabal?',
      options: <String>[
        'Abigail',
        'Michal',
        'Eine Dienerin',
        'Der Hohe Priester',
      ],
      correctIndex: 0,
      explanation: 'Abigail beruhigt David mit Vorräten (1. Samuel 25).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Wo sterben Saul und Jonathan in der letzten Schlacht des '
          'Buches?',
      options: <String>[
        'Auf dem Berg Gilboa, im Kampf gegen die Philister',
        'In Jerusalem',
        'In Hebron',
        'In Gibea',
      ],
      correctIndex: 0,
      explanation:
          'Saul und seine Söhne sterben auf dem Gilboa (1. Samuel 31).',
    ),
  ],
  '2 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie reagierte David auf den Tod von Saul und Jonathan?',
      options: <String>[
        'Er verfasste ein Trauerlied (eine Klage)',
        'Er freute sich',
        'Er ignorierte die Nachricht',
        'Er griff sofort an',
      ],
      correctIndex: 0,
      explanation: 'David verfasst „das Lied vom Bogen“ (2. Samuel 1).',
    ),
    QuizQuestion(
      text:
          'Welche Stadt eroberte David, um sie zu seiner Hauptstadt zu '
          'machen?',
      options: <String>['Jerusalem', 'Hebron', 'Silo', 'Gibea'],
      correctIndex: 0,
      explanation: 'David nimmt die Bergfeste Zion ein (2. Samuel 5).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Welche Verheißung gibt Jehova David durch den Propheten '
          'Nathan?',
      options: <String>[
        'Ein Nachkomme wird für immer regieren',
        'David selbst wird den Tempel bauen',
        'David wird ewig leben',
        'David wird Priester werden',
      ],
      correctIndex: 0,
      explanation: 'Der Davidsbund verheißt eine ewige Dynastie (2. Samuel 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tempel', 'Thron', 'Bund'],
    ),
  ],
  '2 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Mit wem beging David Ehebruch, was zum Mord an Uria führte?',
      options: <String>['Bathseba', 'Michal', 'Abigail', 'Tamar'],
      correctIndex: 0,
      explanation:
          'David lässt Uria töten, um seine Sünde zu verbergen '
          '(2. Samuel 11).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Wie stellte der Prophet Nathan David wegen seiner Sünde zur '
          'Rede?',
      options: <String>[
        'Durch ein Gleichnis von einem reichen und einem armen Mann',
        'Indem er ihn öffentlich anprangerte',
        'Durch einen anonymen Brief',
        'Indem er seinen Dienst verließ',
      ],
      correctIndex: 0,
      explanation:
          'Das Gleichnis bringt David dazu, sein Unrecht einzugestehen '
          '(2. Samuel 12).',
    ),
    QuizQuestion(
      text:
          'Welcher Sohn Davids ließ sich in Hebron zum König ausrufen '
          'und lehnte sich gegen ihn auf?',
      options: <String>['Absalom', 'Amnon', 'Salomo', 'Adonija'],
      correctIndex: 0,
      explanation: 'Absaloms Aufstand beginnt (2. Samuel 15).',
      type: QuizAnswerType.freeText,
    ),
  ],
  '2 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wessen Rat vereitelte Ahitophels schnellen Plan gegen David?',
      options: <String>[
        'Der von Huschai, der David treu blieb',
        'Der von Joab',
        'Der eines Priesters',
        'Der von Salomo',
      ],
      correctIndex: 0,
      explanation:
          'Huschai verzögert den Angriff und rettet David (2. Samuel 17).',
    ),
    QuizQuestion(
      text: 'Wie starb Absalom?',
      options: <String>[
        'Mit dem Kopf in einem Baum hängen geblieben, von Joab getötet',
        'Im Zweikampf gegen David',
        'Durch Gift',
        'Im Exil, an Altersschwäche',
      ],
      correctIndex: 0,
      explanation:
          'Absalom bleibt hängen, und Joab durchbohrt ihn (2. Samuel 18).',
    ),
    QuizQuestion(
      text:
          'Welche Tat Davids brachte gegen Ende des Buches eine Plage '
          'über Israel?',
      options: <String>[
        'Eine Zählung des Volkes',
        'Der Bau eines Palastes',
        'Eine verbotene Ehe',
        'Eine Weigerung zu opfern',
      ],
      correctIndex: 0,
      explanation:
          'Die Zählung missfällt Gott, und eine Plage folgt '
          '(2. Samuel 24).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Plage', 'Altar', 'Joab'],
    ),
  ],
  '1 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welcher Sohn Davids rief sich zum König aus, als David alt '
          'geworden war?',
      options: <String>['Adonija', 'Absalom', 'Nur Joab', 'Nathan'],
      correctIndex: 0,
      explanation:
          'Adonija ruft sich ohne Davids Zustimmung zum König aus '
          '(1. Könige 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Worum bittet Salomo Jehova ganz zu Beginn seiner Regierung?',
      options: <String>[
        'Um ein verständiges Herz, um das Volk zu richten',
        'Um Reichtum vor allem anderen',
        'Um militärischen Sieg',
        'Um ein langes Leben, ohne jede Bedingung',
      ],
      correctIndex: 0,
      explanation: 'Salomo bittet um Weisheit, was Gott gefällt (1. Könige 3).',
    ),
    QuizQuestion(
      text: 'Wer half Salomo mit Material für den Tempelbau?',
      options: <String>[
        'Hiram, der König von Tyrus',
        'Der Pharao von Ägypten',
        'Die Königin von Saba',
        'Der König von Moab',
      ],
      correctIndex: 0,
      explanation: 'Hiram liefert Zedernholz und Handwerker (1. Könige 5).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Hiram'],
    ),
  ],
  '1 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was geschieht, als der Tempel fertiggestellt und eingeweiht '
          'wird?',
      options: <String>[
        'Jehovas Herrlichkeit erfüllt den Tempel',
        'Es kommt zu einem Erdbeben',
        'Das Volk lehnt sich auf',
        'Salomo verlässt Jerusalem',
      ],
      correctIndex: 0,
      explanation: 'Die Wolke der Herrlichkeit erfüllt das Haus (1. Könige 8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Wolke', 'Lade', 'Priester'],
    ),
    QuizQuestion(
      text: 'Warum wurde Salomos Königreich geistig schließlich schwach?',
      options: <String>[
        'Seine ausländischen Frauen wandten sein Herz ab',
        'Er verlor einen Krieg',
        'Er wurde verbannt',
        'Ihm fehlte Reichtum',
      ],
      correctIndex: 0,
      explanation:
          'Der Götzendienst seiner Frauen führt ihn zur Untreue '
          '(1. Könige 11).',
    ),
    QuizQuestion(
      text:
          'Was tut Jerobeam nach der Teilung des Reiches, damit das '
          'Volk nicht nach Jerusalem geht?',
      options: <String>[
        'Er stellt goldene Kälber in Bethel und Dan auf',
        'Er zerstört alle Straßen',
        'Er verbietet jede Anbetung',
        'Er baut einen identischen neuen Tempel',
      ],
      correctIndex: 0,
      explanation:
          'Jerobeam führt eine konkurrierende Götzenanbetung ein '
          '(1. Könige 12).',
    ),
  ],
  '1 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wer kündigte König Ahab eine strafende Dürre an?',
      options: <String>['Elia', 'Elisa', 'Micha', 'Obadja'],
      correctIndex: 0,
      explanation:
          'Elia kündigt an, dass es weder Regen noch Tau geben wird '
          '(1. Könige 17).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Was geschah beim Wettstreit auf dem Berg Karmel?',
      options: <String>[
        'Jehovas Feuer verzehrte Elias Opfer',
        'Zuerst fiel ein plötzlicher Regen',
        'Die Baalspropheten gewannen',
        'Nichts geschah',
      ],
      correctIndex: 0,
      explanation: 'Jehova antwortet vor ganz Israel mit Feuer (1. Könige 18).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Baal', 'Altar', 'Wasser'],
    ),
    QuizQuestion(
      text: 'Warum ließen Ahab und Isebel Naboth töten?',
      options: <String>[
        'Um seinen Weinberg an sich zu reißen',
        'Wegen eines Verbrechens, das er begangen hatte',
        'Wegen einer unbezahlten Schuld',
        'Auf Befehl eines Propheten',
      ],
      correctIndex: 0,
      explanation:
          'Isebel inszeniert einen falschen Prozess gegen Naboth '
          '(1. Könige 21).',
    ),
  ],
  '2 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie verließ Elia die Erde?',
      options: <String>[
        'Er wurde in einem Sturmwind zum Himmel emporgehoben',
        'Er starb an Altersschwäche',
        'Er wurde verbannt',
        'Er verschwand ohne Erklärung',
      ],
      correctIndex: 0,
      explanation:
          'Elisa sieht, wie Elia im Sturmwind emporgehoben wird '
          '(2. Könige 2).',
    ),
    QuizQuestion(
      text: 'Welches Wunder wirkte Elisa für die Schunemiterin?',
      options: <String>[
        'Er erweckte ihren Sohn wieder zum Leben',
        'Er vermehrte ihre Herde',
        'Er heilte sie von Aussatz',
        'Er baute ihr Haus wieder auf',
      ],
      correctIndex: 0,
      explanation:
          'Elisa gibt dem Kind der Schunemiterin das Leben zurück '
          '(2. Könige 4).',
    ),
    QuizQuestion(
      text: 'Wie wurde Naaman von seinem Aussatz geheilt?',
      options: <String>[
        'Indem er sich siebenmal im Jordan wusch',
        'Mit einer besonderen Salbe',
        'Durch ein gemeinsames Gebet',
        'Durch langes Fasten',
      ],
      correctIndex: 0,
      explanation:
          'Naaman befolgt trotz seiner Skepsis Elisas Anweisung '
          '(2. Könige 5).',
    ),
  ],
  '2 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie wurde die Belagerung Samarias unerwartet aufgehoben?',
      options: <String>[
        'Das syrische Heer floh, erschreckt durch ein Geräusch',
        'Ein verbündetes Heer traf ein',
        'Ein Waffenstillstand wurde geschlossen',
        'Der syrische König fiel im Kampf',
      ],
      correctIndex: 0,
      explanation:
          'Jehova lässt ein Geräusch entstehen, das den Feind in Panik '
          'versetzt (2. Könige 7).',
    ),
    QuizQuestion(
      text: 'Wen beseitigte Jehu, um Israels Königshaus zu säubern?',
      options: <String>[
        'Joram, Isebel und das Haus Ahabs',
        'Nur die Baalspropheten',
        'Die Könige von Juda',
        'Die Assyrer',
      ],
      correctIndex: 0,
      explanation:
          'Jehu vollstreckt das angekündigte Urteil gegen das Haus Ahabs '
          '(2. Könige 9-10).',
    ),
    QuizQuestion(
      text: 'Wie wurde der junge Joas geschützt, bevor er König wurde?',
      options: <String>[
        'Von seiner Tante im Tempel versteckt',
        'Ins Ausland geschickt',
        'Von einem einzelnen Propheten aufgezogen',
        'Vom assyrischen Heer beschützt',
      ],
      correctIndex: 0,
      explanation: 'Joas entgeht dem Massaker Athaljas (2. Könige 11).',
    ),
  ],
  '2 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was wird nach der assyrischen Belagerung aus dem Nordreich '
          '(Israel)?',
      options: <String>[
        'Samaria fällt und das Volk wird deportiert',
        'Es erobert Assyrien',
        'Es schließt einen dauerhaften Frieden',
        'Es ändert sich nichts Wesentliches',
      ],
      correctIndex: 0,
      explanation:
          'Der Fall Samarias bedeutet das Ende des Nordreiches '
          '(2. Könige 17).',
    ),
    QuizQuestion(
      text: 'Wie reagierte Hiskia auf Sanheribs Drohbrief?',
      options: <String>[
        'Er breitete ihn vor Jehova aus und betete',
        'Er ergab sich ohne Widerstand',
        'Er floh aus der Stadt',
        'Er ignorierte die Drohung',
      ],
      correctIndex: 0,
      explanation:
          'Hiskias Gebet geht der wunderbaren Befreiung voraus '
          '(2. Könige 19).',
    ),
    QuizQuestion(
      text:
          'Was geschah mit dem assyrischen Heer, das Jerusalem '
          'belagerte?',
      options: <String>[
        'Ein Engel erschlug in einer Nacht eine große Zahl von ihnen',
        'Es wurde im Kampf besiegt',
        'Es zog einfach ab',
        'Eine Seuche schwächte es langsam',
      ],
      correctIndex: 0,
      explanation: 'Göttliches Eingreifen rettet Jerusalem (2. Könige 19).',
    ),
  ],
  '2 Kings#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was entdeckte der Hohe Priester Hilkia während der Regierung '
          'Josias?',
      options: <String>[
        'Das Buch des Gesetzes, das im Tempel verloren gegangen war',
        'Einen Goldschatz',
        'Ein Königsgrab',
        'Eine neue Wasserquelle',
      ],
      correctIndex: 0,
      explanation: 'Der Fund löst Josias religiöse Reform aus (2. Könige 22).',
    ),
    QuizQuestion(
      text: 'Welches große Fest feierte Josia nach seiner Reform?',
      options: <String>[
        'Das Passah',
        'Das Laubhüttenfest',
        'Pfingsten',
        'Das Jubeljahr',
      ],
      correctIndex: 0,
      explanation: 'Ein denkwürdiges Passah wird gefeiert (2. Könige 23).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Passah'],
    ),
    QuizQuestion(
      text: 'Wie endet die Geschichte Judas im Buch der Könige?',
      options: <String>[
        'Mit dem Fall Jerusalems und der Zerstörung des Tempels',
        'Mit der Krönung eines gerechten, dauerhaften Königs',
        'Mit einem großen militärischen Sieg',
        'Mit einer sofortigen Rückkehr aus dem Exil',
      ],
      correctIndex: 0,
      explanation:
          'Der Bericht schließt mit dem Exil in Babylon (2. Könige 25).',
    ),
  ],
  '1 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Mit welchen Geschlechtsregistern beginnt dieses Buch?',
      options: <String>[
        'Von Adam bis zu den zwölf Stämmen Israels',
        'Nur mit Davids Linie',
        'Nur mit den Priestern',
        'Mit den Königen Ägyptens',
      ],
      correctIndex: 0,
      explanation: 'Die Listen reichen bis Adam zurück (1. Chronika 1-2).',
    ),
    QuizQuestion(
      text: 'Aus welchem Stamm stammt Davids Königslinie?',
      options: <String>['Juda', 'Levi', 'Benjamin', 'Ephraim'],
      correctIndex: 0,
      explanation:
          'Judas Geschlechtsregister umfasst das Haus David '
          '(1. Chronika 2-3).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Welche Stämme ließen sich laut diesen Geschlechtsregistern '
          'östlich des Jordan nieder?',
      options: <String>[
        'Ruben, Gad und der halbe Stamm Manasse',
        'Juda und Benjamin',
        'Levi und Simeon',
        'Dan und Naphtali',
      ],
      correctIndex: 0,
      explanation:
          'Ihr Gebiet und ihre Oberhäupter werden aufgezeichnet '
          '(1. Chronika 5).',
    ),
  ],
  '1 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum starb Usa beim Transport der Lade?',
      options: <String>[
        'Er berührte sie beim Rutschen, entgegen Gottes Anweisungen',
        'Er stahl sie',
        'Er weigerte sich, sie zu tragen',
        'Er verspottete den Zug',
      ],
      correctIndex: 0,
      explanation:
          'Der Transport folgte nicht Gottes Anweisungen '
          '(1. Chronika 13).',
    ),
    QuizQuestion(
      text:
          'Wie wurde die Lade schließlich richtig nach Jerusalem '
          'gebracht?',
      options: <String>[
        'Von den Leviten getragen, wie das Gesetz es vorschrieb',
        'Auf einem von Rindern gezogenen Wagen',
        'Mit dem Schiff',
        'Von ägyptischen Priestern',
      ],
      correctIndex: 0,
      explanation: 'David korrigiert den früheren Fehler (1. Chronika 15).',
    ),
    QuizQuestion(
      text: 'Über wen errang David in diesen Kapiteln bedeutende Siege?',
      options: <String>[
        'Die Philister',
        'Die Ägypter',
        'Die Babylonier',
        'Die Perser',
      ],
      correctIndex: 0,
      explanation: 'David besiegt die Philister mehrmals (1. Chronika 14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Philister'],
    ),
  ],
  '1 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welches Lied vertraute David Asaph an, als die Lade '
          'aufgestellt wurde?',
      options: <String>[
        'Ein Lied des Lobes und des Dankes',
        'Ein Trauerlied',
        'Eine Unheilsprophezeiung',
        'Ein Kriegslied',
      ],
      correctIndex: 0,
      explanation: 'Dieser Lobpsalm wird Asaph anvertraut (1. Chronika 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Klagelied', 'Psalm', 'Trompete'],
    ),
    QuizQuestion(
      text: 'Warum konnte David den Tempel nicht selbst bauen?',
      options: <String>[
        'Er hatte im Krieg viel Blut vergossen',
        'Ihm fehlte Reichtum',
        'Er hatte keinen Plan',
        'Das Volk war dagegen',
      ],
      correctIndex: 0,
      explanation:
          'Jehova behält diese Aufgabe Salomo vor (1. Chronika 22; 28).',
    ),
    QuizQuestion(
      text: 'Wo kaufte David den Platz für den künftigen Tempel?',
      options: <String>[
        'Die Tenne Ornans (Arauna)',
        'Ein Feld bei Hebron',
        'Einen Hügel in Silo',
        'Land, das Hiram schenkte',
      ],
      correctIndex: 0,
      explanation:
          'David baut dort nach der Plage einen Altar (1. Chronika 21).',
    ),
  ],
  '1 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie ordnete David den Dienst der Leviten?',
      options: <String>[
        'In Gruppen mit bestimmten zugewiesenen Aufgaben',
        'Sie hatten überhaupt keine Ordnung',
        'Ein Mann erledigte alles',
        'Sie wurden vom Dienst befreit',
      ],
      correctIndex: 0,
      explanation:
          'Die Leviten werden nach Aufgaben eingeteilt (1. Chronika 23).',
    ),
    QuizQuestion(
      text: 'Welche Rolle hatten die von David eingesetzten Musiker?',
      options: <String>[
        'Zu prophezeien und mit Instrumenten zu loben',
        'An vorderster Front zu kämpfen',
        'Rechtsfälle zu richten',
        'Nur Lesen zu unterrichten',
      ],
      correctIndex: 0,
      explanation:
          'Asaph, Heman und Jeduthun leiten die heilige Musik '
          '(1. Chronika 25).',
    ),
    QuizQuestion(
      text:
          'Was war Davids letzte große öffentliche Handlung vor seinem '
          'Tod?',
      options: <String>[
        'Salomo und das Volk zum Tempelbau aufzufordern',
        'Einen letzten Krieg zu führen',
        'Alle Gesetze zu überarbeiten',
        'Freiwillig ins Exil zu gehen',
      ],
      correctIndex: 0,
      explanation:
          'David betet und segnet die Versammlung vor seinem Tod '
          '(1. Chronika 28-29).',
    ),
  ],
  '2 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Worum bittet Salomo Jehova zu Beginn seiner Regierung?',
      options: <String>[
        'Weisheit und Erkenntnis zum Regieren',
        'Reichtum vor allem anderen',
        'Ein mächtiges Heer',
        'Ein Leben ohne Schwierigkeiten',
      ],
      correctIndex: 0,
      explanation:
          'Seine Bitte gefällt Gott, der ihm auch Reichtum gibt '
          '(2. Chronika 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Reichtum', 'Ehre', 'Tempel'],
    ),
    QuizQuestion(
      text: 'Was geschah bei der Einweihung des Tempels?',
      options: <String>[
        'Feuer kam vom Himmel herab und Herrlichkeit erfüllte das Haus',
        'Ein Erdbeben zerstörte alles',
        'Es geschah nichts Besonderes',
        'Das Volk zerstreute sich',
      ],
      correctIndex: 0,
      explanation:
          'Eine eindrucksvolle Erscheinung bestätigt die göttliche '
          'Anerkennung (2. Chronika 7).',
    ),
    QuizQuestion(
      text: 'Welches Gebet spricht Salomo bei der Einweihung?',
      options: <String>[
        'Eine Bitte, dass Gott die zu diesem Ort hin gerichteten Gebete erhört',
        'Eine Bitte um mehr Reichtum',
        'Eine Kriegserklärung',
        'Ein Trauerlied',
      ],
      correctIndex: 0,
      explanation:
          'Salomo bittet Gott, vom Himmel her zu hören (2. Chronika 6).',
    ),
  ],
  '2 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wer besuchte Salomo, um seine Weisheit zu prüfen?',
      options: <String>[
        'Die Königin von Saba',
        'Der König von Assyrien',
        'Der Pharao von Ägypten',
        'Der König von Tyrus',
      ],
      correctIndex: 0,
      explanation:
          'Sie ist von seiner Weisheit und seinem Reichtum beeindruckt '
          '(2. Chronika 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Salomo', 'Ägypten', 'Tyrus'],
    ),
    QuizQuestion(
      text: 'Warum teilte sich das Reich unter Rehabeam?',
      options: <String>[
        'Seine Weigerung, die von Salomo auferlegte Last zu erleichtern',
        'Eine ausländische Invasion',
        'Der plötzliche Tod des Königs',
        'Eine friedliche Teilungsvereinbarung',
      ],
      correctIndex: 0,
      explanation:
          'Seine Härte treibt zehn Stämme dazu, Jerobeam zu folgen '
          '(2. Chronika 10).',
    ),
    QuizQuestion(
      text: 'Wie reagierte Asa auf den äthiopischen Einfall?',
      options: <String>[
        'Er betete vor der Schlacht zu Jehova und siegte',
        'Er ergab sich kampflos',
        'Er floh mit seinem Heer',
        'Er zahlte einen hohen Tribut',
      ],
      correctIndex: 0,
      explanation: 'Sein Vertrauen auf Gott wird belohnt (2. Chronika 14).',
    ),
  ],
  '2 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Krankheit traf Asa, nachdem er es versäumt hatte, '
          'Jehova zu suchen?',
      options: <String>[
        'Eine schwere Krankheit an den Füßen',
        'Aussatz',
        'Blindheit',
        'Vollständige Lähmung',
      ],
      correctIndex: 0,
      explanation: 'Er befragt Ärzte statt Gott (2. Chronika 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Augen', 'Hände', 'Aussatz'],
    ),
    QuizQuestion(
      text: 'Warum wurde Josaphat von einem Propheten zurechtgewiesen?',
      options: <String>[
        'Wegen seines Bündnisses mit dem bösen König Ahab',
        'Weil er den Tempel vernachlässigte',
        'Weil er sich weigerte, in den Krieg zu ziehen',
        'Weil er die Feste abschaffte',
      ],
      correctIndex: 0,
      explanation: 'Sein Bündnis mit Ahab wird kritisiert (2. Chronika 19).',
    ),
    QuizQuestion(
      text: 'Wie errang Josaphat einen Sieg, ohne zu kämpfen?',
      options: <String>[
        'Durch Gebet, während seine Feinde sich gegeneinander wandten',
        'Durch einen ausgehandelten Waffenstillstand',
        'Durch einen strategischen Rückzug',
        'Durch einen Vertrag mit Ägypten',
      ],
      correctIndex: 0,
      explanation:
          'Vertrauen auf Gott geht einer wunderbaren Befreiung voraus '
          '(2. Chronika 20).',
    ),
  ],
  '2 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie wurde der junge Joas vor Athaljas Massaker gerettet?',
      options: <String>[
        'Von seiner Tante im Tempel versteckt',
        'Heimlich ins Ausland geschickt',
        'Von einem fremden Priester adoptiert',
        'Von einem verbündeten Heer beschützt',
      ],
      correctIndex: 0,
      explanation:
          'Joscheba versteckt ihn bis zu seiner Krönung '
          '(2. Chronika 22-23).',
    ),
    QuizQuestion(
      text: 'Warum wurde Usija mit Aussatz geschlagen?',
      options: <String>[
        'Er wollte Räucherwerk darbringen, eine Aufgabe der Priester',
        'Er weigerte sich, den Zehnten zu zahlen',
        'Er beleidigte einen Propheten',
        'Er vernachlässigte das Heer',
      ],
      correctIndex: 0,
      explanation:
          'Sein Stolz bringt ihn dazu, seine Rolle zu überschreiten '
          '(2. Chronika 26).',
    ),
    QuizQuestion(
      text: 'Was tut Hiskia ganz zu Beginn seiner Regierung?',
      options: <String>[
        'Er öffnet und reinigt den Tempel wieder',
        'Er erklärt Assyrien den Krieg',
        'Er schafft alle Feste ab',
        'Er verlegt die Hauptstadt',
      ],
      correctIndex: 0,
      explanation:
          'Hiskia beginnt eine große religiöse Reform (2. Chronika 29).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Altar', 'Passah', 'Tore'],
    ),
  ],
  '2 Chronicles#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welches große Fest organisierte Hiskia nach der Reinigung '
          'des Tempels?',
      options: <String>[
        'Ein außergewöhnliches Passah',
        'Das Laubhüttenfest',
        'Das Jubeljahr',
        'Pfingsten',
      ],
      correctIndex: 0,
      explanation:
          'Dieses Passah versammelt Juda und einen Teil Israels '
          '(2. Chronika 30).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Passah', 'das Passah'],
    ),
    QuizQuestion(
      text:
          'Was geschah, nachdem Manasse in der Gefangenschaft bereut '
          'hatte?',
      options: <String>[
        'Jehova brachte ihn nach Jerusalem zurück und er führte Reformen durch',
        'Er blieb lebenslang gefangen',
        'Er wurde hingerichtet',
        'Es änderte sich nichts',
      ],
      correctIndex: 0,
      explanation:
          'Seine aufrichtige Reue verändert sein Geschick '
          '(2. Chronika 33).',
    ),
    QuizQuestion(
      text: 'Wie endet das Buch der Chronika?',
      options: <String>[
        'Mit dem Erlass des Cyrus, der die Rückkehr und den Wiederaufbau '
            'des Tempels erlaubt',
        'Mit endgültiger, hoffnungsloser Zerstörung',
        'Mit der Krönung eines neuen davidischen Königs',
        'Mit einem langen Bürgerkrieg',
      ],
      correctIndex: 0,
      explanation:
          'Der Erlass des Cyrus öffnet den Weg zur Rückkehr aus dem Exil '
          '(2. Chronika 36).',
    ),
  ],
  'Ezra#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wer erlaubte den Verbannten, zurückzukehren und den Tempel '
          'wieder aufzubauen?',
      options: <String>[
        'Cyrus, der König von Persien',
        'Nebukadnezar',
        'Nur Darius',
        'Xerxes',
      ],
      correctIndex: 0,
      explanation: 'Cyrus erlässt eine befreiende Verordnung (Esra 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Cyrus', 'Kyros'],
    ),
    QuizQuestion(
      text:
          'Was taten die Zurückgekehrten sofort, noch bevor der Tempel '
          'fertig war?',
      options: <String>[
        'Sie bauten den Altar wieder auf, um zu opfern',
        'Sie wählten einen neuen König',
        'Sie griffen ihre Nachbarn an',
        'Sie lehnten jede Anbetung ab',
      ],
      correctIndex: 0,
      explanation:
          'Der Altar wird vor der Grundsteinlegung wiederhergestellt '
          '(Esra 3).',
    ),
    QuizQuestion(
      text:
          'Welche gemischte Reaktion folgte auf die Grundsteinlegung '
          'des neuen Tempels?',
      options: <String>[
        'Freude bei vielen, Weinen bei den Alten, die den ersten '
            'Tempel gesehen hatten',
        'Allgemeine Gleichgültigkeit',
        'Einhelliger Zorn',
        'Das Volk floh',
      ],
      correctIndex: 0,
      explanation:
          'Der Gegensatz zu Salomos Tempel rührt die Alten zu Tränen '
          '(Esra 3).',
    ),
  ],
  'Ezra#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie wurden die Bauarbeiten unterbrochen?',
      options: <String>[
        'Örtliche Gegner erzwangen einen Baustopp',
        'Ein Erdbeben zerstörte alles',
        'Dem Volk ging das Material aus',
        'Die Arbeiter gingen von selbst',
      ],
      correctIndex: 0,
      explanation: 'Politischer Widerstand stoppt das Vorhaben (Esra 4).',
    ),
    QuizQuestion(
      text:
          'Wer ermutigte durch seine Prophezeiungen zur Wiederaufnahme '
          'der Tempelarbeiten?',
      options: <String>[
        'Haggai und Sacharja',
        'Hesekiel und Daniel',
        'Jesaja und Jeremia',
        'Hosea und Amos',
      ],
      correctIndex: 0,
      explanation: 'Ihre Botschaften treiben den Bau wieder voran (Esra 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Esra', 'Nehemia', 'Daniel'],
    ),
    QuizQuestion(
      text:
          'Wer kam später mit einer weiteren Gruppe Verbannter aus '
          'Babylon?',
      options: <String>[
        'Esra, Priester und Abschreiber',
        'Nehemia',
        'Serubbabel',
        'Mordechai',
      ],
      correctIndex: 0,
      explanation: 'Esra kommt während der Regierung Artaxerxes an (Esra 7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Esra'],
    ),
  ],
  'Ezra#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum bat Esra nicht um bewaffnete Begleitung für die Reise?',
      options: <String>[
        'Er hatte sein Vertrauen auf Gottes Schutz ausgedrückt',
        'Der König hatte sie ihm verweigert',
        'Die Reise war ungefährlich',
        'Er hatte bereits ein Heer',
      ],
      correctIndex: 0,
      explanation: 'Esra hatte von Gottes Schutz Zeugnis abgelegt (Esra 8).',
    ),
    QuizQuestion(
      text: 'Welches Problem betrübte Esra bei seiner Ankunft zutiefst?',
      options: <String>[
        'Ehen mit Frauen aus den umliegenden Nationen',
        'Ein Mangel an Opfergaben',
        'Eine Hungersnot',
        'Ein Bürgerkrieg',
      ],
      correctIndex: 0,
      explanation: 'Esra zerreißt vor Kummer seine Kleider (Esra 9).',
    ),
    QuizQuestion(
      text: 'Wie reagierte das Volk auf Esras Appell?',
      options: <String>[
        'Es bekannte sein Unrecht und brachte die Lage in Ordnung',
        'Es lehnte jede Änderung ab',
        'Es vertrieb Esra',
        'Es ignorierte den Appell',
      ],
      correctIndex: 0,
      explanation: 'Eine gemeinsame Reform findet statt (Esra 10).',
    ),
  ],
  'Nehemiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie reagierte Nehemia, als er vom Zustand der Mauern '
          'Jerusalems erfuhr?',
      options: <String>[
        'Er weinte, fastete und betete',
        'Er blieb gleichgültig',
        'Er trat von seinem Posten zurück',
        'Er veranstaltete ein Fest',
      ],
      correctIndex: 0,
      explanation: 'Sein Kummer bewegt ihn zum Handeln (Nehemia 1).',
    ),
    QuizQuestion(
      text: 'Worum bat Nehemia König Artaxerxes?',
      options: <String>[
        'Die Erlaubnis, die Mauern wieder aufzubauen',
        'Gold für sich selbst',
        'Eine höhere Stellung bei Hof',
        'Die Freiheit, den Dienst des Königs zu verlassen',
      ],
      correctIndex: 0,
      explanation:
          'Der König stimmt zu und stellt ihm Mittel bereit (Nehemia 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tempel', 'König', 'Jerusalem'],
    ),
    QuizQuestion(
      text: 'Wie reagierten die Bauleute auf Spott und Drohungen?',
      options: <String>[
        'Sie arbeiteten mit einer Hand und hielten mit der anderen eine '
            'Waffe',
        'Sie stoppten das Vorhaben',
        'Sie flohen aus der Stadt',
        'Sie verhandelten mit den Gegnern',
      ],
      correctIndex: 0,
      explanation:
          'Wachsamkeit und Entschlossenheit prägen die Arbeit (Nehemia 4).',
    ),
  ],
  'Nehemiah#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche soziale Ungerechtigkeit prangerte Nehemia unter dem '
          'Volk an?',
      options: <String>[
        'Wucherdarlehen, die die Armen verarmen ließen',
        'Die Weigerung, den Zehnten zu zahlen',
        'Allein die Missachtung des Sabbats',
        'Bestechlichkeit unter den Richtern',
      ],
      correctIndex: 0,
      explanation: 'Nehemia stellt diese ungerechte Praxis ab (Nehemia 5).',
    ),
    QuizQuestion(
      text: 'In welcher Zeit wurde die Mauer Jerusalems fertiggestellt?',
      options: <String>['52 Tage', 'Ein Jahr', 'Zehn Jahre', 'Eine Woche'],
      correctIndex: 0,
      explanation:
          'Eine bemerkenswerte Leistung trotz starken Widerstands '
          '(Nehemia 6).',
    ),
    QuizQuestion(
      text: 'Was geschah, als Esra dem Volk das Gesetz öffentlich vorlas?',
      options: <String>[
        'Das Volk weinte zuerst und feierte dann voller Freude',
        'Das Volk lehnte sich auf',
        'Niemand hörte zu',
        'Die Lesung wurde unterbrochen',
      ],
      correctIndex: 0,
      explanation:
          'Das Laubhüttenfest folgt auf diese bewegende Lesung '
          '(Nehemia 8).',
    ),
  ],
  'Nehemiah#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was tat das Volk nach der Gesetzeslesung und dem nationalen '
          'Bekenntnis?',
      options: <String>[
        'Es unterzeichnete eine schriftliche Verpflichtung, Gott zu gehorchen',
        'Es verließ Jerusalem',
        'Es schaffte die Feste ab',
        'Es verbannte die Priester',
      ],
      correctIndex: 0,
      explanation:
          'Ein schriftlicher Bund besiegelt diese Verpflichtung '
          '(Nehemia 9-10).',
    ),
    QuizQuestion(
      text: 'Wie wurde die Einweihung der Mauer gefeiert?',
      options: <String>[
        'Mit Umzügen voller Gesang und Danksagung',
        'Mit einem stillen Fasten',
        'Mit einer militärischen Zeremonie',
        'Indem man die Tore schloss',
      ],
      correctIndex: 0,
      explanation: 'Zwei Chöre ziehen singend um die Mauer (Nehemia 12).',
    ),
    QuizQuestion(
      text:
          'Welche Reform setzte Nehemia während seines zweiten '
          'Aufenthalts in Jerusalem durch?',
      options: <String>[
        'Strenge Sabbatbeachtung und die Ausweisung Tobijas',
        'Die Abschaffung des Tempels',
        'Eine neue Volkszählung',
        'Den Bau eines Palastes',
      ],
      correctIndex: 0,
      explanation:
          'Nehemia stellt mehrere Missstände ab, die während seiner '
          'Abwesenheit zurückgekehrt waren (Nehemia 13).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesDeC2 =
    <String, List<QuizQuestion>>{};
