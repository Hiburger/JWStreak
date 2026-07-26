import 'quiz_data.dart';

const Map<String, List<QuizQuestion>> authoredQuizzesItC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi annunciò la venuta di Gesù predicando nel deserto?',
      options: <String>['Giovanni il Battista', 'Elia', 'Isaia', 'Zaccaria'],
      correctIndex: 0,
      explanation: 'Giovanni il Battista prepara la via a Gesù (Matteo 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gesù', 'Pietro', 'Elia'],
    ),
    QuizQuestion(
      text: 'Per quanto tempo digiunò Gesù prima di essere tentato dal Diavolo?',
      options: <String>['40 giorni', '7 giorni', '3 giorni', '100 giorni'],
      correctIndex: 0,
      explanation: 'Gesù digiuna 40 giorni e 40 notti (Matteo 4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['quaranta giorni', '40'],
    ),
    QuizQuestion(
      text: 'Secondo il Sermone sul Monte, chi viene dichiarato felice?',
      options: <String>[
        'Chi è consapevole della propria povertà spirituale',
        'I ricchi',
        'I potenti',
        'I famosi',
      ],
      correctIndex: 0,
      explanation: 'Le Beatitudini iniziano con i poveri in spirito (Matteo 5:3).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quanti pani e pesci usò Gesù per sfamare circa 5.000 uomini?',
      options: <String>['5 pani e 2 pesci', '2 pani e 5 pesci', '7 pani', '12 pani'],
      correctIndex: 0,
      explanation: 'Gesù moltiplica 5 pani e 2 pesci (Matteo 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['7', '12', 'ceste'],
    ),
    QuizQuestion(
      text: 'Che cosa fece Pietro vedendo Gesù camminare sull’acqua?',
      options: <String>[
        'Provò anche lui a camminare sull’acqua',
        'Si nascose',
        'Fuggì',
        'Non fece nulla',
      ],
      correctIndex: 0,
      explanation:
          'Pietro cammina verso Gesù ma comincia ad affondare per mancanza di '
          'fede (Matteo 14).',
    ),
    QuizQuestion(
      text: 'Chi chiese la testa di Giovanni il Battista su un piatto?',
      options: <String>['La figlia di Erodiade', 'Erode stesso', 'Un soldato', 'Pilato'],
      correctIndex: 0,
      explanation:
          'La danzatrice, istigata da sua madre, reclama la testa di '
          'Giovanni (Matteo 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Salomè', 'Erode', 'Maria'],
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Come rispose Pietro quando Gesù chiese: «Chi dite voi che io sia?»?',
      options: <String>[
        'Tu sei il Cristo, il Figlio del Dio vivente',
        'Tu sei Elia',
        'Tu sei un profeta',
        'Non lo so',
      ],
      correctIndex: 0,
      explanation: 'Pietro riconosce Gesù come il Cristo (Matteo 16).',
    ),
    QuizQuestion(
      text: 'Che cosa accadde durante la trasfigurazione?',
      options: <String>[
        'Il volto di Gesù risplendette come il sole',
        'Gesù scomparve',
        'Si scatenò una tempesta',
        'Gesù camminò sull’acqua',
      ],
      correctIndex: 0,
      explanation:
          'Gesù si trasfigura davanti a Pietro, Giacomo e Giovanni '
          '(Matteo 17).',
    ),
    QuizQuestion(
      text: 'Su quale animale entrò Gesù a Gerusalemme?',
      options: <String>['Un asinello', 'Un cavallo bianco', 'Un cammello', 'A piedi'],
      correctIndex: 0,
      explanation:
          'Gesù entra in sella a un asinello, secondo la profezia '
          '(Matteo 21).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['asinello', 'asino'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa istituì Gesù durante il suo ultimo pasto con gli apostoli?',
      options: <String>[
        'Il pasto in memoria della sua morte',
        'Una festa annuale del raccolto',
        'Un digiuno collettivo',
        'Un pellegrinaggio',
      ],
      correctIndex: 0,
      explanation:
          'Gesù istituisce il pasto commemorativo con il pane e il vino '
          '(Matteo 26).',
    ),
    QuizQuestion(
      text: 'Chi tradì Gesù per trenta pezzi d’argento?',
      options: <String>['Giuda Iscariota', 'Pietro', 'Tommaso', 'Barabba'],
      correctIndex: 0,
      explanation: 'Giuda tradisce Gesù (Matteo 26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Giuda'],
    ),
    QuizQuestion(
      text: 'Che cosa accadde il terzo giorno dopo la morte di Gesù?',
      options: <String>[
        'Risuscitò',
        'Il tempio fu distrutto',
        'Salì al cielo',
        'Niente di particolare',
      ],
      correctIndex: 0,
      explanation: 'Gesù risuscita il terzo giorno (Matteo 28).',
    ),
  ],
  'John#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Secondo Giovanni 1, chi era «la Parola» (il Logos) presso Dio al '
          'principio?',
      options: <String>[
        'Il Figlio di Dio, prima di diventare umano',
        'Un angelo',
        'Mosè',
        'Lo Spirito Santo'],
      correctIndex: 0,
      explanation:
          'La Parola era presso Dio e diventa carne in Gesù '
          '(Giovanni 1).',
    ),
    QuizQuestion(
      text: 'Qual è stato il primo miracolo di Gesù, a Cana?',
      options: <String>[
        'Cambiare l’acqua in vino',
        'Guarire un cieco',
        'Sfamare una folla',
        'Calmare una tempesta',
      ],
      correctIndex: 0,
      explanation:
          'Gesù cambia l’acqua in vino durante un matrimonio (Giovanni 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pane', 'pesce', 'olio'],
    ),
    QuizQuestion(
      text: 'Che cosa deve fare, secondo Gesù, una persona per «vedere il '
          'regno di Dio»?',
      options: <String>['Nascere di nuovo', 'Digiunare 40 giorni', 'Andare al tempio', 'Diventare sacerdote'],
      correctIndex: 0,
      explanation:
          'Gesù lo spiega a Nicodemo (Giovanni 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['rinascere'],
    ),
  ],
  'John#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Come si descrive Gesù in Giovanni 10?',
      options: <String>['Il buon pastore', 'Il leone', 'Il sommo sacerdote', 'Il giudice'],
      correctIndex: 0,
      explanation:
          'Gesù si presenta come il buon pastore che dà la vita per le '
          'sue pecore (Giovanni 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['porta', 'vite', 'luce'],
    ),
    QuizQuestion(
      text: 'Chi riportò in vita Gesù dopo quattro giorni nella tomba?',
      options: <String>['Lazzaro', 'Iairo', 'Il figlio della vedova', 'Un centurione'],
      correctIndex: 0,
      explanation: 'Gesù risuscita Lazzaro (Giovanni 11).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Che cosa fece Gesù per i suoi apostoli prima dell’ultima cena, '
          'come esempio di umiltà?',
      options: <String>[
        'Lavò loro i piedi',
        'Li benedisse uno per uno',
        'Condivise i suoi beni',
        'Pregò pubblicamente per ciascuno di loro',
      ],
      correctIndex: 0,
      explanation: 'Gesù lava i piedi ai suoi discepoli (Giovanni 13).',
    ),
  ],
  'John#2': <QuizQuestion>[
    QuizQuestion(
      text: 'A che cosa paragona Gesù la sua relazione con i discepoli in '
          'Giovanni 15?',
      options: <String>['Una vite e i suoi tralci', 'Un pastore e il suo gregge', 'Un re e i suoi sudditi', 'Un padre e i suoi figli'],
      correctIndex: 0,
      explanation: 'Gesù è la vite, i suoi discepoli i tralci (Giovanni 15).',
    ),
    QuizQuestion(
      text: 'Chi tagliò l’orecchio a un uomo durante l’arresto di Gesù?',
      options: <String>['Pietro', 'Giovanni', 'Giacomo', 'Andrea'],
      correctIndex: 0,
      explanation: 'Pietro colpisce Malco con una spada (Giovanni 18).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Chi dubitò dapprima della risurrezione prima di toccare le '
          'ferite di Gesù?',
      options: <String>['Tommaso', 'Pietro', 'Giovanni', 'Filippo'],
      correctIndex: 0,
      explanation: 'Tommaso dubita e poi crede (Giovanni 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi prepara la via davanti a Gesù all’inizio di Marco?',
      options: <String>['Giovanni il Battista', 'Elia in persona', 'Un angelo', 'Il sommo sacerdote'],
      correctIndex: 0,
      explanation:
          'Giovanni battezza e annuncia la venuta di Gesù (Marco 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Gesù', 'Elia', 'Pietro'],
    ),
    QuizQuestion(
      text: 'Come mostrò Gesù la sua autorità guarendo il paralitico calato '
          'dal tetto?',
      options: <String>[
        'Perdonando i suoi peccati prima di guarirlo',
        'Esigendo un sacrificio preliminare',
        'Rimandandolo senza risposta',
        'Consultando prima i farisei',
      ],
      correctIndex: 0,
      explanation:
          'Il perdono precede la guarigione fisica (Marco 2).',
    ),
    QuizQuestion(
      text: 'Che cosa racconta la parabola del seminatore in Marco 4?',
      options: <String>[
        'Le diverse accoglienze riservate alla parola di Dio',
        'Una semplice lezione di agricoltura',
        'Un giudizio contro gli agricoltori',
        'Una profezia sulla carestia',
      ],
      correctIndex: 0,
      explanation:
          'I diversi tipi di terreno illustrano i cuori (Marco 4).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa accadde quando i cinquemila furono sfamati?',
      options: <String>[
        'Cinque pani e due pesci bastarono e ne avanzò',
        'Ognuno aveva portato il proprio cibo',
        'La folla se ne andò affamata',
        'Fu improvvisato un mercato',
      ],
      correctIndex: 0,
      explanation:
          'Un miracolo di moltiplicazione (Marco 6).',
    ),
    QuizQuestion(
      text: 'Quale scena straordinaria si verifica sul monte in Marco 9?',
      options: <String>['La trasfigurazione di Gesù', 'Un terremoto', 'Una violenta tempesta', 'Un giudizio pubblico'],
      correctIndex: 0,
      explanation:
          'Gesù appare glorioso insieme a Mosè ed Elia (Marco 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['battesimo', 'risurrezione', 'monte'],
    ),
    QuizQuestion(
      text: 'Come entra Gesù a Gerusalemme in Marco 11?',
      options: <String>['In sella a un asinello, acclamato dalla folla', 'Di nascosto, senza farsi vedere', 'Con un esercito', 'A cavallo da conquistatore'],
      correctIndex: 0,
      explanation:
          'L’ingresso trionfale adempie una profezia (Marco 11).',
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale grande comandamento cita Gesù in Marco 12?',
      options: <String>[
        'Amare Dio con tutto il cuore e il prossimo come se stessi',
        'Pagare scrupolosamente le tasse',
        'Digiunare ogni settimana',
        'Evitare ogni contatto con gli stranieri',
      ],
      correctIndex: 0,
      explanation:
          'Gesù riassume la legge in due comandamenti (Marco 12).',
    ),
    QuizQuestion(
      text: 'Che cosa istituì Gesù durante l’ultima cena con i discepoli?',
      options: <String>[
        'Il pasto commemorativo della sua morte',
        'Una nuova festa annuale',
        'Un digiuno collettivo',
        'Un pellegrinaggio obbligatorio',
      ],
      correctIndex: 0,
      explanation:
          'Il pane e il vino simboleggiano il suo sacrificio (Marco 14).',
    ),
    QuizQuestion(
      text: 'Che cosa scoprono le donne giunte alla tomba il terzo giorno?',
      options: <String>[
        'La tomba è vuota, Gesù è risuscitato',
        'Il corpo di Gesù è ancora lì',
        'La tomba è sigillata e inaccessibile',
        'Niente di insolito',
      ],
      correctIndex: 0,
      explanation:
          'La risurrezione è annunciata da un angelo (Marco 16).',
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi annuncia a Maria che sarà la madre di Gesù?',
      options: <String>['L’angelo Gabriele', 'Un sacerdote', 'Giovanni il Battista', 'Solo un sogno'],
      correctIndex: 0,
      explanation:
          'Gabriele annuncia la nascita miracolosa (Luca 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Gabriele'],
    ),
    QuizQuestion(
      text: 'Chi rese testimonianza a Gesù bambino durante la sua '
          'presentazione al tempio?',
      options: <String>['Simeone e Anna', 'Erode', 'I sommi sacerdoti', 'Nessuno'],
      correctIndex: 0,
      explanation:
          'Due fedeli anziani riconoscono il Messia (Luca 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Zaccaria', 'Elisabetta', 'Giuseppe'],
    ),
    QuizQuestion(
      text: 'Quale celebre discorso pronuncia Gesù in Luca 6?',
      options: <String>[
        'Il sermone della pianura, con le felicità e i guai',
        'Un discorso sulle tasse',
        'Un annuncio di guerra',
        'Un giudizio contro Roma',
      ],
      correctIndex: 0,
      explanation:
          'Un importante insegnamento morale (Luca 6).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale celebre parabola illustra l’amore per il prossimo in '
          'Luca 10?',
      options: <String>['Il buon Samaritano', 'Il figlio prodigo', 'Il seminatore', 'Le dieci vergini'],
      correctIndex: 0,
      explanation:
          'Un esempio di compassione verso uno straniero (Luca 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sacerdote', 'levita', 'locandiere'],
    ),
    QuizQuestion(
      text: 'Quali tre parabole racconta Gesù in Luca 15 su ciò che è '
          'perduto?',
      options: <String>[
        'La pecora perduta, la moneta perduta, il figlio prodigo',
        'Il seminatore, la rete, la perla',
        'Il fico, la vigna, il grano',
        'I talenti, le mine, il tesoro',
      ],
      correctIndex: 0,
      explanation:
          'Tre immagini della gioia ritrovata (Luca 15).',
    ),
    QuizQuestion(
      text: 'Che cosa rivela la parabola del ricco e di Lazzaro in Luca 16?',
      options: <String>[
        'Un contrasto tra indifferenza e compassione',
        'Una lezione di agricoltura',
        'Un consiglio finanziario pratico',
        'Una profezia su Roma',
      ],
      correctIndex: 0,
      explanation:
          'Una parabola sulle priorità del cuore (Luca 16).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa fa Zaccheo per mostrare il cambiamento della sua vita '
          'dopo aver incontrato Gesù?',
      options: <String>[
        'Restituisce il quadruplo a chi ha danneggiato',
        'Lascia la città',
        'Alla fine ignora Gesù',
        'Rifiuta di condividere i suoi beni',
      ],
      correctIndex: 0,
      explanation:
          'La sua generosità mostra una conversione sincera (Luca 19).',
    ),
    QuizQuestion(
      text: 'Che cosa chiede il malfattore pentito a Gesù sul palo?',
      options: <String>[
        'Di ricordarsi di lui nel suo regno',
        'Di liberarlo immediatamente',
        'Di punire i suoi accusatori',
        'Di dimostrare pubblicamente il suo potere',
      ],
      correctIndex: 0,
      explanation:
          'Gesù gli promette il paradiso (Luca 23).',
    ),
    QuizQuestion(
      text: 'Che cosa accade sulla via di Emmaus dopo la risurrezione?',
      options: <String>[
        'Gesù risuscitato spiega le Scritture a due discepoli',
        'I discepoli vengono arrestati',
        'Un angelo vieta ogni viaggio',
        'Non accade nulla di particolare',
      ],
      correctIndex: 0,
      explanation:
          'Lo riconoscono mentre spezza il pane (Luca 24).',
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa promette Gesù ai suoi discepoli poco prima della sua '
          'ascensione?',
      options: <String>[
        'Riceveranno la potenza dello spirito santo',
        'Regneranno immediatamente su Roma',
        'Non lo rivedranno mai più',
        'Dovranno fuggire subito',
      ],
      correctIndex: 0,
      explanation:
          'Una promessa essenziale prima della Pentecoste (Atti 1).',
    ),
    QuizQuestion(
      text: 'Che cosa accadde il giorno della Pentecoste?',
      options: <String>[
        'Lo spirito santo fu riversato sui discepoli',
        'Un terremoto distrusse il tempio',
        'Gli apostoli fuggirono da Gerusalemme',
        'Non accadde nulla di insolito',
      ],
      correctIndex: 0,
      explanation:
          'La congregazione cristiana inizia quel giorno '
          '(Atti 2).',
    ),
    QuizQuestion(
      text: 'Chi divenne il primo martire cristiano?',
      options: <String>['Stefano', 'Pietro', 'Solo Giacomo', 'Filippo'],
      correctIndex: 0,
      explanation:
          'Stefano viene lapidato dopo il suo discorso (Atti 7).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Come fu trasformato Saulo sulla via di Damasco?',
      options: <String>[
        'Una luce e una voce di Gesù lo convertirono',
        'Cambiò semplicemente idea da solo',
        'Un re lo costrinse a cambiare',
        'Non accadde nulla su quella via',
      ],
      correctIndex: 0,
      explanation:
          'Il suo incontro con Gesù cambia la sua vita (Atti 9).',
    ),
    QuizQuestion(
      text: 'Quale visione riceve Pietro prima di incontrare Cornelio?',
      options: <String>[
        'Un grande telo con animali, che significa l’apertura ai non '
            'ebrei',
        'Una battaglia celeste',
        'Un tempio in fiamme',
        'Un sogno senza significato',
      ],
      correctIndex: 0,
      explanation:
          'Questa visione prepara Pietro ad annunciare la buona '
          'notizia alle nazioni (Atti 10).',
    ),
    QuizQuestion(
      text: 'Dove i discepoli furono chiamati «cristiani» per la prima '
          'volta?',
      options: <String>['Ad Antiochia', 'A Gerusalemme', 'A Roma', 'A Efeso'],
      correctIndex: 0,
      explanation:
          'Questo nome appare per la prima volta ad Antiochia (Atti 11:26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Antiochia'],
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale importante decisione prende il concilio di Gerusalemme '
          'riguardo ai non ebrei convertiti?',
      options: <String>[
        'Non sono tenuti alla circoncisione mosaica',
        'Devono seguire tutta la legge di Mosè',
        'Sono esclusi dalla congregazione',
        'Non viene presa alcuna decisione',
      ],
      correctIndex: 0,
      explanation:
          'Una decisione chiave per l’espansione del cristianesimo '
          '(Atti 15).',
    ),
    QuizQuestion(
      text: 'Che cosa accadde a Paolo e Sila imprigionati a Filippi?',
      options: <String>[
        'Un terremoto aprì le porte della prigione',
        'Fuggirono di nascosto',
        'Rimasero rinchiusi a vita',
        'Nessuno intervenne',
      ],
      correctIndex: 0,
      explanation:
          'Un miracolo libera i prigionieri (Atti 16).',
    ),
    QuizQuestion(
      text: 'Dove pronunciò Paolo il suo celebre discorso sul «Dio '
          'sconosciuto»?',
      options: <String>['All’Areopago, ad Atene', 'A Roma', 'A Gerusalemme', 'A Corinto'],
      correctIndex: 0,
      explanation:
          'Paolo si rivolge ai filosofi greci (Atti 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Areopago', 'Atene'],
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa racconta Paolo nella sua difesa dopo il suo arresto '
          'al tempio?',
      options: <String>[
        'La sua conversione sulla via di Damasco',
        'Una vittoria militare',
        'Un viaggio d’affari',
        'Una disputa personale',
      ],
      correctIndex: 0,
      explanation:
          'Paolo rende testimonianza della sua esperienza personale '
          '(Atti 22).',
    ),
    QuizQuestion(
      text: 'Perché Paolo si appellò a Cesare?',
      options: <String>[
        'Per ottenere un processo equo in quanto cittadino romano',
        'Per evitare qualsiasi processo',
        'Per essere liberato immediatamente',
        'Perché voleva lasciare il ministero',
      ],
      correctIndex: 0,
      explanation:
          'Il suo status di cittadino romano gli dà questo diritto '
          '(Atti 25).',
    ),
    QuizQuestion(
      text: 'Che cosa accadde dopo il naufragio sull’isola di Malta?',
      options: <String>[
        'Paolo fu morso da una vipera senza subire danni',
        'Fu arrestato dagli abitanti',
        'La nave ripartì immediatamente',
        'Non accadde nulla di particolare',
      ],
      correctIndex: 0,
      explanation:
          'Un segno miracoloso colpisce gli abitanti '
          '(Atti 28).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesItC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale modello di preghiera diede Gesù nel Sermone sul Monte?',
      options: <String>[
        'La preghiera «Padre nostro»',
        'Un lungo elenco di richieste',
        'Una preghiera segreta e proibita',
        'Nessuna preghiera precisa',
      ],
      correctIndex: 0,
      explanation:
          'Gesù insegna a pregare in modo semplice (Matteo 6).',
    ),
    QuizQuestion(
      text: 'A che cosa somiglia chi mette in pratica le parole di Gesù, '
          'secondo Matteo 7?',
      options: <String>[
        'Un uomo che costruisce la sua casa sulla roccia',
        'Un uomo che costruisce sulla sabbia',
        'Un viaggiatore senza meta',
        'Un re senza regno',
      ],
      correctIndex: 0,
      explanation:
          'La casa sulla roccia resiste alle tempeste (Matteo 7:24).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Che cosa fece Gesù durante una tempesta sul mare di Galilea?',
      options: <String>['La calmò con una parola', 'Remò più veloce', 'Attese che finisse', 'Fuggì verso la riva'],
      correctIndex: 0,
      explanation:
          'Il vento e il mare gli obbediscono (Matteo 8).',
    ),
    QuizQuestion(
      text: 'Quanti apostoli scelse e mandò a predicare Gesù?',
      options: <String>['Dodici', 'Sette', 'Settanta', 'Tre'],
      correctIndex: 0,
      explanation:
          'Vengono nominati i dodici apostoli (Matteo 10).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['12'],
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quante volte bisogna perdonare il proprio fratello, secondo '
          'Matteo 18?',
      options: <String>[
        'Fino a 77 volte',
        'Solo tre volte',
        'Una sola volta',
        'Mai',
      ],
      correctIndex: 0,
      explanation:
          'Gesù insegna un perdono senza limiti (Matteo 18:22).',
    ),
    QuizQuestion(
      text: 'Che cosa fece Gesù entrando nel tempio a Gerusalemme?',
      options: <String>[
        'Scacciò i mercanti',
        'Offrì un sacrificio',
        'Si nascose',
        'Incoronò un sacerdote',
      ],
      correctIndex: 0,
      explanation:
          'Gesù purifica il tempio (Matteo 21).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sacerdoti', 'farisei', 'tempio'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Quali segni annunciò Gesù per la conclusione del sistema in '
          'Matteo 24?',
      options: <String>[
        'Guerre, carestie e terremoti',
        'Una pace mondiale immediata',
        'La scomparsa del sole per sempre',
        'Nessun segno',
      ],
      correctIndex: 0,
      explanation:
          'Viene descritto un segno composito (Matteo 24).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pestilenze', 'pace', 'ricchezze'],
    ),
    QuizQuestion(
      text: 'Quale missione affidò Gesù ai suoi discepoli dopo la sua '
          'risurrezione?',
      options: <String>[
        'Fare discepoli di persone di tutte le nazioni',
        'Restare nascosti a Gerusalemme',
        'Costruire un tempio',
        'Aspettare senza fare nulla',
      ],
      correctIndex: 0,
      explanation:
          'L’incarico missionario conclude il vangelo (Matteo 28:19).',
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi chiamò per primi Gesù sulla riva del mare di Galilea?',
      options: <String>['Dei pescatori', 'Dei sacerdoti', 'Dei soldati', 'Degli scribi'],
      correctIndex: 0,
      explanation:
          'Simone, Andrea e altri lo seguono (Marco 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['pescatori'],
    ),
    QuizQuestion(
      text: 'Che cosa fece Gesù per l’uomo indemoniato della regione di '
          'Gerasa?',
      options: <String>[
        'Scacciò i demoni che lo tormentavano',
        'Lo ignorò',
        'Lo rimandò a casa senza fare nulla',
        'Lo rimproverò severamente',
      ],
      correctIndex: 0,
      explanation:
          'L’uomo viene liberato e ritrova il senno (Marco 5).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Con quanti pani Gesù sfamò circa 4.000 persone?',
      options: <String>['Sette', 'Cinque', 'Dodici', 'Due'],
      correctIndex: 0,
      explanation:
          'Un secondo miracolo di moltiplicazione (Marco 8).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['7'],
    ),
    QuizQuestion(
      text: 'Che cosa bisogna diventare, secondo Gesù, per entrare nel '
          'Regno di Dio?',
      options: <String>['Come un bambino piccolo', 'Ricco e potente', 'Un capo riconosciuto', 'Un sapiente'],
      correctIndex: 0,
      explanation:
          'Gesù prende i bambini a esempio (Marco 10).',
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale piccola offerta lodò Gesù al tempio?',
      options: <String>[
        'Le due monetine della vedova',
        'Un sacco d’oro',
        'Un agnello perfetto',
        'Una moneta d’argento',
      ],
      correctIndex: 0,
      explanation:
          'Ha dato tutto ciò che aveva (Marco 12).',
    ),
    QuizQuestion(
      text: 'Chi fu costretto a portare il palo di supplizio di Gesù?',
      options: <String>['Simone di Cirene', 'Pietro', 'Giovanni', 'Barabba'],
      correctIndex: 0,
      explanation:
          'Simone viene requisito lungo il cammino (Marco 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Pietro', 'Giuda', 'Barabba'],
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: 'In quale città nacque Gesù?',
      options: <String>['Betlemme', 'Nazaret', 'Gerusalemme', 'Cafarnao'],
      correctIndex: 0,
      explanation:
          'La nascita avviene a Betlemme (Luca 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'A chi annunciarono per primi gli angeli la nascita di Gesù?',
      options: <String>['A dei pastori', 'A dei re', 'Ai sacerdoti', 'A Erode'],
      correctIndex: 0,
      explanation:
          'Alcuni pastori ricevono la buona notizia (Luca 2).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quanti discepoli mandò Gesù a predicare a due a due in '
          'Luca 10?',
      options: <String>['Settanta', 'Dodici', 'Cento', 'Tre'],
      correctIndex: 0,
      explanation:
          'Gesù allarga la predicazione (Luca 10).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['70'],
    ),
    QuizQuestion(
      text: 'Che cosa consiglia Gesù riguardo alla preoccupazione per il '
          'cibo e il vestito?',
      options: <String>[
        'Di non preoccuparsi, ma di cercare prima il Regno',
        'Di accumulare il più possibile',
        'Di smettere di lavorare',
        'Di preoccuparsi costantemente',
      ],
      correctIndex: 0,
      explanation:
          'Gesù insegna la fiducia in Dio (Luca 12).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quanti lebbrosi guarì Gesù, di cui uno solo tornò a '
          'ringraziare?',
      options: <String>['Dieci', 'Sette', 'Tre', 'Dodici'],
      correctIndex: 0,
      explanation:
          'Solo un Samaritano torna a rendere grazie (Luca 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['10'],
    ),
    QuizQuestion(
      text: 'Chi complottò e tradì Gesù per denaro?',
      options: <String>['Giuda Iscariota', 'Pietro', 'Tommaso', 'Pilato'],
      correctIndex: 0,
      explanation:
          'Giuda consegna Gesù (Luca 22).',
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quante persone circa furono battezzate il giorno della '
          'Pentecoste?',
      options: <String>['Circa 3.000', 'Circa 500', 'Circa 12', 'Circa 100'],
      correctIndex: 0,
      explanation:
          'Un gran numero risponde al messaggio (Atti 2).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['3.000', 'tremila'],
    ),
    QuizQuestion(
      text: 'Chi custodiva le vesti di quelli che lapidavano Stefano?',
      options: <String>['Saulo (in seguito Paolo)', 'Pietro', 'Barnaba', 'Filippo'],
      correctIndex: 0,
      explanation:
          'Saulo approvava questo omicidio (Atti 7-8).',
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi mandò lo spirito ad annunciare la buona notizia all’eunuco '
          'etiope?',
      options: <String>['Filippo', 'Pietro', 'Paolo', 'Giovanni'],
      correctIndex: 0,
      explanation:
          'Filippo gli spiega le Scritture (Atti 8).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Come fu liberato Pietro dalla prigione sotto Erode?',
      options: <String>['Da un angelo', 'Corrompendo una guardia', 'Da un terremoto', 'Nessuno lo aiutò'],
      correctIndex: 0,
      explanation:
          'Un angelo lo fa uscire miracolosamente (Atti 12).',
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale mestiere esercitava Paolo insieme ad Aquila e Priscilla?',
      options: <String>['Fabbricante di tende', 'Pescatore', 'Falegname', 'Medico'],
      correctIndex: 0,
      explanation:
          'Paolo lavorava con le proprie mani (Atti 18).',
    ),
    QuizQuestion(
      text: 'In quale città la predicazione di Paolo provocò una sommossa '
          'degli argentieri di Diana/Artemide?',
      options: <String>['Efeso', 'Atene', 'Corinto', 'Roma'],
      correctIndex: 0,
      explanation:
          'Gli artigiani temevano per il loro commercio (Atti 19).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Davanti a quali autorità testimoniò Paolo a Cesarea?',
      options: <String>[
        'Felice, Festo e il re Agrippa',
        'Pilato ed Erode',
        'Solo il Sinedrio',
        'Cesare in persona',
      ],
      correctIndex: 0,
      explanation:
          'Paolo difende la sua fede davanti alle autorità (Atti 24-26).',
    ),
    QuizQuestion(
      text: 'Dove giunse infine Paolo per attendere il suo processo '
          'davanti a Cesare?',
      options: <String>['A Roma', 'A Gerusalemme', 'Ad Antiochia', 'A Efeso'],
      correctIndex: 0,
      explanation:
          'Paolo predica anche agli arresti domiciliari (Atti 28).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Roma'],
    ),
  ],
};
