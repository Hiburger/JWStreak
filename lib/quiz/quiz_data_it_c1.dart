import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesItC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quanti giorni di creazione descrive Genesi prima che Dio si '
          'riposi?',
      options: <String>[
        'Sei giorni',
        'Sette giorni',
        'Tre giorni',
        'Quaranta giorni',
      ],
      correctIndex: 0,
      explanation:
          'La Genesi descrive sei giorni di creazione; Dio si riposa il settimo (Genesi 1 e 2).',
    ),
    QuizQuestion(
      text: 'Chi furono il primo uomo e la prima donna?',
      options: <String>[
        'Adamo ed Eva',
        'Caino e Abele',
        'Noè e sua moglie',
        'Abramo e Sara',
      ],
      correctIndex: 0,
      explanation: 'Adamo ed Eva sono i primi esseri umani (Genesi 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Caino', 'Noè', 'Sara'],
    ),
    QuizQuestion(
      text: 'Chi uccise suo fratello Abele?',
      options: <String>['Caino', 'Set', 'Noè', 'Cam'],
      correctIndex: 0,
      explanation: 'Caino uccide suo fratello Abele per gelosia (Genesi 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Perché Dio fece venire il Diluvio?',
      options: <String>[
        'A causa della malvagità degli uomini',
        'A causa di una siccità',
        'Per ingrandire i mari',
        'Senza alcuna ragione',
      ],
      correctIndex: 0,
      explanation:
          'La malvagità degli esseri umani era grande sulla terra '
          '(Genesi 6).',
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale segno diede Dio come promessa di non distruggere più la '
          'terra con un diluvio?',
      options: <String>['L’arcobaleno', 'Una stella', 'Un ulivo', 'Il tuono'],
      correctIndex: 0,
      explanation: 'L’arcobaleno è il segno dell’alleanza (Genesi 9).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['arcobaleno'],
    ),
    QuizQuestion(
      text: 'Come si chiamava la torre che gli uomini vollero costruire?',
      options: <String>[
        'La torre di Babele',
        'La torre di Sion',
        'La torre di Davide',
        'La torre di Ur',
      ],
      correctIndex: 0,
      explanation: 'A Babele, Dio confonde il loro linguaggio (Genesi 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sion', 'Davide', 'Ur'],
    ),
    QuizQuestion(
      text: 'Chi chiamò Dio a lasciare Ur?',
      options: <String>['Abramo (Abram)', 'Lot', 'Isacco', 'Giacobbe'],
      correctIndex: 0,
      explanation: 'Dio chiama Abramo e gli fa delle promesse (Genesi 12).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Perché gli egiziani ridussero gli israeliti in schiavitù?',
      options: <String>[
        'Temevano che diventassero troppo numerosi',
        'Volevano le loro terre',
        'Un debito non pagato',
        'Una guerra persa',
      ],
      correctIndex: 0,
      explanation:
          'Un nuovo re teme la moltiplicazione degli israeliti '
          '(Esodo 1).',
    ),
    QuizQuestion(
      text: 'In cosa nascose la madre di Mosè il bambino?',
      options: <String>[
        'Un cesto sul Nilo',
        'Una grotta',
        'Una tenda',
        'Un pozzo',
      ],
      correctIndex: 0,
      explanation:
          'Il cesto era fatto di giunchi e spalmato di bitume e pece, '
          'nascosto tra le canne del Nilo (Esodo 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['barca', 'grotta', 'palazzo'],
    ),
    QuizQuestion(
      text: 'Come apparve Geova a Mosè sul monte Oreb?',
      options: <String>[
        'Un roveto in fiamme che non si consuma',
        'Una colonna di nuvola',
        'Un angelo visibile',
        'Un terremoto',
      ],
      correctIndex: 0,
      explanation: 'Dio parla a Mosè da un roveto ardente (Esodo 3).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale festa istituisce Dio prima di far uscire Israele '
          'dall’Egitto?',
      options: <String>[
        'La Pasqua',
        'La Pentecoste',
        'Le Capanne',
        'Il Sabato',
      ],
      correctIndex: 0,
      explanation:
          'La Pasqua commemora la protezione degli israeliti durante '
          'l’ultima piaga (Esodo 12).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Pasqua'],
    ),
    QuizQuestion(
      text: 'Come aprì Dio un passaggio per Israele?',
      options: <String>[
        'Separando le acque del Mar Rosso',
        'Prosciugando il Giordano',
        'Scavando un tunnel',
        'Inviando un ponte di pietra',
      ],
      correctIndex: 0,
      explanation: 'Il Mar Rosso si separa per far passare Israele (Esodo 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['nube', 'vento', 'Egitto'],
    ),
    QuizQuestion(
      text: 'Quale cibo fece scendere Dio dal cielo nel deserto?',
      options: <String>['La manna', 'Pane d’orzo', 'Fichi', 'Miele'],
      correctIndex: 0,
      explanation: 'La manna appare ogni mattina (Esodo 16).',
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Chi consigliò a Mosè di delegare la risoluzione delle '
          'controversie?',
      options: <String>['Ietro, suo suocero', 'Aaronne', 'Giosuè', 'Miriam'],
      correctIndex: 0,
      explanation:
          'Ietro suggerisce di nominare dei capi per giudicare gli affari '
          'correnti (Esodo 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Ietro'],
    ),
    QuizQuestion(
      text: 'Dove diede Geova i Dieci Comandamenti?',
      options: <String>[
        'Sul monte Sinai',
        'Sul monte Nebo',
        'A Cades',
        'A Betel',
      ],
      correctIndex: 0,
      explanation: 'La legge viene data sul monte Sinai (Esodo 19-20).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Oreb', 'Nebo', 'Carmelo'],
    ),
    QuizQuestion(
      text: 'Quale comandamento vieta di desiderare i beni altrui?',
      options: <String>[
        'Il decimo ("Non desidererai")',
        'Il primo',
        'Il quinto',
        'Il settimo',
      ],
      correctIndex: 0,
      explanation: 'Il decimo comandamento vieta la cupidigia (Esodo 20:17).',
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Cosa bisognava costruire secondo le istruzioni divine date a '
          'Mosè?',
      options: <String>[
        'Il tabernacolo',
        'Un palazzo',
        'Un muro',
        'Un tempio in pietra',
      ],
      correctIndex: 0,
      explanation:
          'Dio dà istruzioni dettagliate per il tabernacolo (Esodo 25).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['tabernacolo'],
    ),
    QuizQuestion(
      text: 'Cosa fabbricò il popolo durante l’assenza di Mosè sul monte?',
      options: <String>[
        'Un vitello d’oro',
        'Una statua di pietra',
        'Un altare di legno',
        'Un tempio',
      ],
      correctIndex: 0,
      explanation: 'Il popolo modella un vitello d’oro e lo adora (Esodo 32).',
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Cosa copriva il tabernacolo una volta terminato, segno della '
          'presenza di Dio?',
      options: <String>[
        'Una nuvola',
        'Un fuoco visibile in pieno giorno',
        'Un arcobaleno',
        'Una stella',
      ],
      correctIndex: 0,
      explanation:
          'La nuvola copre la tenda di adunanza e la gloria di Geova '
          'la riempie (Esodo 40).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['nuvola', 'nube'],
    ),
    QuizQuestion(
      text:
          'Chi alla fine tagliò nuove tavole di pietra dopo che Mosè '
          'aveva spezzato le prime?',
      options: <String>[
        'Mosè, per ordine di Dio',
        'Aaronne',
        'Giosuè',
        'Besalel',
      ],
      correctIndex: 0,
      explanation:
          'Dio ordina a Mosè di tagliare due nuove tavole '
          '(Esodo 34).',
    ),
  ],
  'Leviticus#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale tipo di sacrificio veniva bruciato interamente '
          'sull’altare?',
      options: <String>[
        'L’olocausto',
        'L’offerta di comunione',
        'L’offerta di cereali',
        'L’offerta per il peccato',
      ],
      correctIndex: 0,
      explanation:
          'L’olocausto viene consumato interamente sull’altare '
          '(Levitico 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['olocausto'],
    ),
    QuizQuestion(
      text:
          'Quanti tipi principali di offerte sono descritti in questi '
          'primi capitoli?',
      options: <String>['Cinque', 'Due', 'Dieci', 'Tre'],
      correctIndex: 0,
      explanation:
          'Olocausto, offerta di cereali, di comunione, per il '
          'peccato e di colpa (Levitico 1-7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['5'],
    ),
    QuizQuestion(
      text:
          'Chi doveva portare le offerte all’ingresso della tenda di '
          'adunanza?',
      options: <String>[
        'La persona stessa, con l’aiuto dei sacerdoti',
        'Solo i sacerdoti',
        'Solo gli anziani',
        'Un inviato del re',
      ],
      correctIndex: 0,
      explanation:
          'Chi offre porta personalmente il proprio animale, i sacerdoti '
          'officiano (Levitico 1-7).',
    ),
  ],
  'Leviticus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Perché morirono Nadab e Abiu?',
      options: <String>[
        'Offrirono un fuoco non autorizzato davanti a Geova',
        'Disubbidirono a Mosè',
        'Mangiarono un cibo impuro',
        'Rifiutarono di servire',
      ],
      correctIndex: 0,
      explanation:
          'I figli di Aaronne offrono un "fuoco estraneo" e muoiono '
          '(Levitico 10).',
    ),
    QuizQuestion(
      text: 'Quale criterio rendeva un animale terrestre puro da mangiare?',
      options: <String>[
        'Zoccolo diviso e ruminazione',
        'Vivere solo nel deserto',
        'Essere addomesticato',
        'Avere le piume',
      ],
      correctIndex: 0,
      explanation:
          'Gli animali puri ruminano e hanno lo zoccolo diviso '
          '(Levitico 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['squame', 'pinne', 'sangue'],
    ),
    QuizQuestion(
      text:
          'Quale malattia dovevano esaminare in dettaglio i '
          'sacerdoti in questi capitoli?',
      options: <String>['La lebbra', 'Il vaiolo', 'Solo le ustioni', 'L’acne'],
      correctIndex: 0,
      explanation:
          'I sacerdoti esaminano i segni di lebbra sulla pelle, i '
          'vestiti e le case (Levitico 13-14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['lebbra'],
    ),
  ],
  'Leviticus#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Una volta all’anno, in quale giorno solenne venivano '
          'coperti i peccati della nazione?',
      options: <String>[
        'Il giorno di espiazione (Yom Kippur)',
        'La Pasqua',
        'Il Sabato',
        'La Pentecoste',
      ],
      correctIndex: 0,
      explanation:
          'Il sommo sacerdote fa espiazione per la nazione una volta '
          'all’anno (Levitico 16).',
    ),
    QuizQuestion(
      text: 'Quale comandamento ben noto si trova in Levitico 19?',
      options: <String>[
        'Ama il tuo prossimo come te stesso',
        'Non rubare il bestiame',
        'Riposati per sette anni',
        'Onora il re',
      ],
      correctIndex: 0,
      explanation: 'Levitico 19:18 verrà citato in seguito da Gesù stesso.',
    ),
    QuizQuestion(
      text: 'Cosa bisognava evitare secondo Levitico 17 riguardo al cibo?',
      options: <String>[
        'Consumare sangue',
        'Mangiare di notte',
        'Mangiare da soli',
        'Mangiare pane',
      ],
      correctIndex: 0,
      explanation: 'Il consumo di sangue è vietato (Levitico 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['sangue', 'mangiare sangue'],
    ),
  ],
  'Leviticus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Quali feste annuali sono elencate in Levitico 23?',
      options: <String>[
        'Pasqua, Pentecoste, Trombe, Espiazione, Capanne',
        'Solo la Pasqua',
        'Il Capodanno e nient’altro',
        'Solo digiuni',
      ],
      correctIndex: 0,
      explanation:
          'Il calendario delle feste copre tutto l’anno religioso '
          '(Levitico 23).',
    ),
    QuizQuestion(
      text: 'Cosa bisognava fare ogni 50 anni, in occasione del Giubileo?',
      options: <String>[
        'Restituire le terre e liberare gli schiavi ebrei',
        'Distruggere i raccolti',
        'Eleggere un nuovo sommo sacerdote',
        'Rivedere la legge',
      ],
      correctIndex: 0,
      explanation:
          'L’anno del Giubileo restituisce le terre e le libertà '
          '(Levitico 25).',
    ),
    QuizQuestion(
      text: 'Cosa promette Levitico 26 in caso di fedeltà all’alleanza?',
      options: <String>[
        'Benedizioni; la disubbidienza porta sventure',
        'Nulla in particolare',
        'Ricchezza immediata senza condizioni',
        'La guerra sistematica',
      ],
      correctIndex: 0,
      explanation:
          'Benedizioni e maledizioni condizionali sono descritte in '
          'dettaglio (Levitico 26).',
    ),
  ],
  'Numbers#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Perché Israele fece un censimento nel deserto del Sinai?',
      options: <String>[
        'Per contare gli uomini abili alla guerra',
        'Per tassare ogni famiglia',
        'Per scegliere un re',
        'Per ripartire le terre',
      ],
      correctIndex: 0,
      explanation:
          'Il censimento conta gli uomini dai 20 anni in su abili a '
          'combattere (Numeri 1).',
    ),
    QuizQuestion(
      text:
          'Chi era incaricato del trasporto e del servizio del '
          'tabernacolo?',
      options: <String>[
        'I leviti',
        'Solo i sacerdoti',
        'Gli anziani',
        'I guerrieri',
      ],
      correctIndex: 0,
      explanation:
          'I leviti ricevono compiti precisi per il tabernacolo '
          '(Numeri 3-4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['leviti'],
    ),
    QuizQuestion(
      text:
          'Cosa doveva fare una persona che aveva fatto il voto di '
          'nazireato?',
      options: <String>[
        'Astenersi dal vino e non tagliarsi i capelli',
        'Digiunare 40 giorni',
        'Vivere da sola nel deserto',
        'Offrire tutto il proprio bestiame',
      ],
      correctIndex: 0,
      explanation:
          'Il voto di nazireato impone restrizioni particolari '
          '(Numeri 6).',
    ),
  ],
  'Numbers#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi incaricò Dio di aiutare Mosè a portare il peso del popolo?',
      options: <String>[
        '70 anziani',
        'I 12 esploratori',
        'Solo Aaronne',
        'Solo Giosuè',
      ],
      correctIndex: 0,
      explanation:
          '70 anziani ricevono lo spirito per condividere la '
          'responsabilità (Numeri 11).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['settanta anziani', '70'],
    ),
    QuizQuestion(
      text: 'Cosa accadde dopo che Miriam e Aaronne criticarono Mosè?',
      options: <String>[
        'Miriam fu colpita dalla lebbra',
        'Furono banditi definitivamente',
        'Non accadde loro nulla',
        'Persero la voce',
      ],
      correctIndex: 0,
      explanation: 'Miriam diventa lebbrosa per sette giorni (Numeri 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aaronne', 'Mosè', 'nube'],
    ),
    QuizQuestion(
      text:
          'Quanti esploratori diedero un rapporto incoraggiante su '
          'Canaan?',
      options: <String>['Due (Giosuè e Caleb)', 'Dodici', 'Nessuno', 'Cinque'],
      correctIndex: 0,
      explanation:
          'Solo Giosuè e Caleb incoraggiano il popolo a entrare '
          '(Numeri 13-14).',
    ),
  ],
  'Numbers#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi si ribellò contro l’autorità di Mosè e Aaronne?',
      options: <String>['Core e i suoi seguaci', 'Giosuè', 'Caleb', 'Balaam'],
      correctIndex: 0,
      explanation:
          'La ribellione di Core viene inghiottita dalla terra '
          '(Numeri 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aaronne', 'Mosè', 'bastone'],
    ),
    QuizQuestion(
      text:
          'Quale segno confermò la scelta di Aaronne come sommo '
          'sacerdote?',
      options: <String>[
        'Il suo bastone fiorì',
        'Una voce dal cielo',
        'Un fuoco sull’altare',
        'Una stella',
      ],
      correctIndex: 0,
      explanation: 'Il bastone di Aaronne germoglia e fiorisce (Numeri 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['mandorlo', 'tenda', 'fuoco'],
    ),
    QuizQuestion(
      text: 'Perché Mosè non poté entrare nella Terra promessa?',
      options: <String>[
        'Colpì la roccia invece di parlarle',
        'Disubbidì a un ordine di guerra',
        'Adorò un idolo',
        'Era troppo anziano',
      ],
      correctIndex: 0,
      explanation:
          'Mosè colpisce la roccia per rabbia, senza rispettare la '
          'santità di Dio (Numeri 20).',
    ),
  ],
  'Numbers#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi assunse Balac per maledire Israele?',
      options: <String>['Balaam', 'Core', 'Og', 'Sicon'],
      correctIndex: 0,
      explanation:
          'Balaam viene chiamato a maledire Israele ma lo benedice '
          '(Numeri 23-24).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Chi agì con zelo per fermare il flagello durante '
          'l’apostasia di Baal-Peor?',
      options: <String>['Fineas', 'Giosuè', 'Solo Eleazaro', 'Caleb'],
      correctIndex: 0,
      explanation: 'Fineas interviene e il flagello si ferma (Numeri 25).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Chi designò Geova come successore di Mosè?',
      options: <String>['Giosuè', 'Caleb', 'Eleazaro', 'Fineas'],
      correctIndex: 0,
      explanation:
          'Giosuè viene stabilito davanti a Eleazaro e all’assemblea '
          '(Numeri 27).',
    ),
  ],
  'Numbers#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Contro quale popolo Israele condusse una guerra di giudizio?',
      options: <String>['Madian', 'Edom', 'Tutto Moab', 'Egitto'],
      correctIndex: 0,
      explanation: 'Viene narrata la guerra contro Madian (Numeri 31).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['madianiti', 'i madianiti'],
    ),
    QuizQuestion(
      text: 'Quali tribù si stabilirono a est del Giordano?',
      options: <String>[
        'Ruben, Gad e metà di Manasse',
        'Giuda e Beniamino',
        'Levi e Simeone',
        'Solo Efraim',
      ],
      correctIndex: 0,
      explanation:
          'Queste tribù ottengono terre a est, a condizione di aiutare '
          'nella conquista (Numeri 32).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Giuda', 'Efraim', 'Beniamino'],
    ),
    QuizQuestion(
      text: 'Cosa dovevano essere le città di rifugio?',
      options: <String>[
        'Luoghi dove fuggire in caso di omicidio involontario',
        'Capitali regionali',
        'Centri commerciali',
        'Solo luoghi di culto',
      ],
      correctIndex: 0,
      explanation:
          'Le città di rifugio proteggono chi ha ucciso senza '
          'intenzione (Numeri 35).',
    ),
  ],
  'Deuteronomy#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale grande comandamento ripete Mosè in Deuteronomio 6, '
          'chiamato lo Shemà?',
      options: <String>[
        'Geova è uno, amalo con tutto il tuo cuore',
        'Non mangiare carne di maiale',
        'Celebra ogni novilunio',
        'Non lavorare mai',
      ],
      correctIndex: 0,
      explanation:
          'Lo Shemà (Deuteronomio 6:4, 5) è centrale nella fede '
          'd’Israele.',
    ),
    QuizQuestion(
      text:
          'Cosa ricorda Mosè riguardo ai dieci comandamenti in questi '
          'capitoli?',
      options: <String>[
        'Li ripete al popolo prima dell’ingresso in Canaan',
        'Li annulla',
        'Ne aggiunge altri dieci',
        'Li riserva ai sacerdoti',
      ],
      correctIndex: 0,
      explanation: 'Mosè ripropone i dieci comandamenti (Deuteronomio 5).',
    ),
    QuizQuestion(
      text: 'Perché Israele doveva diffidare delle nazioni di Canaan?',
      options: <String>[
        'A causa del rischio di idolatria',
        'A causa della loro ricchezza',
        'A causa della loro lingua',
        'A causa del loro re',
      ],
      correctIndex: 0,
      explanation:
          'Viene sottolineato il pericolo di adottare i loro dèi '
          '(Deuteronomio 7).',
    ),
  ],
  'Deuteronomy#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Cosa doveva ricordare a Israele il ricordo della manna nel '
          'deserto?',
      options: <String>[
        'Che l’uomo non vive di solo pane, ma di ogni parola che '
            'esce dalla bocca di Geova',
        'Che Dio punisce sempre',
        'Che il deserto è maledetto',
        'Che il cibo non ha importanza',
      ],
      correctIndex: 0,
      explanation: 'Deuteronomio 8:3, citato in seguito da Gesù.',
    ),
    QuizQuestion(
      text:
          'Quale evento del deserto ricorda Mosè per mettere in guardia '
          'contro l’orgoglio?',
      options: <String>[
        'Il vitello d’oro',
        'L’attraversamento del Mar Rosso',
        'Il dono della manna',
        'La costruzione del tabernacolo',
      ],
      correctIndex: 0,
      explanation:
          'Il vitello d’oro illustra la ribellione passata '
          '(Deuteronomio 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['manna', 'serpente', 'arca'],
    ),
    QuizQuestion(
      text:
          'Dove dovevano portare i loro sacrifici gli israeliti, secondo '
          'Deuteronomio 12?',
      options: <String>[
        'Nell’unico luogo che Geova avrebbe scelto',
        'Dove desideravano',
        'In ogni villaggio',
        'Solo a casa propria',
      ],
      correctIndex: 0,
      explanation:
          'Viene prescritto un unico luogo di culto (Deuteronomio 12).',
    ),
  ],
  'Deuteronomy#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa bisognava fare dei debiti ogni sette anni?',
      options: <String>[
        'Annullarli (anno di remissione)',
        'Raddoppiarli',
        'Trasferirli ai figli',
        'Nulla di speciale',
      ],
      correctIndex: 0,
      explanation: 'L’anno di remissione cancella i debiti (Deuteronomio 15).',
    ),
    QuizQuestion(
      text: 'Cosa annuncia Deuteronomio 18 riguardo a un futuro profeta?',
      options: <String>[
        'Che Geova ne avrebbe suscitato uno simile a Mosè',
        'Un re straniero',
        'Un angelo',
        'Un unico giudice',
      ],
      correctIndex: 0,
      explanation:
          'Questa profezia viene applicata al Cristo nelle Scritture '
          'Greche (Deuteronomio 18).',
    ),
    QuizQuestion(
      text: 'Quanti testimoni erano necessari per stabilire un’accusa?',
      options: <String>[
        'Due o tre',
        'Ne bastava uno solo',
        'Dieci',
        'Non ne serviva nessuno',
      ],
      correctIndex: 0,
      explanation: 'La legge richiede più testimoni (Deuteronomio 19).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['2 o 3'],
    ),
  ],
  'Deuteronomy#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale offerta annuale ricordava la liberazione dall’Egitto?',
      options: <String>[
        'L’offerta delle primizie',
        'Il sacrificio del Giubileo',
        'Solo l’offerta della decima',
        'Il pasto commemorativo',
      ],
      correctIndex: 0,
      explanation:
          'La dichiarazione delle primizie ricorda l’uscita dall’Egitto '
          '(Deuteronomio 26).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sacrificio', 'decima', 'olocausto'],
    ),
    QuizQuestion(
      text:
          'Cosa dovevano fare gli israeliti entrando a Canaan, sul '
          'monte Ebal?',
      options: <String>[
        'Erigere un altare e proclamare benedizioni e maledizioni',
        'Costruire un palazzo',
        'Stabilire la capitale',
        'Distruggere tutti gli alberi',
      ],
      correctIndex: 0,
      explanation:
          'Viene istituita la cerimonia sui monti Garizim/Ebal '
          '(Deuteronomio 27).',
    ),
    QuizQuestion(
      text:
          'Quale principio regolava le leggi sul divorzio in questi '
          'capitoli?',
      options: <String>[
        'Era richiesto un atto di divorzio scritto',
        'Il divorzio era vietato in ogni forma',
        'Solo la donna poteva divorziare',
        'Non esisteva alcuna regola',
      ],
      correctIndex: 0,
      explanation:
          'La legge regolamenta il divorzio tramite un documento '
          'formale (Deuteronomio 24).',
    ),
  ],
  'Deuteronomy#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa promette il capitolo 28 in caso di fedeltà all’alleanza?',
      options: <String>[
        'Benedizioni; la disubbidienza porta maledizioni',
        'Nulla di concreto',
        'Una guerra immediata',
        'La ricchezza senza condizioni',
      ],
      correctIndex: 0,
      explanation:
          'Benedizioni e maledizioni sono descritte in dettaglio '
          '(Deuteronomio 28).',
    ),
    QuizQuestion(
      text: 'Quale scelta presenta Mosè al popolo in Deuteronomio 30?',
      options: <String>[
        'La vita e la morte, la benedizione e la maledizione',
        'Restare o tornare in Egitto',
        'Servire Aaronne o Giosuè',
        'Pagare o meno una tassa',
      ],
      correctIndex: 0,
      explanation:
          'Il popolo è invitato a "scegliere la vita" '
          '(Deuteronomio 30:19).',
    ),
    QuizQuestion(
      text: 'Dove morì Mosè, senza entrare nella Terra promessa?',
      options: <String>[
        'Sul monte Nebo',
        'A Gerico',
        'Sul monte Sinai',
        'A Betlemme',
      ],
      correctIndex: 0,
      explanation:
          'Mosè contempla il paese dalla cima del Nebo prima di morire '
          '(Deuteronomio 34).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sinai', 'Oreb', 'Carmelo'],
    ),
  ],
  'Joshua#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale istruzione ripete Geova a Giosuè all’inizio del libro?',
      options: <String>[
        'Sii forte e coraggioso',
        'Resta nascosto',
        'Aspetta dieci anni',
        'Torna in Egitto',
      ],
      correctIndex: 0,
      explanation: 'Geova incoraggia Giosuè più volte (Giosuè 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Giosuè', 'legge', 'paura'],
    ),
    QuizQuestion(
      text: 'Chi nascose gli esploratori israeliti a Gerico?',
      options: <String>['Raab', 'Una profetessa', 'Il re stesso', 'Nessuno'],
      correctIndex: 0,
      explanation: 'Raab nasconde gli esploratori sul suo tetto (Giosuè 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Come caddero le mura di Gerico?',
      options: <String>[
        'Dopo una processione e il suono delle trombe',
        'Per un terremoto naturale',
        'Per un assedio di diversi mesi',
        'Per il tradimento di un abitante',
      ],
      correctIndex: 0,
      explanation:
          'Dopo sette giri e il suono delle trombe, le mura '
          'cadono (Giosuè 6).',
    ),
  ],
  'Joshua#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Come evitarono la distruzione i gabaoniti?',
      options: <String>[
        'Facendosi passare per viaggiatori venuti da lontano',
        'Attaccando per primi',
        'Pagando subito un tributo',
        'Convertendosi pubblicamente',
      ],
      correctIndex: 0,
      explanation:
          'Il loro inganno spinge Israele a concludere un trattato di '
          'pace (Giosuè 9).',
    ),
    QuizQuestion(
      text:
          'Cosa accadde di straordinario durante la battaglia contro i '
          'cinque re amorrei?',
      options: <String>[
        'Il sole si fermò',
        'Un’eclissi totale',
        'Una pioggia di fuoco',
        'Un terremoto li separò',
      ],
      correctIndex: 0,
      explanation:
          'Geova combatte per Israele e il sole si ferma '
          '(Giosuè 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['luna', 'grandine', 'notte'],
    ),
    QuizQuestion(
      text: 'Quale porzione di terra reclamò Caleb a 85 anni?',
      options: <String>['Ebron', 'Gerico', 'Silo', 'Betel'],
      correctIndex: 0,
      explanation: 'Caleb rimane fedele e riceve Ebron (Giosuè 14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Joshua#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Dove fu eretto il tabernacolo dopo la conquista iniziale?',
      options: <String>['A Silo', 'A Gerusalemme', 'A Ebron', 'A Betel'],
      correctIndex: 0,
      explanation: 'La tenda di adunanza viene stabilita a Silo (Giosuè 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Silo'],
    ),
    QuizQuestion(
      text:
          'Perché le tribù orientali eressero un altare vicino al '
          'Giordano?',
      options: <String>[
        'Come testimonianza della loro appartenenza a Israele',
        'Per dichiarare la loro indipendenza',
        'Per adorare un altro dio',
        'Per ordine di un re straniero',
      ],
      correctIndex: 0,
      explanation:
          'L’altare è una testimonianza, non un luogo di sacrificio '
          'rivale (Giosuè 22).',
    ),
    QuizQuestion(
      text:
          'Quale dichiarazione celebre fa Giosuè a Sichem prima di '
          'morire?',
      options: <String>[
        'Io e la mia casa serviremo Geova',
        'Torniamo in Egitto',
        'Un re ci governerà',
        'La guerra continuerà per sempre',
      ],
      correctIndex: 0,
      explanation:
          'Giosuè invita il popolo a scegliere chi servire (Giosuè 24).',
    ),
  ],
  'Judges#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale ciclo si ripete lungo tutto il libro dei Giudici?',
      options: <String>[
        'Infedeltà, oppressione, invocazione a Dio, liberazione',
        'Pace perpetua',
        'Guerra civile continua',
        'Migrazione costante',
      ],
      correctIndex: 0,
      explanation: 'Questo ciclo struttura tutto il libro (Giudici 2).',
    ),
    QuizQuestion(
      text:
          'Chi guidò l’esercito d’Israele contro Sisera, con l’aiuto di '
          'Debora?',
      options: <String>['Barac', 'Eud', 'Otniel', 'Gedeone'],
      correctIndex: 0,
      explanation: 'Debora e Barac guidano Israele alla vittoria (Giudici 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Come ridusse Gedeone il suo esercito a 300 uomini?',
      options: <String>[
        'Osservando come bevevano l’acqua',
        'Tirando a sorte',
        'Scegliendo i più giovani',
        'Scegliendo i più ricchi',
      ],
      correctIndex: 0,
      explanation: 'La prova dell’acqua seleziona 300 uomini (Giudici 7).',
    ),
  ],
  'Judges#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Come finì il regno di Abimelec?',
      options: <String>[
        'Perì, colpito da una macina lanciata da una donna',
        'Regnò in pace a lungo',
        'Fu cacciato senza violenza',
        'Fondò una dinastia duratura',
      ],
      correctIndex: 0,
      explanation:
          'Abimelec muore colpito da una macina lanciata da una donna '
          '(Giudici 9).',
    ),
    QuizQuestion(
      text: 'Quale voto tragico fece Iefte prima della battaglia?',
      options: <String>[
        'Offrire la prima persona che fosse uscita di casa sua',
        'Digiunare per un anno',
        'Distruggere la propria casa',
        'Non sposarsi mai',
      ],
      correctIndex: 0,
      explanation: 'Sua figlia esce per prima ad accoglierlo (Giudici 11).',
    ),
    QuizQuestion(
      text:
          'Come si riconoscevano gli efraimiti al passaggio del '
          'Giordano?',
      options: <String>[
        'Non riuscivano a pronunciare correttamente "Sibbolet"',
        'Dai loro vestiti',
        'Dal loro accento cantilenante',
        'Dalle loro armi',
      ],
      correctIndex: 0,
      explanation: 'La parola d’ordine smaschera i fuggitivi (Giudici 12).',
    ),
  ],
  'Judges#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Con quale arma improvvisata Sansone sconfisse mille filistei?',
      options: <String>[
        'Una mascella d’asino',
        'Una spada',
        'Una fionda',
        'Un bastone',
      ],
      correctIndex: 0,
      explanation: 'Sansone colpisce con una mascella d’asino (Giudici 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['spada', 'fionda', 'bastone'],
    ),
    QuizQuestion(
      text: 'Chi rivelò ai filistei il segreto della forza di Sansone?',
      options: <String>[
        'Dalila',
        'Sua madre',
        'Un giudice rivale',
        'Un sacerdote',
      ],
      correctIndex: 0,
      explanation:
          'Dalila scopre che la sua forza viene dai suoi capelli '
          '(Giudici 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Quale frase riassume la condizione di Israele alla fine del '
          'libro?',
      options: <String>[
        'Ognuno faceva ciò che era giusto ai propri occhi',
        'Regnava un re giusto',
        'La pace regnava ovunque',
        'I sacerdoti governavano bene',
      ],
      correctIndex: 0,
      explanation:
          'Questa osservazione conclude diversi racconti del libro '
          '(Giudici 17, 21).',
    ),
  ],
  'Ruth#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Perché Naomi e la sua famiglia partirono per Moab?',
      options: <String>[
        'A causa di una carestia a Betlemme',
        'Per fuggire da una guerra',
        'Per affari',
        'Per ordine di un giudice',
      ],
      correctIndex: 0,
      explanation: 'La carestia spinge Elimelec a emigrare (Rut 1).',
    ),
    QuizQuestion(
      text: 'Quale decisione prende Rut nei confronti di Naomi?',
      options: <String>[
        'Restare con lei: "dove andrai tu, andrò io"',
        'Tornare dal proprio popolo',
        'Risposarsi subito a Moab',
        'Restare sola a Moab',
      ],
      correctIndex: 0,
      explanation: 'Rut esprime un celebre attaccamento leale (Rut 1:16).',
    ),
    QuizQuestion(
      text: 'Cosa accadde ai mariti di Naomi e delle sue nuore?',
      options: <String>[
        'Morirono tutti a Moab',
        'Tornarono a Betlemme',
        'Prosperarono a Moab',
        'Fondarono una città',
      ],
      correctIndex: 0,
      explanation: 'Elimelec, e poi i suoi due figli, muoiono a Moab (Rut 1).',
    ),
  ],
  'Ruth#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa faceva Rut nei campi di Boaz?',
      options: <String>[
        'Spigolava le spighe lasciate dai mietitori',
        'Vendeva tessuti',
        'Custodiva le greggi',
        'Insegnava la legge',
      ],
      correctIndex: 0,
      explanation: 'Rut spigola per nutrire Naomi e se stessa (Rut 2).',
    ),
    QuizQuestion(
      text: 'Come mostrò Boaz bontà verso Rut?',
      options: <String>[
        'Permettendole di spigolare in sicurezza e condividendo il '
            'suo pasto',
        'Ignorandola educatamente',
        'Cacciandola dal campo',
        'Esigendo un pagamento',
      ],
      correctIndex: 0,
      explanation: 'Boaz protegge Rut e la tratta con favore (Rut 2).',
    ),
    QuizQuestion(
      text: 'Cosa consiglia Naomi a Rut riguardo a Boaz?',
      options: <String>[
        'Di andare all’aia e farsi riconoscere da lui',
        'Di evitarlo completamente',
        'Di partire per Moab',
        'Di sposare un altro uomo',
      ],
      correctIndex: 0,
      explanation: 'Naomi guida Rut verso un possibile riscatto (Rut 3).',
    ),
  ],
  'Ruth#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Come risolse Boaz la questione del diritto di riscatto '
          'davanti agli anziani?',
      options: <String>[
        'Un parente più prossimo rinunciò pubblicamente al suo diritto',
        'Decise un’estrazione a sorte',
        'Decise il re',
        'Nessuno fu consultato',
      ],
      correctIndex: 0,
      explanation:
          'La procedura legale si svolge alla porta della città '
          '(Rut 4).',
    ),
    QuizQuestion(
      text: 'Chi ebbero come figlio Rut e Boaz?',
      options: <String>['Obed', 'Davide', 'Iesse', 'Salomone'],
      correctIndex: 0,
      explanation: 'Obed diventa il nonno di Davide (Rut 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Perché il libro di Rut termina con una genealogia?',
      options: <String>[
        'Per collegare Rut alla linea che porta a Davide',
        'Per semplice tradizione letteraria',
        'Per chiudere una disputa legale',
        'Per onorare Moab',
      ],
      correctIndex: 0,
      explanation: 'La genealogia collega Rut a Davide (Rut 4:17-22).',
    ),
  ],
};

const Map<String, List<QuizQuestion>>
extraQuizzesItC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale albero del giardino di Eden era proibito ad Adamo '
          'ed Eva?',
      options: <String>[
        'L’albero della conoscenza del bene e del male',
        'L’albero della vita',
        'Un fico',
        'Un ulivo',
      ],
      correctIndex: 0,
      explanation: 'Dio proibisce solo questo albero (Genesi 2:17).',
    ),
    QuizQuestion(
      text: 'Chi ingannò Eva affinché mangiasse il frutto proibito?',
      options: <String>['Il serpente', 'Caino', 'Un angelo', 'Adamo'],
      correctIndex: 0,
      explanation: 'Il serpente la spinge a disubbidire (Genesi 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['serpente'],
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale uccello, mandato da Noè, tornò con una foglia d’ulivo?',
      options: <String>['La colomba', 'Il corvo', 'L’aquila', 'Il passero'],
      correctIndex: 0,
      explanation:
          'La colomba mostra che le acque si stavano ritirando (Genesi 8).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['colomba'],
    ),
    QuizQuestion(
      text:
          'Chi, re di Salem e sacerdote del Dio Altissimo, benedisse '
          'Abramo?',
      options: <String>['Melchisedec', 'Lot', 'Il faraone', 'Isacco'],
      correctIndex: 0,
      explanation: 'Melchisedec benedice Abramo dopo una vittoria (Genesi 14).',
    ),
  ],
  'Genesis#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale segno dell’alleanza diede Dio ad Abramo?',
      options: <String>[
        'La circoncisione',
        'Un tatuaggio',
        'Un anello',
        'Un bastone',
      ],
      correctIndex: 0,
      explanation: 'La circoncisione segna l’alleanza (Genesi 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['circoncisione'],
    ),
    QuizQuestion(
      text: 'Come si chiamava il figlio di Abramo e Agar?',
      options: <String>['Ismaele', 'Isacco', 'Esaù', 'Giacobbe'],
      correctIndex: 0,
      explanation: 'Ismaele nasce da Agar, la serva (Genesi 16).',
    ),
    QuizQuestion(
      text: 'Quali città distrusse Dio a causa della loro malvagità?',
      options: <String>[
        'Sodoma e Gomorra',
        'Babele e Ur',
        'Ninive e Tiro',
        'Betel e Ai',
      ],
      correctIndex: 0,
      explanation:
          'Il fuoco distrugge queste città; Lot viene salvato (Genesi 19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Ur', 'Babele', 'Gerico'],
    ),
  ],
  'Genesis#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa chiese Dio ad Abramo di offrire sul monte Moria?',
      options: <String>[
        'Suo figlio Isacco',
        'Un montone',
        'La sua tenda',
        'Il suo bestiame',
      ],
      correctIndex: 0,
      explanation: 'Dio ferma Abramo e provvede un montone (Genesi 22).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Isacco'],
    ),
    QuizQuestion(
      text:
          'In cambio di cosa Esaù vendette la sua primogenitura a '
          'Giacobbe?',
      options: <String>[
        'Un piatto di lenticchie',
        'Oro',
        'Un gregge',
        'Una tenda',
      ],
      correctIndex: 0,
      explanation: 'Esaù disprezza la sua primogenitura (Genesi 25).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pane', 'pesce', 'vino'],
    ),
    QuizQuestion(
      text: 'Cosa vide Giacobbe in sogno a Betel?',
      options: <String>[
        'Una scala che raggiungeva il cielo con degli angeli',
        'Un mare in tempesta',
        'Un roveto in fiamme',
        'Una città in rovina',
      ],
      correctIndex: 0,
      explanation: 'Dio conferma le sue promesse a Giacobbe (Genesi 28).',
    ),
  ],
  'Genesis#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quale nuovo nome ricevette Giacobbe dopo aver lottato con '
          'l’angelo?',
      options: <String>['Israele', 'Edom', 'Abramo', 'Efraim'],
      correctIndex: 0,
      explanation:
          'Il nome Israele significa "egli lotta con Dio" (Genesi 32).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Quanti figli ebbe Giacobbe, antenati delle tribù d’Israele?',
      options: <String>['Dodici', 'Dieci', 'Sette', 'Quattordici'],
      correctIndex: 0,
      explanation:
          'I suoi dodici figli fondano le tribù d’Israele (Genesi 35).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['12'],
    ),
    QuizQuestion(
      text: 'Con chi si riconciliò Giacobbe dopo anni di separazione?',
      options: <String>['Suo fratello Esaù', 'Labano', 'Il faraone', 'Isacco'],
      correctIndex: 0,
      explanation: 'I due fratelli si ritrovano in pace (Genesi 33).',
    ),
  ],
  'Genesis#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa fecero i fratelli di Giuseppe per gelosia?',
      options: <String>[
        'Lo vendettero come schiavo',
        'Lo incoronarono re',
        'L’abbandonarono in Egitto',
        'L’ignorarono',
      ],
      correctIndex: 0,
      explanation: 'Giuseppe viene venduto e portato in Egitto (Genesi 37).',
    ),
    QuizQuestion(
      text: 'Quale indumento speciale aveva regalato Giacobbe a Giuseppe?',
      options: <String>[
        'Una bella tunica',
        'Una corona',
        'Un’armatura',
        'Un mantello sacerdotale',
      ],
      correctIndex: 0,
      explanation:
          'Questo regalo attizza la gelosia dei suoi fratelli (Genesi 37).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['mantello', 'sandali', 'cintura'],
    ),
    QuizQuestion(
      text:
          'Cosa interpretò Giuseppe per il faraone, annunciando sette '
          'anni di carestia?',
      options: <String>[
        'I sogni del faraone',
        'Un antico libro',
        'Le stelle',
        'Un oracolo',
      ],
      correctIndex: 0,
      explanation: 'Giuseppe interpreta i sogni del faraone (Genesi 41).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['sogni', 'i sogni', 'i suoi sogni'],
    ),
  ],
  'Genesis#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Come trattò Giuseppe i suoi fratelli una volta che si fece '
          'riconoscere?',
      options: <String>[
        'Li perdonò',
        'Li imprigionò a vita',
        'Li scacciò',
        'Li ignorò',
      ],
      correctIndex: 0,
      explanation: 'Giuseppe perdona e li nutre (Genesi 45).',
    ),
    QuizQuestion(
      text: 'Dove si stabilirono Giacobbe e la sua famiglia in Egitto?',
      options: <String>['Nel paese di Gòsen', 'A Menfi', 'A Tebe', 'Nel Sinai'],
      correctIndex: 0,
      explanation: 'Il faraone dà loro la regione di Gòsen (Genesi 47).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Egitto', 'Canaan', 'Nilo'],
    ),
    QuizQuestion(
      text:
          'Come vedeva Giuseppe il male che i suoi fratelli gli avevano '
          'fatto?',
      options: <String>[
        'Dio lo aveva volto in bene per salvare delle vite',
        'Come un’ingiustizia da vendicare',
        'Come qualcosa senza importanza',
        'Come un semplice incidente',
      ],
      correctIndex: 0,
      explanation: 'Una celebre dichiarazione di fede (Genesi 50:20).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Chi era il fratello di Mosè, designato come suo portavoce?',
      options: <String>['Aaronne', 'Giosuè', 'Ietro', 'Caleb'],
      correctIndex: 0,
      explanation: 'Aaronne parla al popolo per conto di Mosè (Esodo 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Con quale nome si presentò Geova a Mosè al roveto ardente?',
      options: <String>[
        '"Io sarò ciò che sarò"',
        '"Il Dio senza nome"',
        '"Il Dio nascosto"',
        '"Il re dei re"',
      ],
      correctIndex: 0,
      explanation: 'Dio rivela il significato del suo nome (Esodo 3:14).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Quale fu la decima e ultima piaga d’Egitto?',
      options: <String>[
        'La morte dei primogeniti',
        'Le locuste',
        'Le tenebre',
        'La grandine',
      ],
      correctIndex: 0,
      explanation:
          'Questa piaga convince il faraone a liberare Israele (Esodo 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['rane', 'locuste', 'sangue'],
    ),
    QuizQuestion(
      text:
          'Cosa dovevano mettere gli israeliti sulle loro porte durante '
          'la Pasqua?',
      options: <String>[
        'Sangue d’agnello',
        'Olio',
        'Farina',
        'Un segno di cenere',
      ],
      correctIndex: 0,
      explanation: 'Il sangue protegge i loro primogeniti (Esodo 12).',
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Come sgorgò l’acqua per il popolo assetato a Oreb?',
      options: <String>[
        'Mosè colpì la roccia',
        'Una sorgente apparve da sola',
        'Piovve abbondantemente',
        'Fu scavato un pozzo',
      ],
      correctIndex: 0,
      explanation: 'Per ordine di Dio, Mosè colpisce la roccia (Esodo 17).',
    ),
    QuizQuestion(
      text:
          'Da quanti comandamenti è composto il Decalogo dato sul '
          'Sinai?',
      options: <String>['Dieci', 'Sette', 'Dodici', 'Cinque'],
      correctIndex: 0,
      explanation: 'I Dieci Comandamenti sono dati sul Sinai (Esodo 20).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['10'],
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Cosa doveva contenere l’arca dell’alleanza?',
      options: <String>[
        'Le tavole della Legge',
        'Oro e argento',
        'Rotoli di profezie',
        'Offerte di cibo',
      ],
      correctIndex: 0,
      explanation:
          'Le tavole dei comandamenti vengono poste al suo interno '
          '(Esodo 25).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['manna', 'bastone', 'olio'],
    ),
    QuizQuestion(
      text: 'Chi fabbricò il vitello d’oro durante l’assenza di Mosè?',
      options: <String>['Aaronne', 'Giosuè', 'Ur', 'Besalel'],
      correctIndex: 0,
      explanation: 'Aaronne cede alla richiesta del popolo (Esodo 32).',
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Cosa caratterizzava il volto di Mosè dopo aver parlato con '
          'Dio?',
      options: <String>[
        'Era raggiante',
        'Era velato di tristezza',
        'Era invecchiato',
        'Nulla di particolare',
      ],
      correctIndex: 0,
      explanation: 'Mosè doveva velare il suo volto raggiante (Esodo 34).',
    ),
    QuizQuestion(
      text: 'Cosa riempì il tabernacolo una volta terminato?',
      options: <String>[
        'La gloria di Geova (una nuvola)',
        'Solo il fumo dell’incenso',
        'Una luce artificiale',
        'Nulla di visibile',
      ],
      correctIndex: 0,
      explanation: 'La nuvola segnala la presenza divina (Esodo 40).',
    ),
  ],
};
