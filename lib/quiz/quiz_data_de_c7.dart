import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesDeC7 = <String, List<QuizQuestion>>{
  '2 Thessalonians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie ermutigt Paulus die verfolgten Thessalonicher?',
      options: <String>[
        'Indem er sie an das gerechte Gericht erinnert, das Gott vollziehen wird',
        'Indem er ihnen ein sofortiges Ende ihrer Prüfungen verspricht',
        'Indem er ihnen die Schuld an ihrer Lage gibt',
        'Indem er sie drängt, den Glauben aufzugeben',
      ],
      correctIndex: 0,
      explanation:
          'Die Hoffnung auf Gottes Gerechtigkeit ermutigt sie (2. Thessalonicher 1).',
    ),
    QuizQuestion(
      text: 'Wofür dankt Paulus Gott im Zusammenhang mit den Thessalonichern?',
      options: <String>[
        'Ihr Glaube wächst sehr und ihre Liebe nimmt zu',
        'Ihr Reichtum nimmt ständig zu',
        'Ihre Zahl geht jedes Jahr zurück',
        'Sie kommen nicht mehr zusammen',
      ],
      correctIndex: 0,
      explanation:
          'Paulus dankt Gott für ihre Fortschritte (2. Thessalonicher 1:3).',
    ),
  ],
  '2 Thessalonians#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was muss laut 2. Thessalonicher 2 vor dem Tag des Herrn erscheinen?',
      options: <String>[
        'Der Mensch der Gesetzlosigkeit',
        'Ein gerechter König',
        'Universeller Frieden',
        'Nichts Besonderes',
      ],
      correctIndex: 0,
      explanation:
          'Ein vorausgehendes Zeichen wird angekündigt (2. Thessalonicher 2:3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Satan', 'Zurückhaltung', 'Gericht'],
    ),
    QuizQuestion(
      text:
          'Welche Ermutigung gibt Paulus trotz dieser beunruhigenden Ankündigung?',
      options: <String>[
        'Fest an den empfangenen Lehren festzuhalten',
        'Jede Hoffnung aufzugeben',
        'Jede christliche Tätigkeit einzustellen',
        'Sich sofort zu zerstreuen',
      ],
      correctIndex: 0,
      explanation: 'Ein Aufruf zum Ausharren (2. Thessalonicher 2:15).',
    ),
  ],
  '2 Thessalonians#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welchen Grundsatz stellt Paulus über die Arbeit in 2. Thessalonicher 3 auf?',
      options: <String>[
        'Wenn jemand nicht arbeiten will, soll er auch nicht essen',
        'Arbeit ist für Christen nutzlos',
        'Nur die Reichen sollten arbeiten',
        'Arbeit ersetzt den Glauben',
      ],
      correctIndex: 0,
      explanation: 'Eine Warnung vor Faulheit (2. Thessalonicher 3:10).',
    ),
    QuizQuestion(
      text: 'Wie schließt Paulus diesen Brief ab?',
      options: <String>[
        'Mit einem Gruß in eigener Handschrift, ein Zeichen der Echtheit',
        'Mit einem abrupten Schweigen',
        'Mit einer neuen Anklage',
        'Mit einer Liste zusätzlicher Regeln',
      ],
      correctIndex: 0,
      explanation:
          'Seine Unterschrift bürgt für die Echtheit des Briefes (2. Thessalonicher 3:17).',
    ),
  ],
  '1 Timothy#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wovor warnt Paulus Timotheus gleich zu Beginn des Briefes?',
      options: <String>[
        'Vor abweichenden Lehren und endlosen Fabeln',
        'Vor einem Mangel an Reichtum',
        'Vor zu viel Gebet',
        'Vor der Ehe im Allgemeinen',
      ],
      correctIndex: 0,
      explanation:
          'Paulus möchte die Reinheit der Lehre bewahren (1. Timotheus 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gesetz', 'Geschlechtsregister', 'Mythen'],
    ),
    QuizQuestion(
      text: 'Für wen bittet Paulus in 1. Timotheus 2 um Gebete?',
      options: <String>[
        'Für alle Menschen, einschließlich Könige und Machthaber',
        'Nur für die Apostel',
        'Nur für seine eigene Familie',
        'Für niemanden Bestimmten',
      ],
      correctIndex: 0,
      explanation:
          'Ein alle einschließendes Gebet wird empfohlen (1. Timotheus 2:1, 2).',
    ),
  ],
  '1 Timothy#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Eigenschaften werden laut 1. Timotheus 3 von Aufsehern verlangt?',
      options: <String>[
        'Unantastbar, besonnen und gastfreundlich zu sein',
        'Vor allem wohlhabend zu sein',
        'Nur jung zu sein',
        'Große öffentliche Bekanntheit zu haben',
      ],
      correctIndex: 0,
      explanation:
          'Genaue sittliche Kriterien werden genannt (1. Timotheus 3).',
    ),
    QuizQuestion(
      text:
          'Was sagt 1. Timotheus 4 über körperliches Training im Vergleich zur Gottergebenheit?',
      options: <String>[
        'Gottergebenheit ist für alles nützlich, während körperliches Training begrenzt ist',
        'Körperliches Training ist wichtiger',
        'Keines von beiden hat Wert',
        'Nur körperliches Training zählt wirklich',
      ],
      correctIndex: 0,
      explanation: 'Eine Rangordnung wird aufgestellt (1. Timotheus 4:8).',
    ),
  ],
  '1 Timothy#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was empfiehlt 1. Timotheus 5 bezüglich bedürftiger Witwen?',
      options: <String>[
        'Dass zuerst die Familie für sie sorgt',
        'Sie völlig zu ignorieren',
        'Ihnen jede Hilfe zu verweigern',
        'Sie aus der Versammlung auszuschließen',
      ],
      correctIndex: 0,
      explanation:
          'Die familiäre Verantwortung wird betont (1. Timotheus 5:4).',
    ),
    QuizQuestion(
      text: 'Was sagt 1. Timotheus 6 über die Geldliebe?',
      options: <String>[
        'Sie ist eine Wurzel aller möglichen schädlichen Dinge',
        'Sie ist immer etwas Gutes',
        'Sie hat keine Folgen',
        'Sie garantiert Glück',
      ],
      correctIndex: 0,
      explanation: 'Eine berühmte Warnung vor Habgier (1. Timotheus 6:10).',
    ),
  ],
  '2 Timothy#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Worum bittet Paulus Timotheus bezüglich der Gabe, die er durch Handauflegung erhielt?',
      options: <String>[
        'Sie wie ein Feuer wieder anzufachen',
        'Sie endgültig zu vergessen',
        'Sie geheim zu halten',
        'Sie einem Fremden weiterzugeben',
      ],
      correctIndex: 0,
      explanation:
          'Eine Ermutigung, geistig aktiv zu bleiben (2. Timotheus 1:6).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gabe', 'Geist', 'Flamme'],
    ),
    QuizQuestion(
      text: 'Wofür, sagt Paulus, schämt er sich nicht?',
      options: <String>[
        'Für die gute Botschaft über Christus',
        'Für seine Staatsangehörigkeit',
        'Für seinen Reichtum',
        'Nur für seine Vergangenheit',
      ],
      correctIndex: 0,
      explanation:
          'Eine feste Haltung trotz der Gefangenschaft (2. Timotheus 1:8).',
    ),
  ],
  '2 Timothy#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Womit vergleicht Paulus Timotheus, um die nötige Ausdauer zu veranschaulichen?',
      options: <String>[
        'Mit einem guten Soldaten Christi',
        'Mit einem bloßen Zuschauer',
        'Mit einem unparteiischen Richter',
        'Mit einem vorsichtigen Kaufmann',
      ],
      correctIndex: 0,
      explanation:
          'Ein Bild von Disziplin und Opferbereitschaft (2. Timotheus 2:3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Athlet', 'Bauer', 'Diener'],
    ),
    QuizQuestion(
      text: 'Was sagt 2. Timotheus 3 über den Nutzen der Heiligen Schrift?',
      options: <String>[
        'Sie ist von Gott inspiriert und nützlich zum Lehren',
        'Sie ist veraltet und nutzlos',
        'Sie betrifft nur Priester',
        'Sie sollte ignoriert werden',
      ],
      correctIndex: 0,
      explanation:
          'Eine berühmte Aussage über die biblische Inspiration (2. Timotheus 3:16).',
    ),
  ],
  '2 Timothy#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Welchen Auftrag gibt Paulus Timotheus in Kapitel 4?',
      options: <String>[
        'Predige das Wort, zu jeder Zeit',
        'Zieh dich vom Dienst zurück',
        'Warte auf ein Zeichen, bevor du handelst',
        'Bewahre ein vorsichtiges Schweigen',
      ],
      correctIndex: 0,
      explanation: 'Ein dringender Aufruf zur Treue (2. Timotheus 4:2).',
    ),
    QuizQuestion(
      text: 'Wie fasst Paulus am Ende dieses Briefes sein Leben zusammen?',
      options: <String>[
        'Ich habe den vortrefflichen Kampf gekämpft, den Lauf beendet, den Glauben bewahrt',
        'Ich bin in meiner Mission gescheitert',
        'Ich bereue meinen Dienst',
        'Ich habe nichts erreicht',
      ],
      correctIndex: 0,
      explanation:
          'Eine zuversichtliche Zusammenfassung der Treue (2. Timotheus 4:7).',
    ),
  ],
  'Titus#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welche Eigenschaften muss Titus bei den in Kreta einzusetzenden Ältesten suchen?',
      options: <String>[
        'Unantastbar zu sein und an gesunder Lehre festzuhalten',
        'Vor allem wohlhabend zu sein',
        'Nur öffentlich bekannt zu sein',
        'Nur jung zu sein',
      ],
      correctIndex: 0,
      explanation: 'Strenge sittliche Kriterien werden genannt (Titus 1).',
    ),
    QuizQuestion(
      text: 'Vor wem warnt Paulus wegen ihres schlechten Einflusses in Kreta?',
      options: <String>[
        'Trügerischen falschen Lehrern',
        'Den römischen Behörden',
        'Armen Familien',
        'Ehrlichen Kaufleuten',
      ],
      correctIndex: 0,
      explanation: 'Eine deutliche Warnung wird gegeben (Titus 1:10, 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Älteste', 'Beschneidung', 'Mythen'],
    ),
  ],
  'Titus#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Was muss Titus laut Kapitel 2 den verschiedenen Gruppen in der Versammlung lehren?',
      options: <String>[
        'Gesundes Verhalten in Übereinstimmung mit heilsamer Lehre',
        'Nichts Bestimmtes',
        'Nur finanzielle Regeln',
        'Vollständige Isolation von der Welt',
      ],
      correctIndex: 0,
      explanation: 'Für jede Gruppe passender Rat wird gegeben (Titus 2).',
    ),
    QuizQuestion(
      text: 'Was lehrt uns laut Titus 2 die unverdiente Güte Gottes?',
      options: <String>[
        'In gottgefälliger Weise im gegenwärtigen System der Dinge zu leben',
        'Nur das Vergnügen zu suchen',
        'Jede sittliche Regel zu ignorieren',
        'Sich aus der Gesellschaft zurückzuziehen',
      ],
      correctIndex: 0,
      explanation:
          'Die unverdiente Güte formt den christlichen Charakter (Titus 2:12).',
    ),
  ],
  'Titus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was empfiehlt Titus 3 bezüglich der weltlichen Obrigkeit?',
      options: <String>[
        'Sich ihr unterzuordnen und zu jedem guten Werk bereit zu sein',
        'Sich ihr systematisch zu widersetzen',
        'Sie völlig zu ignorieren',
        'Sich zu weigern, Steuern zu zahlen',
      ],
      correctIndex: 0,
      explanation:
          'Ein Geist bürgerlicher Zusammenarbeit wird gefördert (Titus 3:1).',
    ),
    QuizQuestion(
      text:
          'Was sollte laut Titus 3 bei Auseinandersetzungen vermieden werden?',
      options: <String>[
        'Törichte Streitfragen und Debatten über das Gesetz',
        'Jedes öffentliche Gespräch',
        'Bibelunterricht',
        'Gemeinschaftliches Gebet',
      ],
      correctIndex: 0,
      explanation: 'Praktischer Rat zur Bewahrung der Einheit (Titus 3:9).',
    ),
  ],
  'Philemon#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Worum bittet Paulus Philemon bezüglich Onesimus?',
      options: <String>[
        'Ihn als geliebten Bruder aufzunehmen, nicht als Sklaven',
        'Ihn streng zu bestrafen',
        'Ihn an einen anderen Herrn zu verkaufen',
        'Ihn völlig zu ignorieren',
      ],
      correctIndex: 0,
      explanation: 'Ein Aufruf zu brüderlicher Versöhnung (Philemon 1).',
    ),
    QuizQuestion(
      text:
          'Wie schlägt Paulus vor, eine etwaige Schuld von Onesimus gegenüber Philemon zu begleichen?',
      options: <String>[
        'Er bietet an, sie auf sein eigenes Konto zu buchen',
        'Er verlangt, dass Philemon sie ohne Diskussion erlässt',
        'Er ignoriert die Angelegenheit völlig',
        'Er bittet die Versammlung, sie zu bezahlen',
      ],
      correctIndex: 0,
      explanation: 'Ein persönlicher Akt der Vermittlung (Philemon 1:18, 19).',
    ),
  ],
  'Hebrews#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wie sprach Gott laut Hebräer 1 letztlich zur Menschheit?',
      options: <String>[
        'Durch seinen Sohn',
        'Nur durch Engel',
        'Nur durch Träume',
        'Er sprach nie',
      ],
      correctIndex: 0,
      explanation:
          'Eine Offenbarung, überlegen jeder früheren, durch Christus (Hebräer 1:1, 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Propheten', 'Engel', 'Mose'],
    ),
    QuizQuestion(
      text: 'Was beschreibt Hebräer 4 über das Wort Gottes?',
      options: <String>[
        'Es ist lebendig und schärfer als ein zweischneidiges Schwert',
        'Es ist unveränderlich und wirkungslos',
        'Es betrifft nur Priester',
        'Es ist mit der Zeit verschwunden',
      ],
      correctIndex: 0,
      explanation: 'Ein starkes Bild vom göttlichen Wort (Hebräer 4:12).',
    ),
    QuizQuestion(
      text: 'Wovor warnt Kapitel 3 anhand des Beispiels der Wildnis?',
      options: <String>[
        'Vor einem bösen, ungläubigen Herzen, das sich von Gott abwendet',
        'Vor übermäßiger Großzügigkeit',
        'Vor zu viel Gebet',
        'Vor dem bloßen Reisen',
      ],
      correctIndex: 0,
      explanation:
          'Die Generation der Wildnis dient als Warnung (Hebräer 3:12).',
    ),
  ],
  'Hebrews#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Mit welcher alten Priesterordnung wird Christus in diesem Brief verglichen?',
      options: <String>[
        'Melchisedek',
        'Allein Aaron',
        'Allein Levi',
        'Mit keiner bestimmten Ordnung',
      ],
      correctIndex: 0,
      explanation: 'Ein überlegenes und dauerhaftes Priestertum (Hebräer 7).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Was ermöglicht laut Hebräer 8 der neue Bund?',
      options: <String>[
        'Eine erneuerte, innerliche Beziehung zu Gott',
        'Eine bloße Änderung des äußeren Rituals',
        'Das Ende jedes Bundes mit Gott',
        'Keine wirkliche Veränderung',
      ],
      correctIndex: 0,
      explanation: 'Ein überlegener Bund wird aufgerichtet (Hebräer 8:10).',
    ),
    QuizQuestion(
      text: 'Was reinigt laut Hebräer 9 das Blut Christi?',
      options: <String>[
        'Das Gewissen, von toten Werken',
        'Nur den physischen Körper',
        'Nichts Geistiges',
        'Nur die Gegenstände des Tempels',
      ],
      correctIndex: 0,
      explanation: 'Eine tiefgreifende innere Reinigung (Hebräer 9:14).',
    ),
  ],
  'Hebrews#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welchen grundlegenden Grundsatz betonen Hebräer 10-11 bezüglich der Rettung?',
      options: <String>[
        'Der Gerechte wird durch Glauben leben',
        'Die Rettung hängt allein von Ritualen ab',
        'Der Glaube hat keine Bedeutung',
        'Nur äußerliche Werke zählen',
      ],
      correctIndex: 0,
      explanation: 'Ein Schlüsselzitat aus Habakuk (Hebräer 10:38).',
    ),
    QuizQuestion(
      text: 'Welche Beispiele hebt das berühmte Kapitel 11 hervor?',
      options: <String>[
        'Abel, Noah, Abraham und andere Treue, durch Glauben',
        'Nur die Könige Israels',
        'Nur die Priester',
        'Keine konkreten Beispiele',
      ],
      correctIndex: 0,
      explanation: 'Das „Glaubenskapitel“ nennt viele Beispiele (Hebräer 11).',
    ),
    QuizQuestion(
      text: 'Wie beschreibt Hebräer 13 Jesus Christus durch die Zeit hindurch?',
      options: <String>[
        'Derselbe gestern, heute und für immer',
        'Sich mit jeder Epoche verändernd',
        'Für jede Generation anders',
        'Unerkennbar',
      ],
      correctIndex: 0,
      explanation:
          'Eine Aussage der Beständigkeit und Verlässlichkeit (Hebräer 13:8).',
    ),
  ],
  'James#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Worum sollte man laut Jakobus 1 mit Glauben bitten?',
      options: <String>[
        'Um Weisheit',
        'Um Reichtum',
        'Um Beliebtheit',
        'Um Macht',
      ],
      correctIndex: 0,
      explanation: 'Gott gibt Weisheit großzügig (Jakobus 1:5).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Was sagt Jakobus 2 über die Beziehung zwischen Glauben und Werken?',
      options: <String>[
        'Glaube ohne Werke ist tot',
        'Werke haben keine Bedeutung',
        'Nur der Glaube zählt, ohne Handeln',
        'Werke ersetzen den Glauben vollständig',
      ],
      correctIndex: 0,
      explanation: 'Echter Glaube zeigt sich in Taten (Jakobus 2:26).',
    ),
  ],
  'James#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Womit vergleicht Jakobus 3 die Macht der Zunge?',
      options: <String>[
        'Mit einem kleinen Feuer, das einen großen Wald in Brand setzen kann',
        'Mit einem folgenlosen Werkzeug',
        'Mit einem einfachen, neutralen Instrument',
        'Mit einer stets positiven Kraft',
      ],
      correctIndex: 0,
      explanation: 'Ein starkes Bild von der Wirkung der Worte (Jakobus 3:5).',
    ),
    QuizQuestion(
      text:
          'Wie unterscheidet Jakobus 3 die Weisheit von oben von der irdischen Weisheit?',
      options: <String>[
        'Göttliche Weisheit ist rein und friedsam',
        'Beide Arten von Weisheit sind identisch',
        'Irdische Weisheit ist immer besser',
        'Es wird kein Unterschied gemacht',
      ],
      correctIndex: 0,
      explanation: 'Ein deutlicher Gegensatz wird gezogen (Jakobus 3:17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Zunge', 'Feuer', 'Neid'],
    ),
  ],
  'James#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was rät Jakobus 4 angesichts einer ungewissen Zukunft?',
      options: <String>[
        'Rühmt euch nicht des morgigen Tages',
        'Macht Pläne, ohne Gott je zu berücksichtigen',
        'Ignoriert die Zukunft völlig',
        'Verlasst euch allein auf Glück',
      ],
      correctIndex: 0,
      explanation: 'Eine praktische Lektion in Demut (Jakobus 4:13-15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Älteste', 'Gebet', 'Öl'],
    ),
    QuizQuestion(
      text: 'Was sollte ein Kranker laut Jakobus 5 tun?',
      options: <String>[
        'Die Ältesten rufen, damit sie mit Glauben beten',
        'Allein ohne Hilfe warten',
        'Nur einen Wahrsager befragen',
        'Seinen Zustand ignorieren',
      ],
      correctIndex: 0,
      explanation: 'Eine Ermutigung zum gemeinsamen Gebet (Jakobus 5:14).',
    ),
  ],
  '1 Peter#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Wozu wurden Christen laut 1. Petrus 1 wiedergeboren?',
      options: <String>[
        'Zu einer lebendigen Hoffnung durch die Auferstehung Christi',
        'Zu sofortigem materiellem Reichtum',
        'Zu einem Leben ohne Prüfungen',
        'Zu einem höheren gesellschaftlichen Status',
      ],
      correctIndex: 0,
      explanation:
          'Eine Hoffnung, gegründet auf die Auferstehung (1. Petrus 1:3).',
    ),
    QuizQuestion(
      text: 'Womit werden Christen in 1. Petrus 2 verglichen?',
      options: <String>[
        'Mit lebendigen Steinen, die ein geistiges Haus bilden',
        'Mit Fremden ohne Bindungen',
        'Mit bloßen Zuschauern',
        'Mit obersten Richtern',
      ],
      correctIndex: 0,
      explanation:
          'Ein Bild einer gemeinsam erbauten Gemeinschaft (1. Petrus 2:5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tempel', 'Priester', 'Eckstein'],
    ),
  ],
  '1 Peter#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Welches Beispiel bietet 1. Petrus 3 angesichts ungerechten Leidens?',
      options: <String>[
        'Christus, der litt, um uns ein Vorbild zu hinterlassen',
        'Sofortige Rache',
        'Immer zu fliehen',
        'Völlige Gleichgültigkeit',
      ],
      correctIndex: 0,
      explanation: 'Ein Vorbild an Geduld und Lauterkeit (1. Petrus 3:18).',
    ),
    QuizQuestion(
      text:
          'Welche Haltung empfiehlt 1. Petrus 3 gegenüber denen, die Fragen zum Glauben stellen?',
      options: <String>[
        'Bereit zu sein, sich mit Sanftmut und Respekt zu verteidigen',
        'Jedes Gespräch zu verweigern',
        'Mit Verachtung zu antworten',
        'Das Thema systematisch zu meiden',
      ],
      correctIndex: 0,
      explanation: 'Eine respektvolle Antwort wird gefördert (1. Petrus 3:15).',
    ),
  ],
  '1 Peter#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Was sagt 1. Petrus 4 über die Liebe unter Christen?',
      options: <String>[
        'Sie deckt eine Vielzahl von Sünden zu',
        'Sie hat keinen praktischen Wert',
        'Sie sollte oberflächlich bleiben',
        'Sie ist wenigen vorbehalten',
      ],
      correctIndex: 0,
      explanation:
          'Eine wesentliche Eigenschaft, die es zu pflegen gilt (1. Petrus 4:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Herde', 'Älteste', 'Leiden'],
    ),
    QuizQuestion(
      text:
          'Welche Haltung verlangt 1. Petrus 5 von den Ältesten gegenüber der Herde?',
      options: <String>[
        'Sie willig zu hüten, mit Demut, nicht aus Zwang',
        'Sie mit strenger Autorität zu beherrschen',
        'Sie weitgehend zu ignorieren',
        'Persönlichen Gewinn zu suchen',
      ],
      correctIndex: 0,
      explanation:
          'Ein Vorbild demütiger Führung wird gefördert (1. Petrus 5:2, 3).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesDeC7 =
    <String, List<QuizQuestion>>{};
