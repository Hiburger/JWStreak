import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesPlC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Ile dni stworzenia opisuje Księga Rodzaju, zanim Bóg '
          'odpoczywa?',
      options: <String>[
        'Sześć dni',
        'Siedem dni',
        'Trzy dni',
        'Czterdzieści dni',
      ],
      correctIndex: 0,
      explanation:
          'Księga Rodzaju opisuje sześć dni stworzenia; siódmego dnia Bóg odpoczywa (Rodzaju 1 i 2).',
    ),
    QuizQuestion(
      text: 'Kto był pierwszym mężczyzną i pierwszą kobietą?',
      options: <String>[
        'Adam i Ewa',
        'Kain i Abel',
        'Noe i jego żona',
        'Abraham i Sara',
      ],
      correctIndex: 0,
      explanation: 'Adam i Ewa są pierwszymi ludźmi (Rodzaju 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Kain', 'Noe', 'Sara'],
    ),
    QuizQuestion(
      text: 'Kto zabił swojego brata Abla?',
      options: <String>['Kain', 'Set', 'Noe', 'Cham'],
      correctIndex: 0,
      explanation: 'Kain zabija z zazdrości swojego brata Abla (Rodzaju 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Dlaczego Bóg sprowadził potop?',
      options: <String>[
        'Z powodu niegodziwości ludzi',
        'Z powodu suszy',
        'Aby powiększyć morza',
        'Nie podano żadnego powodu',
      ],
      correctIndex: 0,
      explanation: 'Niegodziwość ludzi na ziemi była wielka (Rodzaju 6).',
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Jaki znak dał Bóg jako obietnicę, że nigdy więcej nie zniszczy ziemi potopem?',
      options: <String>['Tęczę', 'Gwiazdę', 'Drzewo oliwne', 'Grzmot'],
      correctIndex: 0,
      explanation: 'Tęcza jest znakiem przymierza (Rodzaju 9).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['tęcza'],
    ),
    QuizQuestion(
      text: 'Jak nazywała się wieża, którą ludzie chcieli zbudować?',
      options: <String>[
        'Wieża Babel',
        'Wieża Syjonu',
        'Wieża Dawida',
        'Wieża Ur',
      ],
      correctIndex: 0,
      explanation: 'W Babel Bóg miesza im język (Rodzaju 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Syjonu', 'Dawida', 'Ur'],
    ),
    QuizQuestion(
      text: 'Kogo Bóg powołał, aby opuścił Ur?',
      options: <String>['Abrama (Abrahama)', 'Lota', 'Izaaka', 'Jakuba'],
      correctIndex: 0,
      explanation: 'Bóg powołuje Abrama i składa mu obietnice (Rodzaju 12).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego Egipcjanie zniewolili Izraelitów?',
      options: <String>[
        'Obawiali się, że Izraelici staną się zbyt liczni',
        'Chcieli ich ziemi',
        'Z powodu niespłaconego długu',
        'Z powodu przegranej wojny',
      ],
      correctIndex: 0,
      explanation:
          'Nowy król obawia się rosnącej liczby Izraelitów (Wyjścia 1).',
    ),
    QuizQuestion(
      text: 'W czym matka Mojżesza ukryła go jako niemowlę?',
      options: <String>[
        'W koszyku z trzciny na Nilu',
        'W jaskini',
        'W namiocie',
        'W studni',
      ],
      correctIndex: 0,
      explanation:
          'Mojżesz zostaje umieszczony w koszyku z trzciny wśród sitowia (Wyjścia 2).',
    ),
    QuizQuestion(
      text: 'Jak Bóg ukazał się Mojżeszowi na górze Horeb?',
      options: <String>[
        'Jako krzew płonący, lecz niespalający się',
        'Jako słup obłoku',
        'Jako widzialny anioł',
        'Jako trzęsienie ziemi',
      ],
      correctIndex: 0,
      explanation: 'Bóg przemawia do Mojżesza z płonącego krzewu (Wyjścia 3).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie święto ustanowił Bóg przed wyprowadzeniem Izraela z Egiptu?',
      options: <String>[
        'Paschę',
        'Pięćdziesiątnicę',
        'Święto Szałasów',
        'Szabat',
      ],
      correctIndex: 0,
      explanation:
          'Pascha upamiętnia ochronę Izraelitów podczas ostatniej plagi (Wyjścia 12).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Pascha'],
    ),
    QuizQuestion(
      text: 'W jaki sposób Bóg otworzył drogę dla Izraela?',
      options: <String>[
        'Rozdzielając wody Morza Czerwonego',
        'Osuszając Jordan',
        'Kopiąc tunel',
        'Zsyłając kamienny most',
      ],
      correctIndex: 0,
      explanation:
          'Morze Czerwone rozdziela się, aby przepuścić Izraela (Wyjścia 14).',
    ),
    QuizQuestion(
      text: 'Jaki pokarm Bóg sprawił, że spadał z nieba na pustyni?',
      options: <String>['Mannę', 'Chleb jęczmienny', 'Figi', 'Miód'],
      correctIndex: 0,
      explanation: 'Manna pojawia się każdego ranka (Wyjścia 16).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto poradził Mojżeszowi, aby delegował rozstrzyganie sporów?',
      options: <String>['Jetro, jego teść', 'Aaron', 'Jozue', 'Miriam'],
      correctIndex: 0,
      explanation:
          'Jetro proponuje ustanowienie przywódców do sądzenia codziennych spraw (Wyjścia 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Jetro'],
    ),
    QuizQuestion(
      text: 'Gdzie Bóg dał Dziesięć Przykazań?',
      options: <String>[
        'Na górze Synaj',
        'Na górze Nebo',
        'W Kadesz',
        'W Betel',
      ],
      correctIndex: 0,
      explanation: 'Prawo zostaje dane na górze Synaj (Wyjścia 19-20).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['góra Synaj', 'Synaj'],
    ),
    QuizQuestion(
      text: 'Które przykazanie zabrania pożądania tego, co należy do innych?',
      options: <String>[
        'Dziesiąte („Nie będziesz pożądał”)',
        'Pierwsze',
        'Piąte',
        'Siódme',
      ],
      correctIndex: 0,
      explanation: 'Dziesiąte przykazanie zabrania pożądania (Wyjścia 20:17).',
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Co należało zbudować według wskazówek, które Bóg dał Mojżeszowi?',
      options: <String>['Przybytek', 'Pałac', 'Mur', 'Kamienną świątynię'],
      correctIndex: 0,
      explanation: 'Bóg podaje szczegółowe plany przybytku (Wyjścia 25).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['przybytek'],
    ),
    QuizQuestion(
      text: 'Co zrobił lud, gdy Mojżesz przebywał na górze?',
      options: <String>[
        'Złotego cielca',
        'Kamienny posąg',
        'Drewniany ołtarz',
        'Świątynię',
      ],
      correctIndex: 0,
      explanation: 'Lud odlewa złotego cielca i oddaje mu cześć (Wyjścia 32).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['brąz', 'byk', 'bożek'],
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Co okryło przybytek po jego ukończeniu, jako znak obecności Boga?',
      options: <String>[
        'Obłok',
        'Ogień widoczny w biały dzień',
        'Tęcza',
        'Gwiazda',
      ],
      correctIndex: 0,
      explanation:
          'Obłok okrywa namiot spotkania, a chwała Jehowy go wypełnia (Wyjścia 40).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['obłok'],
    ),
    QuizQuestion(
      text:
          'Kto ostatecznie wyciosał nowe kamienne tablice, gdy Mojżesz rozbił pierwsze?',
      options: <String>[
        'Mojżesz, na polecenie Boga',
        'Aaron',
        'Jozue',
        'Besalel',
      ],
      correctIndex: 0,
      explanation:
          'Bóg poleca Mojżeszowi wyciosać dwie nowe tablice (Wyjścia 34).',
    ),
  ],
  'Leviticus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Który rodzaj ofiary był całkowicie spalany na ołtarzu?',
      options: <String>[
        'Ofiara całopalna',
        'Ofiara współuczestnictwa',
        'Ofiara zbożowa',
        'Ofiara za grzech',
      ],
      correctIndex: 0,
      explanation:
          'Ofiara całopalna jest w całości spalana na ołtarzu (Kapłańska 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['zbożowa', 'grzech', 'pokój'],
    ),
    QuizQuestion(
      text:
          'Ile głównych rodzajów ofiar opisano w tych początkowych rozdziałach?',
      options: <String>['Pięć', 'Dwa', 'Dziesięć', 'Trzy'],
      correctIndex: 0,
      explanation:
          'Ofiara całopalna, zbożowa, współuczestnictwa, za grzech i za przewinienie (Kapłańska 1-7).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Kto miał przynosić ofiary do wejścia namiotu spotkania?',
      options: <String>[
        'Sama osoba, z pomocą kapłanów',
        'Tylko kapłani',
        'Tylko starsi',
        'Przedstawiciel króla',
      ],
      correctIndex: 0,
      explanation:
          'Ofiarodawca sam przynosi zwierzę, a kapłani sprawują służbę (Kapłańska 1-7).',
    ),
  ],
  'Leviticus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego zginęli Nadab i Abihu?',
      options: <String>[
        'Złożyli przed Jehową nieautoryzowany ogień',
        'Byli nieposłuszni Mojżeszowi',
        'Zjedli nieczysty pokarm',
        'Odmówili służby',
      ],
      correctIndex: 0,
      explanation:
          'Synowie Aarona składają „obcy ogień” i umierają (Kapłańska 10).',
    ),
    QuizQuestion(
      text:
          'Jakie kryteria sprawiały, że zwierzę lądowe było czyste do jedzenia?',
      options: <String>[
        'Rozdwojone kopyto i przeżuwanie',
        'Życie wyłącznie na pustyni',
        'Bycie udomowionym',
        'Posiadanie piór',
      ],
      correctIndex: 0,
      explanation:
          'Czyste zwierzęta przeżuwają i mają rozdwojone kopyto (Kapłańska 11).',
    ),
    QuizQuestion(
      text:
          'Jaką chorobę kapłani mieli szczegółowo badać w tych '
          'rozdziałach?',
      options: <String>['Trąd', 'Ospę', 'Tylko oparzenia', 'Trądzik'],
      correctIndex: 0,
      explanation:
          'Kapłani badają objawy trądu na skórze, ubraniu i domach (Kapłańska 13-14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Leviticus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Raz w roku, w który uroczysty dzień pokrywano grzechy narodu?',
      options: <String>[
        'W Dzień Pojednania (Jom Kippur)',
        'W Paschę',
        'W Szabat',
        'W Pięćdziesiątnicę',
      ],
      correctIndex: 0,
      explanation:
          'Arcykapłan dokonuje przebłagania za naród raz w roku (Kapłańska 16).',
    ),
    QuizQuestion(
      text: 'Które dobrze znane przykazanie znajduje się w Kapłańskiej 19?',
      options: <String>[
        'Miłuj bliźniego jak samego siebie',
        'Nie kradnij bydła',
        'Odpoczywaj przez siedem lat',
        'Czcij króla',
      ],
      correctIndex: 0,
      explanation: 'Kapłańska 19:18 jest później cytowana przez samego Jezusa.',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['serce', 'obcy', 'przebacz'],
    ),
    QuizQuestion(
      text: 'Czego należało unikać w kwestii pokarmu, zgodnie z Kapłańską 17?',
      options: <String>[
        'Spożywania krwi',
        'Jedzenia w nocy',
        'Jedzenia w samotności',
        'Jedzenia chleba',
      ],
      correctIndex: 0,
      explanation: 'Spożywanie krwi jest zabronione (Kapłańska 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['krew'],
    ),
  ],
  'Leviticus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie coroczne święta wymienia Kapłańska 23?',
      options: <String>[
        'Pascha, Pięćdziesiątnica, Trąby, Pojednanie, Szałasy',
        'Tylko Pascha',
        'Tylko Nowy Rok',
        'Tylko posty',
      ],
      correctIndex: 0,
      explanation:
          'Kalendarz świąt obejmuje cały rok religijny (Kapłańska 23).',
    ),
    QuizQuestion(
      text: 'Co należało zrobić co 50 lat, w Roku Jubileuszowym?',
      options: <String>[
        'Zwrócić ziemię i uwolnić hebrajskich niewolników',
        'Zniszczyć plony',
        'Wybrać nowego arcykapłana',
        'Zmienić prawo',
      ],
      correctIndex: 0,
      explanation:
          'Rok Jubileuszowy przywraca ziemię i wolność (Kapłańska 25).',
    ),
    QuizQuestion(
      text: 'Co obiecuje Kapłańska 26 za wierność przymierzu?',
      options: <String>[
        'Błogosławieństwa; nieposłuszeństwo sprowadza nieszczęście',
        'Nic konkretnego',
        'Natychmiastowe bogactwo bez warunków',
        'Nieustanną wojnę',
      ],
      correctIndex: 0,
      explanation:
          'Szczegółowo opisano warunkowe błogosławieństwa i przekleństwa (Kapłańska 26).',
    ),
  ],
  'Numbers#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego Izrael przeprowadził spis na pustyni synajskiej?',
      options: <String>[
        'Aby policzyć mężczyzn zdolnych do wojny',
        'Aby opodatkować każdą rodzinę',
        'Aby wybrać króla',
        'Aby podzielić ziemię',
      ],
      correctIndex: 0,
      explanation:
          'Spis liczy mężczyzn od 20 roku życia zdolnych do walki (Liczb 1).',
    ),
    QuizQuestion(
      text: 'Kto odpowiadał za transport i obsługę przybytku?',
      options: <String>['Lewici', 'Sami kapłani', 'Starsi', 'Wojownicy'],
      correctIndex: 0,
      explanation:
          'Lewici otrzymują konkretne zadania związane z przybytkiem (Liczb 3-4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Lewici'],
    ),
    QuizQuestion(
      text: 'Co musiała robić osoba, która złożyła ślub nazireatu?',
      options: <String>[
        'Powstrzymać się od wina i nie strzyc włosów',
        'Pościć przez 40 dni',
        'Żyć samotnie na pustyni',
        'Ofiarować całe swoje bydło',
      ],
      correctIndex: 0,
      explanation: 'Ślub nazireatu narzuca specjalne ograniczenia (Liczb 6).',
    ),
  ],
  'Numbers#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Kogo Bóg wyznaczył, aby pomagali Mojżeszowi dźwigać ciężar ludu?',
      options: <String>[
        '70 starszych',
        '12 wywiadowców',
        'Samego Aarona',
        'Samego Jozuego',
      ],
      correctIndex: 0,
      explanation:
          '70 starszych otrzymuje ducha, aby dzielić odpowiedzialność (Liczb 11).',
    ),
    QuizQuestion(
      text:
          'Co się stało po tym, jak Miriam i Aaron skrytykowali '
          'Mojżesza?',
      options: <String>[
        'Miriam została dotknięta trądem',
        'Zostali wygnani na zawsze',
        'Nic im się nie stało',
        'Stracili głos',
      ],
      correctIndex: 0,
      explanation: 'Miriam staje się trędowata na siedem dni (Liczb 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aaron', 'Mojżesz', 'obłok'],
    ),
    QuizQuestion(
      text: 'Ilu wywiadowców przedstawiło zachęcające sprawozdanie o Kanaanie?',
      options: <String>['Dwóch (Jozue i Kaleb)', 'Dwunastu', 'Żaden', 'Pięciu'],
      correctIndex: 0,
      explanation:
          'Tylko Jozue i Kaleb zachęcają lud do wejścia (Liczb 13-14).',
    ),
  ],
  'Numbers#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto zbuntował się przeciwko władzy Mojżesza i Aarona?',
      options: <String>['Korach i jego zwolennicy', 'Jozue', 'Kaleb', 'Balaam'],
      correctIndex: 0,
      explanation: 'Bunt Koracha zostaje pochłonięty przez ziemię (Liczb 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Mojżesz', 'Aaron', 'ziemia'],
    ),
    QuizQuestion(
      text: 'Jaki znak potwierdził wybór Aarona na arcykapłana?',
      options: <String>[
        'Jego laska zakwitła',
        'Głos z nieba',
        'Ogień na ołtarzu',
        'Gwiazda',
      ],
      correctIndex: 0,
      explanation: 'Laska Aarona wypuszcza pąki i kwitnie (Liczb 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aaron', 'migdał', 'pręt'],
    ),
    QuizQuestion(
      text: 'Dlaczego Mojżesz nie mógł wejść do Ziemi Obiecanej?',
      options: <String>[
        'Uderzył skałę, zamiast do niej przemówić',
        'Był nieposłuszny rozkazowi wojskowemu',
        'Oddawał cześć bożkowi',
        'Był zbyt stary',
      ],
      correctIndex: 0,
      explanation:
          'Mojżesz w gniewie uderza skałę, nie okazując szacunku dla świętości Boga (Liczb 20).',
    ),
  ],
  'Numbers#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Kogo wynajął Balak, aby przeklął Izraela?',
      options: <String>['Balaama', 'Koracha', 'Oga', 'Sychona'],
      correctIndex: 0,
      explanation:
          'Balaam zostaje wezwany, by przeklął Izraela, lecz zamiast tego mu błogosławi (Liczb 23-24).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Kto gorliwie zadziałał, aby powstrzymać plagę podczas odstępstwa w Baal-Peor?',
      options: <String>['Pinechas', 'Jozue', 'Sam Eleazar', 'Kaleb'],
      correctIndex: 0,
      explanation: 'Pinechas interweniuje i plaga ustaje (Liczb 25).',
    ),
    QuizQuestion(
      text: 'Kogo Jehowa wyznaczył na następcę Mojżesza?',
      options: <String>['Jozuego', 'Kaleba', 'Eleazara', 'Pinechasa'],
      correctIndex: 0,
      explanation:
          'Jozue zostaje ustanowiony przed Eleazarem i zgromadzeniem (Liczb 27).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Numbers#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Przeciwko jakiemu ludowi Izrael prowadził wojnę sądu?',
      options: <String>['Midianowi', 'Edomowi', 'Całemu Moabowi', 'Egiptowi'],
      correctIndex: 0,
      explanation: 'Opisano wojnę przeciwko Midianowi (Liczb 31).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Które plemiona osiedliły się na wschód od Jordanu?',
      options: <String>[
        'Ruben, Gad i połowa Manassesa',
        'Juda i Beniamin',
        'Lewi i Symeon',
        'Sam Efraim',
      ],
      correctIndex: 0,
      explanation:
          'Te plemiona otrzymują ziemię na wschodzie pod warunkiem, że pomogą w podboju (Liczb 32).',
    ),
    QuizQuestion(
      text: 'Czym miały być miasta schronienia?',
      options: <String>[
        'Miejscami ucieczki po niezamierzonym zabójstwie',
        'Stolicami regionalnymi',
        'Centrami handlowymi',
        'Wyłącznie miejscami kultu',
      ],
      correctIndex: 0,
      explanation:
          'Miasta schronienia chronią kogoś, kto zabił bez zamiaru (Liczb 35).',
    ),
  ],
  'Deuteronomy#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Jakie wielkie przykazanie powtarza Mojżesz w Powtórzonego Prawa 6, znane jako Szema?',
      options: <String>[
        'Jehowa jest jeden, miłuj go całym sercem',
        'Nie jedz wieprzowiny',
        'Obchodź każdy nów księżyca',
        'Nigdy nie pracuj',
      ],
      correctIndex: 0,
      explanation:
          'Szema (Powtórzonego Prawa 6:4, 5) jest centralnym elementem wiary Izraela.',
    ),
    QuizQuestion(
      text:
          'Co Mojżesz przypomina o Dziesięciu Przykazaniach w tych rozdziałach?',
      options: <String>[
        'Powtarza je ludowi przed wejściem do Kanaanu',
        'Anuluje je',
        'Dodaje dziesięć kolejnych',
        'Zastrzega je dla kapłanów',
      ],
      correctIndex: 0,
      explanation:
          'Mojżesz ponownie przedstawia Dziesięć Przykazań (Powtórzonego Prawa 5).',
    ),
    QuizQuestion(
      text: 'Dlaczego Izrael musiał wystrzegać się narodów Kanaanu?',
      options: <String>[
        'Z powodu ryzyka bałwochwalstwa',
        'Z powodu ich bogactwa',
        'Z powodu ich języka',
        'Z powodu ich króla',
      ],
      correctIndex: 0,
      explanation:
          'Podkreślono niebezpieczeństwo przyjęcia ich bogów (Powtórzonego Prawa 7).',
    ),
  ],
  'Deuteronomy#1': <QuizQuestion>[
    QuizQuestion(
      text: 'O czym miała przypominać Izraelowi pamięć o mannie na pustyni?',
      options: <String>[
        'Że człowiek żyje nie samym chlebem, lecz każdą wypowiedzią '
            'z ust Jehowy',
        'Że Bóg zawsze karze',
        'Że pustynia jest przeklęta',
        'Że pokarm nie ma znaczenia',
      ],
      correctIndex: 0,
      explanation: 'Powtórzonego Prawa 8:3, później cytowane przez Jezusa.',
    ),
    QuizQuestion(
      text:
          'Które wydarzenie z pustyni przypomina Mojżesz, ostrzegając przed pychą?',
      options: <String>[
        'Złotego cielca',
        'Przejście przez Morze Czerwone',
        'Dar manny',
        'Budowę przybytku',
      ],
      correctIndex: 0,
      explanation: 'Złoty cielec ilustruje dawny bunt (Powtórzonego Prawa 9).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['złoty cielec'],
    ),
    QuizQuestion(
      text:
          'Gdzie Izraelici mieli przynosić swoje ofiary, według Powtórzonego Prawa 12?',
      options: <String>[
        'Tylko na miejsce, które wybierze Jehowa',
        'Gdziekolwiek zechcą',
        'W każdej wiosce',
        'Tylko w domu',
      ],
      correctIndex: 0,
      explanation: 'Nakazano jedno miejsce kultu (Powtórzonego Prawa 12).',
    ),
  ],
  'Deuteronomy#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Co należało zrobić z długami co siedem lat?',
      options: <String>[
        'Umorzyć je (rok darowania)',
        'Podwoić je',
        'Przekazać je dzieciom',
        'Nic szczególnego',
      ],
      correctIndex: 0,
      explanation: 'Rok darowania anuluje długi (Powtórzonego Prawa 15).',
    ),
    QuizQuestion(
      text: 'Co Powtórzonego Prawa 18 zapowiada o przyszłym proroku?',
      options: <String>[
        'Że Jehowa wzbudzi kogoś podobnego do Mojżesza',
        'Obcy król',
        'Anioł',
        'Pojedynczy sędzia',
      ],
      correctIndex: 0,
      explanation:
          'Ta prorocza zapowiedź zostaje odniesiona do Chrystusa w Chrześcijańskich Pismach Greckich (Powtórzonego Prawa 18).',
    ),
    QuizQuestion(
      text: 'Ilu świadków było potrzebnych, aby potwierdzić oskarżenie?',
      options: <String>[
        'Dwóch lub trzech',
        'Jeden wystarczał',
        'Dziesięciu',
        'Żaden nie był wymagany',
      ],
      correctIndex: 0,
      explanation: 'Prawo wymaga wielu świadków (Powtórzonego Prawa 19).',
    ),
  ],
  'Deuteronomy#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka coroczna ofiara przypominała o wybawieniu z Egiptu?',
      options: <String>[
        'Ofiara z pierwszych plonów',
        'Ofiara jubileuszowa',
        'Tylko ofiara z dziesięciny',
        'Posiłek pamiątkowy',
      ],
      correctIndex: 0,
      explanation:
          'Oświadczenie nad pierwszymi plonami przypomina wyjście z Egiptu (Powtórzonego Prawa 26).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['dziesięcina', 'Lewici', 'kosz'],
    ),
    QuizQuestion(
      text: 'Co mieli zrobić Izraelici po wejściu do Kanaanu, na górze Ebal?',
      options: <String>[
        'Zbudować ołtarz i ogłosić błogosławieństwa oraz przekleństwa',
        'Zbudować pałac',
        'Ustanowić stolicę',
        'Zniszczyć wszystkie drzewa',
      ],
      correctIndex: 0,
      explanation:
          'Ustanowiono ceremonię na górach Garizim i Ebal (Powtórzonego Prawa 27).',
    ),
    QuizQuestion(
      text:
          'Jaka zasada rządziła prawami dotyczącymi rozwodu w tych rozdziałach?',
      options: <String>[
        'Wymagano pisemnego świadectwa rozwodu',
        'Rozwód był zakazany w każdej formie',
        'Tylko żona mogła się rozwieść',
        'Nie istniała żadna zasada',
      ],
      correctIndex: 0,
      explanation:
          'Prawo reguluje rozwód za pomocą formalnego dokumentu (Powtórzonego Prawa 24).',
    ),
  ],
  'Deuteronomy#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Co obiecuje rozdział 28 za wierność przymierzu?',
      options: <String>[
        'Błogosławieństwa; nieposłuszeństwo sprowadza przekleństwa',
        'Nic konkretnego',
        'Natychmiastową wojnę',
        'Bogactwo bez żadnych warunków',
      ],
      correctIndex: 0,
      explanation:
          'Szczegółowo opisane błogosławieństwa i przekleństwa (Powtórzonego Prawa 28).',
    ),
    QuizQuestion(
      text: 'Jaki wybór stawia Mojżesz przed ludem w Powtórzonego Prawa 30?',
      options: <String>[
        'Życie i śmierć, błogosławieństwo i przekleństwo',
        'Zostać czy wrócić do Egiptu',
        'Służyć Aaronowi czy Jozuemu',
        'Płacić podatek czy nie',
      ],
      correctIndex: 0,
      explanation:
          'Lud zostaje wezwany, aby „wybrał życie” (Powtórzonego Prawa 30:19).',
    ),
    QuizQuestion(
      text: 'Gdzie zmarł Mojżesz, nie wchodząc do Ziemi Obiecanej?',
      options: <String>[
        'Na górze Nebo',
        'W Jerychu',
        'Na górze Synaj',
        'W Betlejem',
      ],
      correctIndex: 0,
      explanation:
          'Mojżesz ogląda ziemię ze szczytu Nebo, zanim umiera (Powtórzonego Prawa 34).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['góra Nebo', 'Nebo'],
    ),
  ],
  'Joshua#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie polecenie Jehowa powtarza Jozuemu na początku księgi?',
      options: <String>[
        'Bądź silny i odważny',
        'Pozostań w ukryciu',
        'Czekaj dziesięć lat',
        'Wróć do Egiptu',
      ],
      correctIndex: 0,
      explanation: 'Jehowa wielokrotnie zachęca Jozuego (Jozuego 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['strach', 'Mojżesz', 'prawo'],
    ),
    QuizQuestion(
      text: 'Kto ukrył izraelskich wywiadowców w Jerychu?',
      options: <String>['Rachab', 'Prorokini', 'Sam król', 'Nikt'],
      correctIndex: 0,
      explanation: 'Rachab ukrywa wywiadowców na dachu (Jozuego 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Jak runęły mury Jerycha?',
      options: <String>[
        'Po procesji i dźwięku trąb',
        'Wskutek naturalnego trzęsienia ziemi',
        'Po kilkumiesięcznym oblężeniu',
        'Przez zdradę mieszkańca',
      ],
      correctIndex: 0,
      explanation:
          'Po siedmiu okrążeniach i dźwięku trąb mury upadają (Jozuego 6).',
    ),
  ],
  'Joshua#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Gibeonici uniknęli zagłady?',
      options: <String>[
        'Udając podróżnych z odległego kraju',
        'Atakując pierwsi',
        'Płacąc natychmiastową daninę',
        'Publicznie się nawracając',
      ],
      correctIndex: 0,
      explanation:
          'Ich podstęp skłania Izraela do zawarcia z nimi traktatu pokojowego (Jozuego 9).',
    ),
    QuizQuestion(
      text:
          'Co niezwykłego wydarzyło się podczas bitwy z pięcioma królami amoryckimi?',
      options: <String>[
        'Słońce się zatrzymało',
        'Nastąpiło całkowite zaćmienie',
        'Spadł ogień',
        'Trzęsienie ziemi ich rozdzieliło',
      ],
      correctIndex: 0,
      explanation:
          'Jehowa walczy za Izraela, a słońce się zatrzymuje (Jozuego 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['księżyc', 'grad', 'Gibeon'],
    ),
    QuizQuestion(
      text: 'Jaki teren zażądał sobie Kaleb w wieku 85 lat?',
      options: <String>['Hebron', 'Jerycho', 'Szilo', 'Betel'],
      correctIndex: 0,
      explanation: 'Kaleb pozostaje wierny i otrzymuje Hebron (Jozuego 14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Joshua#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Gdzie ustawiono przybytek po wstępnym podboju?',
      options: <String>['W Szilo', 'W Jerozolimie', 'W Hebronie', 'W Betel'],
      correctIndex: 0,
      explanation: 'Namiot spotkania zostaje ustawiony w Szilo (Jozuego 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Szilo'],
    ),
    QuizQuestion(
      text: 'Dlaczego wschodnie plemiona zbudowały ołtarz w pobliżu Jordanu?',
      options: <String>[
        'Jako świadectwo, że należą do Izraela',
        'Aby ogłosić niepodległość',
        'Aby oddawać cześć innemu bogu',
        'Na rozkaz obcego króla',
      ],
      correctIndex: 0,
      explanation:
          'Ołtarz jest świadectwem, a nie rywalizującym miejscem ofiar (Jozuego 22).',
    ),
    QuizQuestion(
      text:
          'Jakie słynne oświadczenie wygłasza Jozue w Szechem przed śmiercią?',
      options: <String>[
        'Co do mnie i mojego domu, będziemy służyć Jehowie',
        'Wracamy do Egiptu',
        'Będzie nami rządził król',
        'Wojna będzie trwać zawsze',
      ],
      correctIndex: 0,
      explanation:
          'Jozue wzywa lud, by wybrał, komu będzie służył (Jozuego 24).',
    ),
  ],
  'Judges#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki cykl powtarza się w całej Księdze Sędziów?',
      options: <String>[
        'Niewierność, ucisk, wołanie do Boga, wybawienie',
        'Nieustanny pokój',
        'Ciągła wojna domowa',
        'Stała migracja',
      ],
      correctIndex: 0,
      explanation: 'Ten cykl kształtuje całą księgę (Sędziów 2).',
    ),
    QuizQuestion(
      text: 'Kto poprowadził wojsko Izraela przeciw Siserze, z pomocą Debory?',
      options: <String>['Barak', 'Ehud', 'Otniel', 'Gedeon'],
      correctIndex: 0,
      explanation: 'Debora i Barak prowadzą Izraela do zwycięstwa (Sędziów 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Jak Gedeon zmniejszył swoje wojsko do 300 mężczyzn?',
      options: <String>[
        'Obserwując, jak piją wodę',
        'Ciągnąc losy',
        'Wybierając najmłodszych',
        'Wybierając najbogatszych',
      ],
      correctIndex: 0,
      explanation: 'Próba z wodą wybiera 300 mężczyzn (Sędziów 7).',
    ),
  ],
  'Judges#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak zakończyły się rządy Abimeleka?',
      options: <String>[
        'Zginął uderzony kamieniem młyńskim rzuconym przez kobietę',
        'Panował w pokoju przez długi czas',
        'Został wygnany bez przemocy',
        'Założył trwałą dynastię',
      ],
      correctIndex: 0,
      explanation:
          'Abimelek umiera od kamienia młyńskiego rzuconego przez kobietę (Sędziów 9).',
    ),
    QuizQuestion(
      text: 'Jaki tragiczny ślub złożył Jefte przed bitwą?',
      options: <String>[
        'Że ofiaruje pierwszą osobę, która wyjdzie z jego domu',
        'Że będzie pościł przez rok',
        'Że zniszczy swój dom',
        'Że nigdy się nie ożeni',
      ],
      correctIndex: 0,
      explanation:
          'Jego córka jako pierwsza wychodzi mu na spotkanie (Sędziów 11).',
    ),
    QuizQuestion(
      text: 'Po czym rozpoznawano Efraimitów przy przeprawie przez Jordan?',
      options: <String>[
        'Nie potrafili poprawnie wymówić słowa „Szibbolet”',
        'Po ich ubraniu',
        'Po ich śpiewnym akcencie',
        'Po ich broni',
      ],
      correctIndex: 0,
      explanation: 'Hasło demaskuje tych, którzy próbują uciec (Sędziów 12).',
    ),
  ],
  'Judges#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaką improwizowaną bronią Samson pokonał tysiąc Filistynów?',
      options: <String>['Oślą szczęką', 'Mieczem', 'Procą', 'Laską'],
      correctIndex: 0,
      explanation: 'Samson pokonuje ich oślą szczęką (Sędziów 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['miecz', 'lew', 'Filistyni'],
    ),
    QuizQuestion(
      text: 'Kto zdradził Filistynom sekret siły Samsona?',
      options: <String>[
        'Delila',
        'Jego matka',
        'Rywalizujący sędzia',
        'Kapłan',
      ],
      correctIndex: 0,
      explanation:
          'Delila odkrywa, że jego siła pochodzi z włosów (Sędziów 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Jakie zdanie podsumowuje stan Izraela pod koniec księgi?',
      options: <String>[
        'Każdy robił to, co było słuszne w jego własnych oczach',
        'Panował sprawiedliwy król',
        'Wszędzie panował pokój',
        'Kapłani dobrze rządzili',
      ],
      correctIndex: 0,
      explanation: 'Ta uwaga kończy kilka relacji w księdze (Sędziów 17, 21).',
    ),
  ],
  'Ruth#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego Noemi i jej rodzina udali się do Moabu?',
      options: <String>[
        'Z powodu głodu w Betlejem',
        'Aby uciec przed wojną',
        'W celach handlowych',
        'Na rozkaz sędziego',
      ],
      correctIndex: 0,
      explanation: 'Głód zmusza Elimelecha do emigracji (Rut 1).',
    ),
    QuizQuestion(
      text: 'Jaką decyzję podejmuje Rut wobec Noemi?',
      options: <String>[
        'Pozostać z nią: „Dokąd ty pójdziesz, tam ja pójdę”',
        'Wrócić do swego ludu',
        'Natychmiast wyjść za mąż w Moabie',
        'Zostać samej w Moabie',
      ],
      correctIndex: 0,
      explanation: 'Rut wyraża słynne, lojalne oddanie (Rut 1:16).',
    ),
    QuizQuestion(
      text: 'Co stało się z mężami Noemi i jej synowych?',
      options: <String>[
        'Wszyscy zmarli w Moabie',
        'Wrócili do Betlejem',
        'Prosperowali w Moabie',
        'Założyli miasto',
      ],
      correctIndex: 0,
      explanation:
          'Elimelech, a potem jego dwaj synowie, umierają w Moabie (Rut 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Betlejem', 'Noemi', 'głód'],
    ),
  ],
  'Ruth#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co robiła Rut na polach Boaza?',
      options: <String>[
        'Zbierała kłosy pozostawione przez żniwiarzy',
        'Sprzedawała tkaniny',
        'Pasła trzody',
        'Nauczała Prawa',
      ],
      correctIndex: 0,
      explanation: 'Rut zbiera kłosy, aby wyżywić siebie i Noemi (Rut 2).',
    ),
    QuizQuestion(
      text: 'Jak Boaz okazał życzliwość Rut?',
      options: <String>[
        'Pozwalając jej bezpiecznie zbierać kłosy i dzieląc się z nią posiłkiem',
        'Grzecznie ją ignorując',
        'Odsyłając ją z pola',
        'Żądając zapłaty',
      ],
      correctIndex: 0,
      explanation: 'Boaz chroni Rut i okazuje jej przychylność (Rut 2).',
    ),
    QuizQuestion(
      text: 'Co Noemi radzi Rut zrobić w związku z Boazem?',
      options: <String>[
        'Pójść na klepisko i dać mu się poznać',
        'Całkowicie go unikać',
        'Wyjechać do Moabu',
        'Wyjść za innego mężczyznę',
      ],
      correctIndex: 0,
      explanation: 'Noemi kieruje Rut ku możliwemu wykupieniu (Rut 3).',
    ),
  ],
  'Ruth#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Boaz rozstrzygnął sprawę prawa wykupu przed starszymi?',
      options: <String>[
        'Bliższy krewny publicznie zrzekł się swojego prawa',
        'Zdecydowało losowanie',
        'Zdecydował król',
        'Nikogo nie konsultowano',
      ],
      correctIndex: 0,
      explanation: 'Postępowanie prawne odbywa się przy bramie miasta (Rut 4).',
    ),
    QuizQuestion(
      text: 'Kto był synem Rut i Boaza?',
      options: <String>['Obed', 'Dawid', 'Jesse', 'Salomon'],
      correctIndex: 0,
      explanation: 'Obed zostaje dziadkiem Dawida (Rut 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Dlaczego Księga Rut kończy się rodowodem?',
      options: <String>[
        'Aby połączyć Rut z linią prowadzącą do Dawida',
        'Po prostu jako literacka tradycja',
        'Aby zamknąć spór prawny',
        'Aby uhonorować Moab',
      ],
      correctIndex: 0,
      explanation: 'Rodowód łączy Rut z Dawidem (Rut 4:17-22).',
    ),
  ],
};

const Map<String, List<QuizQuestion>>
extraQuizzesPlC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Które drzewo w ogrodzie Eden było zakazane dla Adama i Ewy?',
      options: <String>[
        'Drzewo poznania dobra i zła',
        'Drzewo życia',
        'Drzewo figowe',
        'Drzewo oliwne',
      ],
      correctIndex: 0,
      explanation: 'Bóg zakazuje wyłącznie tego jednego drzewa (Rodzaju 2:17).',
    ),
    QuizQuestion(
      text: 'Kto zwiódł Ewę, by zjadła zakazany owoc?',
      options: <String>['Wąż', 'Kain', 'Anioł', 'Adam'],
      correctIndex: 0,
      explanation: 'Wąż doprowadza ją do nieposłuszeństwa (Rodzaju 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['wąż'],
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Który ptak, wysłany przez Noego, wrócił z liściem oliwnym?',
      options: <String>['Gołąb', 'Kruk', 'Orzeł', 'Wróbel'],
      correctIndex: 0,
      explanation: 'Gołąb pokazuje, że wody opadały (Rodzaju 8).',
    ),
    QuizQuestion(
      text:
          'Kto, król Salem i kapłan Boga Najwyższego, pobłogosławił '
          'Abrama?',
      options: <String>['Melchizedek', 'Lot', 'Faraon', 'Izaak'],
      correctIndex: 0,
      explanation:
          'Melchizedek błogosławi Abramowi po zwycięstwie (Rodzaju 14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Genesis#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki znak przymierza dał Bóg Abrahamowi?',
      options: <String>['Obrzezanie', 'Tatuaż', 'Pierścień', 'Laskę'],
      correctIndex: 0,
      explanation: 'Obrzezanie oznacza przymierze (Rodzaju 17).',
    ),
    QuizQuestion(
      text: 'Jak nazywał się syn Abrahama i Hagar?',
      options: <String>['Ismael', 'Izaak', 'Ezaw', 'Jakub'],
      correctIndex: 0,
      explanation: 'Ismael rodzi się z Hagar, służącej (Rodzaju 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Które miasta Bóg zniszczył z powodu ich niegodziwości?',
      options: <String>[
        'Sodomę i Gomorę',
        'Babel i Ur',
        'Niniwę i Tyr',
        'Betel i Aj',
      ],
      correctIndex: 0,
      explanation: 'Ogień niszczy te miasta; Lot zostaje ocalony (Rodzaju 19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Lot', 'Egipt', 'Niniwa'],
    ),
  ],
  'Genesis#3': <QuizQuestion>[
    QuizQuestion(
      text: 'O co Bóg poprosił Abrahama, by ofiarował na górze Moria?',
      options: <String>[
        'Swojego syna Izaaka',
        'Barana',
        'Swój namiot',
        'Swoje trzody',
      ],
      correctIndex: 0,
      explanation: 'Bóg powstrzymuje Abrahama i zapewnia barana (Rodzaju 22).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Izaak'],
    ),
    QuizQuestion(
      text: 'Za co Ezaw sprzedał Jakubowi swoje pierworodztwo?',
      options: <String>[
        'Za miskę soczewicy',
        'Za złoto',
        'Za trzodę',
        'Za namiot',
      ],
      correctIndex: 0,
      explanation: 'Ezaw lekceważy swoje pierworodztwo (Rodzaju 25).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['chleb', 'gulasz', 'Ezaw'],
    ),
    QuizQuestion(
      text: 'Co Jakub zobaczył we śnie w Betel?',
      options: <String>[
        'Schody sięgające nieba, po których wędrowali aniołowie',
        'Wzburzone morze',
        'Płonący krzew',
        'Miasto w ruinie',
      ],
      correctIndex: 0,
      explanation: 'Bóg potwierdza swoje obietnice wobec Jakuba (Rodzaju 28).',
    ),
  ],
  'Genesis#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie nowe imię otrzymał Jakub po zmaganiu się z aniołem?',
      options: <String>['Izrael', 'Edom', 'Abraham', 'Efraim'],
      correctIndex: 0,
      explanation: 'Imię Izrael oznacza „walczy z Bogiem” (Rodzaju 32).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Ilu synów miał Jakub, którzy stali się przodkami plemion Izraela?',
      options: <String>['Dwunastu', 'Dziesięciu', 'Siedmiu', 'Czternastu'],
      correctIndex: 0,
      explanation: 'Jego dwunastu synów zakłada plemiona Izraela (Rodzaju 35).',
    ),
    QuizQuestion(
      text: 'Z kim pojednał się Jakub po latach rozłąki?',
      options: <String>[
        'Ze swoim bratem Ezawem',
        'Z Labanem',
        'Z faraonem',
        'Z Izaakiem',
      ],
      correctIndex: 0,
      explanation: 'Obaj bracia spotykają się ponownie w pokoju (Rodzaju 33).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jakub', 'Laban', 'Józef'],
    ),
  ],
  'Genesis#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Co z zazdrości zrobili bracia Józefa?',
      options: <String>[
        'Sprzedali go jako niewolnika',
        'Ukoronowali go na króla',
        'Porzucili go w Egipcie',
        'Zignorowali go',
      ],
      correctIndex: 0,
      explanation: 'Józef zostaje sprzedany i zabrany do Egiptu (Rodzaju 37).',
    ),
    QuizQuestion(
      text: 'Jaką specjalną szatę dał Jakub Józefowi?',
      options: <String>[
        'Piękną szatę',
        'Koronę',
        'Zbroję',
        'Płaszcz kapłański',
      ],
      correctIndex: 0,
      explanation: 'Ten dar wzbudza zazdrość jego braci (Rodzaju 37).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['płaszcz', 'pierścień', 'sandały'],
    ),
    QuizQuestion(
      text:
          'Co zinterpretował Józef dla faraona, zapowiadając siedem lat głodu?',
      options: <String>[
        'Sny faraona',
        'Starożytną księgę',
        'Gwiazdy',
        'Wyrocznię',
      ],
      correctIndex: 0,
      explanation: 'Józef interpretuje sny faraona (Rodzaju 41).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['sny', 'jego sny', 'sny faraona'],
    ),
  ],
  'Genesis#6': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Józef potraktował swoich braci, gdy się przed nimi ujawnił?',
      options: <String>[
        'Przebaczył im',
        'Uwięził ich dożywotnio',
        'Przepędził ich',
        'Zignorował ich',
      ],
      correctIndex: 0,
      explanation: 'Józef przebacza im i troszczy się o nich (Rodzaju 45).',
    ),
    QuizQuestion(
      text: 'Gdzie osiedlili się Jakub i jego rodzina w Egipcie?',
      options: <String>[
        'W krainie Goszen',
        'W Memfis',
        'W Tebach',
        'Na Synaju',
      ],
      correctIndex: 0,
      explanation: 'Faraon daje im region Goszen (Rodzaju 47).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Kanaan', 'Egipt', 'Nil'],
    ),
    QuizQuestion(
      text: 'Jak Józef postrzegał krzywdę, jaką wyrządzili mu bracia?',
      options: <String>[
        'Bóg obrócił ją w dobro, aby ocalić życie',
        'Jako niesprawiedliwość do pomszczenia',
        'Jako coś nieistotnego',
        'Jako zwykły przypadek',
      ],
      correctIndex: 0,
      explanation: 'Słynne oświadczenie wiary (Rodzaju 50:20).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Kim był brat Mojżesza, wyznaczony na jego rzecznika?',
      options: <String>['Aaron', 'Jozue', 'Jetro', 'Kaleb'],
      correctIndex: 0,
      explanation: 'Aaron przemawia do ludu w imieniu Mojżesza (Wyjścia 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Jakim imieniem Jehowa przedstawił się Mojżeszowi przy '
          'płonącym krzewie?',
      options: <String>[
        '„Stanę się, kim zechcę się stać”',
        '„Bóg bez imienia”',
        '„Ukryty Bóg”',
        '„Król królów”',
      ],
      correctIndex: 0,
      explanation: 'Bóg objawia znaczenie swojego imienia (Wyjścia 3:14).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka była dziesiąta i ostatnia plaga na Egipt?',
      options: <String>[
        'Śmierć pierworodnych',
        'Szarańcza',
        'Ciemność',
        'Grad',
      ],
      correctIndex: 0,
      explanation:
          'Ta plaga ostatecznie skłania faraona do uwolnienia Izraela (Wyjścia 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['plaga', 'szarańcza', 'grad'],
    ),
    QuizQuestion(
      text: 'Co Izraelici mieli umieścić na swoich drzwiach podczas Paschy?',
      options: <String>['Krew baranka', 'Oliwę', 'Mąkę', 'Znak z popiołu'],
      correctIndex: 0,
      explanation: 'Krew chroni ich pierworodnych (Wyjścia 12).',
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak popłynęła woda dla spragnionego ludu przy Horebie?',
      options: <String>[
        'Mojżesz uderzył skałę',
        'Źródło pojawiło się samoistnie',
        'Padał ulewny deszcz',
        'Wykopano studnię',
      ],
      correctIndex: 0,
      explanation: 'Na polecenie Boga Mojżesz uderza skałę (Wyjścia 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aaron', 'laska', 'woda'],
    ),
    QuizQuestion(
      text: 'Ile przykazań składa się na Dekalog dany na Synaju?',
      options: <String>['Dziesięć', 'Siedem', 'Dwanaście', 'Pięć'],
      correctIndex: 0,
      explanation: 'Dziesięć Przykazań zostaje danych na Synaju (Wyjścia 20).',
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Co miała zawierać Arka Przymierza?',
      options: <String>[
        'Tablice Prawa',
        'Złoto i srebro',
        'Zwoje proroctw',
        'Ofiary z pokarmu',
      ],
      correctIndex: 0,
      explanation:
          'Tablice z przykazaniami zostają umieszczone w jej wnętrzu (Wyjścia 25).',
    ),
    QuizQuestion(
      text: 'Kto zrobił złotego cielca, gdy Mojżesz przebywał na górze?',
      options: <String>['Aaron', 'Jozue', 'Chur', 'Besalel'],
      correctIndex: 0,
      explanation: 'Aaron ulega żądaniu ludu (Wyjścia 32).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Co było charakterystyczne w twarzy Mojżesza po rozmowie z Bogiem?',
      options: <String>[
        'Promieniała',
        'Była okryta smutkiem',
        'Postarzała się',
        'Nic szczególnego',
      ],
      correctIndex: 0,
      explanation:
          'Mojżesz musiał zasłaniać swoją promieniejącą twarz (Wyjścia 34).',
    ),
    QuizQuestion(
      text: 'Co wypełniło przybytek po jego ukończeniu?',
      options: <String>[
        'Chwała Jehowy (obłok)',
        'Sam dym kadzidła',
        'Sztuczne światło',
        'Nic widocznego',
      ],
      correctIndex: 0,
      explanation: 'Obłok sygnalizuje boską obecność (Wyjścia 40).',
    ),
  ],
};
