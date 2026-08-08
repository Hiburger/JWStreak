import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesPlC3 = <String, List<QuizQuestion>>{
  'Esther#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego królowa Waszti została usunięta ze swojego stanowiska?',
      options: <String>[
        'Odmówiła stawienia się przed królem i jego gośćmi',
        'Spiskowała przeciwko królowi',
        'Zachorowała',
        'Opuściła pałac',
      ],
      correctIndex: 0,
      explanation: 'Jej odmowa prowadzi do jej odsunięcia (Estery 1).',
    ),
    QuizQuestion(
      text: 'Kogo wychował Mardocheusz i kto została królową?',
      options: <String>[
        'Esterę, swoją kuzynkę',
        'Swoją córkę',
        'Swoją siostrę',
        'Obcą niewolnicę',
      ],
      correctIndex: 0,
      explanation: 'Estera zostaje wybrana na nową królową (Estery 2).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Estera'],
    ),
    QuizQuestion(
      text: 'Dlaczego Haman chciał wytępić wszystkich Żydów w imperium?',
      options: <String>[
        'Mardocheusz odmówił mu pokłonu',
        'Żydzi byli mu winni dług',
        'Król mu to nakazał',
        'Właśnie wybuchła wojna',
      ],
      correctIndex: 0,
      explanation: 'Gniew Hamana przeradza się w plan ludobójstwa (Estery 3).',
    ),
  ],
  'Esther#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Jakie słynne słowa mówi Mardocheusz do Estery, by przekonać ją do działania?',
      options: <String>[
        '„Kto wie, czy nie właśnie na taki czas jak ten...”',
        '„Uciekaj, póki jest jeszcze czas”',
        '„To nie nasz problem”',
        '„Król nigdy cię nie wysłucha”',
      ],
      correctIndex: 0,
      explanation: 'Ten apel skłania Esterę do działania (Estery 4).',
    ),
    QuizQuestion(
      text: 'Co się stało, gdy król nie mógł zasnąć?',
      options: <String>[
        'Odkrył, że Mardocheusz nigdy nie został nagrodzony',
        'Natychmiast wezwał Esterę',
        'Kazał od razu stracić Hamana',
        'Anulował swój dekret',
      ],
      correctIndex: 0,
      explanation: 'Ten opatrznościowy szczegół odwraca sytuację (Estery 6).',
    ),
    QuizQuestion(
      text: 'Jak Estera ujawniła spisek Hamana?',
      options: <String>[
        'Na drugim bankiecie, przed królem',
        'Za pomocą anonimowego listu',
        'Publicznie przed całym narodem',
        'Za pośrednictwem sługi',
      ],
      correctIndex: 0,
      explanation: 'Haman zostaje zdemaskowany i stracony (Estery 7).',
    ),
  ],
  'Esther#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak nowy dekret przeciwdziałał dekretowi Hamana?',
      options: <String>[
        'Pozwolił Żydom się bronić',
        'Całkowicie anulował pierwszy dekret',
        'Wygnał wszystkich Persów',
        'Niczego nie zmienił',
      ],
      correctIndex: 0,
      explanation:
          'Nieodwołalny dekret trzeba było przeciwstawić innym (Estery 8).',
    ),
    QuizQuestion(
      text: 'Jakie święto ustanowiono, aby upamiętnić to wybawienie?',
      options: <String>[
        'Purim',
        'Paschę',
        'Święto Szałasów',
        'Rok Jubileuszowy',
      ],
      correctIndex: 0,
      explanation: 'Purim wciąż upamiętnia to wydarzenie (Estery 9).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Jakie stanowisko ostatecznie zajął Mardocheusz?',
      options: <String>[
        'Wysokie stanowisko, ustępujące tylko królowi',
        'Został wygnany',
        'Pozostał zwykłym urzędnikiem',
        'Opuścił Persję',
      ],
      correctIndex: 0,
      explanation: 'Mardocheusz działa dla dobra swego ludu (Estery 10).',
    ),
  ],
  'Job#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie wyzwanie stawia Szatan Bogu w związku z Hiobem?',
      options: <String>[
        'Hiob służyłby Bogu tylko dla osobistej korzyści',
        'Hiob tak naprawdę nie istnieje',
        'Hiob jest już niewierny',
        'Hiob chce porzucić swoją rodzinę',
      ],
      correctIndex: 0,
      explanation: 'Szatan kwestionuje motywację Hioba (Hioba 1).',
    ),
    QuizQuestion(
      text: 'Jak zareagował Hiob po utracie wszystkiego?',
      options: <String>[
        'Nie zgrzeszył ani nie oskarżył Boga o zło',
        'Przeklął Boga',
        'Szukał zemsty',
        'Porzucił wiarę',
      ],
      correctIndex: 0,
      explanation: 'Jego prawość pozostaje nienaruszona mimo próby (Hioba 1).',
    ),
    QuizQuestion(
      text: 'Co radzi żona Hioba po jego chorobie?',
      options: <String>[
        'Aby przeklął Boga i umarł',
        'Aby skonsultował się z lekarzem',
        'Aby uciekł daleko od domu',
        'Aby cierpliwie milczał',
      ],
      correctIndex: 0,
      explanation: 'Hiob odrzuca tę desperacką radę (Hioba 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['błogosław', 'módl się', 'cierp'],
    ),
  ],
  'Job#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki jest główny argument Bildada w jego pierwszej mowie?',
      options: <String>[
        'Mądrość przodków dowodzi, że Bóg jest sprawiedliwy',
        'Bóg nie istnieje',
        'Hiob jest niewinny',
        'Cierpienie nie ma przyczyny',
      ],
      correctIndex: 0,
      explanation: 'Bildad powołuje się na tradycję (Hioba 8).',
    ),
    QuizQuestion(
      text: 'Czego głęboko pragnie Hiob w swojej odpowiedzi Bildadowi?',
      options: <String>[
        'Pośrednika między nim a Bogiem',
        'Pieniędzy na spłatę długów',
        'Zemsty na przyjaciołach',
        'Nowej trzody, natychmiast',
      ],
      correctIndex: 0,
      explanation:
          'Hiob pragnie sprawiedliwie przedstawić swoją sprawę (Hioba 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['przyjaciel', 'sędzia', 'anioł'],
    ),
    QuizQuestion(
      text: 'Co radzi Sofar Hiobowi w swojej pierwszej mowie?',
      options: <String>[
        'Aby okazał skruchę za ukryty grzech',
        'Aby opuścił rodzinę',
        'Aby skonsultował się z innym mędrcem',
        'Aby zamilkł na zawsze',
      ],
      correctIndex: 0,
      explanation: 'Sofar zakłada, że Hiob ukrywa jakąś winę (Hioba 11).',
    ),
  ],
  'Job#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie słynne oświadczenie wypowiada Hiob pomimo swego cierpienia?',
      options: <String>[
        '„Wiem, że mój Odkupiciel żyje”',
        '„Bóg opuścił mnie na zawsze”',
        '„Życie nie ma sensu”',
        '„Wolałbym teraz umrzeć”',
      ],
      correctIndex: 0,
      explanation: 'Ta deklaracja nadziei wyróżnia Hioba 19.',
    ),
    QuizQuestion(
      text: 'Jaką obserwację czyni Hiob na temat losu niegodziwych?',
      options: <String>[
        'Często wydają się prosperować mimo swojego postępowania',
        'Zawsze są natychmiast karani',
        'Właściwie nie istnieją',
        'Zawsze kończą w biedzie',
      ],
      correctIndex: 0,
      explanation:
          'Hiob kwestionuje uproszczoną teorię swoich przyjaciół (Hioba 21).',
    ),
    QuizQuestion(
      text:
          'Jak Hiob opisuje traktowanie, jakiego doświadcza ze strony przyjaciół w tych rozdziałach?',
      options: <String>[
        'Czuje się przez nich opuszczony i niezrozumiany',
        'Serdecznie im dziękuje',
        'Zgadza się ze wszystkimi ich argumentami',
        'W ogóle o nich nie wspomina',
      ],
      correctIndex: 0,
      explanation:
          'Hiob wyraża rozgoryczenie z powodu ich braku współczucia (Hioba 16-17).',
    ),
  ],
  'Job#3': <QuizQuestion>[
    QuizQuestion(
      text: 'O co dokładnie oskarża Elifaz Hioba w swojej trzeciej mowie?',
      options: <String>[
        'O konkretne grzechy, takie jak uciskanie biednych',
        'O obrabowanie świątyni',
        'O wyparcie się rodziny',
        'O okłamywanie króla',
      ],
      correctIndex: 0,
      explanation:
          'Oskarżenia Elifaza stają się bardziej szczegółowe, lecz bez dowodów (Hioba 22).',
    ),
    QuizQuestion(
      text: 'Czego Hiob mocno pragnie w swojej odpowiedzi?',
      options: <String>[
        'Przedstawić swoją sprawę bezpośrednio przed Bogiem',
        'Uciec daleko od rodziny',
        'Zdobyć bogactwo',
        'Zemścić się na przyjaciołach',
      ],
      correctIndex: 0,
      explanation: 'Hiob szuka sprawiedliwego przesłuchania (Hioba 23).',
    ),
    QuizQuestion(
      text: 'Jaki centralny temat rozwija Hiob w rozdziale 28?',
      options: <String>[
        'Niezrównaną wartość mądrości',
        'Wydobywanie bogactwa',
        'Geografię pustyni',
        'Prawa dotyczące ofiar',
      ],
      correctIndex: 0,
      explanation:
          'Ten poemat wychwala mądrość, cenniejszą niż złoto (Hioba 28).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['złoto', 'srebro', 'perły'],
    ),
  ],
  'Job#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Hiob wspomina, mówiąc o swoich dawnych dniach?',
      options: <String>[
        'Szacunek i honor, jakie kiedyś otrzymywał',
        'Swoje skromne pochodzenie',
        'Życie pełne nieustannej wojny',
        'Swoje dzieciństwo za granicą',
      ],
      correctIndex: 0,
      explanation:
          'Hiob zestawia swoją zaszczytną przeszłość z obecną sytuacją (Hioba 29).',
    ),
    QuizQuestion(
      text: 'Co Hiob oświadcza w swojej końcowej przysiędze niewinności?',
      options: <String>[
        'Potwierdza, że nie popełnił żadnej z wymienionych win',
        'Przyznaje się do kilku grzechów',
        'Odmawia odpowiedzi',
        'Bezpośrednio oskarża Boga',
      ],
      correctIndex: 0,
      explanation:
          'Hiob kończy swoją obronę wszechstronną przysięgą (Hioba 31).',
    ),
    QuizQuestion(
      text: 'Kim jest Elihu, który przemawia po trzech przyjaciołach?',
      options: <String>[
        'Młodym mężczyzną, który uważa się za mądrego',
        'Aniołem posłanym przez Boga',
        'Czwartym, starszym przyjacielem',
        'Synem Hioba',
      ],
      correctIndex: 0,
      explanation:
          'Elihu interweniuje, ponieważ starsi nie przekonali Hioba (Hioba 32).',
    ),
  ],
  'Job#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Skąd ostatecznie przemawia Jehowa do Hioba?',
      options: <String>[
        'Z wichury',
        'Ze snu',
        'Przez widzialnego anioła',
        'Nigdy nie odpowiedział',
      ],
      correctIndex: 0,
      explanation: 'Bóg wreszcie odpowiada, lecz pytaniami (Hioba 38).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ogień', 'obłok', 'grom'],
    ),
    QuizQuestion(
      text: 'Czego głównie dotyczą pytania Jehowy skierowane do Hioba?',
      options: <String>[
        'Stworzenia i władzy nad naturą',
        'Ukrytych grzechów Hioba',
        'Polityki narodów',
        'Rytuałów świątynnych',
      ],
      correctIndex: 0,
      explanation: 'Bóg ukazuje ogrom swojej twórczej mądrości (Hioba 38-41).',
    ),
    QuizQuestion(
      text: 'Jak kończy się historia Hioba?',
      options: <String>[
        'Hiob pokornie okazuje skruchę, a Bóg przywraca mu dwukrotnie więcej dobytku',
        'Hiob umiera w nędzy',
        'Hiob do końca przeklina Boga',
        'Jego przyjaciele zostają nagrodzeni zamiast niego',
      ],
      correctIndex: 0,
      explanation:
          'Jehowa błogosławi Hiobowi bardziej niż wcześniej (Hioba 42).',
    ),
  ],
  'Psalms#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Do czego Psalm 1 porównuje szczęśliwego człowieka, który rozmyśla nad prawem Bożym?',
      options: <String>[
        'Do drzewa zasadzonego nad strumieniami wody',
        'Do solidnej skały',
        'Do ptaka w locie',
        'Do zapalonej lampy',
      ],
      correctIndex: 0,
      explanation: 'Obraz owocującego drzewa otwiera księgę (Psalm 1).',
    ),
    QuizQuestion(
      text: 'Co świętuje Psalm 19 w swojej pierwszej części?',
      options: <String>[
        'Chwałę Boga ukazaną na niebiosach',
        'Zwycięstwo króla',
        'Budowę świątyni',
        'Wygraną bitwę',
      ],
      correctIndex: 0,
      explanation: '„Niebiosa opowiadają o chwale Boga” (Psalm 19:1).',
    ),
    QuizQuestion(
      text: 'Jakie pytanie stawia Psalm 8 wobec ogromu stworzenia?',
      options: <String>[
        'Czym jest człowiek, że o nim pamiętasz?',
        'Dlaczego morze jest tak rozległe?',
        'Gdzie leży ogród Eden?',
        'Ile jest gwiazd?',
      ],
      correctIndex: 0,
      explanation:
          'Psalmista zdumiewa się miejscem danym człowiekowi (Psalm 8:4).',
    ),
  ],
  'Psalms#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Psalm 23 opisuje Jehowę?',
      options: <String>[
        'Jako pasterza, który troszczy się o swoje owce',
        'Jako surowego sędziego',
        'Jako odległego króla',
        'Jako mściwego wojownika',
      ],
      correctIndex: 0,
      explanation: '„Jehowa jest moim pasterzem” (Psalm 23:1).',
    ),
    QuizQuestion(
      text: 'Jakie prorocze słowa z Psalmu 22 zacytował Jezus na palu męki?',
      options: <String>[
        '„Boże mój, Boże mój, czemu mnie opuściłeś?”',
        '„Przyszedłem, aby sądzić”',
        '„Oto mój sługa”',
        '„Królestwo jest blisko”',
      ],
      correctIndex: 0,
      explanation:
          'Ten cytat łączy ten psalm z cierpieniem Chrystusa (Psalm 22:1).',
    ),
    QuizQuestion(
      text: 'Co Psalm 34 oświadcza o dobroci Jehowy?',
      options: <String>[
        'Skosztujcie i zobaczcie, że Jehowa jest dobry',
        'Jego dobroć pozostaje ukryta',
        'Dotyczy tylko kapłanów',
        'Jest ograniczona do Izraela',
      ],
      correctIndex: 0,
      explanation: 'Zaproszenie do doświadczenia dobroci Boga (Psalm 34:8).',
    ),
  ],
  'Psalms#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Jaką poruszającą modlitwę ułożył Dawid po swoim grzechu z Batszebą?',
      options: <String>[
        'Psalm 51, prosząc o czyste serce',
        'Pieśń zwycięstwa militarnego',
        'Proroctwo o Babilonie',
        'Pieśń koronacyjną',
      ],
      correctIndex: 0,
      explanation: '„Stwórz we mnie czyste serce, Boże” (Psalm 51:10).',
    ),
    QuizQuestion(
      text:
          'Do czego psalmista porównuje swoją głęboką tęsknotę za Bogiem w Psalmie 42?',
      options: <String>[
        'Do jelenia dyszącego za strumieniami wody',
        'Do głodnego lwa',
        'Do uwięzionego ptaka',
        'Do spieszącego się kupca',
      ],
      correctIndex: 0,
      explanation: 'Obraz intensywnego duchowego pragnienia (Psalm 42:1).',
    ),
    QuizQuestion(
      text: 'Jakie centralne stwierdzenie zawiera Psalm 46?',
      options: <String>[
        'Bóg jest naszym schronieniem i siłą',
        'Narody zawsze będą żyć w pokoju',
        'Świątynia nigdy nie zostanie zniszczona',
        'Król jest naszą jedyną nadzieją',
      ],
      correctIndex: 0,
      explanation: '„Bóg jest naszym schronieniem i siłą” (Psalm 46:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pasterz', 'skała', 'twierdza'],
    ),
  ],
  'Psalms#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Za kogo Psalm 72 jest modlitwą błogosławieństwa dotyczącą sprawiedliwego i pomyślnego panowania?',
      options: <String>[
        'Za króla (Salomona, a prorokiem za Mesjasza)',
        'Wyłącznie za kapłanów',
        'Za wrogie narody',
        'Za proroków',
      ],
      correctIndex: 0,
      explanation:
          'Ten mesjański psalm opisuje trwałe panowanie pokoju (Psalm 72).',
    ),
    QuizQuestion(
      text: 'Jaki dylemat trapi Asafa w Psalmie 73?',
      options: <String>[
        'Pozorna pomyślność niegodziwych',
        'Ubóstwo świątyni',
        'Brak deszczu',
        'Milczenie proroków',
      ],
      correctIndex: 0,
      explanation:
          'Asaf rozwiązuje ten problem, wchodząc do sanktuarium Boga (Psalm 73:17).',
    ),
    QuizQuestion(
      text: 'Jaki obraz opisuje potężny pochód Boga w Psalmie 68?',
      options: <String>[
        'Jedzie przez pustynię dla swego ludu',
        'Pozostaje na stałe ukryty',
        'Żegluje wyłącznie po morzach',
        'Walczy sam, nie interweniując',
      ],
      correctIndex: 0,
      explanation: 'Poetycki język boskiej mocy (Psalm 68).',
    ),
  ],
  'Psalms#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'O co Mojżesz prosi Boga w Psalmie 90 w związku z krótkością życia?',
      options: <String>[
        'Aby nauczył nas mądrze liczyć nasze dni',
        'Aby bez ograniczeń przedłużył ludzkie życie',
        'Aby zatarł pamięć o śmierci',
        'Aby przyspieszył czas',
      ],
      correctIndex: 0,
      explanation: '„Naucz nas właściwie liczyć nasze dni” (Psalm 90:12).',
    ),
    QuizQuestion(
      text: 'Jaką obietnicę ochrony oferuje Psalm 91?',
      options: <String>[
        'Kto mieszka w schronieniu Najwyższego, jest chroniony',
        'Nie składa się żadnej obietnicy',
        'Chronieni są tylko królowie',
        'Ochrona zależy od ofiar',
      ],
      correctIndex: 0,
      explanation: 'Obraz schronienia pod boskimi skrzydłami (Psalm 91).',
    ),
    QuizQuestion(
      text: 'Co Psalm 84 mówi o miejscu zamieszkania Boga?',
      options: <String>[
        'Że jest nieskończenie pożądane i umiłowane',
        'Że jest groźne',
        'Że wkrótce zostanie zniszczone',
        'Że jest zarezerwowane dla królów',
      ],
      correctIndex: 0,
      explanation: '„Jakże miłe są twoje mieszkania!” (Psalm 84:1).',
    ),
  ],
  'Psalms#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Do jakiego zaproszenia wzywa Psalm 100 na początku?',
      options: <String>[
        'Radośnie wykrzykujcie i wejdźcie z dziękczynieniem',
        'Zachowajcie całkowitą ciszę',
        'Uciekajcie daleko od świątyni',
        'Płaczcie nad swoimi grzechami',
      ],
      correctIndex: 0,
      explanation: 'Radosne wezwanie do zbiorowej pochwały (Psalm 100).',
    ),
    QuizQuestion(
      text: 'O czym przypomina Psalm 103 w związku z przebaczeniem Boga?',
      options: <String>[
        'Przebacza wszystkie nasze winy, jak ojciec okazuje współczucie',
        'Nigdy nie przebacza',
        'Przebaczenie zależy od codziennej ofiary',
        'Przebaczani są tylko kapłani',
      ],
      correctIndex: 0,
      explanation: 'Czuły obraz ojcowskiego współczucia (Psalm 103:13).',
    ),
    QuizQuestion(
      text:
          'Jakie słowa z Psalmu 110 są stosowane do Chrystusa w Pismach Greckich?',
      options: <String>[
        '„Usiądź po mojej prawicy”',
        '„Będziesz królem Babilonu”',
        '„Wróć do Egiptu”',
        '„Zbuduj moją świątynię”',
      ],
      correctIndex: 0,
      explanation: 'Sam Jezus cytuje ten werset (Psalm 110:1).',
    ),
  ],
  'Psalms#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Jaki jest główny temat Psalmu 119, najdłuższego rozdziału w Biblii?',
      options: <String>[
        'Miłość do prawa i słowa Bożego',
        'Historyczna bitwa',
        'Budowa świątyni',
        'Podróż do Egiptu',
      ],
      correctIndex: 0,
      explanation: 'Każda sekcja rozmyśla nad boskim prawem (Psalm 119).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['świątynia', 'król', 'ofiara'],
    ),
    QuizQuestion(
      text: 'Skąd, jak mówi psalmista, pochodzi jego pomoc w Psalmie 121?',
      options: <String>[
        'Od Jehowy, stwórcy nieba i ziemi',
        'Od samych gór',
        'Od wojska króla',
        'Od kapłanów świątynnych',
      ],
      correctIndex: 0,
      explanation:
          '„Podnoszę oczy ku górom... Moja pomoc pochodzi od Jehowy” (Psalm 121).',
    ),
    QuizQuestion(
      text: 'O czym przypomina Psalm 127 w związku z ludzkimi planami?',
      options: <String>[
        'Bez Jehowy budowniczowie trudzą się na próżno',
        'Sukces zależy tylko od wysiłku',
        'Decyduje wyłącznie przypadek',
        'Dzieci nie są błogosławieństwem',
      ],
      correctIndex: 0,
      explanation: '„Jeśli Jehowa nie zbuduje domu...” (Psalm 127:1).',
    ),
  ],
  'Psalms#7': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka rozdzierająca serce scena otwiera Psalm 137?',
      options: <String>[
        'Wygnańcy płaczący nad rzekami Babilonu',
        'Uczta koronacyjna',
        'Zwycięska bitwa',
        'Budowa świątyni',
      ],
      correctIndex: 0,
      explanation:
          '„Nad rzekami Babilonu siedzieliśmy i płakaliśmy” (Psalm 137:1).',
    ),
    QuizQuestion(
      text: 'Jak Psalm 145 opisuje Jehowę?',
      options: <String>[
        'Jako wielkiego i godnego niezmierzonej chwały',
        'Jako odległego i obojętnego',
        'Jako wyłącznie surowego',
        'Jako milczącego wobec swego ludu',
      ],
      correctIndex: 0,
      explanation: 'Psalm hojnej pochwały (Psalm 145:3).',
    ),
    QuizQuestion(
      text: 'Jakim wezwaniem kończy się sam ostatni psalm, Psalm 150?',
      options: <String>[
        'Niech wszystko, co oddycha, wysławia Jah',
        'Niech wszystko na zawsze zamilknie',
        'Niech tylko królowie wysławiają Boga',
        'Niech muzyka będzie zakazana',
      ],
      correctIndex: 0,
      explanation:
          'Księga kończy się powszechnym wezwaniem do chwały (Psalm 150:6).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['niebiosa', 'trąba', 'śpiewajcie'],
    ),
  ],
  'Proverbs#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Co jest, według Przysłów 1, początkiem wiedzy?',
      options: <String>[
        'Bojaźń Jehowy',
        'Bogactwo',
        'Sama doświadczenie',
        'Formalna edukacja',
      ],
      correctIndex: 0,
      explanation: 'Ta podstawowa zasada otwiera księgę (Przysłów 1:7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['mądrość', 'wiedza', 'bogactwo'],
    ),
    QuizQuestion(
      text: 'Co radzi Przysłów 3 w kwestii zaufania?',
      options: <String>[
        'Ufaj Jehowie całym sercem',
        'Polegaj tylko na własnym rozumie',
        'Unikaj każdej ważnej decyzji',
        'Podążaj za opinią większości',
      ],
      correctIndex: 0,
      explanation: '„Ufaj Jehowie całym sercem” (Przysłów 3:5).',
    ),
    QuizQuestion(
      text: 'Jak mądrość jest uosobiona w Przysłów 8?',
      options: <String>[
        'Jako głos publicznie wołający do ludzi',
        'Jako wspomniany, lecz niewidzialny skarb',
        'Jako milczący król',
        'Jako zamknięta księga',
      ],
      correctIndex: 0,
      explanation: 'Mądrość woła głośno na placach publicznych (Przysłów 8).',
    ),
  ],
  'Proverbs#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Przysłów 15 mówi o tym, jak reagować na gniew?',
      options: <String>[
        'Łagodna odpowiedź odwraca srogi gniew',
        'Zawsze trzeba reagować stanowczo',
        'Milczenie jest zawsze lepsze',
        'Gniew trzeba całkowicie ignorować',
      ],
      correctIndex: 0,
      explanation: '„Łagodna odpowiedź odwraca srogi gniew” (Przysłów 15:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ostre', 'słowo', 'krzyk'],
    ),
    QuizQuestion(
      text: 'Co Przysłów 16 mówi o naszych planach i Jehowie?',
      options: <String>[
        'Powierz swoje dzieła Jehowie, a twoje plany się powiodą',
        'Ludzkie plany zależą tylko od nas samych',
        'Jehowa ignoruje nasze codzienne decyzje',
        'Lepiej niczego nie planować',
      ],
      correctIndex: 0,
      explanation: '„Powierz swoje dzieła Jehowie” (Przysłów 16:3).',
    ),
    QuizQuestion(
      text: 'Co reprezentuje mądra kobieta budująca swój dom w Przysłów 14?',
      options: <String>[
        'Praktyczną mądrość, która buduje i zachowuje',
        'Obcą królową',
        'Prostą pracownicę',
        'Nieistotną postać drugoplanową',
      ],
      correctIndex: 0,
      explanation:
          'Ten obraz ilustruje budujący wpływ mądrości (Przysłów 14:1).',
    ),
  ],
  'Proverbs#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Przysłów 18 mówi o mocy języka?',
      options: <String>[
        'Śmierć i życie są w mocy języka',
        'Nie ma on prawdziwego wpływu',
        'Dotyczy to tylko władców',
        'Jest zawsze nieszkodliwy',
      ],
      correctIndex: 0,
      explanation: 'Silny obraz wpływu słów (Przysłów 18:21).',
    ),
    QuizQuestion(
      text: 'Co Przysłów 19 mówi o życzliwości wobec biednych?',
      options: <String>[
        'To jak pożyczanie samemu Jehowie',
        'To strata czasu',
        'Dotyczy tylko bogatych',
        'Osłabia społeczeństwo',
      ],
      correctIndex: 0,
      explanation:
          '„Kto okazuje łaskę biednemu, pożycza Jehowie” (Przysłów 19:17).',
    ),
    QuizQuestion(
      text: 'Co jest, według Przysłów 22, lepsze niż wielkie bogactwo?',
      options: <String>[
        'Dobra reputacja',
        'Wielki pałac',
        'Potężne wojsko',
        'Rozległe terytorium',
      ],
      correctIndex: 0,
      explanation:
          '„Dobre imię jest bardziej pożądane niż wielkie bogactwo” (Przysłów 22:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['bogactwo', 'złoto', 'srebro'],
    ),
  ],
  'Proverbs#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Co Przysłów 27 mówi o tym, jak jeden przyjaciel wpływa na drugiego?',
      options: <String>[
        'Żelazo ostrzy żelazo, tak jeden człowiek ostrzy drugiego',
        'Przyjaciele nie mają żadnego wpływu',
        'Lepiej pozostać samemu',
        'Przyjaciele osłabiają charakter',
      ],
      correctIndex: 0,
      explanation: 'Obraz pozytywnego wzajemnego wpływu (Przysłów 27:17).',
    ),
    QuizQuestion(
      text: 'Co Przysłów 29 mówi o braku duchowego kierownictwa?',
      options: <String>[
        'Gdzie nie ma wizji, lud staje się rozpasany',
        'Lud zawsze radzi sobie sam',
        'Wizje nie mają znaczenia',
        'Lud woli nie mieć zasad',
      ],
      correctIndex: 0,
      explanation: 'Ostrzeżenie przed brakiem kierownictwa (Przysłów 29:18).',
    ),
    QuizQuestion(
      text: 'Co świętuje ostatni poemat Przysłów 31?',
      options: <String>[
        'Zdolną i cnotliwą kobietę',
        'Bogactwo króla',
        'Zwycięstwo militarne',
        'Budowę pałacu',
      ],
      correctIndex: 0,
      explanation:
          'Akrostychiczny poemat wychwala wspaniałą żonę (Przysłów 31).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['król', 'leniwiec', 'wino'],
    ),
  ],
  'Ecclesiastes#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka powtarzająca się obserwacja otwiera Księgę Kaznodziei?',
      options: <String>[
        'Wszystko jest przemijające (marnością) pod słońcem',
        'Wszystko jest doskonale stałe',
        'Bogactwo rozwiązuje wszystko',
        'Nic się nigdy nie zmienia',
      ],
      correctIndex: 0,
      explanation: 'Ten temat kształtuje całą księgę (Kaznodziei 1:2).',
    ),
    QuizQuestion(
      text:
          'Co odkrył Salomon po dążeniu do przyjemności, projektów i mądrości?',
      options: <String>[
        'Wszystko to bez Boga pozostaje bezcelowe',
        'Sama przyjemność wystarczy do szczęścia',
        'Praca zawsze gwarantuje satysfakcję',
        'Ludzka mądrość rozwiązuje wszystko',
      ],
      correctIndex: 0,
      explanation:
          'Jego osobiste doświadczenie ilustruje bezcelowość bez Boga (Kaznodziei 2).',
    ),
    QuizQuestion(
      text: 'Na co wskazuje słynny fragment o „czasie na wszystko”?',
      options: <String>[
        'Na wszystko jest odpowiedni czas',
        'Czas nie ma żadnego znaczenia',
        'Wszystko musi się dziać natychmiast',
        'Przeszłość nie ma znaczenia',
      ],
      correctIndex: 0,
      explanation: 'Ten rytmiczny poemat otwiera Kaznodziei 3.',
    ),
  ],
  'Ecclesiastes#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co radzi Kaznodziei 5 w kwestii ślubów składanych Bogu?',
      options: <String>[
        'Lepiej nie ślubować, niż ślubować i nie wypełnić',
        'Należy składać wiele ślubów',
        'Śluby nie mają wartości',
        'Tylko kapłani mogą składać śluby',
      ],
      correctIndex: 0,
      explanation:
          'Podkreślono ostrożność w mowie wobec Boga (Kaznodziei 5:4, 5).',
    ),
    QuizQuestion(
      text: 'Co Kaznodziei 7 mówi o reputacji?',
      options: <String>[
        'Dobre imię jest lepsze niż wyborny wonny olejek',
        'Reputacja nie ma wartości',
        'Liczy się tylko bogactwo',
        'Imię nigdy nie przetrwa',
      ],
      correctIndex: 0,
      explanation: 'Osąd o wartości prawości (Kaznodziei 7:1).',
    ),
    QuizQuestion(
      text: 'Co zaleca Kaznodziei 8 w związku z ustanowioną władzą?',
      options: <String>[
        'Mądrze być posłusznym, nie śpiesząc się z jej podważaniem',
        'Zawsze przeciwstawiać się władcom',
        'Całkowicie ignorować prawo',
        'Uciekać od wszelkiej odpowiedzialności obywatelskiej',
      ],
      correctIndex: 0,
      explanation: 'Zaleca się praktyczną ostrożność (Kaznodziei 8).',
    ),
  ],
  'Ecclesiastes#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'O czym przypomina Kaznodziei 9 w związku z naszymi codziennymi czynnościami?',
      options: <String>[
        'Wykonuj swoją pracę z całych sił, póki żyjesz',
        'Praca nie ma wartości',
        'Lepiej pozostać bezczynnym',
        'Tylko bogaci powinni pracować',
      ],
      correctIndex: 0,
      explanation:
          'Wezwanie do pełnego zaangażowania w życiu (Kaznodziei 9:10).',
    ),
    QuizQuestion(
      text: 'Co radzi Kaznodziei 11 w kwestii hojności?',
      options: <String>[
        'Rzucaj swój chleb na wody, bo powróci',
        'Zachowaj wszystkie swoje zasoby dla siebie',
        'Hojność jest zawsze bezużyteczna',
        'Trzeba czekać na pewność, zanim się zadziała',
      ],
      correctIndex: 0,
      explanation:
          'Obraz hojnego i pewnego siebie inwestowania (Kaznodziei 11:1).',
    ),
    QuizQuestion(
      text: 'Jaki jest końcowy wniosek Księgi Kaznodziei?',
      options: <String>[
        'Bój się Boga i przestrzegaj jego przykazań',
        'Szukaj wyłącznie przyjemności',
        'Nic tak naprawdę nie ma sensu',
        'Bogactwo jest ostatecznym celem',
      ],
      correctIndex: 0,
      explanation: 'To zakończenie podsumowuje całą księgę (Kaznodziei 12:13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['marność', 'mądrość', 'bogactwo'],
    ),
  ],
  'Song of Solomon#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie uczucie dominuje na początku Pieśni?',
      options: <String>[
        'Namiętna miłość między Szulamitką a jej ukochanym',
        'Konflikt rodzinny',
        'Negocjacje handlowe',
        'Królewski wyrok',
      ],
      correctIndex: 0,
      explanation: 'Księga celebruje szczerą miłość małżeńską (Pieśń 1).',
    ),
    QuizQuestion(
      text: 'Co robi Szulamitka w swoim śnie w rozdziale 3?',
      options: <String>[
        'Szuka swego ukochanego po całym mieście',
        'Ucieka do odległej krainy',
        'Wychodzi za innego mężczyznę',
        'Całkowicie zapomina o swojej miłości',
      ],
      correctIndex: 0,
      explanation: 'Jej oddanie pozostaje wierne nawet we śnie (Pieśń 3).',
    ),
    QuizQuestion(
      text: 'Jak Szulamitka wyraża swoje wyłączne oddanie?',
      options: <String>[
        '„Jestem mojego ukochanego, a mój ukochany jest mój”',
        '„Wolę bogactwo od miłości”',
        '„Miłość nie ma dla mnie znaczenia”',
        '„Pozostanę sama na zawsze”',
      ],
      correctIndex: 0,
      explanation: 'Ta fraza powraca jak refren (Pieśń 2:16).',
    ),
  ],
  'Song of Solomon#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak ukochany opisuje piękno Szulamitki w rozdziale 4?',
      options: <String>[
        'Za pomocą serii żarliwych poetyckich obrazów',
        'Chłodno i z dystansem',
        'Porównując ją do wroga',
        'W ogóle jej nie opisuje',
      ],
      correctIndex: 0,
      explanation: 'Poświęca się jej szczegółowy poemat pochwalny (Pieśń 4).',
    ),
    QuizQuestion(
      text: 'Co się dzieje, gdy ukochany puka do jej drzwi w rozdziale 5?',
      options: <String>[
        'Otwiera zbyt późno, a on już odszedł',
        'Otwiera od razu z radością',
        'Odmawia spotkania z nim',
        'W ogóle nie przyszedł',
      ],
      correctIndex: 0,
      explanation: 'Ten przegapiony moment tworzy przejmujący żal (Pieśń 5).',
    ),
    QuizQuestion(
      text: 'Komu Szulamitka opisuje swojego ukochanego po tym wydarzeniu?',
      options: <String>[
        'Córkom Jerozolimy',
        'Tylko swojej matce',
        'Królowi Salomonowi',
        'Nikomu, zachowuje milczenie',
      ],
      correctIndex: 0,
      explanation: 'Następuje jej entuzjastyczny opis (Pieśń 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Salomon', 'winnica', 'pasterz'],
    ),
  ],
  'Song of Solomon#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie słynne stwierdzenie o miłości znajduje się w rozdziale 8?',
      options: <String>[
        'Miłość jest silna jak śmierć',
        'Miłość kupuje się za pieniądze',
        'Miłość nie ma znaczenia',
        'Miłość nigdy nie trwa',
      ],
      correctIndex: 0,
      explanation: '„Wody wielkie nie zdołają zagasić miłości” (Pieśń 8:6, 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ogień', 'woda', 'zazdrość'],
    ),
    QuizQuestion(
      text: 'Co symbolizują „wody wielkie”, które nie mogą zagasić miłości?',
      options: <String>[
        'Próby, które nie mogą zniszczyć prawdziwej miłości',
        'Dosłowną powódź',
        'Bogactwo królestwa',
        'Potęgę króla',
      ],
      correctIndex: 0,
      explanation: 'Silna metafora odporności miłości (Pieśń 8).',
    ),
    QuizQuestion(
      text: 'Jaki ton dominuje na końcu Pieśni?',
      options: <String>[
        'Celebrację wiernej, wspólnej miłości',
        'Ostateczne zerwanie',
        'Surowy wyrok',
        'Ostrzeżenie przed wojną',
      ],
      correctIndex: 0,
      explanation: 'Księga kończy się nutą spełnionej miłości (Pieśń 8).',
    ),
  ],
  'Isaiah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Co obiecuje Izajasza 2 na przyszłość w kwestii wojny?',
      options: <String>[
        'Narody przekują swoje miecze na lemiesze',
        'Wojny staną się częstsze',
        'Jedno imperium będzie panować na zawsze',
        'Nie przewiduje się żadnej zmiany',
      ],
      correctIndex: 0,
      explanation: 'Wizja powszechnego pokoju (Izajasza 2:4).',
    ),
    QuizQuestion(
      text: 'Co widzi Izajasz podczas swojej wizji prorockiego powołania?',
      options: <String>[
        'Jehowę na wzniosłym tronie, otoczonego serafinami',
        'Niebiańską bitwę',
        'Milczącą pustynię',
        'Tylko miasto w ruinie',
      ],
      correctIndex: 0,
      explanation:
          'Rozżarzony węgiel dotyka jego ust, oczyszczając je (Izajasza 6).',
    ),
    QuizQuestion(
      text: 'Jaki znak Izajasz ogłasza królowi Achazowi w rozdziale 7?',
      options: <String>[
        'Młoda kobieta pocznie syna, Immanuela',
        'Natychmiastowe zwycięstwo militarne',
        'Całkowite zniszczenie Judy',
        'Przedłużający się głód',
      ],
      correctIndex: 0,
      explanation: '„Immanuel” oznacza „Bóg z nami” (Izajasza 7:14).',
    ),
  ],
  'Isaiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie słynne mesjańskie proroctwo znajduje się w Izajasza 9?',
      options: <String>[
        'Narodziło się dziecko, panowanie spoczywa na jego barkach',
        'Obcy król będzie panował na zawsze',
        'Świątynia zostanie natychmiast odbudowana',
        'Pokój nigdy nie nadejdzie',
      ],
      correctIndex: 0,
      explanation: 'Ten fragment zapowiada panowanie pokoju (Izajasza 9:6, 7).',
    ),
    QuizQuestion(
      text:
          'Jaki pokojowy obraz ilustruje Izajasza 11 w związku z przyszłym panowaniem?',
      options: <String>[
        'Wilk będzie mieszkał z barankiem',
        'Lwy będą panować nad ludzkością',
        'Pustynie pozostaną jałowe',
        'Narody pozostaną podzielone',
      ],
      correctIndex: 0,
      explanation: 'Obiecana jest całkowita harmonia (Izajasza 11:6).',
    ),
    QuizQuestion(
      text: 'Jak Izajasza 14 opisuje pyszny upadek króla Babilonu?',
      options: <String>[
        'Jako świecącą gwiazdę spadłą z nieba',
        'Jako króla na zawsze triumfującego',
        'Jako wiernego sprzymierzeńca Izraela',
        'Jako zwykłego kupca',
      ],
      correctIndex: 0,
      explanation: 'Uderzający obraz upadku (Izajasza 14:12).',
    ),
  ],
  'Isaiah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki symboliczny czyn wykonuje Izajasz przeciwko Egiptowi i Kusz?',
      options: <String>[
        'Chodzi boso i bez wierzchniego okrycia',
        'Pali swoje ubrania',
        'Pości przez rok',
        'Buduje ołtarz',
      ],
      correctIndex: 0,
      explanation:
          'Ten znak ilustruje hańbę nadchodzącej niewoli (Izajasza 20).',
    ),
    QuizQuestion(
      text: 'Jaki powszechny sąd zapowiada Izajasza 24?',
      options: <String>[
        'Cała ziemia zostanie wstrząśnięta i spustoszona',
        'Osądzony zostanie tylko jeden naród',
        'Żaden sąd się nie odbędzie',
        'Sąd dotyczy tylko królów',
      ],
      correctIndex: 0,
      explanation: 'Opisany jest światowy zasięg (Izajasza 24).',
    ),
    QuizQuestion(
      text: 'Co obiecuje Izajasza 25 w kwestii śmierci?',
      options: <String>[
        'Jehowa na zawsze połknie śmierć',
        'Śmierć pozostanie niepokonana',
        'Tylko bogaci jej unikną',
        'O śmierci nic się nie mówi',
      ],
      correctIndex: 0,
      explanation: 'Wyrażona jest niezwykła nadzieja (Izajasza 25:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['łzy', 'zasłona', 'góra'],
    ),
  ],
  'Isaiah#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Co obiecuje Izajasza 26 temu, którego umysł polega na Bogu?',
      options: <String>[
        'Doskonały pokój',
        'Natychmiastowe bogactwo',
        'Niezwyciężone wojsko',
        'Gwarantowane długie życie',
      ],
      correctIndex: 0,
      explanation: '„Zachowasz w doskonałym pokoju” (Izajasza 26:3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['pokój'],
    ),
    QuizQuestion(
      text: 'Jaki cenny kamień Jehowa kładzie na Syjonie według Izajasza 28?',
      options: <String>[
        'Kamień węgielny, wypróbowany fundament',
        'Zwykły kamyk',
        'Przeklęty kamień',
        'Nie wspomina się o żadnym kamieniu',
      ],
      correctIndex: 0,
      explanation: 'Mesjański obraz pewnego fundamentu (Izajasza 28:16).',
    ),
    QuizQuestion(
      text: 'Przed czym Izajasz ostrzega lud w związku z sojuszem militarnym?',
      options: <String>[
        'Przed ufaniem Egiptowi zamiast Jehowie',
        'Przed sojuszem wyłącznie z Babilonem',
        'Przed wszelkim handlem zagranicznym',
        'Przed lokalnymi kapłanami',
      ],
      correctIndex: 0,
      explanation:
          'Krytykowane jest szukanie pomocy u Egiptu (Izajasza 30-31).',
    ),
  ],
  'Isaiah#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Czym stanie się pustynia według obietnicy z Izajasza 35?',
      options: <String>[
        'Zakwitnie jak róża',
        'Na zawsze pozostanie jałowa',
        'Stanie się morzem',
        'Zostanie ostatecznie opuszczona',
      ],
      correctIndex: 0,
      explanation: 'Obiecana jest radosna przemiana (Izajasza 35:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pustynia', 'woda', 'śpiewać'],
    ),
    QuizQuestion(
      text:
          'Jak Jehowa odpowiedział na modlitwę Ezechiasza przeciwko Sancherybowi?',
      options: <String>[
        'Anioł pobił wojsko asyryjskie w jedną noc',
        'Ezechiasz musiał się poddać',
        'Głód osłabił Judę',
        'Nie nadeszła żadna odpowiedź',
      ],
      correctIndex: 0,
      explanation:
          'Po modlitwie następuje spektakularne wybawienie (Izajasza 37).',
    ),
    QuizQuestion(
      text:
          'O czym przypomina Izajasza 40 w kwestii natury ludzkiej w porównaniu do Boga?',
      options: <String>[
        'Wszelkie ciało jest jak trawa, która więdnie',
        'Człowiek jest z natury wieczny',
        'Bóg zależy od człowieka',
        'Słowo Boga często się zmienia',
      ],
      correctIndex: 0,
      explanation:
          '„Słowo naszego Boga trwa po czas niezmierzony” (Izajasza 40:8).',
    ),
  ],
  'Isaiah#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Izajasza 42 opisuje łagodność sługi Jehowy?',
      options: <String>[
        'Nie złamie nadłamanej trzciny',
        'Zniszczy wszystko na swojej drodze',
        'Zignoruje słabych',
        'Będzie działał z systematyczną przemocą',
      ],
      correctIndex: 0,
      explanation: 'Niezwykła łagodność cechuje tego sługę (Izajasza 42:3).',
    ),
    QuizQuestion(
      text:
          'Jaki obcy król zostaje z góry wymieniony przez Izajasza jako wyzwoliciel Izraela?',
      options: <String>['Cyrus', 'Nabuchodonozor', 'Dariusz', 'Kserkses'],
      correctIndex: 0,
      explanation:
          'Niezwykłe proroctwo wymienia z imienia Cyrusa (Izajasza 44-45).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Co Izajasza 48 mówi o dawnym nastawieniu ludu do przykazań Boga?',
      options: <String>[
        'Gdyby tylko wcześniej zwrócili uwagę',
        'Zawsze byli doskonale posłuszni',
        'Przykazania nie miały znaczenia',
        'Bóg nigdy niczego od nich nie wymagał',
      ],
      correctIndex: 0,
      explanation:
          'Wyrażony jest żal z powodu ich niesłuchania (Izajasza 48:18).',
    ),
  ],
  'Isaiah#6': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Izajasza 53 opisuje cierpienie sługi Jehowy?',
      options: <String>[
        'Został przebity z powodu naszych przestępstw',
        'Żył, nigdy nie cierpiąc',
        'Panował natychmiast, bez próby',
        'Był honorowany od urodzenia',
      ],
      correctIndex: 0,
      explanation:
          'Centralny rozdział o odkupieńczym cierpieniu (Izajasza 53:5).',
    ),
    QuizQuestion(
      text: 'Jakie bezpłatne zaproszenie zostaje wystosowane w Izajasza 55?',
      options: <String>[
        'Przyjdźcie, kupujcie wino i mleko bez pieniędzy',
        'Zapłaćcie słono, aby zdobyć mądrość',
        'Mogą przyjść tylko bogaci',
        'Nie wystosowuje się żadnego zaproszenia',
      ],
      correctIndex: 0,
      explanation: 'Hojna, powszechna oferta (Izajasza 55:1).',
    ),
    QuizQuestion(
      text: 'Co Izajasza 58 określa jako prawdziwy „post” w oczach Boga?',
      options: <String>[
        'Dzielenie się chlebem z głodnym i wyzwalanie uciskanych',
        'Powstrzymywanie się jedynie od jedzenia',
        'Noszenie specjalnego ubioru',
        'Milczenie przez cały dzień',
      ],
      correctIndex: 0,
      explanation:
          'Prawdziwy post przejawia się w czynach sprawiedliwości (Izajasza 58:6, 7).',
    ),
  ],
  'Isaiah#7': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki obraz nadziei otwiera Izajasza 60 dla Syjonu?',
      options: <String>[
        'Powstań, zajaśnij, bo przyszło twoje światło',
        'Pozostań na zawsze w ciemności',
        'Uciekaj daleko od swojego miasta',
        'Czekaj bez nadziei',
      ],
      correctIndex: 0,
      explanation: 'Promienne wezwanie do przywrócenia (Izajasza 60:1).',
    ),
    QuizQuestion(
      text:
          'Jakie stwierdzenie z Izajasza 61 odczytał Jezus w synagodze w Nazarecie?',
      options: <String>[
        '„Duch Wszechwładnego Pana jest na mnie”',
        '„Przyszedłem, aby sądzić cały świat”',
        '„Świątynia zostanie zniszczona”',
        '„Nikt nie zostanie wybawiony”',
      ],
      correctIndex: 0,
      explanation:
          'Jezus odnosi ten fragment do samego siebie (Łukasza 4, cytując Izajasza 61:1).',
    ),
    QuizQuestion(
      text: 'Co obiecuje Izajasza 65 w kwestii przyszłości stworzenia?',
      options: <String>[
        'Nowe niebiosa i nową ziemię',
        'Ostateczne zniszczenie bez odbudowy',
        'Królestwo ograniczone do jednego narodu',
        'Koniec wszelkiego życia zwierzęcego',
      ],
      correctIndex: 0,
      explanation: 'Obietnica nadziei kończy księgę (Izajasza 65:17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jerozolima', 'światło', 'chwała'],
    ),
  ],
  'Jeremiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Co Jehowa mówi Jeremiaszowi o jego powołaniu, jeszcze zanim się urodził?',
      options: <String>[
        '„Zanim ukształtowałem cię w łonie, znałem cię”',
        'Wybrał go dopiero w dorosłości',
        'Jeremiasz sam się zgłosił',
        'Nie wspomina się o żadnym szczególnym powołaniu',
      ],
      correctIndex: 0,
      explanation:
          'Prorocze powołanie ustanowione jeszcze przed jego narodzeniem (Jeremiasza 1:5).',
    ),
    QuizQuestion(
      text: 'Do czego Jehowa porównuje niewierność Izraela w rozdziale 2?',
      options: <String>[
        'Do żony, która zapomniała swojego męża',
        'Do wiernego króla',
        'Do wzorowego sługi',
        'Do zawsze lojalnego narodu',
      ],
      correctIndex: 0,
      explanation: 'Obraz opuszczenia relacji (Jeremiasza 2).',
    ),
    QuizQuestion(
      text: 'Jaką fałszywą pewność potępia Jeremiasz w rozdziale 7?',
      options: <String>[
        'Powtarzanie „to jest świątynia Jehowy” jak magiczną formułę',
        'Nadmierne zaufanie samemu Jeremiaszowi',
        'Zaufanie wyłącznie wojsku',
        'Zaufanie obcym prorokom',
      ],
      correctIndex: 0,
      explanation:
          'Lud błędnie wierzy, że świątynia automatycznie ich chroni (Jeremiasza 7).',
    ),
  ],
  'Jeremiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie słynne pytanie zadaje Jeremiasz w rozdziale 12?',
      options: <String>[
        'Dlaczego droga niegodziwych się powodzi?',
        'Dlaczego Babilon jest tak słaby?',
        'Dlaczego świątynia jest pusta?',
        'Dlaczego kapłanów nie ma?',
      ],
      correctIndex: 0,
      explanation: 'Jeremiasz wyraża szczerą skargę (Jeremiasza 12:1).',
    ),
    QuizQuestion(
      text: 'Co symbolizuje zniszczony lniany pas w Jeremiasza 13?',
      options: <String>[
        'Zepsucie pychy Judy',
        'Odzyskane bogactwo ludu',
        'Solidny sojusz z Egiptem',
        'Czystość kapłaństwa',
      ],
      correctIndex: 0,
      explanation: 'Widoczny znak moralnego upadku (Jeremiasza 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pas', 'len', 'rzeka'],
    ),
    QuizQuestion(
      text: 'Co Jeremiasza 17 ujawnia o ludzkim sercu?',
      options: <String>[
        'Jest zdradliwe bardziej niż cokolwiek innego',
        'Jest z natury dobre',
        'Nigdy się nie zmienia',
        'Nie ma znaczenia dla Boga',
      ],
      correctIndex: 0,
      explanation: 'Szczera ocena ludzkiej natury (Jeremiasza 17:9).',
    ),
  ],
  'Jeremiah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakiej ilustracji udziela Jehowa Jeremiaszowi w domu garncarza?',
      options: <String>[
        'Jak glina w ręku garncarza, Izrael jest w ręku Boga',
        'Garncarz symbolizuje obcego króla',
        'Glina reprezentuje bogactwo',
        'Nie wyciąga się z tego żadnej duchowej lekcji',
      ],
      correctIndex: 0,
      explanation: 'Obraz boskiej suwerenności (Jeremiasza 18).',
    ),
    QuizQuestion(
      text:
          'Jak potraktowano Jeremiasza po tym, jak prorokował przeciwko Jerozolimie?',
      options: <String>[
        'Paszchur go pobił i wsadził do dyb',
        'Publicznie go uhonorowano',
        'Mianowano go arcykapłanem',
        'Wysłano go jako ambasadora',
      ],
      correctIndex: 0,
      explanation: 'Jeremiasz cierpi za swoje wierne orędzie (Jeremiasza 20).',
    ),
    QuizQuestion(
      text:
          'Jaki wybór Jeremiasz przedstawia oblężonemu ludowi w rozdziale 21?',
      options: <String>[
        'Poddać się Babilonowi (życie) lub stawiać opór (śmierć)',
        'Natychmiast uciec do Egiptu',
        'Zaatakować Babilon pierwsi',
        'Negocjować z Asyrią',
      ],
      correctIndex: 0,
      explanation:
          'Przedstawiony jest trudny, lecz jasny wybór (Jeremiasza 21).',
    ),
  ],
  'Jeremiah#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Co obiecuje Jeremiasza 23 w kwestii przyszłego sprawiedliwego króla?',
      options: <String>[
        '„Sprawiedliwa latorośl” będzie panować z mądrością',
        'Nigdy nie nadejdzie sprawiedliwy król',
        'Fałszywi pasterze będą panować na zawsze',
        'Królestwo zniknie bez następcy',
      ],
      correctIndex: 0,
      explanation:
          'Mesjańska obietnica kontrastuje ze złymi pasterzami (Jeremiasza 23:5).',
    ),
    QuizQuestion(
      text: 'Ile lat niewoli w Babilonie zapowiada Jeremiasz?',
      options: <String>['70 lat', '7 lat', '40 lat', '400 lat'],
      correctIndex: 0,
      explanation: 'Ten dokładny okres jest prorokowany (Jeremiasza 25:11).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['siedemdziesiąt lat'],
    ),
    QuizQuestion(
      text: 'Co radzi Jeremiasz wygnańcom w Babilonie w swoim liście?',
      options: <String>[
        'Budować domy i szukać pokoju miasta',
        'Natychmiast się zbuntować',
        'Odmówić wszelkiej pracy',
        'Ignorować miejscowe władze',
      ],
      correctIndex: 0,
      explanation: 'Realistyczna rada na życie na wygnaniu (Jeremiasza 29).',
    ),
  ],
  'Jeremiah#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Jehowa obiecuje w słynnym proroctwie o nowym przymierzu?',
      options: <String>[
        'Jego prawo zostanie zapisane na sercach ludu',
        'Nowa świątynia zostanie natychmiast zbudowana',
        'Nie planuje się żadnego przyszłego przymierza',
        'Kapłaństwo zostanie zniesione bez zastąpienia',
      ],
      correctIndex: 0,
      explanation:
          'Zapowiedziane jest wewnętrzne, osobiste przymierze (Jeremiasza 31:33).',
    ),
    QuizQuestion(
      text:
          'Jaki symboliczny czyn wykonuje Jeremiasz w środku kryzysu, kupując pole?',
      options: <String>[
        'Wyraża swoją wiarę w przyszłe przywrócenie',
        'Chce się wzbogacić',
        'Ucieka z oblężonego miasta',
        'Negocjuje z Babilonem',
      ],
      correctIndex: 0,
      explanation:
          'Ten zakup świadczy o nadziei mimo oblężenia (Jeremiasza 32).',
    ),
    QuizQuestion(
      text: 'Jaki przykład wierności dają Judzie Rechabici?',
      options: <String>[
        'Ich ścisłe posłuszeństwo nakazowi swojego przodka',
        'Ich obfite bogactwo',
        'Ich potęgę militarną',
        'Ich sojusz z Egiptem',
      ],
      correctIndex: 0,
      explanation:
          'Ich wierność kontrastuje z niewiernością Judy (Jeremiasza 35).',
    ),
  ],
  'Jeremiah#5': <QuizQuestion>[
    QuizQuestion(
      text:
          'Kto uratował Jeremiasza po tym, jak wrzucono go do błotnistej cysterny?',
      options: <String>['Ebed-Melech', 'Baruch', 'Godoliasz', 'Ismael'],
      correctIndex: 0,
      explanation: 'Ten Etiopczyk odważnie interweniuje (Jeremiasza 38).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Kto został mianowany namiestnikiem po upadku Jerozolimy, a następnie zamordowany?',
      options: <String>['Godoliasz', 'Sedekiasz', 'Ismael', 'Baruch'],
      correctIndex: 0,
      explanation:
          'Jego zabójstwo wywołuje dalsze zamieszki (Jeremiasza 40-41).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Co robi reszta ludu mimo ostrzeżenia Jeremiasza, by pozostać w kraju?',
      options: <String>[
        'Uciekają do Egiptu, zabierając ze sobą Jeremiasza',
        'W pełni podporządkowują się radzie proroka',
        'Atakują Babilon',
        'Rozpraszają się w kierunku Asyrii',
      ],
      correctIndex: 0,
      explanation:
          'Ich nieposłuszeństwo pogarsza ich sytuację (Jeremiasza 43).',
    ),
  ],
  'Jeremiah#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Przeciwko jakim narodom ostatnie rozdziały Jeremiasza wygłaszają wyroki?',
      options: <String>[
        'Egiptowi, Filistynom, Moabowi, Ammonowi, Babilonowi i innym',
        'Tylko Izraelowi',
        'Żadnemu obcemu narodowi',
        'Tylko Judzie',
      ],
      correctIndex: 0,
      explanation:
          'Seria wyroczni przeciwko narodom kończy księgę (Jeremiasza 46-51).',
    ),
    QuizQuestion(
      text:
          'Jaki symboliczny znak towarzyszy proroctwu przeciw Babilonowi przekazanemu Serajaszowi?',
      options: <String>[
        'Zwój zostaje wrzucony do Eufratu, aby zatonął',
        'Zostaje publicznie spalony',
        'Zostaje odczytany przed królem Babilonu',
        'Zostaje ukryty w świątyni',
      ],
      correctIndex: 0,
      explanation: 'Obraz ostatecznego upadku Babilonu (Jeremiasza 51).',
    ),
    QuizQuestion(
      text: 'Jak Księga Jeremiasza kończy się historycznie?',
      options: <String>[
        'Uwolnieniem Jojachina z więzienia w Babilonie',
        'Natychmiastowym powrotem całego ludu',
        'Odbudową świątyni',
        'Militarnym zwycięstwem Judy',
      ],
      correctIndex: 0,
      explanation: 'Historyczny epilog zamyka księgę (Jeremiasza 52).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesPlC3 =
    <String, List<QuizQuestion>>{};
