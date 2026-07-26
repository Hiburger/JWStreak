import 'quiz_data.dart';

const Map<String, List<QuizQuestion>> authoredQuizzesItC7 = <String, List<QuizQuestion>>{
  '2 Thessalonians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Come incoraggia Paolo i Tessalonicesi perseguitati?',
      options: <String>[
        'Ricordando il giusto giudizio che Dio eseguirà',
        'Promettendo loro una fine immediata delle prove',
        'Incolpandoli della loro situazione',
        'Spingendoli ad abbandonare la fede',
      ],
      correctIndex: 0,
      explanation:
          'Una speranza di giustizia divina li incoraggia '
          '(2 Tessalonicesi 1).',
    ),
    QuizQuestion(
      text: 'Quale preoccupazione corregge Paolo riguardo al giorno del '
          'Signore?',
      options: <String>[
        'Credere erroneamente che fosse già arrivato',
        'Credere che non sarebbe mai arrivato',
        'Ignorare del tutto l’argomento',
        'Pensare che bisognasse smettere di pregare',
      ],
      correctIndex: 0,
      explanation:
          'Una confusione viene chiarita (2 Tessalonicesi 2:2).',
    ),
  ],
  '2 Thessalonians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa deve manifestarsi prima del giorno del Signore secondo '
          '2 Tessalonicesi 2?',
      options: <String>['L’uomo dell’illegalità', 'Un re giusto', 'Una pace universale', 'Niente in particolare'],
      correctIndex: 0,
      explanation:
          'Viene annunciato un segno premonitore '
          '(2 Tessalonicesi 2:3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['uomo dell’illegalità'],
    ),
    QuizQuestion(
      text: 'Quale incoraggiamento dà Paolo nonostante questo annuncio '
          'inquietante?',
      options: <String>[
        'Restare saldi negli insegnamenti ricevuti',
        'Abbandonare ogni speranza',
        'Cessare ogni attività cristiana',
        'Disperdersi immediatamente',
      ],
      correctIndex: 0,
      explanation:
          'Un appello alla perseveranza (2 Tessalonicesi 2:15).',
    ),
  ],
  '2 Thessalonians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale principio stabilisce Paolo riguardo al lavoro in '
          '2 Tessalonicesi 3?',
      options: <String>[
        'Se qualcuno non vuole lavorare, non mangi neppure',
        'Il lavoro è inutile per i cristiani',
        'Solo i ricchi devono lavorare',
        'Il lavoro sostituisce la fede',
      ],
      correctIndex: 0,
      explanation:
          'Un avvertimento contro l’ozio (2 Tessalonicesi 3:10).',
    ),
    QuizQuestion(
      text: 'Come conclude Paolo questa lettera?',
      options: <String>[
        'Con un saluto di suo pugno, segno di autenticità',
        'Con un silenzio brusco',
        'Con una nuova accusa',
        'Con un elenco di regole aggiuntive',
      ],
      correctIndex: 0,
      explanation:
          'La sua firma garantisce l’autenticità della lettera '
          '(2 Tessalonicesi 3:17).',
    ),
  ],
  '1 Timothy#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Contro cosa mette in guardia Paolo Timoteo fin dall’inizio '
          'della lettera?',
      options: <String>[
        'Gli insegnamenti diversi e le favole senza fine',
        'La mancanza di ricchezza',
        'Un eccesso di preghiera',
        'Il matrimonio in generale',
      ],
      correctIndex: 0,
      explanation:
          'Paolo vuole preservare la purezza dell’insegnamento '
          '(1 Timoteo 1).',
    ),
    QuizQuestion(
      text: 'Per chi chiede Paolo che vengano fatte preghiere in '
          '1 Timoteo 2?',
      options: <String>[
        'Per tutti gli uomini, inclusi re e autorità',
        'Solo per gli apostoli',
        'Solo per la propria famiglia',
        'Per nessuno in particolare',
      ],
      correctIndex: 0,
      explanation:
          'Viene raccomandata una preghiera inclusiva (1 Timoteo 2:1, '
          '2).',
    ),
  ],
  '1 Timothy#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quali qualità sono richieste ai sorveglianti secondo '
          '1 Timoteo 3?',
      options: <String>[
        'Essere irreprensibili, padroni di sé, ospitali',
        'Essere prima di tutto ricchi',
        'Essere solo giovani',
        'Avere grande fama pubblica',
      ],
      correctIndex: 0,
      explanation:
          'Vengono dati criteri morali precisi '
          '(1 Timoteo 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ricchi', 'severi', 'eloquenti'],
    ),
    QuizQuestion(
      text: 'Cosa dice 1 Timoteo 4 sull’esercizio fisico rispetto alla '
          'devozione?',
      options: <String>[
        'La devozione è utile a tutto, l’esercizio fisico è limitato',
        'L’esercizio fisico è più importante',
        'Nessuno dei due ha valore',
        'Solo l’esercizio fisico conta davvero',
      ],
      correctIndex: 0,
      explanation:
          'Viene stabilito un ordine di priorità (1 Timoteo 4:8).',
    ),
  ],
  '1 Timothy#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa raccomanda 1 Timoteo 5 riguardo alle vedove nel '
          'bisogno?',
      options: <String>[
        'Che la famiglia se ne prenda cura per prima',
        'Di ignorarle completamente',
        'Di vietare loro ogni aiuto',
        'Di escluderle dalla congregazione',
      ],
      correctIndex: 0,
      explanation:
          'Viene sottolineata la responsabilità familiare '
          '(1 Timoteo 5:4).',
    ),
    QuizQuestion(
      text: 'Cosa dice 1 Timoteo 6 sull’amore per il denaro?',
      options: <String>[
        'È una radice di ogni sorta di cose dannose',
        'È sempre una buona cosa',
        'Non ha alcuna conseguenza',
        'Garantisce la felicità',
      ],
      correctIndex: 0,
      explanation:
          'Un celebre avvertimento sull’avidità '
          '(1 Timoteo 6:10).',
    ),
  ],
  '2 Timothy#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa chiede Paolo a Timoteo riguardo al dono ricevuto '
          'tramite l’imposizione delle mani?',
      options: <String>[
        'Di ravvivarlo come un fuoco',
        'Di dimenticarlo definitivamente',
        'Di tenerlo segreto',
        'Di trasmetterlo a uno sconosciuto',
      ],
      correctIndex: 0,
      explanation:
          'Un incoraggiamento a restare attivi spiritualmente '
          '(2 Timoteo 1:6).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['spegnerlo', 'nasconderlo', 'dono'],
    ),
    QuizQuestion(
      text: 'Di cosa dice Paolo di non vergognarsi?',
      options: <String>[
        'Della buona notizia riguardo a Cristo',
        'Della sua nazionalità',
        'Della sua ricchezza',
        'Solo del suo passato',
      ],
      correctIndex: 0,
      explanation:
          'Una fermezza nonostante la prigionia (2 Timoteo 1:8).',
    ),
  ],
  '2 Timothy#1': <QuizQuestion>[
    QuizQuestion(
      text: 'A cosa paragona Paolo Timoteo per illustrare la resistenza '
          'necessaria?',
      options: <String>[
        'A un buon soldato di Cristo',
        'A un semplice spettatore',
        'A un giudice imparziale',
        'A un mercante prudente',
      ],
      correctIndex: 0,
      explanation:
          'Un’immagine di disciplina e sacrificio '
          '(2 Timoteo 2:3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['atleta', 'agricoltore', 'servo'],
    ),
    QuizQuestion(
      text: 'Cosa dice 2 Timoteo 3 sull’utilità delle Scritture?',
      options: <String>[
        'Sono ispirate da Dio e utili per insegnare',
        'Sono superate e inutili',
        'Riguardano solo i sacerdoti',
        'Devono essere ignorate',
      ],
      correctIndex: 0,
      explanation:
          'Una celebre dichiarazione sull’ispirazione biblica '
          '(2 Timoteo 3:16).',
    ),
  ],
  '2 Timothy#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale incarico dà Paolo a Timoteo al capitolo 4?',
      options: <String>[
        'Predicare la parola, in ogni stagione',
        'Ritirarsi dal ministero',
        'Attendere un segno prima di agire',
        'Mantenere prudentemente il silenzio',
      ],
      correctIndex: 0,
      explanation:
          'Un appello pressante alla fedeltà (2 Timoteo 4:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['tacere', 'attendere', 'riposare'],
    ),
    QuizQuestion(
      text: 'Come riassume Paolo la sua vita alla fine di questa '
          'lettera?',
      options: <String>[
        'Ho combattuto la buona battaglia, terminato la corsa, custodito la fede',
        'Ho fallito nella mia missione',
        'Mi pento del mio ministero',
        'Non ho compiuto nulla',
      ],
      correctIndex: 0,
      explanation:
          'Un bilancio di fedeltà pieno di fiducia '
          '(2 Timoteo 4:7).',
    ),
  ],
  'Titus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quali qualità deve cercare Tito negli anziani da stabilire '
          'a Creta?',
      options: <String>[
        'Essere irreprensibili e legati a un insegnamento sano',
        'Essere prima di tutto ricchi',
        'Essere conosciuti solo pubblicamente',
        'Essere solo giovani',
      ],
      correctIndex: 0,
      explanation:
          'Vengono dati criteri morali rigorosi (Tito 1).',
    ),
    QuizQuestion(
      text: 'Contro chi mette in guardia Paolo a causa della loro '
          'cattiva influenza a Creta?',
      options: <String>[
        'I falsi insegnanti ingannevoli',
        'Le autorità romane',
        'Le famiglie povere',
        'I commercianti onesti',
      ],
      correctIndex: 0,
      explanation:
          'Viene dato un chiaro avvertimento (Tito 1:10, 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['anziani', 'fratelli', 'vedove'],
    ),
  ],
  'Titus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa deve insegnare Tito ai diversi gruppi della '
          'congregazione secondo il capitolo 2?',
      options: <String>[
        'Un comportamento sano e conforme a un insegnamento '
            'salutare',
        'Niente di specifico',
        'Solo regole finanziarie',
        'Un completo isolamento dal mondo',
      ],
      correctIndex: 0,
      explanation:
          'Vengono dati consigli adatti a ciascun gruppo '
          '(Tito 2).',
    ),
    QuizQuestion(
      text: 'Cosa ci insegna la grazia di Dio secondo Tito 2?',
      options: <String>[
        'A vivere devotamente nell’attuale sistema di cose',
        'A cercare solo il piacere',
        'A ignorare ogni regola morale',
        'A ritirarsi dalla società',
      ],
      correctIndex: 0,
      explanation:
          'La grazia forma il carattere cristiano (Tito 2:12).',
    ),
  ],
  'Titus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa raccomanda Tito 3 riguardo alle autorità civili?',
      options: <String>[
        'Essere loro sottomessi e pronti a ogni opera buona',
        'Sfidarle sistematicamente',
        'Ignorarle completamente',
        'Rifiutare di pagare le tasse',
      ],
      correctIndex: 0,
      explanation:
          'Viene incoraggiato uno spirito di collaborazione civile '
          '(Tito 3:1).',
    ),
    QuizQuestion(
      text: 'Cosa bisogna evitare secondo Tito 3 riguardo ai dibattiti?',
      options: <String>[
        'Le controversie stupide e le dispute sulla legge',
        'Ogni conversazione pubblica',
        'L’insegnamento biblico',
        'La preghiera comunitaria',
      ],
      correctIndex: 0,
      explanation:
          'Un consiglio pratico per preservare l’unità (Tito '
          '3:9).',
    ),
  ],
  'Philemon#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa chiede Paolo a Filemone riguardo a Onesimo?',
      options: <String>[
        'Di accoglierlo come un fratello caro, non come uno '
            'schiavo',
        'Di punirlo severamente',
        'Di venderlo a un altro padrone',
        'Di ignorarlo completamente',
      ],
      correctIndex: 0,
      explanation:
          'Un appello alla riconciliazione fraterna (Filemone 1).',
    ),
    QuizQuestion(
      text: 'Come propone Paolo di sistemare l’eventuale debito di '
          'Onesimo verso Filemone?',
      options: <String>[
        'Propone di metterlo sul proprio conto',
        'Esige che Filemone lo cancelli senza discussione',
        'Ignora completamente la questione',
        'Chiede alla Chiesa di pagare',
      ],
      correctIndex: 0,
      explanation:
          'Un gesto personale di mediazione (Filemone 1:18, 19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['schiavo', 'fratello', 'lettera'],
    ),
  ],
  'Hebrews#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Come ha parlato Dio finalmente agli uomini secondo '
          'Ebrei 1?',
      options: <String>['Per mezzo di suo Figlio', 'Solo per mezzo di angeli', 'Solo tramite sogni', 'Non ha mai parlato'],
      correctIndex: 0,
      explanation:
          'Una rivelazione superiore attraverso Cristo (Ebrei '
          '1:1, 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['profeti', 'angeli', 'legge'],
    ),
    QuizQuestion(
      text: 'Cosa descrive Ebrei 4 riguardo alla parola di Dio?',
      options: <String>[
        'È viva e penetra più di una spada a doppio '
            'taglio',
        'È immutabile e senza effetto',
        'Riguarda solo i sacerdoti',
        'È scomparsa con il tempo',
      ],
      correctIndex: 0,
      explanation:
          'Una potente immagine della parola divina (Ebrei 4:12).',
    ),
    QuizQuestion(
      text: 'Contro cosa mette in guardia il capitolo 3, partendo '
          'dall’esempio del deserto?',
      options: <String>[
        'Un cuore incredulo che si allontana da Dio',
        'Un eccesso di generosità',
        'Un eccesso di preghiera',
        'Il semplice fatto di viaggiare',
      ],
      correctIndex: 0,
      explanation:
          'La generazione del deserto serve da avvertimento '
          '(Ebrei 3:12).',
    ),
  ],
  'Hebrews#1': <QuizQuestion>[
    QuizQuestion(
      text: 'A quale antico ordine sacerdotale viene paragonato Cristo '
          'in questa lettera?',
      options: <String>['Melchisedec', 'Solo Aronne', 'Solo Levi', 'Nessun ordine particolare'],
      correctIndex: 0,
      explanation:
          'Un sacerdozio superiore e permanente (Ebrei 7).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Cosa rende possibile il nuovo patto secondo Ebrei '
          '8?',
      options: <String>[
        'Una relazione interiore rinnovata con Dio',
        'Un semplice cambiamento di rituale esteriore',
        'La fine di ogni patto con Dio',
        'Nessun cambiamento reale',
      ],
      correctIndex: 0,
      explanation:
          'Viene instaurato un patto superiore (Ebrei 8:10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['legge', 'sacrifici', 'tempio'],
    ),
    QuizQuestion(
      text: 'Cosa purifica il sangue di Cristo secondo Ebrei 9?',
      options: <String>[
        'La coscienza, dalle opere morte',
        'Solo il corpo fisico',
        'Niente di spirituale',
        'Solo gli oggetti del tempio',
      ],
      correctIndex: 0,
      explanation:
          'Una profonda purificazione interiore (Ebrei 9:14).',
    ),
  ],
  'Hebrews#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale principio fondamentale mettono in risalto Ebrei '
          '10-11 riguardo alla salvezza?',
      options: <String>[
        'Il giusto vivrà per fede',
        'La salvezza dipende solo dai rituali',
        'La fede non ha alcuna importanza',
        'Contano solo le opere esteriori',
      ],
      correctIndex: 0,
      explanation:
          'Una citazione chiave ripresa da Abacuc (Ebrei 10:38).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['opere', 'legge', 'sacrifici'],
    ),
    QuizQuestion(
      text: 'Quali esempi mette in risalto il famoso capitolo 11?',
      options: <String>[
        'Abele, Noè, Abraamo e altri fedeli per fede',
        'Solo i re d’Israele',
        'Solo i sacerdoti',
        'Nessun esempio concreto',
      ],
      correctIndex: 0,
      explanation:
          'Il “capitolo della fede” cita numerosi esempi '
          '(Ebrei 11).',
    ),
    QuizQuestion(
      text: 'Come descrive Ebrei 13 Gesù Cristo attraverso il tempo?',
      options: <String>[
        'Lo stesso ieri, oggi ed eternamente',
        'Mutevole secondo le epoche',
        'Diverso per ogni generazione',
        'Inconoscibile',
      ],
      correctIndex: 0,
      explanation:
          'Un’affermazione di costanza e affidabilità '
          '(Ebrei 13:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['mutevole', 'domani', 'tempo'],
    ),
  ],
  'James#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa bisogna chiedere con fede secondo Giacomo 1?',
      options: <String>['La sapienza', 'La ricchezza', 'La popolarità', 'Il potere'],
      correctIndex: 0,
      explanation:
          'Dio dà la sapienza generosamente (Giacomo 1:5).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['sapienza'],
    ),
    QuizQuestion(
      text: 'Cosa dice Giacomo 2 sulla relazione tra fede e opere?',
      options: <String>[
        'La fede senza le opere è morta',
        'Le opere non hanno alcuna importanza',
        'Conta solo la fede, senza azione',
        'Le opere sostituiscono completamente la fede',
      ],
      correctIndex: 0,
      explanation:
          'Una fede autentica si manifesta con atti '
          '(Giacomo 2:26).',
    ),
  ],
  'James#1': <QuizQuestion>[
    QuizQuestion(
      text: 'A cosa paragona Giacomo 3 il potere della lingua?',
      options: <String>[
        'A un piccolo fuoco capace di incendiare una grande foresta',
        'A uno strumento senza conseguenze',
        'A un semplice attrezzo neutro',
        'A una forza sempre positiva',
      ],
      correctIndex: 0,
      explanation:
          'Un’immagine forte sull’impatto delle parole (Giacomo 3:5).',
    ),
    QuizQuestion(
      text: 'Come distingue Giacomo 3 la sapienza dall’alto dalla '
          'sapienza terrena?',
      options: <String>[
        'La sapienza divina è pura e pacifica',
        'Le due sapienze sono identiche',
        'La sapienza terrena è sempre migliore',
        'Non viene fatta alcuna differenza',
      ],
      correctIndex: 0,
      explanation:
          'Viene stabilito un contrasto chiaro (Giacomo 3:17).',
    ),
  ],
  'James#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa consiglia Giacomo 4 di fronte all’incertezza del '
          'futuro?',
      options: <String>[
        'Non vantarsi del domani',
        'Pianificare senza mai tenere conto di Dio',
        'Ignorare completamente il futuro',
        'Affidarsi solo alla fortuna',
      ],
      correctIndex: 0,
      explanation:
          'Una lezione di umiltà pratica (Giacomo 4:13-15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pregare', 'giurare', 'lamentarsi'],
    ),
    QuizQuestion(
      text: 'Cosa deve fare una persona malata secondo Giacomo 5?',
      options: <String>[
        'Chiamare gli anziani per pregare con fede',
        'Aspettare da sola senza aiuto',
        'Consultare solo un indovino',
        'Ignorare la sua condizione',
      ],
      correctIndex: 0,
      explanation:
          'Un incoraggiamento alla preghiera comunitaria '
          '(Giacomo 5:14).',
    ),
  ],
  '1 Peter#0': <QuizQuestion>[
    QuizQuestion(
      text: 'A cosa sono nati di nuovo i cristiani secondo 1 Pietro '
          '1?',
      options: <String>[
        'A una speranza viva grazie alla risurrezione di Cristo',
        'A una ricchezza materiale immediata',
        'A una vita senza prove',
        'A uno status sociale superiore',
      ],
      correctIndex: 0,
      explanation:
          'Una speranza fondata sulla risurrezione (1 Pietro '
          '1:3).',
    ),
    QuizQuestion(
      text: 'A cosa sono paragonati i cristiani in 1 Pietro 2?',
      options: <String>[
        'A pietre vive che formano una casa spirituale',
        'A estranei senza legami',
        'A semplici spettatori',
        'A giudici supremi',
      ],
      correctIndex: 0,
      explanation:
          'Un’immagine di comunità costruita insieme (1 Pietro 2:5).',
    ),
  ],
  '1 Peter#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale esempio propone 1 Pietro 3 di fronte alla '
          'sofferenza ingiusta?',
      options: <String>[
        'Cristo, che ha sofferto per lasciarci un modello',
        'La vendetta immediata',
        'La fuga sistematica',
        'L’indifferenza totale',
      ],
      correctIndex: 0,
      explanation:
          'Un modello di pazienza e integrità (1 Pietro 3:18).',
    ),
    QuizQuestion(
      text: 'Quale atteggiamento raccomanda 1 Pietro 3 verso chi pone '
          'domande sulla fede?',
      options: <String>[
        'Essere pronti a difendersi con dolcezza e rispetto',
        'Rifiutare ogni discussione',
        'Rispondere con disprezzo',
        'Evitare sistematicamente l’argomento',
      ],
      correctIndex: 0,
      explanation:
          'Viene incoraggiata una risposta rispettosa (1 Pietro 3:15).',
    ),
  ],
  '1 Peter#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa dice 1 Pietro 4 sull’amore tra cristiani?',
      options: <String>[
        'Copre una moltitudine di peccati',
        'Non ha alcun valore pratico',
        'Deve restare superficiale',
        'È riservato a pochi',
      ],
      correctIndex: 0,
      explanation:
          'Una qualità essenziale da coltivare (1 Pietro 4:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['perdona', 'giudica', 'fede'],
    ),
    QuizQuestion(
      text: 'Quale atteggiamento chiede 1 Pietro 5 agli anziani verso '
          'il gregge?',
      options: <String>[
        'Guidarlo volentieri, con umiltà, non per costrizione',
        'Dominarlo con rigida autorità',
        'Ignorarlo in gran parte',
        'Cercare un guadagno personale',
      ],
      correctIndex: 0,
      explanation:
          'Viene incoraggiato un modello di guida umile '
          '(1 Pietro 5:2, 3).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesItC7 = <String, List<QuizQuestion>>{};
