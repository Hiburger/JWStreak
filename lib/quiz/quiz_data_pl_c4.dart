import 'quiz_data.dart';

const Map<String, List<QuizQuestion>> authoredQuizzesPlC4 = <String, List<QuizQuestion>>{
  'Lamentations#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Lamentacje 1 opisują Jerozolimę po jej upadku?',
      options: <String>[
        'Jako miasto, kiedyś pełne ludzi, teraz siedzące samotnie',
        'Jako miasto w pełnym rozkwicie',
        'Jako nietkniętą stolicę',
        'Jako miejsce nieustannego świętowania',
      ],
      correctIndex: 0,
      explanation:
          '„Jakże samotnie ona siedzi!” otwiera księgę (Lamentacje 1:1).',
    ),
    QuizQuestion(
      text: 'Co opisują Lamentacje 2 na temat gniewu Jehowy?',
      options: <String>[
        'Wylał się na Syjon z powodu jej niewierności',
        'Całkowicie oszczędził miasto',
        'Skierował się wyłącznie na sąsiednie narody',
        'Nie miał żadnego widocznego skutku',
      ],
      correctIndex: 0,
      explanation:
          'Zniszczenie jest przedstawione jako zasłużony wyrok (Lamentacje 2).',
    ),
    QuizQuestion(
      text: 'Jaki ton dominuje w tych pierwszych dwóch rozdziałach jako całości?',
      options: <String>[
        'Głęboka żałoba nad zniszczonym miastem',
        'Radosne świętowanie',
        'Całkowita obojętność',
        'Militarny triumf',
      ],
      correctIndex: 0,
      explanation: 'Księga jest żałobną elegią (Lamentacje 1-2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['radość', 'świątynia', 'mury'],
    ),
  ],
  'Lamentations#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie stwierdzenie nadziei stanowi sedno rozdziału 3 mimo cierpienia?',
      options: <String>[
        'Przejawy lojalnej miłości Jehowy są nowe każdego ranka',
        'Nie ma żadnej nadziei',
        'Cierpienie nigdy się nie skończy',
        'Bóg całkowicie opuścił swój lud',
      ],
      correctIndex: 0,
      explanation: '„Wielka jest twoja wierność” (Lamentacje 3:22, 23).',
    ),
    QuizQuestion(
      text: 'Jak pisarz opisuje siebie osobiście w rozdziale 3?',
      options: <String>[
        'Jako człowieka, który zaznał utrapienia',
        'Jako triumfującego króla',
        'Jako zwykłego zewnętrznego obserwatora',
        'Jako kapłana podczas uczty',
      ],
      correctIndex: 0,
      explanation:
          'Dzieli się osobistym doświadczeniem cierpienia (Lamentacje 3:1).',
    ),
    QuizQuestion(
      text: 'Jaką postawę zaleca rozdział 3 wobec próby?',
      options: <String>[
        'Cichego oczekiwania na Jehowę z nadzieją',
        'Natychmiastowej zemsty',
        'Porzucenia wszelkiej wiary',
        'Ucieczki daleko od jakiejkolwiek społeczności',
      ],
      correctIndex: 0,
      explanation:
          'Zachęca się do ufnej cierpliwości (Lamentacje 3:25, 26).',
    ),
  ],
  'Lamentations#2': <QuizQuestion>[
    QuizQuestion(
      text: 'O jakim skrajnym cierpieniu przypomina rozdział 4 podczas oblężenia?',
      options: <String>[
        'O dotkliwym głodzie wśród mieszkańców',
        'O obfitości pożywienia',
        'O niespodziewanym pokoju',
        'O powodzi bogactw',
      ],
      correctIndex: 0,
      explanation:
          'Głód podczas oblężenia opisano z surowym realizmem (Lamentacje 4).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['plaga', 'miecz', 'ogień'],
    ),
    QuizQuestion(
      text: 'O co prosi końcowa modlitwa rozdziału 5?',
      options: <String>[
        'Aby Jehowa przywrócił swój lud jak dawniej',
        'Aby miasto na zawsze pozostało w ruinie',
        'Aby powrót nigdy nie był możliwy',
        'Aby lud zapomniał swoją przeszłość',
      ],
      correctIndex: 0,
      explanation:
          '„Sprowadź nas z powrotem do siebie” kończy księgę (Lamentacje 5:21).',
    ),
    QuizQuestion(
      text: 'Jakie uczucie dominuje we wspólnej modlitwie ostatniego rozdziału?',
      options: <String>[
        'Pokorne błaganie mimo wstydu za przeszłość',
        'Odnowiona pycha',
        'Obojętność wobec przyszłości',
        'Gniew przeciwko Bogu',
      ],
      correctIndex: 0,
      explanation:
          'Lud uznaje swoją sytuację i błaga o przywrócenie (Lamentacje 5).',
    ),
  ],
  'Ezekiel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Co widzi Ezechiel w swojej początkowej wizji w rozdziale 1?',
      options: <String>[
        'Niebiański rydwan Jehowy z żywymi istotami',
        'Zwyczajną burzę piaskową',
        'Płonącą świątynię',
        'Maszerujące wojsko',
      ],
      correctIndex: 0,
      explanation:
          'Imponująca wizja otwiera księgę (Ezechiela 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['tron', 'koła', 'świątynia'],
    ),
    QuizQuestion(
      text: 'Co Ezechiel musi zrobić ze zwojem, który otrzymał?',
      options: <String>['Zjeść go', 'Spalić go', 'Ukryć go', 'Sprzedać go'],
      correctIndex: 0,
      explanation:
          'Symboliczny znak przyswojenia orędzia (Ezechiela 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['zjeść zwój'],
    ),
    QuizQuestion(
      text: 'Jaki potajemny kult bałwochwalczy widzi Ezechiel uprawiany wewnątrz samej świątyni?',
      options: <String>[
        'Kult słońca i bożki ukryte przez starszych',
        'Nie znajduje żadnego bałwochwalstwa',
        'Widzi jedynie pusty ołtarz',
        'Prawowitą publiczną ucztę',
      ],
      correctIndex: 0,
      explanation:
          'Wizja ujawnia ukrytą zepsucie (Ezechiela 8).',
    ),
  ],
  'Ezekiel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Kto otrzymuje ochronny znak przed sądem nad Jerozolimą?',
      options: <String>[
        'Ci, którzy wzdychają z powodu obrzydliwych praktyk',
        'Wszyscy mieszkańcy bez wyjątku',
        'Tylko kapłani',
        'Tylko bogaci',
      ],
      correctIndex: 0,
      explanation:
          'Rozróżnienie następuje według nastawienia serca (Ezechiela 9).',
    ),
    QuizQuestion(
      text: 'Co znaczącego dzieje się z chwałą Jehowy w Ezechiela 10-11?',
      options: <String>[
        'Opuszcza świątynię i miasto',
        'Osiedla się tam na stałe',
        'Staje się jeszcze potężniejsza',
        'Nic się nie zmienia',
      ],
      correctIndex: 0,
      explanation:
          'Poważny znak nadchodzącego sądu (Ezechiela 10-11).',
    ),
    QuizQuestion(
      text: 'Do czego Jerozolima jest porównana w przypowieści z rozdziału 16?',
      options: <String>[
        'Do niewiernej żony, wychowanej przez Boga od urodzenia',
        'Do zawsze wiernej królowej',
        'Do potężnego króla',
        'Do miasta, które nigdy nie zostało założone',
      ],
      correctIndex: 0,
      explanation:
          'Uderzająca alegoria niewierności (Ezechiela 16).',
    ),
  ],
  'Ezekiel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Co oświadcza Ezechiela 18 o indywidualnej odpowiedzialności?',
      options: <String>[
        'Dusza, która grzeszy, ta umrze',
        'Dzieci zawsze ponoszą winę rodziców',
        'Nikt nie odpowiada za własne czyny',
        'Sądzeni są tylko królowie',
      ],
      correctIndex: 0,
      explanation:
          'Ustanowiona jest zasada indywidualnej sprawiedliwości (Ezechiela 18:20).',
    ),
    QuizQuestion(
      text: 'Czego szuka Jehowa w Ezechiela 22, nie znajdując tego?',
      options: <String>[
        'Człowieka, który stanąłby w wyłomie',
        'Nowego króla',
        'Świątyni do odbudowy',
        'Obcego proroka',
      ],
      correctIndex: 0,
      explanation:
          'Brak orędownika pogarsza sąd (Ezechiela 22:30).',
    ),
    QuizQuestion(
      text: 'Jakiego bolesnego osobistego znaku doświadcza Ezechiel w rozdziale 24?',
      options: <String>[
        'Śmierci swojej żony, po której nie mógł jawnie żałować',
        'Utraty swego domu',
        'Natychmiastowego wygnania',
        'Poważnej choroby',
      ],
      correctIndex: 0,
      explanation:
          'Ten znak ilustruje rozmiar nadchodzącego wstrząsu (Ezechiela 24).',
    ),
  ],
  'Ezekiel#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Przeciwko jakim sąsiednim narodom skierowane są wyrocznie tych rozdziałów?',
      options: <String>[
        'Ammonowi, Moabowi, Edomowi, Filistynom i Tyrowi',
        'Wyłącznie Egiptowi',
        'Wyłącznie Babilonowi',
        'Żadnemu obcemu narodowi',
      ],
      correctIndex: 0,
      explanation:
          'Seria wyroków przeciwko narodom (Ezechiela 25-28).',
    ),
    QuizQuestion(
      text: 'Jak Tyr jest opisany w poetyckim lamencie na jego temat?',
      options: <String>[
        'Jako wspaniały statek handlowy',
        'Jako miasto bez handlu',
        'Jako pokojowy naród',
        'Jako wierny sojusznik Izraela',
      ],
      correctIndex: 0,
      explanation:
          'Morski obraz ilustruje jego dawną chwałę (Ezechiela 27).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tyr', 'morze', 'cedr'],
    ),
    QuizQuestion(
      text: 'Do czego porównany jest Egipt w wyroku o nim?',
      options: <String>[
        'Do wielkiego cedru, ostatecznie ściętego',
        'Do niewzruszonej skały',
        'Do spokojnego morza',
        'Do pustej pustyni',
      ],
      correctIndex: 0,
      explanation:
          'Obraz wielkości, po której następuje upadek (Ezechiela 31).',
    ),
  ],
  'Ezekiel#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka rola została przydzielona Ezechielowi wobec jego ludu?',
      options: <String>[
        'Rola strażnika, zobowiązanego do ostrzegania',
        'Rola króla',
        'Rola zwykłego pisarza',
        'Rola sędziego wojskowego',
      ],
      correctIndex: 0,
      explanation:
          'Określona jest jego odpowiedzialność jako strażnika (Ezechiela 33).',
    ),
    QuizQuestion(
      text: 'Co widzi Ezechiel w słynnej wizji doliny suchych kości?',
      options: <String>[
        'Kości powracające do życia, obraz przywrócenia Izraela',
        'Krwawą bitwę w toku',
        'Beznadziejną pustynię',
        'Kwitnące miasto',
      ],
      correctIndex: 0,
      explanation:
          'Potężny obraz narodowego zmartwychwstania (Ezechiela 37).',
    ),
    QuizQuestion(
      text: 'Co symbolizują dwa złączone w jeden kije w Ezechiela 37?',
      options: <String>[
        'Ponowne zjednoczenie Judy i Izraela',
        'Sojusz z Egiptem',
        'Trwały podział ludu',
        'Zniszczenie świątyni',
      ],
      correctIndex: 0,
      explanation:
          'Jeden lud zjednoczony pod jednym pasterzem (Ezechiela 37:19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['kije', 'kości', 'świątynia'],
    ),
  ],
  'Ezekiel#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Co robi chwała Jehowy, powracając w wizji nowej świątyni?',
      options: <String>[
        'Ponownie wypełnia dom',
        'Pozostaje nieobecna na zawsze',
        'Pojawia się tylko gdzie indziej',
        'Nic się nie dzieje',
      ],
      correctIndex: 0,
      explanation:
          'Symboliczny powrót boskiej obecności (Ezechiela 43).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['chwała', 'rzeka', 'brama'],
    ),
    QuizQuestion(
      text: 'Co wytwarza rzeka wypływająca ze świątyni, według Ezechiela 47?',
      options: <String>[
        'Wodę, która uzdrawia i daje życie, gdziekolwiek płynie',
        'Niszczycielską powódź',
        'Zwykłą ciekawostkę bez znaczenia',
        'Wodę zastrzeżoną tylko dla kapłanów',
      ],
      correctIndex: 0,
      explanation:
          'Obraz obfitego przywrócenia (Ezechiela 47:9).',
    ),
    QuizQuestion(
      text: 'Jak nazywa się ostatecznie miasto pod koniec księgi?',
      options: <String>['„Jehowa Tam Jest”', '„Wieczne Miasto”', '„Nowy Babilon”', 'Po prostu „Święte Miasto”'],
      correctIndex: 0,
      explanation:
          'To imię podsumowuje nadzieję księgi (Ezechiela 48:35).',
    ),
  ],
  'Daniel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego Daniel i jego towarzysze odmówili jedzenia króla?',
      options: <String>[
        'Aby pozostać wiernymi swoim zasadom',
        'Ponieważ nie byli głodni',
        'Ponieważ brakowało im środków',
        'Na rozkaz samego króla',
      ],
      correctIndex: 0,
      explanation:
          'Ich prawość zostaje nagrodzona dobrym zdrowiem (Daniela 1).',
    ),
    QuizQuestion(
      text: 'Co reprezentuje posąg ze snu Nabuchodonozora, zinterpretowany przez Daniela?',
      options: <String>[
        'Kolejne po sobie następujące światowe królestwa',
        'Zwykłe dzieło sztuki',
        'Sen bez znaczenia',
        'Proroctwo dotyczące samego Daniela',
      ],
      correctIndex: 0,
      explanation:
          'Ostateczne królestwo ustanowione przez Boga przewyższa wszystkie inne (Daniela 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['posąg', 'sen', 'lwy'],
    ),
    QuizQuestion(
      text: 'Co się stało, gdy Szadrak, Meszak i Abed-Nego odmówili oddania czci złotemu posągowi?',
      options: <String>[
        'Zostali ochronieni wewnątrz płonącego pieca',
        'Zostali natychmiast straceni',
        'Ostatecznie ustąpili',
        'Uciekli z królestwa',
      ],
      correctIndex: 0,
      explanation:
          'Cud ukazuje boską ochronę (Daniela 3).',
    ),
  ],
  'Daniel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka tajemnicza wiadomość pojawia się na ścianie podczas uczty Belszaccara?',
      options: <String>[
        'Napis zapowiadający upadek królestwa',
        'Poemat świąteczny',
        'Lista skarbów',
        'Wiadomość pokoju',
      ],
      correctIndex: 0,
      explanation: 'Babilon upada tej samej nocy (Daniela 5).',
    ),
    QuizQuestion(
      text: 'Dlaczego Daniel został wrzucony do jamy lwów?',
      options: <String>[
        'Nadal się modlił mimo dekretu tego zabraniającego',
        'Okradł króla',
        'Zdradził królestwo',
        'Odmówił pracy',
      ],
      correctIndex: 0,
      explanation:
          'Jego wierność w modlitwie jest wystawiona na próbę (Daniela 6).',
    ),
    QuizQuestion(
      text: 'Co widzi Daniel w swojej wizji czterech bestii?',
      options: <String>[
        'Kolejne królestwa, a następnie wieczne królestwo dane „synowi człowieczemu”',
        'Zwykłą scenę pasterską',
        'Natychmiastowy koniec świata',
        'Wojnę bez prorockiego znaczenia',
      ],
      correctIndex: 0,
      explanation:
          'Kluczowa wizja o obiecanym wiecznym panowaniu (Daniela 7).',
    ),
  ],
  'Daniel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Co robi Daniel, zanim otrzymuje proroctwo o „70 tygodniach”?',
      options: <String>[
        'Modli się i wyznaje grzechy swego ludu',
        'Wyprawia ucztę',
        'Opuszcza Babilon',
        'Konsultuje się z wróżbitami',
      ],
      correctIndex: 0,
      explanation:
          'Jego szczera modlitwa poprzedza odpowiedź Gabriela (Daniela 9).',
    ),
    QuizQuestion(
      text: 'Kto zjawia się Danielowi w pobliżu Tygrysu, aby wyjaśnić mu niebiański konflikt?',
      options: <String>[
        'Niebiański posłaniec, wysłany po duchowej walce',
        'Wyłącznie ludzki król',
        'Zwykły sen bez posłańca',
        'Sam Nabuchodonozor',
      ],
      correctIndex: 0,
      explanation:
          'Danielowi zostaje objawiona duchowa walka (Daniela 10).',
    ),
    QuizQuestion(
      text: 'Jaka ostateczna nadzieja kończy Księgę Daniela?',
      options: <String>[
        'Obiecane jest zmartwychwstanie wraz z oczyszczeniem ludu',
        'Koniec bez żadnej nadziei',
        'Całkowite zniszczenie bez przyszłości',
        'Ostateczne milczenie Boga',
      ],
      correctIndex: 0,
      explanation:
          'Michał powstaje i zostaje dana nadzieja na zmartwychwstanie (Daniela 12).',
    ),
  ],
  'Hosea#0': <QuizQuestion>[
    QuizQuestion(
      text: 'O co Jehowa poprosił Ozeasza, aby zilustrować niewierność Izraela?',
      options: <String>[
        'Poślubić niewierną kobietę, Gomer',
        'Zbudować nowy ołtarz',
        'Udać się na dobrowolne wygnanie',
        'Pościć przez rok',
      ],
      correctIndex: 0,
      explanation:
          'Małżeństwo Ozeasza ilustruje relację między Bogiem a Izraelem (Ozeasza 1).',
    ),
    QuizQuestion(
      text: 'Jaki brak wyrzuca Jehowa swojemu ludowi w rozdziale 4?',
      options: <String>[
        'Brak poznania Boga',
        'Brak bogactwa',
        'Brak zdolnych królów',
        'Brak ziemi',
      ],
      correctIndex: 0,
      explanation:
          '„Mój lud ginie z braku poznania” (Ozeasza 4:6).',
    ),
  ],
  'Hosea#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Jehowa przedkłada nad ofiarę, według Ozeasza 6?',
      options: <String>['Lojalną miłość (życzliwość serca)', 'Obfite ofiary', 'Większą świątynię', 'Dłuższe ceremonie'],
      correctIndex: 0,
      explanation:
          '„Mam upodobanie w lojalności, a nie w ofierze” (Ozeasza 6:6).',
    ),
    QuizQuestion(
      text: 'Co zbiera Izrael po „siania wiatru”, według Ozeasza 8?',
      options: <String>['Burzę', 'Trwały pokój', 'Bogactwo', 'Nic konkretnego'],
      correctIndex: 0,
      explanation:
          'Obraz konsekwencji niewierności (Ozeasza 8:7).',
    ),
  ],
  'Hosea#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Jehowa wyraża swoje ojcowskie przywiązanie do Efraima w Ozeasza 11?',
      options: <String>[
        '„Jak mógłbym cię porzucić, Efraimie?”',
        'Oświadcza, że chce go zapomnieć na zawsze',
        'Odmawia wszelkiego współczucia',
        'Całkowicie ignoruje jego los',
      ],
      correctIndex: 0,
      explanation:
          'Ojcowska czułość mimo buntu (Ozeasza 11:8).',
    ),
    QuizQuestion(
      text: 'Jaka ostateczna obietnica kończy Księgę Ozeasza?',
      options: <String>[
        'Jehowa uleczy ich niewierność i pokocha ich dobrowolnie',
        'Izrael pozostanie na zawsze ukarany',
        'Nie jest obiecane żadne przywrócenie',
        'Lud zostanie całkowicie wytępiony',
      ],
      correctIndex: 0,
      explanation:
          'Ostateczne wezwanie do skruchy i nadziei (Ozeasza 14).',
    ),
  ],
  'Joel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaka katastrofa dotyka kraj na początku Księgi Joela?',
      options: <String>['Inwazja szarańczy', 'Wojna domowa', 'Dziesięcioletnia susza', 'Epidemia'],
      correctIndex: 0,
      explanation:
          'Opisana jest bezprecedensowa katastrofa (Joela 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['szarańcza'],
    ),
    QuizQuestion(
      text: 'Do czego wzywa Joel w obliczu tej katastrofy?',
      options: <String>['Do żałoby i postu', 'Do zorganizowania uroczystości', 'Do zignorowania wydarzenia', 'Do natychmiastowej emigracji'],
      correctIndex: 0,
      explanation:
          'Wezwanie do zbiorowej skruchy (Joela 1).',
    ),
  ],
  'Joel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'O co prosi Joela 2, zamiast zwykłego zewnętrznego obrzędu?',
      options: <String>[
        'Rozdarcia serca, a nie szat',
        'Składania większej liczby ofiar',
        'Budowy nowej świątyni',
        'Zapłacenia grzywny',
      ],
      correctIndex: 0,
      explanation:
          'Wymagana jest szczera skrucha (Joela 2:13).',
    ),
    QuizQuestion(
      text: 'Jaką obietnicę z Joela 2 zacytował Piotr w dniu Pięćdziesiątnicy?',
      options: <String>[
        'Wyleję mojego ducha na wszelkiego rodzaju ciało',
        'Zniszczę świątynię',
        'Będę błogosławił tylko kapłanów',
        'Nie ma żadnej godnej uwagi obietnicy',
      ],
      correctIndex: 0,
      explanation:
          'Zacytowana w Dziejach 2 podczas Pięćdziesiątnicy (Joela 2:28).',
    ),
  ],
  'Joel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Gdzie sądzone są narody, według Joela 3?',
      options: <String>['W Dolinie Decyzji', 'W Babilonie', 'W Niniwie', 'W Egipcie'],
      correctIndex: 0,
      explanation:
          'Ogłoszony jest tam zbiorowy sąd (Joela 3:14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jerozolima', 'Syjon', 'Egipt'],
    ),
    QuizQuestion(
      text: 'Co obiecuje Joela 3 Judzie po sądzie nad narodami?',
      options: <String>['Błogosławieństwo i przywrócenie', 'Ostateczne zniszczenie', 'Kolejne wygnanie', 'Nic konkretnego'],
      correctIndex: 0,
      explanation:
          'Wniosek pełen nadziei (Joela 3).',
    ),
  ],
  'Amos#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Przeciwko jakim narodom Amos ogłasza wyroki na początku księgi?',
      options: <String>[
        'Damaszkowi, Gazie, Tyrowi, Edomowi, Ammonowi, Moabowi, a potem Judzie i Izraelowi',
        'Wyłącznie Egiptowi',
        'Wyłącznie Babilonowi',
        'Żadnemu obcemu narodowi',
      ],
      correctIndex: 0,
      explanation:
          'Seria wyroczni poprzedza centralne orędzie (Amosa 1-2).',
    ),
    QuizQuestion(
      text: 'Co oświadcza Amosa 3 o sposobie działania Boga?',
      options: <String>[
        'Nie robi niczego, nie objawiając tego swoim prorokom',
        'Zawsze działa w całkowitej tajemnicy',
        'Nigdy nie ingeruje w historię',
        'Nie potrzebuje posłańców',
      ],
      correctIndex: 0,
      explanation:
          'Podkreślona jest rola proroków (Amosa 3:7).',
    ),
  ],
  'Amos#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Kogo krytykuje Amosa 4, porównując je do „krów Baszanu”?',
      options: <String>[
        'Zamożne kobiety uciskające biednych',
        'Wyłącznie kapłanów',
        'Obcych proroków',
        'Sąsiednich królów',
      ],
      correctIndex: 0,
      explanation: 'Bezpośrednia krytyka społeczna (Amosa 4:1).',
    ),
    QuizQuestion(
      text: 'O co Amosa 5 prosi lud w związku ze sprawiedliwością?',
      options: <String>[
        'Aby sprawiedliwość płynęła jak wody',
        'Aby sprawiedliwość została nieokreślenie odłożona',
        'Aby sądzeni byli tylko bogaci',
        'Aby sprawiedliwość pozostała jedynie symboliczna',
      ],
      correctIndex: 0,
      explanation:
          'Słynne wezwanie do prawdziwej sprawiedliwości (Amosa 5:24).',
    ),
  ],
  'Amos#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakiego symbolicznego narzędzia używa Bóg w wizji, aby osądzić Izraela?',
      options: <String>['Pionu', 'Pustej wagi', 'Złamanej trąby', 'Królewskiego berła'],
      correctIndex: 0,
      explanation:
          'Ten obraz sprawdza prostoliniowość muru (Amosa 7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['pion'],
    ),
    QuizQuestion(
      text: 'Co obiecuje Amosa 9 mimo ogłoszonego sądu?',
      options: <String>[
        'Przywrócenie „upadłej chatki” Dawida',
        'Ostateczne zniszczenie bez nadziei',
        'Całkowite zapomnienie ludu',
        'Koniec każdej boskiej obietnicy',
      ],
      correctIndex: 0,
      explanation:
          'Nuta nadziei kończy księgę (Amosa 9:11).',
    ),
  ],
  'Obadiah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Przeciwko komu skierowana jest krótka Księga Abdiasza?',
      options: <String>['Edomowi', 'Babilonowi', 'Niniwie', 'Egiptowi'],
      correctIndex: 0,
      explanation:
          'Edom jest sądzony za swoją przemoc wobec brata Jakuba (Abdiasza 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Jakim stwierdzeniem kończy się Księga Abdiasza?',
      options: <String>[
        'Królestwo będzie należeć do Jehowy',
        'Edom będzie panował na zawsze',
        'Izrael zniknie na zawsze',
        'Żaden sąd się nie odbędzie',
      ],
      correctIndex: 0,
      explanation:
          'Stwierdzenie boskiej suwerenności (Abdiasza 21).',
    ),
  ],
  'Jonah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego Jonasz uciekał w kierunku Tarszisz, zamiast udać się do Niniwy?',
      options: <String>[
        'Chciał uniknąć misji, którą powierzył mu Jehowa',
        'Nie wiedział o misji',
        'Już wykonał swoje zadanie',
        'Niniwa osobiście go zaprosiła',
      ],
      correctIndex: 0,
      explanation: 'Jonasz próbuje uciec od swojej misji (Jonasza 1).',
    ),
    QuizQuestion(
      text: 'Co się stało, gdy Jonasz został wrzucony do morza?',
      options: <String>[
        'Został połknięty przez wielką rybę',
        'Sam popłynął do brzegu',
        'Natychmiast utonął',
        'Statek od razu go podniósł',
      ],
      correctIndex: 0,
      explanation:
          'Niezwykłe wydarzenie ratuje go (Jonasza 1:17).',
    ),
  ],
  'Jonah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co robi Jonasz wewnątrz ryby?',
      options: <String>['Modli się do Jehowy', 'Śpi głębokim snem', 'Gniewnie protestuje', 'Milczy'],
      correctIndex: 0,
      explanation:
          'Modlitwa udręki i wdzięczności (Jonasza 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ryba', 'Niniwa', 'wór'],
    ),
    QuizQuestion(
      text: 'Jak Niniwa zareagowała na orędzie Jonasza?',
      options: <String>[
        'Całe miasto okazało skruchę, od króla po lud',
        'Całkowicie zignorowało orędzie',
        'Natychmiast wypędziło Jonasza',
        'Wypowiedziało wojnę Izraelowi',
      ],
      correctIndex: 0,
      explanation:
          'Zaskakująca zbiorowa skrucha (Jonasza 3).',
    ),
  ],
  'Jonah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Dlaczego Jonasz był niezadowolony po skrusze Niniwy?',
      options: <String>[
        'Wolałby, żeby Bóg zniszczył miasto',
        'Chciał więcej pieniędzy',
        'Chciał pozostać w Niniwie',
        'Wcale nie był niezadowolony',
      ],
      correctIndex: 0,
      explanation:
          'Jonasz z trudem akceptuje boskie miłosierdzie (Jonasza 4).',
    ),
    QuizQuestion(
      text: 'Czego Jehowa chce nauczyć Jonasza za pomocą więdnącej rośliny?',
      options: <String>[
        'Znaczenia współczucia, nawet wobec obcych',
        'Bezużyteczności wszelkiego współczucia',
        'Czysto materialnej wartości roślin',
        'Prostego faktu botanicznego',
      ],
      correctIndex: 0,
      explanation:
          'Lekcja o boskim współczuciu (Jonasza 4).',
    ),
  ],
  'Micah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Przeciwko jakim miastom ogłoszony jest wyrok Micheasza na początku księgi?',
      options: <String>['Samarii i Jerozolimie', 'Niniwie i Babilonowi', 'Tyrowi i Sydonowi', 'Wyłącznie Damaszkowi'],
      correctIndex: 0,
      explanation:
          'Obie stolice są celem (Micheasza 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Babilon', 'Niniwa', 'Betlejem'],
    ),
    QuizQuestion(
      text: 'Jakie nadużycie społeczne potępia Micheasza 2?',
      options: <String>[
        'Pożądanie pól i domów zabranych biednym',
        'Brak ofiar',
        'Brak świąt religijnych',
        'Brak kapłanów',
      ],
      correctIndex: 0,
      explanation:
          'Potępiona zostaje niesprawiedliwość społeczna (Micheasza 2).',
    ),
  ],
  'Micah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co obiecuje Micheasza 5 w kwestii przyszłego władcy?',
      options: <String>[
        'Przyjdzie z Betlejem',
        'Przyjdzie z Babilonu',
        'Przyjdzie z Egiptu',
        'Nie podano żadnego miejsca',
      ],
      correctIndex: 0,
      explanation:
          'Precyzyjne mesjańskie proroctwo (Micheasza 5:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jerozolima', 'Juda', 'Egipt'],
    ),
    QuizQuestion(
      text: 'Jaką wizję pokoju przedstawia Micheasza 4, podobną do wizji Izajasza?',
      options: <String>[
        'Miecze przekute na lemiesze',
        'Nieustanną wojnę',
        'Zniszczenie wszystkich narodów',
        'Całkowite milczenie o przyszłości',
      ],
      correctIndex: 0,
      explanation:
          'Obraz powszechnego pokoju (Micheasza 4:3).',
    ),
  ],
  'Micah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Czego Jehowa wymaga od człowieka, według Micheasza 6?',
      options: <String>[
        'Praktykowania sprawiedliwości, miłowania życzliwości i pokornego chodzenia z Bogiem',
        'Składania jedynie kosztownych ofiar',
        'Budowania wielkich świątyń',
        'Unikania wszelkiej działalności publicznej',
      ],
      correctIndex: 0,
      explanation:
          'Słynne podsumowanie prawdziwej pobożności (Micheasza 6:8).',
    ),
    QuizQuestion(
      text: 'Jaką nadzieję wyraża Micheasz mimo otaczającej zepsucia?',
      options: <String>[
        'Bóg ponownie okaże swoje współczucie',
        'Żadna nadzieja nie jest możliwa',
        'Sąd będzie ostateczny, bez przebaczenia',
        'Lud sam musi się zemścić',
      ],
      correctIndex: 0,
      explanation:
          'Odnowiona ufność kończy księgę (Micheasza 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['gniew', 'sąd', 'morze'],
    ),
  ],
  'Nahum#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Nahuma 1 opisuje charakter Jehowy?',
      options: <String>[
        'Cierpliwy, lecz potężny w swojej sprawiedliwości',
        'Obojętny na niesprawiedliwość',
        'Słaby w obliczu narodów',
        'Pozbawiony jakichkolwiek emocji',
      ],
      correctIndex: 0,
      explanation:
          'Równowaga między cierpliwością a mocą (Nahuma 1).',
    ),
    QuizQuestion(
      text: 'Komu Nahum oferuje pociechę mimo ogłoszonego sądu?',
      options: <String>['Tym, którzy szukają w nim schronienia', 'Wyłącznie mieszkańcom Niniwy', 'Obcym królom', 'Nikomu'],
      correctIndex: 0,
      explanation:
          'Pocieszenie dla wiernych (Nahuma 1:7).',
    ),
  ],
  'Nahum#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co Nahuma 2 opisuje z taką intensywnością?',
      options: <String>['Oblężenie i upadek Niniwy', 'Budowę świątyni', 'Święto żniw', 'Koronację królewską'],
      correctIndex: 0,
      explanation:
          'Żywy opis bitwy (Nahuma 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Samaria', 'Babilon', 'Juda'],
    ),
    QuizQuestion(
      text: 'Jaki ton dominuje w tym opisie upadku Niniwy?',
      options: <String>['Nieunikniony i całkowity sąd', 'Łagodne ostrzeżenie', 'Nadzieja na trwały pokój', 'Trwające negocjacje'],
      correctIndex: 0,
      explanation:
          'Koniec Niniwy jest przedstawiony jako pewny (Nahuma 2).',
    ),
  ],
  'Nahum#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak Nahuma 3 opisuje Niniwę?',
      options: <String>['Zbroczone krwią miasto', 'Święte miasto', 'Miasto pokoju', 'Błogosławione miasto'],
      correctIndex: 0,
      explanation:
          'Surowy sąd za jej przemoc (Nahuma 3:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Niniwa', 'zrujnowane', 'dumne'],
    ),
    QuizQuestion(
      text: 'Jaki ostateczny los ogłoszony jest dla Niniwy?',
      options: <String>['Całkowite zniszczenie', 'Przyszłe przywrócenie', 'Sojusz z Izraelem', 'Zwykłe ostrzeżenie bez konsekwencji'],
      correctIndex: 0,
      explanation:
          'Księga kończy się nieodwracalnym upadkiem miasta (Nahuma 3).',
    ),
  ],
  'Habakkuk#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Na co skarży się Habakuk na początku księgi?',
      options: <String>[
        'Na niesprawiedliwość i przemoc, które trwają bez odpowiedzi',
        'Na brak żywności',
        'Wyłącznie na nadciągającą inwazję',
        'Na osobisty konflikt z kapłanem',
      ],
      correctIndex: 0,
      explanation:
          'Szczera skarga w obliczu niesprawiedliwości (Habakuka 1).',
    ),
    QuizQuestion(
      text: 'Jakiej zaskakującej odpowiedzi udziela Bóg Habakukowi?',
      options: <String>[
        'Użyje Chaldejczyków (Babilończyków), aby wykonać sąd',
        'W ogóle nic nie zrobi',
        'Natychmiast zniszczy Babilon',
        'Zignoruje sytuację',
      ],
      correctIndex: 0,
      explanation:
          'Odpowiedź, która jeszcze bardziej niepokoi proroka (Habakuka 1).',
    ),
  ],
  'Habakkuk#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaką słynną prawdę potwierdza Habakuka 2 o prawym?',
      options: <String>[
        'Prawy będzie żył dzięki swojej wierności',
        'Prawy zawsze musi wątpić',
        'Tylko bogactwo ratuje prawego',
        'Prawy nie ma żadnej nadziei',
      ],
      correctIndex: 0,
      explanation:
          'Oświadczenie później cytowane w Chrześcijańskich Pismach Greckich (Habakuka 2:4).',
    ),
    QuizQuestion(
      text: 'Co wypełni całą ziemię, według Habakuka 2?',
      options: <String>[
        'Poznanie chwały Jehowy',
        'Bogactwo narodów',
        'Całkowitą ciszę',
        'Panowanie Babilonu na zawsze',
      ],
      correctIndex: 0,
      explanation:
          'Powszechna obietnica nadziei (Habakuka 2:14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['wody', 'morze', 'ziemia'],
    ),
  ],
  'Habakkuk#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaką postawę przyjmuje Habakuk w swojej końcowej modlitwie mimo braku plonów?',
      options: <String>[
        'Mimo wszystko będzie się radować w Jehowie',
        'Porzuci swoją wiarę',
        'Będzie przeklinał Boga',
        'Ucieknie daleko od swojego kraju',
      ],
      correctIndex: 0,
      explanation:
          'Ufność, która wznosi się ponad okoliczności (Habakuka 3:17, 18).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['figa', 'trzoda', 'winorośl'],
    ),
    QuizQuestion(
      text: 'Jak kończy się Księga Habakuka?',
      options: <String>[
        'Pieśnią ufności w siłę, jaką daje Bóg',
        'Beznadziejnym sądem',
        'Listą praw',
        'Całkowitym milczeniem',
      ],
      correctIndex: 0,
      explanation:
          'Psalm wiary kończy księgę (Habakuka 3).',
    ),
  ],
  'Zephaniah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakie centralne wydarzenie ogłasza Sofoniasza 1?',
      options: <String>[
        'Wielki dzień Jehowy, dzień sądu',
        'Święto żniw',
        'Budowę nowego pałacu',
        'Sojusz handlowy',
      ],
      correctIndex: 0,
      explanation:
          'Ogłoszony jest powszechny sąd (Sofoniasza 1).',
    ),
    QuizQuestion(
      text: 'Kogo ten sąd dotyczy przede wszystkim?',
      options: <String>['Judy i Jerozolimy', 'Wyłącznie Egiptu', 'Wyłącznie Niniwy', 'Wyłącznie Edomu'],
      correctIndex: 0,
      explanation:
          'Sąd zaczyna się od samego ludu Bożego (Sofoniasza 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Niniwa', 'Moab', 'Egipt'],
    ),
  ],
  'Zephaniah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Co radzi Sofoniasza 2 przed nadejściem sądu?',
      options: <String>['Szukania Jehowy i pokory', 'Beztroskiej radości', 'Ignorowania ostrzeżeń', 'Bezmyślnej ucieczki'],
      correctIndex: 0,
      explanation:
          'Pilne wezwanie do skruchy (Sofoniasza 2:3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pycha', 'narody', 'bogactwo'],
    ),
    QuizQuestion(
      text: 'Jakie narody są również sądzone w tym rozdziale?',
      options: <String>['Sąsiednie narody, takie jak Moab i Ammon', 'Wyłącznie Izrael', 'Żaden inny naród', 'Wyłącznie Babilon'],
      correctIndex: 0,
      explanation:
          'Sąd rozciąga się na okoliczne narody (Sofoniasza 2).',
    ),
  ],
  'Zephaniah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaką radosną obietnicą kończy się Księga Sofoniasza?',
      options: <String>[
        'Jehowa będzie się radował swoim ludem, śpiewając',
        'Sąd pozostanie trwały',
        'Nie jest obiecane żadne przywrócenie',
        'Lud zostanie zapomniany na zawsze',
      ],
      correctIndex: 0,
      explanation:
          'Wzruszający obraz boskiej radości (Sofoniasza 3:17).',
    ),
    QuizQuestion(
      text: 'Co obiecuje Sofoniasza 3 w kwestii wiernego ostatku?',
      options: <String>[
        'Zostanie oczyszczony i zgromadzony',
        'Całkowicie zniknie',
        'Zostanie wygnany na zawsze',
        'Nie będzie miał przyszłości',
      ],
      correctIndex: 0,
      explanation:
          'Nadzieja przywrócenia dla wiernych (Sofoniasza 3).',
    ),
  ],
  'Haggai#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki wyrzut czyni Aggeusz ludowi, który wrócił z wygnania?',
      options: <String>[
        'Zaniedbali odbudowę świątyni',
        'Zbyt dużo pracowali przy świątyni',
        'Nie mieli wystarczająco pieniędzy, co było zrozumiałe',
        'Zbudowali zbyt wiele świątyń',
      ],
      correctIndex: 0,
      explanation:
          'Lud stawiał na pierwszym miejscu własne domy (Aggeusza 1).',
    ),
    QuizQuestion(
      text: 'Jaka obietnica zachęca do wznowienia budowy świątyni?',
      options: <String>[
        'Chwała tego domu przewyższy chwałę poprzedniego',
        'Świątynia nigdy nie zostanie ukończona',
        'Nie daje się żadnej zachęty',
        'Świątynia zostanie na stałe porzucona',
      ],
      correctIndex: 0,
      explanation:
          'Silna zachęta dla Zorobabela i ludu (Aggeusza 2:9).',
    ),
  ],
  'Zechariah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jakiego rodzaju objawienia otrzymuje Zachariasz na początku księgi?',
      options: <String>[
        'Serię symbolicznych nocnych wizji',
        'Zwykłe publiczne przemówienie',
        'List od obcego króla',
        'Wyłącznie królewski dekret',
      ],
      correctIndex: 0,
      explanation:
          'Osiem nocnych wizji kształtuje te rozdziały (Zachariasza 1-5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sny', 'anioł', 'świątynia'],
    ),
    QuizQuestion(
      text: 'Co symbolizuje oczyszczenie arcykapłana Jozuego w jednej z tych wizji?',
      options: <String>[
        'Przebaczenie i odnowienie kapłaństwa',
        'Ostateczne potępienie kapłanów',
        'Koniec kapłaństwa',
        'Zwykłą zmianę ubioru bez znaczenia',
      ],
      correctIndex: 0,
      explanation:
          'Jego brudne szaty zostają zastąpione świątecznym strojem (Zachariasza 3).',
    ),
  ],
  'Zechariah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Jak opisany jest przyszły mesjański król w Zachariasza 9?',
      options: <String>[
        'Pokorny, jadący na młodym ośle',
        'Zdobywający na wojennym rydwanie',
        'Niewidzialny i bezkształtny',
        'Towarzyszy mu wielkie wojsko',
      ],
      correctIndex: 0,
      explanation:
          'Proroctwo spełnione podczas triumfalnego wjazdu Jezusa (Zachariasza 9:9).',
    ),
    QuizQuestion(
      text: 'Co odpowiada Zachariasza 7-8 na pytanie o rytualny post?',
      options: <String>[
        'Sprawiedliwość i miłosierdzie liczą się bardziej niż rytuał',
        'Sam post zawsze wystarcza',
        'Post musi zostać natychmiast zniesiony',
        'Nie daje się żadnej odpowiedzi',
      ],
      correctIndex: 0,
      explanation:
          'Nacisk kładziony jest na nastawienie serca, a nie na rytuał (Zachariasza 7-8).',
    ),
  ],
  'Zechariah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Które proroctwo z Zachariasza 11 wiąże się ze zdradą Judasza?',
      options: <String>[
        'Trzydzieści srebrników',
        'Zniszczenie świątyni',
        'Upadek Babilonu',
        'Wyrok przeciw Egiptowi',
      ],
      correctIndex: 0,
      explanation:
          'Ten szczegół zostaje podjęty w relacjach ewangelicznych (Zachariasza 11:12, 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['złoto', 'pasterz', 'garncarz'],
    ),
    QuizQuestion(
      text: 'Jak kończy się Księga Zachariasza w kwestii przyszłości?',
      options: <String>[
        'Jehowa stanie się królem nad całą ziemią',
        'Świat pozostanie na zawsze podzielony',
        'Nie zostaje dana żadna ostateczna nadzieja',
        'Jerozolima zniknie na zawsze',
      ],
      correctIndex: 0,
      explanation:
          'Powszechna wizja boskiego panowania (Zachariasza 14:9).',
    ),
  ],
  'Malachi#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki wyrzut czyni Malachiasz kapłanom w rozdziale 1?',
      options: <String>[
        'Składanie Jehowie wadliwych ofiar',
        'Nigdy nie składanie ofiar',
        'Zbyt częste modlenie się',
        'Budowę drugiej świątyni',
      ],
      correctIndex: 0,
      explanation:
          'Potępiona jest pogarda wobec ofiar (Malachiasza 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['dziesięciny', 'kadzidło', 'ołtarz'],
    ),
    QuizQuestion(
      text: 'Jak Malachiasza 1 ilustruje miłość Jehowy do swojego ludu?',
      options: <String>[
        'Przez zestawienie Jakuba i Ezawa',
        'Przez całkowite zignorowanie Izraela',
        'Przez faworyzowanie innego narodu',
        'Przez brak jakiegokolwiek rozróżnienia',
      ],
      correctIndex: 0,
      explanation:
          'Kontrast uwydatnia łaskę okazaną Jakubowi (Malachiasza 1:2, 3).',
    ),
  ],
  'Malachi#1': <QuizQuestion>[
    QuizQuestion(
      text: 'O co prosi Malachiasza 3 w kwestii dziesięcin?',
      options: <String>[
        'Aby przynieść całą dziesięcinę i „wystawić Boga na próbę”',
        'Aby całkowicie zlikwidować dziesięcinę',
        'Aby zastrzec ją tylko dla bogatych',
        'Aby złożyć ją tylko raz w życiu',
      ],
      correctIndex: 0,
      explanation:
          'Wyzwanie, by praktycznie zaufać Bogu (Malachiasza 3:10).',
    ),
    QuizQuestion(
      text: 'Jakiego posłańca zapowiada Malachiasza 3 przed przyjściem Pana?',
      options: <String>[
        'Posłańca, który przygotuje drogę',
        'Obcego króla',
        'Tylko nowego kapłana',
        'Nie wspomina się o żadnym posłańcu',
      ],
      correctIndex: 0,
      explanation:
          'Proroctwo związane z Janem Chrzcicielem (Malachiasza 3:1).',
    ),
  ],
  'Malachi#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Jaki straszny dzień zapowiada Malachiasza 4?',
      options: <String>[
        'Wielki i straszny dzień Jehowy',
        'Dzień świąteczny bez żadnych konsekwencji',
        'Zwykły dzień targowy',
        'Żaden szczególny dzień',
      ],
      correctIndex: 0,
      explanation: 'Obraz ostatecznego sądu (Malachiasza 4:1).',
    ),
    QuizQuestion(
      text: 'Kto, jak ogłasza Malachiasz, musi powrócić przed tym dniem?',
      options: <String>['Eliasz', 'Mojżesz', 'Dawid', 'Salomon'],
      correctIndex: 0,
      explanation:
          'To proroctwo jest w Ewangeliach związane z Janem Chrzcicielem (Malachiasza 4:5).',
      type: QuizAnswerType.freeText,
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesPlC4 = <String, List<QuizQuestion>>{};
