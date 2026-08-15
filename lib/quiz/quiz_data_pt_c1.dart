import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesPtC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quantos dias de criação Gênesis descreve antes de Deus '
          'descansar?',
      options: <String>['Seis dias', 'Sete dias', 'Três dias', 'Quarenta dias'],
      correctIndex: 0,
      explanation:
          'Gênesis descreve seis dias de criação; Deus descansa no sétimo '
          '(Gênesis 1 e 2).',
    ),
    QuizQuestion(
      text: 'Quem foram o primeiro homem e a primeira mulher?',
      options: <String>[
        'Adão e Eva',
        'Caim e Abel',
        'Noé e sua esposa',
        'Abraão e Sara',
      ],
      correctIndex: 0,
      explanation: 'Adão e Eva são os primeiros seres humanos (Gênesis 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Caim', 'Noé', 'Sara'],
    ),
    QuizQuestion(
      text: 'Quem matou seu irmão Abel?',
      options: <String>['Caim', 'Sete', 'Noé', 'Cam'],
      correctIndex: 0,
      explanation: 'Caim mata seu irmão Abel por ciúme (Gênesis 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Por que Deus trouxe o Dilúvio?',
      options: <String>[
        'Por causa da maldade dos homens',
        'Por causa de uma seca',
        'Para aumentar os mares',
        'Sem motivo indicado',
      ],
      correctIndex: 0,
      explanation:
          'A maldade dos seres humanos era grande na terra (Gênesis 6).',
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Que sinal Deus deu como promessa de nunca mais destruir a '
          'terra por um dilúvio?',
      options: <String>[
        'O arco-íris',
        'Uma estrela',
        'Uma oliveira',
        'O trovão',
      ],
      correctIndex: 0,
      explanation: 'O arco-íris é o sinal da aliança (Gênesis 9).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['arco-íris'],
    ),
    QuizQuestion(
      text: 'Como se chamava a torre que os homens quiseram construir?',
      options: <String>[
        'A torre de Babel',
        'A torre de Sião',
        'A torre de Davi',
        'A torre de Ur',
      ],
      correctIndex: 0,
      explanation: 'Em Babel, Deus confunde a língua deles (Gênesis 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sião', 'Davi', 'Ur'],
    ),
    QuizQuestion(
      text: 'Quem Deus chamou para sair de Ur?',
      options: <String>['Abrão (Abraão)', 'Ló', 'Isaque', 'Jacó'],
      correctIndex: 0,
      explanation: 'Deus chama Abrão e lhe faz promessas (Gênesis 12).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Por que os egípcios escravizaram os israelitas?',
      options: <String>[
        'Temiam que eles se tornassem numerosos demais',
        'Queriam suas terras',
        'Uma dívida não paga',
        'Uma guerra perdida',
      ],
      correctIndex: 0,
      explanation: 'Um novo rei teme a multiplicação dos israelitas (Êxodo 1).',
    ),
    QuizQuestion(
      text: 'Onde a mãe de Moisés escondeu o bebê?',
      options: <String>[
        'Um cesto de junco no Nilo',
        'Uma caverna',
        'Uma tenda',
        'Um poço',
      ],
      correctIndex: 0,
      explanation:
          'Moisés é colocado num cesto de junco entre os juncos (Êxodo 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['barco', 'palácio', 'deserto'],
    ),
    QuizQuestion(
      text: 'Como Deus apareceu a Moisés no monte Horebe?',
      options: <String>[
        'Uma sarça em chamas que não se consumia',
        'Uma coluna de nuvem',
        'Um anjo visível',
        'Um terremoto',
      ],
      correctIndex: 0,
      explanation: 'Deus fala com Moisés desde uma sarça ardente (Êxodo 3).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Que festividade Deus institui antes de tirar Israel do Egito?',
      options: <String>['A Páscoa', 'Pentecostes', 'As Tendas', 'O Sábado'],
      correctIndex: 0,
      explanation:
          'A Páscoa lembra a proteção dos israelitas durante a última '
          'praga (Êxodo 12).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Páscoa'],
    ),
    QuizQuestion(
      text: 'Como Deus abriu um caminho para Israel?',
      options: <String>[
        'Separando as águas do mar Vermelho',
        'Secando o Jordão',
        'Cavando um túnel',
        'Enviando uma ponte de pedra',
      ],
      correctIndex: 0,
      explanation:
          'O mar Vermelho se abre para deixar Israel passar (Êxodo 14).',
    ),
    QuizQuestion(
      text: 'Que alimento Deus fez cair do céu no deserto?',
      options: <String>['O maná', 'Pão de cevada', 'Figos', 'Mel'],
      correctIndex: 0,
      explanation: 'O maná aparece toda manhã (Êxodo 16).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['maná'],
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quem aconselhou Moisés a delegar a resolução das disputas?',
      options: <String>['Jetro, seu sogro', 'Arão', 'Josué', 'Miriã'],
      correctIndex: 0,
      explanation:
          'Jetro sugere nomear chefes para julgar os casos do dia a dia '
          '(Êxodo 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Jetro'],
    ),
    QuizQuestion(
      text: 'Onde Deus deu os Dez Mandamentos?',
      options: <String>[
        'No monte Sinai',
        'No monte Nebo',
        'Em Cades',
        'Em Betel',
      ],
      correctIndex: 0,
      explanation: 'A lei é dada no monte Sinai (Êxodo 19-20).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Horebe', 'Nebo', 'Carmelo'],
    ),
    QuizQuestion(
      text: 'Que mandamento proíbe desejar os bens de outra pessoa?',
      options: <String>[
        'O décimo (“Não cobiçarás”)',
        'O primeiro',
        'O quinto',
        'O sétimo',
      ],
      correctIndex: 0,
      explanation: 'O décimo mandamento proíbe a cobiça (Êxodo 20:17).',
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que era preciso construir segundo as instruções divinas '
          'dadas a Moisés?',
      options: <String>[
        'O tabernáculo',
        'Um palácio',
        'Um muro',
        'Um templo de pedra',
      ],
      correctIndex: 0,
      explanation: 'Deus dá planos detalhados para o tabernáculo (Êxodo 25).',
    ),
    QuizQuestion(
      text: 'O que o povo fabricou durante a ausência de Moisés no monte?',
      options: <String>[
        'Um bezerro de ouro',
        'Uma estátua de pedra',
        'Um altar de madeira',
        'Um templo',
      ],
      correctIndex: 0,
      explanation: 'O povo molda um bezerro de ouro e o adora (Êxodo 32).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pedra', 'prata', 'altar'],
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que cobria o tabernáculo assim que ficou pronto, sinal da '
          'presença de Deus?',
      options: <String>[
        'Uma nuvem',
        'Um fogo visível em pleno dia',
        'Um arco-íris',
        'Uma estrela',
      ],
      correctIndex: 0,
      explanation:
          'A nuvem cobre a tenda de reunião e a glória de Jeová a enche '
          '(Êxodo 40).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['nuvem'],
    ),
    QuizQuestion(
      text:
          'Quem por fim talhou novas tábuas de pedra depois que Moisés '
          'quebrou as primeiras?',
      options: <String>[
        'Moisés, por ordem de Deus',
        'Arão',
        'Josué',
        'Bezalel',
      ],
      correctIndex: 0,
      explanation:
          'Deus ordena a Moisés que talhe duas novas tábuas (Êxodo 34).',
    ),
  ],
  'Leviticus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Que tipo de sacrifício era totalmente queimado sobre o altar?',
      options: <String>[
        'O holocausto',
        'A oferta de comunhão',
        'A oferta de cereais',
        'A oferta pelo pecado',
      ],
      correctIndex: 0,
      explanation:
          'O holocausto é totalmente consumido sobre o altar '
          '(Levítico 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['holocausto'],
    ),
    QuizQuestion(
      text:
          'Quantos tipos principais de ofertas são descritos nestes '
          'primeiros capítulos?',
      options: <String>['Cinco', 'Dois', 'Dez', 'Três'],
      correctIndex: 0,
      explanation:
          'Holocausto, oferta de cereais, de comunhão, pelo pecado e pela '
          'culpa (Levítico 1-7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['5'],
    ),
    QuizQuestion(
      text: 'Quem devia trazer as ofertas à entrada da tenda de reunião?',
      options: <String>[
        'A própria pessoa, com a ajuda dos sacerdotes',
        'Somente os sacerdotes',
        'Somente os anciãos',
        'Um enviado do rei',
      ],
      correctIndex: 0,
      explanation:
          'Quem oferece traz o próprio animal, e os sacerdotes oficiam '
          '(Levítico 1-7).',
    ),
  ],
  'Leviticus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Por que Nadabe e Abiú morreram?',
      options: <String>[
        'Ofereceram um fogo não autorizado diante de Jeová',
        'Desobedeceram a Moisés',
        'Comeram um alimento impuro',
        'Recusaram-se a servir',
      ],
      correctIndex: 0,
      explanation:
          'Os filhos de Arão oferecem um “fogo estranho” e morrem '
          '(Levítico 10).',
    ),
    QuizQuestion(
      text: 'Que critério tornava um animal terrestre puro para se comer?',
      options: <String>[
        'Casco fendido e ruminação',
        'Viver apenas no deserto',
        'Ser domesticado',
        'Ter penas',
      ],
      correctIndex: 0,
      explanation:
          'Os animais puros ruminam e têm o casco fendido (Levítico 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['penas', 'escamas', 'sangue'],
    ),
    QuizQuestion(
      text:
          'Que doença deviam os sacerdotes examinar em detalhe '
          'nesses capítulos?',
      options: <String>['A lepra', 'A varíola', 'Apenas queimaduras', 'A acne'],
      correctIndex: 0,
      explanation:
          'Os sacerdotes examinam os sinais de lepra na pele, nas roupas '
          'e nas casas (Levítico 13-14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['lepra'],
    ),
  ],
  'Leviticus#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Uma vez por ano, em que dia solene os pecados da nação eram '
          'cobertos?',
      options: <String>[
        'O Dia da Expiação (Yom Kipur)',
        'A Páscoa',
        'O Sábado',
        'Pentecostes',
      ],
      correctIndex: 0,
      explanation:
          'O sumo sacerdote faz expiação pela nação uma vez ao ano '
          '(Levítico 16).',
    ),
    QuizQuestion(
      text: 'Que mandamento bem conhecido se encontra em Levítico 19?',
      options: <String>[
        'Ame o seu próximo como a si mesmo',
        'Não roube gado',
        'Descanse a cada sete anos',
        'Honre o rei',
      ],
      correctIndex: 0,
      explanation: 'Levítico 19:18 é citado mais tarde pelo próprio Jesus.',
    ),
    QuizQuestion(
      text:
          'O que se devia evitar segundo Levítico 17 quanto à '
          'alimentação?',
      options: <String>[
        'Consumir sangue',
        'Comer à noite',
        'Comer sozinho',
        'Comer pão',
      ],
      correctIndex: 0,
      explanation: 'O consumo de sangue é proibido (Levítico 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['sangue', 'o sangue'],
    ),
  ],
  'Leviticus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Que festividades anuais são listadas em Levítico 23?',
      options: <String>[
        'Páscoa, Pentecostes, Trombetas, Expiação, Tendas',
        'Somente a Páscoa',
        'Só o Ano-Novo e mais nada',
        'Apenas jejuns',
      ],
      correctIndex: 0,
      explanation:
          'O calendário de festividades cobre todo o ano religioso '
          '(Levítico 23).',
    ),
    QuizQuestion(
      text: 'O que se devia fazer a cada 50 anos, no Jubileu?',
      options: <String>[
        'Devolver as terras e libertar os escravos hebreus',
        'Destruir as colheitas',
        'Eleger um novo sumo sacerdote',
        'Revisar a lei',
      ],
      correctIndex: 0,
      explanation:
          'O ano do Jubileu restaura as terras e as liberdades '
          '(Levítico 25).',
    ),
    QuizQuestion(
      text: 'O que Levítico 26 promete em caso de fidelidade à aliança?',
      options: <String>[
        'Bênçãos; a desobediência traz desgraças',
        'Nada em especial',
        'Riqueza imediata sem condição',
        'Guerra sistemática',
      ],
      correctIndex: 0,
      explanation:
          'Bênçãos e maldições condicionais são detalhadas '
          '(Levítico 26).',
    ),
  ],
  'Numbers#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Por que Israel fez um recenseamento no deserto do Sinai?',
      options: <String>[
        'Para contar os homens aptos para a guerra',
        'Para taxar cada família',
        'Para escolher um rei',
        'Para repartir terras',
      ],
      correctIndex: 0,
      explanation:
          'O recenseamento conta os homens de 20 anos ou mais aptos '
          'para lutar (Números 1).',
    ),
    QuizQuestion(
      text:
          'Quem era responsável pelo transporte e serviço do '
          'tabernáculo?',
      options: <String>[
        'Os levitas',
        'Somente os sacerdotes',
        'Os anciãos',
        'Os guerreiros',
      ],
      correctIndex: 0,
      explanation:
          'Os levitas recebem tarefas específicas para o tabernáculo '
          '(Números 3-4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['levitas'],
    ),
    QuizQuestion(
      text: 'O que devia fazer uma pessoa que fizesse o voto de nazireu?',
      options: <String>[
        'Abster-se de vinho e não cortar o cabelo',
        'Jejuar 40 dias',
        'Viver sozinha no deserto',
        'Oferecer todo o seu gado',
      ],
      correctIndex: 0,
      explanation:
          'O voto de nazireu impõe restrições específicas (Números 6).',
    ),
  ],
  'Numbers#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quem Deus encarregou de ajudar Moisés a carregar o fardo do '
          'povo?',
      options: <String>[
        '70 anciãos',
        'Os 12 espiões',
        'Somente Arão',
        'Somente Josué',
      ],
      correctIndex: 0,
      explanation:
          '70 anciãos recebem o espírito para compartilhar a '
          'responsabilidade (Números 11).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['setenta anciãos', '70'],
    ),
    QuizQuestion(
      text:
          'O que aconteceu depois que Miriã e Arão criticaram '
          'Moisés?',
      options: <String>[
        'Miriã foi ferida com lepra',
        'Foram banidos definitivamente',
        'Nada lhes aconteceu',
        'Perderam a voz',
      ],
      correctIndex: 0,
      explanation: 'Miriã fica leprosa por sete dias (Números 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Arão', 'cegueira', 'deserto'],
    ),
    QuizQuestion(
      text: 'Quantos espiões deram um relatório encorajador sobre Canaã?',
      options: <String>['Dois (Josué e Calebe)', 'Doze', 'Nenhum', 'Cinco'],
      correctIndex: 0,
      explanation:
          'Somente Josué e Calebe encorajam o povo a entrar '
          '(Números 13-14).',
    ),
  ],
  'Numbers#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quem se rebelou contra a autoridade de Moisés e Arão?',
      options: <String>['Corá e seus seguidores', 'Josué', 'Calebe', 'Balaão'],
      correctIndex: 0,
      explanation: 'A rebelião de Corá é engolida pela terra (Números 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Arão', 'Moisés', 'tribo'],
    ),
    QuizQuestion(
      text: 'Que sinal confirmou a escolha de Arão como sumo sacerdote?',
      options: <String>[
        'Sua vara floresceu',
        'Uma voz celestial',
        'Um fogo sobre o altar',
        'Uma estrela',
      ],
      correctIndex: 0,
      explanation: 'A vara de Arão brota e floresce (Números 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['bastão', 'ouro', 'serpente'],
    ),
    QuizQuestion(
      text: 'Por que Moisés não pôde entrar na Terra Prometida?',
      options: <String>[
        'Ele bateu na rocha em vez de falar com ela',
        'Desobedeceu a uma ordem de guerra',
        'Adorou um ídolo',
        'Estava velho demais',
      ],
      correctIndex: 0,
      explanation:
          'Moisés bate na rocha com raiva, sem respeitar a santidade de '
          'Deus (Números 20).',
    ),
  ],
  'Numbers#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Quem Balaque contratou para amaldiçoar Israel?',
      options: <String>['Balaão', 'Corá', 'Ogue', 'Seom'],
      correctIndex: 0,
      explanation:
          'Balaão é chamado para amaldiçoar Israel, mas o abençoa '
          '(Números 23-24).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Quem agiu com zelo para deter a praga durante a apostasia de '
          'Baal-Peor?',
      options: <String>['Fineias', 'Josué', 'Somente Eleazar', 'Calebe'],
      correctIndex: 0,
      explanation: 'Fineias intervém e a praga cessa (Números 25).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Quem Jeová designou como sucessor de Moisés?',
      options: <String>['Josué', 'Calebe', 'Eleazar', 'Fineias'],
      correctIndex: 0,
      explanation:
          'Josué é estabelecido diante de Eleazar e da assembleia '
          '(Números 27).',
    ),
  ],
  'Numbers#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Contra que povo Israel travou uma guerra de julgamento?',
      options: <String>['Midiã', 'Edom', 'Todo o Moabe', 'Egito'],
      correctIndex: 0,
      explanation: 'A guerra contra Midiã é relatada (Números 31).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Que tribos se estabeleceram a leste do Jordão?',
      options: <String>[
        'Rúben, Gade e a metade de Manassés',
        'Judá e Benjamim',
        'Levi e Simeão',
        'Somente Efraim',
      ],
      correctIndex: 0,
      explanation:
          'Essas tribos obtêm terras a leste, com a condição de ajudar '
          'na conquista (Números 32).',
    ),
    QuizQuestion(
      text: 'O que deviam ser as cidades de refúgio?',
      options: <String>[
        'Lugares para onde fugir em caso de homicídio involuntário',
        'Capitais regionais',
        'Centros comerciais',
        'Lugares de culto apenas',
      ],
      correctIndex: 0,
      explanation:
          'As cidades de refúgio protegem quem matou sem intenção '
          '(Números 35).',
    ),
  ],
  'Deuteronomy#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Que grande mandamento Moisés repete em Deuteronômio 6, '
          'chamado de Shemá?',
      options: <String>[
        'Jeová é um só; ame-o de todo o coração',
        'Não coma porco',
        'Celebre cada lua nova',
        'Nunca trabalhe',
      ],
      correctIndex: 0,
      explanation: 'O Shemá (Deuteronômio 6:4, 5) é central na fé de Israel.',
    ),
    QuizQuestion(
      text:
          'O que Moisés lembra a respeito dos dez mandamentos nesses '
          'capítulos?',
      options: <String>[
        'Ele os repete ao povo antes da entrada em Canaã',
        'Ele os anula',
        'Ele acrescenta mais dez',
        'Ele os reserva aos sacerdotes',
      ],
      correctIndex: 0,
      explanation: 'Moisés repete os dez mandamentos (Deuteronômio 5).',
    ),
    QuizQuestion(
      text: 'Por que Israel devia desconfiar das nações de Canaã?',
      options: <String>[
        'Por causa do risco de idolatria',
        'Por causa de sua riqueza',
        'Por causa de sua língua',
        'Por causa de seu rei',
      ],
      correctIndex: 0,
      explanation:
          'O perigo de adotar os deuses deles é destacado '
          '(Deuteronômio 7).',
    ),
  ],
  'Deuteronomy#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que a lembrança do maná no deserto devia recordar a '
          'Israel?',
      options: <String>[
        'Que o homem não vive só de pão, mas de toda palavra que '
            'sai da boca de Jeová',
        'Que Deus sempre castiga',
        'Que o deserto é amaldiçoado',
        'Que a comida não tem importância',
      ],
      correctIndex: 0,
      explanation: 'Deuteronômio 8:3, citado mais tarde por Jesus.',
    ),
    QuizQuestion(
      text:
          'Que acontecimento do deserto Moisés relembra para advertir '
          'contra o orgulho?',
      options: <String>[
        'O bezerro de ouro',
        'A travessia do mar Vermelho',
        'O dom do maná',
        'A construção do tabernáculo',
      ],
      correctIndex: 0,
      explanation:
          'O bezerro de ouro ilustra a rebelião passada '
          '(Deuteronômio 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['serpente', 'maná', 'tábuas'],
    ),
    QuizQuestion(
      text:
          'Onde os israelitas deviam levar seus sacrifícios, segundo '
          'Deuteronômio 12?',
      options: <String>[
        'Ao único lugar que Jeová escolhesse',
        'Onde quisessem',
        'Em cada vilarejo',
        'Somente em casa',
      ],
      correctIndex: 0,
      explanation: 'Um único lugar de culto é prescrito (Deuteronômio 12).',
    ),
  ],
  'Deuteronomy#2': <QuizQuestion>[
    QuizQuestion(
      text: 'O que se devia fazer com as dívidas a cada sete anos?',
      options: <String>[
        'Cancelá-las (ano de remissão)',
        'Dobrá-las',
        'Transmiti-las aos filhos',
        'Nada de especial',
      ],
      correctIndex: 0,
      explanation: 'O ano de remissão cancela as dívidas (Deuteronômio 15).',
    ),
    QuizQuestion(
      text: 'O que Deuteronômio 18 anuncia sobre um futuro profeta?',
      options: <String>[
        'Que Jeová levantaria um semelhante a Moisés',
        'Um rei estrangeiro',
        'Um anjo',
        'Um juiz único',
      ],
      correctIndex: 0,
      explanation:
          'Essa profecia é aplicada a Cristo nas Escrituras Gregas '
          '(Deuteronômio 18).',
    ),
    QuizQuestion(
      text:
          'Quantas testemunhas eram necessárias para comprovar uma '
          'acusação?',
      options: <String>[
        'Duas ou três',
        'Uma só bastava',
        'Dez',
        'Nenhuma era exigida',
      ],
      correctIndex: 0,
      explanation: 'A lei exige várias testemunhas (Deuteronômio 19).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['2 ou 3', 'duas'],
    ),
  ],
  'Deuteronomy#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Que oferta anual lembrava a libertação do Egito?',
      options: <String>[
        'A oferta dos primeiros frutos',
        'O sacrifício do Jubileu',
        'Somente a oferta do dízimo',
        'A refeição comemorativa',
      ],
      correctIndex: 0,
      explanation:
          'A declaração dos primeiros frutos lembra a saída do Egito '
          '(Deuteronômio 26).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sacrifício', 'cordeiro', 'templo'],
    ),
    QuizQuestion(
      text:
          'O que os israelitas deviam fazer ao entrar em Canaã, no '
          'monte Ebal?',
      options: <String>[
        'Erguer um altar e proclamar bênçãos e maldições',
        'Construir um palácio',
        'Estabelecer a capital',
        'Destruir todas as árvores',
      ],
      correctIndex: 0,
      explanation:
          'A cerimônia nos montes Gerizim/Ebal é instituída '
          '(Deuteronômio 27).',
    ),
    QuizQuestion(
      text:
          'Que princípio regia as leis sobre o divórcio nesses '
          'capítulos?',
      options: <String>[
        'Exigia-se um certificado de divórcio por escrito',
        'O divórcio era proibido em qualquer forma',
        'Só a mulher podia se divorciar',
        'Não existia nenhuma regra',
      ],
      correctIndex: 0,
      explanation:
          'A lei regula o divórcio por meio de um documento formal '
          '(Deuteronômio 24).',
    ),
  ],
  'Deuteronomy#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que os capítulos 28 prometem em caso de fidelidade à '
          'aliança?',
      options: <String>[
        'Bênçãos; a desobediência traz maldições',
        'Nada concreto',
        'Uma guerra imediata',
        'Riqueza sem condição',
      ],
      correctIndex: 0,
      explanation: 'Bênçãos e maldições detalhadas (Deuteronômio 28).',
    ),
    QuizQuestion(
      text: 'Que escolha Moisés apresenta ao povo em Deuteronômio 30?',
      options: <String>[
        'A vida e a morte, a bênção e a maldição',
        'Ficar ou voltar para o Egito',
        'Servir a Arão ou a Josué',
        'Pagar um imposto ou não',
      ],
      correctIndex: 0,
      explanation: 'O povo é chamado a “escolher a vida” (Deuteronômio 30:19).',
    ),
    QuizQuestion(
      text: 'Onde Moisés morreu, sem entrar na Terra Prometida?',
      options: <String>[
        'No monte Nebo',
        'Em Jericó',
        'No monte Sinai',
        'Em Belém',
      ],
      correctIndex: 0,
      explanation:
          'Moisés contempla a terra do alto do Nebo antes de morrer '
          '(Deuteronômio 34).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sinai', 'Horebe', 'Carmelo'],
    ),
  ],
  'Joshua#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Que instrução Jeová repete a Josué no início do livro?',
      options: <String>[
        'Seja forte e corajoso',
        'Fique escondido',
        'Espere dez anos',
        'Volte para o Egito',
      ],
      correctIndex: 0,
      explanation: 'Jeová encoraja Josué várias vezes (Josué 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['medo', 'fiel', 'obedeça'],
    ),
    QuizQuestion(
      text: 'Quem escondeu os espiões israelitas em Jericó?',
      options: <String>['Raabe', 'Uma profetisa', 'O próprio rei', 'Ninguém'],
      correctIndex: 0,
      explanation: 'Raabe esconde os espiões em seu telhado (Josué 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Como caíram as muralhas de Jericó?',
      options: <String>[
        'Depois de uma procissão e do som das trombetas',
        'Por um terremoto natural',
        'Por um cerco de vários meses',
        'Pela traição de um morador',
      ],
      correctIndex: 0,
      explanation:
          'Depois de sete voltas e do som das trombetas, os muros caem '
          '(Josué 6).',
    ),
  ],
  'Joshua#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Como os gibeonitas escaparam da destruição?',
      options: <String>[
        'Fingindo ser viajantes vindos de longe',
        'Atacando primeiro',
        'Pagando tributo imediatamente',
        'Convertendo-se publicamente',
      ],
      correctIndex: 0,
      explanation:
          'O engano deles leva Israel a fazer um tratado de paz '
          '(Josué 9).',
    ),
    QuizQuestion(
      text:
          'O que aconteceu de extraordinário na batalha contra os '
          'cinco reis amorreus?',
      options: <String>[
        'O sol parou',
        'Um eclipse total',
        'Uma chuva de fogo',
        'Um terremoto os separou',
      ],
      correctIndex: 0,
      explanation: 'Jeová luta por Israel e o sol para (Josué 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['lua', 'fogo', 'caiu'],
    ),
    QuizQuestion(
      text: 'Que porção de terra Calebe reivindicou aos 85 anos?',
      options: <String>['Hebrom', 'Jericó', 'Siló', 'Betel'],
      correctIndex: 0,
      explanation: 'Calebe permanece fiel e recebe Hebrom (Josué 14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Joshua#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Onde o tabernáculo foi armado depois da conquista inicial?',
      options: <String>['Em Siló', 'Em Jerusalém', 'Em Hebrom', 'Em Betel'],
      correctIndex: 0,
      explanation: 'A tenda de reunião é estabelecida em Siló (Josué 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Siló'],
    ),
    QuizQuestion(
      text:
          'Por que as tribos do leste ergueram um altar perto do '
          'Jordão?',
      options: <String>[
        'Como testemunho de que pertenciam a Israel',
        'Para declarar independência',
        'Para adorar outro deus',
        'Por ordem de um rei estrangeiro',
      ],
      correctIndex: 0,
      explanation:
          'O altar é uma testemunha, não um lugar de sacrifício rival '
          '(Josué 22).',
    ),
    QuizQuestion(
      text: 'Que declaração famosa Josué faz em Siquém antes de morrer?',
      options: <String>[
        'Eu e minha casa serviremos a Jeová',
        'Vamos voltar para o Egito',
        'Um rei nos governará',
        'A guerra continuará para sempre',
      ],
      correctIndex: 0,
      explanation: 'Josué chama o povo a escolher a quem servir (Josué 24).',
    ),
  ],
  'Judges#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Que ciclo se repete ao longo do livro de Juízes?',
      options: <String>[
        'Infidelidade, opressão, clamor a Deus, libertação',
        'Paz permanente',
        'Guerra civil contínua',
        'Migração constante',
      ],
      correctIndex: 0,
      explanation: 'Esse ciclo estrutura todo o livro (Juízes 2).',
    ),
    QuizQuestion(
      text:
          'Quem liderou o exército de Israel contra Sísera, com a ajuda '
          'de Débora?',
      options: <String>['Baraque', 'Eúde', 'Otniel', 'Gideão'],
      correctIndex: 0,
      explanation: 'Débora e Baraque levam Israel à vitória (Juízes 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Como Gideão reduziu seu exército a 300 homens?',
      options: <String>[
        'Observando como bebiam água',
        'Sorteando',
        'Escolhendo os mais jovens',
        'Escolhendo os mais ricos',
      ],
      correctIndex: 0,
      explanation: 'O teste da água seleciona 300 homens (Juízes 7).',
    ),
  ],
  'Judges#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Como terminou o reinado de Abimeleque?',
      options: <String>[
        'Pereceu, atingido por uma pedra de moinho atirada por uma '
            'mulher',
        'Reinou em paz por muito tempo',
        'Foi expulso sem violência',
        'Fundou uma dinastia duradoura',
      ],
      correctIndex: 0,
      explanation:
          'Abimeleque morre com uma pedra de moinho atirada por uma '
          'mulher (Juízes 9).',
    ),
    QuizQuestion(
      text: 'Que voto trágico Jefté fez antes da batalha?',
      options: <String>[
        'Oferecer a primeira pessoa que saísse de sua casa',
        'Jejuar um ano',
        'Destruir sua casa',
        'Nunca se casar',
      ],
      correctIndex: 0,
      explanation: 'Sua filha é a primeira a sair ao seu encontro (Juízes 11).',
    ),
    QuizQuestion(
      text: 'Como se reconheciam os efraimitas na passagem do Jordão?',
      options: <String>[
        'Não conseguiam pronunciar “Chibolete” corretamente',
        'Por suas roupas',
        'Por seu sotaque cantado',
        'Por seu armamento',
      ],
      correctIndex: 0,
      explanation: 'A senha desmascara os fugitivos (Juízes 12).',
    ),
  ],
  'Judges#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Com que arma improvisada Sansão venceu mil filisteus?',
      options: <String>[
        'Uma queixada de jumento',
        'Uma espada',
        'Um estilingue',
        'Um bastão',
      ],
      correctIndex: 0,
      explanation: 'Sansão golpeia com uma queixada de jumento (Juízes 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['espada', 'leão', 'corda'],
    ),
    QuizQuestion(
      text: 'Quem revelou o segredo da força de Sansão aos filisteus?',
      options: <String>['Dalila', 'Sua mãe', 'Um juiz rival', 'Um sacerdote'],
      correctIndex: 0,
      explanation: 'Dalila descobre que sua força vem dos cabelos (Juízes 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Que frase resume a situação de Israel no fim do livro?',
      options: <String>[
        'Cada um fazia o que era certo aos seus próprios olhos',
        'Um rei justo reinava',
        'A paz reinava em toda parte',
        'Os sacerdotes governavam bem',
      ],
      correctIndex: 0,
      explanation:
          'Essa observação encerra vários relatos do livro '
          '(Juízes 17, 21).',
    ),
  ],
  'Ruth#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Por que Noemi e sua família foram para Moabe?',
      options: <String>[
        'Por causa de uma fome em Belém',
        'Para fugir de uma guerra',
        'A negócios',
        'Por ordem de um juiz',
      ],
      correctIndex: 0,
      explanation: 'A fome leva Elimeleque a emigrar (Rute 1).',
    ),
    QuizQuestion(
      text: 'Que decisão Rute toma em relação a Noemi?',
      options: <String>[
        'Ficar com ela: “Aonde você for, irei”',
        'Voltar para seu próprio povo',
        'Casar-se de novo imediatamente em Moabe',
        'Ficar sozinha em Moabe',
      ],
      correctIndex: 0,
      explanation: 'Rute expressa um apego leal muito conhecido (Rute 1:16).',
    ),
    QuizQuestion(
      text: 'O que aconteceu com os maridos de Noemi e de suas noras?',
      options: <String>[
        'Todos morreram em Moabe',
        'Voltaram para Belém',
        'Prosperaram em Moabe',
        'Fundaram uma cidade',
      ],
      correctIndex: 0,
      explanation:
          'Elimeleque, e depois seus dois filhos, morrem em Moabe '
          '(Rute 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Belém', 'voltaram', 'Noemi'],
    ),
  ],
  'Ruth#1': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Rute fazia nos campos de Boaz?',
      options: <String>[
        'Catava as espigas deixadas pelos ceifeiros',
        'Vendia tecidos',
        'Cuidava dos rebanhos',
        'Ensinava a lei',
      ],
      correctIndex: 0,
      explanation:
          'Rute cata espigas para alimentar Noemi e a si mesma (Rute 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Boaz', 'campo', 'trigo'],
    ),
    QuizQuestion(
      text: 'Como Boaz demonstrou bondade para com Rute?',
      options: <String>[
        'Permitindo que ela catasse em segurança e compartilhando sua refeição',
        'Ignorando-a educadamente',
        'Mandando-a embora do campo',
        'Exigindo um pagamento',
      ],
      correctIndex: 0,
      explanation: 'Boaz protege Rute e a trata com favor (Rute 2).',
    ),
    QuizQuestion(
      text: 'O que Noemi aconselha Rute a respeito de Boaz?',
      options: <String>[
        'Ir à eira e se dar a conhecer a ele',
        'Evitá-lo completamente',
        'Partir para Moabe',
        'Casar-se com outro homem',
      ],
      correctIndex: 0,
      explanation: 'Noemi orienta Rute rumo a um possível resgate (Rute 3).',
    ),
  ],
  'Ruth#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Como Boaz resolveu a questão do direito de resgate diante '
          'dos anciãos?',
      options: <String>[
        'Um parente mais próximo renunciou publicamente ao seu direito',
        'Um sorteio decidiu',
        'O rei decidiu',
        'Ninguém foi consultado',
      ],
      correctIndex: 0,
      explanation: 'O procedimento legal ocorre no portão da cidade (Rute 4).',
    ),
    QuizQuestion(
      text: 'Que filho Rute e Boaz tiveram?',
      options: <String>['Obede', 'Davi', 'Jessé', 'Salomão'],
      correctIndex: 0,
      explanation: 'Obede se torna o avô de Davi (Rute 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Por que o livro de Rute termina com uma genealogia?',
      options: <String>[
        'Para ligar Rute à linhagem que leva a Davi',
        'Por simples tradição literária',
        'Para encerrar um debate jurídico',
        'Para honrar Moabe',
      ],
      correctIndex: 0,
      explanation: 'A genealogia liga Rute a Davi (Rute 4:17-22).',
    ),
  ],
};

const Map<String, List<QuizQuestion>>
extraQuizzesPtC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Que árvore do jardim do Éden era proibida a Adão e Eva?',
      options: <String>[
        'A árvore do conhecimento do bem e do mal',
        'A árvore da vida',
        'Uma figueira',
        'Uma oliveira',
      ],
      correctIndex: 0,
      explanation: 'Deus proíbe somente essa árvore (Gênesis 2:17).',
    ),
    QuizQuestion(
      text: 'Quem enganou Eva para que comesse do fruto proibido?',
      options: <String>['A serpente', 'Caim', 'Um anjo', 'Adão'],
      correctIndex: 0,
      explanation: 'A serpente a induz a desobedecer (Gênesis 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['serpente'],
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Que ave, enviada por Noé, voltou com uma folha de oliveira?',
      options: <String>['A pomba', 'O corvo', 'A águia', 'O pardal'],
      correctIndex: 0,
      explanation: 'A pomba mostra que as águas estavam baixando (Gênesis 8).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['pomba'],
    ),
    QuizQuestion(
      text:
          'Quem, rei de Salém e sacerdote do Deus Altíssimo, '
          'abençoou Abrão?',
      options: <String>['Melquisedeque', 'Ló', 'Faraó', 'Isaque'],
      correctIndex: 0,
      explanation:
          'Melquisedeque abençoa Abrão depois de uma vitória (Gênesis 14).',
    ),
  ],
  'Genesis#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Que sinal da aliança Deus deu a Abraão?',
      options: <String>[
        'A circuncisão',
        'Uma tatuagem',
        'Um anel',
        'Um bastão',
      ],
      correctIndex: 0,
      explanation: 'A circuncisão marca a aliança (Gênesis 17).',
    ),
    QuizQuestion(
      text: 'Como se chamava o filho de Abraão e Agar?',
      options: <String>['Ismael', 'Isaque', 'Esaú', 'Jacó'],
      correctIndex: 0,
      explanation: 'Ismael nasce de Agar, a serva (Gênesis 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Que cidades Deus destruiu por causa de sua maldade?',
      options: <String>[
        'Sodoma e Gomorra',
        'Babel e Ur',
        'Nínive e Tiro',
        'Betel e Ai',
      ],
      correctIndex: 0,
      explanation: 'O fogo destrói essas cidades; Ló é salvo (Gênesis 19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Babel', 'Ur', 'Salém'],
    ),
  ],
  'Genesis#3': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Deus pediu que Abraão oferecesse no monte Moriá?',
      options: <String>[
        'Seu filho Isaque',
        'Um carneiro',
        'Sua tenda',
        'Seus rebanhos',
      ],
      correctIndex: 0,
      explanation: 'Deus detém Abraão e providencia um carneiro (Gênesis 22).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jacó', 'Esaú', 'cordeiro'],
    ),
    QuizQuestion(
      text:
          'Em troca de que Esaú vendeu seu direito de primogenitura '
          'a Jacó?',
      options: <String>[
        'Um prato de lentilhas',
        'Ouro',
        'Um rebanho',
        'Uma tenda',
      ],
      correctIndex: 0,
      explanation: 'Esaú despreza seu direito de primogenitura (Gênesis 25).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pão', 'ouro', 'carne'],
    ),
    QuizQuestion(
      text: 'O que Jacó viu em sonho em Betel?',
      options: <String>[
        'Uma escada que alcançava o céu, com anjos',
        'Um mar agitado',
        'Uma sarça em chamas',
        'Uma cidade em ruínas',
      ],
      correctIndex: 0,
      explanation: 'Deus confirma suas promessas a Jacó (Gênesis 28).',
    ),
  ],
  'Genesis#4': <QuizQuestion>[
    QuizQuestion(
      text: 'Que novo nome Jacó recebeu depois de lutar com o anjo?',
      options: <String>['Israel', 'Edom', 'Abraão', 'Efraim'],
      correctIndex: 0,
      explanation: 'O nome Israel significa “ele luta com Deus” (Gênesis 32).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Quantos filhos Jacó teve, que se tornaram ancestrais das '
          'tribos de Israel?',
      options: <String>['Doze', 'Dez', 'Sete', 'Catorze'],
      correctIndex: 0,
      explanation: 'Seus doze filhos fundam as tribos de Israel (Gênesis 35).',
    ),
    QuizQuestion(
      text: 'Com quem Jacó se reconciliou depois de anos separados?',
      options: <String>['Seu irmão Esaú', 'Labão', 'Faraó', 'Isaque'],
      correctIndex: 0,
      explanation: 'Os dois irmãos se reencontram em paz (Gênesis 33).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Labão', 'Raquel', 'Jacó'],
    ),
  ],
  'Genesis#5': <QuizQuestion>[
    QuizQuestion(
      text: 'O que os irmãos de José fizeram por ciúme?',
      options: <String>[
        'Venderam-no como escravo',
        'Coroaram-no rei',
        'Abandonaram-no no Egito',
        'Ignoraram-no',
      ],
      correctIndex: 0,
      explanation: 'José é vendido e levado para o Egito (Gênesis 37).',
    ),
    QuizQuestion(
      text: 'Que peça de roupa especial Jacó havia dado a José?',
      options: <String>[
        'Uma túnica bonita',
        'Uma coroa',
        'Uma armadura',
        'Um manto de sacerdote',
      ],
      correctIndex: 0,
      explanation: 'Esse presente atiça o ciúme de seus irmãos (Gênesis 37).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['manto', 'sandálias', 'cinto'],
    ),
    QuizQuestion(
      text:
          'O que José interpretou para Faraó, anunciando sete anos '
          'de fome?',
      options: <String>[
        'Os sonhos de Faraó',
        'Um livro antigo',
        'As estrelas',
        'Um oráculo',
      ],
      correctIndex: 0,
      explanation: 'José interpreta os sonhos de Faraó (Gênesis 41).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['sonhos', 'os sonhos', 'seus sonhos'],
    ),
  ],
  'Genesis#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Como José tratou seus irmãos depois de se dar a conhecer '
          'a eles?',
      options: <String>[
        'Ele os perdoou',
        'Prendeu-os para sempre',
        'Expulsou-os',
        'Ignorou-os',
      ],
      correctIndex: 0,
      explanation: 'José perdoa e os alimenta (Gênesis 45).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['puniu', 'castigou', 'Egito'],
    ),
    QuizQuestion(
      text: 'Onde Jacó e sua família se instalaram no Egito?',
      options: <String>[
        'Na terra de Gósen',
        'Em Mênfis',
        'Em Tebas',
        'No Sinai',
      ],
      correctIndex: 0,
      explanation: 'Faraó lhes dá a região de Gósen (Gênesis 47).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Canaã', 'Nilo', 'Menfis'],
    ),
    QuizQuestion(
      text: 'Como José via o mal que seus irmãos lhe haviam feito?',
      options: <String>[
        'Deus o havia transformado em bem para salvar vidas',
        'Como uma injustiça a vingar',
        'Como algo sem importância',
        'Como um simples acidente',
      ],
      correctIndex: 0,
      explanation: 'Uma declaração famosa de fé (Gênesis 50:20).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quem era o irmão de Moisés, designado como seu porta-voz?',
      options: <String>['Arão', 'Josué', 'Jetro', 'Calebe'],
      correctIndex: 0,
      explanation: 'Arão fala ao povo por Moisés (Êxodo 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Com que nome Jeová se identificou a Moisés na sarça '
          'ardente?',
      options: <String>[
        '“Eu serei o que eu serei”',
        '“O Deus sem nome”',
        '“O Deus oculto”',
        '“O rei dos reis”',
      ],
      correctIndex: 0,
      explanation: 'Deus revela o significado de seu nome (Êxodo 3:14).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Qual foi a décima e última praga do Egito?',
      options: <String>[
        'A morte dos primogênitos',
        'Os gafanhotos',
        'As trevas',
        'O granizo',
      ],
      correctIndex: 0,
      explanation: 'Essa praga leva Faraó a libertar Israel (Êxodo 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['rãs', 'gafanhotos', 'trevas'],
    ),
    QuizQuestion(
      text:
          'O que os israelitas deviam colocar em suas portas durante '
          'a Páscoa?',
      options: <String>[
        'Sangue de cordeiro',
        'Óleo',
        'Farinha',
        'Um sinal de cinzas',
      ],
      correctIndex: 0,
      explanation: 'O sangue protege seus primogênitos (Êxodo 12).',
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Como brotou água para o povo sedento em Horebe?',
      options: <String>[
        'Moisés bateu na rocha',
        'Uma fonte surgiu sozinha',
        'Choveu bastante',
        'Um poço foi cavado',
      ],
      correctIndex: 0,
      explanation: 'Por ordem de Deus, Moisés bate na rocha (Êxodo 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['vara', 'água', 'Arão'],
    ),
    QuizQuestion(
      text: 'Quantos mandamentos compõem o Decálogo dado no Sinai?',
      options: <String>['Dez', 'Sete', 'Doze', 'Cinco'],
      correctIndex: 0,
      explanation: 'Os Dez Mandamentos são dados no Sinai (Êxodo 20).',
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text: 'O que deveria conter a arca da aliança?',
      options: <String>[
        'As tábuas da Lei',
        'Ouro e prata',
        'Rolos de profecias',
        'Ofertas de alimento',
      ],
      correctIndex: 0,
      explanation: 'As tábuas dos mandamentos são colocadas nela (Êxodo 25).',
    ),
    QuizQuestion(
      text:
          'Quem fabricou o bezerro de ouro durante a ausência de '
          'Moisés?',
      options: <String>['Arão', 'Josué', 'Hur', 'Bezalel'],
      correctIndex: 0,
      explanation: 'Arão cede ao pedido do povo (Êxodo 32).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que caracterizava o rosto de Moisés depois que ele '
          'falou com Deus?',
      options: <String>[
        'Estava radiante',
        'Estava velado de tristeza',
        'Havia envelhecido',
        'Nada de especial',
      ],
      correctIndex: 0,
      explanation: 'Moisés precisava velar seu rosto radiante (Êxodo 34).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['radiante'],
    ),
    QuizQuestion(
      text: 'O que preenchia o tabernáculo assim que ficou pronto?',
      options: <String>[
        'A glória de Jeová (uma nuvem)',
        'Apenas fumaça de incenso',
        'Uma luz artificial',
        'Nada visível',
      ],
      correctIndex: 0,
      explanation: 'A nuvem sinaliza a presença divina (Êxodo 40).',
    ),
  ],
};
