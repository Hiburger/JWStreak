import 'quiz_data.dart';

const Map<String, List<QuizQuestion>> authoredQuizzesItC6 = <String, List<QuizQuestion>>{
  'Romans#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa dichiara Paolo sulla condizione di tutti gli esseri umani, '
          'Ebrei e non Ebrei, in Romani 3?',
      options: <String>[
        'Tutti hanno peccato e sono privi della gloria di Dio',
        'Solo i non Ebrei hanno peccato',
        'In realtà nessuno ha peccato',
        'Solo i governanti sono responsabili',
      ],
      correctIndex: 0,
      explanation: 'Un punto fondamentale del ragionamento di Paolo (Romani 3:23).',
    ),
    QuizQuestion(
      text: 'Su cosa si basa la giustificazione secondo Romani 3-4, '
          'illustrata dall’esempio di Abraamo?',
      options: <String>[
        'Sulla fede, e non sulle opere della legge',
        'Solo sui sacrifici rituali',
        'Sulla ricchezza personale',
        'Sull’origine etnica',
      ],
      correctIndex: 0,
      explanation: 'Abraamo fu dichiarato giusto grazie alla fede (Romani 4).',
    ),
  ],
  'Romans#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa dichiara Romani 8 riguardo all’amore di Dio per i cristiani?',
      options: <String>[
        'Niente può separarci dall’amore di Dio',
        'Questo amore è condizionato e fragile',
        'Riguarda solo pochi eletti',
        'Scompare di fronte alle prove',
      ],
      correctIndex: 0,
      explanation: 'Una potente affermazione conclude questo capitolo (Romani 8:38, 39).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['morte', 'angeli', 'tribolazione'],
    ),
    QuizQuestion(
      text: 'Cosa dice Romani 10 riguardo alla salvezza?',
      options: <String>[
        'Chiunque invoca il nome di Geova sarà salvato',
        'Solo i sacerdoti possono essere salvati',
        'La salvezza dipende unicamente dalla nascita',
        'Nessuna salvezza è possibile per le nazioni',
      ],
      correctIndex: 0,
      explanation: 'Viene citata una promessa universale (Romani 10:13).',
    ),
  ],
  'Romans#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa chiede Romani 12 ai cristiani riguardo alla loro vita quotidiana?',
      options: <String>[
        'Di offrirsi come un sacrificio vivente a Dio',
        'Di evitare ogni attività sociale',
        'Di ritirarsi completamente dal mondo',
        'Di non usare mai i propri doni',
      ],
      correctIndex: 0,
      explanation: 'Un appello a una dedizione pratica (Romani 12:1).',
    ),
    QuizQuestion(
      text: 'Quale principio stabilisce Romani 13 riguardo alle autorità?',
      options: <String>[
        'Essere sottomessi alle autorità superiori',
        'Ignorare sistematicamente le leggi',
        'Ribellarsi a ogni governo',
        'Pagare le tasse solo se lo si desidera',
      ],
      correctIndex: 0,
      explanation: 'Viene insegnato un principio di rispetto civico (Romani 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ribelli', 'indifferenti', 'giudici'],
    ),
  ],
  '1 Corinthians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale problema affronta Paolo fin dall’inizio di questa lettera?',
      options: <String>[
        'Le divisioni e le rivalità nella congregazione',
        'Una mancanza di cibo',
        'Un’invasione militare',
        'Una totale assenza di fede',
      ],
      correctIndex: 0,
      explanation: 'Le fazioni sorte attorno a diversi insegnanti creavano problemi (1 Corinti 1).',
    ),
    QuizQuestion(
      text: 'A cosa paragona Paolo la congregazione in 1 Corinti 3?',
      options: <String>[
        'Al tempio di Dio',
        'A un esercito',
        'A un semplice edificio vuoto',
        'A un’impresa commerciale',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine sacra sottolinea la responsabilità collettiva (1 Corinti 3:16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['corpo', 'famiglia', 'campo'],
    ),
  ],
  '1 Corinthians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Come affronta Paolo la questione del cibo offerto agli idoli?',
      options: <String>[
        'L’amore e la coscienza del prossimo vengono prima della libertà',
        'Lo vieta in modo assoluto, senza eccezioni',
        'Lo incoraggia senza riserve',
        'Rifiuta di affrontare l’argomento',
      ],
      correctIndex: 0,
      explanation: 'Un equilibrio tra libertà e considerazione per gli altri (1 Corinti 8).',
    ),
    QuizQuestion(
      text: 'Quale atteggiamento adotta Paolo per conquistare le persone '
          'alla buona notizia, secondo 1 Corinti 9?',
      options: <String>[
        'Diventare ogni cosa per ogni persona, per quanto possibile',
        'Rimanere rigido in tutte le sue abitudini',
        'Evitare ogni contatto con altre culture',
        'Esigere un pagamento per predicare',
      ],
      correctIndex: 0,
      explanation: 'Una flessibilità motivata dall’amore (1 Corinti 9:22).',
    ),
  ],
  '1 Corinthians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'A cosa paragona Paolo la diversità dei doni spirituali nella congregazione?',
      options: <String>[
        'Alle diverse parti di uno stesso corpo',
        'A rivali separati',
        'A estranei senza alcun legame',
        'A doni privi di utilità',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine di unità nella diversità (1 Corinti 12).',
    ),
    QuizQuestion(
      text: 'Quale qualità descrive Paolo come superiore a tutti i doni '
          'nel celebre capitolo 13?',
      options: <String>['L’amore', 'La ricchezza', 'La fama', 'Il potere'],
      correctIndex: 0,
      explanation: 'Senza amore, tutto il resto è vano (1 Corinti 13).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['amore'],
    ),
  ],
  '2 Corinthians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Come descrive Paolo il conforto che ha ricevuto nella prova?',
      options: <String>[
        'Un conforto da condividere poi con altri',
        'Un conforto riservato solo a se stesso',
        'Una totale assenza di conforto',
        'Un conforto proveniente solo dagli uomini',
      ],
      correctIndex: 0,
      explanation: 'Il conforto divino si trasmette agli altri (2 Corinti 1).',
    ),
    QuizQuestion(
      text: 'A cosa paragona Paolo i cristiani trasformati in 2 Corinti 3-4?',
      options: <String>[
        'A tesori preziosi in fragili vasi di argilla',
        'A re potenti',
        'A guerrieri invincibili',
        'A statue immutabili',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine di umiltà e potenza divina (2 Corinti 4:7).',
    ),
  ],
  '2 Corinthians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale appello centrale lancia Paolo in 2 Corinti 5?',
      options: <String>['Riconciliatevi con Dio', 'Cercate prima di tutto la ricchezza', 'Evitate ogni predicazione', 'Fuggite ogni responsabilità'],
      correctIndex: 0,
      explanation: 'Il messaggio centrale della riconciliazione (2 Corinti 5:20).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pentitevi', 'pregate', 'amatevi'],
    ),
    QuizQuestion(
      text: 'Quale principio insegna Paolo sul dono generoso in 2 Corinti 9?',
      options: <String>[
        'Dio ama chi dona con gioia',
        'Il dono deve sempre essere forzato',
        'Solo i ricchi devono donare',
        'Il dono non ha alcuna importanza',
      ],
      correctIndex: 0,
      explanation: '«Dio ama chi dona con gioia» (2 Corinti 9:7).',
    ),
  ],
  '2 Corinthians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Come risponde Paolo alla sua «spina nella carne» in 2 Corinti 12?',
      options: <String>[
        'Accetta che la potenza di Dio si compia nella debolezza',
        'Abbandona il suo ministero',
        'Esige una guarigione immediata',
        'Accusa Dio di ingiustizia',
      ],
      correctIndex: 0,
      explanation: '«La mia potenza si compie nella debolezza» (2 Corinti 12:9).',
    ),
    QuizQuestion(
      text: 'Quale appello finale lancia Paolo in 2 Corinti 13?',
      options: <String>[
        'Esaminare se stessi per vedere se si è nella fede',
        'Ignorare ogni esame personale',
        'Giudicare severamente solo gli altri',
        'Abbandonare ogni riflessione spirituale',
      ],
      correctIndex: 0,
      explanation: 'Un invito a una sincera introspezione (2 Corinti 13:5).',
    ),
  ],
  'Galatians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Da dove afferma Paolo di trarre la sua autorità apostolica?',
      options: <String>[
        'Direttamente da Gesù Cristo, non dagli uomini',
        'Solo dalla nomina degli apostoli di Gerusalemme',
        'Da una sua decisione personale',
        'Da una tradizione familiare',
      ],
      correctIndex: 0,
      explanation: 'Paolo difende la legittimità della sua missione (Galati 1).',
    ),
    QuizQuestion(
      text: 'Perché Paolo ha ripreso Pietro pubblicamente?',
      options: <String>[
        'Pietro evitava per ipocrisia di mangiare con i non Ebrei',
        'Pietro aveva rubato del denaro',
        'Pietro aveva rinnegato la sua fede',
        'Pietro rifiutava di predicare',
      ],
      correctIndex: 0,
      explanation: 'Viene corretta un’incoerenza pratica (Galati 2).',
    ),
  ],
  'Galatians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Su cosa si basa la giustificazione secondo Galati 3, '
          'illustrata dall’esempio di Abraamo?',
      options: <String>[
        'Sulla fede, e non sulle opere della legge',
        'Solo sulla discendenza biologica',
        'Sulla ricchezza personale',
        'Sullo status sociale',
      ],
      correctIndex: 0,
      explanation: 'Un principio centrale ripreso dalla vita di Abraamo (Galati 3:6).',
    ),
    QuizQuestion(
      text: 'Quale ruolo ha svolto la legge secondo Galati 3-4, '
          'in attesa di Cristo?',
      options: <String>[
        'Quello di un pedagogo che conduce a Cristo',
        'Un mezzo definitivo di salvezza',
        'Un semplice rituale senza significato',
        'Una maledizione senza scopo',
      ],
      correctIndex: 0,
      explanation: 'La legge preparava alla venuta del Messia (Galati 3:24).',
    ),
  ],
  'Galatians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale frutto dello spirito mette in evidenza Galati 5, '
          'in contrasto con le opere della carne?',
      options: <String>[
        'Amore, gioia, pace, pazienza e altre qualità',
        'Ricchezza e potere',
        'Ambizione personale',
        'Dominio sugli altri',
      ],
      correctIndex: 0,
      explanation: 'Un elenco di qualità cristiane essenziali (Galati 5:22, 23).',
    ),
    QuizQuestion(
      text: 'Cosa consiglia Galati 6 riguardo ai pesi degli altri?',
      options: <String>[
        'Portarli gli uni degli altri',
        'Ignorarli completamente',
        'Giudicarli severamente',
        'Evitarli a tutti i costi',
      ],
      correctIndex: 0,
      explanation: 'Un invito al sostegno reciproco tra fratelli (Galati 6:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ignorarli', 'aumentarli', 'dividerli'],
    ),
  ],
  'Ephesians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Per mezzo di cosa sono salvati i cristiani secondo Efesini 2?',
      options: <String>[
        'Per grazia, mediante la fede, non per le opere',
        'Solo per le loro buone azioni',
        'Per la loro origine etnica',
        'Per la loro ricchezza materiale',
      ],
      correctIndex: 0,
      explanation: 'Un principio fondamentale della salvezza (Efesini 2:8, 9).',
    ),
    QuizQuestion(
      text: 'Cosa realizza Cristo tra Ebrei e non Ebrei secondo Efesini 2?',
      options: <String>[
        'Li unisce in una sola nuova umanità',
        'Mantiene una separazione permanente',
        'Favorisce un gruppo a danno dell’altro',
        'Ignora questa distinzione',
      ],
      correctIndex: 0,
      explanation: 'Il muro di separazione viene abbattuto (Efesini 2:14).',
    ),
  ],
  'Ephesians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale «mistero» dice Paolo di aver ricevuto l’incarico di rivelare alle nazioni?',
      options: <String>[
        'Che i non Ebrei sono coeredi della promessa',
        'Un segreto riservato a pochi privilegiati',
        'Un insegnamento nascosto sugli angeli',
        'Una profezia su Roma',
      ],
      correctIndex: 0,
      explanation: 'Un’inaspettata inclusione delle nazioni (Efesini 3:6).',
    ),
    QuizQuestion(
      text: 'Cosa devono «rivestire» i cristiani secondo Efesini 4?',
      options: <String>[
        'La nuova personalità, simile a Dio',
        'Vesti sontuose',
        'Una ricchezza visibile',
        'Uno status sociale superiore',
      ],
      correctIndex: 0,
      explanation: 'Viene richiesto un profondo cambiamento interiore (Efesini 4:24).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['vecchia', 'carne', 'opere'],
    ),
  ],
  'Ephesians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'A cosa paragona Paolo la relazione tra marito e moglie in Efesini 5?',
      options: <String>[
        'Alla relazione tra Cristo e la congregazione',
        'A una semplice associazione commerciale',
        'A una gerarchia senza amore',
        'A una competizione permanente',
      ],
      correctIndex: 0,
      explanation: 'Viene proposto un modello di amore sacrificale (Efesini 5:25).',
    ),
    QuizQuestion(
      text: 'Cosa rappresenta «l’armatura completa di Dio» in Efesini 6?',
      options: <String>[
        'Qualità spirituali per resistere al combattimento spirituale',
        'Un equipaggiamento militare letterale',
        'Una semplice metafora senza applicazione',
        'Un’uniforme religiosa',
      ],
      correctIndex: 0,
      explanation: 'Ogni elemento simboleggia una qualità protettiva (Efesini 6:11-17).',
    ),
  ],
  'Philippians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Come percepisce Paolo la sua condizione di prigionia in questa lettera?',
      options: <String>[
        'Se ne rallegra, perché serve al progresso della buona notizia',
        'Ne è totalmente disperato',
        'Abbandona il suo ministero',
        'Accusa i suoi carcerieri senza speranza',
      ],
      correctIndex: 0,
      explanation: 'Un atteggiamento positivo nonostante la prova (Filippesi 1).',
    ),
    QuizQuestion(
      text: 'Quale celebre dichiarazione riassume la prospettiva di Paolo sulla vita e sulla morte?',
      options: <String>[
        '«Per me il vivere è Cristo, e il morire un guadagno»',
        '«La vita non ha alcun senso»',
        '«Meglio fuggire ogni prova»',
        '«La morte va evitata a ogni costo»',
      ],
      correctIndex: 0,
      explanation: 'Una fiducia totale in Cristo (Filippesi 1:21).',
    ),
  ],
  'Philippians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale esempio di umiltà propone Paolo in Filippesi 2?',
      options: <String>[
        'Cristo, che si è abbassato fino a diventare schiavo',
        'Un re potente e glorioso',
        'Un filosofo famoso',
        'Un generale vittorioso',
      ],
      correctIndex: 0,
      explanation: 'Un modello di umiltà estrema (Filippesi 2:5-8).',
    ),
    QuizQuestion(
      text: 'Cosa dice Paolo di aver abbandonato per guadagnare Cristo in Filippesi 3?',
      options: <String>[
        'Tutti i suoi vantaggi e successi passati',
        'Niente di particolare',
        'Solo la sua nazionalità',
        'La sua vita di preghiera',
      ],
      correctIndex: 0,
      explanation: 'Considera tutto una perdita di fronte a Cristo (Filippesi 3:8).',
    ),
  ],
  'Philippians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa promette Filippesi 4 a chi prega senza ansia?',
      options: <String>[
        'La pace di Dio che supera ogni pensiero',
        'Una ricchezza immediata',
        'L’assenza totale di problemi',
        'Niente di particolare',
      ],
      correctIndex: 0,
      explanation: 'Una promessa di pace interiore (Filippesi 4:6, 7).',
    ),
    QuizQuestion(
      text: 'Quale dichiarazione di fiducia fa Paolo riguardo alla sua forza personale?',
      options: <String>[
        '«Posso ogni cosa grazie a colui che mi dà la forza»',
        '«Riesco da solo, senza aiuto»',
        '«Dipendo solo dagli uomini»',
        '«Niente mi sostiene davvero»',
      ],
      correctIndex: 0,
      explanation: 'Una fiducia riposta in Cristo (Filippesi 4:13).',
    ),
  ],
  'Colossians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Come descrive Colossesi 1 la posizione di Cristo rispetto alla creazione?',
      options: <String>[
        'Tutto è stato creato per mezzo suo e per lui',
        'È una creatura tra le altre, senza distinzione',
        'Non ha alcun ruolo nella creazione',
        'È successivo a ogni creazione',
      ],
      correctIndex: 0,
      explanation: 'A Cristo viene attribuito un posto centrale (Colossesi 1:16).',
    ),
    QuizQuestion(
      text: 'Quale «mistero» dice Paolo di avere la missione di rivelare?',
      options: <String>[
        'Cristo in voi, la speranza della gloria',
        'Un insegnamento riservato segretamente a pochi',
        'Una profezia su Roma',
        'Un rituale nascosto del tempio',
      ],
      correctIndex: 0,
      explanation: 'Una verità ormai resa pubblica (Colossesi 1:27).',
    ),
  ],
  'Colossians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Contro cosa mette in guardia Paolo in Colossesi 2?',
      options: <String>[
        'La filosofia vuota e le tradizioni umane',
        'La preghiera stessa',
        'La fede autentica',
        'L’insegnamento degli apostoli',
      ],
      correctIndex: 0,
      explanation: 'Un avvertimento contro le false dottrine (Colossesi 2:8).',
    ),
    QuizQuestion(
      text: 'Cosa devono «rivestire» i cristiani secondo Colossesi 3?',
      options: <String>[
        'La nuova personalità, con compassione e amore',
        'Vesti costose',
        'Un atteggiamento di superiorità',
        'Niente di particolare',
      ],
      correctIndex: 0,
      explanation: 'Viene richiesto un concreto cambiamento interiore (Colossesi 3:10, 12).',
    ),
  ],
  'Colossians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Come incoraggia Paolo a comportarsi verso le persone estranee alla fede?',
      options: <String>[
        'Con saggezza, sfruttando bene il tempo',
        'Con totale indifferenza',
        'Evitandole sistematicamente',
        'Con aperto disprezzo',
      ],
      correctIndex: 0,
      explanation: 'Viene raccomandato un comportamento assennato (Colossesi 4:5).',
    ),
    QuizQuestion(
      text: 'Quale tono caratterizza la fine della lettera ai Colossesi?',
      options: <String>[
        'Calorosi saluti personali',
        'Un giudizio severo',
        'Un elenco di leggi supplementari',
        'Un brusco silenzio',
      ],
      correctIndex: 0,
      explanation: 'Paolo conclude con affettuosi saluti (Colossesi 4).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['rimproveri', 'avvertimenti', 'istruzioni'],
    ),
  ],
  '1 Thessalonians#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Come descrive Paolo la fede dei Tessalonicesi?',
      options: <String>[
        'Un esempio per i credenti circostanti',
        'Debole ed esitante',
        'Inesistente all’inizio',
        'Basata solo sul timore',
      ],
      correctIndex: 0,
      explanation: 'La loro fede è diventata un modello riconosciuto (1 Tessalonicesi 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['debole', 'tiepida', 'vacillante'],
    ),
    QuizQuestion(
      text: 'Come descrive Paolo il suo ministero tra loro?',
      options: <String>[
        'Sincero, come una madre che si prende cura dei propri figli',
        'Interessato e calcolatore',
        'Distante e freddo',
        'Basato sull’adulazione',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine tenera della sua dedizione (1 Tessalonicesi 2:7).',
    ),
  ],
  '1 Thessalonians#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Perché Paolo ha inviato Timoteo ai Tessalonicesi?',
      options: <String>[
        'Per rafforzare la loro fede di fronte alle prove',
        'Solo per raccogliere denaro',
        'Per rimproverarli severamente',
        'Per porre fine alla congregazione',
      ],
      correctIndex: 0,
      explanation: 'Una preoccupazione pastorale motiva questo invio (1 Tessalonicesi 3).',
    ),
    QuizQuestion(
      text: 'Quale sentimento esprime Paolo nell’apprendere la loro fedeltà persistente?',
      options: <String>['Una grande gioia', 'Delusione', 'Indifferenza', 'Rabbia'],
      correctIndex: 0,
      explanation: 'La loro costanza lo conforta profondamente (1 Tessalonicesi 3:8, 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['tristezza', 'timore', 'sorpresa'],
    ),
  ],
  '1 Thessalonians#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Come descrive 1 Tessalonicesi 4 la risurrezione dei credenti?',
      options: <String>[
        'Saranno rapiti per incontrare il Signore',
        'Resteranno indefinitamente nella tomba',
        'Nessuna risurrezione viene menzionata',
        'Solo pochi privilegiati risorgeranno',
      ],
      correctIndex: 0,
      explanation: 'Una speranza centrale per i credenti (1 Tessalonicesi 4:17).',
    ),
    QuizQuestion(
      text: 'A cosa viene paragonato il giorno di Geova in 1 Tessalonicesi 5?',
      options: <String>['A un ladro di notte', 'A una festa prevedibile', 'A un giorno ordinario', 'A un semplice avvertimento senza effetto'],
      correctIndex: 0,
      explanation: 'Un’immagine di arrivo improvviso e inatteso (1 Tessalonicesi 5:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sposo', 'pastore', 'giorno'],
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesItC6 = <String, List<QuizQuestion>>{
  // No entries for Romans, 1 Corinthians, 2 Corinthians, Galatians, Ephesians,
  // Philippians, Colossians, or 1 Thessalonians exist in _extraQuizzes.
};
