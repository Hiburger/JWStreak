import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesEsC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Cuántos días de creación describe Génesis antes de que Dios '
          'descanse?',
      options: <String>[
        'Seis días',
        'Siete días',
        'Tres días',
        'Cuarenta días',
      ],
      correctIndex: 0,
      explanation:
          'Génesis describe seis días de creación; Dios descansa el '
          'séptimo (Génesis 1 y 2).',
    ),
    QuizQuestion(
      text: '¿Quiénes fueron el primer hombre y la primera mujer?',
      options: <String>[
        'Adán y Eva',
        'Caín y Abel',
        'Noé y su esposa',
        'Abrahán y Sara',
      ],
      correctIndex: 0,
      explanation: 'Adán y Eva son los primeros seres humanos (Génesis 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Caín', 'Noé', 'Sara'],
    ),
    QuizQuestion(
      text: '¿Quién mató a su hermano Abel?',
      options: <String>['Caín', 'Set', 'Noé', 'Cam'],
      correctIndex: 0,
      explanation: 'Caín mata a su hermano Abel por celos (Génesis 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Por qué envió Dios el Diluvio?',
      options: <String>[
        'Por la maldad de los hombres',
        'Por una sequía',
        'Para agrandar los mares',
        'Sin razón alguna',
      ],
      correctIndex: 0,
      explanation:
          'La maldad de los seres humanos era grande sobre la tierra '
          '(Génesis 6).',
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué señal dio Dios como promesa de no volver a destruir la '
          'tierra con un diluvio?',
      options: <String>['El arcoíris', 'Una estrella', 'Un olivo', 'El trueno'],
      correctIndex: 0,
      explanation: 'El arcoíris es la señal del pacto (Génesis 9).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['arcoíris', 'arco iris'],
    ),
    QuizQuestion(
      text:
          '¿Cómo se llamaba la torre que los hombres quisieron '
          'construir?',
      options: <String>[
        'La torre de Babel',
        'La torre de Sion',
        'La torre de David',
        'La torre de Ur',
      ],
      correctIndex: 0,
      explanation: 'En Babel, Dios confunde su idioma (Génesis 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sion', 'ladrillos', 'Ur'],
    ),
    QuizQuestion(
      text: '¿A quién llamó Dios a salir de Ur?',
      options: <String>['Abrán (Abrahán)', 'Lot', 'Isaac', 'Jacob'],
      correctIndex: 0,
      explanation: 'Dios llama a Abrán y le hace promesas (Génesis 12).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Por qué redujeron los egipcios a los israelitas a la '
          'esclavitud?',
      options: <String>[
        'Temían que se hicieran demasiado numerosos',
        'Querían sus tierras',
        'Una deuda impagada',
        'Una guerra perdida',
      ],
      correctIndex: 0,
      explanation:
          'Un nuevo rey teme la multiplicación de los israelitas '
          '(Éxodo 1).',
    ),
    QuizQuestion(
      text: '¿En qué escondió la madre de Moisés al bebé?',
      options: <String>[
        'Una cesta de juncos en el Nilo',
        'Una cueva',
        'Una tienda',
        'Un pozo',
      ],
      correctIndex: 0,
      explanation:
          'Moisés es colocado en una cesta de juncos entre los cañaverales '
          '(Éxodo 2).',
    ),
    QuizQuestion(
      text: '¿Cómo se apareció Jehová a Moisés en el monte Horeb?',
      options: <String>[
        'Una zarza en llamas que no se consumía',
        'Una columna de nube',
        'Un ángel visible',
        'Un terremoto',
      ],
      correctIndex: 0,
      explanation: 'Dios habla a Moisés desde una zarza ardiente (Éxodo 3).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué fiesta instituye Dios antes de sacar a Israel de '
          'Egipto?',
      options: <String>[
        'La Pascua',
        'Pentecostés',
        'los Tabernáculos',
        'el Sábado',
      ],
      correctIndex: 0,
      explanation:
          'La Pascua conmemora la protección de los israelitas durante la '
          'última plaga (Éxodo 12).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Pascua'],
    ),
    QuizQuestion(
      text: '¿Cómo abrió Dios un paso para Israel?',
      options: <String>[
        'Separando las aguas del mar Rojo',
        'Secando el Jordán',
        'Cavando un túnel',
        'Enviando un puente de piedra',
      ],
      correctIndex: 0,
      explanation: 'El mar Rojo se abre para dejar pasar a Israel (Éxodo 14).',
    ),
    QuizQuestion(
      text: '¿Qué alimento hizo caer Dios del cielo en el desierto?',
      options: <String>['El maná', 'Pan de cebada', 'Higos', 'Miel'],
      correctIndex: 0,
      explanation: 'El maná aparece cada mañana (Éxodo 16).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['maná'],
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Quién aconsejó a Moisés delegar la resolución de los '
          'litigios?',
      options: <String>['Jetró, su suegro', 'Aarón', 'Josué', 'Miriam'],
      correctIndex: 0,
      explanation:
          'Jetró sugiere nombrar jefes para juzgar los asuntos '
          'cotidianos (Éxodo 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Jetró'],
    ),
    QuizQuestion(
      text: '¿Dónde dio Jehová los Diez Mandamientos?',
      options: <String>[
        'En el monte Sinaí',
        'En el monte Nebo',
        'En Cadés',
        'En Betel',
      ],
      correctIndex: 0,
      explanation: 'La ley es dada en el monte Sinaí (Éxodo 19-20).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Horeb', 'Nebo', 'Carmelo'],
    ),
    QuizQuestion(
      text: '¿Qué mandamiento prohíbe desear los bienes ajenos?',
      options: <String>[
        'El décimo (« No codiciarás »)',
        'El primero',
        'El quinto',
        'El séptimo',
      ],
      correctIndex: 0,
      explanation: 'El décimo mandamiento prohíbe la codicia (Éxodo 20:17).',
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué había que construir según las instrucciones divinas '
          'dadas a Moisés?',
      options: <String>[
        'El tabernáculo',
        'Un palacio',
        'Un muro',
        'Un templo de piedra',
      ],
      correctIndex: 0,
      explanation: 'Dios da planos detallados para el tabernáculo (Éxodo 25).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['tabernáculo'],
    ),
    QuizQuestion(
      text:
          '¿Qué fabricó el pueblo durante la ausencia de Moisés en la '
          'montaña?',
      options: <String>[
        'Un becerro de oro',
        'Una estatua de piedra',
        'Un altar de madera',
        'Un templo',
      ],
      correctIndex: 0,
      explanation: 'El pueblo forma un becerro de oro y lo adora (Éxodo 32).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['plata', 'Aarón', 'altar'],
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué cubrió el tabernáculo una vez terminado, como señal de '
          'la presencia de Dios?',
      options: <String>[
        'Una nube',
        'Un fuego visible en pleno día',
        'Un arcoíris',
        'Una estrella',
      ],
      correctIndex: 0,
      explanation:
          'La nube cubre la tienda de reunión y la gloria de Jehová '
          'la llena (Éxodo 40).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['nube', 'la nube'],
    ),
    QuizQuestion(
      text:
          '¿Quién talló finalmente unas nuevas tablas de piedra '
          'después de que Moisés rompiera las primeras?',
      options: <String>[
        'Moisés, por orden de Dios',
        'Aarón',
        'Josué',
        'Bezalel',
      ],
      correctIndex: 0,
      explanation:
          'Dios ordena a Moisés tallar dos tablas nuevas '
          '(Éxodo 34).',
    ),
  ],
  'Leviticus#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué tipo de sacrificio se quemaba por completo sobre el altar?',
      options: <String>[
        'El holocausto',
        'La ofrenda de comunión',
        'La ofrenda de grano',
        'La ofrenda por el pecado',
      ],
      correctIndex: 0,
      explanation:
          'El holocausto se consume íntegramente sobre el altar '
          '(Levítico 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['holocausto'],
    ),
    QuizQuestion(
      text:
          '¿Cuántos tipos principales de ofrendas se describen en '
          'estos primeros capítulos?',
      options: <String>['Cinco', 'Dos', 'Diez', 'Tres'],
      correctIndex: 0,
      explanation:
          'Holocausto, ofrenda de grano, de comunión, por el pecado y '
          'por la culpa (Levítico 1-7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['5'],
    ),
    QuizQuestion(
      text:
          '¿Quién debía llevar las ofrendas a la entrada de la tienda '
          'de reunión?',
      options: <String>[
        'La propia persona, con la ayuda de los sacerdotes',
        'Solo los sacerdotes',
        'Solo los ancianos',
        'Un enviado del rey',
      ],
      correctIndex: 0,
      explanation:
          'El que ofrece lleva él mismo su animal, y los sacerdotes '
          'ofician (Levítico 1-7).',
    ),
  ],
  'Leviticus#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Por qué murieron Nadab y Abiú?',
      options: <String>[
        'Ofrecieron un fuego no autorizado delante de Jehová',
        'Desobedecieron a Moisés',
        'Comieron un alimento impuro',
        'Se negaron a servir',
      ],
      correctIndex: 0,
      explanation:
          'Los hijos de Aarón ofrecen un «fuego extraño» y mueren '
          '(Levítico 10).',
    ),
    QuizQuestion(
      text: '¿Qué criterio hacía puro para comer a un animal terrestre?',
      options: <String>[
        'Pezuña hendida y rumiar',
        'Vivir únicamente en el desierto',
        'Estar domesticado',
        'Tener plumas',
      ],
      correctIndex: 0,
      explanation:
          'Los animales puros rumian y tienen la pezuña hendida '
          '(Levítico 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['escamas', 'aletas', 'cerdo'],
    ),
    QuizQuestion(
      text:
          '¿Qué enfermedad debían examinar en detalle los sacerdotes en '
          'estos capítulos?',
      options: <String>[
        'La lepra',
        'La viruela',
        'Solo las quemaduras',
        'El acné',
      ],
      correctIndex: 0,
      explanation:
          'Los sacerdotes examinan las señales de lepra en la piel, la '
          'ropa y las casas (Levítico 13-14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['lepra'],
    ),
  ],
  'Leviticus#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿En qué día solemne, una vez al año, se cubrían los '
          'pecados de la nación?',
      options: <String>[
        'El día de la Expiación (Yom Kipur)',
        'La Pascua',
        'El Sábado',
        'Pentecostés',
      ],
      correctIndex: 0,
      explanation:
          'El sumo sacerdote hace propiciación por la nación una vez '
          'al año (Levítico 16).',
    ),
    QuizQuestion(
      text: '¿Qué mandamiento bien conocido se encuentra en Levítico 19?',
      options: <String>[
        'Ama a tu prójimo como a ti mismo',
        'No robes ganado',
        'Descansa siete años',
        'Honra al rey',
      ],
      correctIndex: 0,
      explanation: 'Levítico 19:18 es citado más tarde por el propio Jesús.',
    ),
    QuizQuestion(
      text:
          '¿Qué debía evitarse, según Levítico 17, en cuanto a la '
          'comida?',
      options: <String>[
        'Consumir sangre',
        'Comer de noche',
        'Comer solo',
        'Comer pan',
      ],
      correctIndex: 0,
      explanation: 'El consumo de sangre está prohibido (Levítico 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['sangre', 'comer sangre'],
    ),
  ],
  'Leviticus#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué fiestas anuales se enumeran en Levítico 23?',
      options: <String>[
        'Pascua, Pentecostés, Trompetas, Expiación, Tabernáculos',
        'Solo la Pascua',
        'El Año Nuevo y nada más',
        'Únicamente ayunos',
      ],
      correctIndex: 0,
      explanation:
          'El calendario de fiestas abarca todo el año religioso '
          '(Levítico 23).',
    ),
    QuizQuestion(
      text: '¿Qué debía hacerse cada 50 años, en el Jubileo?',
      options: <String>[
        'Devolver las tierras y liberar a los esclavos hebreos',
        'Destruir las cosechas',
        'Elegir un nuevo sumo sacerdote',
        'Revisar la ley',
      ],
      correctIndex: 0,
      explanation:
          'El año del Jubileo restaura las tierras y las libertades '
          '(Levítico 25).',
    ),
    QuizQuestion(
      text: '¿Qué promete Levítico 26 en caso de fidelidad al pacto?',
      options: <String>[
        'Bendiciones; la desobediencia trae desgracias',
        'Nada en particular',
        'Riqueza inmediata sin condiciones',
        'Guerra sistemática',
      ],
      correctIndex: 0,
      explanation:
          'Se detallan bendiciones y maldiciones condicionales '
          '(Levítico 26).',
    ),
  ],
  'Numbers#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Por qué hizo Israel un censo en el desierto de Sinaí?',
      options: <String>[
        'Para contar a los hombres aptos para la guerra',
        'Para gravar a cada familia',
        'Para elegir un rey',
        'Para repartir tierras',
      ],
      correctIndex: 0,
      explanation:
          'El censo cuenta a los hombres de 20 años en adelante aptos '
          'para combatir (Números 1).',
    ),
    QuizQuestion(
      text:
          '¿Quién estaba encargado del transporte y del servicio del '
          'tabernáculo?',
      options: <String>[
        'Los levitas',
        'Solo los sacerdotes',
        'Los ancianos',
        'Los guerreros',
      ],
      correctIndex: 0,
      explanation:
          'Los levitas reciben tareas precisas para el tabernáculo '
          '(Números 3-4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['levitas'],
    ),
    QuizQuestion(
      text:
          '¿Qué debía hacer una persona que había hecho el voto de '
          'nazareato?',
      options: <String>[
        'Abstenerse de vino y no cortarse el cabello',
        'Ayunar 40 días',
        'Vivir sola en el desierto',
        'Ofrecer todo su ganado',
      ],
      correctIndex: 0,
      explanation:
          'El voto de nazareato impone restricciones particulares '
          '(Números 6).',
    ),
  ],
  'Numbers#1': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿A quién encargó Dios que ayudara a Moisés a llevar la '
          'carga del pueblo?',
      options: <String>[
        'A 70 ancianos',
        'A los 12 espías',
        'Solo a Aarón',
        'Solo a Josué',
      ],
      correctIndex: 0,
      explanation:
          '70 ancianos reciben el espíritu para compartir la '
          'responsabilidad (Números 11).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['doce', 'jueces', 'profetas'],
    ),
    QuizQuestion(
      text:
          '¿Qué sucedió después de que Miriam y Aarón criticaran a '
          'Moisés?',
      options: <String>[
        'Miriam quedó cubierta de lepra',
        'Fueron desterrados definitivamente',
        'No les pasó nada',
        'Perdieron la voz',
      ],
      correctIndex: 0,
      explanation: 'Miriam queda leprosa durante siete días (Números 12).',
    ),
    QuizQuestion(
      text: '¿Cuántos espías dieron un informe alentador sobre Canaán?',
      options: <String>['Dos (Josué y Caleb)', 'Doce', 'Ninguno', 'Cinco'],
      correctIndex: 0,
      explanation:
          'Solo Josué y Caleb animan al pueblo a entrar '
          '(Números 13-14).',
    ),
  ],
  'Numbers#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Quién se rebeló contra la autoridad de Moisés y Aarón?',
      options: <String>['Coré y sus partidarios', 'Josué', 'Caleb', 'Balaam'],
      correctIndex: 0,
      explanation: 'La rebelión de Coré es tragada por la tierra (Números 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Datán', 'fuego', 'tierra'],
    ),
    QuizQuestion(
      text:
          '¿Qué señal confirmó la elección de Aarón como sumo '
          'sacerdote?',
      options: <String>[
        'Su vara floreció',
        'Una voz celestial',
        'Un fuego sobre el altar',
        'Una estrella',
      ],
      correctIndex: 0,
      explanation: 'La vara de Aarón brota y florece (Números 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['incienso', 'tienda', 'arca'],
    ),
    QuizQuestion(
      text: '¿Por qué no pudo Moisés entrar en la Tierra Prometida?',
      options: <String>[
        'Golpeó la roca en lugar de hablarle',
        'Desobedeció una orden de guerra',
        'Adoró un ídolo',
        'Era demasiado anciano',
      ],
      correctIndex: 0,
      explanation:
          'Moisés golpea la roca con enojo, sin respetar la santidad '
          'de Dios (Números 20).',
    ),
  ],
  'Numbers#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿A quién contrató Balac para maldecir a Israel?',
      options: <String>['A Balaam', 'A Coré', 'A Og', 'A Sehón'],
      correctIndex: 0,
      explanation:
          'Balaam es llamado a maldecir a Israel, pero lo bendice '
          '(Números 23-24).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Balaam'],
    ),
    QuizQuestion(
      text:
          '¿Quién actuó con celo para detener la plaga durante la '
          'apostasía de Baal-Peor?',
      options: <String>['Finés', 'Josué', 'Solo Eleazar', 'Caleb'],
      correctIndex: 0,
      explanation: 'Finés interviene y la plaga se detiene (Números 25).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿A quién designó Jehová como sucesor de Moisés?',
      options: <String>['A Josué', 'A Caleb', 'A Eleazar', 'A Finés'],
      correctIndex: 0,
      explanation:
          'Josué es instalado ante Eleazar y la asamblea (Números 27).',
    ),
  ],
  'Numbers#4': <QuizQuestion>[
    QuizQuestion(
      text: '¿Contra qué pueblo libró Israel una guerra de juicio?',
      options: <String>['Madián', 'Edom', 'Todo Moab', 'Egipto'],
      correctIndex: 0,
      explanation: 'Se relata la guerra contra Madián (Números 31).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Qué tribus se establecieron al este del Jordán?',
      options: <String>[
        'Rubén, Gad y la media tribu de Manasés',
        'Judá y Benjamín',
        'Leví y Simeón',
        'Solo Efraín',
      ],
      correctIndex: 0,
      explanation:
          'Estas tribus obtienen tierras al este, con la condición de '
          'ayudar en la conquista (Números 32).',
    ),
    QuizQuestion(
      text: '¿Qué debían ser las ciudades de refugio?',
      options: <String>[
        'Lugares donde huir en caso de homicidio involuntario',
        'Capitales regionales',
        'Centros comerciales',
        'Solo lugares de culto',
      ],
      correctIndex: 0,
      explanation:
          'Las ciudades de refugio protegen a quien mató sin '
          'intención (Números 35).',
    ),
  ],
  'Deuteronomy#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué gran mandamiento repite Moisés en Deuteronomio 6, '
          'llamado el Semá?',
      options: <String>[
        'Jehová es uno; ámalo con todo tu corazón',
        'No comas cerdo',
        'Celebra cada luna nueva',
        'No trabajes nunca',
      ],
      correctIndex: 0,
      explanation:
          'El Semá (Deuteronomio 6:4, 5) es central en la fe de '
          'Israel.',
    ),
    QuizQuestion(
      text:
          '¿Qué recuerda Moisés sobre los diez mandamientos en estos '
          'capítulos?',
      options: <String>[
        'Los repite al pueblo antes de entrar en Canaán',
        'Los anula',
        'Añade otros diez',
        'Los reserva para los sacerdotes',
      ],
      correctIndex: 0,
      explanation:
          'Moisés vuelve a dar los diez mandamientos '
          '(Deuteronomio 5).',
    ),
    QuizQuestion(
      text:
          '¿Por qué debía Israel desconfiar de las naciones de '
          'Canaán?',
      options: <String>[
        'Por el riesgo de idolatría',
        'Por su riqueza',
        'Por su idioma',
        'Por su rey',
      ],
      correctIndex: 0,
      explanation:
          'Se subraya el peligro de adoptar sus dioses '
          '(Deuteronomio 7).',
    ),
  ],
  'Deuteronomy#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué debía recordarle a Israel el maná del desierto?',
      options: <String>[
        'Que el hombre no vive solo de pan, sino de toda expresión '
            'de la boca de Jehová',
        'Que Dios siempre castiga',
        'Que el desierto está maldito',
        'Que la comida no tiene importancia',
      ],
      correctIndex: 0,
      explanation: 'Deuteronomio 8:3, citado más tarde por Jesús.',
    ),
    QuizQuestion(
      text:
          '¿Qué suceso del desierto recuerda Moisés para advertir '
          'contra el orgullo?',
      options: <String>[
        'El becerro de oro',
        'El cruce del mar Rojo',
        'El don del maná',
        'La construcción del tabernáculo',
      ],
      correctIndex: 0,
      explanation:
          'El becerro de oro ilustra la rebelión pasada '
          '(Deuteronomio 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Aarón', 'plata', 'maná'],
    ),
    QuizQuestion(
      text:
          '¿Dónde debían llevar los israelitas sus sacrificios, según '
          'Deuteronomio 12?',
      options: <String>[
        'Al único lugar que Jehová escogiera',
        'Donde quisieran',
        'En cada aldea',
        'Solo en su propia casa',
      ],
      correctIndex: 0,
      explanation: 'Se prescribe un único lugar de culto (Deuteronomio 12).',
    ),
  ],
  'Deuteronomy#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué debía hacerse con las deudas cada siete años?',
      options: <String>[
        'Cancelarlas (año de remisión)',
        'Duplicarlas',
        'Transmitirlas a los hijos',
        'Nada en especial',
      ],
      correctIndex: 0,
      explanation: 'El año de remisión borra las deudas (Deuteronomio 15).',
    ),
    QuizQuestion(
      text: '¿Qué anuncia Deuteronomio 18 sobre un futuro profeta?',
      options: <String>[
        'Que Jehová levantaría a uno semejante a Moisés',
        'Un rey extranjero',
        'Un ángel',
        'Un juez único',
      ],
      correctIndex: 0,
      explanation:
          'Esta profecía se aplica a Cristo en las Escrituras Griegas '
          '(Deuteronomio 18).',
    ),
    QuizQuestion(
      text:
          '¿Cuántos testigos se necesitaban para establecer una '
          'acusación?',
      options: <String>[
        'Dos o tres',
        'Bastaba con uno solo',
        'Diez',
        'No se requería ninguno',
      ],
      correctIndex: 0,
      explanation: 'La ley exige varios testigos (Deuteronomio 19).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['2 o 3', 'dos', 'tres'],
    ),
  ],
  'Deuteronomy#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué ofrenda anual recordaba la liberación de Egipto?',
      options: <String>[
        'La ofrenda de las primicias',
        'El sacrificio del Jubileo',
        'Solo la ofrenda del diezmo',
        'La cena conmemorativa',
      ],
      correctIndex: 0,
      explanation:
          'La declaración de las primicias recuerda la salida de '
          'Egipto (Deuteronomio 26).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['diezmo', 'holocausto', 'Pascua'],
    ),
    QuizQuestion(
      text:
          '¿Qué debían hacer los israelitas al entrar en Canaán, en '
          'el monte Ebal?',
      options: <String>[
        'Levantar un altar y proclamar bendiciones y maldiciones',
        'Construir un palacio',
        'Establecer la capital',
        'Destruir todos los árboles',
      ],
      correctIndex: 0,
      explanation:
          'Se instituye la ceremonia en los montes Gerizim/Ebal '
          '(Deuteronomio 27).',
    ),
    QuizQuestion(
      text:
          '¿Qué principio regía las leyes sobre el divorcio en estos '
          'capítulos?',
      options: <String>[
        'Se exigía un certificado de divorcio por escrito',
        'El divorcio estaba prohibido en toda forma',
        'Solo la mujer podía divorciarse',
        'No existía ninguna norma',
      ],
      correctIndex: 0,
      explanation:
          'La ley regula el divorcio mediante un documento formal '
          '(Deuteronomio 24).',
    ),
  ],
  'Deuteronomy#4': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué prometen los capítulos 28 en caso de fidelidad al '
          'pacto?',
      options: <String>[
        'Bendiciones; la desobediencia trae maldiciones',
        'Nada concreto',
        'Una guerra inmediata',
        'Riqueza sin condiciones',
      ],
      correctIndex: 0,
      explanation: 'Se detallan bendiciones y maldiciones (Deuteronomio 28).',
    ),
    QuizQuestion(
      text:
          '¿Qué elección presenta Moisés al pueblo en Deuteronomio '
          '30?',
      options: <String>[
        'La vida y la muerte, la bendición y la maldición',
        'Quedarse o volver a Egipto',
        'Servir a Aarón o a Josué',
        'Pagar un impuesto o no',
      ],
      correctIndex: 0,
      explanation:
          'Se llama al pueblo a «escoger la vida» (Deuteronomio '
          '30:19).',
    ),
    QuizQuestion(
      text: '¿Dónde murió Moisés, sin entrar en la Tierra Prometida?',
      options: <String>[
        'En el monte Nebo',
        'En Jericó',
        'En el monte Sinaí',
        'En Belén',
      ],
      correctIndex: 0,
      explanation:
          'Moisés contempla el país desde lo alto del Nebo antes de '
          'morir (Deuteronomio 34).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Sinaí', 'Horeb', 'Jordán'],
    ),
  ],
  'Joshua#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué instrucción repite Jehová a Josué al comienzo del '
          'libro?',
      options: <String>[
        'Sé fuerte y valiente',
        'Quédate escondido',
        'Espera diez años',
        'Vuelve a Egipto',
      ],
      correctIndex: 0,
      explanation: 'Jehová anima a Josué en varias ocasiones (Josué 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['temas', 'Jericó', 'Jordán'],
    ),
    QuizQuestion(
      text: '¿Quién escondió a los espías israelitas en Jericó?',
      options: <String>['Rahab', 'Una profetisa', 'El propio rey', 'Nadie'],
      correctIndex: 0,
      explanation: 'Rahab esconde a los espías en su tejado (Josué 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Cómo cayeron las murallas de Jericó?',
      options: <String>[
        'Tras una procesión y el sonido de las trompetas',
        'Por un terremoto natural',
        'Por un asedio de varios meses',
        'Por la traición de un habitante',
      ],
      correctIndex: 0,
      explanation:
          'Después de siete vueltas y el sonido de las trompetas, los '
          'muros caen (Josué 6).',
    ),
  ],
  'Joshua#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo evitaron los gabaonitas la destrucción?',
      options: <String>[
        'Haciéndose pasar por viajeros venidos de lejos',
        'Atacando primero',
        'Pagando un tributo inmediato',
        'Convirtiéndose públicamente',
      ],
      correctIndex: 0,
      explanation:
          'Su astucia lleva a Israel a concluir un pacto de paz '
          '(Josué 9).',
    ),
    QuizQuestion(
      text:
          '¿Qué ocurrió de extraordinario durante la batalla contra '
          'los cinco reyes amorreos?',
      options: <String>[
        'El sol se detuvo',
        'Un eclipse total',
        'Una lluvia de fuego',
        'Un terremoto los separó',
      ],
      correctIndex: 0,
      explanation: 'Jehová pelea por Israel y el sol se detiene (Josué 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['luna', 'granizo', 'cielo'],
    ),
    QuizQuestion(
      text: '¿Qué porción de tierra reclamó Caleb a los 85 años?',
      options: <String>['Hebrón', 'Jericó', 'Silo', 'Betel'],
      correctIndex: 0,
      explanation: 'Caleb permanece fiel y recibe Hebrón (Josué 14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Joshua#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Dónde se instaló el tabernáculo después de la conquista '
          'inicial?',
      options: <String>['En Silo', 'En Jerusalén', 'En Hebrón', 'En Betel'],
      correctIndex: 0,
      explanation: 'La tienda de reunión se establece en Silo (Josué 18).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Silo'],
    ),
    QuizQuestion(
      text:
          '¿Por qué levantaron un altar cerca del Jordán las tribus '
          'del este?',
      options: <String>[
        'Como testimonio de su pertenencia a Israel',
        'Para declarar su independencia',
        'Para adorar a otro dios',
        'Por orden de un rey extranjero',
      ],
      correctIndex: 0,
      explanation:
          'El altar es un testigo, no un lugar de sacrificio rival '
          '(Josué 22).',
    ),
    QuizQuestion(
      text:
          '¿Qué famosa declaración hace Josué en Siquem antes de '
          'morir?',
      options: <String>[
        'Yo y mi casa serviremos a Jehová',
        'Volvemos a Egipto',
        'Un rey nos gobernará',
        'La guerra continuará para siempre',
      ],
      correctIndex: 0,
      explanation: 'Josué llama al pueblo a escoger a quién servir (Josué 24).',
    ),
  ],
  'Judges#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué ciclo se repite a lo largo del libro de Jueces?',
      options: <String>[
        'Infidelidad, opresión, clamor a Dios, liberación',
        'Paz perpetua',
        'Guerra civil continua',
        'Migración constante',
      ],
      correctIndex: 0,
      explanation: 'Este ciclo estructura todo el libro (Jueces 2).',
    ),
    QuizQuestion(
      text:
          '¿Quién dirigió el ejército de Israel contra Sísara, con la '
          'ayuda de Débora?',
      options: <String>['Barac', 'Aod', 'Otoniel', 'Gedeón'],
      correctIndex: 0,
      explanation: 'Débora y Barac llevan a Israel a la victoria (Jueces 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Cómo redujo Gedeón su ejército a 300 hombres?',
      options: <String>[
        'Observando cómo bebían agua',
        'Echando suertes',
        'Escogiendo a los más jóvenes',
        'Escogiendo a los más ricos',
      ],
      correctIndex: 0,
      explanation: 'La prueba del agua selecciona a 300 hombres (Jueces 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['trompetas', 'cántaros', 'antorchas'],
    ),
  ],
  'Judges#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo terminó el reinado de Abimélec?',
      options: <String>[
        'Pereció, golpeado por una piedra de molino lanzada por una '
            'mujer',
        'Reinó en paz mucho tiempo',
        'Fue expulsado sin violencia',
        'Fundó una dinastía duradera',
      ],
      correctIndex: 0,
      explanation:
          'Abimélec muere bajo una piedra de molino lanzada por una '
          'mujer (Jueces 9).',
    ),
    QuizQuestion(
      text: '¿Qué voto trágico hizo Jefté antes de la batalla?',
      options: <String>[
        'Ofrecer a la primera persona que saliera de su casa',
        'Ayunar un año',
        'Destruir su casa',
        'No casarse nunca',
      ],
      correctIndex: 0,
      explanation: 'Su hija es la primera en salir a su encuentro (Jueces 11).',
    ),
    QuizQuestion(
      text: '¿Cómo se reconocía a los efraimitas al cruzar el Jordán?',
      options: <String>[
        'No podían pronunciar correctamente «Shibolet»',
        'Por su ropa',
        'Por su acento cantarín',
        'Por su armamento',
      ],
      correctIndex: 0,
      explanation: 'La contraseña delata a los fugitivos (Jueces 12).',
    ),
  ],
  'Judges#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Con qué arma improvisada venció Sansón a mil filisteos?',
      options: <String>[
        'Una quijada de asno',
        'Una espada',
        'Una honda',
        'Un bastón',
      ],
      correctIndex: 0,
      explanation: 'Sansón golpea con una quijada de asno (Jueces 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['espada', 'honda', 'filisteos'],
    ),
    QuizQuestion(
      text:
          '¿Quién reveló a los filisteos el secreto de la fuerza de '
          'Sansón?',
      options: <String>['Dalila', 'Su madre', 'Un juez rival', 'Un sacerdote'],
      correctIndex: 0,
      explanation:
          'Dalila descubre que su fuerza proviene de su cabello '
          '(Jueces 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Qué frase resume el estado de Israel al final del libro?',
      options: <String>[
        'Cada uno hacía lo que le parecía correcto a sus propios ojos',
        'Un rey justo reinaba',
        'La paz reinaba en todas partes',
        'Los sacerdotes gobernaban bien',
      ],
      correctIndex: 0,
      explanation:
          'Esta observación concluye varios relatos del libro '
          '(Jueces 17, 21).',
    ),
  ],
  'Ruth#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Por qué se fueron Noemí y su familia a Moab?',
      options: <String>[
        'Por una hambruna en Belén',
        'Para huir de una guerra',
        'Por negocios',
        'Por orden de un juez',
      ],
      correctIndex: 0,
      explanation: 'El hambre empuja a Elimélec a emigrar (Rut 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['guerra', 'Moab', 'sequía'],
    ),
    QuizQuestion(
      text: '¿Qué decisión toma Rut respecto a Noemí?',
      options: <String>[
        'Quedarse con ella: «adondequiera que tú vayas, iré yo»',
        'Volver con su propio pueblo',
        'Volver a casarse de inmediato en Moab',
        'Quedarse sola en Moab',
      ],
      correctIndex: 0,
      explanation: 'Rut expresa un célebre y leal apego (Rut 1:16).',
    ),
    QuizQuestion(
      text: '¿Qué fue de los esposos de Noemí y de sus nueras?',
      options: <String>[
        'Todos murieron en Moab',
        'Volvieron a Belén',
        'Prosperaron en Moab',
        'Fundaron una ciudad',
      ],
      correctIndex: 0,
      explanation: 'Elimélec, y luego sus dos hijos, mueren en Moab (Rut 1).',
    ),
  ],
  'Ruth#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué hacía Rut en los campos de Booz?',
      options: <String>[
        'Espigaba las espigas dejadas por los segadores',
        'Vendía telas',
        'Cuidaba rebaños',
        'Enseñaba la ley',
      ],
      correctIndex: 0,
      explanation: 'Rut espiga para alimentar a Noemí y a sí misma (Rut 2).',
    ),
    QuizQuestion(
      text: '¿Cómo mostró Booz bondad hacia Rut?',
      options: <String>[
        'Permitiéndole espigar con seguridad y compartiendo su comida',
        'Ignorándola cortésmente',
        'Echándola del campo',
        'Exigiéndole un pago',
      ],
      correctIndex: 0,
      explanation: 'Booz protege a Rut y la trata con favor (Rut 2).',
    ),
    QuizQuestion(
      text: '¿Qué le aconseja Noemí a Rut acerca de Booz?',
      options: <String>[
        'Ir a la era y darse a conocer ante él',
        'Evitarlo por completo',
        'Irse a Moab',
        'Casarse con otro hombre',
      ],
      correctIndex: 0,
      explanation: 'Noemí guía a Rut hacia un posible rescate (Rut 3).',
    ),
  ],
  'Ruth#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Cómo resolvió Booz la cuestión del derecho de rescate ante '
          'los ancianos?',
      options: <String>[
        'Un pariente más cercano renunció públicamente a su derecho',
        'Un sorteo lo decidió',
        'El rey lo determinó',
        'No se consultó a nadie',
      ],
      correctIndex: 0,
      explanation:
          'El procedimiento legal se desarrolla en la puerta de la '
          'ciudad (Rut 4).',
    ),
    QuizQuestion(
      text: '¿Qué hijo tuvieron Rut y Booz?',
      options: <String>['Obed', 'David', 'Isaí', 'Salomón'],
      correctIndex: 0,
      explanation: 'Obed llega a ser el abuelo de David (Rut 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Por qué termina el libro de Rut con una genealogía?',
      options: <String>[
        'Para vincular a Rut con el linaje que lleva a David',
        'Por simple tradición literaria',
        'Para cerrar un debate jurídico',
        'Para honrar a Moab',
      ],
      correctIndex: 0,
      explanation: 'La genealogía vincula a Rut con David (Rut 4:17-22).',
    ),
  ],
};

const Map<String, List<QuizQuestion>>
extraQuizzesEsC1 = <String, List<QuizQuestion>>{
  'Genesis#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué árbol del jardín de Edén estaba prohibido para Adán '
          'y Eva?',
      options: <String>[
        'El árbol del conocimiento de lo bueno y lo malo',
        'El árbol de la vida',
        'Una higuera',
        'Un olivo',
      ],
      correctIndex: 0,
      explanation: 'Dios prohíbe únicamente este árbol (Génesis 2:17).',
    ),
    QuizQuestion(
      text: '¿Quién engañó a Eva para que comiera del fruto prohibido?',
      options: <String>['La serpiente', 'Caín', 'Un ángel', 'Adán'],
      correctIndex: 0,
      explanation: 'La serpiente la incita a desobedecer (Génesis 3).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['serpiente'],
    ),
  ],
  'Genesis#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué ave, enviada por Noé, regresó con una hoja de olivo?',
      options: <String>['La paloma', 'El cuervo', 'El águila', 'El gorrión'],
      correctIndex: 0,
      explanation: 'La paloma muestra que las aguas bajaban (Génesis 8).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['paloma'],
    ),
    QuizQuestion(
      text:
          '¿Quién, rey de Salem y sacerdote del Dios Altísimo, '
          'bendijo a Abrán?',
      options: <String>['Melquisedec', 'Lot', 'El faraón', 'Isaac'],
      correctIndex: 0,
      explanation:
          'Melquisedec bendice a Abrán tras una victoria (Génesis 14).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Genesis#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué señal del pacto dio Dios a Abrahán?',
      options: <String>[
        'La circuncisión',
        'Un tatuaje',
        'Un anillo',
        'Un bastón',
      ],
      correctIndex: 0,
      explanation: 'La circuncisión marca el pacto (Génesis 17).',
    ),
    QuizQuestion(
      text: '¿Cómo se llamaba el hijo de Abrahán y Agar?',
      options: <String>['Ismael', 'Isaac', 'Esaú', 'Jacob'],
      correctIndex: 0,
      explanation: 'Ismael nace de Agar, la sierva (Génesis 16).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Qué ciudades destruyó Dios a causa de su maldad?',
      options: <String>[
        'Sodoma y Gomorra',
        'Babel y Ur',
        'Nínive y Tiro',
        'Betel y Hai',
      ],
      correctIndex: 0,
      explanation:
          'El fuego destruye estas ciudades; Lot se salva (Génesis 19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Lot', 'sal', 'Abrahán'],
    ),
  ],
  'Genesis#3': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué le pidió Dios a Abrahán que ofreciera en el monte '
          'Moria?',
      options: <String>[
        'A su hijo Isaac',
        'Un carnero',
        'Su tienda',
        'Sus rebaños',
      ],
      correctIndex: 0,
      explanation: 'Dios detiene a Abrahán y provee un carnero (Génesis 22).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['carnero', 'Sara', 'altar'],
    ),
    QuizQuestion(
      text: '¿Por qué vendió Esaú su primogenitura a Jacob?',
      options: <String>[
        'Por un plato de lentejas',
        'Por oro',
        'Por un rebaño',
        'Por una tienda',
      ],
      correctIndex: 0,
      explanation: 'Esaú desprecia su primogenitura (Génesis 25).',
    ),
    QuizQuestion(
      text: '¿Qué vio Jacob en sueños en Betel?',
      options: <String>[
        'Una escalera que llegaba al cielo con ángeles',
        'Un mar embravecido',
        'Una zarza en llamas',
        'Una ciudad en ruinas',
      ],
      correctIndex: 0,
      explanation: 'Dios confirma sus promesas a Jacob (Génesis 28).',
    ),
  ],
  'Genesis#4': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué nuevo nombre recibió Jacob después de luchar con el '
          'ángel?',
      options: <String>['Israel', 'Edom', 'Abrahán', 'Efraín'],
      correctIndex: 0,
      explanation:
          'El nombre Israel significa «el que lucha con Dios» '
          '(Génesis 32).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          '¿Cuántos hijos tuvo Jacob, antepasados de las tribus de '
          'Israel?',
      options: <String>['Doce', 'Diez', 'Siete', 'Catorce'],
      correctIndex: 0,
      explanation: 'Sus doce hijos fundan las tribus de Israel (Génesis 35).',
    ),
    QuizQuestion(
      text: '¿Con quién se reconcilió Jacob tras años de separación?',
      options: <String>[
        'Con su hermano Esaú',
        'Con Labán',
        'Con el faraón',
        'Con Isaac',
      ],
      correctIndex: 0,
      explanation: 'Los dos hermanos se reencuentran en paz (Génesis 33).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Labán', 'Raquel', 'ángel'],
    ),
  ],
  'Genesis#5': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué hicieron los hermanos de José por envidia?',
      options: <String>[
        'Lo vendieron como esclavo',
        'Lo coronaron rey',
        'Lo abandonaron en Egipto',
        'Lo ignoraron',
      ],
      correctIndex: 0,
      explanation: 'José es vendido y llevado a Egipto (Génesis 37).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Egipto', 'pozo', 'túnica'],
    ),
    QuizQuestion(
      text: '¿Qué prenda especial le había regalado Jacob a José?',
      options: <String>[
        'Una hermosa túnica',
        'Una corona',
        'Una armadura',
        'Un manto sacerdotal',
      ],
      correctIndex: 0,
      explanation: 'Este regalo aviva los celos de sus hermanos (Génesis 37).',
    ),
    QuizQuestion(
      text:
          '¿Qué interpretó José para el faraón, anunciando siete años '
          'de hambre?',
      options: <String>[
        'Los sueños del faraón',
        'Un libro antiguo',
        'Las estrellas',
        'Un oráculo',
      ],
      correctIndex: 0,
      explanation: 'José interpreta los sueños del faraón (Génesis 41).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['sueños', 'los sueños', 'sus sueños'],
    ),
  ],
  'Genesis#6': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Cómo trató José a sus hermanos una vez que se dio a '
          'conocer?',
      options: <String>[
        'Los perdonó',
        'Los encarceló de por vida',
        'Los expulsó',
        'Los ignoró',
      ],
      correctIndex: 0,
      explanation: 'José los perdona y los alimenta (Génesis 45).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['perdonó', 'les perdonó'],
    ),
    QuizQuestion(
      text: '¿Dónde se establecieron Jacob y su familia en Egipto?',
      options: <String>[
        'En la tierra de Gosén',
        'En Menfis',
        'En Tebas',
        'En el Sinaí',
      ],
      correctIndex: 0,
      explanation: 'El faraón les da la región de Gosén (Génesis 47).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Egipto', 'faraón', 'Canaán'],
    ),
    QuizQuestion(
      text: '¿Cómo veía José el mal que sus hermanos le habían hecho?',
      options: <String>[
        'Dios lo había convertido en bien para salvar vidas',
        'Como una injusticia que vengar',
        'Como algo sin importancia',
        'Como un simple accidente',
      ],
      correctIndex: 0,
      explanation: 'Una célebre declaración de fe (Génesis 50:20).',
    ),
  ],
  'Exodus#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Quién era el hermano de Moisés, designado como su '
          'portavoz?',
      options: <String>['Aarón', 'Josué', 'Jetró', 'Caleb'],
      correctIndex: 0,
      explanation: 'Aarón habla al pueblo en lugar de Moisés (Éxodo 4).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          '¿Con qué nombre se identificó Jehová ante Moisés en la '
          'zarza ardiente?',
      options: <String>[
        '«Seré lo que seré»',
        '«El Dios sin nombre»',
        '«El Dios oculto»',
        '«El rey de reyes»',
      ],
      correctIndex: 0,
      explanation: 'Dios revela el significado de su nombre (Éxodo 3:14).',
    ),
  ],
  'Exodus#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cuál fue la décima y última plaga de Egipto?',
      options: <String>[
        'La muerte de los primogénitos',
        'Las langostas',
        'Las tinieblas',
        'El granizo',
      ],
      correctIndex: 0,
      explanation:
          'Esta plaga hace que el faraón decida liberar a Israel '
          '(Éxodo 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ranas', 'langostas', 'granizo'],
    ),
    QuizQuestion(
      text:
          '¿Qué debían poner los israelitas en sus puertas durante '
          'la Pascua?',
      options: <String>[
        'Sangre de cordero',
        'Aceite',
        'Harina',
        'Una señal de ceniza',
      ],
      correctIndex: 0,
      explanation: 'La sangre protege a sus primogénitos (Éxodo 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['aceite', 'ceniza', 'vino'],
    ),
  ],
  'Exodus#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo brotó agua para el pueblo sediento en Horeb?',
      options: <String>[
        'Moisés golpeó la roca',
        'Un manantial apareció solo',
        'Llovió abundantemente',
        'Se cavó un pozo',
      ],
      correctIndex: 0,
      explanation: 'Por orden de Dios, Moisés golpea la roca (Éxodo 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['vara', 'agua', 'Aarón'],
    ),
    QuizQuestion(
      text:
          '¿Cuántos mandamientos componen el Decálogo dado en el '
          'Sinaí?',
      options: <String>['Diez', 'Siete', 'Doce', 'Cinco'],
      correctIndex: 0,
      explanation: 'Los Diez Mandamientos se dan en el Sinaí (Éxodo 20).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['10'],
    ),
  ],
  'Exodus#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué debía contener el arca del pacto?',
      options: <String>[
        'Las tablas de la Ley',
        'Oro y plata',
        'Rollos de profecías',
        'Ofrendas de alimentos',
      ],
      correctIndex: 0,
      explanation:
          'Las tablas de los mandamientos son colocadas allí '
          '(Éxodo 25).',
    ),
    QuizQuestion(
      text:
          '¿Quién fabricó el becerro de oro durante la ausencia de '
          'Moisés?',
      options: <String>['Aarón', 'Josué', 'Hur', 'Bezalel'],
      correctIndex: 0,
      explanation: 'Aarón cede a la petición del pueblo (Éxodo 32).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Exodus#4': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué caracterizaba el rostro de Moisés después de hablar '
          'con Dios?',
      options: <String>[
        'Resplandecía',
        'Estaba velado de tristeza',
        'Había envejecido',
        'Nada en particular',
      ],
      correctIndex: 0,
      explanation:
          'Moisés debía cubrir con un velo su rostro resplandeciente '
          '(Éxodo 34).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['brillaba'],
    ),
    QuizQuestion(
      text: '¿Qué llenó el tabernáculo una vez terminado?',
      options: <String>[
        'La gloria de Jehová (una nube)',
        'Solo humo de incienso',
        'Una luz artificial',
        'Nada visible',
      ],
      correctIndex: 0,
      explanation: 'La nube señala la presencia divina (Éxodo 40).',
    ),
  ],
};
