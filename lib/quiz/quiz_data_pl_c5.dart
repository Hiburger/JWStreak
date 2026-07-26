import 'quiz_data.dart';

const Map<String, List<QuizQuestion>> authoredQuizzesPlC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto zapowiedział przyjście Jezusa, głosząc na pustyni?',
      options: <String>['Jan Chrzciciel', 'Eliasz', 'Izajasz', 'Zachariasz'],
      correctIndex: 0,
      explanation:
          'Jan Chrzciciel przygotowuje drogę dla Jezusa (Mateusza 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jezus', 'Eliasz', 'Piotr'],
    ),
    QuizQuestion(
      text: 'Jak długo Jezus pościł, zanim był kuszony przez Diabła?',
      options: <String>['40 dni', '7 dni', '3 dni', '100 dni'],
      correctIndex: 0,
      explanation:
          'Jezus pości 40 dni i 40 nocy (Mateusza 4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['czterdzieści dni'],
    ),
    QuizQuestion(
      text: 'Według Kazania na Górze, kto jest ogłoszony szczęśliwym?',
      options: <String>[
        'Ci, którzy są świadomi swojej duchowej potrzeby',
        'Bogaci',
        'Możni',
        'Sławni',
      ],
      correctIndex: 0,
      explanation:
          'Błogosławieństwa zaczynają się od ubogich w duchu (Mateusza 5:3).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Ile chlebów i ryb użył Jezus, aby nakarmić około 5000 mężczyzn?',
      options: <String>['5 chlebów i 2 ryby', '2 chleby i 5 ryb', '7 chlebów', '12 chlebów'],
      correctIndex: 0,
      explanation:
          'Jezus rozmnaża 5 chlebów i 2 ryby (Mateusza 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['chleb', 'kosze', 'dwanaście'],
    ),
    QuizQuestion(
      text: 'Co zrobił Piotr, gdy zobaczył Jezusa chodzącego po wodzie?',
      options: <String>[
        'Też spróbował chodzić po wodzie',
        'Ukrył się',
        'Uciekł',
        'Nic nie zrobił',
      ],
      correctIndex: 0,
      explanation:
          'Piotr idzie w stronę Jezusa, lecz zaczyna tonąć z braku wiary (Mateusza 14).',
    ),
    QuizQuestion(
      text: 'Kto zażądał głowy Jana Chrzciciela na misie?',
      options: <String>['Córka Herodiady', 'Sam Herod', 'Żołnierz', 'Piłat'],
      correctIndex: 0,
      explanation:
          'Tancerka, namówiona przez matkę, żąda głowy Jana (Mateusza 14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Salome', 'córka Herodiady'],
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak odpowiedział Piotr, gdy Jezus zapytał: „A wy, za kogo mnie uważacie?”',
      options: <String>[
        'Ty jesteś Chrystus, Syn żywego Boga',
        'Ty jesteś Eliasz',
        'Ty jesteś prorok',
        'Nie wiem',
      ],
      correctIndex: 0,
      explanation: 'Piotr rozpoznaje w Jezusie Chrystusa (Mateusza 16).',
    ),
    QuizQuestion(
      text: 'Co się stało podczas przemienienia?',
      options: <String>[
        'Twarz Jezusa zajaśniała jak słońce',
        'Jezus zniknął',
        'Rozpętała się burza',
        'Jezus chodził po wodzie',
      ],
      correctIndex: 0,
      explanation:
          'Jezus zostaje przemieniony przed Piotrem, Jakubem i Janem (Mateusza 17).',
    ),
    QuizQuestion(
      text: 'Na jakim zwierzęciu Jezus wjechał do Jerozolimy?',
      options: <String>['Na młodym ośle', 'Na białym koniu', 'Na wielbłądzie', 'Szedł pieszo'],
      correctIndex: 0,
      explanation:
          'Jezus wjeżdża na młodym ośle, spełniając proroctwo (Mateusza 21).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['koń', 'wielbłąd', 'rydwan'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Co ustanowił Jezus podczas swojego ostatniego posiłku z apostołami?',
      options: <String>[
        'Pamiątkowy posiłek swojej śmierci',
        'Coroczne święto żniw',
        'Wspólny post',
        'Pielgrzymkę',
      ],
      correctIndex: 0,
      explanation:
          'Jezus ustanawia pamiątkowy posiłek z chlebem i winem (Mateusza 26).',
    ),
    QuizQuestion(
      text: 'Kto zdradził Jezusa za trzydzieści srebrników?',
      options: <String>['Judasz Iskariot', 'Piotr', 'Tomasz', 'Barabasz'],
      correctIndex: 0,
      explanation: 'Judasz zdradza Jezusa (Mateusza 26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Judasz'],
    ),
    QuizQuestion(
      text: 'Co się stało trzeciego dnia po śmierci Jezusa?',
      options: <String>[
        'Został wskrzeszony',
        'Świątynia została zniszczona',
        'Wstąpił do nieba',
        'Nic szczególnego',
      ],
      correctIndex: 0,
      explanation: 'Jezus zostaje wskrzeszony trzeciego dnia (Mateusza 28).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['grób', 'anioł', 'kamień'],
    ),
  ],
  'John#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Według Jana 1, kim było „Słowo” (Logos), które na początku było u Boga?',
      options: <String>[
        'Synem Bożym, zanim stał się człowiekiem',
        'Aniołem',
        'Mojżeszem',
        'Duchem Świętym',
      ],
      correctIndex: 0,
      explanation:
          'Słowo było u Boga i staje się ciałem w Jezusie (Jana 1).',
    ),
    QuizQuestion(
      text: 'Jaki był pierwszy cud Jezusa, dokonany w Kanie?',
      options: <String>[
        'Zamiana wody w wino',
        'Uzdrowienie niewidomego',
        'Nakarmienie tłumu',
        'Uciszenie burzy',
      ],
      correctIndex: 0,
      explanation:
          'Jezus zamienia wodę w wino na weselu (Jana 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Kana', 'chleb', 'olej'],
    ),
    QuizQuestion(
      text: 'Co musi zrobić człowiek, według Jezusa, aby „ujrzeć Królestwo Boże”?',
      options: <String>['Narodzić się na nowo', 'Pościć 40 dni', 'Pójść do świątyni', 'Zostać kapłanem'],
      correctIndex: 0,
      explanation:
          'Jezus wyjaśnia to Nikodemowi (Jana 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Nikodem', 'duch', 'ciało'],
    ),
  ],
  'John#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Jezus opisuje samego siebie w Jana 10?',
      options: <String>['Wspaniały pasterz', 'Lew', 'Arcykapłan', 'Sędzia'],
      correctIndex: 0,
      explanation:
          'Jezus przedstawia się jako wspaniały pasterz, który oddaje życie za swoje owce (Jana 10).',
    ),
    QuizQuestion(
      text: 'Kogo Jezus wskrzesił po czterech dniach w grobie?',
      options: <String>['Łazarza', 'Jaira', 'Syna wdowy', 'Setnika'],
      correctIndex: 0,
      explanation: 'Jezus wskrzesza Łazarza (Jana 11).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Co Jezus zrobił dla swoich apostołów przed ostatnim posiłkiem, jako przykład pokory?',
      options: <String>[
        'Umył im nogi',
        'Pobłogosławił ich pojedynczo',
        'Podzielił się z nimi swoim mieniem',
        'Publicznie modlił się za każdego z nich',
      ],
      correctIndex: 0,
      explanation: 'Jezus myje nogi swoim uczniom (Jana 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ręce', 'chleb', 'miednica'],
    ),
  ],
  'John#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Do czego Jezus porównuje swoją relację z uczniami w Jana 15?',
      options: <String>['Do krzewu winnego i jego gałązek', 'Do pasterza i jego trzody', 'Do króla i jego poddanych', 'Do ojca i jego dzieci'],
      correctIndex: 0,
      explanation: 'Jezus jest krzewem winnym, jego uczniowie gałązkami (Jana 15).',
    ),
    QuizQuestion(
      text: 'Kto odciął mężczyźnie ucho podczas aresztowania Jezusa?',
      options: <String>['Piotr', 'Jan', 'Jakub', 'Andrzej'],
      correctIndex: 0,
      explanation: 'Piotr uderza mieczem Malchusa (Jana 18).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Kto pierwszy zwątpił w zmartwychwstanie, zanim dotknął ran Jezusa?',
      options: <String>['Tomasz', 'Piotr', 'Jan', 'Filip'],
      correctIndex: 0,
      explanation: 'Tomasz wątpi, a potem wierzy (Jana 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto przygotowuje drogę przed Jezusem na początku Ewangelii Marka?',
      options: <String>['Jan Chrzciciel', 'Osobiście Eliasz', 'Anioł', 'Arcykapłan'],
      correctIndex: 0,
      explanation:
          'Jan chrzci i zapowiada przyjście Jezusa (Marka 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Jan'],
    ),
    QuizQuestion(
      text: 'Jak Jezus okazał swoją władzę, uzdrawiając sparaliżowanego mężczyznę spuszczonego przez dach?',
      options: <String>[
        'Przebaczając mu grzechy, zanim go uzdrowił',
        'Najpierw żądając ofiary',
        'Odsyłając go bez odpowiedzi',
        'Najpierw konsultując się z faryzeuszami',
      ],
      correctIndex: 0,
      explanation:
          'Przebaczenie poprzedza fizyczne uzdrowienie (Marka 2).',
    ),
    QuizQuestion(
      text: 'Co opisuje przypowieść o siewcy w Marka 4?',
      options: <String>[
        'Różne reakcje na słowo Boże',
        'Zwykłą lekcję rolnictwa',
        'Wyrok przeciw rolnikom',
        'Proroctwo o głodzie',
      ],
      correctIndex: 0,
      explanation:
          'Rodzaje gleby ilustrują różne serca (Marka 4).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co się stało, gdy nakarmiono pięć tysięcy?',
      options: <String>[
        'Pięć chlebów i dwie ryby wystarczyły, a nawet zostało',
        'Każdy przyniósł własne jedzenie',
        'Tłum odszedł głodny',
        'Zorganizowano prowizoryczny targ',
      ],
      correctIndex: 0,
      explanation:
          'Cud rozmnożenia (Marka 6).',
    ),
    QuizQuestion(
      text: 'Jaka niezwykła scena rozgrywa się na górze w Marka 9?',
      options: <String>['Przemienienie Jezusa', 'Trzęsienie ziemi', 'Gwałtowna burza', 'Publiczny wyrok'],
      correctIndex: 0,
      explanation:
          'Jezus ukazuje się w chwale z Mojżeszem i Eliaszem (Marka 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['chrzest', 'Mojżesz', 'góra'],
    ),
    QuizQuestion(
      text: 'Jak Jezus wjeżdża do Jerozolimy w Marka 11?',
      options: <String>['Na młodym ośle, wiwatowany przez tłum', 'Potajemnie, niezauważony', 'Z wojskiem', 'Konno, jako zdobywca'],
      correctIndex: 0,
      explanation:
          'Triumfalny wjazd spełnia proroctwo (Marka 11).',
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie wielkie przykazanie cytuje Jezus w Marka 12?',
      options: <String>[
        'Miłuj Boga całym swoim sercem i bliźniego jak samego siebie',
        'Skrupulatnie płać podatki',
        'Pość co tydzień',
        'Unikaj wszelkiego kontaktu z obcymi',
      ],
      correctIndex: 0,
      explanation:
          'Jezus streszcza Prawo w dwóch przykazaniach (Marka 12).',
    ),
    QuizQuestion(
      text: 'Co Jezus ustanowił podczas ostatniego posiłku z uczniami?',
      options: <String>[
        'Pamiątkowy posiłek swojej śmierci',
        'Nowe coroczne święto',
        'Wspólny post',
        'Obowiązkową pielgrzymkę',
      ],
      correctIndex: 0,
      explanation:
          'Chleb i wino symbolizują jego ofiarę (Marka 14).',
    ),
    QuizQuestion(
      text: 'Co odkrywają kobiety, które przychodzą do grobu trzeciego dnia?',
      options: <String>[
        'Grób jest pusty, Jezus został wskrzeszony',
        'Ciało Jezusa wciąż tam jest',
        'Grób jest zapieczętowany i niedostępny',
        'Nic niezwykłego',
      ],
      correctIndex: 0,
      explanation:
          'Zmartwychwstanie ogłasza anioł (Marka 16).',
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto zapowiada Marii, że będzie matką Jezusa?',
      options: <String>['Anioł Gabriel', 'Kapłan', 'Jan Chrzciciel', 'Tylko sen'],
      correctIndex: 0,
      explanation:
          'Gabriel zapowiada cudowne narodziny (Łukasza 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Gabriel'],
    ),
    QuizQuestion(
      text: 'Kto złożył świadectwo o dziecięciu Jezusie podczas jego ofiarowania w świątyni?',
      options: <String>['Symeon i Anna', 'Herod', 'Naczelni kapłani', 'Nikt'],
      correctIndex: 0,
      explanation:
          'Dwoje wiernych w podeszłym wieku rozpoznaje Mesjasza (Łukasza 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Maria', 'Józef', 'Zachariasz'],
    ),
    QuizQuestion(
      text: 'Jaką słynną mowę wygłasza Jezus w Łukasza 6?',
      options: <String>[
        'Kazanie na równinie, z błogosławieństwami i biadami',
        'Mowę o podatkach',
        'Wypowiedzenie wojny',
        'Wyrok przeciwko Rzymowi',
      ],
      correctIndex: 0,
      explanation:
          'Ważna nauka moralna (Łukasza 6).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka słynna przypowieść ilustruje miłość bliźniego w Łukasza 10?',
      options: <String>['Dobry Samarytanin', 'Syn marnotrawny', 'Siewca', 'Dziesięć dziewic'],
      correctIndex: 0,
      explanation:
          'Przykład współczucia wobec obcego (Łukasza 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['kapłan', 'Lewita', 'zbójca'],
    ),
    QuizQuestion(
      text: 'Jakie trzy przypowieści opowiada Jezus w Łukasza 15 o tym, co zaginęło?',
      options: <String>[
        'Zgubioną owcę, zgubioną monetę, syna marnotrawnego',
        'Siewcę, sieć, perłę',
        'Drzewo figowe, winorośl, pszenicę',
        'Talenty, miny, skarb',
      ],
      correctIndex: 0,
      explanation:
          'Trzy obrazy radości z odnalezienia (Łukasza 15).',
    ),
    QuizQuestion(
      text: 'Co ukazuje przypowieść o bogaczu i Łazarzu w Łukasza 16?',
      options: <String>[
        'Kontrast między obojętnością a współczuciem',
        'Lekcję rolnictwa',
        'Praktyczne porady finansowe',
        'Proroctwo o Rzymie',
      ],
      correctIndex: 0,
      explanation:
          'Przypowieść o priorytetach serca (Łukasza 16).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Co robi Zacheusz, aby okazać zmianę swojego życia po spotkaniu z Jezusem?',
      options: <String>[
        'Zwraca czterokrotnie tym, których skrzywdził',
        'Opuszcza miasto',
        'Ostatecznie ignoruje Jezusa',
        'Odmawia dzielenia się swoim mieniem',
      ],
      correctIndex: 0,
      explanation:
          'Jego hojność ilustruje jego szczerą przemianę (Łukasza 19).',
    ),
    QuizQuestion(
      text: 'O co prosi Jezusa skruszony przestępca na palu?',
      options: <String>[
        'Aby pamiętał o nim w swoim Królestwie',
        'Aby natychmiast go uwolnił',
        'Aby ukarał jego oskarżycieli',
        'Aby publicznie udowodnił swoją moc',
      ],
      correctIndex: 0,
      explanation:
          'Jezus obiecuje mu raj (Łukasza 23).',
    ),
    QuizQuestion(
      text: 'Co się dzieje w drodze do Emaus po zmartwychwstaniu?',
      options: <String>[
        'Zmartwychwstały Jezus wyjaśnia Pisma dwóm uczniom',
        'Uczniowie zostają aresztowani',
        'Anioł zakazuje jakiejkolwiek podróży',
        'Nic szczególnego się nie dzieje',
      ],
      correctIndex: 0,
      explanation:
          'Rozpoznają go, gdy dzieli się chlebem (Łukasza 24).',
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Jezus obiecuje swoim uczniom tuż przed wniebowstąpieniem?',
      options: <String>[
        'Otrzymają moc ducha świętego',
        'Natychmiast zapanują nad Rzymem',
        'Nigdy więcej go nie zobaczą',
        'Będą musieli od razu uciekać',
      ],
      correctIndex: 0,
      explanation:
          'Istotna obietnica przed Pięćdziesiątnicą (Dzieje 1).',
    ),
    QuizQuestion(
      text: 'Co się stało w dniu Pięćdziesiątnicy?',
      options: <String>[
        'Duch święty został wylany na uczniów',
        'Trzęsienie ziemi zniszczyło świątynię',
        'Apostołowie uciekli z Jerozolimy',
        'Nic niezwykłego się nie stało',
      ],
      correctIndex: 0,
      explanation:
          'Zbór chrześcijański zaczyna się tego dnia (Dzieje 2).',
    ),
    QuizQuestion(
      text: 'Kto stał się pierwszym chrześcijańskim męczennikiem?',
      options: <String>['Szczepan', 'Piotr', 'Sam Jakub', 'Filip'],
      correctIndex: 0,
      explanation:
          'Szczepan zostaje ukamienowany po swojej mowie (Dzieje 7).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Saul został przemieniony w drodze do Damaszku?',
      options: <String>[
        'Nawróciło go światło i głos od Jezusa',
        'Po prostu sam zmienił zdanie',
        'Zmusił go do zmiany pewien król',
        'Nic się nie stało na tej drodze',
      ],
      correctIndex: 0,
      explanation:
          'Spotkanie z Jezusem zmienia jego życie (Dzieje 9).',
    ),
    QuizQuestion(
      text: 'Jaką wizję otrzymuje Piotr przed spotkaniem z Korneliuszem?',
      options: <String>[
        'Wielkie płótno ze zwierzętami, oznaczające otwartość na nie-Żydów',
        'Niebiańską bitwę',
        'Płonącą świątynię',
        'Bezsensowny sen',
      ],
      correctIndex: 0,
      explanation:
          'Ta wizja przygotowuje Piotra do głoszenia dobrej nowiny narodom (Dzieje 10).',
    ),
    QuizQuestion(
      text: 'Gdzie uczniów po raz pierwszy nazwano „chrześcijanami”?',
      options: <String>['W Antiochii', 'W Jerozolimie', 'W Rzymie', 'W Efezie'],
      correctIndex: 0,
      explanation:
          'To określenie pojawia się po raz pierwszy w Antiochii (Dzieje 11:26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Antiochia'],
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaką ważną decyzję podejmuje sobór jerozolimski w sprawie nawróconych nie-Żydów?',
      options: <String>[
        'Nie muszą być obrzezani zgodnie z Prawem',
        'Muszą przestrzegać całego Prawa Mojżeszowego',
        'Zostają wykluczeni ze zboru',
        'Nie podjęto żadnej decyzji',
      ],
      correctIndex: 0,
      explanation:
          'Kluczowa decyzja dla rozprzestrzeniania się chrześcijaństwa (Dzieje 15).',
    ),
    QuizQuestion(
      text: 'Co się stało z Pawłem i Sylasem uwięzionymi w Filippi?',
      options: <String>[
        'Trzęsienie ziemi otworzyło drzwi więzienia',
        'Uciekli po kryjomu',
        'Pozostali zamknięci do końca życia',
        'Nikt nie interweniował',
      ],
      correctIndex: 0,
      explanation:
          'Cud uwalnia więźniów (Dzieje 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['łańcuchy', 'strażnik', 'Sylas'],
    ),
    QuizQuestion(
      text: 'Gdzie Paweł wygłosił swoją słynną mowę o „Nieznanym Bogu”?',
      options: <String>['Na Areopagu, w Atenach', 'W Rzymie', 'W Jerozolimie', 'W Koryncie'],
      correctIndex: 0,
      explanation:
          'Paweł zwraca się do greckich filozofów (Dzieje 17).',
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Paweł opowiada w swojej obronie po aresztowaniu w świątyni?',
      options: <String>[
        'O swoim nawróceniu w drodze do Damaszku',
        'O militarnym zwycięstwie',
        'O podróży służbowej',
        'O osobistym sporze',
      ],
      correctIndex: 0,
      explanation:
          'Paweł świadczy o swoim osobistym doświadczeniu (Dzieje 22).',
    ),
    QuizQuestion(
      text: 'Dlaczego Paweł odwołał się do cezara?',
      options: <String>[
        'Aby otrzymać sprawiedliwy proces jako obywatel rzymski',
        'Aby uniknąć jakiegokolwiek procesu',
        'Aby zostać natychmiast uwolnionym',
        'Ponieważ chciał opuścić służbę',
      ],
      correctIndex: 0,
      explanation:
          'Jego status obywatela rzymskiego daje mu to prawo (Dzieje 25).',
    ),
    QuizQuestion(
      text: 'Co się stało po katastrofie statku na wyspie Malta?',
      options: <String>[
        'Paweł został ukąszony przez żmiję, nie doznając szkody',
        'Został aresztowany przez mieszkańców',
        'Statek natychmiast wypłynął ponownie',
        'Nic szczególnego się nie stało',
      ],
      correctIndex: 0,
      explanation:
          'Paweł pozostaje nietknięty mimo ukąszenia żmii, co zdumiewa wyspiarzy (Dzieje 28).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesPlC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki wzorcowy modlitwę dał Jezus w Kazaniu na Górze?',
      options: <String>[
        'Modlitwę „Ojcze nasz”',
        'Długą listę ślubów',
        'Zakazaną tajną modlitwę',
        'Żadną konkretną modlitwę',
      ],
      correctIndex: 0,
      explanation:
          'Jezus uczy, jak modlić się prosto (Mateusza 6).',
    ),
    QuizQuestion(
      text: 'Do kogo podobny jest, według Mateusza 7, człowiek, który wprowadza słowa Jezusa w czyn?',
      options: <String>[
        'Do człowieka, który buduje swój dom na skale',
        'Do człowieka, który buduje na piasku',
        'Do bezcelowego podróżnika',
        'Do króla bez królestwa',
      ],
      correctIndex: 0,
      explanation:
          'Dom na skale wytrzymuje burze (Mateusza 7:24).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co zrobił Jezus podczas burzy na Morzu Galilejskim?',
      options: <String>['Uciszył ją słowem', 'Wiosłował szybciej', 'Przeczekał ją', 'Uciekł na brzeg'],
      correctIndex: 0,
      explanation:
          'Wiatr i morze są mu posłuszne (Mateusza 8).',
    ),
    QuizQuestion(
      text: 'Ilu apostołów wybrał Jezus i wysłał, aby głosili?',
      options: <String>['Dwunastu', 'Siedmiu', 'Siedemdziesięciu', 'Trzech'],
      correctIndex: 0,
      explanation:
          'Dwunastu apostołów jest wymienionych z imienia (Mateusza 10).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Ile razy powinieneś przebaczyć swojemu bratu, według Mateusza 18?',
      options: <String>[
        'Nawet 77 razy',
        'Tylko trzy razy',
        'Tylko raz',
        'Nigdy',
      ],
      correctIndex: 0,
      explanation:
          'Jezus uczy nieograniczonego przebaczenia (Mateusza 18:22).',
    ),
    QuizQuestion(
      text: 'Co zrobił Jezus, wchodząc do świątyni w Jerozolimie?',
      options: <String>[
        'Wypędził sprzedawców',
        'Złożył ofiarę',
        'Ukrył się',
        'Koronował kapłana',
      ],
      correctIndex: 0,
      explanation:
          'Jezus oczyszcza świątynię (Mateusza 21).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['świątynia', 'pieniądze', 'gołębie'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie znaki zapowiedział Jezus na zakończenie systemu rzeczy w Mateusza 24?',
      options: <String>[
        'Wojny, głody i trzęsienia ziemi',
        'Natychmiastowy powszechny pokój',
        'Znikające na zawsze słońce',
        'Żadnych znaków w ogóle',
      ],
      correctIndex: 0,
      explanation:
          'Opisany jest złożony znak (Mateusza 24).',
    ),
    QuizQuestion(
      text: 'Jaką misję powierzył Jezus swoim uczniom po zmartwychwstaniu?',
      options: <String>[
        'Czynienie uczniów z ludzi ze wszystkich narodów',
        'Pozostanie ukrytymi w Jerozolimie',
        'Budowę świątyni',
        'Bierne czekanie',
      ],
      correctIndex: 0,
      explanation:
          'Wielkie zlecenie zamyka Ewangelię (Mateusza 28:19).',
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Kogo Jezus powołał najpierw nad Morzem Galilejskim?',
      options: <String>['Rybaków', 'Kapłanów', 'Żołnierzy', 'Uczonych w piśmie'],
      correctIndex: 0,
      explanation:
          'Szymon, Andrzej i inni idą za nim (Marka 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Co Jezus zrobił dla opętanego mężczyzny z krainy Gerazeńczyków?',
      options: <String>[
        'Wypędził z niego dręczące go demony',
        'Zignorował go',
        'Odesłał go do domu, nic nie robiąc',
        'Ostro go zganił',
      ],
      correctIndex: 0,
      explanation:
          'Mężczyzna zostaje uwolniony i odzyskuje zmysły (Marka 5).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Iloma chlebami Jezus nakarmił około 4000 ludzi?',
      options: <String>['Siedmioma', 'Pięcioma', 'Dwunastoma', 'Dwoma'],
      correctIndex: 0,
      explanation:
          'Drugi cud rozmnożenia (Marka 8).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Kim musi się stać człowiek, według Jezusa, aby wejść do Królestwa Bożego?',
      options: <String>['Jak małe dziecko', 'Bogatym i możnym', 'Uznanym przywódcą', 'Uczonym'],
      correctIndex: 0,
      explanation:
          'Jezus przyjmuje dzieci jako przykład (Marka 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sługa', 'anioł', 'uczeń'],
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki drobny datek pochwalił Jezus w świątyni?',
      options: <String>[
        'Dwie małe monety wdowy',
        'Worek złota',
        'Nieskazitelnego baranka',
        'Srebrną monetę',
      ],
      correctIndex: 0,
      explanation:
          'Ona dała wszystko, co miała (Marka 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['bogaty', 'świątynia', 'złoto'],
    ),
    QuizQuestion(
      text: 'Kto został zmuszony do niesienia pala męki Jezusa?',
      options: <String>['Szymon z Cyreny', 'Piotr', 'Jan', 'Barabasz'],
      correctIndex: 0,
      explanation:
          'Szymon zostaje zmuszony po drodze (Marka 15).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Szymon'],
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: 'W jakim mieście urodził się Jezus?',
      options: <String>['W Betlejem', 'W Nazarecie', 'W Jerozolimie', 'W Kafarnaum'],
      correctIndex: 0,
      explanation:
          'Narodziny mają miejsce w Betlejem (Łukasza 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Komu aniołowie najpierw ogłosili narodziny Jezusa?',
      options: <String>['Pasterzom', 'Królom', 'Kapłanom', 'Herodowi'],
      correctIndex: 0,
      explanation:
          'Pasterze otrzymują dobrą nowinę (Łukasza 2).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Ilu uczniów wysłał Jezus, aby głosili po dwóch, w Łukasza 10?',
      options: <String>['Siedemdziesięciu', 'Dwunastu', 'Stu', 'Trzech'],
      correctIndex: 0,
      explanation:
          'Jezus rozszerza dzieło głoszenia (Łukasza 10).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Co radzi Jezus w związku z martwieniem się o jedzenie i odzież?',
      options: <String>[
        'Nie martwić się, lecz najpierw szukać Królestwa',
        'Gromadzić jak najwięcej',
        'Całkowicie przestać pracować',
        'Nieustannie się martwić',
      ],
      correctIndex: 0,
      explanation:
          'Jezus uczy zaufania do Boga (Łukasza 12).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Ilu trędowatych uzdrowił Jezus, spośród których tylko jeden wrócił, aby podziękować?',
      options: <String>['Dziesięciu', 'Siedmiu', 'Trzech', 'Dwunastu'],
      correctIndex: 0,
      explanation:
          'Tylko Samarytanin wraca, aby podziękować (Łukasza 17).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Kto spiskował i zdradził Jezusa za pieniądze?',
      options: <String>['Judasz Iskariot', 'Piotr', 'Tomasz', 'Piłat'],
      correctIndex: 0,
      explanation:
          'Judasz zdradza Jezusa (Łukasza 22).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Judasz'],
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Ile mniej więcej osób zostało ochrzczonych w dniu Pięćdziesiątnicy?',
      options: <String>['Około 3000', 'Około 500', 'Około 12', 'Około 100'],
      correctIndex: 0,
      explanation:
          'Wielka liczba osób odpowiada na orędzie (Dzieje 2).',
    ),
    QuizQuestion(
      text: 'Kto pilnował ubrań tych, którzy kamienowali Szczepana?',
      options: <String>['Saul (później Paweł)', 'Piotr', 'Barnabas', 'Filip'],
      correctIndex: 0,
      explanation:
          'Saul pochwalał to zabójstwo (Dzieje 7-8).',
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Kogo duch posłał, aby oznajmił dobrą nowinę etiopskiemu urzędnikowi?',
      options: <String>['Filipa', 'Piotra', 'Pawła', 'Jana'],
      correctIndex: 0,
      explanation:
          'Filip wyjaśnia mu Pisma (Dzieje 8).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Jak Piotr został uwolniony z więzienia za czasów Heroda?',
      options: <String>['Przez anioła', 'Przez przekupienie strażnika', 'Przez trzęsienie ziemi', 'Nikt mu nie pomógł'],
      correctIndex: 0,
      explanation:
          'Anioł cudownie go wyprowadza (Dzieje 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Piotr', 'więzienie', 'wizja'],
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki fach uprawiał Paweł razem z Akwilą i Pryscyllą?',
      options: <String>['Wyrób namiotów', 'Rybołówstwo', 'Ciesielstwo', 'Medycynę'],
      correctIndex: 0,
      explanation:
          'Paweł pracował własnymi rękami (Dzieje 18).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'W jakim mieście głoszenie Pawła wywołało rozruchy wśród złotników czczących Dianę/Artemidę?',
      options: <String>['W Efezie', 'W Atenach', 'W Koryncie', 'W Rzymie'],
      correctIndex: 0,
      explanation:
          'Rzemieślnicy obawiali się o swoje rzemiosło (Dzieje 19).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Przed jakimi władcami Paweł składał świadectwo w Cezarei?',
      options: <String>[
        'Feliksem, Festusem i królem Agryppą',
        'Piłatem i Herodem',
        'Wyłącznie Sanhedrynem',
        'Samym cezarem',
      ],
      correctIndex: 0,
      explanation:
          'Paweł broni swojej wiary przed władzami (Dzieje 24-26).',
    ),
    QuizQuestion(
      text: 'Dokąd ostatecznie przybył Paweł, aby oczekiwać na swój proces przed cezarem?',
      options: <String>['Do Rzymu', 'Do Jerozolimy', 'Do Antiochii', 'Do Efezu'],
      correctIndex: 0,
      explanation:
          'Paweł głosi nawet w areszcie domowym (Dzieje 28).',
      type: QuizAnswerType.freeText,
    ),
  ],
};
