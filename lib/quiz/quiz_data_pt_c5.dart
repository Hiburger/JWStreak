import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesPtC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quem anunciou a vinda de Jesus pregando no deserto?',
      options: <String>['João Batista', 'Elias', 'Isaías', 'Zacarias'],
      correctIndex: 0,
      explanation: 'João Batista prepara o caminho de Jesus (Mateus 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['João'],
    ),
    QuizQuestion(
      text: 'Quanto tempo Jesus jejuou antes de ser tentado pelo Diabo?',
      options: <String>['40 dias', '7 dias', '3 dias', '100 dias'],
      correctIndex: 0,
      explanation: 'Jesus jejua 40 dias e 40 noites (Mateus 4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['quarenta dias', '40'],
    ),
    QuizQuestion(
      text: 'Segundo o Sermão do Monte, quem é declarado feliz?',
      options: <String>[
        'Os que têm consciência de sua pobreza espiritual',
        'Os ricos',
        'Os poderosos',
        'Os famosos',
      ],
      correctIndex: 0,
      explanation:
          'As Bem-aventuranças começam com os pobres em espírito (Mateus 5:3).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quantos pães e peixes Jesus usou para alimentar cerca de 5.000 homens?',
      options: <String>[
        '5 pães e 2 peixes',
        '2 pães e 5 peixes',
        '7 pães',
        '12 pães',
      ],
      correctIndex: 0,
      explanation: 'Jesus multiplica 5 pães e 2 peixes (Mateus 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['cestos', 'doze', 'multidão'],
    ),
    QuizQuestion(
      text: 'O que Pedro fez ao ver Jesus andando sobre a água?',
      options: <String>[
        'Tentou andar sobre a água também',
        'Escondeu-se',
        'Fugiu',
        'Não fez nada',
      ],
      correctIndex: 0,
      explanation:
          'Pedro caminha em direção a Jesus, mas começa a afundar por falta de fé (Mateus 14).',
    ),
    QuizQuestion(
      text: 'Quem pediu a cabeça de João Batista em um prato?',
      options: <String>[
        'A filha de Herodias',
        'O próprio Herodes',
        'Um soldado',
        'Pilatos',
      ],
      correctIndex: 0,
      explanation:
          'A dançarina, instigada por sua mãe, exige a cabeça de João (Mateus 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Herodes', 'banquete', 'rainha'],
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Como Pedro respondeu quando Jesus perguntou: "Quem vocês dizem que eu sou?"?',
      options: <String>[
        'Tu és o Cristo, o Filho do Deus vivo',
        'Tu és Elias',
        'Tu és um profeta',
        'Não sei',
      ],
      correctIndex: 0,
      explanation: 'Pedro reconhece Jesus como o Cristo (Mateus 16).',
    ),
    QuizQuestion(
      text: 'O que aconteceu na transfiguração?',
      options: <String>[
        'O rosto de Jesus brilhou como o sol',
        'Jesus desapareceu',
        'Uma tempestade se levantou',
        'Jesus andou sobre a água',
      ],
      correctIndex: 0,
      explanation:
          'Jesus é transfigurado diante de Pedro, Tiago e João (Mateus 17).',
    ),
    QuizQuestion(
      text: 'Sobre qual animal Jesus entrou em Jerusalém?',
      options: <String>[
        'Um jumentinho',
        'Um cavalo branco',
        'Um camelo',
        'A pé',
      ],
      correctIndex: 0,
      explanation:
          'Jesus entra montado em um jumentinho, conforme a profecia (Mateus 21).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['jumentinho', 'jumento'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que Jesus instituiu durante sua última refeição com os apóstolos?',
      options: <String>[
        'A refeição em memória de sua morte',
        'Uma festa anual da colheita',
        'Um jejum coletivo',
        'Uma peregrinação',
      ],
      correctIndex: 0,
      explanation:
          'Jesus institui a refeição comemorativa com o pão e o vinho (Mateus 26).',
    ),
    QuizQuestion(
      text: 'Quem entregou Jesus por trinta moedas de prata?',
      options: <String>['Judas Iscariotes', 'Pedro', 'Tomé', 'Barrabás'],
      correctIndex: 0,
      explanation: 'Judas trai Jesus (Mateus 26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Judas'],
    ),
    QuizQuestion(
      text: 'O que aconteceu no terceiro dia após a morte de Jesus?',
      options: <String>[
        'Ele ressuscitou',
        'O templo foi destruído',
        'Ele subiu ao céu',
        'Nada de especial',
      ],
      correctIndex: 0,
      explanation: 'Jesus ressuscita no terceiro dia (Mateus 28).',
    ),
  ],
  'John#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Segundo João 1, quem era "a Palavra" (o Logos) junto de Deus no princípio?',
      options: <String>[
        'O Filho de Deus, antes de se tornar humano',
        'Um anjo',
        'Moisés',
        'O espírito santo',
      ],
      correctIndex: 0,
      explanation:
          'A Palavra estava junto de Deus e se torna carne em Jesus (João 1).',
    ),
    QuizQuestion(
      text: 'Qual foi o primeiro milagre de Jesus, em Caná?',
      options: <String>[
        'Transformar água em vinho',
        'Curar um cego',
        'Alimentar uma multidão',
        'Acalmar uma tempestade',
      ],
      correctIndex: 0,
      explanation: 'Jesus transforma água em vinho em um casamento (João 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Caná', 'festa', 'jarros'],
    ),
    QuizQuestion(
      text:
          'O que uma pessoa deve fazer, segundo Jesus, para "ver o Reino de Deus"?',
      options: <String>[
        'Nascer de novo',
        'Jejuar 40 dias',
        'Ir ao templo',
        'Tornar-se sacerdote',
      ],
      correctIndex: 0,
      explanation: 'Jesus explica isso a Nicodemos (João 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['batizar', 'espírito', 'Reino'],
    ),
  ],
  'John#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Como Jesus se descreve em João 10?',
      options: <String>['O bom pastor', 'O leão', 'O sumo sacerdote', 'O juiz'],
      correctIndex: 0,
      explanation:
          'Jesus se apresenta como o bom pastor que dá a vida por suas ovelhas (João 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['porta', 'videira', 'luz'],
    ),
    QuizQuestion(
      text:
          'Quem Jesus trouxe de volta à vida depois de quatro dias no túmulo?',
      options: <String>['Lázaro', 'Jairo', 'O filho da viúva', 'Um centurião'],
      correctIndex: 0,
      explanation: 'Jesus ressuscita Lázaro (João 11).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'O que Jesus fez por seus apóstolos antes da última refeição, como exemplo de humildade?',
      options: <String>[
        'Lavou os pés deles',
        'Abençoou cada um deles',
        'Compartilhou seus bens',
        'Orou por cada um deles publicamente',
      ],
      correctIndex: 0,
      explanation: 'Jesus lava os pés de seus discípulos (João 13).',
    ),
  ],
  'John#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'A que Jesus compara seu relacionamento com os discípulos em João 15?',
      options: <String>[
        'Uma videira e seus ramos',
        'Um pastor e seu rebanho',
        'Um rei e seus súditos',
        'Um pai e seus filhos',
      ],
      correctIndex: 0,
      explanation: 'Jesus é a videira, seus discípulos os ramos (João 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pastor', 'ovelhas', 'fruto'],
    ),
    QuizQuestion(
      text: 'Quem cortou a orelha de um homem durante a prisão de Jesus?',
      options: <String>['Pedro', 'João', 'Tiago', 'André'],
      correctIndex: 0,
      explanation: 'Pedro golpeia Malco com uma espada (João 18).',
    ),
    QuizQuestion(
      text:
          'Quem duvidou primeiro da ressurreição antes de tocar os ferimentos de Jesus?',
      options: <String>['Tomé', 'Pedro', 'João', 'Filipe'],
      correctIndex: 0,
      explanation: 'Tomé duvida e depois crê (João 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quem prepara o caminho diante de Jesus no início de Marcos?',
      options: <String>[
        'João Batista',
        'O próprio Elias',
        'Um anjo',
        'O sumo sacerdote',
      ],
      correctIndex: 0,
      explanation: 'João batiza e anuncia a vinda de Jesus (Marcos 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['João'],
    ),
    QuizQuestion(
      text:
          'Como Jesus mostrou sua autoridade ao curar o paralítico que desceu pelo teto?',
      options: <String>[
        'Perdoando seus pecados antes de curá-lo',
        'Exigindo um sacrifício prévio',
        'Mandando-o embora sem resposta',
        'Consultando os fariseus primeiro',
      ],
      correctIndex: 0,
      explanation: 'O perdão precede a cura física (Marcos 2).',
    ),
    QuizQuestion(
      text: 'O que conta a parábola do semeador em Marcos 4?',
      options: <String>[
        'Diferentes recepções dadas à palavra de Deus',
        'Uma simples lição de agricultura',
        'Um julgamento contra os agricultores',
        'Uma profecia sobre a fome',
      ],
      correctIndex: 0,
      explanation: 'Os tipos de solo ilustram os corações (Marcos 4).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: 'O que aconteceu quando os cinco mil foram alimentados?',
      options: <String>[
        'Cinco pães e dois peixes bastaram e ainda sobrou',
        'Cada um tinha trazido sua própria comida',
        'A multidão foi embora com fome',
        'Um mercado foi improvisado',
      ],
      correctIndex: 0,
      explanation: 'Um milagre de multiplicação (Marcos 6).',
    ),
    QuizQuestion(
      text: 'Que cena extraordinária ocorre no monte em Marcos 9?',
      options: <String>[
        'A transfiguração de Jesus',
        'Um terremoto',
        'Uma tempestade violenta',
        'Um julgamento público',
      ],
      correctIndex: 0,
      explanation: 'Jesus aparece glorioso com Moisés e Elias (Marcos 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Elias', 'Moisés', 'nuvem'],
    ),
    QuizQuestion(
      text: 'Como Jesus entra em Jerusalém em Marcos 11?',
      options: <String>[
        'Montado em um jumentinho, aclamado pela multidão',
        'Em segredo, sem ser visto',
        'Com um exército',
        'A cavalo como conquistador',
      ],
      correctIndex: 0,
      explanation: 'A entrada triunfal cumpre uma profecia (Marcos 11).',
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Qual grande mandamento Jesus cita em Marcos 12?',
      options: <String>[
        'Amar a Deus de todo o coração e ao próximo como a si mesmo',
        'Pagar rigorosamente o imposto',
        'Jejuar toda semana',
        'Evitar todo contato com estrangeiros',
      ],
      correctIndex: 0,
      explanation: 'Jesus resume a lei em dois mandamentos (Marcos 12).',
    ),
    QuizQuestion(
      text:
          'O que Jesus instituiu durante a última refeição com seus discípulos?',
      options: <String>[
        'A refeição comemorativa de sua morte',
        'Uma nova festa anual',
        'Um jejum coletivo',
        'Uma peregrinação obrigatória',
      ],
      correctIndex: 0,
      explanation: 'O pão e o vinho simbolizam seu sacrifício (Marcos 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Páscoa', 'pão', 'vinho'],
    ),
    QuizQuestion(
      text: 'O que as mulheres que foram ao túmulo descobrem no terceiro dia?',
      options: <String>[
        'O túmulo está vazio, Jesus ressuscitou',
        'O corpo de Jesus ainda está lá',
        'O túmulo está selado e inacessível',
        'Nada de incomum',
      ],
      correctIndex: 0,
      explanation: 'A ressurreição é anunciada por um anjo (Marcos 16).',
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quem anuncia a Maria que ela será a mãe de Jesus?',
      options: <String>[
        'O anjo Gabriel',
        'Um sacerdote',
        'João Batista',
        'Apenas um sonho',
      ],
      correctIndex: 0,
      explanation: 'Gabriel anuncia o nascimento milagroso (Lucas 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Miguel', 'Maria', 'José'],
    ),
    QuizQuestion(
      text:
          'Quem deu testemunho de Jesus menino durante sua apresentação no templo?',
      options: <String>[
        'Simeão e Ana',
        'Herodes',
        'Os principais sacerdotes',
        'Ninguém',
      ],
      correctIndex: 0,
      explanation: 'Dois fiéis idosos reconhecem o Messias (Lucas 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Maria', 'José', 'Zacarias'],
    ),
    QuizQuestion(
      text: 'Qual discurso famoso Jesus pronuncia em Lucas 6?',
      options: <String>[
        'O sermão na planície, com felicidades e infelicidades',
        'Um discurso sobre impostos',
        'Um anúncio de guerra',
        'Um julgamento contra Roma',
      ],
      correctIndex: 0,
      explanation: 'Um ensinamento moral importante (Lucas 6).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Qual parábola famosa ilustra o amor ao próximo em Lucas 10?',
      options: <String>[
        'O bom samaritano',
        'O filho pródigo',
        'O semeador',
        'As dez virgens',
      ],
      correctIndex: 0,
      explanation: 'Um exemplo de compaixão por um estranho (Lucas 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sacerdote', 'levita', 'ladrões'],
    ),
    QuizQuestion(
      text:
          'Quais três parábolas Jesus conta em Lucas 15 sobre o que estava perdido?',
      options: <String>[
        'A ovelha perdida, a moeda perdida, o filho pródigo',
        'O semeador, a rede, a pérola',
        'A figueira, a videira, o trigo',
        'Os talentos, as minas, o tesouro',
      ],
      correctIndex: 0,
      explanation: 'Três imagens da alegria de reencontrar (Lucas 15).',
    ),
    QuizQuestion(
      text: 'O que revela a parábola do rico e Lázaro em Lucas 16?',
      options: <String>[
        'Um contraste entre indiferença e compaixão',
        'Uma lição sobre agricultura',
        'Um conselho financeiro prático',
        'Uma profecia sobre Roma',
      ],
      correctIndex: 0,
      explanation: 'Uma parábola sobre as prioridades do coração (Lucas 16).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que Zaqueu faz para mostrar sua mudança de vida depois de encontrar Jesus?',
      options: <String>[
        'Devolve o quádruplo a quem prejudicou',
        'Deixa a cidade',
        'Ignora Jesus no final',
        'Recusa-se a compartilhar seus bens',
      ],
      correctIndex: 0,
      explanation: 'Sua generosidade ilustra sua conversão sincera (Lucas 19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['metade', 'riqueza', 'imposto'],
    ),
    QuizQuestion(
      text: 'O que o malfeitor arrependido pede a Jesus na estaca?',
      options: <String>[
        'Que se lembre dele em seu Reino',
        'Que o liberte imediatamente',
        'Que puna seus acusadores',
        'Que prove seu poder publicamente',
      ],
      correctIndex: 0,
      explanation: 'Jesus lhe promete o paraíso (Lucas 23).',
    ),
    QuizQuestion(
      text: 'O que acontece no caminho de Emaús após a ressurreição?',
      options: <String>[
        'Jesus ressuscitado explica as Escrituras a dois discípulos',
        'Os discípulos são presos',
        'Um anjo proíbe qualquer viagem',
        'Nada de especial acontece',
      ],
      correctIndex: 0,
      explanation: 'Eles o reconhecem ao partilhar o pão (Lucas 24).',
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que Jesus promete a seus discípulos pouco antes de sua ascensão?',
      options: <String>[
        'Eles receberão o poder do espírito santo',
        'Reinarão imediatamente sobre Roma',
        'Nunca mais o verão',
        'Terão de fugir logo em seguida',
      ],
      correctIndex: 0,
      explanation: 'Uma promessa essencial antes de Pentecostes (Atos 1).',
    ),
    QuizQuestion(
      text: 'O que aconteceu no dia de Pentecostes?',
      options: <String>[
        'O espírito santo foi derramado sobre os discípulos',
        'Um terremoto destruiu o templo',
        'Os apóstolos fugiram de Jerusalém',
        'Nada de incomum aconteceu',
      ],
      correctIndex: 0,
      explanation: 'A congregação cristã começa nesse dia (Atos 2).',
    ),
    QuizQuestion(
      text: 'Quem se tornou o primeiro mártir cristão?',
      options: <String>['Estêvão', 'Pedro', 'Tiago apenas', 'Filipe'],
      correctIndex: 0,
      explanation: 'Estêvão é apedrejado depois de seu discurso (Atos 7).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Como Saulo foi transformado no caminho de Damasco?',
      options: <String>[
        'Uma luz e uma voz de Jesus o converteram',
        'Ele simplesmente mudou de ideia sozinho',
        'Um rei o forçou a mudar',
        'Nada aconteceu nesse caminho',
      ],
      correctIndex: 0,
      explanation: 'Seu encontro com Jesus muda sua vida (Atos 9).',
    ),
    QuizQuestion(
      text: 'Que visão Pedro recebe antes de encontrar Cornélio?',
      options: <String>[
        'Um grande lençol com animais, significando abertura aos não judeus',
        'Uma batalha celestial',
        'Um templo em chamas',
        'Um sonho sem significado',
      ],
      correctIndex: 0,
      explanation:
          'Essa visão prepara Pedro para anunciar as boas novas às nações (Atos 10).',
    ),
    QuizQuestion(
      text:
          'Onde os discípulos foram chamados de "cristãos" pela primeira vez?',
      options: <String>['Em Antioquia', 'Em Jerusalém', 'Em Roma', 'Em Éfeso'],
      correctIndex: 0,
      explanation: 'Esse nome surge primeiro em Antioquia (Atos 11:26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Antioquia'],
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Que decisão importante o conselho de Jerusalém toma a respeito dos não judeus convertidos?',
      options: <String>[
        'Não são obrigados à circuncisão mosaica',
        'Devem seguir toda a lei de Moisés',
        'São excluídos da congregação',
        'Nenhuma decisão é tomada',
      ],
      correctIndex: 0,
      explanation:
          'Uma decisão-chave para a expansão do cristianismo (Atos 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['lei', 'sábado', 'sacrifícios'],
    ),
    QuizQuestion(
      text: 'O que aconteceu com Paulo e Silas presos em Filipos?',
      options: <String>[
        'Um terremoto abriu as portas da prisão',
        'Eles fugiram secretamente',
        'Ficaram presos para sempre',
        'Ninguém interveio',
      ],
      correctIndex: 0,
      explanation: 'Um milagre liberta os prisioneiros (Atos 16).',
    ),
    QuizQuestion(
      text:
          'Onde Paulo pronunciou seu famoso discurso sobre o "Deus desconhecido"?',
      options: <String>[
        'No Areópago, em Atenas',
        'Em Roma',
        'Em Jerusalém',
        'Em Corinto',
      ],
      correctIndex: 0,
      explanation: 'Paulo se dirige aos filósofos gregos (Atos 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Atenas', 'Areópago'],
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Paulo relata em sua defesa após sua prisão no templo?',
      options: <String>[
        'Sua conversão no caminho de Damasco',
        'Uma vitória militar',
        'Uma viagem comercial',
        'Uma disputa pessoal',
      ],
      correctIndex: 0,
      explanation: 'Paulo testemunha sobre sua experiência pessoal (Atos 22).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Jerusalém', 'templo', 'visão'],
    ),
    QuizQuestion(
      text: 'Por que Paulo apelou a César?',
      options: <String>[
        'Para obter um julgamento justo como cidadão romano',
        'Para evitar qualquer julgamento',
        'Para ser libertado imediatamente',
        'Porque queria deixar o ministério',
      ],
      correctIndex: 0,
      explanation:
          'Seu status de cidadão romano lhe dá esse direito (Atos 25).',
    ),
    QuizQuestion(
      text: 'O que aconteceu após o naufrágio na ilha de Malta?',
      options: <String>[
        'Paulo foi picado por uma víbora sem se ferir',
        'Foi preso pelos habitantes',
        'O navio partiu imediatamente',
        'Nada de especial aconteceu',
      ],
      correctIndex: 0,
      explanation: 'Um sinal miraculoso impressiona os habitantes (Atos 28).',
    ),
  ],
};

const Map<String, List<QuizQuestion>>
extraQuizzesPtC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Qual modelo de oração Jesus deu no Sermão do Monte?',
      options: <String>[
        'A oração "Pai Nosso"',
        'Uma longa lista de votos',
        'Uma oração secreta proibida',
        'Nenhuma oração específica',
      ],
      correctIndex: 0,
      explanation: 'Jesus ensina a orar de forma simples (Mateus 6).',
    ),
    QuizQuestion(
      text:
          'Com o que se parece aquele que põe em prática as palavras de Jesus, segundo Mateus 7?',
      options: <String>[
        'Um homem que constrói sua casa sobre a rocha',
        'Um homem que constrói sobre a areia',
        'Um viajante sem destino',
        'Um rei sem reino',
      ],
      correctIndex: 0,
      explanation: 'A casa sobre a rocha resiste às tempestades (Mateus 7:24).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Jesus fez durante uma tempestade no mar da Galileia?',
      options: <String>[
        'Acalmou-a com uma palavra',
        'Remou mais rápido',
        'Esperou passar',
        'Fugiu para a margem',
      ],
      correctIndex: 0,
      explanation: 'O vento e o mar lhe obedecem (Mateus 8).',
    ),
    QuizQuestion(
      text: 'Quantos apóstolos Jesus escolheu e enviou para pregar?',
      options: <String>['Doze', 'Sete', 'Setenta', 'Três'],
      correctIndex: 0,
      explanation: 'Os doze apóstolos são nomeados (Mateus 10).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['12'],
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Quantas vezes é preciso perdoar ao irmão, segundo Mateus 18?',
      options: <String>[
        'Até 77 vezes',
        'Apenas três vezes',
        'Uma única vez',
        'Nunca',
      ],
      correctIndex: 0,
      explanation: 'Jesus ensina um perdão sem limites (Mateus 18:22).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sete', 'sempre', 'muitas'],
    ),
    QuizQuestion(
      text: 'O que Jesus fez ao entrar no templo em Jerusalém?',
      options: <String>[
        'Expulsou os vendedores',
        'Ofereceu um sacrifício',
        'Escondeu-se',
        'Coroou um sacerdote',
      ],
      correctIndex: 0,
      explanation: 'Jesus purifica o templo (Mateus 21).',
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Que sinais Jesus anunciou para a conclusão do sistema em Mateus 24?',
      options: <String>[
        'Guerras, fomes e terremotos',
        'Uma paz mundial imediata',
        'O desaparecimento do sol para sempre',
        'Nenhum sinal',
      ],
      correctIndex: 0,
      explanation: 'Um sinal composto é descrito (Mateus 24).',
    ),
    QuizQuestion(
      text: 'Que missão Jesus confiou a seus discípulos após sua ressurreição?',
      options: <String>[
        'Fazer discípulos de pessoas de todas as nações',
        'Permanecer escondidos em Jerusalém',
        'Construir um templo',
        'Esperar sem fazer nada',
      ],
      correctIndex: 0,
      explanation: 'A ordem missionária encerra o evangelho (Mateus 28:19).',
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Quem Jesus chamou primeiro à beira do mar da Galileia?',
      options: <String>['Pescadores', 'Sacerdotes', 'Soldados', 'Escribas'],
      correctIndex: 0,
      explanation: 'Simão, André e outros o seguem (Marcos 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['os pescadores'],
    ),
    QuizQuestion(
      text: 'O que Jesus fez pelo homem possesso da região de Gerasa?',
      options: <String>[
        'Expulsou os demônios que o atormentavam',
        'Ignorou-o',
        'Mandou-o para casa sem fazer nada',
        'Repreendeu-o severamente',
      ],
      correctIndex: 0,
      explanation: 'O homem é libertado e recupera a razão (Marcos 5).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Com quantos pães Jesus alimentou cerca de 4.000 pessoas?',
      options: <String>['Sete', 'Cinco', 'Doze', 'Dois'],
      correctIndex: 0,
      explanation: 'Um segundo milagre de multiplicação (Marcos 8).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['7'],
    ),
    QuizQuestion(
      text:
          'O que é preciso se tornar, segundo Jesus, para entrar no Reino de Deus?',
      options: <String>[
        'Como uma criancinha',
        'Rico e poderoso',
        'Um líder reconhecido',
        'Um sábio',
      ],
      correctIndex: 0,
      explanation: 'Jesus recebe as crianças como exemplo (Marcos 10).',
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Qual pequena oferta Jesus elogiou no templo?',
      options: <String>[
        'As duas moedinhas da viúva',
        'Um saco de ouro',
        'Um cordeiro perfeito',
        'Uma peça de prata',
      ],
      correctIndex: 0,
      explanation: 'Ela deu tudo o que tinha (Marcos 12).',
    ),
    QuizQuestion(
      text: 'Quem foi forçado a carregar a estaca de tortura de Jesus?',
      options: <String>['Simão de Cirene', 'Pedro', 'João', 'Barrabás'],
      correctIndex: 0,
      explanation: 'Simão é requisitado no caminho (Marcos 15).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Simão'],
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Em qual cidade Jesus nasceu?',
      options: <String>['Belém', 'Nazaré', 'Jerusalém', 'Cafarnaum'],
      correctIndex: 0,
      explanation: 'O nascimento ocorre em Belém (Lucas 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'A quem os anjos anunciaram primeiro o nascimento de Jesus?',
      options: <String>['A pastores', 'A reis', 'Aos sacerdotes', 'A Herodes'],
      correctIndex: 0,
      explanation: 'Pastores recebem a boa notícia (Lucas 2).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quantos discípulos Jesus enviou para pregar dois a dois em Lucas 10?',
      options: <String>['Setenta', 'Doze', 'Cem', 'Três'],
      correctIndex: 0,
      explanation: 'Jesus amplia a pregação (Lucas 10).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['70'],
    ),
    QuizQuestion(
      text:
          'O que Jesus aconselha sobre a preocupação com comida e vestimenta?',
      options: <String>[
        'Não se preocupar, mas buscar primeiro o Reino',
        'Acumular o máximo possível',
        'Parar de trabalhar',
        'Preocupar-se constantemente',
      ],
      correctIndex: 0,
      explanation: 'Jesus ensina a confiança em Deus (Lucas 12).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quantos leprosos Jesus curou, dos quais apenas um voltou para agradecer?',
      options: <String>['Dez', 'Sete', 'Três', 'Doze'],
      correctIndex: 0,
      explanation: 'Apenas um samaritano volta para dar graças (Lucas 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['10'],
    ),
    QuizQuestion(
      text: 'Quem tramou e traiu Jesus por dinheiro?',
      options: <String>['Judas Iscariotes', 'Pedro', 'Tomé', 'Pilatos'],
      correctIndex: 0,
      explanation: 'Judas entrega Jesus (Lucas 22).',
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Aproximadamente quantas pessoas foram batizadas no dia de Pentecostes?',
      options: <String>[
        'Cerca de 3.000',
        'Cerca de 500',
        'Cerca de 12',
        'Cerca de 100',
      ],
      correctIndex: 0,
      explanation: 'Um grande número responde à mensagem (Atos 2).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['3000', 'três mil'],
    ),
    QuizQuestion(
      text: 'Quem guardava as roupas dos que apedrejavam Estêvão?',
      options: <String>[
        'Saulo (mais tarde Paulo)',
        'Pedro',
        'Barnabé',
        'Filipe',
      ],
      correctIndex: 0,
      explanation: 'Saulo aprovava esse assassinato (Atos 7-8).',
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quem o espírito enviou para anunciar as boas novas ao eunuco etíope?',
      options: <String>['Filipe', 'Pedro', 'Paulo', 'João'],
      correctIndex: 0,
      explanation: 'Filipe lhe explica as Escrituras (Atos 8).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Como Pedro foi libertado da prisão sob Herodes?',
      options: <String>[
        'Por um anjo',
        'Subornando um guarda',
        'Por um terremoto',
        'Ninguém o ajudou',
      ],
      correctIndex: 0,
      explanation: 'Um anjo o faz sair milagrosamente (Atos 12).',
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Que ofício Paulo exercia com Áquila e Priscila?',
      options: <String>[
        'Fabricante de tendas',
        'Pescador',
        'Carpinteiro',
        'Médico',
      ],
      correctIndex: 0,
      explanation: 'Paulo trabalhava com as próprias mãos (Atos 18).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pescador', 'tecelão', 'carpinteiro'],
    ),
    QuizQuestion(
      text:
          'Em qual cidade a pregação de Paulo provocou um tumulto dos ourives de Diana/Ártemis?',
      options: <String>['Éfeso', 'Atenas', 'Corinto', 'Roma'],
      correctIndex: 0,
      explanation: 'Os artesãos temiam por seu comércio (Atos 19).',
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Diante de quais governantes Paulo testemunhou em Cesareia?',
      options: <String>[
        'Félix, Festo e o rei Agripa',
        'Pilatos e Herodes',
        'Somente o Sinédrio',
        'O próprio César',
      ],
      correctIndex: 0,
      explanation: 'Paulo defende sua fé diante das autoridades (Atos 24-26).',
    ),
    QuizQuestion(
      text:
          'Onde Paulo finalmente chegou para aguardar seu julgamento diante de César?',
      options: <String>['Em Roma', 'Em Jerusalém', 'Em Antioquia', 'Em Éfeso'],
      correctIndex: 0,
      explanation: 'Paulo prega mesmo em prisão domiciliar (Atos 28).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Roma'],
    ),
  ],
};
