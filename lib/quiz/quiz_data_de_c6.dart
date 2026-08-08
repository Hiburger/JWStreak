import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesDeC6 = <String, List<QuizQuestion>>{
  'Romans#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was erklärt Paulus in Römer 3 über die Lage aller Menschen, Juden wie Nichtjuden?',
      options: <String>[
        'Alle haben gesündigt und erreichen die Herrlichkeit Gottes nicht',
        'Nur Nichtjuden haben gesündigt',
        'Niemand hat wirklich gesündigt',
        'Nur die Führer sind verantwortlich',
      ],
      correctIndex: 0,
      explanation:
          'Eine wesentliche Grundlage von Paulus\' Argumentation (Römer 3:23).',
    ),
    QuizQuestion(
      text:
          'Worauf beruht laut Römer 3-4 die Rechtfertigung, veranschaulicht am Beispiel Abrahams?',
      options: <String>[
        'Auf dem Glauben, nicht auf Werken des Gesetzes',
        'Allein auf rituellen Opfern',
        'Auf persönlichem Reichtum',
        'Auf der ethnischen Herkunft',
      ],
      correctIndex: 0,
      explanation: 'Abraham wurde durch Glauben für gerecht erklärt (Römer 4).',
    ),
  ],
  'Romans#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Was erklärt Römer 8 über Gottes Liebe zu den Christen?',
      options: <String>[
        'Nichts kann uns von der Liebe Gottes trennen',
        'Diese Liebe ist bedingt und zerbrechlich',
        'Sie betrifft nur wenige Auserwählte',
        'Sie verschwindet in Zeiten der Prüfung',
      ],
      correctIndex: 0,
      explanation:
          'Eine kraftvolle Aussage beschließt dieses Kapitel (Römer 8:38, 39).',
    ),
    QuizQuestion(
      text: 'Was sagt Römer 10 über die Rettung?',
      options: <String>[
        'Jeder, der den Namen Jehovas anruft, wird gerettet werden',
        'Nur Priester können gerettet werden',
        'Die Rettung hängt allein von der Geburt ab',
        'Für die Nationen ist keine Rettung möglich',
      ],
      correctIndex: 0,
      explanation: 'Eine universelle Verheißung wird zitiert (Römer 10:13).',
    ),
  ],
  'Romans#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Worum bittet Römer 12 die Christen bezüglich ihres täglichen Lebens?',
      options: <String>[
        'Sich Gott als lebendiges Opfer darzubringen',
        'Jede gesellschaftliche Tätigkeit zu meiden',
        'Sich völlig aus der Welt zurückzuziehen',
        'Ihre Gaben nie zu benutzen',
      ],
      correctIndex: 0,
      explanation: 'Ein Aufruf zu praktischer Hingabe (Römer 12:1).',
    ),
    QuizQuestion(
      text: 'Welchen Grundsatz stellt Römer 13 bezüglich der Obrigkeit auf?',
      options: <String>[
        'Sich den übergeordneten Autoritäten unterzuordnen',
        'Gesetze systematisch zu ignorieren',
        'Sich gegen jede Regierung aufzulehnen',
        'Steuern nur nach Belieben zu zahlen',
      ],
      correctIndex: 0,
      explanation:
          'Ein Grundsatz bürgerlichen Respekts wird gelehrt (Römer 13).',
    ),
  ],
  '1 Corinthians#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welches Problem spricht Paulus gleich zu Beginn dieses Briefes an?',
      options: <String>[
        'Spaltungen und Rivalitäten in der Versammlung',
        'Einen Mangel an Nahrung',
        'Eine militärische Invasion',
        'Ein völliges Fehlen von Glauben',
      ],
      correctIndex: 0,
      explanation:
          'Parteiungen um verschiedene Lehrer verursachten Probleme (1. Korinther 1).',
    ),
    QuizQuestion(
      text: 'Womit vergleicht Paulus die Gemeinde in 1. Korinther 3?',
      options: <String>[
        'Mit dem Tempel Gottes',
        'Mit einem Heer',
        'Mit einem einfachen leeren Gebäude',
        'Mit einem Geschäftsunternehmen',
      ],
      correctIndex: 0,
      explanation:
          'Ein heiliges Bild unterstreicht ihre gemeinsame Verantwortung (1. Korinther 3:16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Körper', 'Geist', 'Stein'],
    ),
  ],
  '1 Corinthians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie geht Paulus mit der Frage der Götzenopferspeise um?',
      options: <String>[
        'Liebe und Rücksicht auf das Gewissen des Nächsten gehen vor Freiheit',
        'Er verbietet es absolut, ohne Ausnahme',
        'Er ermutigt vorbehaltlos dazu',
        'Er weigert sich, das Thema anzusprechen',
      ],
      correctIndex: 0,
      explanation:
          'Ein Gleichgewicht zwischen Freiheit und Rücksicht auf andere (1. Korinther 8).',
    ),
    QuizQuestion(
      text:
          'Welche Haltung nimmt Paulus laut 1. Korinther 9 ein, um Menschen für die gute Botschaft zu gewinnen?',
      options: <String>[
        'Allen alles werden, soweit es möglich ist',
        'In all seinen Gewohnheiten starr bleiben',
        'Jeden Kontakt mit anderen Kulturen meiden',
        'Bezahlung für das Predigen verlangen',
      ],
      correctIndex: 0,
      explanation:
          'Eine von Liebe motivierte Flexibilität (1. Korinther 9:22).',
    ),
  ],
  '1 Corinthians#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Womit vergleicht Paulus die Vielfalt der geistigen Gaben in der Versammlung?',
      options: <String>[
        'Mit den verschiedenen Teilen eines einzigen Körpers',
        'Mit getrennten Rivalen',
        'Mit unverbundenen Fremden',
        'Mit Gaben ohne Zweck',
      ],
      correctIndex: 0,
      explanation: 'Ein Bild der Einheit in Vielfalt (1. Korinther 12).',
    ),
    QuizQuestion(
      text:
          'Welche Eigenschaft beschreibt Paulus im berühmten Kapitel 13 als größer als alle Gaben?',
      options: <String>['Liebe', 'Reichtum', 'Ruhm', 'Macht'],
      correctIndex: 0,
      explanation: 'Ohne Liebe ist alles andere wertlos (1. Korinther 13).',
      type: QuizAnswerType.freeText,
    ),
  ],
  '2 Corinthians#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie beschreibt Paulus den Trost, den er in seiner Prüfung erhielt?',
      options: <String>[
        'Einen Trost, der später mit anderen geteilt werden soll',
        'Einen Trost, der nur ihm selbst vorbehalten ist',
        'Ein völliges Fehlen von Trost',
        'Einen Trost, der nur von Menschen kommt',
      ],
      correctIndex: 0,
      explanation:
          'Göttlicher Trost wird an andere weitergegeben (2. Korinther 1).',
    ),
    QuizQuestion(
      text:
          'Womit vergleicht Paulus die verwandelten Christen in 2. Korinther 3-4?',
      options: <String>[
        'Mit kostbaren Schätzen in zerbrechlichen Tongefäßen',
        'Mit mächtigen Königen',
        'Mit unbesiegbaren Kriegern',
        'Mit unveränderlichen Statuen',
      ],
      correctIndex: 0,
      explanation:
          'Ein Bild von Demut und göttlicher Kraft (2. Korinther 4:7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gold', 'Gefäß', 'Licht'],
    ),
  ],
  '2 Corinthians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Welchen zentralen Appell macht Paulus in 2. Korinther 5?',
      options: <String>[
        'Lasst euch mit Gott versöhnen',
        'Sucht vor allem Reichtum',
        'Meidet jede Predigttätigkeit',
        'Flieht vor jeder Verantwortung',
      ],
      correctIndex: 0,
      explanation: 'Die zentrale Botschaft der Versöhnung (2. Korinther 5:20).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gesandte', 'Christus', 'Frieden'],
    ),
    QuizQuestion(
      text:
          'Welchen Grundsatz lehrt Paulus in 2. Korinther 9 über großzügiges Geben?',
      options: <String>[
        'Gott liebt einen fröhlichen Geber',
        'Geben muss immer erzwungen werden',
        'Nur die Reichen sollten geben',
        'Geben spielt keine Rolle',
      ],
      correctIndex: 0,
      explanation: '„Gott liebt einen fröhlichen Geber“ (2. Korinther 9:7).',
    ),
  ],
  '2 Corinthians#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie reagiert Paulus auf seinen „Dorn im Fleisch“ in 2. Korinther 12?',
      options: <String>[
        'Er akzeptiert, dass Gottes Kraft sich in Schwachheit als vollkommen erweist',
        'Er gibt seinen Dienst auf',
        'Er verlangt sofortige Heilung',
        'Er beschuldigt Gott der Ungerechtigkeit',
      ],
      correctIndex: 0,
      explanation:
          '„Meine Kraft wird in Schwachheit vollkommen gemacht“ (2. Korinther 12:9).',
    ),
    QuizQuestion(
      text: 'Welchen abschließenden Appell macht Paulus in 2. Korinther 13?',
      options: <String>[
        'Sich selbst zu prüfen, ob sie im Glauben sind',
        'Jede Selbstprüfung zu ignorieren',
        'Andere nur hart zu richten',
        'Jede geistige Reflexion aufzugeben',
      ],
      correctIndex: 0,
      explanation:
          'Ein Aufruf zu aufrichtiger Selbstprüfung (2. Korinther 13:5).',
    ),
  ],
  'Galatians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Woher, sagt Paulus, kommt seine apostolische Vollmacht?',
      options: <String>[
        'Direkt von Jesus Christus, nicht von Menschen',
        'Allein von der Einsetzung der Apostel in Jerusalem',
        'Aus seiner eigenen persönlichen Entscheidung',
        'Aus einer Familientradition',
      ],
      correctIndex: 0,
      explanation:
          'Paulus verteidigt die Rechtmäßigkeit seiner Mission (Galater 1).',
    ),
    QuizQuestion(
      text: 'Warum tadelte Paulus Petrus öffentlich?',
      options: <String>[
        'Petrus vermied heuchlerisch, mit Nichtjuden zu essen',
        'Petrus hatte Geld gestohlen',
        'Petrus hatte seinen Glauben verleugnet',
        'Petrus weigerte sich zu predigen',
      ],
      correctIndex: 0,
      explanation:
          'Eine praktische Widersprüchlichkeit wird korrigiert (Galater 2).',
    ),
  ],
  'Galatians#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Worauf beruht laut Galater 3 die Rechtfertigung, veranschaulicht am Beispiel Abrahams?',
      options: <String>[
        'Auf dem Glauben, nicht auf Werken des Gesetzes',
        'Allein auf biologischer Abstammung',
        'Auf persönlichem Reichtum',
        'Auf gesellschaftlichem Status',
      ],
      correctIndex: 0,
      explanation: 'Ein zentraler Grundsatz aus Abrahams Leben (Galater 3:6).',
    ),
    QuizQuestion(
      text:
          'Welche Rolle spielte das Gesetz laut Galater 3-4, während man auf Christus wartete?',
      options: <String>[
        'Die eines Erziehers, der zu Christus hinführt',
        'Ein endgültiges Mittel zur Rettung',
        'Ein bloßes Ritual ohne Bedeutung',
        'Ein Fluch ohne Zweck',
      ],
      correctIndex: 0,
      explanation:
          'Das Gesetz bereitete den Weg für den Messias vor (Galater 3:24).',
    ),
  ],
  'Galatians#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Frucht des Geistes hebt Galater 5 im Gegensatz zu den Werken des Fleisches hervor?',
      options: <String>[
        'Liebe, Freude, Frieden, Geduld und andere Eigenschaften',
        'Reichtum und Macht',
        'Persönlichen Ehrgeiz',
        'Herrschaft über andere',
      ],
      correctIndex: 0,
      explanation:
          'Eine Liste wesentlicher christlicher Eigenschaften (Galater 5:22, 23).',
    ),
    QuizQuestion(
      text: 'Was rät Galater 6 bezüglich der Lasten anderer?',
      options: <String>[
        'Einer trage des anderen Lasten',
        'Sie völlig zu ignorieren',
        'Sie hart zu richten',
        'Sie um jeden Preis zu meiden',
      ],
      correctIndex: 0,
      explanation:
          'Ein Aufruf zu brüderlicher gegenseitiger Unterstützung (Galater 6:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gesetz', 'Geist', 'Fleisch'],
    ),
  ],
  'Ephesians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wodurch werden die Christen laut Epheser 2 gerettet?',
      options: <String>[
        'Durch unverdiente Güte, mittels Glauben, nicht durch Werke',
        'Nur durch ihre guten Taten',
        'Durch ihre ethnische Herkunft',
        'Durch ihren materiellen Reichtum',
      ],
      correctIndex: 0,
      explanation: 'Ein grundlegender Rettungsgrundsatz (Epheser 2:8, 9).',
    ),
    QuizQuestion(
      text:
          'Was bewirkt Christus laut Epheser 2 zwischen Juden und Nichtjuden?',
      options: <String>[
        'Er vereint sie zu einer neuen Menschheit',
        'Er erhält eine dauerhafte Trennung aufrecht',
        'Er bevorzugt eine Gruppe gegenüber der anderen',
        'Er ignoriert diesen Unterschied',
      ],
      correctIndex: 0,
      explanation: 'Die Trennungsmauer wird niedergerissen (Epheser 2:14).',
    ),
  ],
  'Ephesians#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welches „Geheimnis“, sagt Paulus, wurde ihm anvertraut, um es den Nationen zu offenbaren?',
      options: <String>[
        'Dass Nichtjuden Miterben der Verheißung sind',
        'Ein wenigen Privilegierten vorbehaltenes Geheimnis',
        'Eine verborgene Lehre über Engel',
        'Eine Prophezeiung über Rom',
      ],
      correctIndex: 0,
      explanation: 'Eine unerwartete Einbeziehung der Nationen (Epheser 3:6).',
    ),
    QuizQuestion(
      text: 'Was müssen Christen laut Epheser 4 „anziehen“?',
      options: <String>[
        'Die neue Persönlichkeit, wie Gott',
        'Prächtige Kleidung',
        'Sichtbaren Reichtum',
        'Einen höheren gesellschaftlichen Status',
      ],
      correctIndex: 0,
      explanation:
          'Eine tiefgreifende innere Veränderung wird gefordert (Epheser 4:24).',
    ),
  ],
  'Ephesians#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Womit vergleicht Paulus die Beziehung zwischen Mann und Frau in Epheser 5?',
      options: <String>[
        'Mit der Beziehung zwischen Christus und der Versammlung',
        'Mit einer bloßen Geschäftspartnerschaft',
        'Mit einer Hierarchie ohne Liebe',
        'Mit einem ständigen Wettbewerb',
      ],
      correctIndex: 0,
      explanation:
          'Ein Vorbild selbstaufopfernder Liebe wird dargestellt (Epheser 5:25).',
    ),
    QuizQuestion(
      text:
          'Wofür steht „die vollständige Waffenrüstung von Gott“ in Epheser 6?',
      options: <String>[
        'Für geistige Eigenschaften, um dem geistigen Kampf zu widerstehen',
        'Für buchstäbliche militärische Ausrüstung',
        'Für eine bloße Metapher ohne Anwendung',
        'Für eine religiöse Uniform',
      ],
      correctIndex: 0,
      explanation:
          'Jedes Teil steht für eine schützende Eigenschaft (Epheser 6:11-17).',
    ),
  ],
  'Philippians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie sieht Paulus in diesem Brief seine Gefangenschaft?',
      options: <String>[
        'Er freut sich darüber, da sie dem Fortschritt der guten Botschaft dient',
        'Er ist völlig verzweifelt darüber',
        'Er gibt seinen Dienst auf',
        'Er beschuldigt seine Wärter hoffnungslos',
      ],
      correctIndex: 0,
      explanation: 'Eine positive Haltung trotz Not (Philipper 1).',
    ),
    QuizQuestion(
      text:
          'Welche berühmte Aussage fasst Paulus\' Sicht auf Leben und Tod zusammen?',
      options: <String>[
        '„Für mich ist das Leben Christus, und der Tod ist Gewinn“',
        '„Das Leben hat keinen Sinn“',
        '„Es ist besser, jeder Prüfung zu fliehen“',
        '„Der Tod ist um jeden Preis zu vermeiden“',
      ],
      correctIndex: 0,
      explanation: 'Ein völliges Vertrauen auf Christus (Philipper 1:21).',
    ),
  ],
  'Philippians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Welches Beispiel der Demut stellt Paulus in Philipper 2 vor?',
      options: <String>[
        'Christus, der sich erniedrigte, um ein Sklave zu werden',
        'Einen mächtigen und herrlichen König',
        'Einen berühmten Philosophen',
        'Einen siegreichen General',
      ],
      correctIndex: 0,
      explanation: 'Ein Vorbild äußerster Demut (Philipper 2:5-8).',
    ),
    QuizQuestion(
      text:
          'Worauf, sagt Paulus, verzichtete er, um Christus zu gewinnen, in Philipper 3?',
      options: <String>[
        'Auf all seine früheren Vorteile und Errungenschaften',
        'Auf nichts Besonderes',
        'Nur auf seine Staatsangehörigkeit',
        'Auf sein Gebetsleben',
      ],
      correctIndex: 0,
      explanation:
          'Er betrachtet alles als Verlust im Vergleich zu Christus (Philipper 3:8).',
    ),
  ],
  'Philippians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was verheißt Philipper 4 denen, die ohne Sorge beten?',
      options: <String>[
        'Den Frieden Gottes, der alles Denken übertrifft',
        'Sofortigen Reichtum',
        'Ein völliges Fehlen von Problemen',
        'Nichts Besonderes',
      ],
      correctIndex: 0,
      explanation: 'Eine Verheißung inneren Friedens (Philipper 4:6, 7).',
    ),
    QuizQuestion(
      text:
          'Welche Vertrauensaussage macht Paulus über seine persönliche Kraft?',
      options: <String>[
        '„Für alles habe ich die Kraft durch den, der mir Macht gibt“',
        '„Ich habe allein Erfolg, ohne Hilfe“',
        '„Ich hänge nur von Menschen ab“',
        '„Nichts trägt mich wirklich“',
      ],
      correctIndex: 0,
      explanation:
          'Ein Vertrauen, das auf Christus gesetzt wird (Philipper 4:13).',
    ),
  ],
  'Colossians#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie beschreibt Kolosser 1 Christi Stellung in Bezug auf die Schöpfung?',
      options: <String>[
        'Alles wurde durch ihn und für ihn geschaffen',
        'Er ist ein Geschöpf unter anderen, ohne Unterschied',
        'Er hat keine Rolle in der Schöpfung',
        'Er kam nach der ganzen Schöpfung',
      ],
      correctIndex: 0,
      explanation:
          'Christus wird eine zentrale Stellung eingeräumt (Kolosser 1:16).',
    ),
    QuizQuestion(
      text:
          'Welches „Geheimnis“, sagt Paulus, hat er die Aufgabe zu offenbaren?',
      options: <String>[
        'Christus in euch, die Hoffnung auf Herrlichkeit',
        'Eine wenigen heimlich vorbehaltene Lehre',
        'Eine Prophezeiung über Rom',
        'Ein verborgenes Tempelritual',
      ],
      correctIndex: 0,
      explanation:
          'Eine Wahrheit, die nun öffentlich gemacht wird (Kolosser 1:27).',
    ),
  ],
  'Colossians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Wovor warnt Paulus in Kolosser 2?',
      options: <String>[
        'Vor leerer Philosophie und menschlichen Überlieferungen',
        'Vor dem Gebet selbst',
        'Vor echtem Glauben',
        'Vor der Lehre der Apostel',
      ],
      correctIndex: 0,
      explanation: 'Eine Warnung vor falschen Lehren (Kolosser 2:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Beschneidung', 'Engel', 'Weisheit'],
    ),
    QuizQuestion(
      text: 'Was müssen Christen laut Kolosser 3 „anziehen“?',
      options: <String>[
        'Die neue Persönlichkeit, mit Mitgefühl und Liebe',
        'Kostbare Kleidung',
        'Eine Haltung der Überlegenheit',
        'Nichts Besonderes',
      ],
      correctIndex: 0,
      explanation:
          'Eine konkrete innere Veränderung wird gefordert (Kolosser 3:10, 12).',
    ),
  ],
  'Colossians#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie ermutigt Paulus die Gläubigen, sich gegenüber Außenstehenden zu verhalten?',
      options: <String>[
        'Mit Weisheit, indem sie die Zeit bestmöglich nutzen',
        'Mit völliger Gleichgültigkeit',
        'Indem sie sie systematisch meiden',
        'Mit offener Verachtung',
      ],
      correctIndex: 0,
      explanation: 'Weises Verhalten wird empfohlen (Kolosser 4:5).',
    ),
    QuizQuestion(
      text: 'Welcher Ton prägt das Ende des Briefes an die Kolosser?',
      options: <String>[
        'Warmherzige persönliche Grüße',
        'Ein hartes Urteil',
        'Eine Liste zusätzlicher Gesetze',
        'Ein abruptes Schweigen',
      ],
      correctIndex: 0,
      explanation: 'Paulus schließt mit liebevollen Grüßen (Kolosser 4).',
    ),
  ],
  '1 Thessalonians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie beschreibt Paulus den Glauben der Thessalonicher?',
      options: <String>[
        'Ein Beispiel für die Gläubigen in ihrer Umgebung',
        'Schwach und zögerlich',
        'Anfangs nicht vorhanden',
        'Nur auf Furcht gegründet',
      ],
      correctIndex: 0,
      explanation:
          'Ihr Glaube wurde zu einem anerkannten Vorbild (1. Thessalonicher 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Last', 'Scham', 'Vorbild'],
    ),
    QuizQuestion(
      text: 'Wie beschreibt Paulus seinen Dienst unter ihnen?',
      options: <String>[
        'Aufrichtig, wie eine Mutter, die sich um ihre Kinder kümmert',
        'Eigennützig und berechnend',
        'Distanziert und kalt',
        'Auf Schmeichelei gegründet',
      ],
      correctIndex: 0,
      explanation:
          'Ein zärtliches Bild seiner Hingabe (1. Thessalonicher 2:7).',
    ),
  ],
  '1 Thessalonians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Warum sandte Paulus Timotheus zu den Thessalonichern?',
      options: <String>[
        'Um ihren Glauben angesichts der Prüfungen zu stärken',
        'Um nur Geld zu sammeln',
        'Um sie streng zu tadeln',
        'Um die Versammlung aufzulösen',
      ],
      correctIndex: 0,
      explanation:
          'Hirtliche Fürsorge motivierte diese Botschaft (1. Thessalonicher 3).',
    ),
    QuizQuestion(
      text:
          'Welches Gefühl drückt Paulus aus, als er von ihrer anhaltenden Treue erfährt?',
      options: <String>[
        'Große Freude',
        'Enttäuschung',
        'Gleichgültigkeit',
        'Zorn',
      ],
      correctIndex: 0,
      explanation:
          'Ihre Standhaftigkeit tröstet ihn zutiefst (1. Thessalonicher 3:8, 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Kummer', 'Furcht', 'Frieden'],
    ),
  ],
  '1 Thessalonians#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Wie beschreibt 1. Thessalonicher 4 die Auferstehung der Gläubigen?',
      options: <String>[
        'Sie werden entrückt werden, um dem Herrn zu begegnen',
        'Sie werden für immer im Grab bleiben',
        'Keine Auferstehung wird erwähnt',
        'Nur wenige Privilegierte werden auferweckt',
      ],
      correctIndex: 0,
      explanation:
          'Eine zentrale Hoffnung für die Gläubigen (1. Thessalonicher 4:17).',
    ),
    QuizQuestion(
      text: 'Womit wird der Tag Jehovas in 1. Thessalonicher 5 verglichen?',
      options: <String>[
        'Mit einem Dieb in der Nacht',
        'Mit einem vorhersehbaren Fest',
        'Mit einem gewöhnlichen Tag',
        'Mit einer bloßen Warnung ohne Wirkung',
      ],
      correctIndex: 0,
      explanation:
          'Ein Bild eines plötzlichen, unerwarteten Eintreffens (1. Thessalonicher 5:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Trompete', 'Wolke', 'Braut'],
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesDeC6 =
    <String, List<QuizQuestion>>{};
