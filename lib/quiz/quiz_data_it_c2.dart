import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesItC2 = <String, List<QuizQuestion>>{
  '1 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa promise Anna a Geova se avesse avuto un figlio?',
      options: <String>[
        'Di consacrarlo al suo servizio per tutta la vita',
        'Di offrirgli metà dei suoi beni',
        'Di costruire un tempio',
        'Di diventare lei stessa sacerdotessa',
      ],
      correctIndex: 0,
      explanation:
          'Anna consacra Samuele al servizio del tabernacolo (1 Samuele 1).',
    ),
    QuizQuestion(
      text: 'In che modo Geova chiamò il giovane Samuele?',
      options: <String>[
        'Pronunciando il suo nome di notte, più volte',
        'Tramite un angelo visibile',
        'Tramite un sogno unico',
        'Tramite una voce pubblica',
      ],
      correctIndex: 0,
      explanation:
          'Samuele crede dapprima che sia Eli a chiamarlo (1 Samuele 3).',
    ),
    QuizQuestion(
      text: 'Perché il popolo chiese un re a Samuele?',
      options: <String>[
        'Per essere come le altre nazioni',
        'Per ordine diretto di Geova',
        'A causa di un’invasione imminente',
        'Perché lo proponeva Samuele',
      ],
      correctIndex: 0,
      explanation: 'Il popolo rigetta il governo diretto di Dio (1 Samuele 8).',
    ),
  ],
  '1 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi unse Samuele in segreto come primo re d’Israele?',
      options: <String>['Saul', 'Davide', 'Gionatan', 'Abner'],
      correctIndex: 0,
      explanation: 'Samuele unge Saul in modo discreto (1 Samuele 9-10).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Perché Samuele annunciò il rigetto di Saul come re?',
      options: <String>[
        'Saul offrì un sacrificio senza aspettare Samuele',
        'Saul perse una battaglia',
        'Saul rifiutò di regnare',
        'Saul fuggì davanti al nemico',
      ],
      correctIndex: 0,
      explanation:
          'Saul disubbidisce offrendo lui stesso il sacrificio (1 Samuele 13).',
    ),
    QuizQuestion(
      text: 'Perché Saul fu definitivamente rigettato come re da Geova?',
      options: <String>[
        'Disubbidì risparmiando Agag e il meglio del bestiame',
        'Perse una battaglia di poco conto',
        'Invecchiò troppo in fretta',
        'Chiese aiuto a Samuele',
      ],
      correctIndex: 0,
      explanation:
          'La disubbidienza riguardo ad Amalec suggella il suo rigetto (1 Samuele 15).',
    ),
  ],
  '1 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Con quale arma Davide sconfisse Golia?',
      options: <String>[
        'Una fionda e una pietra',
        'Una spada',
        'Una lancia',
        'A mani nude',
      ],
      correctIndex: 0,
      explanation:
          'Davide rifiuta l’armatura e usa la sua fionda (1 Samuele 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['spada', 'lancia', 'scudo'],
    ),
    QuizQuestion(
      text:
          'Quale sentimento spinse Saul a voler uccidere Davide dopo la sua vittoria?',
      options: <String>[
        'La gelosia',
        'La paura dei Filistei',
        'La collera di Samuele',
        'Un consiglio di Gionatan',
      ],
      correctIndex: 0,
      explanation:
          'I canti di lode per Davide rendono Saul geloso (1 Samuele 18).',
    ),
    QuizQuestion(
      text: 'Chi aiutò Davide a sfuggire a Saul avvertendolo del pericolo?',
      options: <String>[
        'Gionatan',
        'Abner',
        'Solo Samuele',
        'Un sacerdote sconosciuto',
      ],
      correctIndex: 0,
      explanation:
          'Gionatan avverte Davide grazie a un segnale concordato (1 Samuele 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  '1 Samuel#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa fa Davide quando ha l’occasione di uccidere Saul in una grotta?',
      options: <String>[
        'Lo risparmia e taglia solo un lembo della sua veste',
        'Lo uccide immediatamente',
        'Fugge senza agire',
        'Negozia una pace',
      ],
      correctIndex: 0,
      explanation:
          'Davide rifiuta di toccare «l’unto di Geova» (1 Samuele 24).',
    ),
    QuizQuestion(
      text:
          'Chi evitò un conflitto tra Davide e Nabal grazie alla sua saggezza?',
      options: <String>['Abigail', 'Mical', 'Una serva', 'Il sommo sacerdote'],
      correctIndex: 0,
      explanation: 'Abigail placa Davide con delle provviste (1 Samuele 25).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Dove muoiono Saul e Gionatan nella battaglia finale del libro?',
      options: <String>[
        'Sul monte Ghilboa, contro i Filistei',
        'A Gerusalemme',
        'A Ebron',
        'A Ghibea',
      ],
      correctIndex: 0,
      explanation: 'Saul e i suoi figli muoiono sul Ghilboa (1 Samuele 31).',
    ),
  ],
  '2 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Come reagì Davide alla morte di Saul e Gionatan?',
      options: <String>[
        'Compose un canto di lutto (una lamentazione)',
        'Si rallegrò',
        'Ignorò la notizia',
        'Attaccò immediatamente',
      ],
      correctIndex: 0,
      explanation: 'Davide compone «il Canto dell’arco» (2 Samuele 1).',
    ),
    QuizQuestion(
      text: 'Quale città conquistò Davide per farne la sua capitale?',
      options: <String>['Gerusalemme', 'Ebron', 'Silo', 'Ghibea'],
      correctIndex: 0,
      explanation: 'Davide prende la fortezza di Sion (2 Samuele 5).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Quale promessa fa Geova a Davide tramite il profeta Natan?',
      options: <String>[
        'Un discendente regnerà per sempre',
        'Davide costruirà lui stesso il tempio',
        'Davide vivrà in eterno',
        'Davide diventerà sacerdote',
      ],
      correctIndex: 0,
      explanation:
          'Il patto davidico promette una dinastia eterna (2 Samuele 7).',
    ),
  ],
  '2 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Con chi Davide commise adulterio, arrivando a far uccidere Uria?',
      options: <String>['Bat-Sceba', 'Mical', 'Abigail', 'Tamar'],
      correctIndex: 0,
      explanation:
          'Davide fa uccidere Uria per nascondere il suo peccato (2 Samuele 11).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Betsabea'],
    ),
    QuizQuestion(
      text:
          'In che modo il profeta Natan affrontò Davide riguardo al suo peccato?',
      options: <String>[
        'Con una parabola su un uomo ricco e uno povero',
        'Denunciandolo pubblicamente',
        'Con una lettera anonima',
        'Lasciando il suo servizio',
      ],
      correctIndex: 0,
      explanation:
          'La parabola spinge Davide a riconoscere la sua colpa (2 Samuele 12).',
    ),
    QuizQuestion(
      text: 'Chi si ribellò contro suo padre Davide per prendere il trono?',
      options: <String>['Absalom', 'Amnon', 'Salomone', 'Adonia'],
      correctIndex: 0,
      explanation: 'Inizia la ribellione di Absalom (2 Samuele 15).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Assalonne'],
    ),
  ],
  '2 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale consiglio fece fallire il piano rapido di Achitofel contro Davide?',
      options: <String>[
        'Quello di Cusai, rimasto fedele a Davide',
        'Quello di Ioab',
        'Quello di un sacerdote',
        'Quello di Salomone',
      ],
      correctIndex: 0,
      explanation: 'Cusai ritarda l’attacco e salva Davide (2 Samuele 17).',
    ),
    QuizQuestion(
      text: 'Come morì Absalom?',
      options: <String>[
        'Rimasto appeso per i capelli a un albero, ucciso da Ioab',
        'In duello contro Davide',
        'Avvelenato',
        'In esilio, di vecchiaia',
      ],
      correctIndex: 0,
      explanation:
          'Absalom resta impigliato all’albero e poi Ioab lo trafigge (2 Samuele 18).',
    ),
    QuizQuestion(
      text:
          'Quale azione di Davide provocò una pestilenza su Israele verso la fine del libro?',
      options: <String>[
        'Un censimento del popolo',
        'La costruzione di un palazzo',
        'Un matrimonio proibito',
        'Un rifiuto di sacrificio',
      ],
      correctIndex: 0,
      explanation:
          'Il censimento dispiace a Dio e ne segue una pestilenza (2 Samuele 24).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['peste', 'guerra', 'altare'],
    ),
  ],
  '1 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi tentò di impadronirsi del trono prima della morte di Davide?',
      options: <String>['Adonia', 'Absalom', 'Solo Ioab', 'Natan'],
      correctIndex: 0,
      explanation:
          'Adonia si proclama re senza il consenso di Davide (1 Re 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Che cosa chiede Salomone a Geova all’inizio del suo regno?',
      options: <String>[
        'Un cuore comprensivo per giudicare il popolo',
        'La ricchezza prima di ogni altra cosa',
        'La vittoria militare',
        'Una lunga vita senza condizioni',
      ],
      correctIndex: 0,
      explanation:
          'Salomone chiede la saggezza, cosa che piace a Dio (1 Re 3).',
    ),
    QuizQuestion(
      text: 'Chi aiutò Salomone a fornire i materiali per costruire il tempio?',
      options: <String>[
        'Chiram, re di Tiro',
        'Il faraone d’Egitto',
        'La regina di Seba',
        'Il re di Moab',
      ],
      correctIndex: 0,
      explanation: 'Chiram fornisce legno di cedro e artigiani (1 Re 5).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Chiram', 'Hiram'],
    ),
  ],
  '1 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa succede quando il tempio viene completato e dedicato?',
      options: <String>[
        'La gloria di Geova riempie il tempio',
        'Si verifica un terremoto',
        'Il popolo si ribella',
        'Salomone lascia Gerusalemme',
      ],
      correctIndex: 0,
      explanation: 'La nube di gloria riempie la casa (1 Re 8).',
    ),
    QuizQuestion(
      text: 'Perché il regno di Salomone finì per indebolirsi spiritualmente?',
      options: <String>[
        'Le sue mogli straniere sviarono il suo cuore',
        'Perse una guerra',
        'Fu mandato in esilio',
        'Gli mancò la ricchezza',
      ],
      correctIndex: 0,
      explanation:
          'L’idolatria delle sue mogli porta alla sua infedeltà (1 Re 11).',
    ),
    QuizQuestion(
      text:
          'Che cosa fa Geroboamo dopo la divisione del regno per impedire al popolo di andare a Gerusalemme?',
      options: <String>[
        'Installa vitelli d’oro a Betel e a Dan',
        'Distrugge tutte le strade',
        'Vieta ogni forma di culto',
        'Costruisce un nuovo tempio identico',
      ],
      correctIndex: 0,
      explanation: 'Geroboamo introduce un culto idolatrico rivale (1 Re 12).',
    ),
  ],
  '1 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi annunciò una siccità punitiva al re Acab?',
      options: <String>['Elia', 'Eliseo', 'Michea', 'Abdia'],
      correctIndex: 0,
      explanation: 'Elia annuncia l’assenza di pioggia e di rugiada (1 Re 17).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Che cosa accadde durante la sfida sul monte Carmelo?',
      options: <String>[
        'Il fuoco di Geova consumò il sacrificio di Elia',
        'Prima cadde improvvisamente la pioggia',
        'Vinsero i profeti di Baal',
        'Non accadde nulla',
      ],
      correctIndex: 0,
      explanation:
          'Geova risponde con il fuoco davanti a tutto Israele (1 Re 18).',
    ),
    QuizQuestion(
      text: 'Perché Acab e Izebel fecero uccidere Nabot?',
      options: <String>[
        'Per impadronirsi della sua vigna',
        'Per un crimine che aveva commesso',
        'Per un debito non pagato',
        'Su ordine di un profeta',
      ],
      correctIndex: 0,
      explanation: 'Izebel orchestra un processo farsa contro Nabot (1 Re 21).',
    ),
  ],
  '2 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text: 'In che modo Elia lasciò la terra?',
      options: <String>[
        'Portato in cielo in un turbine',
        'Morì di vecchiaia',
        'Fu mandato in esilio',
        'Scomparve senza spiegazione',
      ],
      correctIndex: 0,
      explanation: 'Eliseo vede Elia portato via da un turbine (2 Re 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['carro', 'fuoco', 'Eliseo'],
    ),
    QuizQuestion(
      text: 'Quale miracolo compì Eliseo per la donna sunamita?',
      options: <String>[
        'Riportò in vita suo figlio',
        'Moltiplicò il suo gregge',
        'La guarì dalla lebbra',
        'Ricostruì la sua casa',
      ],
      correctIndex: 0,
      explanation: 'Eliseo risuscita il figlio della sunamita (2 Re 4).',
    ),
    QuizQuestion(
      text: 'In che modo Naaman fu guarito dalla lebbra?',
      options: <String>[
        'Immergendosi sette volte nel Giordano',
        'Con un unguento speciale',
        'Con una preghiera collettiva',
        'Con un digiuno prolungato',
      ],
      correctIndex: 0,
      explanation:
          'Naaman ubbidisce all’istruzione di Eliseo nonostante il suo scetticismo (2 Re 5).',
    ),
  ],
  '2 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: 'In che modo l’assedio di Samaria fu tolto in modo inaspettato?',
      options: <String>[
        'L’esercito siro fuggì, spaventato da un rumore',
        'Arrivò un esercito alleato',
        'Fu firmata una tregua',
        'Il re siro morì in battaglia',
      ],
      correctIndex: 0,
      explanation:
          'Geova fa udire un rumore che fa fuggire in preda al panico il nemico (2 Re 7).',
    ),
    QuizQuestion(
      text: 'Chi eliminò Ieu per purificare la regalità d’Israele?',
      options: <String>[
        'Ioram, Izebel e la casa di Acab',
        'Solo i profeti di Baal',
        'I re di Giuda',
        'Gli Assiri',
      ],
      correctIndex: 0,
      explanation:
          'Ieu esegue il giudizio annunciato contro la casa di Acab (2 Re 9-10).',
    ),
    QuizQuestion(
      text: 'In che modo il giovane Ioas fu protetto prima di diventare re?',
      options: <String>[
        'Nascosto nel tempio da sua zia',
        'Mandato all’estero',
        'Cresciuto da un profeta isolato',
        'Protetto dall’esercito assiro',
      ],
      correctIndex: 0,
      explanation: 'Ioas sfugge alla strage di Atalia (2 Re 11).',
    ),
  ],
  '2 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa succede al regno del nord (Israele) dopo l’assedio assiro?',
      options: <String>[
        'Samaria cade e il popolo viene deportato',
        'Conquista l’Assiria',
        'Firma una pace duratura',
        'In realtà non cambia nulla',
      ],
      correctIndex: 0,
      explanation:
          'La caduta di Samaria segna la fine del regno del nord (2 Re 17).',
    ),
    QuizQuestion(
      text: 'Come reagì Ezechia alla lettera minacciosa di Sennacherib?',
      options: <String>[
        'La distese davanti a Geova e pregò',
        'Si arrese senza resistere',
        'Fuggì dalla città',
        'Ignorò la minaccia',
      ],
      correctIndex: 0,
      explanation:
          'La preghiera di Ezechia precede la liberazione miracolosa (2 Re 19).',
    ),
    QuizQuestion(
      text: 'Che cosa accadde all’esercito assiro che assediava Gerusalemme?',
      options: <String>[
        'Un angelo ne colpì un gran numero in una sola notte',
        'Fu sconfitto in battaglia',
        'Si ritirò semplicemente',
        'Un’epidemia lo indebolì lentamente',
      ],
      correctIndex: 0,
      explanation: 'L’intervento divino salva Gerusalemme (2 Re 19).',
    ),
  ],
  '2 Kings#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa scoprì il sommo sacerdote Chilchia sotto il regno di Giosia?',
      options: <String>[
        'Il libro della legge, perduto nel tempio',
        'Un tesoro d’oro',
        'Una tomba reale',
        'Una nuova sorgente d’acqua',
      ],
      correctIndex: 0,
      explanation:
          'La scoperta rilancia la riforma religiosa di Giosia (2 Re 22).',
    ),
    QuizQuestion(
      text: 'Quale grande festa celebrò Giosia dopo la sua riforma?',
      options: <String>[
        'La Pasqua',
        'Le Capanne',
        'La Pentecoste',
        'Il Giubileo',
      ],
      correctIndex: 0,
      explanation: 'Viene celebrata una Pasqua memorabile (2 Re 23).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Pasqua'],
    ),
    QuizQuestion(
      text: 'Come termina il libro dei Re?',
      options: <String>[
        'Con la caduta di Gerusalemme e la distruzione del tempio',
        'Con l’incoronazione di un re giusto e duraturo',
        'Con una grande vittoria militare',
        'Con il ritorno immediato dall’esilio',
      ],
      correctIndex: 0,
      explanation:
          'Il racconto si conclude con l’esilio a Babilonia (2 Re 25).',
    ),
  ],
  '1 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Con quali genealogie inizia questo libro?',
      options: <String>[
        'Da Adamo fino alle dodici tribù d’Israele',
        'Solo la linea di Davide',
        'Solo i sacerdoti',
        'I re d’Egitto',
      ],
      correctIndex: 0,
      explanation: 'Gli elenchi risalgono ad Adamo (1 Cronache 1-2).',
    ),
    QuizQuestion(
      text: 'Da quale tribù discende la linea reale di Davide?',
      options: <String>['Giuda', 'Levi', 'Beniamino', 'Efraim'],
      correctIndex: 0,
      explanation:
          'La genealogia di Giuda include la casa di Davide (1 Cronache 2-3).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Quali tribù si stabilirono a est del Giordano secondo queste genealogie?',
      options: <String>[
        'Ruben, Gad e mezza tribù di Manasse',
        'Giuda e Beniamino',
        'Levi e Simeone',
        'Dan e Neftali',
      ],
      correctIndex: 0,
      explanation:
          'Vengono ricordati il loro territorio e i loro capi (1 Cronache 5).',
    ),
  ],
  '1 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Perché Uzza morì mentre trasportava l’Arca?',
      options: <String>[
        'La toccò mentre scivolava, contro le regole divine',
        'La rubò',
        'Rifiutò di portarla',
        'Si prese gioco del corteo',
      ],
      correctIndex: 0,
      explanation:
          'Il trasporto non rispettava le istruzioni divine (1 Cronache 13).',
    ),
    QuizQuestion(
      text:
          'In che modo l’Arca fu infine trasportata correttamente a Gerusalemme?',
      options: <String>[
        'Portata dai leviti, come prescriveva la legge',
        'Su un carro trainato da buoi',
        'Via mare',
        'Dai sacerdoti egiziani',
      ],
      correctIndex: 0,
      explanation: 'Davide corregge l’errore precedente (1 Cronache 15).',
    ),
    QuizQuestion(
      text: 'Contro chi Davide riportò notevoli vittorie in questi capitoli?',
      options: <String>[
        'I Filistei',
        'Gli Egiziani',
        'I Babilonesi',
        'I Persiani',
      ],
      correctIndex: 0,
      explanation: 'Davide sconfigge più volte i Filistei (1 Cronache 14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Filistei'],
    ),
  ],
  '1 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale canto compose Asaf in occasione della collocazione dell’Arca?',
      options: <String>[
        'Un canto di lode e di ringraziamento',
        'Un canto di lutto',
        'Una profezia di sventura',
        'Un canto di guerra',
      ],
      correctIndex: 0,
      explanation: 'Questo salmo di lode è affidato ad Asaf (1 Cronache 16).',
    ),
    QuizQuestion(
      text: 'Perché Davide non poté costruire il tempio lui stesso?',
      options: <String>[
        'Aveva versato molto sangue in guerra',
        'Gli mancava la ricchezza',
        'Non aveva un progetto',
        'Il popolo vi si opponeva',
      ],
      correctIndex: 0,
      explanation:
          'Geova riserva questo compito a Salomone (1 Cronache 22; 28).',
    ),
    QuizQuestion(
      text: 'Dove acquistò Davide il luogo del futuro tempio?',
      options: <String>[
        'L’aia di trebbiatura di Ornan (Arauna)',
        'Un campo vicino a Ebron',
        'Una collina a Silo',
        'Un terreno donato da Chiram',
      ],
      correctIndex: 0,
      explanation:
          'Davide vi costruisce un altare dopo la pestilenza (1 Cronache 21).',
    ),
  ],
  '1 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: 'In che modo Davide organizzò il servizio dei leviti?',
      options: <String>[
        'In gruppi con compiti precisi assegnati',
        'Non avevano alcuna organizzazione',
        'Un solo uomo si occupava di tutto',
        'Erano dispensati dal servizio',
      ],
      correctIndex: 0,
      explanation: 'I leviti vengono suddivisi per funzioni (1 Cronache 23).',
    ),
    QuizQuestion(
      text: 'Quale ruolo svolgevano i musicisti designati da Davide?',
      options: <String>[
        'Profetizzare e lodare con gli strumenti',
        'Combattere in prima linea',
        'Giudicare le cause',
        'Insegnare solo la lettura',
      ],
      correctIndex: 0,
      explanation:
          'Asaf, Eman e Iedutun dirigono la musica sacra (1 Cronache 25).',
    ),
    QuizQuestion(
      text:
          'Quale fu l’ultima grande azione pubblica di Davide prima di morire?',
      options: <String>[
        'Incaricare Salomone e il popolo di costruire il tempio',
        'Condurre un’ultima guerra',
        'Rivedere tutte le leggi',
        'Partire volontariamente in esilio',
      ],
      correctIndex: 0,
      explanation:
          'Davide prega e benedice l’assemblea prima di morire (1 Cronache 28-29).',
    ),
  ],
  '2 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa chiede Salomone a Geova all’inizio del suo regno?',
      options: <String>[
        'La saggezza e la conoscenza per governare',
        'La ricchezza prima di ogni altra cosa',
        'Un esercito potente',
        'Una vita senza prove',
      ],
      correctIndex: 0,
      explanation:
          'La sua richiesta piace a Dio, che gli dà anche la ricchezza (2 Cronache 1).',
    ),
    QuizQuestion(
      text: 'Che cosa accadde quando il tempio fu dedicato?',
      options: <String>[
        'Il fuoco scese dal cielo e la gloria riempì la casa',
        'Un terremoto distrusse tutto',
        'Non accadde nulla di particolare',
        'Il popolo si disperse',
      ],
      correctIndex: 0,
      explanation:
          'Una manifestazione spettacolare conferma l’approvazione divina (2 Cronache 7).',
    ),
    QuizQuestion(
      text: 'Quale preghiera pronuncia Salomone durante la dedicazione?',
      options: <String>[
        'Una supplica affinché Dio ascolti le preghiere rivolte verso quel luogo',
        'Una richiesta di ulteriore ricchezza',
        'Una dichiarazione di guerra',
        'Un canto di lutto',
      ],
      correctIndex: 0,
      explanation: 'Salomone chiede che Dio ascolti dai cieli (2 Cronache 6).',
    ),
  ],
  '2 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Chi fece visita a Salomone per mettere alla prova la sua saggezza?',
      options: <String>[
        'La regina di Seba',
        'Il re d’Assiria',
        'Il faraone d’Egitto',
        'Il re di Tiro',
      ],
      correctIndex: 0,
      explanation:
          'Rimane colpita dalla sua saggezza e dalla sua ricchezza (2 Cronache 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Salomone', 'oro', 'Tiro'],
    ),
    QuizQuestion(
      text: 'Perché il regno si divise sotto Roboamo?',
      options: <String>[
        'Il suo rifiuto di alleggerire il giogo imposto da Salomone',
        'Un’invasione straniera',
        'La morte improvvisa del re',
        'Un accordo pacifico di spartizione',
      ],
      correctIndex: 0,
      explanation:
          'La sua durezza spinge dieci tribù a seguire Geroboamo (2 Cronache 10).',
    ),
    QuizQuestion(
      text: 'Come reagì Asa di fronte all’invasione etiope?',
      options: <String>[
        'Pregò Geova prima della battaglia e vinse',
        'Si arrese senza combattere',
        'Fuggì con il suo esercito',
        'Pagò un pesante tributo',
      ],
      correctIndex: 0,
      explanation: 'La sua fiducia in Dio viene ricompensata (2 Cronache 14).',
    ),
  ],
  '2 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale malattia colpì Asa dopo che trascurò di cercare Geova?',
      options: <String>[
        'Una grave malattia ai piedi',
        'La lebbra',
        'La cecità',
        'Una paralisi totale',
      ],
      correctIndex: 0,
      explanation: 'Consulta i medici anziché Dio (2 Cronache 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['lebbra', 'peste', 'cecità'],
    ),
    QuizQuestion(
      text: 'Perché Giosafat fu ripreso da un profeta?',
      options: <String>[
        'Per la sua alleanza con il malvagio re Acab',
        'Per aver trascurato il tempio',
        'Per aver rifiutato la guerra',
        'Per aver abolito le feste',
      ],
      correctIndex: 0,
      explanation: 'La sua alleanza con Acab viene criticata (2 Cronache 19).',
    ),
    QuizQuestion(
      text: 'In che modo Giosafat riportò una vittoria senza combattere?',
      options: <String>[
        'Pregando, mentre i suoi nemici si uccidevano a vicenda',
        'Grazie a una tregua negoziata',
        'Con una fuga strategica',
        'Grazie a un trattato con l’Egitto',
      ],
      correctIndex: 0,
      explanation:
          'La fiducia in Dio precede una liberazione miracolosa (2 Cronache 20).',
    ),
  ],
  '2 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: 'In che modo il giovane Ioas fu salvato dalla strage di Atalia?',
      options: <String>[
        'Nascosto nel tempio da sua zia',
        'Mandato segretamente all’estero',
        'Adottato da un sacerdote straniero',
        'Protetto da un esercito alleato',
      ],
      correctIndex: 0,
      explanation:
          'Ieoseba lo nasconde fino alla sua incoronazione (2 Cronache 22-23).',
    ),
    QuizQuestion(
      text: 'Perché Uzzia (Ozia) fu colpito dalla lebbra?',
      options: <String>[
        'Volle offrire l’incenso, riservato ai sacerdoti',
        'Rifiutò di pagare la decima',
        'Insultò un profeta',
        'Trascurò l’esercito',
      ],
      correctIndex: 0,
      explanation:
          'Il suo orgoglio lo spinge a oltrepassare il suo ruolo (2 Cronache 26).',
    ),
    QuizQuestion(
      text: 'Che cosa fa Ezechia fin dall’inizio del suo regno?',
      options: <String>[
        'Riapre e purifica il tempio',
        'Dichiara guerra all’Assiria',
        'Abolisce tutte le feste',
        'Sposta la capitale',
      ],
      correctIndex: 0,
      explanation:
          'Ezechia intraprende una grande riforma religiosa (2 Cronache 29).',
    ),
  ],
  '2 Chronicles#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale grande festa organizzò Ezechia dopo la purificazione del tempio?',
      options: <String>[
        'Una Pasqua straordinaria',
        'Le Capanne',
        'Il Giubileo',
        'La Pentecoste',
      ],
      correctIndex: 0,
      explanation:
          'Questa Pasqua riunisce Giuda e parte d’Israele (2 Cronache 30).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Pentecoste', 'Capanne', 'digiuno'],
    ),
    QuizQuestion(
      text: 'Che cosa accadde dopo che Manasse si pentì durante la prigionia?',
      options: <String>[
        'Geova lo riportò a Gerusalemme ed egli attuò riforme',
        'Rimase prigioniero per tutta la vita',
        'Fu giustiziato',
        'Non cambiò nulla',
      ],
      correctIndex: 0,
      explanation:
          'Il suo sincero pentimento cambia il suo destino (2 Cronache 33).',
    ),
    QuizQuestion(
      text: 'Come termina il libro delle Cronache?',
      options: <String>[
        'Con il decreto di Ciro che autorizza il ritorno e la ricostruzione del tempio',
        'Con la distruzione finale senza speranza',
        'Con l’incoronazione di un nuovo re davidico',
        'Con una prolungata guerra civile',
      ],
      correctIndex: 0,
      explanation:
          'Il decreto di Ciro apre la via al ritorno dall’esilio (2 Cronache 36).',
    ),
  ],
  'Ezra#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi autorizzò gli esuli a tornare per ricostruire il tempio?',
      options: <String>[
        'Ciro, re di Persia',
        'Nabucodonosor',
        'Solo Dario',
        'Serse',
      ],
      correctIndex: 0,
      explanation: 'Ciro emana un decreto liberatorio (Esdra 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Ciro'],
    ),
    QuizQuestion(
      text:
          'Che cosa fecero gli esuli appena tornati, ancora prima di completare il tempio?',
      options: <String>[
        'Ricostruirono l’altare per offrire sacrifici',
        'Elessero un nuovo re',
        'Attaccarono i loro vicini',
        'Rifiutarono ogni forma di culto',
      ],
      correctIndex: 0,
      explanation:
          'L’altare viene ripristinato prima delle fondamenta (Esdra 3).',
    ),
    QuizQuestion(
      text:
          'Quale reazione mista seguì la posa delle fondamenta del nuovo tempio?',
      options: <String>[
        'Gioia dei giovani, pianto degli anziani che ricordavano il primo',
        'Indifferenza generale',
        'Collera unanime',
        'Fuga del popolo',
      ],
      correctIndex: 0,
      explanation:
          'Il contrasto con il tempio di Salomone commuove gli anziani (Esdra 3).',
    ),
  ],
  'Ezra#1': <QuizQuestion>[
    QuizQuestion(
      text: 'In che modo i lavori di ricostruzione furono interrotti?',
      options: <String>[
        'Degli avversari locali fecero cessare i lavori',
        'Un terremoto distrusse tutto',
        'Al popolo mancarono i materiali',
        'Gli operai se ne andarono di loro iniziativa',
      ],
      correctIndex: 0,
      explanation: 'L’opposizione politica blocca il cantiere (Esdra 4).',
    ),
    QuizQuestion(
      text:
          'Chi incoraggiò la ripresa dei lavori del tempio con le loro profezie?',
      options: <String>[
        'Aggeo e Zaccaria',
        'Ezechiele e Daniele',
        'Isaia e Geremia',
        'Osea e Amos',
      ],
      correctIndex: 0,
      explanation: 'I loro messaggi rilanciano la costruzione (Esdra 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Esdra', 'Neemia', 'Ciro'],
    ),
    QuizQuestion(
      text:
          'Chi arrivò più tardi da Babilonia con un ulteriore gruppo di esuli?',
      options: <String>[
        'Esdra, sacerdote e scriba',
        'Neemia',
        'Zorobabele',
        'Mardocheo',
      ],
      correctIndex: 0,
      explanation: 'Esdra arriva sotto il regno di Artaserse (Esdra 7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Esdra'],
    ),
  ],
  'Ezra#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Perché Esdra non chiese una scorta armata per il viaggio?',
      options: <String>[
        'Aveva espresso la sua fiducia nella protezione di Dio',
        'Il re gliela aveva rifiutata',
        'Il viaggio era privo di pericoli',
        'Aveva già un esercito',
      ],
      correctIndex: 0,
      explanation:
          'Esdra aveva testimoniato della protezione divina (Esdra 8).',
    ),
    QuizQuestion(
      text: 'Quale problema rattristò profondamente Esdra al suo arrivo?',
      options: <String>[
        'Matrimoni con donne delle nazioni vicine',
        'Una mancanza di offerte',
        'Una carestia',
        'Una guerra civile',
      ],
      correctIndex: 0,
      explanation: 'Esdra si straccia le vesti per il dolore (Esdra 9).',
    ),
    QuizQuestion(
      text: 'Come rispose il popolo all’appello di Esdra?',
      options: <String>[
        'Confessando la propria colpa e correggendo la situazione',
        'Rifiutando ogni cambiamento',
        'Espellendo Esdra',
        'Ignorando l’appello',
      ],
      correctIndex: 0,
      explanation: 'Ha luogo una riforma collettiva (Esdra 10).',
    ),
  ],
  'Nehemiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Come reagì Neemia nell’apprendere lo stato delle mura di Gerusalemme?',
      options: <String>[
        'Pianse, digiunò e pregò',
        'Rimase indifferente',
        'Si dimise dal suo incarico',
        'Organizzò una festa',
      ],
      correctIndex: 0,
      explanation: 'Il suo dolore lo spinge ad agire (Neemia 1).',
    ),
    QuizQuestion(
      text: 'Che cosa chiese Neemia al re Artaserse?',
      options: <String>[
        'Il permesso di andare a ricostruire le mura',
        'Oro per sé stesso',
        'Una posizione più elevata a corte',
        'La libertà di lasciare il servizio del re',
      ],
      correctIndex: 0,
      explanation: 'Il re acconsente e gli fornisce delle risorse (Neemia 2).',
    ),
    QuizQuestion(
      text: 'Come reagirono i costruttori di fronte a scherni e minacce?',
      options: <String>[
        'Lavorarono con una mano occupata e l’altra che impugnava un’arma',
        'Interruppero il cantiere',
        'Fuggirono dalla città',
        'Negoziarono con gli oppositori',
      ],
      correctIndex: 0,
      explanation:
          'Vigilanza e determinazione caratterizzano il cantiere (Neemia 4).',
    ),
  ],
  'Nehemiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale ingiustizia sociale denunciò Neemia tra il popolo?',
      options: <String>[
        'Prestiti abusivi che impoverivano i poveri',
        'Il rifiuto di pagare la decima',
        'La sola inosservanza del sabato',
        'La corruzione dei giudici',
      ],
      correctIndex: 0,
      explanation: 'Neemia corregge questa pratica ingiusta (Neemia 5).',
    ),
    QuizQuestion(
      text: 'In quanto tempo fu completata la muraglia di Gerusalemme?',
      options: <String>['52 giorni', 'Un anno', 'Dieci anni', 'Una settimana'],
      correctIndex: 0,
      explanation: 'Un’impresa nonostante una forte opposizione (Neemia 6).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['cinquantadue giorni', '52'],
    ),
    QuizQuestion(
      text:
          'Che cosa accadde quando Esdra lesse la Legge pubblicamente al popolo?',
      options: <String>[
        'Il popolo prima pianse, poi festeggiò con gioia',
        'Il popolo si ribellò',
        'Nessuno ascoltò',
        'La lettura fu interrotta',
      ],
      correctIndex: 0,
      explanation:
          'La festa delle Capanne segue questa commovente lettura (Neemia 8).',
    ),
  ],
  'Nehemiah#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa fece il popolo dopo la lettura della Legge e la confessione nazionale?',
      options: <String>[
        'Firmò un impegno scritto a ubbidire a Dio',
        'Lasciò Gerusalemme',
        'Abolì le feste',
        'Mandò in esilio i sacerdoti',
      ],
      correctIndex: 0,
      explanation: 'Un patto scritto suggella questo impegno (Neemia 9-10).',
    ),
    QuizQuestion(
      text: 'Come fu celebrata la dedicazione della muraglia?',
      options: <String>[
        'Con processioni di canto e di ringraziamento',
        'Con un digiuno silenzioso',
        'Con una cerimonia militare',
        'Con la chiusura delle porte',
      ],
      correctIndex: 0,
      explanation: 'Due cori percorrono la muraglia cantando (Neemia 12).',
    ),
    QuizQuestion(
      text: 'Quale riforma impose Neemia al suo ritorno da un secondo mandato?',
      options: <String>[
        'Il rispetto rigoroso del sabato e l’espulsione di Tobia',
        'L’abolizione del tempio',
        'Un nuovo censimento',
        'La costruzione di un palazzo',
      ],
      correctIndex: 0,
      explanation:
          'Neemia corregge diversi abusi tornati in sua assenza (Neemia 13).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesItC2 =
    <String, List<QuizQuestion>>{};
