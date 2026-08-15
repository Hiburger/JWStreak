import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesPlC2 = <String, List<QuizQuestion>>{
  '1 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Anna obiecała Jehowie, gdyby miała syna?',
      options: <String>[
        'Poświęcić go na służbę Bogu na całe życie',
        'Ofiarować mu połowę swego majątku',
        'Zbudować świątynię',
        'Zostać kapłanką',
      ],
      correctIndex: 0,
      explanation: 'Anna poświęca Samuela na służbę w przybytku (1 Samuela 1).',
    ),
    QuizQuestion(
      text: 'Jak Jehowa powołał młodego Samuela?',
      options: <String>[
        'Wymawiając jego imię nocą, kilka razy',
        'Za pomocą widzialnego anioła',
        'Poprzez pojedynczy sen',
        'Poprzez publiczny głos',
      ],
      correctIndex: 0,
      explanation: 'Samuel najpierw myśli, że wzywa go Heli (1 Samuela 3).',
    ),
    QuizQuestion(
      text: 'Dlaczego lud poprosił Samuela o króla?',
      options: <String>[
        'Aby być jak inne narody',
        'Na bezpośredni rozkaz Jehowy',
        'Z powodu nadciągającej inwazji',
        'Ponieważ zaproponował to Samuel',
      ],
      correctIndex: 0,
      explanation: 'Lud odrzuca bezpośrednie panowanie Boga (1 Samuela 8).',
    ),
  ],
  '1 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Kogo Samuel potajemnie namaścił na pierwszego króla Izraela?',
      options: <String>['Saula', 'Dawida', 'Jonatana', 'Abnera'],
      correctIndex: 0,
      explanation: 'Samuel namaszcza Saula w cztery oczy (1 Samuela 9-10).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Co Saul zrobił w Gilgal, nie czekając na Samuela?',
      options: <String>[
        'Sam złożył ofiarę',
        'Przegrał bitwę',
        'Odmówił panowania',
        'Uciekł przed wrogiem',
      ],
      correctIndex: 0,
      explanation:
          'Saul jest nieposłuszny, sam składając ofiarę (1 Samuela 13).',
    ),
    QuizQuestion(
      text:
          'Dlaczego Saul został ostatecznie odrzucony przez Jehowę jako król?',
      options: <String>[
        'Był nieposłuszny, oszczędzając Agaga i najlepsze bydło',
        'Przegrał niewielką bitwę',
        'Zbyt szybko się zestarzał',
        'Poprosił Samuela o pomoc',
      ],
      correctIndex: 0,
      explanation:
          'Jego nieposłuszeństwo w sprawie Amaleka przypieczętowuje jego odrzucenie (1 Samuela 15).',
    ),
  ],
  '1 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaką bronią Dawid pokonał Goliata?',
      options: <String>[
        'Procą i kamieniem',
        'Mieczem',
        'Włócznią',
        'Gołymi rękami',
      ],
      correctIndex: 0,
      explanation: 'Dawid odrzuca zbroję i używa procy (1 Samuela 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['miecz', 'tarcza', 'włócznia'],
    ),
    QuizQuestion(
      text:
          'Jakie uczucie skłoniło Saula, by chciał zabić Dawida po jego zwycięstwie?',
      options: <String>[
        'Zazdrość',
        'Strach przed Filistynami',
        'Gniew Samuela',
        'Rada Jonatana',
      ],
      correctIndex: 0,
      explanation:
          'Pieśni pochwalne na cześć Dawida budzą zazdrość Saula (1 Samuela 18).',
    ),
    QuizQuestion(
      text:
          'Kto pomógł Dawidowi uciec przed Saulem, ostrzegając go o niebezpieczeństwie?',
      options: <String>['Jonatan', 'Abner', 'Sam Samuel', 'Nieznany kapłan'],
      correctIndex: 0,
      explanation:
          'Jonatan ostrzega Dawida za pomocą umówionego sygnału (1 Samuela 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  '1 Samuel#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Co robi Dawid, gdy ma okazję zabić Saula w jaskini?',
      options: <String>[
        'Oszczędza go i odcina jedynie skraj jego szaty',
        'Zabija go natychmiast',
        'Ucieka, nic nie robiąc',
        'Negocjuje pokój',
      ],
      correctIndex: 0,
      explanation:
          'Dawid odmawia dotknięcia „pomazańca Jehowy” (1 Samuela 24).',
    ),
    QuizQuestion(
      text:
          'Kto swoją mądrością zapobiegł konfliktowi między Dawidem a Nabalem?',
      options: <String>['Abigail', 'Mikal', 'Służąca', 'Arcykapłan'],
      correctIndex: 0,
      explanation: 'Abigail uspokaja Dawida zapasami żywności (1 Samuela 25).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Gdzie giną Saul i Jonatan w ostatniej bitwie tej księgi?',
      options: <String>[
        'Na górze Gilboa, walcząc z Filistynami',
        'W Jerozolimie',
        'W Hebronie',
        'W Gibea',
      ],
      correctIndex: 0,
      explanation: 'Saul i jego synowie giną pod Gilboa (1 Samuela 31).',
    ),
  ],
  '2 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Dawid zareagował na śmierć Saula i Jonatana?',
      options: <String>[
        'Ułożył pieśń żałobną (lament)',
        'Ucieszył się',
        'Zignorował wiadomość',
        'Natychmiast zaatakował',
      ],
      correctIndex: 0,
      explanation: 'Dawid układa „Pieśń Łuku” (2 Samuela 1).',
    ),
    QuizQuestion(
      text: 'Które miasto zdobył Dawid, aby uczynić je swoją stolicą?',
      options: <String>['Jerozolimę', 'Hebron', 'Szilo', 'Gibea'],
      correctIndex: 0,
      explanation: 'Dawid zdobywa twierdzę Syjon (2 Samuela 5).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Jaką obietnicę Jehowa składa Dawidowi przez proroka Natana?',
      options: <String>[
        'Potomek będzie panował na zawsze',
        'Dawid sam zbuduje świątynię',
        'Dawid będzie żył wiecznie',
        'Dawid zostanie kapłanem',
      ],
      correctIndex: 0,
      explanation:
          'Przymierze z Dawidem obiecuje wieczną dynastię (2 Samuela 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['świątynia', 'tron', 'przymierze'],
    ),
  ],
  '2 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Z kim Dawid dopuścił się cudzołóstwa, co doprowadziło do zabójstwa Uriasza?',
      options: <String>['Z Batszebą', 'Z Mikal', 'Z Abigail', 'Z Tamar'],
      correctIndex: 0,
      explanation:
          'Dawid doprowadza do śmierci Uriasza, aby ukryć swój grzech (2 Samuela 11).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'W jaki sposób prorok Natan skonfrontował Dawida z jego grzechem?',
      options: <String>[
        'Za pomocą przypowieści o bogaczu i biedaku',
        'Publicznie go potępiając',
        'Za pomocą anonimowego listu',
        'Opuszczając jego służbę',
      ],
      correctIndex: 0,
      explanation:
          'Przypowieść skłania Dawida do przyznania się do winy (2 Samuela 12).',
    ),
    QuizQuestion(
      text:
          'Który syn Dawida kazał się ogłosić królem w Hebronie, '
          'buntując się przeciw niemu?',
      options: <String>['Absalom', 'Amnon', 'Salomon', 'Adoniasz'],
      correctIndex: 0,
      explanation: 'Rozpoczyna się bunt Absaloma (2 Samuela 15).',
      type: QuizAnswerType.freeText,
    ),
  ],
  '2 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Czyja rada udaremniła szybki plan Achitofela przeciwko Dawidowi?',
      options: <String>[
        'Rada Chuszaja, który pozostał wierny Dawidowi',
        'Rada Joaba',
        'Rada pewnego kapłana',
        'Rada Salomona',
      ],
      correctIndex: 0,
      explanation: 'Chuszaj opóźnia atak i ratuje Dawida (2 Samuela 17).',
    ),
    QuizQuestion(
      text: 'Jak zginął Absalom?',
      options: <String>[
        'Zawisł, gdy jego głowa utkwiła w drzewie, zabity przez Joaba',
        'W pojedynku z Dawidem',
        'Otruty',
        'Na wygnaniu, ze starości',
      ],
      correctIndex: 0,
      explanation:
          'Absalom zostaje zawieszony, a Joab przebija go włócznią (2 Samuela 18).',
    ),
    QuizQuestion(
      text: 'Jaki czyn Dawida sprowadził plagę na Izraela pod koniec księgi?',
      options: <String>[
        'Spis ludności',
        'Budowa pałacu',
        'Zakazane małżeństwo',
        'Odmowa złożenia ofiary',
      ],
      correctIndex: 0,
      explanation:
          'Spis nie podoba się Bogu, w wyniku czego następuje plaga (2 Samuela 24).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['plaga', 'ołtarz', 'Joab'],
    ),
  ],
  '1 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Który syn Dawida ogłosił się królem, gdy Dawid był już '
          'stary?',
      options: <String>['Adoniasz', 'Absalom', 'Sam Joab', 'Natan'],
      correctIndex: 0,
      explanation: 'Adoniasz ogłasza się królem bez zgody Dawida (1 Królów 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'O co Salomon prosi Jehowę na samym początku swojego panowania?',
      options: <String>[
        'O rozumne serce, by sądzić lud',
        'O bogactwo ponad wszystko',
        'O zwycięstwo wojskowe',
        'O długie życie, bez żadnych warunków',
      ],
      correctIndex: 0,
      explanation: 'Salomon prosi o mądrość, co podoba się Bogu (1 Królów 3).',
    ),
    QuizQuestion(
      text:
          'Kto pomógł Salomonowi w dostarczeniu materiałów do budowy świątyni?',
      options: <String>[
        'Hiram, król Tyru',
        'Faraon Egiptu',
        'Królowa Saby',
        'Król Moabu',
      ],
      correctIndex: 0,
      explanation:
          'Hiram dostarcza drewno cedrowe i rzemieślników (1 Królów 5).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Hiram'],
    ),
  ],
  '1 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co dzieje się, gdy świątynia zostaje ukończona i poświęcona?',
      options: <String>[
        'Chwała Jehowy wypełnia świątynię',
        'Następuje trzęsienie ziemi',
        'Lud się buntuje',
        'Salomon opuszcza Jerozolimę',
      ],
      correctIndex: 0,
      explanation: 'Obłok chwały wypełnia dom (1 Królów 8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['obłok', 'arka', 'kapłani'],
    ),
    QuizQuestion(
      text: 'Dlaczego królestwo Salomona ostatecznie osłabło duchowo?',
      options: <String>[
        'Jego obce żony odwróciły jego serce',
        'Przegrał wojnę',
        'Został wygnany',
        'Brakowało mu bogactwa',
      ],
      correctIndex: 0,
      explanation:
          'Bałwochwalstwo jego żon prowadzi go do niewierności (1 Królów 11).',
    ),
    QuizQuestion(
      text:
          'Co robi Jeroboam po podziale królestwa, aby lud nie chodził do Jerozolimy?',
      options: <String>[
        'Ustawia złote cielce w Betel i Dan',
        'Niszczy wszystkie drogi',
        'Zakazuje wszelkiego kultu',
        'Buduje identyczną nową świątynię',
      ],
      correctIndex: 0,
      explanation:
          'Jeroboam wprowadza rywalizujący kult bałwochwalczy (1 Królów 12).',
    ),
  ],
  '1 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto zapowiedział królowi Achabowi karzącą suszę?',
      options: <String>['Eliasz', 'Elizeusz', 'Micheasz', 'Abdiasz'],
      correctIndex: 0,
      explanation:
          'Eliasz zapowiada, że nie będzie ani deszczu, ani rosy (1 Królów 17).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Co wydarzyło się podczas próby na górze Karmel?',
      options: <String>[
        'Ogień od Jehowy strawił ofiarę Eliasza',
        'Najpierw spadł nagły deszcz',
        'Wygrali prorocy Baala',
        'Nic się nie wydarzyło',
      ],
      correctIndex: 0,
      explanation:
          'Jehowa odpowiada ogniem na oczach całego Izraela (1 Królów 18).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Baal', 'ołtarz', 'woda'],
    ),
    QuizQuestion(
      text: 'Dlaczego Achab i Izebel doprowadzili do śmierci Nabota?',
      options: <String>[
        'Aby przejąć jego winnicę',
        'Za przestępstwo, które popełnił',
        'Za niespłacony dług',
        'Na rozkaz proroka',
      ],
      correctIndex: 0,
      explanation:
          'Izebel organizuje fałszywy proces przeciwko Nabotowi (1 Królów 21).',
    ),
  ],
  '2 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Eliasz opuścił ziemię?',
      options: <String>[
        'Został wzięty do nieba w wichurze',
        'Zmarł ze starości',
        'Został wygnany',
        'Zniknął bez wyjaśnienia',
      ],
      correctIndex: 0,
      explanation:
          'Elizeusz widzi, jak Eliasz zostaje wzięty w wichurze (2 Królów 2).',
    ),
    QuizQuestion(
      text: 'Jaki cud uczynił Elizeusz dla Szunemitki?',
      options: <String>[
        'Przywrócił do życia jej syna',
        'Rozmnożył jej trzodę',
        'Uzdrowił ją z trądu',
        'Odbudował jej dom',
      ],
      correctIndex: 0,
      explanation: 'Elizeusz przywraca życie dziecku Szunemitki (2 Królów 4).',
    ),
    QuizQuestion(
      text: 'Jak Naaman został uzdrowiony z trądu?',
      options: <String>[
        'Kąpiąc się siedem razy w Jordanie',
        'Za pomocą specjalnej maści',
        'Poprzez wspólną modlitwę',
        'Poprzez długi post',
      ],
      correctIndex: 0,
      explanation:
          'Naaman, mimo sceptycyzmu, wypełnia polecenie Elizeusza (2 Królów 5).',
    ),
  ],
  '2 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak niespodziewanie zniesiono oblężenie Samarii?',
      options: <String>[
        'Wojsko aramejskie uciekło, przerażone hałasem',
        'Przybyło sprzymierzone wojsko',
        'Podpisano rozejm',
        'Król aramejski zginął w bitwie',
      ],
      correctIndex: 0,
      explanation:
          'Jehowa sprawia hałas, który wywołuje panikę u wroga (2 Królów 7).',
    ),
    QuizQuestion(
      text: 'Kogo Jehu wyeliminował, aby oczyścić królestwo Izraela?',
      options: <String>[
        'Jorama, Izebel i dom Achaba',
        'Tylko proroków Baala',
        'Królów Judy',
        'Asyryjczyków',
      ],
      correctIndex: 0,
      explanation:
          'Jehu wykonuje ogłoszony wyrok przeciwko domowi Achaba (2 Królów 9-10).',
    ),
    QuizQuestion(
      text: 'Jak chroniono młodego Joasza, zanim został królem?',
      options: <String>[
        'Ukryła go w świątyni jego ciotka',
        'Wysłano go za granicę',
        'Wychowywał go samotny prorok',
        'Chroniło go wojsko asyryjskie',
      ],
      correctIndex: 0,
      explanation: 'Joasz unika masakry dokonanej przez Atalię (2 Królów 11).',
    ),
  ],
  '2 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Co dzieje się z królestwem północnym (Izraelem) po oblężeniu asyryjskim?',
      options: <String>[
        'Samaria upada, a lud zostaje deportowany',
        'Podbija Asyrię',
        'Zawiera trwały pokój',
        'Właściwie nic się nie zmienia',
      ],
      correctIndex: 0,
      explanation:
          'Upadek Samarii oznacza koniec królestwa północnego (2 Królów 17).',
    ),
    QuizQuestion(
      text: 'Jak Ezechiasz zareagował na groźny list Sancheryba?',
      options: <String>[
        'Rozłożył go przed Jehową i modlił się',
        'Poddał się bez oporu',
        'Uciekł z miasta',
        'Zignorował groźbę',
      ],
      correctIndex: 0,
      explanation:
          'Modlitwa Ezechiasza poprzedza cudowne wybawienie (2 Królów 19).',
    ),
    QuizQuestion(
      text: 'Co spotkało wojsko asyryjskie oblegające Jerozolimę?',
      options: <String>[
        'Anioł jednej nocy pobił wielką ich liczbę',
        'Zostało pokonane w bitwie',
        'Po prostu się wycofało',
        'Epidemia stopniowo je osłabiła',
      ],
      correctIndex: 0,
      explanation: 'Boska interwencja ratuje Jerozolimę (2 Królów 19).',
    ),
  ],
  '2 Kings#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Co odkrył arcykapłan Chilkiasz za panowania Jozjasza?',
      options: <String>[
        'Księgę Prawa, zagubioną w świątyni',
        'Skarb złota',
        'Grobowiec królewski',
        'Nowe źródło wody',
      ],
      correctIndex: 0,
      explanation:
          'To odkrycie wywołuje religijną reformę Jozjasza (2 Królów 22).',
    ),
    QuizQuestion(
      text: 'Jakie wielkie święto obchodził Jozjasz po swojej reformie?',
      options: <String>[
        'Paschę',
        'Święto Szałasów',
        'Pięćdziesiątnicę',
        'Rok Jubileuszowy',
      ],
      correctIndex: 0,
      explanation: 'Obchodzona jest pamiętna Pascha (2 Królów 23).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Pascha'],
    ),
    QuizQuestion(
      text: 'Jak kończy się historia Judy w Księdze Królów?',
      options: <String>[
        'Upadkiem Jerozolimy i zniszczeniem świątyni',
        'Koronacją sprawiedliwego, trwałego króla',
        'Wielkim zwycięstwem militarnym',
        'Natychmiastowym powrotem z wygnania',
      ],
      correctIndex: 0,
      explanation: 'Relacja kończy się wygnaniem do Babilonu (2 Królów 25).',
    ),
  ],
  '1 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Od jakich rodowodów zaczyna się ta księga?',
      options: <String>[
        'Od Adama aż po dwanaście plemion Izraela',
        'Tylko od linii Dawida',
        'Tylko od kapłanów',
        'Od królów Egiptu',
      ],
      correctIndex: 0,
      explanation: 'Wykazy sięgają aż do Adama (1 Kronik 1-2).',
    ),
    QuizQuestion(
      text: 'Z jakiego plemienia pochodzi królewska linia Dawida?',
      options: <String>['Judy', 'Lewiego', 'Beniamina', 'Efraima'],
      correctIndex: 0,
      explanation: 'Rodowód Judy obejmuje dom Dawida (1 Kronik 2-3).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Które plemiona osiedliły się na wschód od Jordanu według tych rodowodów?',
      options: <String>[
        'Ruben, Gad i połowa Manassesa',
        'Juda i Beniamin',
        'Lewi i Symeon',
        'Dan i Naftali',
      ],
      correctIndex: 0,
      explanation: 'Zapisano ich terytorium i przywódców (1 Kronik 5).',
    ),
  ],
  '1 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego Uzza zmarł podczas transportu Arki?',
      options: <String>[
        'Dotknął jej, gdy się przechyliła, wbrew poleceniom Boga',
        'Ukradł ją',
        'Odmówił jej niesienia',
        'Wyśmiał procesję',
      ],
      correctIndex: 0,
      explanation:
          'Transport nie odbywał się według poleceń Boga (1 Kronik 13).',
    ),
    QuizQuestion(
      text:
          'W jaki sposób Arka została ostatecznie prawidłowo przeniesiona do Jerozolimy?',
      options: <String>[
        'Niesiona przez Lewitów, jak nakazywało Prawo',
        'Na wozie ciągniętym przez woły',
        'Statkiem',
        'Przez egipskich kapłanów',
      ],
      correctIndex: 0,
      explanation: 'Dawid naprawia wcześniejszy błąd (1 Kronik 15).',
    ),
    QuizQuestion(
      text: 'Nad kim Dawid odniósł znaczące zwycięstwa w tych rozdziałach?',
      options: <String>[
        'Nad Filistynami',
        'Nad Egipcjanami',
        'Nad Babilończykami',
        'Nad Persami',
      ],
      correctIndex: 0,
      explanation: 'Dawid kilkakrotnie pokonuje Filistynów (1 Kronik 14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Filistyni'],
    ),
  ],
  '1 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaką pieśń Dawid powierzył Asafowi, gdy ustawiono Arkę?',
      options: <String>[
        'Pieśń chwały i dziękczynienia',
        'Pieśń żałobną',
        'Proroctwo nieszczęścia',
        'Pieśń wojenną',
      ],
      correctIndex: 0,
      explanation:
          'Ten psalm pochwalny zostaje powierzony Asafowi (1 Kronik 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['lament', 'psalm', 'trąba'],
    ),
    QuizQuestion(
      text: 'Dlaczego Dawid nie mógł sam zbudować świątyni?',
      options: <String>[
        'Przelał wiele krwi na wojnie',
        'Brakowało mu bogactwa',
        'Nie miał planu',
        'Lud był temu przeciwny',
      ],
      correctIndex: 0,
      explanation:
          'Jehowa zastrzega to zadanie dla Salomona (1 Kronik 22; 28).',
    ),
    QuizQuestion(
      text: 'Gdzie Dawid kupił miejsce pod przyszłą świątynię?',
      options: <String>[
        'Klepisko Ornana (Arauny)',
        'Pole w pobliżu Hebronu',
        'Wzgórze w Szilo',
        'Ziemię podarowaną przez Hirama',
      ],
      correctIndex: 0,
      explanation: 'Dawid buduje tam ołtarz po pladze (1 Kronik 21).',
    ),
  ],
  '1 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Dawid zorganizował służbę Lewitów?',
      options: <String>[
        'W grupy z konkretnymi przydzielonymi zadaniami',
        'Nie mieli żadnej organizacji',
        'Jeden mężczyzna zajmował się wszystkim',
        'Zostali zwolnieni ze służby',
      ],
      correctIndex: 0,
      explanation: 'Lewici zostają podzieleni według funkcji (1 Kronik 23).',
    ),
    QuizQuestion(
      text: 'Jaką rolę pełnili muzycy wyznaczeni przez Dawida?',
      options: <String>[
        'Prorokowali i wielbili Boga przy użyciu instrumentów',
        'Walczyli na pierwszej linii',
        'Sądzili sprawy sądowe',
        'Uczyli wyłącznie czytania',
      ],
      correctIndex: 0,
      explanation: 'Asaf, Heman i Jedutun kierują świętą muzyką (1 Kronik 25).',
    ),
    QuizQuestion(
      text: 'Jaki był ostatni wielki publiczny czyn Dawida przed śmiercią?',
      options: <String>[
        'Nakłonienie Salomona i ludu do budowy świątyni',
        'Stoczenie ostatniej wojny',
        'Zrewidowanie wszystkich praw',
        'Dobrowolne wygnanie',
      ],
      correctIndex: 0,
      explanation:
          'Dawid modli się i błogosławi zgromadzenie przed śmiercią (1 Kronik 28-29).',
    ),
  ],
  '2 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: 'O co Salomon prosi Jehowę na początku swojego panowania?',
      options: <String>[
        'O mądrość i wiedzę do rządzenia',
        'O bogactwo ponad wszystko',
        'O potężne wojsko',
        'O życie bez trudności',
      ],
      correctIndex: 0,
      explanation:
          'Jego prośba podoba się Bogu, który dodatkowo daje mu bogactwo (2 Kronik 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['bogactwo', 'honor', 'świątynia'],
    ),
    QuizQuestion(
      text: 'Co wydarzyło się podczas poświęcenia świątyni?',
      options: <String>[
        'Zstąpił ogień z nieba, a chwała wypełniła dom',
        'Trzęsienie ziemi wszystko zniszczyło',
        'Nic szczególnego się nie wydarzyło',
        'Lud się rozproszył',
      ],
      correctIndex: 0,
      explanation:
          'Spektakularny przejaw potwierdza boskie uznanie (2 Kronik 7).',
    ),
    QuizQuestion(
      text: 'Jaką modlitwę zanosi Salomon podczas poświęcenia?',
      options: <String>[
        'Prośbę, by Bóg wysłuchiwał modlitw zanoszonych ku temu miejscu',
        'Prośbę o więcej bogactwa',
        'Wypowiedzenie wojny',
        'Pieśń żałobną',
      ],
      correctIndex: 0,
      explanation: 'Salomon prosi Boga, by słuchał z nieba (2 Kronik 6).',
    ),
  ],
  '2 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto odwiedził Salomona, by wypróbować jego mądrość?',
      options: <String>[
        'Królowa Saby',
        'Król Asyrii',
        'Faraon Egiptu',
        'Król Tyru',
      ],
      correctIndex: 0,
      explanation: 'Jest pod wrażeniem jego mądrości i bogactwa (2 Kronik 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Salomon', 'Egipt', 'Tyr'],
    ),
    QuizQuestion(
      text: 'Dlaczego królestwo podzieliło się za panowania Roboama?',
      options: <String>[
        'Jego odmowa złagodzenia ciężaru nałożonego przez Salomona',
        'Obca inwazja',
        'Nagła śmierć króla',
        'Pokojowe porozumienie o podziale',
      ],
      correctIndex: 0,
      explanation:
          'Jego surowość skłania dziesięć plemion do pójścia za Jeroboamem (2 Kronik 10).',
    ),
    QuizQuestion(
      text: 'Jak Asa zareagował na inwazję etiopską?',
      options: <String>[
        'Modlił się do Jehowy przed bitwą i zwyciężył',
        'Poddał się bez walki',
        'Uciekł z wojskiem',
        'Zapłacił wysoki trybut',
      ],
      correctIndex: 0,
      explanation: 'Jego ufność Bogu zostaje wynagrodzona (2 Kronik 14).',
    ),
  ],
  '2 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka choroba dotknęła Asę po tym, jak zaniedbał szukania Jehowy?',
      options: <String>[
        'Poważna choroba nóg',
        'Trąd',
        'Ślepota',
        'Całkowity paraliż',
      ],
      correctIndex: 0,
      explanation: 'Radzi się lekarzy zamiast Boga (2 Kronik 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['oczy', 'ręce', 'trąd'],
    ),
    QuizQuestion(
      text: 'Dlaczego Jehoszafat został skarcony przez proroka?',
      options: <String>[
        'Za sojusz z niegodziwym królem Achabem',
        'Za zaniedbanie świątyni',
        'Za odmowę pójścia na wojnę',
        'Za zniesienie świąt',
      ],
      correctIndex: 0,
      explanation: 'Jego sojusz z Achabem zostaje skrytykowany (2 Kronik 19).',
    ),
    QuizQuestion(
      text: 'Jak Jehoszafat odniósł zwycięstwo, nie walcząc?',
      options: <String>[
        'Modląc się, podczas gdy jego wrogowie zwrócili się przeciwko sobie',
        'Dzięki wynegocjowanemu rozejmowi',
        'Dzięki strategicznemu odwrotowi',
        'Dzięki traktatowi z Egiptem',
      ],
      correctIndex: 0,
      explanation: 'Ufność Bogu poprzedza cudowne wybawienie (2 Kronik 20).',
    ),
  ],
  '2 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak młody Joasz został ocalony z masakry dokonanej przez Atalię?',
      options: <String>[
        'Ukryła go w świątyni jego ciotka',
        'Potajemnie wysłano go za granicę',
        'Adoptował go obcy kapłan',
        'Chroniło go sprzymierzone wojsko',
      ],
      correctIndex: 0,
      explanation: 'Jehoszeba ukrywa go aż do jego koronacji (2 Kronik 22-23).',
    ),
    QuizQuestion(
      text: 'Dlaczego Uzjasz został dotknięty trądem?',
      options: <String>[
        'Próbował złożyć kadzielną ofiarę, zadanie zastrzeżone dla kapłanów',
        'Odmówił płacenia dziesięciny',
        'Znieważył proroka',
        'Zaniedbał wojsko',
      ],
      correctIndex: 0,
      explanation:
          'Jego pycha skłania go do przekroczenia swojej roli (2 Kronik 26).',
    ),
    QuizQuestion(
      text: 'Co Ezechiasz robi na samym początku swojego panowania?',
      options: <String>[
        'Ponownie otwiera i oczyszcza świątynię',
        'Wypowiada wojnę Asyrii',
        'Znosi wszystkie święta',
        'Przenosi stolicę',
      ],
      correctIndex: 0,
      explanation:
          'Ezechiasz podejmuje wielką religijną reformę (2 Kronik 29).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ołtarz', 'Pascha', 'bramy'],
    ),
  ],
  '2 Chronicles#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'Jakie wielkie święto zorganizował Ezechiasz po oczyszczeniu świątyni?',
      options: <String>[
        'Niezwykłą Paschę',
        'Święto Szałasów',
        'Rok Jubileuszowy',
        'Pięćdziesiątnicę',
      ],
      correctIndex: 0,
      explanation: 'Ta Pascha gromadzi Judę i część Izraela (2 Kronik 30).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Pascha'],
    ),
    QuizQuestion(
      text: 'Co się stało, gdy Manasses okazał skruchę w niewoli?',
      options: <String>[
        'Jehowa sprowadził go z powrotem do Jerozolimy i przeprowadził on reformy',
        'Pozostał więźniem do końca życia',
        'Został stracony',
        'Nic się nie zmieniło',
      ],
      correctIndex: 0,
      explanation: 'Jego szczera skrucha zmienia jego los (2 Kronik 33).',
    ),
    QuizQuestion(
      text: 'Jak kończy się Księga Kronik?',
      options: <String>[
        'Dekretem Cyrusa zezwalającym na powrót i odbudowę świątyni',
        'Ostateczną, beznadziejną zagładą',
        'Koronacją nowego króla z rodu Dawida',
        'Przedłużającą się wojną domową',
      ],
      correctIndex: 0,
      explanation:
          'Dekret Cyrusa otwiera drogę do powrotu z wygnania (2 Kronik 36).',
    ),
  ],
  'Ezra#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto upoważnił wygnańców do powrotu i odbudowy świątyni?',
      options: <String>[
        'Cyrus, król Persji',
        'Nabuchodonozor',
        'Sam Dariusz',
        'Kserkses',
      ],
      correctIndex: 0,
      explanation: 'Cyrus wydaje wyzwalający dekret (Ezdrasza 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Cyrus'],
    ),
    QuizQuestion(
      text:
          'Co zrobili wygnańcy zaraz po powrocie, jeszcze przed dokończeniem świątyni?',
      options: <String>[
        'Odbudowali ołtarz, aby składać ofiary',
        'Wybrali nowego króla',
        'Zaatakowali sąsiadów',
        'Odmówili wszelkiego kultu',
      ],
      correctIndex: 0,
      explanation:
          'Ołtarz zostaje odbudowany przed położeniem fundamentu (Ezdrasza 3).',
    ),
    QuizQuestion(
      text:
          'Jaka mieszana reakcja towarzyszyła położeniu fundamentu nowej świątyni?',
      options: <String>[
        'Radość u wielu, płacz u starców, którzy widzieli pierwszą '
            'świątynię',
        'Ogólna obojętność',
        'Jednomyślny gniew',
        'Lud uciekł',
      ],
      correctIndex: 0,
      explanation:
          'Kontrast ze świątynią Salomona wzrusza starszych do łez (Ezdrasza 3).',
    ),
  ],
  'Ezra#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak przerwano prace budowlane?',
      options: <String>[
        'Miejscowi przeciwnicy zmusili do wstrzymania prac',
        'Trzęsienie ziemi wszystko zniszczyło',
        'Ludowi zabrakło materiałów',
        'Robotnicy sami odeszli',
      ],
      correctIndex: 0,
      explanation:
          'Polityczny sprzeciw wstrzymuje przedsięwzięcie (Ezdrasza 4).',
    ),
    QuizQuestion(
      text: 'Kto swoimi proroctwami zachęcił do wznowienia prac przy świątyni?',
      options: <String>[
        'Aggeusz i Zachariasz',
        'Ezechiel i Daniel',
        'Izajasz i Jeremiasz',
        'Ozeasz i Amos',
      ],
      correctIndex: 0,
      explanation: 'Ich orędzia ponownie pobudzają budowę (Ezdrasza 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Ezdrasz', 'Nehemiasz', 'Daniel'],
    ),
    QuizQuestion(
      text: 'Kto przybył później z Babilonu z dodatkową grupą wygnańców?',
      options: <String>[
        'Ezdrasz, kapłan i pisarz',
        'Nehemiasz',
        'Zerubbabel',
        'Mardocheusz',
      ],
      correctIndex: 0,
      explanation: 'Ezdrasz przybywa za panowania Artakserksesa (Ezdrasza 7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Ezdrasz'],
    ),
  ],
  'Ezra#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego Ezdrasz nie poprosił o zbrojną eskortę na podróż?',
      options: <String>[
        'Wyraził swoją ufność w ochronę Boga',
        'Król mu jej odmówił',
        'Podróż była bezpieczna',
        'Miał już wojsko',
      ],
      correctIndex: 0,
      explanation: 'Ezdrasz zaświadczył o ochronie Boga (Ezdrasza 8).',
    ),
    QuizQuestion(
      text: 'Jaki problem głęboko zasmucił Ezdrasza po jego przybyciu?',
      options: <String>[
        'Małżeństwa z kobietami z okolicznych narodów',
        'Brak ofiar',
        'Głód',
        'Wojna domowa',
      ],
      correctIndex: 0,
      explanation: 'Ezdrasz rozdziera swoje szaty z rozpaczy (Ezdrasza 9).',
    ),
    QuizQuestion(
      text: 'Jak lud zareagował na apel Ezdrasza?',
      options: <String>[
        'Wyznając swoje przewinienie i naprawiając sytuację',
        'Odmawiając jakiejkolwiek zmiany',
        'Wypędzając Ezdrasza',
        'Ignorując apel',
      ],
      correctIndex: 0,
      explanation: 'Następuje wspólna reforma (Ezdrasza 10).',
    ),
  ],
  'Nehemiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Jak zareagował Nehemiasz, gdy dowiedział się o stanie murów Jerozolimy?',
      options: <String>[
        'Płakał, pościł i modlił się',
        'Pozostał obojętny',
        'Zrezygnował ze stanowiska',
        'Zorganizował uroczystość',
      ],
      correctIndex: 0,
      explanation: 'Jego smutek skłania go do działania (Nehemiasza 1).',
    ),
    QuizQuestion(
      text: 'O co Nehemiasz poprosił króla Artakserksesa?',
      options: <String>[
        'O pozwolenie na odbudowę murów',
        'O złoto dla siebie',
        'O wyższe stanowisko na dworze',
        'O wolność od służby u króla',
      ],
      correctIndex: 0,
      explanation: 'Król się zgadza i zapewnia mu środki (Nehemiasza 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['świątynia', 'król', 'Jerozolima'],
    ),
    QuizQuestion(
      text: 'Jak budowniczowie zareagowali na szyderstwa i groźby?',
      options: <String>[
        'Pracowali jedną ręką, a drugą trzymali broń',
        'Przerwali przedsięwzięcie',
        'Uciekli z miasta',
        'Negocjowali z przeciwnikami',
      ],
      correctIndex: 0,
      explanation: 'Czujność i determinacja cechują tę pracę (Nehemiasza 4).',
    ),
  ],
  'Nehemiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaką niesprawiedliwość społeczną Nehemiasz potępił wśród ludu?',
      options: <String>[
        'Lichwiarskie pożyczki, które zubażały biednych',
        'Odmowę płacenia dziesięciny',
        'Wyłącznie lekceważenie szabatu',
        'Korupcję wśród sędziów',
      ],
      correctIndex: 0,
      explanation:
          'Nehemiasz koryguje tę niesprawiedliwą praktykę (Nehemiasza 5).',
    ),
    QuizQuestion(
      text: 'W jakim czasie ukończono mur Jerozolimy?',
      options: <String>['52 dni', 'Rok', 'Dziesięć lat', 'Tydzień'],
      correctIndex: 0,
      explanation:
          'Niezwykłe osiągnięcie mimo silnego sprzeciwu (Nehemiasza 6).',
    ),
    QuizQuestion(
      text: 'Co się stało, gdy Ezdrasz publicznie odczytał ludowi Prawo?',
      options: <String>[
        'Lud najpierw płakał, a potem radośnie świętował',
        'Lud się zbuntował',
        'Nikt nie słuchał',
        'Odczyt przerwano',
      ],
      correctIndex: 0,
      explanation:
          'Po tym poruszającym odczytaniu następuje Święto Szałasów (Nehemiasza 8).',
    ),
  ],
  'Nehemiah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Co lud zrobił po odczytaniu Prawa i narodowym wyznaniu?',
      options: <String>[
        'Podpisali pisemne zobowiązanie do posłuszeństwa Bogu',
        'Opuścili Jerozolimę',
        'Znieśli święta',
        'Wygnali kapłanów',
      ],
      correctIndex: 0,
      explanation:
          'Pisemne przymierze przypieczętowuje to zobowiązanie (Nehemiasza 9-10).',
    ),
    QuizQuestion(
      text: 'Jak świętowano poświęcenie muru?',
      options: <String>[
        'Procesjami śpiewu i dziękczynienia',
        'Cichym postem',
        'Wojskową ceremonią',
        'Zamykając bramy',
      ],
      correctIndex: 0,
      explanation: 'Dwa chóry obchodzą mur, śpiewając (Nehemiasza 12).',
    ),
    QuizQuestion(
      text:
          'Jaką reformę wprowadził Nehemiasz podczas swojego drugiego '
          'pobytu w Jerozolimie?',
      options: <String>[
        'Ścisłe przestrzeganie szabatu i wygnanie Tobiasza',
        'Zniesienie świątyni',
        'Nowy spis ludności',
        'Budowę pałacu',
      ],
      correctIndex: 0,
      explanation:
          'Nehemiasz koryguje kilka nadużyć, które powróciły podczas jego nieobecności (Nehemiasza 13).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesPlC2 =
    <String, List<QuizQuestion>>{};
