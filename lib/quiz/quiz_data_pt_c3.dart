import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesPtC3 = <String, List<QuizQuestion>>{
  'Esther#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Por que a rainha Vasti foi destituída?',
      options: <String>[
        'Ela se recusou a comparecer diante do rei e de seus convidados',
        'Ela conspirou contra o rei',
        'Ela ficou doente',
        'Ela abandonou o palácio',
      ],
      correctIndex: 0,
      explanation: 'Sua recusa resulta em sua desgraça (Ester 1).',
    ),
    QuizQuestion(
      text: 'Quem Mordecai criou e quem se tornou rainha?',
      options: <String>[
        'Ester, sua prima',
        'Sua filha',
        'Sua irmã',
        'Uma escrava estrangeira',
      ],
      correctIndex: 0,
      explanation: 'Ester é escolhida como a nova rainha (Ester 2).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Ester'],
    ),
    QuizQuestion(
      text: 'Por que Hamã queria exterminar todos os judeus do império?',
      options: <String>[
        'Mordecai se recusava a se curvar diante dele',
        'Os judeus tinham uma dívida com ele',
        'O rei havia lhe ordenado isso',
        'Uma guerra tinha acabado de estourar',
      ],
      correctIndex: 0,
      explanation:
          'A ira de Hamã se transforma em um complô genocida (Ester 3).',
    ),
  ],
  'Esther#1': <QuizQuestion>[
    QuizQuestion(
      text:
          'Qual frase célebre Mordecai dirige a Ester para convencê-la a agir?',
      options: <String>[
        '"Quem sabe se não foi para um tempo como este..."',
        '"Fuja enquanto há tempo"',
        '"Isso não é problema nosso"',
        '"O rei nunca vai te ouvir"',
      ],
      correctIndex: 0,
      explanation: 'Esse apelo leva Ester a intervir (Ester 4).',
    ),
    QuizQuestion(
      text: 'O que aconteceu quando o rei não conseguia dormir?',
      options: <String>[
        'Ele descobriu que Mordecai nunca havia sido recompensado',
        'Ele convocou Ester imediatamente',
        'Ele mandou executar Hamã na hora',
        'Ele anulou seu decreto',
      ],
      correctIndex: 0,
      explanation: 'Esse detalhe providencial vira o jogo (Ester 6).',
    ),
    QuizQuestion(
      text: 'Como Ester revelou o complô de Hamã?',
      options: <String>[
        'Em um segundo banquete, diante do rei',
        'Por meio de uma carta anônima',
        'Publicamente diante de todo o povo',
        'Por intermédio de um servo',
      ],
      correctIndex: 0,
      explanation: 'Hamã é desmascarado e executado (Ester 7).',
    ),
  ],
  'Esther#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Como o novo decreto contrariou o de Hamã?',
      options: <String>[
        'Ele autorizava os judeus a se defenderem',
        'Ele anulava totalmente o primeiro decreto',
        'Ele exilava todos os persas',
        'Ele não mudava nada',
      ],
      correctIndex: 0,
      explanation:
          'Um decreto irrevogável precisava ser contrariado por outro (Ester 8).',
    ),
    QuizQuestion(
      text: 'Que festa foi instituída para comemorar essa libertação?',
      options: <String>['Purim', 'A Páscoa', 'As Tendas', 'O Jubileu'],
      correctIndex: 0,
      explanation: 'Purim celebra até hoje esse acontecimento (Ester 9).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Que posição Mordecai finalmente ocupou?',
      options: <String>[
        'Uma posição elevada, a segunda depois do rei',
        'Ele foi exilado',
        'Ele continuou como um simples funcionário',
        'Ele deixou a Pérsia',
      ],
      correctIndex: 0,
      explanation: 'Mordecai trabalha pelo bem do seu povo (Ester 10).',
    ),
  ],
  'Job#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Que desafio Satanás lança a Deus a respeito de Jó?',
      options: <String>[
        'Jó só serviria a Deus por interesse pessoal',
        'Jó não existe de verdade',
        'Jó já é infiel',
        'Jó quer abandonar sua família',
      ],
      correctIndex: 0,
      explanation: 'Satanás põe em dúvida a motivação de Jó (Jó 1).',
    ),
    QuizQuestion(
      text: 'Como Jó reagiu depois de perder tudo?',
      options: <String>[
        'Ele não pecou nem acusou Deus de nada errado',
        'Ele amaldiçoou Deus',
        'Ele se vingou',
        'Ele abandonou sua fé',
      ],
      correctIndex: 0,
      explanation:
          'Sua integridade permanece intacta apesar da provação (Jó 1).',
    ),
    QuizQuestion(
      text: 'O que a esposa de Jó aconselha depois de sua doença?',
      options: <String>[
        'Que amaldiçoasse a Deus e morresse',
        'Que consultasse um médico',
        'Que fugisse para longe de casa',
        'Que esperasse em silêncio',
      ],
      correctIndex: 0,
      explanation: 'Jó recusa esse conselho desesperado (Jó 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['fé', 'paciência', 'amigos'],
    ),
  ],
  'Job#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Qual é o principal argumento de Bildade em seu primeiro discurso?',
      options: <String>[
        'A sabedoria dos antepassados prova que Deus é justo',
        'Deus não existe',
        'Jó é inocente',
        'O sofrimento não tem causa alguma',
      ],
      correctIndex: 0,
      explanation: 'Bildade se apoia na tradição (Jó 8).',
    ),
    QuizQuestion(
      text: 'O que Jó deseja profundamente em sua resposta a Bildade?',
      options: <String>[
        'Um mediador entre ele e Deus',
        'Dinheiro para pagar suas dívidas',
        'Vingança contra seus amigos',
        'Um novo rebanho imediatamente',
      ],
      correctIndex: 0,
      explanation: 'Jó anseia por defender sua causa com justiça (Jó 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['amigo', 'juiz', 'anjo'],
    ),
    QuizQuestion(
      text: 'O que Zofar aconselha Jó em seu primeiro discurso?',
      options: <String>[
        'Que se arrependesse de um pecado oculto',
        'Que deixasse sua família',
        'Que consultasse outro sábio',
        'Que ficasse calado para sempre',
      ],
      correctIndex: 0,
      explanation: 'Zofar supõe que Jó esconde uma falta (Jó 11).',
    ),
  ],
  'Job#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Que afirmação célebre Jó pronuncia apesar de seu sofrimento?',
      options: <String>[
        '"Eu sei que o meu Redentor vive"',
        '"Deus me abandonou para sempre"',
        '"A vida não tem sentido algum"',
        '"Prefiro morrer agora"',
      ],
      correctIndex: 0,
      explanation: 'Essa declaração de esperança marca Jó 19.',
    ),
    QuizQuestion(
      text: 'Que observação Jó faz sobre o destino dos maus?',
      options: <String>[
        'Eles parecem muitas vezes prosperar apesar de sua conduta',
        'Eles são sempre punidos imediatamente',
        'Eles não existem de verdade',
        'Eles sempre acabam pobres',
      ],
      correctIndex: 0,
      explanation: 'Jó questiona a teoria simplista de seus amigos (Jó 21).',
    ),
    QuizQuestion(
      text:
          'Como Jó descreve o tratamento recebido de seus amigos nesses capítulos?',
      options: <String>[
        'Ele se sente abandonado e incompreendido por eles',
        'Ele agradece calorosamente',
        'Ele aprova todos os argumentos deles',
        'Ele nem os menciona',
      ],
      correctIndex: 0,
      explanation:
          'Jó expressa sua angústia diante da falta de compaixão deles (Jó 16-17).',
    ),
  ],
  'Job#3': <QuizQuestion>[
    QuizQuestion(
      text: 'Do que exatamente Elifaz acusa Jó em seu terceiro discurso?',
      options: <String>[
        'De pecados específicos, como a opressão dos pobres',
        'De ter roubado um templo',
        'De ter renegado sua família',
        'De ter mentido ao rei',
      ],
      correctIndex: 0,
      explanation:
          'As acusações de Elifaz se tornam mais específicas, sem prova alguma (Jó 22).',
    ),
    QuizQuestion(
      text: 'O que Jó deseja ardentemente em sua resposta?',
      options: <String>[
        'Apresentar sua causa diretamente diante de Deus',
        'Fugir para longe de sua família',
        'Obter riqueza',
        'Vingar-se de seus amigos',
      ],
      correctIndex: 0,
      explanation: 'Jó busca uma audiência justa (Jó 23).',
    ),
    QuizQuestion(
      text: 'Que tema central Jó desenvolve no capítulo 28?',
      options: <String>[
        'O valor incomparável da sabedoria',
        'A riqueza mineral',
        'A geografia do deserto',
        'As leis do sacrifício',
      ],
      correctIndex: 0,
      explanation:
          'Esse poema celebra a sabedoria, mais preciosa que o ouro (Jó 28).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ouro', 'prata', 'riqueza'],
    ),
  ],
  'Job#4': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Jó relembra ao evocar seus dias passados?',
      options: <String>[
        'O respeito e a honra que recebia antigamente',
        'Sua pobreza de origem',
        'Uma vida de guerra constante',
        'Sua infância no estrangeiro',
      ],
      correctIndex: 0,
      explanation:
          'Jó contrasta seu passado honrado com sua situação atual (Jó 29).',
    ),
    QuizQuestion(
      text: 'O que Jó declara em seu juramento final de inocência?',
      options: <String>[
        'Ele afirma não ter cometido nenhuma das faltas enumeradas',
        'Ele confessa vários pecados',
        'Ele se recusa a responder',
        'Ele acusa Deus diretamente',
      ],
      correctIndex: 0,
      explanation: 'Jó encerra sua defesa com um extenso juramento (Jó 31).',
    ),
    QuizQuestion(
      text: 'Quem é Eliú, que toma a palavra depois dos três amigos?',
      options: <String>[
        'Um jovem que se considera portador de sabedoria',
        'Um anjo enviado por Deus',
        'Um quarto amigo, mais velho',
        'O filho de Jó',
      ],
      correctIndex: 0,
      explanation:
          'Eliú intervém porque os mais velhos não convenceram (Jó 32).',
    ),
  ],
  'Job#5': <QuizQuestion>[
    QuizQuestion(
      text: 'De onde Jeová finalmente fala a Jó?',
      options: <String>[
        'Do meio de uma tempestade',
        'De um sonho',
        'De um anjo visível',
        'Ele nunca respondeu',
      ],
      correctIndex: 0,
      explanation:
          'Deus finalmente responde, mas por meio de perguntas (Jó 38).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['nuvem', 'fogo', 'anjo'],
    ),
    QuizQuestion(
      text: 'Sobre o que tratam principalmente as perguntas de Jeová a Jó?',
      options: <String>[
        'A criação e o domínio sobre o mundo natural',
        'Os pecados ocultos de Jó',
        'A política das nações',
        'Os rituais do templo',
      ],
      correctIndex: 0,
      explanation:
          'Deus mostra a imensidão de sua sabedoria criadora (Jó 38-41).',
    ),
    QuizQuestion(
      text: 'Como a história de Jó se conclui?',
      options: <String>[
        'Jó se arrepende com humildade e Deus restaura o dobro de seus bens',
        'Jó morre na pobreza',
        'Jó amaldiçoa Deus até o fim',
        'Seus amigos são recompensados no lugar dele',
      ],
      correctIndex: 0,
      explanation: 'Jeová abençoa Jó mais do que antes (Jó 42).',
    ),
  ],
  'Psalms#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Com o que o Salmo 1 compara o homem feliz que medita na lei de Deus?',
      options: <String>[
        'Uma árvore plantada junto a correntes de água',
        'Uma pedra sólida',
        'Uma ave em voo',
        'Uma lâmpada acesa',
      ],
      correctIndex: 0,
      explanation: 'A imagem da árvore fértil abre o livro (Salmo 1).',
    ),
    QuizQuestion(
      text: 'O que o Salmo 19 celebra em sua primeira parte?',
      options: <String>[
        'A glória de Deus manifesta nos céus',
        'A vitória de um rei',
        'A construção do templo',
        'Uma batalha vencida',
      ],
      correctIndex: 0,
      explanation: '"Os céus proclamam a glória de Deus" (Salmo 19:1).',
    ),
    QuizQuestion(
      text: 'Que pergunta o Salmo 8 faz diante da imensidão da criação?',
      options: <String>[
        'O que é o homem para que você se lembre dele?',
        'Por que o mar é tão vasto?',
        'Onde fica o jardim do Éden?',
        'Quantas estrelas existem?',
      ],
      correctIndex: 0,
      explanation:
          'O salmista se maravilha com o lugar dado ao homem (Salmo 8:4).',
    ),
  ],
  'Psalms#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Como o Salmo 23 descreve Jeová?',
      options: <String>[
        'Como um pastor que cuida de suas ovelhas',
        'Como um juiz severo',
        'Como um rei distante',
        'Como um guerreiro vingativo',
      ],
      correctIndex: 0,
      explanation: '"Jeová é o meu pastor" (Salmo 23:1).',
    ),
    QuizQuestion(
      text:
          'Que palavra profética do Salmo 22 foi citada por Jesus na estaca de tortura?',
      options: <String>[
        '"Meu Deus, meu Deus, por que me abandonaste?"',
        '"Eu vim para julgar"',
        '"Eis o meu servo"',
        '"O reino se aproxima"',
      ],
      correctIndex: 0,
      explanation:
          'Essa citação liga esse salmo à paixão de Cristo (Salmo 22:1).',
    ),
    QuizQuestion(
      text: 'O que o Salmo 34 declara sobre a bondade de Jeová?',
      options: <String>[
        'Provem e vejam como Jeová é bom',
        'Sua bondade permanece oculta',
        'Ela diz respeito apenas aos sacerdotes',
        'Ela se limita a Israel',
      ],
      correctIndex: 0,
      explanation:
          'Um convite para experimentar a bondade divina (Salmo 34:8).',
    ),
  ],
  'Psalms#2': <QuizQuestion>[
    QuizQuestion(
      text:
          'Que oração comovente Davi compôs depois de seu pecado com Bate-Seba?',
      options: <String>[
        'O Salmo 51, pedindo um coração puro',
        'Um cântico de vitória militar',
        'Uma profecia sobre Babilônia',
        'Um cântico de coroação',
      ],
      correctIndex: 0,
      explanation: '"Cria em mim um coração puro, ó Deus" (Salmo 51:10).',
    ),
    QuizQuestion(
      text:
          'Com o que o salmista compara seu desejo ardente de Deus no Salmo 42?',
      options: <String>[
        'Uma corça que suspira por correntes de água',
        'Um leão faminto',
        'Um pássaro engaiolado',
        'Um mercador apressado',
      ],
      correctIndex: 0,
      explanation: 'Uma imagem de sede espiritual intensa (Salmo 42:1).',
    ),
    QuizQuestion(
      text: 'Que afirmação central o Salmo 46 faz?',
      options: <String>[
        'Deus é o nosso refúgio e a nossa força',
        'As nações viverão sempre em paz',
        'O templo nunca será destruído',
        'O rei é nossa única esperança',
      ],
      correctIndex: 0,
      explanation: '"Deus é para nós um refúgio e uma força" (Salmo 46:1).',
    ),
  ],
  'Psalms#3': <QuizQuestion>[
    QuizQuestion(
      text:
          'Para quem o Salmo 72 é uma oração de bênção sobre um reinado justo e próspero?',
      options: <String>[
        'Para o rei (Salomão e, profeticamente, o Messias)',
        'Somente para os sacerdotes',
        'Para as nações inimigas',
        'Para os profetas',
      ],
      correctIndex: 0,
      explanation:
          'Esse salmo messiânico descreve um reinado de paz duradoura (Salmo 72).',
    ),
    QuizQuestion(
      text: 'Que dilema perturba Asafe no Salmo 73?',
      options: <String>[
        'A prosperidade aparente dos maus',
        'A pobreza do templo',
        'A ausência de chuva',
        'O silêncio dos profetas',
      ],
      correctIndex: 0,
      explanation:
          'Asafe resolve essa perturbação ao entrar no santuário de Deus (Salmo 73:17).',
    ),
    QuizQuestion(
      text: 'Que imagem descreve a marcha poderosa de Deus no Salmo 68?',
      options: <String>[
        'Ele avança pelo deserto em favor de seu povo',
        'Ele permanece escondido para sempre',
        'Ele navega apenas pelos mares',
        'Ele combate sozinho, sem intervenção',
      ],
      correctIndex: 0,
      explanation: 'Uma linguagem poética de poder divino (Salmo 68).',
    ),
  ],
  'Psalms#4': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Moisés pede a Deus no Salmo 90 sobre a brevidade da vida?',
      options: <String>[
        'Que nos ensine a contar nossos dias com sabedoria',
        'Que prolongue indefinidamente a vida humana',
        'Que apague a lembrança da morte',
        'Que acelere o tempo',
      ],
      correctIndex: 0,
      explanation: '"Ensina-nos a contar bem os nossos dias" (Salmo 90:12).',
    ),
    QuizQuestion(
      text: 'Que promessa de proteção o Salmo 91 oferece?',
      options: <String>[
        'Quem habita no abrigo do Altíssimo está protegido',
        'Nenhuma promessa é feita',
        'Somente os reis são protegidos',
        'A proteção depende dos sacrifícios',
      ],
      correctIndex: 0,
      explanation: 'Uma imagem de refúgio sob as asas divinas (Salmo 91).',
    ),
    QuizQuestion(
      text: 'O que o Salmo 84 diz sobre a morada de Deus?',
      options: <String>[
        'Que ela é infinitamente desejável e amada',
        'Que ela é ameaçadora',
        'Que ela logo será destruída',
        'Que ela é reservada aos reis',
      ],
      correctIndex: 0,
      explanation: '"Quão amáveis são as tuas moradas!" (Salmo 84:1).',
    ),
  ],
  'Psalms#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Que convite abre o Salmo 100?',
      options: <String>[
        'Dai gritos de alegria e entrai com gratidão',
        'Guardai silêncio total',
        'Fugi para longe do templo',
        'Chorai por seus pecados',
      ],
      correctIndex: 0,
      explanation: 'Um chamado alegre ao louvor coletivo (Salmo 100).',
    ),
    QuizQuestion(
      text: 'O que o Salmo 103 relembra sobre o perdão de Deus?',
      options: <String>[
        'Ele perdoa todas as nossas faltas, como um pai tem compaixão',
        'Ele nunca perdoa',
        'O perdão depende do sacrifício diário',
        'Somente os sacerdotes são perdoados',
      ],
      correctIndex: 0,
      explanation: 'Uma imagem terna de compaixão paterna (Salmo 103:13).',
    ),
    QuizQuestion(
      text:
          'Que palavra do Salmo 110 é aplicada a Cristo nas Escrituras Gregas?',
      options: <String>[
        '"Senta-te à minha direita"',
        '"Serás rei da Babilônia"',
        '"Volta ao Egito"',
        '"Constrói o meu templo"',
      ],
      correctIndex: 0,
      explanation: 'O próprio Jesus cita esse versículo (Salmo 110:1).',
    ),
  ],
  'Psalms#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Qual é o tema principal do Salmo 119, o capítulo mais longo da Bíblia?',
      options: <String>[
        'O amor pela lei e pela palavra de Deus',
        'Uma batalha histórica',
        'A construção do templo',
        'Uma viagem ao Egito',
      ],
      correctIndex: 0,
      explanation: 'Cada seção medita sobre a lei divina (Salmo 119).',
    ),
    QuizQuestion(
      text: 'De onde o salmista diz que vem seu socorro no Salmo 121?',
      options: <String>[
        'De Jeová, criador dos céus e da terra',
        'Das próprias montanhas',
        'Do exército do rei',
        'Dos sacerdotes do templo',
      ],
      correctIndex: 0,
      explanation:
          '"Levanto os olhos para os montes... meu socorro vem de Jeová" (Salmo 121).',
    ),
    QuizQuestion(
      text: 'O que o Salmo 127 relembra sobre os projetos humanos?',
      options: <String>[
        'Sem Jeová, os construtores trabalham em vão',
        'O sucesso depende só do esforço',
        'Só a sorte decide',
        'Os filhos não são uma bênção',
      ],
      correctIndex: 0,
      explanation: '"Se Jeová não construir a casa..." (Salmo 127:1).',
    ),
  ],
  'Psalms#7': <QuizQuestion>[
    QuizQuestion(
      text: 'Que cena angustiante abre o Salmo 137?',
      options: <String>[
        'Os exilados chorando às margens dos rios da Babilônia',
        'Uma festa de coroação',
        'Uma batalha vitoriosa',
        'A construção do templo',
      ],
      correctIndex: 0,
      explanation:
          '"Às margens dos rios da Babilônia, nós chorávamos" (Salmo 137:1).',
    ),
    QuizQuestion(
      text: 'Como o Salmo 145 descreve Jeová?',
      options: <String>[
        'Grande e digno de louvor sem limites',
        'Distante e indiferente',
        'Somente severo',
        'Silencioso diante de seu povo',
      ],
      correctIndex: 0,
      explanation: 'Um salmo de louvor generoso (Salmo 145:3).',
    ),
    QuizQuestion(
      text: 'Que apelo encerra o último salmo, o Salmo 150?',
      options: <String>[
        'Que tudo o que tem fôlego louve a Jah',
        'Que tudo se cale para sempre',
        'Que somente os reis louvem a Deus',
        'Que a música seja proibida',
      ],
      correctIndex: 0,
      explanation:
          'O livro termina com um chamado universal ao louvor (Salmo 150:6).',
    ),
  ],
  'Proverbs#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Segundo Provérbios 1, qual é o começo do conhecimento?',
      options: <String>[
        'O temor de Jeová',
        'A riqueza',
        'A experiência apenas',
        'A educação formal',
      ],
      correctIndex: 0,
      explanation: 'Esse princípio fundamental abre o livro (Provérbios 1:7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sabedoria', 'tolo', 'riqueza'],
    ),
    QuizQuestion(
      text: 'O que Provérbios 3 aconselha sobre a confiança?',
      options: <String>[
        'Confiar em Jeová de todo o coração',
        'Contar apenas com a própria inteligência',
        'Evitar toda decisão importante',
        'Seguir a opinião da maioria',
      ],
      correctIndex: 0,
      explanation: '"Confia em Jeová de todo o teu coração" (Provérbios 3:5).',
    ),
    QuizQuestion(
      text: 'Como a sabedoria é personificada em Provérbios 8?',
      options: <String>[
        'Como uma voz que chama publicamente os homens',
        'Como um tesouro mencionado, mas invisível',
        'Como um rei silencioso',
        'Como um livro fechado',
      ],
      correctIndex: 0,
      explanation: 'A sabedoria clama nas praças públicas (Provérbios 8).',
    ),
  ],
  'Proverbs#1': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Provérbios 15 diz sobre como responder à ira?',
      options: <String>[
        'Uma resposta suave desvia o furor',
        'É preciso sempre responder com força',
        'O silêncio é sempre preferível',
        'A ira deve ser totalmente ignorada',
      ],
      correctIndex: 0,
      explanation: '"Uma resposta suave acalma o furor" (Provérbios 15:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ira', 'língua', 'tolo'],
    ),
    QuizQuestion(
      text: 'O que Provérbios 16 diz sobre nossos planos e Jeová?',
      options: <String>[
        'Entrega tuas obras a Jeová e teus planos darão certo',
        'Os planos humanos dependem só de nós',
        'Jeová ignora nossas decisões diárias',
        'Melhor não planejar nada',
      ],
      correctIndex: 0,
      explanation: '"Confia a Jeová as tuas obras" (Provérbios 16:3).',
    ),
    QuizQuestion(
      text:
          'O que representa a mulher sábia que constrói sua casa em Provérbios 14?',
      options: <String>[
        'A sabedoria prática que constrói e preserva',
        'Uma rainha estrangeira',
        'Uma simples operária',
        'Uma personagem menor, sem importância',
      ],
      correctIndex: 0,
      explanation:
          'A imagem ilustra o efeito construtivo da sabedoria (Provérbios 14:1).',
    ),
  ],
  'Proverbs#2': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Provérbios 18 diz sobre o poder da língua?',
      options: <String>[
        'A morte e a vida estão no poder da língua',
        'Ela não tem influência real',
        'Ela só diz respeito aos governantes',
        'Ela é sempre inofensiva',
      ],
      correctIndex: 0,
      explanation:
          'Uma imagem forte sobre o impacto das palavras (Provérbios 18:21).',
    ),
    QuizQuestion(
      text: 'O que Provérbios 19 diz sobre a bondade para com os pobres?',
      options: <String>[
        'É como emprestar ao próprio Jeová',
        'É uma perda de tempo',
        'Isso só diz respeito aos ricos',
        'Isso enfraquece a sociedade',
      ],
      correctIndex: 0,
      explanation:
          '"Quem tem compaixão do pobre empresta a Jeová" (Provérbios 19:17).',
    ),
    QuizQuestion(
      text: 'Segundo Provérbios 22, o que vale mais do que grande riqueza?',
      options: <String>[
        'Um bom nome',
        'Um grande palácio',
        'Um exército poderoso',
        'Um vasto território',
      ],
      correctIndex: 0,
      explanation:
          '"Um bom nome vale mais do que grandes riquezas" (Provérbios 22:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['riqueza', 'ouro', 'prata'],
    ),
  ],
  'Proverbs#3': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Provérbios 27 diz sobre o efeito de um amigo sobre outro?',
      options: <String>[
        'O ferro afia o ferro, um homem estimula outro',
        'Os amigos não têm influência alguma',
        'É melhor ficar sozinho',
        'Os amigos enfraquecem o caráter',
      ],
      correctIndex: 0,
      explanation:
          'Uma imagem de influência mútua positiva (Provérbios 27:17).',
    ),
    QuizQuestion(
      text: 'O que Provérbios 29 diz sobre a falta de direção espiritual?',
      options: <String>[
        'Sem visão, o povo fica sem freios',
        'O povo sempre prospera sozinho',
        'As visões não têm importância',
        'O povo prefere a ausência de regras',
      ],
      correctIndex: 0,
      explanation:
          'Uma advertência sobre a falta de orientação (Provérbios 29:18).',
    ),
    QuizQuestion(
      text: 'O que o poema final de Provérbios 31 celebra?',
      options: <String>[
        'A mulher capaz e virtuosa',
        'A riqueza de um rei',
        'Uma vitória militar',
        'A construção de um palácio',
      ],
      correctIndex: 0,
      explanation: 'Um acróstico louva a mulher valorosa (Provérbios 31).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['rei', 'sábio', 'marido'],
    ),
  ],
  'Ecclesiastes#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Que constatação recorrente abre o livro de Eclesiastes?',
      options: <String>[
        'Tudo é vaidade (vapor, futilidade) debaixo do sol',
        'Tudo é perfeitamente estável',
        'A riqueza resolve tudo',
        'Nada muda nunca',
      ],
      correctIndex: 0,
      explanation: 'Esse tema estrutura todo o livro (Eclesiastes 1:2).',
    ),
    QuizQuestion(
      text:
          'O que Salomão descobriu depois de buscar prazer, trabalhos e sabedoria?',
      options: <String>[
        'Tudo isso, sem Deus, continua sendo vão',
        'O prazer sozinho basta para a felicidade',
        'O trabalho garante sempre a satisfação',
        'A sabedoria humana resolve tudo',
      ],
      correctIndex: 0,
      explanation:
          'Sua experiência pessoal ilustra a futilidade sem Deus (Eclesiastes 2).',
    ),
    QuizQuestion(
      text: 'O que o famoso trecho sobre "um tempo para tudo" nos lembra?',
      options: <String>[
        'Há uma estação apropriada para cada coisa',
        'O tempo não tem importância alguma',
        'Tudo deve ser feito imediatamente',
        'O passado não conta',
      ],
      correctIndex: 0,
      explanation: 'Esse poema ritmado abre Eclesiastes 3.',
    ),
  ],
  'Ecclesiastes#1': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Eclesiastes 5 aconselha sobre votos feitos a Deus?',
      options: <String>[
        'É melhor não fazer voto algum do que deixar de cumpri-lo',
        'É preciso multiplicar os votos',
        'Os votos não têm valor algum',
        'Só os sacerdotes podem fazer votos',
      ],
      correctIndex: 0,
      explanation:
          'A prudência ao falar com Deus é destacada (Eclesiastes 5:4, 5).',
    ),
    QuizQuestion(
      text: 'O que Eclesiastes 7 diz sobre a reputação?',
      options: <String>[
        'Um bom nome vale mais do que o óleo perfumado',
        'A reputação não tem valor algum',
        'Só a riqueza conta',
        'O nome nunca sobrevive',
      ],
      correctIndex: 0,
      explanation:
          'Um julgamento de valor sobre a integridade (Eclesiastes 7:1).',
    ),
    QuizQuestion(
      text:
          'O que Eclesiastes 8 recomenda em relação à autoridade estabelecida?',
      options: <String>[
        'Obedecer com sabedoria, sem pressa em contestar',
        'Sempre desafiar os governantes',
        'Ignorar completamente a lei',
        'Fugir de toda responsabilidade civil',
      ],
      correctIndex: 0,
      explanation: 'Uma prudência prática é aconselhada (Eclesiastes 8).',
    ),
  ],
  'Ecclesiastes#2': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Eclesiastes 9 relembra sobre nossas atividades diárias?',
      options: <String>[
        'Faça seu trabalho com todas as suas forças, enquanto vive',
        'O trabalho não tem valor',
        'É melhor ficar inativo',
        'Só os ricos devem trabalhar',
      ],
      correctIndex: 0,
      explanation:
          'Um chamado ao pleno engajamento na vida (Eclesiastes 9:10).',
    ),
    QuizQuestion(
      text: 'O que Eclesiastes 11 aconselha a respeito da generosidade?',
      options: <String>[
        'Lance o seu pão sobre as águas, ele voltará',
        'Guarde todos os seus recursos só para si mesmo',
        'A generosidade é sempre inútil',
        'É preciso esperar a certeza antes de agir',
      ],
      correctIndex: 0,
      explanation:
          'Uma imagem de investimento generoso e confiante (Eclesiastes 11:1).',
    ),
    QuizQuestion(
      text: 'Qual é a conclusão final do livro de Eclesiastes?',
      options: <String>[
        'Teme a Deus e guarda os seus mandamentos',
        'Busque apenas o prazer',
        'Nada realmente faz sentido',
        'A riqueza é o objetivo final',
      ],
      correctIndex: 0,
      explanation: 'Essa conclusão resume todo o livro (Eclesiastes 12:13).',
    ),
  ],
  'Song of Solomon#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Que sentimento domina a abertura do Cântico dos Cânticos?',
      options: <String>[
        'Um amor ardente entre a sulamita e seu amado',
        'Um conflito familiar',
        'Uma negociação comercial',
        'Um julgamento real',
      ],
      correctIndex: 0,
      explanation: 'O livro celebra o amor conjugal sincero (Cântico 1).',
    ),
    QuizQuestion(
      text: 'O que a sulamita faz em seu sonho no capítulo 3?',
      options: <String>[
        'Ela procura seu amado pela cidade',
        'Ela foge para um país distante',
        'Ela se casa com outro homem',
        'Ela esquece completamente seu amor',
      ],
      correctIndex: 0,
      explanation: 'Seu apego permanece fiel mesmo no sonho (Cântico 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sonho', 'guardas', 'jardim'],
    ),
    QuizQuestion(
      text: 'Como a sulamita expressa seu apego exclusivo?',
      options: <String>[
        '"Eu sou do meu amado, e o meu amado é meu"',
        '"Prefiro a riqueza ao amor"',
        '"O amor não tem importância para mim"',
        '"Ficarei sozinha para sempre"',
      ],
      correctIndex: 0,
      explanation: 'Essa fórmula retorna como um refrão (Cântico 2:16).',
    ),
  ],
  'Song of Solomon#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Como o amado descreve a beleza da sulamita no capítulo 4?',
      options: <String>[
        'Por meio de uma série de imagens poéticas elogiosas',
        'De forma fria e distante',
        'Comparando-a a uma inimiga',
        'Ele não a descreve de forma alguma',
      ],
      correctIndex: 0,
      explanation: 'Um poema de elogio detalhado é dedicado a ela (Cântico 4).',
    ),
    QuizQuestion(
      text:
          'O que acontece quando o amado vem bater à sua porta no capítulo 5?',
      options: <String>[
        'Ela demora a abrir e ele já foi embora',
        'Ela abre imediatamente com alegria',
        'Ela se recusa a vê-lo',
        'Ele nunca chegou a vir',
      ],
      correctIndex: 0,
      explanation:
          'Esse momento perdido cria um arrependimento pungente (Cântico 5).',
    ),
    QuizQuestion(
      text: 'Para quem a sulamita descreve seu amado depois desse episódio?',
      options: <String>[
        'Para as filhas de Jerusalém',
        'Somente para sua mãe',
        'Para o rei Salomão',
        'Para ninguém, ela guarda silêncio',
      ],
      correctIndex: 0,
      explanation: 'Sua descrição entusiasmada vem em seguida (Cântico 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['amado', 'sulamita', 'rei'],
    ),
  ],
  'Song of Solomon#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Que afirmação célebre sobre o amor se encontra no capítulo 8?',
      options: <String>[
        'O amor é forte como a morte',
        'O amor se compra com dinheiro',
        'O amor não tem importância alguma',
        'O amor nunca dura',
      ],
      correctIndex: 0,
      explanation:
          '"Muitas águas não conseguem apagar o amor" (Cântico 8:6, 7).',
    ),
    QuizQuestion(
      text: 'O que simbolizam as "muitas águas" incapazes de apagar o amor?',
      options: <String>[
        'As provações que não conseguem destruir um amor verdadeiro',
        'Uma inundação literal',
        'A riqueza do reino',
        'O poder do rei',
      ],
      correctIndex: 0,
      explanation:
          'Uma metáfora poderosa sobre a resiliência do amor (Cântico 8).',
    ),
    QuizQuestion(
      text: 'Que tom domina o final do Cântico dos Cânticos?',
      options: <String>[
        'A celebração de um amor fiel e compartilhado',
        'Uma ruptura definitiva',
        'Um julgamento severo',
        'Um aviso de guerra',
      ],
      correctIndex: 0,
      explanation:
          'O livro se conclui em uma nota de amor realizado (Cântico 8).',
    ),
  ],
  'Isaiah#0': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Isaías 2 promete para o futuro em relação à guerra?',
      options: <String>[
        'As nações transformarão suas espadas em relhas de arado',
        'As guerras se tornarão mais frequentes',
        'Um único império dominará para sempre',
        'Nenhuma mudança é prevista',
      ],
      correctIndex: 0,
      explanation: 'Uma visão de paz universal (Isaías 2:4).',
    ),
    QuizQuestion(
      text: 'O que Isaías vê em sua visão de comissão profética?',
      options: <String>[
        'Jeová em um trono elevado, cercado de serafins',
        'Uma batalha celestial',
        'Um deserto silencioso',
        'Apenas uma cidade em ruínas',
      ],
      correctIndex: 0,
      explanation:
          'Um carvão toca seus lábios, purificando sua boca (Isaías 6).',
    ),
    QuizQuestion(
      text: 'Que sinal Isaías anuncia ao rei Acaz no capítulo 7?',
      options: <String>[
        'Uma jovem conceberá um filho, Emanuel',
        'Uma vitória militar imediata',
        'A destruição total de Judá',
        'Uma fome prolongada',
      ],
      correctIndex: 0,
      explanation: '"Emanuel" significa "Deus conosco" (Isaías 7:14).',
    ),
  ],
  'Isaiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Que profecia messiânica célebre se encontra em Isaías 9?',
      options: <String>[
        'Uma criança nasceu, o governo sobre seu ombro',
        'Um rei estrangeiro dominará para sempre',
        'O templo será reconstruído imediatamente',
        'A paz nunca virá',
      ],
      correctIndex: 0,
      explanation: 'Essa passagem anuncia um reinado de paz (Isaías 9:6, 7).',
    ),
    QuizQuestion(
      text: 'Que imagem pacífica ilustra Isaías 11 sobre o reinado futuro?',
      options: <String>[
        'O lobo morará com o cordeiro',
        'Os leões dominarão os homens',
        'Os desertos continuarão estéreis',
        'As nações continuarão divididas',
      ],
      correctIndex: 0,
      explanation: 'Uma harmonia total é prometida (Isaías 11:6).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['leão', 'ovelha', 'pastor'],
    ),
    QuizQuestion(
      text: 'Como Isaías 14 descreve a queda orgulhosa do rei da Babilônia?',
      options: <String>[
        'Como uma estrela brilhante caída do céu',
        'Como um rei eternamente triunfante',
        'Como um aliado fiel de Israel',
        'Como um simples mercador',
      ],
      correctIndex: 0,
      explanation: 'Uma imagem impressionante de decadência (Isaías 14:12).',
    ),
  ],
  'Isaiah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Que gesto simbólico Isaías realiza contra o Egito e Cuxe?',
      options: <String>[
        'Andar descalço e sem a veste de cima',
        'Queimar suas roupas',
        'Jejuar durante um ano',
        'Construir um altar',
      ],
      correctIndex: 0,
      explanation:
          'Esse sinal ilustra a vergonha do cativeiro que viria (Isaías 20).',
    ),
    QuizQuestion(
      text: 'Que julgamento universal Isaías 24 anuncia?',
      options: <String>[
        'A terra inteira será abalada e devastada',
        'Somente uma nação será julgada',
        'Nenhum julgamento acontecerá',
        'O julgamento dirá respeito apenas aos reis',
      ],
      correctIndex: 0,
      explanation: 'Um alcance mundial é descrito (Isaías 24).',
    ),
    QuizQuestion(
      text: 'O que Isaías 25 promete em relação à morte?',
      options: <String>[
        'Jeová engolirá a morte para sempre',
        'A morte continuará invencível',
        'Só os ricos escaparão dela',
        'Nada é dito sobre a morte',
      ],
      correctIndex: 0,
      explanation: 'Uma esperança extraordinária é expressa (Isaías 25:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['vida', 'túmulo', 'lágrimas'],
    ),
  ],
  'Isaiah#3': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Isaías 26 promete a quem apoia seu espírito em Deus?',
      options: <String>[
        'Uma paz perfeita',
        'Uma riqueza imediata',
        'Um exército invencível',
        'Uma longevidade garantida',
      ],
      correctIndex: 0,
      explanation: '"Tu guardarás em perfeita paz" (Isaías 26:3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['guerra', 'justiça', 'alegria'],
    ),
    QuizQuestion(
      text: 'Que pedra preciosa Jeová põe em Sião segundo Isaías 28?',
      options: <String>[
        'Uma pedra angular, um fundamento testado',
        'Um simples seixo',
        'Uma pedra amaldiçoada',
        'Nenhuma pedra é mencionada',
      ],
      correctIndex: 0,
      explanation: 'Uma imagem messiânica de fundamento seguro (Isaías 28:16).',
    ),
    QuizQuestion(
      text:
          'Contra o que Isaías adverte o povo em relação a uma aliança militar?',
      options: <String>[
        'Contra confiar no Egito em vez de em Jeová',
        'Contra uma aliança apenas com a Babilônia',
        'Contra todo comércio exterior',
        'Contra os sacerdotes locais',
      ],
      correctIndex: 0,
      explanation: 'Buscar socorro no Egito é criticado (Isaías 30-31).',
    ),
  ],
  'Isaiah#4': <QuizQuestion>[
    QuizQuestion(
      text: 'No que o deserto se transformará segundo a promessa de Isaías 35?',
      options: <String>[
        'Ele florescerá como uma rosa',
        'Ele continuará estéril para sempre',
        'Ele se tornará um mar',
        'Ele será abandonado definitivamente',
      ],
      correctIndex: 0,
      explanation: 'Uma transformação alegre é prometida (Isaías 35:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['deserto', 'água', 'espinhos'],
    ),
    QuizQuestion(
      text: 'Como Jeová respondeu à oração de Ezequias diante de Senaqueribe?',
      options: <String>[
        'Um anjo atacou o exército assírio em uma única noite',
        'Ezequias teve que se render',
        'Uma fome enfraqueceu Judá',
        'Nenhuma resposta veio',
      ],
      correctIndex: 0,
      explanation:
          'Um livramento espetacular acontece depois da oração (Isaías 37).',
    ),
    QuizQuestion(
      text: 'O que Isaías 40 relembra sobre a natureza humana diante de Deus?',
      options: <String>[
        'Toda carne é como a relva que murcha',
        'O homem é eterno por natureza',
        'Deus depende do homem',
        'A palavra de Deus muda com frequência',
      ],
      correctIndex: 0,
      explanation:
          '"A palavra do nosso Deus subsiste para sempre" (Isaías 40:8).',
    ),
  ],
  'Isaiah#5': <QuizQuestion>[
    QuizQuestion(
      text: 'Como Isaías 42 descreve a delicadeza do servo de Jeová?',
      options: <String>[
        'Ele não quebrará a cana já rachada',
        'Ele destruirá tudo pelo caminho',
        'Ele ignorará os fracos',
        'Ele agirá com violência sistemática',
      ],
      correctIndex: 0,
      explanation:
          'Uma delicadeza notável caracteriza esse servo (Isaías 42:3).',
    ),
    QuizQuestion(
      text:
          'Que rei estrangeiro é nomeado com antecedência por Isaías como libertador de Israel?',
      options: <String>['Ciro', 'Nabucodonosor', 'Dario', 'Xerxes'],
      correctIndex: 0,
      explanation: 'Uma profecia notável nomeia Ciro (Isaías 44-45).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'O que Isaías 48 diz sobre a atitude passada do povo em relação aos mandamentos de Deus?',
      options: <String>[
        'Se ao menos tivessem prestado atenção antes',
        'Eles sempre obedeceram perfeitamente',
        'Os mandamentos não tinham importância',
        'Deus nunca havia pedido nada',
      ],
      correctIndex: 0,
      explanation:
          'Um pesar expresso sobre a falta de atenção deles (Isaías 48:18).',
    ),
  ],
  'Isaiah#6': <QuizQuestion>[
    QuizQuestion(
      text: 'Como Isaías 53 descreve o sofrimento do servo de Jeová?',
      options: <String>[
        'Ele foi trespassado por causa das nossas transgressões',
        'Ele viveu sem jamais sofrer',
        'Ele reinou imediatamente sem provação',
        'Ele foi honrado desde o nascimento',
      ],
      correctIndex: 0,
      explanation:
          'Um capítulo central sobre o sofrimento redentor (Isaías 53:5).',
    ),
    QuizQuestion(
      text: 'Que convite gratuito é lançado em Isaías 55?',
      options: <String>[
        'Vinde comprar vinho e leite sem dinheiro',
        'Paguem caro para obter sabedoria',
        'Só os ricos podem vir',
        'Nenhum convite é feito',
      ],
      correctIndex: 0,
      explanation: 'Uma oferta generosa e universal (Isaías 55:1).',
    ),
    QuizQuestion(
      text:
          'O que Isaías 58 define como um "jejum" verdadeiro aos olhos de Deus?',
      options: <String>[
        'Repartir seu pão com o faminto e libertar os oprimidos',
        'Abster-se apenas de alimento',
        'Usar roupas especiais',
        'Ficar em silêncio o dia todo',
      ],
      correctIndex: 0,
      explanation:
          'O jejum autêntico se traduz em atos de justiça (Isaías 58:6, 7).',
    ),
  ],
  'Isaiah#7': <QuizQuestion>[
    QuizQuestion(
      text: 'Que imagem de esperança abre Isaías 60 para Sião?',
      options: <String>[
        'Levanta-te, resplandece, a tua luz chegou',
        'Fica na escuridão para sempre',
        'Foge para longe de tua cidade',
        'Espera sem esperança alguma',
      ],
      correctIndex: 0,
      explanation: 'Um chamado luminoso à restauração (Isaías 60:1).',
    ),
    QuizQuestion(
      text: 'Que declaração de Isaías 61 Jesus leu na sinagoga de Nazaré?',
      options: <String>[
        '"O espírito do Soberano Senhor está sobre mim"',
        '"Eu virei julgar o mundo inteiro"',
        '"O templo será destruído"',
        '"Ninguém será salvo"',
      ],
      correctIndex: 0,
      explanation:
          'Jesus aplica essa passagem a si mesmo (Lucas 4, citando Isaías 61:1).',
    ),
    QuizQuestion(
      text: 'O que Isaías 65 promete sobre o futuro da criação?',
      options: <String>[
        'Novos céus e uma nova terra',
        'A destruição final sem restauração',
        'Um reino limitado a uma só nação',
        'O fim de toda vida animal',
      ],
      correctIndex: 0,
      explanation: 'Uma promessa de esperança conclui o livro (Isaías 65:17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sião', 'luz', 'glória'],
    ),
  ],
  'Jeremiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'O que Jeová diz a Jeremias sobre seu chamado antes mesmo de seu nascimento?',
      options: <String>[
        '"Antes que eu te formasse no ventre, eu já te conhecia"',
        'Ele o escolheu somente na idade adulta',
        'Jeremias se propôs por conta própria',
        'Nenhum chamado especial é mencionado',
      ],
      correctIndex: 0,
      explanation:
          'Uma vocação profética estabelecida desde antes do seu nascimento (Jeremias 1:5).',
    ),
    QuizQuestion(
      text: 'A que Jeová compara a infidelidade de Israel no capítulo 2?',
      options: <String>[
        'A uma esposa que esqueceu seu marido',
        'A um rei fiel',
        'A um servo exemplar',
        'A uma nação sempre leal',
      ],
      correctIndex: 0,
      explanation: 'Uma imagem de abandono relacional (Jeremias 2).',
    ),
    QuizQuestion(
      text: 'Que falsa confiança Jeremias denuncia no capítulo 7?',
      options: <String>[
        'Repetir "este é o templo de Jeová" como uma fórmula mágica',
        'A confiança excessiva no próprio Jeremias',
        'A confiança somente no exército',
        'A confiança em profetas estrangeiros',
      ],
      correctIndex: 0,
      explanation:
          'O povo acredita erroneamente que o templo os protege automaticamente (Jeremias 7).',
    ),
  ],
  'Jeremiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Que pergunta célebre Jeremias faz no capítulo 12?',
      options: <String>[
        'Por que o caminho dos maus prospera?',
        'Por que a Babilônia é tão fraca?',
        'Por que o templo está vazio?',
        'Por que os sacerdotes estão ausentes?',
      ],
      correctIndex: 0,
      explanation: 'Jeremias expressa uma queixa sincera (Jeremias 12:1).',
    ),
    QuizQuestion(
      text: 'O que simboliza o cinto de linho estragado em Jeremias 13?',
      options: <String>[
        'A corrupção do orgulho de Judá',
        'A riqueza recuperada do povo',
        'Uma aliança sólida com o Egito',
        'A pureza do sacerdócio',
      ],
      correctIndex: 0,
      explanation: 'Um sinal visual de decadência moral (Jeremias 13).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['cinto', 'linho', 'rio'],
    ),
    QuizQuestion(
      text: 'O que Jeremias 17 revela sobre o coração humano?',
      options: <String>[
        'Ele é mais enganoso do que qualquer outra coisa',
        'Ele é naturalmente bom',
        'Ele nunca muda',
        'Ele não tem importância para Deus',
      ],
      correctIndex: 0,
      explanation: 'Uma avaliação franca da natureza humana (Jeremias 17:9).',
    ),
  ],
  'Jeremiah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Que ilustração Jeová dá a Jeremias na casa do oleiro?',
      options: <String>[
        'Como o barro na mão do oleiro, Israel está na mão de Deus',
        'O oleiro simboliza um rei estrangeiro',
        'O barro representa a riqueza',
        'Nenhuma lição espiritual é tirada disso',
      ],
      correctIndex: 0,
      explanation: 'Uma imagem de soberania divina (Jeremias 18).',
    ),
    QuizQuestion(
      text: 'Como Jeremias foi tratado depois de profetizar contra Jerusalém?',
      options: <String>[
        'Ele foi espancado e preso no tronco por Pasur',
        'Ele foi honrado publicamente',
        'Ele foi nomeado sumo sacerdote',
        'Ele foi enviado em uma embaixada',
      ],
      correctIndex: 0,
      explanation: 'Jeremias sofre por sua mensagem fiel (Jeremias 20).',
    ),
    QuizQuestion(
      text: 'Que escolha Jeremias propõe ao povo sitiado no capítulo 21?',
      options: <String>[
        'Render-se à Babilônia (vida) ou resistir (morte)',
        'Fugir imediatamente para o Egito',
        'Atacar a Babilônia primeiro',
        'Negociar com a Assíria',
      ],
      correctIndex: 0,
      explanation:
          'Uma escolha difícil, mas clara, é apresentada (Jeremias 21).',
    ),
  ],
  'Jeremiah#3': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Jeremias 23 promete sobre um futuro rei justo?',
      options: <String>[
        'Um "renovo justo" reinará com sabedoria',
        'Nenhum rei justo virá jamais',
        'Os falsos pastores reinarão para sempre',
        'O reino desaparecerá sem sucessor',
      ],
      correctIndex: 0,
      explanation:
          'Uma promessa messiânica contrasta com os maus pastores (Jeremias 23:5).',
    ),
    QuizQuestion(
      text: 'Quantos anos de cativeiro na Babilônia Jeremias anuncia?',
      options: <String>['70 anos', '7 anos', '40 anos', '400 anos'],
      correctIndex: 0,
      explanation: 'Essa duração precisa é profetizada (Jeremias 25:11).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['setenta anos', '70'],
    ),
    QuizQuestion(
      text: 'O que Jeremias aconselha os exilados na Babilônia em sua carta?',
      options: <String>[
        'Construir casas e buscar a paz da cidade',
        'Rebelar-se imediatamente',
        'Recusar todo trabalho',
        'Ignorar as autoridades locais',
      ],
      correctIndex: 0,
      explanation: 'Um conselho realista para viver no exílio (Jeremias 29).',
    ),
  ],
  'Jeremiah#4': <QuizQuestion>[
    QuizQuestion(
      text: 'O que Jeová promete na célebre profecia da nova aliança?',
      options: <String>[
        'Sua lei será escrita no coração do povo',
        'Um novo templo será construído imediatamente',
        'Nenhuma aliança futura está prevista',
        'O sacerdócio será abolido sem substituto',
      ],
      correctIndex: 0,
      explanation:
          'Uma aliança interior e pessoal é anunciada (Jeremias 31:33).',
    ),
    QuizQuestion(
      text:
          'Que gesto simbólico Jeremias realiza em plena crise, comprando um campo?',
      options: <String>[
        'Ele expressa sua fé em uma restauração futura',
        'Ele busca se enriquecer pessoalmente',
        'Ele foge da cidade sitiada',
        'Ele negocia com a Babilônia',
      ],
      correctIndex: 0,
      explanation:
          'Essa compra testemunha esperança apesar do cerco (Jeremias 32).',
    ),
    QuizQuestion(
      text: 'Que exemplo de fidelidade os recabitas oferecem a Judá?',
      options: <String>[
        'Sua obediência rigorosa ao mandamento de seu ancestral',
        'Sua riqueza abundante',
        'Seu poder militar',
        'Sua aliança com o Egito',
      ],
      correctIndex: 0,
      explanation:
          'A fidelidade deles contrasta com a infidelidade de Judá (Jeremias 35).',
    ),
  ],
  'Jeremiah#5': <QuizQuestion>[
    QuizQuestion(
      text:
          'Quem salvou Jeremias, que havia sido jogado em uma cisterna lamacenta?',
      options: <String>['Ebede-Meleque', 'Baruque', 'Gedalias', 'Ismael'],
      correctIndex: 0,
      explanation: 'Esse etíope intervém corajosamente (Jeremias 38).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'Quem foi nomeado governador depois da queda de Jerusalém, e depois assassinado?',
      options: <String>['Gedalias', 'Zedequias', 'Ismael', 'Baruque'],
      correctIndex: 0,
      explanation: 'Seu assassinato provoca novos tumultos (Jeremias 40-41).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          'O que o restante do povo faz, apesar da advertência de Jeremias para ficar no país?',
      options: <String>[
        'Ele foge para o Egito levando Jeremias junto',
        'Ele se submete plenamente ao conselho do profeta',
        'Ele ataca a Babilônia',
        'Ele se dispersa em direção à Assíria',
      ],
      correctIndex: 0,
      explanation: 'A desobediência deles agrava sua situação (Jeremias 43).',
    ),
  ],
  'Jeremiah#6': <QuizQuestion>[
    QuizQuestion(
      text:
          'Contra quais nações os últimos capítulos de Jeremias pronunciam julgamentos?',
      options: <String>[
        'O Egito, os filisteus, Moabe, Amom, a Babilônia e outras',
        'Somente Israel',
        'Nenhuma nação estrangeira',
        'Apenas Judá',
      ],
      correctIndex: 0,
      explanation:
          'Uma série de oráculos contra as nações encerra o livro (Jeremias 46-51).',
    ),
    QuizQuestion(
      text:
          'Que sinal simbólico acompanha a profecia contra a Babilônia entregue a Seraías?',
      options: <String>[
        'O rolo é jogado no Eufrates para afundar',
        'Ele é queimado publicamente',
        'Ele é lido diante do rei da Babilônia',
        'Ele é escondido no templo',
      ],
      correctIndex: 0,
      explanation: 'Uma imagem da queda definitiva da Babilônia (Jeremias 51).',
    ),
    QuizQuestion(
      text: 'Como o livro de Jeremias termina historicamente?',
      options: <String>[
        'Com a libertação de Joaquim da prisão na Babilônia',
        'Com o retorno imediato de todo o povo',
        'Com a reconstrução do templo',
        'Com uma vitória militar de Judá',
      ],
      correctIndex: 0,
      explanation: 'Um epílogo histórico encerra o livro (Jeremias 52).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesPtC3 =
    <String, List<QuizQuestion>>{};
