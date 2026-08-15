import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesDeC3 = <String, List<QuizQuestion>>{
  'Esther#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum wurde Königin Waschti ihrer Stellung enthoben?',
      options: <String>[
        'Sie weigerte sich, vor dem König und seinen Gästen zu erscheinen',
        'Sie verschwor sich gegen den König',
        'Sie wurde krank',
        'Sie verließ den Palast',
      ],
      correctIndex: 0,
      explanation: 'Ihre Weigerung führt zu ihrer Verstoßung (Esther 1).',
    ),
    QuizQuestion(
      text: 'Wen zog Mordechai auf, und wer wurde Königin?',
      options: <String>[
        'Esther, seine Cousine',
        'Seine Tochter',
        'Seine Schwester',
        'Eine ausländische Sklavin',
      ],
      correctIndex: 0,
      explanation: 'Esther wird zur neuen Königin gewählt (Esther 2).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Esther'],
    ),
    QuizQuestion(
      text: 'Warum wollte Haman alle Juden des Reiches ausrotten?',
      options: <String>[
        'Mordechai weigerte sich, sich vor ihm zu verbeugen',
        'Die Juden schuldeten ihm Geld',
        'Der König hatte es ihm befohlen',
        'Ein Krieg war gerade ausgebrochen',
      ],
      correctIndex: 0,
      explanation: 'Hamans Zorn wird zu einem Völkermordplan (Esther 3).',
    ),
  ],
  'Esther#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Mit welchen berühmten Worten überzeugt Mordechai Esther zu handeln?',
      options: <String>[
        '„Wer weiß, ob du nicht gerade für eine solche Zeit ... gelangt bist“',
        '„Flieh, solange noch Zeit ist“',
        '„Das ist nicht unser Problem“',
        '„Der König wird dir niemals zuhören“',
      ],
      correctIndex: 0,
      explanation: 'Dieser Appell bewegt Esther zum Eingreifen (Esther 4).',
    ),
    QuizQuestion(
      text: 'Was geschah, als der König nicht schlafen konnte?',
      options: <String>[
        'Er entdeckte, dass Mordechai nie belohnt worden war',
        'Er rief sofort Esther zu sich',
        'Er ließ Haman auf der Stelle hinrichten',
        'Er hob seinen Erlass auf',
      ],
      correctIndex: 0,
      explanation: 'Dieses vorsehungsvolle Detail wendet die Lage (Esther 6).',
    ),
    QuizQuestion(
      text: 'Wie deckte Esther Hamans Komplott auf?',
      options: <String>[
        'Bei einem zweiten Bankett, vor dem König',
        'Durch einen anonymen Brief',
        'Öffentlich vor der ganzen Nation',
        'Durch einen Diener',
      ],
      correctIndex: 0,
      explanation: 'Haman wird entlarvt und hingerichtet (Esther 7).',
    ),
  ],
  'Esther#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie wirkte der neue Erlass Hamans Erlass entgegen?',
      options: <String>[
        'Er erlaubte den Juden, sich zu verteidigen',
        'Er hob den ersten Erlass vollständig auf',
        'Er verbannte alle Perser',
        'Er änderte nichts',
      ],
      correctIndex: 0,
      explanation:
          'Ein unwiderruflicher Erlass musste durch einen anderen ausgeglichen werden (Esther 8).',
    ),
    QuizQuestion(
      text: 'Welches Fest wurde eingerichtet, um diese Rettung zu feiern?',
      options: <String>['Purim', 'Passah', 'Laubhüttenfest', 'Das Jubeljahr'],
      correctIndex: 0,
      explanation: 'Purim erinnert bis heute an dieses Ereignis (Esther 9).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Welche Stellung erlangte Mordechai schließlich?',
      options: <String>[
        'Eine hohe Stellung, nur dem König untergeordnet',
        'Er wurde verbannt',
        'Er blieb ein einfacher Beamter',
        'Er verließ Persien',
      ],
      correctIndex: 0,
      explanation:
          'Mordechai setzt sich für das Wohl seines Volkes ein (Esther 10).',
    ),
  ],
  'Job#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche Herausforderung stellt Satan Gott bezüglich Hiob?',
      options: <String>[
        'Hiob diene Gott nur aus Eigennutz',
        'Hiob existiere gar nicht wirklich',
        'Hiob sei bereits untreu',
        'Hiob wolle seine Familie verlassen',
      ],
      correctIndex: 0,
      explanation: 'Satan stellt Hiobs Beweggrund infrage (Hiob 1).',
    ),
    QuizQuestion(
      text: 'Wie reagierte Hiob, nachdem er alles verloren hatte?',
      options: <String>[
        'Er sündigte nicht und beschuldigte Gott keines Unrechts',
        'Er verfluchte Gott',
        'Er sann auf Rache',
        'Er gab seinen Glauben auf',
      ],
      correctIndex: 0,
      explanation:
          'Seine Lauterkeit bleibt trotz der Prüfung unversehrt (Hiob 1).',
    ),
    QuizQuestion(
      text: 'Was rät Hiobs Frau ihm nach seiner Erkrankung?',
      options: <String>[
        'Gott zu verfluchen und zu sterben',
        'Einen Arzt aufzusuchen',
        'Weit weg von zu Hause zu fliehen',
        'Geduldig zu schweigen',
      ],
      correctIndex: 0,
      explanation: 'Hiob weist diesen verzweifelten Rat zurück (Hiob 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['segne', 'bete', 'leide'],
    ),
  ],
  'Job#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was ist Bildads Hauptargument in seiner ersten Rede?',
      options: <String>[
        'Die Weisheit der Vorfahren beweist, dass Gott gerecht ist',
        'Gott existiert nicht',
        'Hiob ist unschuldig',
        'Leid hat keine Ursache',
      ],
      correctIndex: 0,
      explanation: 'Bildad beruft sich auf die Überlieferung (Hiob 8).',
    ),
    QuizQuestion(
      text: 'Wonach sehnt sich Hiob in seiner Antwort an Bildad zutiefst?',
      options: <String>[
        'Nach einem Vermittler zwischen ihm und Gott',
        'Nach Geld, um seine Schulden zu bezahlen',
        'Nach Rache an seinen Freunden',
        'Nach einer neuen Herde, sofort',
      ],
      correctIndex: 0,
      explanation:
          'Hiob sehnt sich danach, seinen Fall fair vorzutragen (Hiob 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Freund', 'Richter', 'Engel'],
    ),
    QuizQuestion(
      text: 'Was rät Zophar Hiob in seiner ersten Rede?',
      options: <String>[
        'Eine verborgene Sünde zu bereuen',
        'Seine Familie zu verlassen',
        'Einen anderen Weisen zu befragen',
        'Für immer zu schweigen',
      ],
      correctIndex: 0,
      explanation: 'Zophar nimmt an, Hiob verberge eine Schuld (Hiob 11).',
    ),
  ],
  'Job#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche berühmte Aussage macht Hiob trotz seines Leidens?',
      options: <String>[
        '„Ich weiß, dass mein Erlöser lebt“',
        '„Gott hat mich für immer verlassen“',
        '„Das Leben hat keinen Sinn“',
        '„Ich möchte lieber jetzt sterben“',
      ],
      correctIndex: 0,
      explanation: 'Diese Hoffnungserklärung prägt Hiob 19.',
    ),
    QuizQuestion(
      text: 'Welche Beobachtung macht Hiob über das Schicksal der Bösen?',
      options: <String>[
        'Sie scheinen trotz ihres Verhaltens oft zu gedeihen',
        'Sie werden immer sofort bestraft',
        'Sie existieren eigentlich nicht',
        'Sie enden stets in Armut',
      ],
      correctIndex: 0,
      explanation:
          'Hiob stellt die einfache Theorie seiner Freunde infrage (Hiob 21).',
    ),
    QuizQuestion(
      text:
          'Wie beschreibt Hiob die Behandlung durch seine Freunde in diesen Kapiteln?',
      options: <String>[
        'Er fühlt sich von ihnen verlassen und missverstanden',
        'Er dankt ihnen herzlich',
        'Er stimmt all ihren Argumenten zu',
        'Er erwähnt sie überhaupt nicht',
      ],
      correctIndex: 0,
      explanation:
          'Hiob äußert seinen Kummer über ihren Mangel an Mitgefühl (Hiob 16-17).',
    ),
  ],
  'Job#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wessen genauer Anschuldigungen erhebt Eliphas in seiner dritten Rede gegen Hiob?',
      options: <String>[
        'Konkrete Sünden wie die Unterdrückung der Armen',
        'Raub an einem Tempel',
        'Die Verleugnung seiner Familie',
        'Lügen gegenüber dem König',
      ],
      correctIndex: 0,
      explanation:
          'Eliphas\' Anschuldigungen werden konkreter, aber ohne Beweis (Hiob 22).',
    ),
    QuizQuestion(
      text: 'Wonach verlangt es Hiob in seiner Antwort sehr stark?',
      options: <String>[
        'Seinen Fall direkt vor Gott vorzutragen',
        'Weit weg von seiner Familie zu fliehen',
        'Reichtum zu erlangen',
        'Sich an seinen Freunden zu rächen',
      ],
      correctIndex: 0,
      explanation: 'Hiob sucht ein gerechtes Gehör (Hiob 23).',
    ),
    QuizQuestion(
      text: 'Welches zentrale Thema entfaltet Hiob in Kapitel 28?',
      options: <String>[
        'Den unvergleichlichen Wert der Weisheit',
        'Den Bergbau nach Reichtum',
        'Die Geografie der Wüste',
        'Die Opfergesetze',
      ],
      correctIndex: 0,
      explanation:
          'Dieses Gedicht feiert die Weisheit, kostbarer als Gold (Hiob 28).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gold', 'Silber', 'Perlen'],
    ),
  ],
  'Job#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Woran erinnert sich Hiob, wenn er von seinen vergangenen Tagen spricht?',
      options: <String>[
        'An den Respekt und die Ehre, die er einst erhielt',
        'An seine bescheidene Herkunft',
        'An ein Leben voller Krieg',
        'An seine Kindheit im Ausland',
      ],
      correctIndex: 0,
      explanation:
          'Hiob stellt seine geehrte Vergangenheit seiner heutigen Lage gegenüber (Hiob 29).',
    ),
    QuizQuestion(
      text: 'Was erklärt Hiob in seinem abschließenden Unschuldseid?',
      options: <String>[
        'Er bekräftigt, keine der genannten Verfehlungen begangen zu haben',
        'Er gesteht mehrere Sünden',
        'Er weigert sich zu antworten',
        'Er beschuldigt Gott direkt',
      ],
      correctIndex: 0,
      explanation:
          'Hiob schließt seine Verteidigung mit einem umfassenden Eid (Hiob 31).',
    ),
    QuizQuestion(
      text: 'Wer ist Elihu, der nach den drei Freunden spricht?',
      options: <String>[
        'Ein jüngerer Mann, der aus Respekt gewartet hatte, bevor er '
            'sprach',
        'Ein von Gott gesandter Engel',
        'Ein vierter, älterer Freund',
        'Hiobs Sohn',
      ],
      correctIndex: 0,
      explanation:
          'Elihu greift ein, weil die Älteren Hiob nicht überzeugt haben (Hiob 32).',
    ),
  ],
  'Job#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Von wo aus spricht Jehova schließlich zu Hiob?',
      options: <String>[
        'Aus einem Sturmwind',
        'Aus einem Traum',
        'Durch einen sichtbaren Engel',
        'Er antwortete nie',
      ],
      correctIndex: 0,
      explanation: 'Gott antwortet schließlich, aber mit Fragen (Hiob 38).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Feuer', 'Wolke', 'Donner'],
    ),
    QuizQuestion(
      text: 'Worum geht es bei Jehovas Fragen an Hiob hauptsächlich?',
      options: <String>[
        'Um die Schöpfung und die Herrschaft über die Natur',
        'Um Hiobs verborgene Sünden',
        'Um die Politik der Nationen',
        'Um Tempelrituale',
      ],
      correctIndex: 0,
      explanation:
          'Gott zeigt die Weite seiner schöpferischen Weisheit (Hiob 38-41).',
    ),
    QuizQuestion(
      text: 'Wie endet Hiobs Geschichte?',
      options: <String>[
        'Hiob bereut demütig, und Gott gibt ihm das Doppelte seines Besitzes zurück',
        'Hiob stirbt in Armut',
        'Hiob verflucht Gott bis zum Schluss',
        'Seine Freunde werden an seiner Stelle belohnt',
      ],
      correctIndex: 0,
      explanation: 'Jehova segnet Hiob mehr als zuvor (Hiob 42).',
    ),
  ],
  'Psalms#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Womit vergleicht Psalm 1 den glücklichen Menschen, der über Gottes Gesetz nachsinnt?',
      options: <String>[
        'Mit einem Baum, gepflanzt an Wasserbächen',
        'Mit einem festen Felsen',
        'Mit einem Vogel im Flug',
        'Mit einer angezündeten Lampe',
      ],
      correctIndex: 0,
      explanation:
          'Das Bild des fruchtbaren Baumes eröffnet das Buch (Psalm 1).',
    ),
    QuizQuestion(
      text: 'Was feiert Psalm 19 in seinem ersten Teil?',
      options: <String>[
        'Die Herrlichkeit Gottes, die sich am Himmel zeigt',
        'Den Sieg eines Königs',
        'Den Bau des Tempels',
        'Eine gewonnene Schlacht',
      ],
      correctIndex: 0,
      explanation: '„Die Himmel erzählen Gottes Herrlichkeit“ (Psalm 19:1).',
    ),
    QuizQuestion(
      text: 'Welche Frage stellt Psalm 8 angesichts der Weite der Schöpfung?',
      options: <String>[
        'Was ist der Mensch, dass du an ihn denkst?',
        'Warum ist das Meer so gewaltig?',
        'Wo liegt der Garten Eden?',
        'Wie viele Sterne gibt es?',
      ],
      correctIndex: 0,
      explanation:
          'Der Psalmist staunt über die Stellung des Menschen (Psalm 8:4).',
    ),
  ],
  'Psalms#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie beschreibt Psalm 23 Jehova?',
      options: <String>[
        'Als einen Hirten, der sich um seine Schafe kümmert',
        'Als strengen Richter',
        'Als fernen König',
        'Als rachsüchtigen Krieger',
      ],
      correctIndex: 0,
      explanation: '„Jehova ist mein Hirte“ (Psalm 23:1).',
    ),
    QuizQuestion(
      text:
          'Welche prophetischen Worte aus Psalm 22 zitierte Jesus am Marterpfahl?',
      options: <String>[
        '„Mein Gott, mein Gott, warum hast du mich verlassen?“',
        '„Ich bin gekommen, um zu richten“',
        '„Seht meinen Diener“',
        '„Das Königreich ist nahe“',
      ],
      correctIndex: 0,
      explanation:
          'Dieses Zitat verbindet diesen Psalm mit Christi Leiden (Psalm 22:1).',
    ),
    QuizQuestion(
      text: 'Was erklärt Psalm 34 über Jehovas Güte?',
      options: <String>[
        'Schmeckt und seht, dass Jehova gut ist',
        'Seine Güte bleibt verborgen',
        'Sie betrifft nur die Priester',
        'Sie ist auf Israel beschränkt',
      ],
      correctIndex: 0,
      explanation: 'Eine Einladung, Gottes Güte zu erleben (Psalm 34:8).',
    ),
  ],
  'Psalms#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welches bewegende Gebet verfasste David nach seiner Sünde mit Bathseba?',
      options: <String>[
        'Psalm 51, mit der Bitte um ein reines Herz',
        'Ein Lied des militärischen Sieges',
        'Eine Prophezeiung über Babylon',
        'Ein Krönungslied',
      ],
      correctIndex: 0,
      explanation: '„Erschaffe in mir ein reines Herz, o Gott“ (Psalm 51:10).',
    ),
    QuizQuestion(
      text:
          'Womit vergleicht der Psalmist seine tiefe Sehnsucht nach Gott in Psalm 42?',
      options: <String>[
        'Mit einem Hirsch, der nach Wasserbächen lechzt',
        'Mit einem hungrigen Löwen',
        'Mit einem eingesperrten Vogel',
        'Mit einem eiligen Kaufmann',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild starken geistigen Durstes (Psalm 42:1).',
    ),
    QuizQuestion(
      text: 'Welche zentrale Aussage macht Psalm 46?',
      options: <String>[
        'Gott ist unsere Zuflucht und Stärke',
        'Die Nationen werden immer in Frieden leben',
        'Der Tempel wird nie zerstört werden',
        'Der König ist unsere einzige Hoffnung',
      ],
      correctIndex: 0,
      explanation: '„Gott ist unsere Zuflucht und Stärke“ (Psalm 46:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Hirte', 'Fels', 'Festung'],
    ),
  ],
  'Psalms#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Für wen ist Psalm 72 ein Segensgebet für eine gerechte, wohlhabende Herrschaft?',
      options: <String>[
        'Für den König (Salomo, und prophetisch den Messias)',
        'Allein für die Priester',
        'Für die feindlichen Nationen',
        'Für die Propheten',
      ],
      correctIndex: 0,
      explanation:
          'Dieser messianische Psalm beschreibt eine dauerhafte Friedensherrschaft (Psalm 72).',
    ),
    QuizQuestion(
      text: 'Welches Dilemma beunruhigt Asaph in Psalm 73?',
      options: <String>[
        'Das scheinbare Gedeihen der Bösen',
        'Die Armut des Tempels',
        'Der ausbleibende Regen',
        'Das Schweigen der Propheten',
      ],
      correctIndex: 0,
      explanation:
          'Asaph löst diese Sorge, indem er Gottes Heiligtum betritt (Psalm 73:17).',
    ),
    QuizQuestion(
      text: 'Welches Bild beschreibt Gottes machtvollen Zug in Psalm 68?',
      options: <String>[
        'Er reitet durch die Wüste für sein Volk',
        'Er bleibt dauerhaft verborgen',
        'Er befährt nur die Meere',
        'Er kämpft allein, ohne einzugreifen',
      ],
      correctIndex: 0,
      explanation: 'Poetische Sprache göttlicher Macht (Psalm 68).',
    ),
  ],
  'Psalms#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Worum bittet Mose Gott in Psalm 90 angesichts der Kürze des Lebens?',
      options: <String>[
        'Uns zu lehren, unsere Tage weise zu zählen',
        'Das menschliche Leben unbegrenzt zu verlängern',
        'Die Erinnerung an den Tod zu löschen',
        'Die Zeit zu beschleunigen',
      ],
      correctIndex: 0,
      explanation: '„Lehre uns, unsere Tage richtig zu zählen“ (Psalm 90:12).',
    ),
    QuizQuestion(
      text: 'Welche Schutzverheißung bietet Psalm 91?',
      options: <String>[
        'Wer im Schutz des Höchsten wohnt, ist geborgen',
        'Es wird keine Verheißung gegeben',
        'Nur Könige sind geschützt',
        'Schutz hängt von Opfern ab',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild der Zuflucht unter göttlichen Flügeln (Psalm 91).',
    ),
    QuizQuestion(
      text: 'Was sagt Psalm 84 über Gottes Wohnstätte?',
      options: <String>[
        'Dass sie unendlich begehrenswert und geliebt ist',
        'Dass sie bedrohlich ist',
        'Dass sie bald zerstört wird',
        'Dass sie nur Königen vorbehalten ist',
      ],
      correctIndex: 0,
      explanation: '„Wie lieblich sind deine Wohnstätten!“ (Psalm 84:1).',
    ),
  ],
  'Psalms#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Zu welcher Einladung ruft Psalm 100 zu Beginn auf?',
      options: <String>[
        'Jauchzt und kommt mit Dank herein',
        'Bewahrt völliges Schweigen',
        'Flieht weit vom Tempel',
        'Weint über eure Sünden',
      ],
      correctIndex: 0,
      explanation: 'Ein freudiger Aufruf zu gemeinsamem Lob (Psalm 100).',
    ),
    QuizQuestion(
      text: 'Woran erinnert Psalm 103 bezüglich Gottes Vergebung?',
      options: <String>[
        'Er vergibt all unsere Verfehlungen, wie ein Vater Mitgefühl zeigt',
        'Er vergibt niemals',
        'Vergebung hängt vom täglichen Opfer ab',
        'Nur die Priester werden vergeben',
      ],
      correctIndex: 0,
      explanation: 'Ein zärtliches Bild väterlichen Mitgefühls (Psalm 103:13).',
    ),
    QuizQuestion(
      text:
          'Welche Worte aus Psalm 110 werden in den Griechischen Schriften auf Christus angewandt?',
      options: <String>[
        '„Setze dich zu meiner Rechten“',
        '„Du wirst König von Babylon sein“',
        '„Kehre nach Ägypten zurück“',
        '„Baue meinen Tempel“',
      ],
      correctIndex: 0,
      explanation: 'Jesus selbst zitiert diesen Vers (Psalm 110:1).',
    ),
  ],
  'Psalms#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was ist das Hauptthema von Psalm 119, dem längsten Kapitel der Bibel?',
      options: <String>[
        'Die Liebe zu Gottes Gesetz und Wort',
        'Eine geschichtliche Schlacht',
        'Der Bau des Tempels',
        'Eine Reise nach Ägypten',
      ],
      correctIndex: 0,
      explanation:
          'Jeder Abschnitt sinnt über das göttliche Gesetz nach (Psalm 119).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tempel', 'König', 'Opfer'],
    ),
    QuizQuestion(
      text: 'Woher kommt laut Psalm 121 die Hilfe des Psalmisten?',
      options: <String>[
        'Von Jehova, dem Schöpfer von Himmel und Erde',
        'Von den Bergen selbst',
        'Vom Heer des Königs',
        'Von den Tempelpriestern',
      ],
      correctIndex: 0,
      explanation:
          '„Ich erhebe meine Augen zu den Bergen ... Meine Hilfe kommt von Jehova“ (Psalm 121).',
    ),
    QuizQuestion(
      text: 'Woran erinnert Psalm 127 bezüglich menschlicher Pläne?',
      options: <String>[
        'Ohne Jehova mühen sich die Bauleute umsonst',
        'Erfolg hängt nur von Anstrengung ab',
        'Allein der Zufall entscheidet',
        'Kinder sind kein Segen',
      ],
      correctIndex: 0,
      explanation: '„Wenn Jehova nicht das Haus baut ...“ (Psalm 127:1).',
    ),
  ],
  'Psalms#7': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche herzzerreißende Szene eröffnet Psalm 137?',
      options: <String>[
        'Die Verbannten, die an den Flüssen Babylons weinen',
        'Ein Krönungsfest',
        'Eine gewonnene Schlacht',
        'Der Bau des Tempels',
      ],
      correctIndex: 0,
      explanation:
          '„An den Flüssen Babylons, da saßen wir und weinten“ (Psalm 137:1).',
    ),
    QuizQuestion(
      text: 'Wie beschreibt Psalm 145 Jehova?',
      options: <String>[
        'Groß und grenzenlosen Lobes würdig',
        'Fern und gleichgültig',
        'Nur streng',
        'Seinem Volk gegenüber schweigend',
      ],
      correctIndex: 0,
      explanation: 'Ein Psalm reichen Lobes (Psalm 145:3).',
    ),
    QuizQuestion(
      text: 'Zu welchem Aufruf schließt der allerletzte Psalm, Psalm 150?',
      options: <String>[
        'Alles, was Atem hat, lobe Jah',
        'Alles soll für immer verstummen',
        'Nur Könige sollen Gott loben',
        'Musik soll verboten werden',
      ],
      correctIndex: 0,
      explanation:
          'Das Buch endet mit einem universellen Aufruf zum Lob (Psalm 150:6).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Himmel', 'Trompete', 'singt'],
    ),
  ],
  'Proverbs#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Was ist laut Sprüche 1 der Anfang der Erkenntnis?',
      options: <String>[
        'Die Furcht Jehovas',
        'Reichtum',
        'Erfahrung allein',
        'Formale Bildung',
      ],
      correctIndex: 0,
      explanation: 'Dieser Grundsatz eröffnet das Buch (Sprüche 1:7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Weisheit', 'Erkenntnis', 'Reichtum'],
    ),
    QuizQuestion(
      text: 'Was rät Sprüche 3 bezüglich des Vertrauens?',
      options: <String>[
        'Vertraue von ganzem Herzen auf Jehova',
        'Verlass dich nur auf deinen eigenen Verstand',
        'Vermeide jede wichtige Entscheidung',
        'Folge der Meinung der Mehrheit',
      ],
      correctIndex: 0,
      explanation: '„Vertraue von ganzem Herzen auf Jehova“ (Sprüche 3:5).',
    ),
    QuizQuestion(
      text: 'Wie wird die Weisheit in Sprüche 8 personifiziert?',
      options: <String>[
        'Als eine Stimme, die öffentlich zu den Menschen ruft',
        'Als ein erwähnter, aber unsichtbarer Schatz',
        'Als ein schweigender König',
        'Als ein verschlossenes Buch',
      ],
      correctIndex: 0,
      explanation:
          'Die Weisheit ruft laut auf den öffentlichen Plätzen (Sprüche 8).',
    ),
  ],
  'Proverbs#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was sagt Sprüche 15 darüber, wie man auf Zorn reagieren soll?',
      options: <String>[
        'Eine sanfte Antwort wendet Grimm ab',
        'Man muss immer energisch reagieren',
        'Schweigen ist immer vorzuziehen',
        'Zorn muss völlig ignoriert werden',
      ],
      correctIndex: 0,
      explanation: '„Eine sanfte Antwort wendet Grimm ab“ (Sprüche 15:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['harsch', 'Wort', 'Zorn'],
    ),
    QuizQuestion(
      text: 'Was sagt Sprüche 16 über unsere Pläne und Jehova?',
      options: <String>[
        'Befiehl Jehova deine Werke, und deine Pläne werden gelingen',
        'Menschliche Pläne hängen nur von uns selbst ab',
        'Jehova ignoriert unsere täglichen Entscheidungen',
        'Es ist besser, nichts zu planen',
      ],
      correctIndex: 0,
      explanation: '„Befiehl Jehova deine Werke“ (Sprüche 16:3).',
    ),
    QuizQuestion(
      text: 'Wofür steht die weise Frau, die in Sprüche 14 ihr Haus baut?',
      options: <String>[
        'Für praktische Weisheit, die aufbaut und bewahrt',
        'Für eine ausländische Königin',
        'Für eine einfache Arbeiterin',
        'Für eine unbedeutende Nebenfigur',
      ],
      correctIndex: 0,
      explanation:
          'Das Bild veranschaulicht die aufbauende Wirkung der Weisheit (Sprüche 14:1).',
    ),
  ],
  'Proverbs#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was sagt Sprüche 18 über die Macht der Zunge?',
      options: <String>[
        'Tod und Leben liegen in der Macht der Zunge',
        'Sie hat keinen wirklichen Einfluss',
        'Sie betrifft nur Herrscher',
        'Sie ist immer harmlos',
      ],
      correctIndex: 0,
      explanation:
          'Ein starkes Bild von der Wirkung der Worte (Sprüche 18:21).',
    ),
    QuizQuestion(
      text: 'Was sagt Sprüche 19 über Güte gegenüber den Armen?',
      options: <String>[
        'Es ist, als leihe man Jehova selbst',
        'Es ist Zeitverschwendung',
        'Es betrifft nur die Reichen',
        'Es schwächt die Gesellschaft',
      ],
      correctIndex: 0,
      explanation:
          '„Wer dem Geringen Gunst erweist, leiht Jehova“ (Sprüche 19:17).',
    ),
    QuizQuestion(
      text: 'Was ist laut Sprüche 22 besser als großer Reichtum?',
      options: <String>[
        'Ein guter Ruf',
        'Ein großer Palast',
        'Ein mächtiges Heer',
        'Ein weites Territorium',
      ],
      correctIndex: 0,
      explanation:
          '„Ein guter Name ist begehrenswerter als großer Reichtum“ (Sprüche 22:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Reichtum', 'Gold', 'Silber'],
    ),
  ],
  'Proverbs#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was sagt Sprüche 27 darüber, wie ein Freund den anderen beeinflusst?',
      options: <String>[
        'Eisen schärft Eisen, so schärft einer den anderen',
        'Freunde haben überhaupt keinen Einfluss',
        'Es ist besser, allein zu bleiben',
        'Freunde schwächen den Charakter',
      ],
      correctIndex: 0,
      explanation:
          'Ein Bild positiver gegenseitiger Beeinflussung (Sprüche 27:17).',
    ),
    QuizQuestion(
      text: 'Was sagt Sprüche 29 über das Fehlen geistiger Führung?',
      options: <String>[
        'Wo keine Vision ist, wird das Volk zügellos',
        'Das Volk gedeiht immer von selbst',
        'Visionen sind unwichtig',
        'Das Volk zieht das Fehlen von Regeln vor',
      ],
      correctIndex: 0,
      explanation: 'Eine Warnung vor mangelnder Führung (Sprüche 29:18).',
    ),
    QuizQuestion(
      text: 'Was feiert das abschließende Gedicht in Sprüche 31?',
      options: <String>[
        'Die tüchtige und tugendhafte Frau',
        'Den Reichtum eines Königs',
        'Einen militärischen Sieg',
        'Den Bau eines Palastes',
      ],
      correctIndex: 0,
      explanation:
          'Ein akrostisches Gedicht preist die vortreffliche Frau (Sprüche 31).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['König', 'Faulenzer', 'Wein'],
    ),
  ],
  'Ecclesiastes#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche wiederkehrende Feststellung eröffnet das Buch Prediger?',
      options: <String>[
        'Alles ist Dunst (Nichtigkeit) unter der Sonne',
        'Alles ist vollkommen beständig',
        'Reichtum löst alles',
        'Nichts ändert sich je',
      ],
      correctIndex: 0,
      explanation: 'Dieses Thema strukturiert das ganze Buch (Prediger 1:2).',
    ),
    QuizQuestion(
      text:
          'Was entdeckte Salomo, nachdem er Vergnügen, Projekten und Weisheit nachgejagt war?',
      options: <String>[
        'All das bleibt ohne Gott nichtig',
        'Vergnügen allein genügt für Glück',
        'Arbeit garantiert immer Zufriedenheit',
        'Menschliche Weisheit löst alles',
      ],
      correctIndex: 0,
      explanation:
          'Seine persönliche Erfahrung veranschaulicht die Nichtigkeit ohne Gott (Prediger 2).',
    ),
    QuizQuestion(
      text:
          'Worauf weist der berühmte Abschnitt über „eine Zeit für alles“ hin?',
      options: <String>[
        'Es gibt für alles eine passende Zeit',
        'Zeit hat überhaupt keine Bedeutung',
        'Alles muss sofort geschehen',
        'Die Vergangenheit spielt keine Rolle',
      ],
      correctIndex: 0,
      explanation: 'Dieses rhythmische Gedicht eröffnet Prediger 3.',
    ),
  ],
  'Ecclesiastes#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was rät Prediger 5 bezüglich Gelübden gegenüber Gott?',
      options: <String>[
        'Besser nicht geloben, als geloben und es nicht erfüllen',
        'Man sollte viele Gelübde ablegen',
        'Gelübde haben keinen Wert',
        'Nur Priester dürfen Gelübde ablegen',
      ],
      correctIndex: 0,
      explanation:
          'Vorsicht im Reden gegenüber Gott wird betont (Prediger 5:4, 5).',
    ),
    QuizQuestion(
      text: 'Was sagt Prediger 7 über den guten Ruf?',
      options: <String>[
        'Ein guter Name ist besser als feines duftendes Öl',
        'Ruf hat keinen Wert',
        'Nur Reichtum zählt',
        'Ein Name überlebt nie',
      ],
      correctIndex: 0,
      explanation: 'Ein Urteil über den Wert der Lauterkeit (Prediger 7:1).',
    ),
    QuizQuestion(
      text: 'Was empfiehlt Prediger 8 im Umgang mit der Obrigkeit?',
      options: <String>[
        'Klug gehorchen, ohne vorschnell aufzubegehren',
        'Sich stets den Herrschern widersetzen',
        'Das Gesetz völlig ignorieren',
        'Vor jeder staatsbürgerlichen Pflicht fliehen',
      ],
      correctIndex: 0,
      explanation: 'Praktische Vorsicht wird geraten (Prediger 8).',
    ),
  ],
  'Ecclesiastes#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Woran erinnert Prediger 9 bezüglich unserer täglichen Tätigkeiten?',
      options: <String>[
        'Tu dein Werk mit aller Kraft, solange du lebst',
        'Arbeit hat keinen Wert',
        'Es ist besser, untätig zu bleiben',
        'Nur die Reichen sollten arbeiten',
      ],
      correctIndex: 0,
      explanation: 'Ein Aufruf zu vollem Einsatz im Leben (Prediger 9:10).',
    ),
    QuizQuestion(
      text: 'Was rät Prediger 11 bezüglich Großzügigkeit?',
      options: <String>[
        'Wirf dein Brot auf das Wasser, denn du wirst es wiederfinden',
        'Behalte alle deine Mittel für dich',
        'Großzügigkeit ist immer nutzlos',
        'Man muss auf Gewissheit warten, bevor man handelt',
      ],
      correctIndex: 0,
      explanation:
          'Ein Bild großzügigen und zuversichtlichen Investierens (Prediger 11:1).',
    ),
    QuizQuestion(
      text: 'Was ist der abschließende Schluss des Buches Prediger?',
      options: <String>[
        'Fürchte Gott und halte seine Gebote',
        'Suche allein das Vergnügen',
        'Nichts hat wirklich einen Sinn',
        'Reichtum ist das letzte Ziel',
      ],
      correctIndex: 0,
      explanation:
          'Dieser Schluss fasst das ganze Buch zusammen (Prediger 12:13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Nichtigkeit', 'Weisheit', 'Reichtum'],
    ),
  ],
  'Song of Solomon#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Gefühl prägt den Anfang des Hohen Liedes?',
      options: <String>[
        'Eine leidenschaftliche Liebe zwischen der Sulamith und ihrem Geliebten',
        'Ein Familienkonflikt',
        'Eine Geschäftsverhandlung',
        'Ein königliches Urteil',
      ],
      correctIndex: 0,
      explanation:
          'Das Buch feiert aufrichtige treue, ausschließliche Liebe (Hohes Lied 1).',
    ),
    QuizQuestion(
      text: 'Was tut die Sulamith in ihrem Traum in Kapitel 3?',
      options: <String>[
        'Sie sucht ihren Geliebten in der ganzen Stadt',
        'Sie flieht in ein fernes Land',
        'Sie heiratet einen anderen Mann',
        'Sie vergisst ihre Liebe völlig',
      ],
      correctIndex: 0,
      explanation: 'Ihre Hingabe bleibt selbst im Traum treu (Hohes Lied 3).',
    ),
    QuizQuestion(
      text: 'Wie drückt die Sulamith ihre ausschließliche Hingabe aus?',
      options: <String>[
        '„Mein Geliebter gehört mir, und ich gehöre ihm“',
        '„Ich ziehe Reichtum der Liebe vor“',
        '„Liebe bedeutet mir nichts“',
        '„Ich werde für immer allein bleiben“',
      ],
      correctIndex: 0,
      explanation:
          'Diese Formulierung kehrt wie ein Refrain wieder (Hohes Lied 2:16).',
    ),
  ],
  'Song of Solomon#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie beschreibt der Geliebte die Schönheit der Sulamith in Kapitel 4?',
      options: <String>[
        'Durch eine Reihe glühender poetischer Bilder',
        'Kühl und distanziert',
        'Indem er sie mit einer Feindin vergleicht',
        'Er beschreibt sie überhaupt nicht',
      ],
      correctIndex: 0,
      explanation:
          'Ein ausführliches Lobgedicht wird ihr gewidmet (Hohes Lied 4).',
    ),
    QuizQuestion(
      text: 'Was geschieht, als der Geliebte in Kapitel 5 an ihre Tür klopft?',
      options: <String>[
        'Sie öffnet zu spät, und er ist schon fort',
        'Sie öffnet sofort mit Freude',
        'Sie weigert sich, ihn zu sehen',
        'Er kam überhaupt nicht',
      ],
      correctIndex: 0,
      explanation:
          'Dieser verpasste Moment schafft schmerzliches Bedauern (Hohes Lied 5).',
    ),
    QuizQuestion(
      text: 'Wem beschreibt die Sulamith nach diesem Ereignis ihren Geliebten?',
      options: <String>[
        'Den Töchtern Jerusalems',
        'Nur ihrer Mutter',
        'König Salomo',
        'Niemandem, sie schweigt',
      ],
      correctIndex: 0,
      explanation: 'Ihre begeisterte Beschreibung folgt (Hohes Lied 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Salomo', 'Weinberg', 'Hirte'],
    ),
  ],
  'Song of Solomon#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche berühmte Aussage über die Liebe findet sich in Kapitel 8?',
      options: <String>[
        'Liebe ist so stark wie der Tod',
        'Liebe wird mit Geld erkauft',
        'Liebe spielt keine Rolle',
        'Liebe hält nie an',
      ],
      correctIndex: 0,
      explanation:
          '„Viele Wasser können die Liebe nicht auslöschen“ (Hohes Lied 8:6, 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Feuer', 'Wasser', 'Eifersucht'],
    ),
    QuizQuestion(
      text:
          'Wofür stehen die „vielen Wasser“, die die Liebe nicht auslöschen können?',
      options: <String>[
        'Für Prüfungen, die eine wahre Liebe nicht zerstören können',
        'Für eine buchstäbliche Flut',
        'Für den Reichtum des Königreichs',
        'Für die Macht des Königs',
      ],
      correctIndex: 0,
      explanation:
          'Ein starkes Bild für die Widerstandskraft der Liebe (Hohes Lied 8).',
    ),
    QuizQuestion(
      text: 'Welcher Ton prägt den Schluss des Hohen Liedes?',
      options: <String>[
        'Die Feier einer treuen, gemeinsamen Liebe',
        'Eine endgültige Trennung',
        'Ein hartes Urteil',
        'Eine Kriegswarnung',
      ],
      correctIndex: 0,
      explanation:
          'Das Buch endet mit einem Ton erfüllter Liebe (Hohes Lied 8).',
    ),
  ],
  'Isaiah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Was verheißt Jesaja 2 für die Zukunft bezüglich des Krieges?',
      options: <String>[
        'Die Nationen werden ihre Schwerter zu Pflugscharen umschmieden',
        'Kriege werden häufiger werden',
        'Ein einziges Reich wird für immer herrschen',
        'Es wird keine Veränderung vorausgesagt',
      ],
      correctIndex: 0,
      explanation: 'Eine Vision universellen Friedens (Jesaja 2:4).',
    ),
    QuizQuestion(
      text: 'Was sieht Jesaja in seiner Vision der prophetischen Beauftragung?',
      options: <String>[
        'Jehova auf einem hohen Thron, umgeben von Seraphim',
        'Eine himmlische Schlacht',
        'Eine stille Wüste',
        'Nur eine Stadt in Trümmern',
      ],
      correctIndex: 0,
      explanation:
          'Eine glühende Kohle berührt seine Lippen und reinigt seinen Mund (Jesaja 6).',
    ),
    QuizQuestion(
      text: 'Welches Zeichen kündigt Jesaja König Ahas in Kapitel 7 an?',
      options: <String>[
        'Eine junge Frau wird einen Sohn empfangen, Immanuel',
        'Einen sofortigen militärischen Sieg',
        'Die vollständige Zerstörung Judas',
        'Eine lang anhaltende Hungersnot',
      ],
      correctIndex: 0,
      explanation: '„Immanuel“ bedeutet „Gott mit uns“ (Jesaja 7:14).',
    ),
  ],
  'Isaiah#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche berühmte messianische Prophezeiung findet sich in Jesaja 9?',
      options: <String>[
        'Ein Kind ist geboren, die Herrschaft ruht auf seiner Schulter',
        'Ein fremder König wird für immer regieren',
        'Der Tempel wird sofort wieder aufgebaut',
        'Frieden wird niemals kommen',
      ],
      correctIndex: 0,
      explanation:
          'Diese Stelle kündigt eine Friedensherrschaft an (Jesaja 9:6, 7).',
    ),
    QuizQuestion(
      text:
          'Welches friedliche Bild veranschaulicht Jesaja 11 bezüglich der künftigen Herrschaft?',
      options: <String>[
        'Der Wolf wird beim Lamm wohnen',
        'Löwen werden die Menschheit beherrschen',
        'Die Wüsten werden karg bleiben',
        'Die Nationen werden gespalten bleiben',
      ],
      correctIndex: 0,
      explanation: 'Vollkommene Harmonie wird verheißen (Jesaja 11:6).',
    ),
    QuizQuestion(
      text: 'Wie beschreibt Jesaja 14 den stolzen Fall des Königs von Babylon?',
      options: <String>[
        'Als leuchtenden Stern, der vom Himmel gefallen ist',
        'Als für immer triumphierenden König',
        'Als treuen Verbündeten Israels',
        'Als bloßen Händler',
      ],
      correctIndex: 0,
      explanation: 'Ein eindrucksvolles Bild des Sturzes (Jesaja 14:12).',
    ),
  ],
  'Isaiah#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche symbolische Handlung führt Jesaja gegen Ägypten und Kusch aus?',
      options: <String>[
        'Barfuß und ohne Obergewand umherzugehen',
        'Seine Kleider zu verbrennen',
        'Ein Jahr lang zu fasten',
        'Einen Altar zu bauen',
      ],
      correctIndex: 0,
      explanation:
          'Dieses Zeichen veranschaulicht die Schande der kommenden Gefangenschaft (Jesaja 20).',
    ),
    QuizQuestion(
      text: 'Welches universelle Gericht kündigt Jesaja 24 an?',
      options: <String>[
        'Die ganze Erde wird erschüttert und verwüstet',
        'Nur eine Nation wird gerichtet',
        'Es wird kein Gericht stattfinden',
        'Das Gericht betrifft nur Könige',
      ],
      correctIndex: 0,
      explanation: 'Ein weltweites Ausmaß wird beschrieben (Jesaja 24).',
    ),
    QuizQuestion(
      text: 'Was verheißt Jesaja 25 bezüglich des Todes?',
      options: <String>[
        'Jehova wird den Tod für immer verschlingen',
        'Der Tod wird unbesiegt bleiben',
        'Nur die Reichen werden ihm entkommen',
        'Über den Tod wird nichts gesagt',
      ],
      correctIndex: 0,
      explanation:
          'Eine außergewöhnliche Hoffnung wird ausgedrückt (Jesaja 25:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tränen', 'Schleier', 'Berg'],
    ),
  ],
  'Isaiah#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Was verheißt Jesaja 26 demjenigen, dessen Sinn auf Gott vertraut?',
      options: <String>[
        'Beständigen Frieden',
        'Sofortigen Reichtum',
        'Ein unbesiegbares Heer',
        'Garantiertes langes Leben',
      ],
      correctIndex: 0,
      explanation: '„Du wirst ihnen beständigen Frieden geben“ (Jesaja 26:3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Frieden'],
    ),
    QuizQuestion(
      text: 'Welchen kostbaren Stein legt Jehova laut Jesaja 28 in Zion?',
      options: <String>[
        'Einen Eckstein, ein geprüftes Fundament',
        'Einen gewöhnlichen Kieselstein',
        'Einen verfluchten Stein',
        'Kein Stein wird erwähnt',
      ],
      correctIndex: 0,
      explanation:
          'Ein messianisches Bild eines sicheren Fundaments (Jesaja 28:16).',
    ),
    QuizQuestion(
      text:
          'Wovor warnt Jesaja das Volk bezüglich eines militärischen Bündnisses?',
      options: <String>[
        'Davor, eher Ägypten als Jehova zu vertrauen',
        'Vor einem Bündnis allein mit Babylon',
        'Vor jeglichem Außenhandel',
        'Vor den örtlichen Priestern',
      ],
      correctIndex: 0,
      explanation:
          'Hilfe bei Ägypten zu suchen wird kritisiert (Jesaja 30-31).',
    ),
  ],
  'Isaiah#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Was wird laut der Verheißung von Jesaja 35 aus der Wüste?',
      options: <String>[
        'Sie wird wie der Safran blühen',
        'Sie wird für immer karg bleiben',
        'Sie wird zu einem Meer werden',
        'Sie wird endgültig verlassen',
      ],
      correctIndex: 0,
      explanation: 'Eine freudige Verwandlung wird verheißen (Jesaja 35:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Wüste', 'Wasser', 'singen'],
    ),
    QuizQuestion(
      text: 'Wie antwortete Jehova auf Hiskias Gebet gegen Sanherib?',
      options: <String>[
        'Ein Engel schlug das assyrische Heer in einer einzigen Nacht',
        'Hiskia musste sich ergeben',
        'Eine Hungersnot schwächte Juda',
        'Es kam gar keine Antwort',
      ],
      correctIndex: 0,
      explanation: 'Eine spektakuläre Rettung folgt auf das Gebet (Jesaja 37).',
    ),
    QuizQuestion(
      text:
          'Woran erinnert Jesaja 40 bezüglich der menschlichen Natur im Vergleich zu Gott?',
      options: <String>[
        'Alles Fleisch ist wie Gras, das verwelkt',
        'Der Mensch ist von Natur aus ewig',
        'Gott hängt vom Menschen ab',
        'Gottes Wort ändert sich oft',
      ],
      correctIndex: 0,
      explanation:
          '„Das Wort unseres Gottes besteht auf unabsehbare Zeit“ (Jesaja 40:8).',
    ),
  ],
  'Isaiah#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie beschreibt Jesaja 42 die Sanftmut von Jehovas Diener?',
      options: <String>[
        'Er wird ein geknicktes Rohr nicht zerbrechen',
        'Er wird alles auf seinem Weg zerstören',
        'Er wird die Schwachen ignorieren',
        'Er wird mit systematischer Gewalt handeln',
      ],
      correctIndex: 0,
      explanation:
          'Bemerkenswerte Sanftmut kennzeichnet diesen Diener (Jesaja 42:3).',
    ),
    QuizQuestion(
      text:
          'Welcher fremde König wird von Jesaja im Voraus als Israels Befreier genannt?',
      options: <String>['Cyrus', 'Nebukadnezar', 'Darius', 'Xerxes'],
      correctIndex: 0,
      explanation:
          'Eine bemerkenswerte Prophezeiung nennt Cyrus namentlich (Jesaja 44-45).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Cyrus', 'Kyros'],
    ),
    QuizQuestion(
      text:
          'Was sagt Jesaja 48 über die frühere Haltung des Volkes gegenüber Gottes Geboten?',
      options: <String>[
        'Hätten sie doch nur früher aufgemerkt',
        'Sie gehorchten stets vollkommen',
        'Die Gebote spielten keine Rolle',
        'Gott verlangte nie etwas von ihnen',
      ],
      correctIndex: 0,
      explanation:
          'Ein Bedauern über ihr Versäumnis zuzuhören wird ausgedrückt (Jesaja 48:18).',
    ),
  ],
  'Isaiah#6': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie beschreibt Jesaja 53 das Leiden von Jehovas Diener?',
      options: <String>[
        'Er wurde wegen unserer Übertretungen durchbohrt',
        'Er lebte, ohne je zu leiden',
        'Er herrschte sofort, ohne Prüfung',
        'Er wurde von Geburt an geehrt',
      ],
      correctIndex: 0,
      explanation:
          'Ein zentrales Kapitel über erlösendes Leiden (Jesaja 53:5).',
    ),
    QuizQuestion(
      text: 'Welche kostenlose Einladung wird in Jesaja 55 ausgesprochen?',
      options: <String>[
        'Kommt, kauft Wein und Milch ohne Geld',
        'Bezahlt teuer, um Weisheit zu erlangen',
        'Nur die Reichen dürfen kommen',
        'Es wird keine Einladung ausgesprochen',
      ],
      correctIndex: 0,
      explanation: 'Ein großzügiges, universelles Angebot (Jesaja 55:1).',
    ),
    QuizQuestion(
      text: 'Was definiert Jesaja 58 als wahres „Fasten“ in Gottes Augen?',
      options: <String>[
        'Sein Brot mit dem Hungrigen zu teilen und Unterdrückte freizulassen',
        'Nur auf Essen zu verzichten',
        'Besondere Kleidung zu tragen',
        'Den ganzen Tag zu schweigen',
      ],
      correctIndex: 0,
      explanation:
          'Wahres Fasten zeigt sich durch Taten der Gerechtigkeit (Jesaja 58:6, 7).',
    ),
  ],
  'Isaiah#7': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Hoffnungsbild eröffnet Jesaja 60 für Zion?',
      options: <String>[
        'Steh auf, werde licht, denn dein Licht ist gekommen',
        'Bleibe für immer in Dunkelheit',
        'Fliehe weit weg von deiner Stadt',
        'Warte ohne Hoffnung',
      ],
      correctIndex: 0,
      explanation:
          'Ein strahlender Aufruf zur Wiederherstellung (Jesaja 60:1).',
    ),
    QuizQuestion(
      text:
          'Welche Aussage aus Jesaja 61 las Jesus in der Synagoge von Nazareth vor?',
      options: <String>[
        '„Der Geist des Souveränen Herrn Jehova ist auf mir“',
        '„Ich komme, um die ganze Welt zu richten“',
        '„Der Tempel wird zerstört werden“',
        '„Niemand wird gerettet werden“',
      ],
      correctIndex: 0,
      explanation:
          'Jesus wendet diese Stelle auf sich selbst an (Lukas 4, zitiert Jesaja 61:1).',
    ),
    QuizQuestion(
      text: 'Was verheißt Jesaja 65 bezüglich der Zukunft der Schöpfung?',
      options: <String>[
        'Neue Himmel und eine neue Erde',
        'Endgültige Zerstörung ohne Wiederherstellung',
        'Ein Königreich, beschränkt auf eine einzige Nation',
        'Das Ende allen tierischen Lebens',
      ],
      correctIndex: 0,
      explanation:
          'Eine Hoffnungsverheißung beschließt das Buch (Jesaja 65:17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jerusalem', 'Licht', 'Herrlichkeit'],
    ),
  ],
  'Jeremiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was sagt Jehova Jeremia über seine Berufung, noch bevor er geboren wurde?',
      options: <String>[
        '„Bevor ich dich im Mutterleib formte, kannte ich dich“',
        'Er erwählte ihn erst im Erwachsenenalter',
        'Jeremia meldete sich selbst freiwillig',
        'Es wird keine besondere Berufung erwähnt',
      ],
      correctIndex: 0,
      explanation:
          'Eine prophetische Berufung, festgelegt schon vor seiner Geburt (Jeremia 1:5).',
    ),
    QuizQuestion(
      text: 'Womit vergleicht Jehova Israels Untreue in Kapitel 2?',
      options: <String>[
        'Mit einer Frau, die ihren Mann vergessen hat',
        'Mit einem treuen König',
        'Mit einem vorbildlichen Diener',
        'Mit einer stets loyalen Nation',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild der Beziehungsverlassenheit (Jeremia 2).',
    ),
    QuizQuestion(
      text: 'Welches falsche Vertrauen prangert Jeremia in Kapitel 7 an?',
      options: <String>[
        'Wie eine Zauberformel zu wiederholen: „Dies ist der Tempel Jehovas“',
        'Übermäßiges Vertrauen in Jeremia selbst',
        'Vertrauen allein in das Heer',
        'Vertrauen in ausländische Propheten',
      ],
      correctIndex: 0,
      explanation:
          'Das Volk glaubt fälschlich, der Tempel schütze es automatisch (Jeremia 7).',
    ),
  ],
  'Jeremiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Welche berühmte Frage stellt Jeremia in Kapitel 12?',
      options: <String>[
        'Warum gedeiht der Weg der Bösen?',
        'Warum ist Babylon so schwach?',
        'Warum ist der Tempel leer?',
        'Warum sind die Priester abwesend?',
      ],
      correctIndex: 0,
      explanation: 'Jeremia äußert eine aufrichtige Klage (Jeremia 12:1).',
    ),
    QuizQuestion(
      text: 'Wofür steht der verdorbene Leinengürtel in Jeremia 13?',
      options: <String>[
        'Für die Verderbtheit des Stolzes Judas',
        'Für den wiedererlangten Reichtum des Volkes',
        'Für ein solides Bündnis mit Ägypten',
        'Für die Reinheit des Priestertums',
      ],
      correctIndex: 0,
      explanation: 'Ein sichtbares Zeichen moralischen Verfalls (Jeremia 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gürtel', 'Leinen', 'Fluss'],
    ),
    QuizQuestion(
      text:
          'Was erkennt Jeremia in Kapitel 10 über das menschliche Verhalten an?',
      options: <String>[
        'Ein Mensch, der geht, kann seinen Schritt nicht selbst lenken',
        'Es ist von Natur aus gut',
        'Es ändert sich nie',
        'Es ist Gott unwichtig',
      ],
      correctIndex: 0,
      explanation:
          '„Es steht dem Menschen, der geht, nicht zu, seinen Schritt zu lenken“ (Jeremia 10:23).',
    ),
  ],
  'Jeremiah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Bild gibt Jehova Jeremia im Haus des Töpfers?',
      options: <String>[
        'Wie Ton in der Hand des Töpfers ist Israel in Gottes Hand',
        'Der Töpfer steht für einen fremden König',
        'Der Ton steht für Reichtum',
        'Es wird keine geistige Lehre daraus gezogen',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild göttlicher Souveränität (Jeremia 18).',
    ),
    QuizQuestion(
      text:
          'Wie wurde Jeremia behandelt, nachdem er gegen Jerusalem prophezeit hatte?',
      options: <String>[
        'Er wurde von Paschhur geschlagen und in den Block gelegt',
        'Er wurde öffentlich geehrt',
        'Er wurde zum Hohen Priester ernannt',
        'Er wurde als Gesandter geschickt',
      ],
      correctIndex: 0,
      explanation: 'Jeremia leidet für seine treue Botschaft (Jeremia 20).',
    ),
    QuizQuestion(
      text: 'Welche Wahl bietet Jeremia dem belagerten Volk in Kapitel 21 an?',
      options: <String>[
        'Sich Babylon ergeben (Leben) oder Widerstand leisten (Tod)',
        'Sofort nach Ägypten fliehen',
        'Babylon zuerst angreifen',
        'Mit Assyrien verhandeln',
      ],
      correctIndex: 0,
      explanation:
          'Eine schwierige, aber klare Wahl wird gestellt (Jeremia 21).',
    ),
  ],
  'Jeremiah#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was verheißt Jeremia 23 bezüglich eines künftigen gerechten Königs?',
      options: <String>[
        'Ein „gerechter Spross“ wird mit Weisheit regieren',
        'Es wird nie ein gerechter König kommen',
        'Die falschen Hirten werden für immer herrschen',
        'Das Königreich wird ohne Nachfolger verschwinden',
      ],
      correctIndex: 0,
      explanation:
          'Eine messianische Verheißung im Gegensatz zu den schlechten Hirten (Jeremia 23:5).',
    ),
    QuizQuestion(
      text: 'Wie viele Jahre der Gefangenschaft in Babylon kündigt Jeremia an?',
      options: <String>['70 Jahre', '7 Jahre', '40 Jahre', '400 Jahre'],
      correctIndex: 0,
      explanation: 'Diese genaue Dauer wird prophezeit (Jeremia 25:11).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['siebzig Jahre'],
    ),
    QuizQuestion(
      text: 'Was rät Jeremia den Verbannten in Babylon in seinem Brief?',
      options: <String>[
        'Häuser zu bauen und den Frieden der Stadt zu suchen',
        'Sofort zu revoltieren',
        'Jede Arbeit zu verweigern',
        'Die örtlichen Behörden zu ignorieren',
      ],
      correctIndex: 0,
      explanation: 'Realistischer Rat für das Leben im Exil (Jeremia 29).',
    ),
  ],
  'Jeremiah#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was verheißt Jehova in der berühmten Prophezeiung über den neuen Bund?',
      options: <String>[
        'Sein Gesetz wird auf die Herzen des Volkes geschrieben werden',
        'Ein neuer Tempel wird sofort gebaut',
        'Es ist kein künftiger Bund geplant',
        'Das Priestertum wird ersatzlos abgeschafft',
      ],
      correctIndex: 0,
      explanation:
          'Ein innerlicher, persönlicher Bund wird angekündigt (Jeremia 31:33).',
    ),
    QuizQuestion(
      text:
          'Welche symbolische Handlung führt Jeremia mitten in der Krise aus, als er ein Feld kauft?',
      options: <String>[
        'Er drückt seinen Glauben an eine künftige Wiederherstellung aus',
        'Er will sich bereichern',
        'Er flieht aus der belagerten Stadt',
        'Er verhandelt mit Babylon',
      ],
      correctIndex: 0,
      explanation:
          'Dieser Kauf bezeugt Hoffnung trotz der Belagerung (Jeremia 32).',
    ),
    QuizQuestion(
      text: 'Welches Beispiel der Treue geben die Rechabiter Juda?',
      options: <String>[
        'Ihren strengen Gehorsam gegenüber dem Gebot ihres Vorfahren',
        'Ihren großen Reichtum',
        'Ihre militärische Macht',
        'Ihr Bündnis mit Ägypten',
      ],
      correctIndex: 0,
      explanation:
          'Ihre Treue steht im Gegensatz zu Judas Untreue (Jeremia 35).',
    ),
  ],
  'Jeremiah#5': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wer rettete Jeremia, nachdem er in eine schlammige Zisterne geworfen worden war?',
      options: <String>['Ebed-Melech', 'Baruch', 'Gedalja', 'Ismael'],
      correctIndex: 0,
      explanation: 'Dieser Äthiopier greift mutig ein (Jeremia 38).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Wer wurde nach dem Fall Jerusalems zum Statthalter ernannt und dann ermordet?',
      options: <String>['Gedalja', 'Zedekia', 'Ismael', 'Baruch'],
      correctIndex: 0,
      explanation: 'Seine Ermordung löst weiteren Aufruhr aus (Jeremia 40-41).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Was tut der Rest des Volkes trotz Jeremias Warnung, im Land zu bleiben?',
      options: <String>[
        'Sie fliehen nach Ägypten und nehmen Jeremia mit',
        'Sie unterwerfen sich voll und ganz dem Rat des Propheten',
        'Sie greifen Babylon an',
        'Sie zerstreuen sich nach Assyrien',
      ],
      correctIndex: 0,
      explanation: 'Ihr Ungehorsam verschlimmert ihre Lage (Jeremia 43).',
    ),
  ],
  'Jeremiah#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Gegen welche Nationen sprechen die Schlusskapitel von Jeremia Gerichte aus?',
      options: <String>[
        'Ägypten, die Philister, Moab, Ammon, Babylon und andere',
        'Nur Israel',
        'Keine fremde Nation',
        'Nur Juda',
      ],
      correctIndex: 0,
      explanation:
          'Eine Reihe von Sprüchen gegen die Nationen beschließt das Buch (Jeremia 46-51).',
    ),
    QuizQuestion(
      text:
          'Welches symbolische Zeichen begleitet die an Seraja übergebene Prophezeiung gegen Babylon?',
      options: <String>[
        'Die Buchrolle wird in den Euphrat geworfen, um zu sinken',
        'Sie wird öffentlich verbrannt',
        'Sie wird dem König von Babylon vorgelesen',
        'Sie wird im Tempel versteckt',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild von Babylons endgültigem Untergang (Jeremia 51).',
    ),
    QuizQuestion(
      text: 'Wie endet das Buch Jeremia historisch gesehen?',
      options: <String>[
        'Mit Jojachins Freilassung aus dem Gefängnis in Babylon',
        'Mit der sofortigen Rückkehr des ganzen Volkes',
        'Mit dem Wiederaufbau des Tempels',
        'Mit einem militärischen Sieg für Juda',
      ],
      correctIndex: 0,
      explanation: 'Ein historischer Epilog beschließt das Buch (Jeremia 52).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesDeC3 =
    <String, List<QuizQuestion>>{};
