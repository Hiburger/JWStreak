import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesItC3 = <String, List<QuizQuestion>>{
  'Esther#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Perché la regina Vasti fu destituita?',
      options: <String>[
        'Rifiutò di presentarsi davanti al re e ai suoi ospiti',
        'Complottò contro il re',
        'Si ammalò',
        'Lasciò il palazzo',
      ],
      correctIndex: 0,
      explanation:
          'Il suo rifiuto provoca la sua caduta in disgrazia (Ester 1).',
    ),
    QuizQuestion(
      text: 'Chi allevò Mardocheo, e chi divenne poi regina?',
      options: <String>[
        'Ester, sua cugina',
        'Sua figlia',
        'Sua sorella',
        'Una schiava straniera',
      ],
      correctIndex: 0,
      explanation: 'Ester viene scelta come nuova regina (Ester 2).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Ester'],
    ),
    QuizQuestion(
      text: 'Perché Aman voleva sterminare tutti gli ebrei dell’impero?',
      options: <String>[
        'Mardocheo si rifiutava di inchinarsi davanti a lui',
        'Gli ebrei avevano un debito nei suoi confronti',
        'Il re glielo aveva ordinato',
        'Era appena scoppiata una guerra',
      ],
      correctIndex: 0,
      explanation:
          'La collera di Aman si trasforma in un complotto di sterminio '
          '(Ester 3).',
    ),
  ],
  'Esther#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale frase famosa Mardocheo rivolge a Ester per convincerla '
          'ad agire?',
      options: <String>[
        '«Chi lo sa se non sei giunta al regno proprio per un tempo come '
            'questo...»',
        '«Fuggi finché sei in tempo»',
        '«Non è un problema nostro»',
        '«Il re non ti ascolterà mai»',
      ],
      correctIndex: 0,
      explanation: 'Questo appello spinge Ester a intervenire (Ester 4).',
    ),
    QuizQuestion(
      text: 'Che cosa accadde quando il re non riusciva a prendere sonno?',
      options: <String>[
        'Scoprì che Mardocheo non era mai stato ricompensato',
        'Convocò immediatamente Ester',
        'Fece giustiziare subito Aman',
        'Annullò il suo decreto',
      ],
      correctIndex: 0,
      explanation:
          'Questo dettaglio provvidenziale ribalta la situazione (Ester 6).',
    ),
    QuizQuestion(
      text: 'Come Ester svelò il complotto di Aman?',
      options: <String>[
        'Durante un secondo banchetto, davanti al re',
        'Con una lettera anonima',
        'In pubblico davanti a tutto il popolo',
        'Tramite un servitore',
      ],
      correctIndex: 0,
      explanation: 'Aman viene smascherato e giustiziato (Ester 7).',
    ),
  ],
  'Esther#2': <QuizQuestion>[
    QuizQuestion(
      text: 'In che modo il nuovo decreto contrastò quello di Aman?',
      options: <String>[
        'Autorizzava gli ebrei a difendersi',
        'Annullava completamente il primo decreto',
        'Esiliava tutti i persiani',
        'Non cambiava nulla',
      ],
      correctIndex: 0,
      explanation:
          'Un decreto irrevocabile doveva essere contrastato da un altro '
          'decreto (Ester 8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['fuggire', 'tacere', 'pagare'],
    ),
    QuizQuestion(
      text: 'Quale festa fu istituita per commemorare questa liberazione?',
      options: <String>['Purim', 'La Pasqua', 'Le Capanne', 'Il Giubileo'],
      correctIndex: 0,
      explanation: 'Purim celebra ancora oggi questo evento (Ester 9).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Quale posizione ricoprì infine Mardocheo?',
      options: <String>[
        'Una posizione elevata, seconda solo al re',
        'Fu mandato in esilio',
        'Rimase un semplice funzionario',
        'Lasciò la Persia',
      ],
      correctIndex: 0,
      explanation:
          'Mardocheo si adopera per il bene del suo popolo (Ester 10).',
    ),
  ],
  'Job#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale sfida Satana lancia a Dio riguardo a Giobbe?',
      options: <String>[
        'Giobbe servirebbe Dio solo per interesse personale',
        'Giobbe non esiste realmente',
        'Giobbe è già infedele',
        'Giobbe vuole abbandonare la sua famiglia',
      ],
      correctIndex: 0,
      explanation:
          'Satana mette in dubbio le motivazioni di Giobbe (Giobbe 1).',
    ),
    QuizQuestion(
      text: 'Come reagì Giobbe dopo aver perso tutto?',
      options: <String>[
        'Non peccò né accusò Dio di alcun male',
        'Maledisse Dio',
        'Si vendicò',
        'Abbandonò la sua fede',
      ],
      correctIndex: 0,
      explanation:
          'La sua integrità resta intatta nonostante la prova (Giobbe 1).',
    ),
    QuizQuestion(
      text: 'Che cosa consiglia la moglie di Giobbe dopo la sua malattia?',
      options: <String>[
        'Di maledire Dio e morire',
        'Di consultare un medico',
        'Di fuggire lontano da casa',
        'Di pazientare in silenzio',
      ],
      correctIndex: 0,
      explanation: 'Giobbe rifiuta questo consiglio disperato (Giobbe 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['benedire', 'pregare', 'vivere'],
    ),
  ],
  'Job#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale argomento principale espone Bildad nel suo primo '
          'discorso?',
      options: <String>[
        'La saggezza degli antenati dimostra che Dio è giusto',
        'Dio non esiste',
        'Giobbe è innocente',
        'La sofferenza non ha alcuna causa',
      ],
      correctIndex: 0,
      explanation: 'Bildad si appoggia sulla tradizione (Giobbe 8).',
    ),
    QuizQuestion(
      text:
          'Che cosa desidera profondamente Giobbe nella sua risposta a '
          'Bildad?',
      options: <String>[
        'Un mediatore tra lui e Dio',
        'Denaro per i suoi debiti',
        'Vendetta contro i suoi amici',
        'Un nuovo gregge immediatamente',
      ],
      correctIndex: 0,
      explanation:
          'Giobbe aspira a perorare la propria causa in modo equo (Giobbe 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['amico', 'giudice', 'testimone'],
    ),
    QuizQuestion(
      text: 'Che cosa consiglia Zofar a Giobbe nel suo primo discorso?',
      options: <String>[
        'Di pentirsi di un peccato nascosto',
        'Di lasciare la sua famiglia',
        'Di consultare un altro saggio',
        'Di restare in silenzio per sempre',
      ],
      correctIndex: 0,
      explanation: 'Zofar suppone che Giobbe nasconda una colpa (Giobbe 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sacrificio', 'digiuno', 'silenzio'],
    ),
  ],
  'Job#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale celebre affermazione pronuncia Giobbe nonostante la sua '
          'sofferenza?',
      options: <String>[
        '«So che il mio redentore è vivente»',
        '«Dio mi ha abbandonato per sempre»',
        '«La vita non ha alcun senso»',
        '«Preferirei morire subito»',
      ],
      correctIndex: 0,
      explanation: 'Questa dichiarazione di speranza segna Giobbe 19.',
    ),
    QuizQuestion(
      text:
          'Quale constatazione fa Giobbe riguardo alla sorte dei '
          'malvagi?',
      options: <String>[
        'Sembrano spesso prosperare nonostante la loro condotta',
        'Vengono sempre puniti immediatamente',
        'In realtà non esistono',
        'Finiscono sempre in povertà',
      ],
      correctIndex: 0,
      explanation:
          'Giobbe mette in discussione la teoria semplicistica dei suoi '
          'amici (Giobbe 21).',
    ),
    QuizQuestion(
      text:
          'Come descrive Giobbe il trattamento ricevuto dai suoi amici '
          'in questi capitoli?',
      options: <String>[
        'Si sente abbandonato e incompreso da loro',
        'Li ringrazia calorosamente',
        'Approva tutti i loro argomenti',
        'Non li menziona affatto',
      ],
      correctIndex: 0,
      explanation:
          'Giobbe esprime la sua angoscia di fronte alla loro mancanza di '
          'compassione (Giobbe 16-17).',
    ),
  ],
  'Job#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Di che cosa accusa precisamente Elifaz Giobbe nel suo terzo '
          'discorso?',
      options: <String>[
        'Di peccati specifici come l’oppressione dei poveri',
        'Di aver derubato un tempio',
        'Di aver rinnegato la sua famiglia',
        'Di aver mentito al re',
      ],
      correctIndex: 0,
      explanation:
          'Le accuse di Elifaz si fanno più precise, ma senza prove '
          '(Giobbe 22).',
    ),
    QuizQuestion(
      text: 'Che cosa desidera ardentemente Giobbe nella sua risposta?',
      options: <String>[
        'Presentare la propria causa direttamente davanti a Dio',
        'Fuggire lontano dalla sua famiglia',
        'Ottenere ricchezza',
        'Vendicarsi dei suoi amici',
      ],
      correctIndex: 0,
      explanation: 'Giobbe cerca un’udienza equa (Giobbe 23).',
    ),
    QuizQuestion(
      text: 'Quale tema centrale sviluppa Giobbe nel capitolo 28?',
      options: <String>[
        'Il valore incomparabile della sapienza',
        'La ricchezza mineraria',
        'La geografia del deserto',
        'Le leggi del sacrificio',
      ],
      correctIndex: 0,
      explanation:
          'Questo poema celebra la sapienza, più preziosa dell’oro '
          '(Giobbe 28).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ricchezza', 'oro', 'forza'],
    ),
  ],
  'Job#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa ricorda Giobbe evocando i suoi giorni passati?',
      options: <String>[
        'Il rispetto e l’onore che riceveva un tempo',
        'La sua povertà d’origine',
        'Una vita di guerra costante',
        'La sua infanzia all’estero',
      ],
      correctIndex: 0,
      explanation:
          'Giobbe mette a confronto il suo passato onorato con la '
          'situazione attuale (Giobbe 29).',
    ),
    QuizQuestion(
      text:
          'Che cosa dichiara Giobbe nel suo giuramento finale '
          'd’innocenza?',
      options: <String>[
        'Afferma di non aver commesso nessuna delle colpe elencate',
        'Confessa diversi peccati',
        'Rifiuta di rispondere',
        'Accusa Dio direttamente',
      ],
      correctIndex: 0,
      explanation:
          'Giobbe conclude la sua difesa con un ampio giuramento (Giobbe 31).',
    ),
    QuizQuestion(
      text: 'Chi è Eliu, che prende la parola dopo i tre amici?',
      options: <String>[
        'Un uomo più giovane, che aveva atteso per rispetto prima di '
            'parlare',
        'Un angelo mandato da Dio',
        'Un quarto amico anziano',
        'Il figlio di Giobbe',
      ],
      correctIndex: 0,
      explanation:
          'Eliu interviene perché gli anziani non hanno convinto (Giobbe 32).',
    ),
  ],
  'Job#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Da dove parla infine Geova a Giobbe?',
      options: <String>[
        'Dal seno di una tempesta',
        'Da un sogno',
        'Da un angelo visibile',
        'Non rispose mai',
      ],
      correctIndex: 0,
      explanation: 'Dio risponde finalmente, ma con delle domande (Giobbe 38).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['nube', 'fuoco', 'silenzio'],
    ),
    QuizQuestion(
      text:
          'Su che cosa vertono principalmente le domande di Geova a '
          'Giobbe?',
      options: <String>[
        'La creazione e il dominio sul mondo naturale',
        'I peccati nascosti di Giobbe',
        'La politica delle nazioni',
        'I rituali del tempio',
      ],
      correctIndex: 0,
      explanation:
          'Dio mostra l’immensità della sua sapienza creatrice '
          '(Giobbe 38-41).',
    ),
    QuizQuestion(
      text: 'Come si conclude la storia di Giobbe?',
      options: <String>[
        'Giobbe si pente con umiltà e Dio gli restituisce il doppio dei '
            'suoi beni',
        'Giobbe muore in povertà',
        'Giobbe maledice Dio fino alla fine',
        'I suoi amici vengono ricompensati al posto suo',
      ],
      correctIndex: 0,
      explanation: 'Geova benedice Giobbe più di prima (Giobbe 42).',
    ),
  ],
  // I Salmi sono una raccolta di 150 canti/poesie e non un racconto
  // continuo: ogni checkpoint mette in evidenza 2-3 salmi noti del suo
  // intervallo, senza pretesa di copertura esaustiva.
  'Psalms#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'A che cosa paragona il Salmo 1 l’uomo felice che medita '
          'sulla legge di Dio?',
      options: <String>[
        'A un albero piantato vicino a corsi d’acqua',
        'A una pietra solida',
        'A un uccello in volo',
        'A una lampada accesa',
      ],
      correctIndex: 0,
      explanation: 'L’immagine dell’albero rigoglioso apre il libro (Salmo 1).',
    ),
    QuizQuestion(
      text: 'Che cosa celebra il Salmo 19 nella sua prima parte?',
      options: <String>[
        'La gloria di Dio manifestata nei cieli',
        'La vittoria di un re',
        'La costruzione del tempio',
        'Una battaglia vinta',
      ],
      correctIndex: 0,
      explanation: '«I cieli raccontano la gloria di Dio» (Salmo 19:1).',
    ),
    QuizQuestion(
      text:
          'Quale domanda pone il Salmo 8 di fronte all’immensità del '
          'creato?',
      options: <String>[
        'Che cos’è l’uomo perché tu ti ricordi di lui?',
        'Perché il mare è così vasto?',
        'Dove si trova il giardino di Eden?',
        'Quante stelle esistono?',
      ],
      correctIndex: 0,
      explanation:
          'Il salmista si meraviglia del posto riservato all’uomo '
          '(Salmo 8:4).',
    ),
  ],
  'Psalms#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Come descrive il Salmo 23 Geova?',
      options: <String>[
        'Come un pastore che si prende cura delle sue pecore',
        'Come un giudice severo',
        'Come un re lontano',
        'Come un guerriero vendicatore',
      ],
      correctIndex: 0,
      explanation: '«Geova è il mio pastore» (Salmo 23:1).',
    ),
    QuizQuestion(
      text:
          'Quale parola profetica del Salmo 22 fu citata da Gesù sul '
          'palo di tortura?',
      options: <String>[
        '«Dio mio, Dio mio, perché mi hai abbandonato?»',
        '«Sono venuto per giudicare»',
        '«Ecco il mio servitore»',
        '«Il regno si avvicina»',
      ],
      correctIndex: 0,
      explanation:
          'Questa citazione collega il salmo alla passione di Cristo '
          '(Salmo 22:1).',
    ),
    QuizQuestion(
      text: 'Che cosa dichiara il Salmo 34 riguardo alla bontà di Geova?',
      options: <String>[
        'Gustate e vedete quanto è buono Geova',
        'La sua bontà resta nascosta',
        'Riguarda solo i sacerdoti',
        'È limitata a Israele',
      ],
      correctIndex: 0,
      explanation:
          'Un invito a sperimentare personalmente la bontà divina '
          '(Salmo 34:8).',
    ),
  ],
  'Psalms#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale toccante preghiera compose Davide dopo il suo peccato '
          'con Bat-Sceba?',
      options: <String>[
        'Il Salmo 51, in cui chiede un cuore puro',
        'Un canto di vittoria militare',
        'Una profezia su Babilonia',
        'Un canto di incoronazione',
      ],
      correctIndex: 0,
      explanation: '«Crea in me un cuore puro, o Dio» (Salmo 51:10).',
    ),
    QuizQuestion(
      text:
          'A che cosa paragona il salmista il suo ardente desiderio di '
          'Dio nel Salmo 42?',
      options: <String>[
        'A una cerva che anela ai corsi d’acqua',
        'A un leone affamato',
        'A un uccello in gabbia',
        'A un mercante frettoloso',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine di intensa sete spirituale (Salmo 42:1).',
    ),
    QuizQuestion(
      text: 'Quale affermazione centrale fa il Salmo 46?',
      options: <String>[
        'Dio è il nostro rifugio e la nostra forza',
        'Le nazioni vivranno sempre in pace',
        'Il tempio non sarà mai distrutto',
        'Il re è la nostra unica speranza',
      ],
      correctIndex: 0,
      explanation: '«Dio è per noi un rifugio e una forza» (Salmo 46:1).',
    ),
  ],
  'Psalms#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Per chi è il Salmo 72 una preghiera di benedizione riguardo '
          'a un regno giusto e prospero?',
      options: <String>[
        'Per il re (Salomone, e in senso profetico il Messia)',
        'Solo per i sacerdoti',
        'Per le nazioni nemiche',
        'Per i profeti',
      ],
      correctIndex: 0,
      explanation:
          'Questo salmo messianico descrive un regno di pace duratura '
          '(Salmo 72).',
    ),
    QuizQuestion(
      text: 'Quale dilemma turba Asaf nel Salmo 73?',
      options: <String>[
        'L’apparente prosperità dei malvagi',
        'La povertà del tempio',
        'L’assenza di pioggia',
        'Il silenzio dei profeti',
      ],
      correctIndex: 0,
      explanation:
          'Asaf risolve questo turbamento entrando nel santuario di Dio '
          '(Salmo 73:17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['giusti', 'ricchezza', 'tempio'],
    ),
    QuizQuestion(
      text:
          'Quale immagine descrive la potente marcia di Dio nel '
          'Salmo 68?',
      options: <String>[
        'Egli avanza attraverso il deserto per il suo popolo',
        'Rimane sempre nascosto',
        'Naviga solo sui mari',
        'Combatte da solo senza mai intervenire',
      ],
      correctIndex: 0,
      explanation:
          'Un linguaggio poetico che esalta la potenza divina (Salmo 68).',
    ),
  ],
  'Psalms#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa chiede Mosè a Dio nel Salmo 90 riguardo alla '
          'brevità della vita?',
      options: <String>[
        'Di insegnarci a contare sapientemente i nostri giorni',
        'Di prolungare indefinitamente la vita umana',
        'Di cancellare il ricordo della morte',
        'Di accelerare il tempo',
      ],
      correctIndex: 0,
      explanation: '«Insegnaci a contare bene i nostri giorni» (Salmo 90:12).',
    ),
    QuizQuestion(
      text: 'Quale promessa di protezione offre il Salmo 91?',
      options: <String>[
        'Chi dimora al riparo dell’Altissimo è protetto',
        'Non viene fatta alcuna promessa',
        'Solo i re sono protetti',
        'La protezione dipende dai sacrifici',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine di rifugio sotto le ali divine (Salmo 91).',
    ),
    QuizQuestion(
      text: 'Che cosa dice il Salmo 84 riguardo alla dimora di Dio?',
      options: <String>[
        'Che è infinitamente desiderabile e amata',
        'Che è minacciosa',
        'Che sarà presto distrutta',
        'Che è riservata ai re',
      ],
      correctIndex: 0,
      explanation: '«Quanto sono amabili le tue dimore!» (Salmo 84:1).',
    ),
  ],
  'Psalms#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale invito apre il Salmo 100?',
      options: <String>[
        'Innalzate grida di gioia ed entrate con gratitudine',
        'Rimanete in assoluto silenzio',
        'Fuggite lontano dal tempio',
        'Piangete per i vostri peccati',
      ],
      correctIndex: 0,
      explanation: 'Un gioioso appello alla lode collettiva (Salmo 100).',
    ),
    QuizQuestion(
      text: 'Che cosa ricorda il Salmo 103 riguardo al perdono di Dio?',
      options: <String>[
        'Perdona tutte le nostre colpe, come un padre ha compassione',
        'Non perdona mai',
        'Il perdono dipende dal sacrificio quotidiano',
        'Solo i sacerdoti vengono perdonati',
      ],
      correctIndex: 0,
      explanation: 'Una tenera immagine di compassione paterna (Salmo 103:13).',
    ),
    QuizQuestion(
      text:
          'Quale parola del Salmo 110 viene applicata al Cristo nelle '
          'Scritture Greche?',
      options: <String>[
        '«Siedi alla mia destra»',
        '«Sarai re di Babilonia»',
        '«Ritorna in Egitto»',
        '«Costruisci il mio tempio»',
      ],
      correctIndex: 0,
      explanation: 'Gesù stesso cita questo versetto (Salmo 110:1).',
    ),
  ],
  'Psalms#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Qual è il tema principale del Salmo 119, il capitolo più '
          'lungo della Bibbia?',
      options: <String>[
        'L’amore per la legge e la parola di Dio',
        'Una battaglia storica',
        'La costruzione del tempio',
        'Un viaggio in Egitto',
      ],
      correctIndex: 0,
      explanation: 'Ogni sezione medita sulla legge divina (Salmo 119).',
    ),
    QuizQuestion(
      text:
          'Da dove dice il salmista che viene il suo aiuto nel '
          'Salmo 121?',
      options: <String>[
        'Da Geova, creatore dei cieli e della terra',
        'Dalle montagne stesse',
        'Dall’esercito del re',
        'Dai sacerdoti del tempio',
      ],
      correctIndex: 0,
      explanation:
          '«Alzo gli occhi ai monti... il mio aiuto viene da Geova» '
          '(Salmo 121).',
    ),
    QuizQuestion(
      text: 'Che cosa ricorda il Salmo 127 riguardo ai progetti umani?',
      options: <String>[
        'Senza Geova, i costruttori lavorano invano',
        'Il successo dipende solo dallo sforzo',
        'Solo la fortuna decide',
        'I figli non sono una benedizione',
      ],
      correctIndex: 0,
      explanation: '«Se Geova non costruisce la casa...» (Salmo 127:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['casa', 'città', 'vigilanti'],
    ),
  ],
  'Psalms#7': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale scena straziante apre il Salmo 137?',
      options: <String>[
        'Gli esiliati che piangono sulle rive dei fiumi di Babilonia',
        'Una festa di incoronazione',
        'Una battaglia vittoriosa',
        'La costruzione del tempio',
      ],
      correctIndex: 0,
      explanation:
          '«Presso i fiumi di Babilonia, sedevamo e piangevamo» '
          '(Salmo 137:1).',
    ),
    QuizQuestion(
      text: 'Come descrive il Salmo 145 Geova?',
      options: <String>[
        'Grande e degno di lode senza limiti',
        'Distante e indifferente',
        'Solo severo',
        'Silenzioso verso il suo popolo',
      ],
      correctIndex: 0,
      explanation: 'Un salmo di generosa lode (Salmo 145:3).',
    ),
    QuizQuestion(
      text: 'Quale appello conclude l’ultimissimo salmo, il Salmo 150?',
      options: <String>[
        'Che tutto ciò che respira lodi Iah',
        'Che tutto taccia per sempre',
        'Che solo i re lodino Dio',
        'Che la musica sia proibita',
      ],
      correctIndex: 0,
      explanation:
          'Il libro si conclude con un appello universale alla lode '
          '(Salmo 150:6).',
    ),
  ],
  'Proverbs#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Secondo Proverbi 1, qual è il principio della conoscenza?',
      options: <String>[
        'Il timore di Geova',
        'La ricchezza',
        'La sola esperienza',
        'L’istruzione formale',
      ],
      correctIndex: 0,
      explanation:
          'Questo principio fondamentale apre il libro (Proverbi 1:7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sapienza', 'ricchezza', 'stoltezza'],
    ),
    QuizQuestion(
      text: 'Che cosa consiglia Proverbi 3 riguardo alla fiducia?',
      options: <String>[
        'Confidare in Geova con tutto il cuore',
        'Contare solo sulla propria intelligenza',
        'Evitare ogni decisione importante',
        'Seguire il parere della maggioranza',
      ],
      correctIndex: 0,
      explanation: '«Confida in Geova con tutto il tuo cuore» (Proverbi 3:5).',
    ),
    QuizQuestion(
      text: 'Come viene personificata la sapienza in Proverbi 8?',
      options: <String>[
        'Come una voce che chiama pubblicamente gli uomini',
        'Come un tesoro citato ma invisibile',
        'Come un re silenzioso',
        'Come un libro chiuso',
      ],
      correctIndex: 0,
      explanation: 'La sapienza grida nelle piazze pubbliche (Proverbi 8).',
    ),
  ],
  'Proverbs#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa dice Proverbi 15 sul modo di rispondere alla '
          'collera?',
      options: <String>[
        'Una risposta gentile allontana il furore',
        'Bisogna sempre rispondere con forza',
        'Il silenzio è sempre preferibile',
        'La collera va sempre ignorata',
      ],
      correctIndex: 0,
      explanation: '«Una risposta gentile calma il furore» (Proverbi 15:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['parola', 'collera', 'silenzio'],
    ),
    QuizQuestion(
      text:
          'Che cosa dice Proverbi 16 riguardo ai nostri progetti e a '
          'Geova?',
      options: <String>[
        'Affida a Geova le tue opere e i tuoi progetti riusciranno',
        'I progetti umani dipendono solo da noi',
        'Geova ignora le nostre decisioni quotidiane',
        'È meglio non pianificare nulla',
      ],
      correctIndex: 0,
      explanation: '«Affida a Geova le tue opere» (Proverbi 16:3).',
    ),
    QuizQuestion(
      text:
          'Che cosa rappresenta la donna saggia che costruisce la '
          'propria casa in Proverbi 14?',
      options: <String>[
        'La sapienza pratica che costruisce e preserva',
        'Una regina straniera',
        'Una semplice operaia',
        'Un personaggio minore senza rilevanza',
      ],
      correctIndex: 0,
      explanation:
          'L’immagine illustra l’effetto costruttivo della sapienza '
          '(Proverbi 14:1).',
    ),
  ],
  'Proverbs#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa dice Proverbi 18 sul potere della lingua?',
      options: <String>[
        'La morte e la vita sono in potere della lingua',
        'Non ha alcuna influenza reale',
        'Riguarda solo i governanti',
        'È sempre innocua',
      ],
      correctIndex: 0,
      explanation:
          'Un’immagine potente sull’impatto delle parole (Proverbi 18:21).',
    ),
    QuizQuestion(
      text:
          'Che cosa dice Proverbi 19 riguardo alla bontà verso i '
          'poveri?',
      options: <String>[
        'È come prestare a Geova stesso',
        'È una perdita di tempo',
        'Riguarda solo i ricchi',
        'Indebolisce la società',
      ],
      correctIndex: 0,
      explanation:
          '«Chi ha pietà del povero fa un prestito a Geova» '
          '(Proverbi 19:17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ricchezza', 'elemosina', 'debito'],
    ),
    QuizQuestion(
      text:
          'Secondo Proverbi 22, che cosa vale più di una grande '
          'ricchezza?',
      options: <String>[
        'Una buona reputazione',
        'Un grande palazzo',
        'Un esercito potente',
        'Un vasto territorio',
      ],
      correctIndex: 0,
      explanation:
          '«Una buona reputazione vale più di grandi ricchezze» '
          '(Proverbi 22:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ricchezza', 'argento', 'oro'],
    ),
  ],
  'Proverbs#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa dice Proverbi 27 sull’effetto di un amico su un '
          'altro?',
      options: <String>[
        'Il ferro aguzza il ferro, un uomo ne stimola un altro',
        'Gli amici non hanno alcuna influenza',
        'È meglio restare soli',
        'Gli amici indeboliscono il carattere',
      ],
      correctIndex: 0,
      explanation:
          'Un’immagine di positiva influenza reciproca (Proverbi 27:17).',
    ),
    QuizQuestion(
      text:
          'Che cosa dice Proverbi 29 riguardo alla mancanza di guida '
          'spirituale?',
      options: <String>[
        'Senza visione, il popolo non ha freno',
        'Il popolo prospera sempre da solo',
        'Le visioni non hanno importanza',
        'Il popolo preferisce l’assenza di regole',
      ],
      correctIndex: 0,
      explanation: 'Un avvertimento sulla mancanza di guida (Proverbi 29:18).',
    ),
    QuizQuestion(
      text: 'Che cosa celebra il poema finale di Proverbi 31?',
      options: <String>[
        'La donna capace e virtuosa',
        'La ricchezza di un re',
        'Una vittoria militare',
        'La costruzione di un palazzo',
      ],
      correctIndex: 0,
      explanation: 'Un acrostico loda la donna valorosa (Proverbi 31).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sapienza', 'marito', 'casa'],
    ),
  ],
  'Ecclesiastes#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale osservazione ricorrente apre il libro '
          'dell’Ecclesiaste?',
      options: <String>[
        'Tutto è vanità (vapore, futilità) sotto il sole',
        'Tutto è perfettamente stabile',
        'La ricchezza risolve ogni cosa',
        'Niente cambia mai',
      ],
      correctIndex: 0,
      explanation: 'Questo tema struttura l’intero libro (Ecclesiaste 1:2).',
    ),
    QuizQuestion(
      text:
          'Che cosa scoprì Salomone dopo aver cercato piacere, lavoro '
          'e sapienza?',
      options: <String>[
        'Tutto questo, senza Dio, resta vano',
        'Il solo piacere basta per la felicità',
        'Il lavoro garantisce sempre soddisfazione',
        'La sapienza umana risolve tutto',
      ],
      correctIndex: 0,
      explanation:
          'La sua esperienza personale illustra la futilità di ogni '
          'cosa senza Dio (Ecclesiaste 2).',
    ),
    QuizQuestion(
      text:
          'Che cosa ricorda il celebre passo su «un tempo per ogni '
          'cosa»?',
      options: <String>[
        'C’è una stagione appropriata per ogni cosa',
        'Il tempo non ha alcuna importanza',
        'Tutto deve essere fatto immediatamente',
        'Il passato non conta',
      ],
      correctIndex: 0,
      explanation: 'Questo poema ritmato apre Ecclesiaste 3.',
    ),
  ],
  'Ecclesiastes#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa consiglia Ecclesiaste 5 riguardo ai voti fatti a '
          'Dio?',
      options: <String>[
        'È meglio non fare un voto che farlo e non adempierlo',
        'Bisogna moltiplicare i voti',
        'I voti non hanno alcun valore',
        'Solo i sacerdoti possono fare voti',
      ],
      correctIndex: 0,
      explanation:
          'Viene sottolineata la prudenza nel parlare a Dio '
          '(Ecclesiaste 5:4, 5).',
    ),
    QuizQuestion(
      text: 'Che cosa dice Ecclesiaste 7 riguardo alla reputazione?',
      options: <String>[
        'Un buon nome vale più dell’olio profumato',
        'La reputazione non ha alcun valore',
        'Conta solo la ricchezza',
        'Il nome non sopravvive mai',
      ],
      correctIndex: 0,
      explanation: 'Un giudizio di valore sull’integrità (Ecclesiaste 7:1).',
    ),
    QuizQuestion(
      text:
          'Che cosa raccomanda Ecclesiaste 8 riguardo all’autorità '
          'costituita?',
      options: <String>[
        'Obbedire saggiamente, senza affrettarsi a contestare',
        'Sfidare sempre i governanti',
        'Ignorare completamente la legge',
        'Sottrarsi a ogni responsabilità civile',
      ],
      correctIndex: 0,
      explanation: 'Viene consigliata una prudenza pratica (Ecclesiaste 8).',
    ),
  ],
  'Ecclesiastes#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa ricorda Ecclesiaste 9 riguardo alle nostre attività '
          'quotidiane?',
      options: <String>[
        'Fai il tuo lavoro con tutte le tue forze, finché vivi',
        'Il lavoro non ha alcun valore',
        'È meglio restare inattivi',
        'Solo i ricchi devono lavorare',
      ],
      correctIndex: 0,
      explanation:
          'Un invito a impegnarsi pienamente nella vita (Ecclesiaste 9:10).',
    ),
    QuizQuestion(
      text: 'Che cosa consiglia Ecclesiaste 11 riguardo alla generosità?',
      options: <String>[
        'Getta il tuo pane sulle acque, esso ritornerà',
        'Tieni tutte le tue risorse solo per te',
        'La generosità è sempre inutile',
        'Bisogna attendere la certezza prima di agire',
      ],
      correctIndex: 0,
      explanation:
          'Un’immagine di investimento generoso e fiducioso '
          '(Ecclesiaste 11:1).',
    ),
    QuizQuestion(
      text: 'Qual è la conclusione finale del libro dell’Ecclesiaste?',
      options: <String>[
        'Temi Dio e osserva i suoi comandamenti',
        'Cerca soltanto il piacere',
        'Nulla ha davvero un senso',
        'La ricchezza è lo scopo ultimo',
      ],
      correctIndex: 0,
      explanation:
          'Questa conclusione riassume l’intero libro (Ecclesiaste 12:13).',
    ),
  ],
  'Song of Solomon#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale sentimento domina l’apertura del Cantico dei Cantici?',
      options: <String>[
        'Un amore ardente tra la Sulammita e il suo amato',
        'Un conflitto familiare',
        'Una trattativa commerciale',
        'Un giudizio regale',
      ],
      correctIndex: 0,
      explanation: 'Il libro celebra l’amore fedele ed esclusivo (Cantico 1).',
    ),
    QuizQuestion(
      text: 'Che cosa fa la Sulammita nel suo sogno al capitolo 3?',
      options: <String>[
        'Cerca il suo amato per la città',
        'Fugge verso un paese lontano',
        'Si sposa con un altro uomo',
        'Dimentica completamente il suo amore',
      ],
      correctIndex: 0,
      explanation:
          'Il suo attaccamento resta fedele anche nel sogno (Cantico 3).',
    ),
    QuizQuestion(
      text: 'Come esprime la Sulammita il suo attaccamento esclusivo?',
      options: <String>[
        '«Il mio amato è mio, e io sono sua»',
        '«Preferisco la ricchezza all’amore»',
        '«L’amore non ha importanza per me»',
        '«Resterò sola per sempre»',
      ],
      correctIndex: 0,
      explanation: 'Questa formula ritorna come un ritornello (Cantico 2:16).',
    ),
  ],
  'Song of Solomon#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Come descrive l’amato la bellezza della Sulammita al '
          'capitolo 4?',
      options: <String>[
        'Con una serie di immagini poetiche elogiative',
        'In modo freddo e distante',
        'Paragonandola a una nemica',
        'Non la descrive affatto',
      ],
      correctIndex: 0,
      explanation:
          'Un poema di elogio dettagliato le viene dedicato (Cantico 4).',
    ),
    QuizQuestion(
      text:
          'Che cosa succede quando l’amato viene a bussare alla sua '
          'porta nel capitolo 5?',
      options: <String>[
        'Lei tarda ad aprire ed egli se n’è già andato',
        'Apre subito con gioia',
        'Si rifiuta di vederlo',
        'Egli non è mai venuto',
      ],
      correctIndex: 0,
      explanation:
          'Questo momento mancato genera un rimpianto struggente '
          '(Cantico 5).',
    ),
    QuizQuestion(
      text:
          'A chi descrive la Sulammita il suo amato dopo questo '
          'episodio?',
      options: <String>[
        'Alle figlie di Gerusalemme',
        'Solo a sua madre',
        'Al re Salomone',
        'A nessuno, resta in silenzio',
      ],
      correctIndex: 0,
      explanation: 'Segue la sua entusiastica descrizione (Cantico 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sulammita', 'amato', 'vigna'],
    ),
  ],
  'Song of Solomon#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale celebre affermazione sull’amore si trova nel '
          'capitolo 8?',
      options: <String>[
        'L’amore è forte come la morte',
        'L’amore si compra con il denaro',
        'L’amore non ha importanza',
        'L’amore non dura mai',
      ],
      correctIndex: 0,
      explanation:
          '«Le grandi acque non possono spegnere l’amore» '
          '(Cantico 8:6, 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['acque', 'fuoco', 'vento'],
    ),
    QuizQuestion(
      text:
          'Che cosa simboleggiano le «grandi acque» incapaci di '
          'spegnere l’amore?',
      options: <String>[
        'Le prove che non possono distruggere un amore autentico',
        'Un’inondazione letterale',
        'La ricchezza del regno',
        'Il potere del re',
      ],
      correctIndex: 0,
      explanation:
          'Una potente metafora sulla resilienza dell’amore (Cantico 8).',
    ),
    QuizQuestion(
      text: 'Quale tono domina la fine del Cantico dei Cantici?',
      options: <String>[
        'La celebrazione di un amore fedele e condiviso',
        'Una rottura definitiva',
        'Un giudizio severo',
        'Un avvertimento di guerra',
      ],
      correctIndex: 0,
      explanation:
          'Il libro si conclude con una nota di amore compiuto (Cantico 8).',
    ),
  ],
  'Isaiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa promette Isaia 2 per il futuro riguardo alla '
          'guerra?',
      options: <String>[
        'Le nazioni forgeranno le loro spade in vomeri',
        'Le guerre saranno più frequenti',
        'Un solo impero dominerà per sempre',
        'Non viene predetto alcun cambiamento',
      ],
      correctIndex: 0,
      explanation: 'Una visione di pace universale (Isaia 2:4).',
    ),
    QuizQuestion(
      text:
          'Che cosa vede Isaia nella sua visione di incarico '
          'profetico?',
      options: <String>[
        'Geova su un trono elevato, circondato da serafini',
        'Una battaglia celeste',
        'Un deserto silenzioso',
        'Solo una città in rovina',
      ],
      correctIndex: 0,
      explanation:
          'Un carbone tocca le sue labbra, purificando la sua bocca '
          '(Isaia 6).',
    ),
    QuizQuestion(
      text: 'Quale segno annuncia Isaia al re Acaz nel capitolo 7?',
      options: <String>[
        'Una giovane donna concepirà un figlio, Emmanuele',
        'Una vittoria militare immediata',
        'La distruzione totale di Giuda',
        'Una carestia prolungata',
      ],
      correctIndex: 0,
      explanation: '«Emmanuele» significa «Dio con noi» (Isaia 7:14).',
    ),
  ],
  'Isaiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale celebre profezia messianica si trova in Isaia 9?',
      options: <String>[
        'Un bambino è nato, il governo sulla sua spalla',
        'Un re straniero dominerà per sempre',
        'Il tempio sarà ricostruito immediatamente',
        'La pace non arriverà mai',
      ],
      correctIndex: 0,
      explanation: 'Questo passo annuncia un regno di pace (Isaia 9:6, 7).',
    ),
    QuizQuestion(
      text:
          'Quale immagine pacifica illustra Isaia 11 riguardo al regno '
          'futuro?',
      options: <String>[
        'Il lupo dimorerà con l’agnello',
        'I leoni domineranno gli uomini',
        'I deserti resteranno sterili',
        'Le nazioni resteranno divise',
      ],
      correctIndex: 0,
      explanation: 'Viene promessa un’armonia totale (Isaia 11:6).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['leone', 'pastore', 'deserto'],
    ),
    QuizQuestion(
      text:
          'Come descrive Isaia 14 la caduta superba del re di '
          'Babilonia?',
      options: <String>[
        'Come una stella splendente caduta dal cielo',
        'Come un re eternamente trionfante',
        'Come un fedele alleato di Israele',
        'Come un semplice mercante',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine impressionante di decadenza (Isaia 14:12).',
    ),
  ],
  'Isaiah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale gesto simbolico compie Isaia contro l’Egitto e Cus?',
      options: <String>[
        'Camminare scalzo e senza abito esterno',
        'Bruciare le proprie vesti',
        'Digiunare per un anno',
        'Costruire un altare',
      ],
      correctIndex: 0,
      explanation:
          'Questo segno illustra la vergogna della cattività che verrà '
          '(Isaia 20).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sandali', 'deserto', 'catene'],
    ),
    QuizQuestion(
      text: 'Quale giudizio universale annuncia Isaia 24?',
      options: <String>[
        'La terra intera sarà sconvolta e devastata',
        'Solo una nazione sarà giudicata',
        'Non ci sarà alcun giudizio',
        'Il giudizio riguarderà solo i re',
      ],
      correctIndex: 0,
      explanation: 'Viene descritta una portata mondiale (Isaia 24).',
    ),
    QuizQuestion(
      text: 'Che cosa promette Isaia 25 riguardo alla morte?',
      options: <String>[
        'Geova inghiottirà la morte per sempre',
        'La morte resterà invincibile',
        'Solo i ricchi ne saranno risparmiati',
        'Non viene detto nulla sulla morte',
      ],
      correctIndex: 0,
      explanation: 'Viene espressa una straordinaria speranza (Isaia 25:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['vita', 'tomba', 'lacrime'],
    ),
  ],
  'Isaiah#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa promette Isaia 26 a chi appoggia il proprio spirito '
          'su Dio?',
      options: <String>[
        'Una pace continua',
        'Una ricchezza immediata',
        'Un esercito invincibile',
        'Una longevità garantita',
      ],
      correctIndex: 0,
      explanation: '«Tu conserverai in perfetta pace» (Isaia 26:3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['guerra', 'gioia', 'forza'],
    ),
    QuizQuestion(
      text: 'Quale pietra preziosa pone Geova in Sion secondo Isaia 28?',
      options: <String>[
        'Una pietra angolare, un fondamento collaudato',
        'Un semplice sasso',
        'Una pietra maledetta',
        'Non viene menzionata alcuna pietra',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine messianica di fondamento sicuro (Isaia 28:16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sion', 'tempio', 'muro'],
    ),
    QuizQuestion(
      text:
          'Contro chi mette in guardia Isaia il popolo riguardo a '
          'un’alleanza militare?',
      options: <String>[
        'Contro il confidare nell’Egitto piuttosto che in Geova',
        'Contro un’alleanza solo con Babilonia',
        'Contro ogni commercio estero',
        'Contro i sacerdoti locali',
      ],
      correctIndex: 0,
      explanation: 'Il cercare aiuto in Egitto viene criticato (Isaia 30-31).',
    ),
  ],
  'Isaiah#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa diventerà il deserto secondo la promessa di '
          'Isaia 35?',
      options: <String>[
        'Fiorirà come lo zafferano',
        'Resterà sterile per sempre',
        'Diventerà un mare',
        'Sarà abbandonato definitivamente',
      ],
      correctIndex: 0,
      explanation: 'Viene promessa una gioiosa trasformazione (Isaia 35:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['deserto', 'acqua', 'giglio'],
    ),
    QuizQuestion(
      text:
          'Come rispose Geova alla preghiera di Ezechia di fronte a '
          'Sennacherib?',
      options: <String>[
        'Un angelo colpì l’esercito assiro in una sola notte',
        'Ezechia dovette arrendersi',
        'Una carestia indebolì Giuda',
        'Non arrivò alcuna risposta',
      ],
      correctIndex: 0,
      explanation:
          'Una liberazione spettacolare segue la preghiera (Isaia 37).',
    ),
    QuizQuestion(
      text:
          'Che cosa ricorda Isaia 40 riguardo alla natura umana di '
          'fronte a Dio?',
      options: <String>[
        'Ogni carne è come l’erba che appassisce',
        'L’uomo è eterno per natura',
        'Dio dipende dall’uomo',
        'La parola di Dio cambia spesso',
      ],
      correctIndex: 0,
      explanation: '«La parola del nostro Dio durerà per sempre» (Isaia 40:8).',
    ),
  ],
  'Isaiah#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Come descrive Isaia 42 la mitezza del servitore di Geova?',
      options: <String>[
        'Non spezzerà la canna già incrinata',
        'Distruggerà tutto ciò che incontra',
        'Ignorerà i deboli',
        'Agirà con violenza sistematica',
      ],
      correctIndex: 0,
      explanation:
          'Una notevole mitezza caratterizza questo servitore (Isaia 42:3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['lucignolo', 'fumante', 'servitore'],
    ),
    QuizQuestion(
      text:
          'Quale re straniero viene nominato in anticipo da Isaia come '
          'liberatore di Israele?',
      options: <String>['Ciro', 'Nabucodonosor', 'Dario', 'Serse'],
      correctIndex: 0,
      explanation: 'Una notevole profezia nomina Ciro (Isaia 44-45).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Che cosa dice Isaia 48 riguardo all’atteggiamento passato '
          'del popolo verso i comandamenti di Dio?',
      options: <String>[
        'Se solo vi avessero prestato attenzione prima',
        'Hanno sempre obbedito perfettamente',
        'I comandamenti non avevano importanza',
        'Dio non ha mai chiesto nulla',
      ],
      correctIndex: 0,
      explanation:
          'Viene espresso un rimpianto per la loro mancanza di ascolto '
          '(Isaia 48:18).',
    ),
  ],
  'Isaiah#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Come descrive Isaia 53 la sofferenza del servitore di '
          'Geova?',
      options: <String>[
        'Fu trafitto a causa delle nostre trasgressioni',
        'Visse senza mai soffrire',
        'Regnò subito senza alcuna prova',
        'Fu onorato fin dalla nascita',
      ],
      correctIndex: 0,
      explanation:
          'Un capitolo centrale sulla sofferenza redentrice (Isaia 53:5).',
    ),
    QuizQuestion(
      text: 'Quale invito gratuito viene lanciato in Isaia 55?',
      options: <String>[
        'Venite a comprare vino e latte senza denaro',
        'Pagate caro per ottenere la sapienza',
        'Solo i ricchi possono venire',
        'Non viene fatto alcun invito',
      ],
      correctIndex: 0,
      explanation: 'Un’offerta generosa e universale (Isaia 55:1).',
    ),
    QuizQuestion(
      text:
          'Che cosa definisce Isaia 58 come un vero «digiuno» agli '
          'occhi di Dio?',
      options: <String>[
        'Condividere il proprio pane con l’affamato e liberare gli '
            'oppressi',
        'Astenersi soltanto dal cibo',
        'Indossare vesti speciali',
        'Restare in silenzio per un’intera giornata',
      ],
      correctIndex: 0,
      explanation:
          'Il vero digiuno si traduce in atti di giustizia '
          '(Isaia 58:6, 7).',
    ),
  ],
  'Isaiah#7': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale immagine di speranza apre Isaia 60 per Sion?',
      options: <String>[
        'Alzati, risplendi, la tua luce è giunta',
        'Resta nell’oscurità per sempre',
        'Fuggi lontano dalla tua città',
        'Attendi senza speranza',
      ],
      correctIndex: 0,
      explanation: 'Un luminoso appello alla restaurazione (Isaia 60:1).',
    ),
    QuizQuestion(
      text:
          'Quale dichiarazione di Isaia 61 lesse Gesù nella sinagoga '
          'di Nazaret?',
      options: <String>[
        '«Lo spirito del Sovrano Signore Geova è su di me»',
        '«Verrò a giudicare il mondo intero»',
        '«Il tempio sarà distrutto»',
        '«Nessuno sarà salvato»',
      ],
      correctIndex: 0,
      explanation:
          'Gesù applica questo passo a se stesso (Luca 4, citando '
          'Isaia 61:1).',
    ),
    QuizQuestion(
      text: 'Che cosa promette Isaia 65 riguardo al futuro del creato?',
      options: <String>[
        'Nuovi cieli e una nuova terra',
        'La distruzione finale senza restaurazione',
        'Un regno limitato a una sola nazione',
        'La fine di ogni vita animale',
      ],
      correctIndex: 0,
      explanation: 'Una promessa di speranza conclude il libro (Isaia 65:17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sion', 'luce', 'mare'],
    ),
  ],
  'Jeremiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa dice Geova a Geremia riguardo alla sua chiamata '
          'ancor prima della nascita?',
      options: <String>[
        '«Prima ancora di formarti nel ventre, ti conoscevo»',
        'Lo scelse solo da adulto',
        'Geremia si propose da solo',
        'Non viene menzionata alcuna chiamata particolare',
      ],
      correctIndex: 0,
      explanation:
          'Una vocazione profetica stabilita ancor prima della sua '
          'nascita (Geremia 1:5).',
    ),
    QuizQuestion(
      text:
          'A che cosa paragona Geova l’infedeltà d’Israele nel '
          'capitolo 2?',
      options: <String>[
        'A una moglie che ha dimenticato suo marito',
        'A un re fedele',
        'A un servitore esemplare',
        'A una nazione sempre leale',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine di abbandono relazionale (Geremia 2).',
    ),
    QuizQuestion(
      text: 'Quale falsa fiducia denuncia Geremia nel capitolo 7?',
      options: <String>[
        'Ripetere «questo è il tempio di Geova» come una formula magica',
        'L’eccessiva fiducia in Geremia stesso',
        'La fiducia riposta solo nell’esercito',
        'La fiducia nei profeti stranieri',
      ],
      correctIndex: 0,
      explanation:
          'Il popolo crede erroneamente che il tempio li protegga '
          'automaticamente (Geremia 7).',
    ),
  ],
  'Jeremiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale celebre domanda pone Geremia nel capitolo 12?',
      options: <String>[
        'Perché la via dei malvagi prospera?',
        'Perché Babilonia è così debole?',
        'Perché il tempio è vuoto?',
        'Perché i sacerdoti sono assenti?',
      ],
      correctIndex: 0,
      explanation: 'Geremia esprime una lamentela sincera (Geremia 12:1).',
    ),
    QuizQuestion(
      text:
          'Che cosa simboleggia la cintura di lino rovinata in '
          'Geremia 13?',
      options: <String>[
        'La corruzione dell’orgoglio di Giuda',
        'La ricchezza ritrovata del popolo',
        'Una solida alleanza con l’Egitto',
        'La purezza del sacerdozio',
      ],
      correctIndex: 0,
      explanation: 'Un segno visivo di decadenza morale (Geremia 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['cintura', 'lino', 'Eufrate'],
    ),
    QuizQuestion(
      text: 'Cosa riconosce Geremia nel capitolo 10 sulla condotta umana?',
      options: <String>[
        'L’uomo che cammina non può dirigere i propri passi',
        'È naturalmente buono',
        'Non cambia mai',
        'Non ha alcuna importanza per Dio',
      ],
      correctIndex: 0,
      explanation:
          '«Non appartiene all’uomo che cammina dirigere i suoi passi» (Geremia 10:23).',
    ),
  ],
  'Jeremiah#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale illustrazione dà Geova a Geremia nella casa del '
          'vasaio?',
      options: <String>[
        'Come l’argilla nella mano del vasaio, Israele è nella mano di '
            'Dio',
        'Il vasaio simboleggia un re straniero',
        'L’argilla rappresenta la ricchezza',
        'Non se ne trae alcun insegnamento spirituale',
      ],
      correctIndex: 0,
      explanation: 'Un’immagine della sovranità divina (Geremia 18).',
    ),
    QuizQuestion(
      text:
          'Come fu trattato Geremia dopo aver profetizzato contro '
          'Gerusalemme?',
      options: <String>[
        'Fu percosso e messo ai ceppi da Pascur',
        'Fu onorato pubblicamente',
        'Fu nominato sommo sacerdote',
        'Fu inviato in ambasciata',
      ],
      correctIndex: 0,
      explanation: 'Geremia soffre per il suo messaggio fedele (Geremia 20).',
    ),
    QuizQuestion(
      text:
          'Quale scelta propone Geremia al popolo assediato nel '
          'capitolo 21?',
      options: <String>[
        'Arrendersi a Babilonia (vita) o resistere (morte)',
        'Fuggire subito in Egitto',
        'Attaccare per primi Babilonia',
        'Negoziare con l’Assiria',
      ],
      correctIndex: 0,
      explanation:
          'Viene presentata una scelta difficile ma chiara (Geremia 21).',
    ),
  ],
  'Jeremiah#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa promette Geremia 23 riguardo a un futuro re '
          'giusto?',
      options: <String>[
        'Un «germoglio giusto» regnerà con saggezza',
        'Nessun re giusto verrà mai',
        'I falsi pastori regneranno per sempre',
        'Il regno scomparirà senza successore',
      ],
      correctIndex: 0,
      explanation:
          'Una promessa messianica contrasta con i cattivi pastori '
          '(Geremia 23:5).',
    ),
    QuizQuestion(
      text: 'Quanti anni di cattività a Babilonia annuncia Geremia?',
      options: <String>['70 anni', '7 anni', '40 anni', '400 anni'],
      correctIndex: 0,
      explanation: 'Questa durata precisa viene profetizzata (Geremia 25:11).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['settanta anni', '70'],
    ),
    QuizQuestion(
      text:
          'Che cosa consiglia Geremia agli esiliati a Babilonia nella '
          'sua lettera?',
      options: <String>[
        'Costruire case e cercare la pace della città',
        'Ribellarsi immediatamente',
        'Rifiutare ogni lavoro',
        'Ignorare le autorità locali',
      ],
      correctIndex: 0,
      explanation: 'Un consiglio realistico per vivere in esilio (Geremia 29).',
    ),
  ],
  'Jeremiah#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Che cosa promette Geova nella celebre profezia del nuovo '
          'patto?',
      options: <String>[
        'La sua legge sarà scritta nel cuore del popolo',
        'Un nuovo tempio sarà costruito immediatamente',
        'Non è previsto alcun patto futuro',
        'Il sacerdozio sarà abolito senza sostituzione',
      ],
      correctIndex: 0,
      explanation:
          'Viene annunciato un patto interiore e personale '
          '(Geremia 31:33).',
    ),
    QuizQuestion(
      text:
          'Quale gesto simbolico compie Geremia in piena crisi, '
          'comprando un campo?',
      options: <String>[
        'Esprime la sua fede in una futura restaurazione',
        'Cerca di arricchirsi personalmente',
        'Fugge dalla città assediata',
        'Negozia con Babilonia',
      ],
      correctIndex: 0,
      explanation:
          'Questo acquisto testimonia speranza nonostante l’assedio '
          '(Geremia 32).',
    ),
    QuizQuestion(
      text: 'Quale esempio di fedeltà offrono i recabiti a Giuda?',
      options: <String>[
        'La loro rigorosa obbedienza al comando del loro antenato',
        'La loro abbondante ricchezza',
        'Il loro potere militare',
        'La loro alleanza con l’Egitto',
      ],
      correctIndex: 0,
      explanation:
          'La loro fedeltà contrasta con l’infedeltà di Giuda (Geremia 35).',
    ),
  ],
  'Jeremiah#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi salvò Geremia gettato in una cisterna fangosa?',
      options: <String>['Ebed-Mèlec', 'Baruc', 'Ghedalia', 'Ismaele'],
      correctIndex: 0,
      explanation: 'Questo etiope interviene coraggiosamente (Geremia 38).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Ebed Melec'],
    ),
    QuizQuestion(
      text:
          'Chi fu nominato governatore dopo la caduta di Gerusalemme, '
          'per poi essere assassinato?',
      options: <String>['Ghedalia', 'Sedechia', 'Ismaele', 'Baruc'],
      correctIndex: 0,
      explanation: 'Il suo assassinio provoca nuovi disordini (Geremia 40-41).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Che cosa fa il resto del popolo nonostante l’avvertimento '
          'di Geremia di restare nel paese?',
      options: <String>[
        'Fugge in Egitto portando con sé Geremia',
        'Si sottomette pienamente al consiglio del profeta',
        'Attacca Babilonia',
        'Si disperde verso l’Assiria',
      ],
      correctIndex: 0,
      explanation:
          'La loro disobbedienza aggrava la loro situazione (Geremia 43).',
    ),
  ],
  'Jeremiah#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Contro quali nazioni pronunciano giudizi gli ultimi '
          'capitoli di Geremia?',
      options: <String>[
        'L’Egitto, i filistei, Moab, Ammon, Babilonia e altre ancora',
        'Solo Israele',
        'Nessuna nazione straniera',
        'Solo Giuda',
      ],
      correctIndex: 0,
      explanation:
          'Una serie di oracoli contro le nazioni conclude il libro '
          '(Geremia 46-51).',
    ),
    QuizQuestion(
      text:
          'Quale segno simbolico accompagna la profezia contro '
          'Babilonia consegnata a Seraia?',
      options: <String>[
        'Il rotolo viene gettato nell’Eufrate per affondare',
        'Viene bruciato pubblicamente',
        'Viene letto davanti al re di Babilonia',
        'Viene nascosto nel tempio',
      ],
      correctIndex: 0,
      explanation:
          'Un’immagine della caduta definitiva di Babilonia (Geremia 51).',
    ),
    QuizQuestion(
      text: 'Come si conclude storicamente il libro di Geremia?',
      options: <String>[
        'Con la liberazione di Ioiachin dalla prigione a Babilonia',
        'Con il ritorno immediato di tutto il popolo',
        'Con la ricostruzione del tempio',
        'Con una vittoria militare di Giuda',
      ],
      correctIndex: 0,
      explanation: 'Un epilogo storico chiude il libro (Geremia 52).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesItC3 =
    <String, List<QuizQuestion>>{};
