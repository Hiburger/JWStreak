import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesDeC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wer kündigte das Kommen Jesu an, indem er in der Wildnis predigte?',
      options: <String>['Johannes der Täufer', 'Elia', 'Jesaja', 'Sacharja'],
      correctIndex: 0,
      explanation:
          'Johannes der Täufer bereitet den Weg für Jesus (Matthäus 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jesus', 'Elia', 'Petrus'],
    ),
    QuizQuestion(
      text: 'Wie lange fastete Jesus, bevor er vom Teufel versucht wurde?',
      options: <String>['40 Tage', '7 Tage', '3 Tage', '100 Tage'],
      correctIndex: 0,
      explanation: 'Jesus fastet 40 Tage und 40 Nächte (Matthäus 4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['vierzig Tage'],
    ),
    QuizQuestion(
      text: 'Wer wird laut der Bergpredigt glücklich genannt?',
      options: <String>[
        'Wer sich seiner geistigen Bedürftigkeit bewusst ist',
        'Die Reichen',
        'Die Mächtigen',
        'Die Berühmten',
      ],
      correctIndex: 0,
      explanation:
          'Die Seligpreisungen beginnen mit denen, die sich ihres geistigen Bedürfnisses bewusst sind (Matthäus 5:3).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie viele Brote und Fische benutzte Jesus, um etwa 5.000 Männer zu speisen?',
      options: <String>[
        '5 Brote und 2 Fische',
        '2 Brote und 5 Fische',
        '7 Brote',
        '12 Brote',
      ],
      correctIndex: 0,
      explanation: 'Jesus vermehrt 5 Brote und 2 Fische (Matthäus 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Brot', 'Körbe', 'zwölf'],
    ),
    QuizQuestion(
      text: 'Was tat Petrus, als er Jesus auf dem Wasser gehen sah?',
      options: <String>[
        'Er versuchte ebenfalls, auf dem Wasser zu gehen',
        'Er versteckte sich',
        'Er floh',
        'Er tat nichts',
      ],
      correctIndex: 0,
      explanation:
          'Petrus geht auf Jesus zu, beginnt aber aus Mangel an Glauben zu sinken (Matthäus 14).',
    ),
    QuizQuestion(
      text: 'Wer verlangte den Kopf von Johannes dem Täufer auf einer Platte?',
      options: <String>[
        'Die Tochter der Herodias',
        'Herodes selbst',
        'Ein Soldat',
        'Pilatus',
      ],
      correctIndex: 0,
      explanation:
          'Die Tänzerin, angestiftet von ihrer Mutter, verlangt Johannes\' Kopf (Matthäus 14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Salome', 'die Tochter der Herodias'],
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie antwortete Petrus, als Jesus fragte: „Wer, sagt ihr, bin ich?“',
      options: <String>[
        'Du bist der Christus, der Sohn des lebendigen Gottes',
        'Du bist Elia',
        'Du bist ein Prophet',
        'Ich weiß es nicht',
      ],
      correctIndex: 0,
      explanation: 'Petrus erkennt Jesus als den Christus (Matthäus 16).',
    ),
    QuizQuestion(
      text: 'Was geschah bei der Verklärung?',
      options: <String>[
        'Jesu Gesicht leuchtete wie die Sonne',
        'Jesus verschwand',
        'Ein Sturm brach los',
        'Jesus lief auf dem Wasser',
      ],
      correctIndex: 0,
      explanation:
          'Jesus wird vor Petrus, Jakobus und Johannes verklärt (Matthäus 17).',
    ),
    QuizQuestion(
      text: 'Auf welchem Tier ritt Jesus in Jerusalem ein?',
      options: <String>[
        'Auf einem jungen Esel',
        'Auf einem weißen Pferd',
        'Auf einem Kamel',
        'Er ging zu Fuß',
      ],
      correctIndex: 0,
      explanation:
          'Jesus zieht reitend auf einem jungen Esel ein und erfüllt damit eine Prophezeiung (Matthäus 21).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Pferd', 'Kamel', 'Wagen'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was führte Jesus bei seiner letzten Mahlzeit mit seinen Aposteln ein?',
      options: <String>[
        'Das Gedächtnismahl seines Todes',
        'Ein jährliches Erntefest',
        'Ein gemeinsames Fasten',
        'Eine Pilgerreise',
      ],
      correctIndex: 0,
      explanation:
          'Jesus führt das Gedächtnismahl mit Brot und Wein ein (Matthäus 26).',
    ),
    QuizQuestion(
      text: 'Wer verriet Jesus für dreißig Silberstücke?',
      options: <String>['Judas Iskariot', 'Petrus', 'Thomas', 'Barabbas'],
      correctIndex: 0,
      explanation: 'Judas verrät Jesus (Matthäus 26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Judas'],
    ),
    QuizQuestion(
      text: 'Was geschah am dritten Tag nach Jesu Tod?',
      options: <String>[
        'Er wurde auferweckt',
        'Der Tempel wurde zerstört',
        'Er fuhr zum Himmel auf',
        'Nichts Besonderes',
      ],
      correctIndex: 0,
      explanation: 'Jesus wird am dritten Tag auferweckt (Matthäus 28).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Grab', 'Engel', 'Stein'],
    ),
  ],
  'John#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wer war laut Johannes 1 „das Wort“ (der Logos), das im Anfang bei Gott war?',
      options: <String>[
        'Der Sohn Gottes, bevor er Mensch wurde',
        'Ein Engel',
        'Mose',
        'Der heilige Geist',
      ],
      correctIndex: 0,
      explanation:
          'Das Wort war bei Gott und wird in Jesus Fleisch (Johannes 1).',
    ),
    QuizQuestion(
      text: 'Was war Jesu erstes Wunder, vollbracht in Kana?',
      options: <String>[
        'Wasser in Wein zu verwandeln',
        'Einen Blinden zu heilen',
        'Eine Menschenmenge zu speisen',
        'Einen Sturm zu beruhigen',
      ],
      correctIndex: 0,
      explanation:
          'Jesus verwandelt bei einer Hochzeit Wasser in Wein (Johannes 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Kana', 'Brot', 'Öl'],
    ),
    QuizQuestion(
      text:
          'Was muss ein Mensch laut Jesus tun, um „das Königreich Gottes zu sehen“?',
      options: <String>[
        'Neu geboren werden',
        '40 Tage fasten',
        'Zum Tempel gehen',
        'Priester werden',
      ],
      correctIndex: 0,
      explanation: 'Jesus erklärt dies Nikodemus (Johannes 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Nikodemus', 'Geist', 'Fleisch'],
    ),
  ],
  'John#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie beschreibt sich Jesus in Johannes 10 selbst?',
      options: <String>[
        'Der vortreffliche Hirte',
        'Der Löwe',
        'Der Hohe Priester',
        'Der Richter',
      ],
      correctIndex: 0,
      explanation:
          'Jesus stellt sich als vortrefflicher Hirte dar, der sein Leben für seine Schafe gibt (Johannes 10).',
    ),
    QuizQuestion(
      text: 'Wen erweckte Jesus nach vier Tagen im Grab wieder zum Leben?',
      options: <String>[
        'Lazarus',
        'Jairus',
        'Den Sohn der Witwe',
        'Einen Hauptmann',
      ],
      correctIndex: 0,
      explanation: 'Jesus erweckt Lazarus wieder (Johannes 11).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Was tat Jesus für seine Apostel vor der letzten Mahlzeit als Beispiel der Demut?',
      options: <String>[
        'Er wusch ihnen die Füße',
        'Er segnete sie einzeln',
        'Er teilte seinen Besitz',
        'Er betete öffentlich für jeden Einzelnen',
      ],
      correctIndex: 0,
      explanation: 'Jesus wäscht seinen Jüngern die Füße (Johannes 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Hände', 'Brot', 'Becken'],
    ),
  ],
  'John#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Womit vergleicht Jesus seine Beziehung zu seinen Jüngern in Johannes 15?',
      options: <String>[
        'Mit einem Weinstock und seinen Zweigen',
        'Mit einem Hirten und seiner Herde',
        'Mit einem König und seinen Untertanen',
        'Mit einem Vater und seinen Kindern',
      ],
      correctIndex: 0,
      explanation:
          'Jesus ist der Weinstock, seine Jünger die Zweige (Johannes 15).',
    ),
    QuizQuestion(
      text: 'Wer schlug einem Mann bei Jesu Festnahme das Ohr ab?',
      options: <String>['Petrus', 'Johannes', 'Jakobus', 'Andreas'],
      correctIndex: 0,
      explanation: 'Petrus trifft Malchus mit einem Schwert (Johannes 18).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Wer zweifelte zuerst an der Auferstehung, bevor er Jesu Wunden berührte?',
      options: <String>['Thomas', 'Petrus', 'Johannes', 'Philippus'],
      correctIndex: 0,
      explanation: 'Thomas zweifelt und glaubt dann (Johannes 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wer bereitet zu Beginn des Markusevangeliums den Weg vor Jesus vor?',
      options: <String>[
        'Johannes der Täufer',
        'Elia persönlich',
        'Ein Engel',
        'Der Hohe Priester',
      ],
      correctIndex: 0,
      explanation: 'Johannes tauft und kündigt Jesu Kommen an (Markus 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Johannes'],
    ),
    QuizQuestion(
      text:
          'Wie zeigte Jesus seine Vollmacht, als er den durch das Dach heruntergelassenen Gelähmten heilte?',
      options: <String>[
        'Indem er ihm zuerst die Sünden vergab, bevor er ihn heilte',
        'Indem er zuerst ein Opfer verlangte',
        'Indem er ihn ohne Antwort wegschickte',
        'Indem er zuerst die Pharisäer befragte',
      ],
      correctIndex: 0,
      explanation:
          'Die Vergebung geht der körperlichen Heilung voraus (Markus 2).',
    ),
    QuizQuestion(
      text: 'Was beschreibt das Gleichnis vom Sämann in Markus 4?',
      options: <String>[
        'Verschiedene Reaktionen auf das Wort Gottes',
        'Eine einfache Lektion in Landwirtschaft',
        'Ein Gericht gegen Bauern',
        'Eine Prophezeiung über eine Hungersnot',
      ],
      correctIndex: 0,
      explanation:
          'Die verschiedenen Bodenarten veranschaulichen unterschiedliche Herzen (Markus 4).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was geschah, als die fünftausend gespeist wurden?',
      options: <String>[
        'Fünf Brote und zwei Fische reichten aus, mit Resten übrig',
        'Jeder hatte sein eigenes Essen mitgebracht',
        'Die Menge ging hungrig fort',
        'Ein behelfsmäßiger Markt wurde aufgebaut',
      ],
      correctIndex: 0,
      explanation: 'Ein Wunder der Vermehrung (Markus 6).',
    ),
    QuizQuestion(
      text:
          'Welche außergewöhnliche Szene findet auf dem Berg in Markus 9 statt?',
      options: <String>[
        'Die Verklärung Jesu',
        'Ein Erdbeben',
        'Ein heftiger Sturm',
        'Ein öffentliches Gericht',
      ],
      correctIndex: 0,
      explanation:
          'Jesus erscheint in Herrlichkeit mit Mose und Elia (Markus 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Taufe', 'Mose', 'Berg'],
    ),
    QuizQuestion(
      text: 'Wie zieht Jesus in Markus 11 in Jerusalem ein?',
      options: <String>[
        'Reitend auf einem jungen Esel, von der Menge bejubelt',
        'Heimlich, ungesehen',
        'Mit einem Heer',
        'Zu Pferd wie ein Eroberer',
      ],
      correctIndex: 0,
      explanation:
          'Der triumphale Einzug erfüllt eine Prophezeiung (Markus 11).',
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches große Gebot nennt Jesus in Markus 12?',
      options: <String>[
        'Gott mit ganzem Herzen zu lieben und den Nächsten wie sich selbst',
        'Steuern gewissenhaft zu zahlen',
        'Jede Woche zu fasten',
        'Jeden Kontakt mit Fremden zu meiden',
      ],
      correctIndex: 0,
      explanation:
          'Jesus fasst das Gesetz in zwei Geboten zusammen (Markus 12).',
    ),
    QuizQuestion(
      text: 'Was führte Jesus bei der letzten Mahlzeit mit seinen Jüngern ein?',
      options: <String>[
        'Das Gedächtnismahl seines Todes',
        'Ein neues jährliches Fest',
        'Ein gemeinsames Fasten',
        'Eine verpflichtende Pilgerreise',
      ],
      correctIndex: 0,
      explanation:
          'Das Brot und der Wein symbolisieren sein Opfer (Markus 14).',
    ),
    QuizQuestion(
      text: 'Was entdecken die Frauen, die am dritten Tag zum Grab kommen?',
      options: <String>[
        'Das Grab ist leer, Jesus ist auferweckt worden',
        'Jesu Leichnam ist noch dort',
        'Das Grab ist versiegelt und unzugänglich',
        'Nichts Ungewöhnliches',
      ],
      correctIndex: 0,
      explanation:
          'Ein junger Mann in weißem Gewand verkündet ihnen die Auferstehung (Markus 16:5, 6).',
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wer kündigt Maria an, dass sie die Mutter Jesu sein wird?',
      options: <String>[
        'Der Engel Gabriel',
        'Ein Priester',
        'Johannes der Täufer',
        'Nur ein Traum',
      ],
      correctIndex: 0,
      explanation: 'Gabriel kündigt die wunderbare Geburt an (Lukas 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Gabriel'],
    ),
    QuizQuestion(
      text:
          'Wer legte bei der Darstellung im Tempel Zeugnis über das Kind Jesus ab?',
      options: <String>[
        'Simeon und Hanna',
        'Herodes',
        'Die Oberpriester',
        'Niemand',
      ],
      correctIndex: 0,
      explanation: 'Zwei betagte Treue erkennen den Messias (Lukas 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Maria', 'Josef', 'Zacharias'],
    ),
    QuizQuestion(
      text: 'Welche berühmte Rede hält Jesus in Lukas 6?',
      options: <String>[
        'Die Feldrede mit Segnungen und Weherufen',
        'Eine Rede über Steuern',
        'Eine Kriegserklärung',
        'Ein Gericht gegen Rom',
      ],
      correctIndex: 0,
      explanation: 'Eine bedeutende sittliche Lehre (Lukas 6).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welches berühmte Gleichnis veranschaulicht in Lukas 10 die Nächstenliebe?',
      options: <String>[
        'Der barmherzige Samariter',
        'Der verlorene Sohn',
        'Der Sämann',
        'Die zehn Jungfrauen',
      ],
      correctIndex: 0,
      explanation:
          'Ein Beispiel des Mitgefühls gegenüber einem Fremden (Lukas 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Priester', 'Levit', 'Räuber'],
    ),
    QuizQuestion(
      text:
          'Welche drei Gleichnisse erzählt Jesus in Lukas 15 über Verlorenes?',
      options: <String>[
        'Das verlorene Schaf, die verlorene Münze, der verlorene Sohn',
        'Der Sämann, das Netz, die Perle',
        'Der Feigenbaum, der Weinstock, der Weizen',
        'Die Talente, die Minen, der Schatz',
      ],
      correctIndex: 0,
      explanation: 'Drei Bilder der Freude über das Wiederfinden (Lukas 15).',
    ),
    QuizQuestion(
      text:
          'Was enthüllt das Gleichnis vom reichen Mann und Lazarus in Lukas 16?',
      options: <String>[
        'Einen Gegensatz zwischen Gleichgültigkeit und Mitgefühl',
        'Eine Lektion in Landwirtschaft',
        'Praktischen Finanzrat',
        'Eine Prophezeiung über Rom',
      ],
      correctIndex: 0,
      explanation: 'Ein Gleichnis über die Prioritäten des Herzens (Lukas 16).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was tut Zachäus, um seine Lebensänderung nach der Begegnung mit Jesus zu zeigen?',
      options: <String>[
        'Er erstattet denen, die er betrogen hatte, das Vierfache zurück',
        'Er verlässt die Stadt',
        'Er ignoriert Jesus schließlich',
        'Er weigert sich, seinen Besitz zu teilen',
      ],
      correctIndex: 0,
      explanation:
          'Seine Großzügigkeit veranschaulicht seine aufrichtige Bekehrung (Lukas 19).',
    ),
    QuizQuestion(
      text: 'Worum bittet der reuige Verbrecher Jesus am Pfahl?',
      options: <String>[
        'Sich seiner in seinem Königreich zu erinnern',
        'Ihn sofort zu befreien',
        'Seine Ankläger zu bestrafen',
        'Seine Macht öffentlich zu beweisen',
      ],
      correctIndex: 0,
      explanation: 'Jesus verheißt ihm das Paradies (Lukas 23).',
    ),
    QuizQuestion(
      text: 'Was geschieht auf dem Weg nach Emmaus nach der Auferstehung?',
      options: <String>[
        'Der auferweckte Jesus erklärt zwei Jüngern die Schriften',
        'Die Jünger werden verhaftet',
        'Ein Engel verbietet jede Reise',
        'Nichts Besonderes geschieht',
      ],
      correctIndex: 0,
      explanation: 'Sie erkennen ihn, als er das Brot teilt (Lukas 24).',
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Was verheißt Jesus seinen Jüngern kurz vor seiner Himmelfahrt?',
      options: <String>[
        'Sie werden die Kraft des heiligen Geistes empfangen',
        'Sie werden sofort über Rom herrschen',
        'Sie werden ihn nie wiedersehen',
        'Sie müssen sofort fliehen',
      ],
      correctIndex: 0,
      explanation:
          'Eine wesentliche Verheißung vor Pfingsten (Apostelgeschichte 1).',
    ),
    QuizQuestion(
      text: 'Was geschah am Pfingsttag?',
      options: <String>[
        'Der heilige Geist wurde über die Jünger ausgegossen',
        'Ein Erdbeben zerstörte den Tempel',
        'Die Apostel flohen aus Jerusalem',
        'Nichts Ungewöhnliches geschah',
      ],
      correctIndex: 0,
      explanation:
          'Die christliche Versammlung beginnt an diesem Tag (Apostelgeschichte 2).',
    ),
    QuizQuestion(
      text: 'Wer wurde der erste christliche Märtyrer?',
      options: <String>['Stephanus', 'Petrus', 'Jakobus allein', 'Philippus'],
      correctIndex: 0,
      explanation:
          'Stephanus wird nach seiner Rede gesteinigt (Apostelgeschichte 7).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie wurde Saulus auf dem Weg nach Damaskus verwandelt?',
      options: <String>[
        'Ein Licht und eine Stimme von Jesus bekehrten ihn',
        'Er änderte einfach von sich aus seine Meinung',
        'Ein König zwang ihn zur Änderung',
        'Auf diesem Weg geschah nichts',
      ],
      correctIndex: 0,
      explanation:
          'Seine Begegnung mit Jesus verändert sein Leben (Apostelgeschichte 9).',
    ),
    QuizQuestion(
      text: 'Welche Vision erhält Petrus, bevor er Kornelius trifft?',
      options: <String>[
        'Ein großes Tuch mit Tieren, das Offenheit gegenüber Nichtjuden bedeutet',
        'Eine himmlische Schlacht',
        'Einen brennenden Tempel',
        'Einen bedeutungslosen Traum',
      ],
      correctIndex: 0,
      explanation:
          'Diese Vision bereitet Petrus darauf vor, den Nationen die gute Botschaft zu predigen (Apostelgeschichte 10).',
    ),
    QuizQuestion(
      text: 'Wo wurden die Jünger zum ersten Mal „Christen“ genannt?',
      options: <String>['In Antiochia', 'In Jerusalem', 'In Rom', 'In Ephesus'],
      correctIndex: 0,
      explanation:
          'Dieser Name erscheint zum ersten Mal in Antiochia (Apostelgeschichte 11:26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Antiochia'],
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche wichtige Entscheidung trifft die Jerusalemer Körperschaft bezüglich nichtjüdischer Bekehrter?',
      options: <String>[
        'Sie müssen nicht gemäß dem Gesetz beschnitten werden',
        'Sie müssen dem ganzen Gesetz Moses folgen',
        'Sie werden aus der Versammlung ausgeschlossen',
        'Es wird keine Entscheidung getroffen',
      ],
      correctIndex: 0,
      explanation:
          'Eine wichtige Entscheidung für die Ausbreitung des Christentums (Apostelgeschichte 15).',
    ),
    QuizQuestion(
      text:
          'Was geschah mit Paulus und Silas, die in Philippi gefangen gehalten wurden?',
      options: <String>[
        'Ein Erdbeben öffnete die Gefängnistüren',
        'Sie entkamen heimlich',
        'Sie blieben lebenslang eingesperrt',
        'Niemand griff ein',
      ],
      correctIndex: 0,
      explanation: 'Ein Wunder befreit die Gefangenen (Apostelgeschichte 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Ketten', 'Gefängniswärter', 'Silas'],
    ),
    QuizQuestion(
      text: 'Wo hielt Paulus seine berühmte Rede über den „Unbekannten Gott“?',
      options: <String>[
        'Auf dem Areopag, in Athen',
        'In Rom',
        'In Jerusalem',
        'In Korinth',
      ],
      correctIndex: 0,
      explanation:
          'Paulus spricht zu den griechischen Philosophen (Apostelgeschichte 17).',
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was erzählt Paulus in seiner Verteidigung nach seiner Festnahme im Tempel?',
      options: <String>[
        'Seine Bekehrung auf dem Weg nach Damaskus',
        'Einen militärischen Sieg',
        'Eine Geschäftsreise',
        'Einen persönlichen Streit',
      ],
      correctIndex: 0,
      explanation:
          'Paulus bezeugt seine persönliche Erfahrung (Apostelgeschichte 22).',
    ),
    QuizQuestion(
      text: 'Warum berief sich Paulus auf den Kaiser?',
      options: <String>[
        'Um als römischer Bürger ein faires Verfahren zu erhalten',
        'Um jedem Verfahren zu entgehen',
        'Um sofort freigelassen zu werden',
        'Weil er den Dienst verlassen wollte',
      ],
      correctIndex: 0,
      explanation:
          'Sein Status als römischer Bürger gibt ihm dieses Recht (Apostelgeschichte 25).',
    ),
    QuizQuestion(
      text: 'Was geschah nach dem Schiffbruch auf der Insel Malta?',
      options: <String>[
        'Paulus wurde von einer Viper gebissen, ohne Schaden zu nehmen',
        'Er wurde von den Bewohnern festgenommen',
        'Das Schiff fuhr sofort wieder los',
        'Nichts Besonderes geschah',
      ],
      correctIndex: 0,
      explanation:
          'Paulus bleibt trotz des Viperbisses unversehrt, zur Verwunderung der Inselbewohner (Apostelgeschichte 28).',
    ),
  ],
};

const Map<String, List<QuizQuestion>>
extraQuizzesDeC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Mustergebet gab Jesus in der Bergpredigt?',
      options: <String>[
        'Das „Vaterunser“',
        'Eine lange Liste von Gelübden',
        'Ein verbotenes Geheimgebet',
        'Kein bestimmtes Gebet',
      ],
      correctIndex: 0,
      explanation: 'Jesus lehrt, einfach zu beten (Matthäus 6).',
    ),
    QuizQuestion(
      text:
          'Womit wird laut Matthäus 7 der Mensch verglichen, der Jesu Worte in die Tat umsetzt?',
      options: <String>[
        'Mit einem Mann, der sein Haus auf den Felsen baut',
        'Mit einem Mann, der auf Sand baut',
        'Mit einem ziellosen Reisenden',
        'Mit einem König ohne Königreich',
      ],
      correctIndex: 0,
      explanation:
          'Das Haus auf dem Felsen übersteht die Stürme (Matthäus 7:24).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was tat Jesus während eines Sturms auf dem See Galiläa?',
      options: <String>[
        'Er beruhigte ihn mit einem Wort',
        'Er ruderte schneller',
        'Er wartete ab',
        'Er floh ans Ufer',
      ],
      correctIndex: 0,
      explanation: 'Der Wind und das Meer gehorchen ihm (Matthäus 8).',
    ),
    QuizQuestion(
      text:
          'Wie viele Apostel wählte Jesus aus und sandte sie aus, um zu predigen?',
      options: <String>['Zwölf', 'Sieben', 'Siebzig', 'Drei'],
      correctIndex: 0,
      explanation: 'Die zwölf Apostel werden namentlich genannt (Matthäus 10).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie oft sollst du deinem Bruder laut Matthäus 18 vergeben?',
      options: <String>[
        'Bis zu 77-mal',
        'Nur dreimal',
        'Nur einmal',
        'Niemals',
      ],
      correctIndex: 0,
      explanation: 'Jesus lehrt unbegrenzte Vergebung (Matthäus 18:22).',
    ),
    QuizQuestion(
      text: 'Was tat Jesus, als er den Tempel in Jerusalem betrat?',
      options: <String>[
        'Er vertrieb die Händler',
        'Er brachte ein Opfer dar',
        'Er versteckte sich',
        'Er krönte einen Priester',
      ],
      correctIndex: 0,
      explanation: 'Jesus reinigt den Tempel (Matthäus 21).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tempel', 'Geld', 'Tauben'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Zeichen kündigte Jesus für den Abschluss des Systems der Dinge in Matthäus 24 an?',
      options: <String>[
        'Kriege, Hungersnöte und Erdbeben',
        'Sofortigen weltweiten Frieden',
        'Das für immer verschwindende Sonnenlicht',
        'Überhaupt keine Zeichen',
      ],
      correctIndex: 0,
      explanation:
          'Ein zusammengesetztes Zeichen wird beschrieben (Matthäus 24).',
    ),
    QuizQuestion(
      text:
          'Welchen Auftrag vertraute Jesus seinen Jüngern nach seiner Auferstehung an?',
      options: <String>[
        'Menschen aus allen Nationen zu Jüngern zu machen',
        'Verborgen in Jerusalem zu bleiben',
        'Einen Tempel zu bauen',
        'Untätig abzuwarten',
      ],
      correctIndex: 0,
      explanation:
          'Der große Missionsauftrag beschließt das Evangelium (Matthäus 28:19).',
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wen berief Jesus zuerst am See Galiläa?',
      options: <String>['Fischer', 'Priester', 'Soldaten', 'Schriftgelehrte'],
      correctIndex: 0,
      explanation: 'Simon, Andreas und andere folgen ihm (Markus 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Was tat Jesus für den vom Dämon besessenen Mann aus der Gegend von Gerasa?',
      options: <String>[
        'Er trieb die ihn quälenden Dämonen aus',
        'Er ignorierte ihn',
        'Er schickte ihn ohne etwas zu tun nach Hause',
        'Er wies ihn scharf zurecht',
      ],
      correctIndex: 0,
      explanation:
          'Der Mann wird befreit und erlangt seinen Verstand zurück (Markus 5).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Mit wie vielen Broten speiste Jesus etwa 4.000 Menschen?',
      options: <String>['Sieben', 'Fünf', 'Zwölf', 'Zwei'],
      correctIndex: 0,
      explanation: 'Ein zweites Wunder der Vermehrung (Markus 8).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Was muss ein Mensch laut Jesus werden, um in das Königreich Gottes einzugehen?',
      options: <String>[
        'Wie ein kleines Kind',
        'Reich und mächtig',
        'Ein anerkannter Führer',
        'Ein Gelehrter',
      ],
      correctIndex: 0,
      explanation: 'Jesus nimmt Kinder als Beispiel auf (Markus 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Diener', 'Engel', 'Jünger'],
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche kleine Gabe lobte Jesus im Tempel?',
      options: <String>[
        'Die zwei kleinen Münzen der Witwe',
        'Ein Beutel Gold',
        'Ein makelloses Lamm',
        'Eine Silbermünze',
      ],
      correctIndex: 0,
      explanation: 'Sie gab alles, was sie hatte (Markus 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['reich', 'Tempel', 'Gold'],
    ),
    QuizQuestion(
      text: 'Wer wurde gezwungen, Jesu Marterpfahl zu tragen?',
      options: <String>['Simon von Cyrene', 'Petrus', 'Johannes', 'Barabbas'],
      correctIndex: 0,
      explanation: 'Simon wird unterwegs zum Tragen gezwungen (Markus 15).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Simon'],
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: 'In welcher Stadt wurde Jesus geboren?',
      options: <String>['Bethlehem', 'Nazareth', 'Jerusalem', 'Kapernaum'],
      correctIndex: 0,
      explanation: 'Die Geburt findet in Bethlehem statt (Lukas 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Wem verkündeten die Engel zuerst Jesu Geburt?',
      options: <String>['Hirten', 'Königen', 'Priestern', 'Herodes'],
      correctIndex: 0,
      explanation: 'Hirten erhalten die gute Botschaft (Lukas 2).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie viele Jünger sandte Jesus in Lukas 10 aus, um zu zweit zu predigen?',
      options: <String>['Siebzig', 'Zwölf', 'Hundert', 'Drei'],
      correctIndex: 0,
      explanation: 'Jesus weitet das Predigtwerk aus (Lukas 10).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Was rät Jesus bezüglich der Sorge um Essen und Kleidung?',
      options: <String>[
        'Sich nicht zu sorgen, sondern zuerst das Königreich zu suchen',
        'So viel wie möglich anzuhäufen',
        'Ganz aufzuhören zu arbeiten',
        'Sich ständig zu sorgen',
      ],
      correctIndex: 0,
      explanation: 'Jesus lehrt Vertrauen auf Gott (Lukas 12).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie viele Aussätzige heilte Jesus, von denen nur einer zurückkam, um zu danken?',
      options: <String>['Zehn', 'Sieben', 'Drei', 'Zwölf'],
      correctIndex: 0,
      explanation: 'Nur ein Samariter kehrt zurück, um zu danken (Lukas 17).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Wer plante Jesu Verrat gegen Geld?',
      options: <String>['Judas Iskariot', 'Petrus', 'Thomas', 'Pilatus'],
      correctIndex: 0,
      explanation: 'Judas verrät Jesus (Lukas 22).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Judas'],
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie viele Menschen wurden am Pfingsttag ungefähr getauft?',
      options: <String>['Etwa 3.000', 'Etwa 500', 'Etwa 12', 'Etwa 100'],
      correctIndex: 0,
      explanation:
          'Eine große Zahl reagiert auf die Botschaft (Apostelgeschichte 2).',
    ),
    QuizQuestion(
      text: 'Wer bewachte die Kleider derer, die Stephanus steinigten?',
      options: <String>[
        'Saulus (später Paulus)',
        'Petrus',
        'Barnabas',
        'Philippus',
      ],
      correctIndex: 0,
      explanation: 'Saulus billigte diesen Mord (Apostelgeschichte 7-8).',
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wen sandte der Geist, um dem äthiopischen Hofbeamten die gute Botschaft zu erklären?',
      options: <String>['Philippus', 'Petrus', 'Paulus', 'Johannes'],
      correctIndex: 0,
      explanation: 'Philippus erklärt ihm die Schriften (Apostelgeschichte 8).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Wie wurde Petrus aus dem Gefängnis unter Herodes befreit?',
      options: <String>[
        'Durch einen Engel',
        'Durch Bestechung eines Wächters',
        'Durch ein Erdbeben',
        'Niemand half ihm',
      ],
      correctIndex: 0,
      explanation:
          'Ein Engel führt ihn auf wunderbare Weise hinaus (Apostelgeschichte 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Petrus', 'Gefängnis', 'Vision'],
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Handwerk übte Paulus mit Aquila und Priscilla aus?',
      options: <String>['Zeltmacherei', 'Fischerei', 'Zimmerei', 'Medizin'],
      correctIndex: 0,
      explanation: 'Paulus arbeitete mit seinen Händen (Apostelgeschichte 18).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'In welcher Stadt löste Paulus\' Predigt einen Aufruhr unter den Silberschmieden der Diana/Artemis aus?',
      options: <String>['Ephesus', 'Athen', 'Korinth', 'Rom'],
      correctIndex: 0,
      explanation:
          'Die Handwerker fürchteten um ihr Gewerbe (Apostelgeschichte 19).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Vor welchen Herrschern bezeugte Paulus in Cäsarea seinen Glauben?',
      options: <String>[
        'Felix, Festus und König Agrippa',
        'Pilatus und Herodes',
        'Nur dem Sanhedrin',
        'Dem Kaiser selbst',
      ],
      correctIndex: 0,
      explanation:
          'Paulus verteidigt seinen Glauben vor den Behörden (Apostelgeschichte 24-26).',
    ),
    QuizQuestion(
      text:
          'Wo kam Paulus schließlich an, um sein Verfahren vor dem Kaiser abzuwarten?',
      options: <String>['Rom', 'Jerusalem', 'Antiochia', 'Ephesus'],
      correctIndex: 0,
      explanation:
          'Paulus predigt sogar unter Hausarrest (Apostelgeschichte 28).',
      type: QuizAnswerType.freeText,
    ),
  ],
};
