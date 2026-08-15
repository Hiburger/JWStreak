import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesEsC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Quién anunció la venida de Jesús predicando en el desierto?',
      options: <String>['Juan el Bautista', 'Elías', 'Isaías', 'Zacarías'],
      correctIndex: 0,
      explanation: 'Juan el Bautista prepara el camino de Jesús (Mateo 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Elías', 'Jesús', 'Herodes'],
    ),
    QuizQuestion(
      text: '¿Cuánto tiempo ayunó Jesús antes de ser tentado por el Diablo?',
      options: <String>['40 días', '7 días', '3 días', '100 días'],
      correctIndex: 0,
      explanation: 'Jesús ayuna 40 días y 40 noches (Mateo 4).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['cuarenta días', '40'],
    ),
    QuizQuestion(
      text: 'Según el Sermón del Monte, ¿quiénes son declarados felices?',
      options: <String>[
        'Los que son conscientes de su pobreza espiritual',
        'Los ricos',
        'Los poderosos',
        'Los famosos',
      ],
      correctIndex: 0,
      explanation:
          'Las Bienaventuranzas comienzan con los que son conscientes de su necesidad espiritual (Mateo 5:3).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Cuántos panes y peces usó Jesús para alimentar a unos 5000 hombres?',
      options: <String>[
        '5 panes y 2 peces',
        '2 panes y 5 peces',
        '7 panes',
        '12 panes',
      ],
      correctIndex: 0,
      explanation: 'Jesús multiplica 5 panes y 2 peces (Mateo 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['siete', 'doce', 'cestas'],
    ),
    QuizQuestion(
      text: '¿Qué hizo Pedro al ver a Jesús caminar sobre el agua?',
      options: <String>[
        'Intentó caminar sobre el agua también',
        'Se escondió',
        'Huyó',
        'No hizo nada',
      ],
      correctIndex: 0,
      explanation:
          'Pedro camina hacia Jesús pero comienza a hundirse por falta de fe (Mateo 14).',
    ),
    QuizQuestion(
      text: '¿Quién pidió la cabeza de Juan el Bautista en un plato?',
      options: <String>[
        'La hija de Herodías',
        'El propio Herodes',
        'Un soldado',
        'Pilato',
      ],
      correctIndex: 0,
      explanation:
          'La bailarina, instigada por su madre, reclama la cabeza de Juan (Mateo 14).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Herodes', 'Salomé', 'banquete'],
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Cómo respondió Pedro cuando Jesús preguntó: «¿Quién dicen ustedes que soy yo?»?',
      options: <String>[
        'Tú eres el Cristo, el Hijo del Dios viviente',
        'Tú eres Elías',
        'Tú eres un profeta',
        'No lo sé',
      ],
      correctIndex: 0,
      explanation: 'Pedro reconoce a Jesús como el Cristo (Mateo 16).',
    ),
    QuizQuestion(
      text: '¿Qué sucedió durante la transfiguración?',
      options: <String>[
        'El rostro de Jesús brilló como el sol',
        'Jesús desapareció',
        'Se levantó una tormenta',
        'Jesús caminó sobre el agua',
      ],
      correctIndex: 0,
      explanation:
          'Jesús se transfigura ante Pedro, Santiago y Juan (Mateo 17).',
    ),
    QuizQuestion(
      text: '¿En qué animal entró Jesús a Jerusalén?',
      options: <String>[
        'Un burrito',
        'Un caballo blanco',
        'Un camello',
        'A pie',
      ],
      correctIndex: 0,
      explanation:
          'Jesús entra montado en un burrito, conforme a la profecía (Mateo 21).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['burrito', 'asno', 'un asno'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué instituyó Jesús durante su última cena con los apóstoles?',
      options: <String>[
        'La cena conmemorativa de su muerte',
        'Una fiesta anual de la cosecha',
        'Un ayuno colectivo',
        'Una peregrinación',
      ],
      correctIndex: 0,
      explanation:
          'Jesús instituye la cena conmemorativa con el pan y el vino (Mateo 26).',
    ),
    QuizQuestion(
      text: '¿Quién entregó a Jesús por treinta piezas de plata?',
      options: <String>['Judas Iscariote', 'Pedro', 'Tomás', 'Barrabás'],
      correctIndex: 0,
      explanation: 'Judas traiciona a Jesús (Mateo 26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Judas'],
    ),
    QuizQuestion(
      text: '¿Qué sucedió al tercer día después de la muerte de Jesús?',
      options: <String>[
        'Resucitó',
        'El templo fue destruido',
        'Subió al cielo',
        'Nada en particular',
      ],
      correctIndex: 0,
      explanation: 'Jesús resucita al tercer día (Mateo 28).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>[
        'fue resucitado',
        'resucitó de entre los muertos',
      ],
    ),
  ],
  'John#0': <QuizQuestion>[
    QuizQuestion(
      text:
          'Según Juan 1, ¿quién era «la Palabra» (el Logos) junto a Dios en el principio?',
      options: <String>[
        'El Hijo de Dios, antes de hacerse humano',
        'Un ángel',
        'Moisés',
        'El Espíritu Santo',
      ],
      correctIndex: 0,
      explanation:
          'La Palabra estaba junto a Dios y se hace carne en Jesús (Juan 1).',
    ),
    QuizQuestion(
      text: '¿Cuál fue el primer milagro de Jesús, en Caná?',
      options: <String>[
        'Convertir el agua en vino',
        'Sanar a un ciego',
        'Alimentar a una multitud',
        'Calmar una tormenta',
      ],
      correctIndex: 0,
      explanation: 'Jesús convierte el agua en vino durante una boda (Juan 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Caná', 'boda', 'pan'],
    ),
    QuizQuestion(
      text:
          'Según Jesús, ¿qué debe hacer una persona para «ver el reino de Dios»?',
      options: <String>[
        'Nacer de nuevo',
        'Ayunar 40 días',
        'Ir al templo',
        'Convertirse en sacerdote',
      ],
      correctIndex: 0,
      explanation: 'Jesús se lo explica a Nicodemo (Juan 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['bautizarse', 'arrepentirse', 'espíritu'],
    ),
  ],
  'John#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo se describe Jesús a sí mismo en Juan 10?',
      options: <String>[
        'El pastor excelente',
        'El león',
        'El sumo sacerdote',
        'El juez',
      ],
      correctIndex: 0,
      explanation:
          'Jesús se presenta como el pastor excelente que da su vida por sus ovejas (Juan 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['puerta', 'ovejas', 'luz'],
    ),
    QuizQuestion(
      text:
          '¿A quién devolvió Jesús a la vida después de cuatro días en la tumba?',
      options: <String>[
        'A Lázaro',
        'A Jairo',
        'Al hijo de la viuda',
        'A un centurión',
      ],
      correctIndex: 0,
      explanation: 'Jesús resucita a Lázaro (Juan 11).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Lázaro'],
    ),
    QuizQuestion(
      text:
          '¿Qué hizo Jesús por sus apóstoles antes de la última cena, como ejemplo de humildad?',
      options: <String>[
        'Les lavó los pies',
        'Los bendijo uno por uno',
        'Compartió sus bienes',
        'Oró públicamente por cada uno de ellos',
      ],
      correctIndex: 0,
      explanation: 'Jesús lava los pies de sus discípulos (Juan 13).',
    ),
  ],
  'John#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Con qué compara Jesús su relación con sus discípulos en Juan 15?',
      options: <String>[
        'Una vid y sus ramas',
        'Un pastor y su rebaño',
        'Un rey y sus súbditos',
        'Un padre y sus hijos',
      ],
      correctIndex: 0,
      explanation: 'Jesús es la vid, sus discípulos las ramas (Juan 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pastor', 'olivo', 'fruto'],
    ),
    QuizQuestion(
      text: '¿Quién cortó la oreja de un hombre durante el arresto de Jesús?',
      options: <String>['Pedro', 'Juan', 'Santiago', 'Andrés'],
      correctIndex: 0,
      explanation: 'Pedro golpea a Malco con una espada (Juan 18).',
    ),
    QuizQuestion(
      text:
          '¿Quién dudó primero de la resurrección antes de tocar las heridas de Jesús?',
      options: <String>['Tomás', 'Pedro', 'Juan', 'Felipe'],
      correctIndex: 0,
      explanation: 'Tomás duda y después cree (Juan 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Quién prepara el camino delante de Jesús al comienzo de Marcos?',
      options: <String>[
        'Juan el Bautista',
        'Elías en persona',
        'Un ángel',
        'El sumo sacerdote',
      ],
      correctIndex: 0,
      explanation: 'Juan bautiza y anuncia la venida de Jesús (Marcos 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Elías', 'Jesús', 'Herodes'],
    ),
    QuizQuestion(
      text:
          '¿Cómo mostró Jesús su autoridad al sanar al paralítico que bajaron por el techo?',
      options: <String>[
        'Perdonando sus pecados antes de sanarlo',
        'Exigiendo un sacrificio previo',
        'Despidiéndolo sin respuesta',
        'Consultando primero a los fariseos',
      ],
      correctIndex: 0,
      explanation: 'El perdón precede a la curación física (Marcos 2).',
    ),
    QuizQuestion(
      text: '¿Qué relata la parábola del sembrador en Marcos 4?',
      options: <String>[
        'Las distintas acogidas que recibe la palabra de Dios',
        'Una simple lección de agricultura',
        'Un juicio contra los agricultores',
        'Una profecía sobre el hambre',
      ],
      correctIndex: 0,
      explanation: 'Los tipos de terreno ilustran los corazones (Marcos 4).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué sucedió cuando se alimentó a los cinco mil?',
      options: <String>[
        'Cinco panes y dos peces bastaron y hasta sobraron',
        'Cada uno había traído su propia comida',
        'La multitud se fue con hambre',
        'Se improvisó un mercado',
      ],
      correctIndex: 0,
      explanation: 'Un milagro de multiplicación (Marcos 6).',
    ),
    QuizQuestion(
      text: '¿Qué escena extraordinaria ocurre en el monte en Marcos 9?',
      options: <String>[
        'La transfiguración de Jesús',
        'Un terremoto',
        'Una tormenta violenta',
        'Un juicio público',
      ],
      correctIndex: 0,
      explanation:
          'Jesús aparece glorioso junto con Moisés y Elías (Marcos 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['bautismo', 'Elías', 'monte'],
    ),
    QuizQuestion(
      text: '¿Cómo entra Jesús a Jerusalén en Marcos 11?',
      options: <String>[
        'Montado en un burrito, aclamado por la multitud',
        'En secreto, sin ser visto',
        'Con un ejército',
        'A caballo como conquistador',
      ],
      correctIndex: 0,
      explanation: 'La entrada triunfal cumple una profecía (Marcos 11).',
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué gran mandamiento cita Jesús en Marcos 12?',
      options: <String>[
        'Amar a Dios con todo el corazón y al prójimo como a uno mismo',
        'Pagar escrupulosamente los impuestos',
        'Ayunar cada semana',
        'Evitar todo contacto con los extranjeros',
      ],
      correctIndex: 0,
      explanation: 'Jesús resume la ley en dos mandamientos (Marcos 12).',
    ),
    QuizQuestion(
      text: '¿Qué instituyó Jesús durante la última cena con sus discípulos?',
      options: <String>[
        'La cena conmemorativa de su muerte',
        'Una nueva fiesta anual',
        'Un ayuno colectivo',
        'Una peregrinación obligatoria',
      ],
      correctIndex: 0,
      explanation: 'El pan y el vino simbolizan su sacrificio (Marcos 14).',
    ),
    QuizQuestion(
      text: '¿Qué descubren las mujeres que llegan a la tumba al tercer día?',
      options: <String>[
        'La tumba está vacía, Jesús ha resucitado',
        'El cuerpo de Jesús todavía está allí',
        'La tumba está sellada e inaccesible',
        'Nada fuera de lo común',
      ],
      correctIndex: 0,
      explanation:
          'Un joven vestido de blanco les anuncia la resurrección (Marcos 16:5, 6).',
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Quién anuncia a María que será la madre de Jesús?',
      options: <String>[
        'El ángel Gabriel',
        'Un sacerdote',
        'Juan el Bautista',
        'Solo un sueño',
      ],
      correctIndex: 0,
      explanation: 'Gabriel anuncia el nacimiento milagroso (Lucas 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Miguel', 'José', 'Isabel'],
    ),
    QuizQuestion(
      text:
          '¿Quiénes dieron testimonio de Jesús niño en su presentación en el templo?',
      options: <String>[
        'Simeón y Ana',
        'Herodes',
        'Los sumos sacerdotes',
        'Nadie',
      ],
      correctIndex: 0,
      explanation: 'Dos fieles ancianos reconocen al Mesías (Lucas 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Zacarías', 'José', 'María'],
    ),
    QuizQuestion(
      text: '¿Qué famoso discurso pronuncia Jesús en Lucas 6?',
      options: <String>[
        'El sermón en la llanura, con dichas y ayes',
        'Un discurso sobre los impuestos',
        'Un anuncio de guerra',
        'Un juicio contra Roma',
      ],
      correctIndex: 0,
      explanation: 'Una enseñanza moral fundamental (Lucas 6).',
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué famosa parábola ilustra el amor al prójimo en Lucas 10?',
      options: <String>[
        'El buen samaritano',
        'El hijo pródigo',
        'El sembrador',
        'Las diez vírgenes',
      ],
      correctIndex: 0,
      explanation: 'Un ejemplo de compasión hacia un desconocido (Lucas 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sacerdote', 'levita', 'posadero'],
    ),
    QuizQuestion(
      text:
          '¿Qué tres parábolas cuenta Jesús en Lucas 15 sobre lo que se pierde?',
      options: <String>[
        'La oveja perdida, la moneda perdida, el hijo pródigo',
        'El sembrador, la red, la perla',
        'La higuera, la vid, el trigo',
        'Los talentos, las minas, el tesoro',
      ],
      correctIndex: 0,
      explanation: 'Tres imágenes de la alegría recuperada (Lucas 15).',
    ),
    QuizQuestion(
      text: '¿Qué revela la parábola del rico y Lázaro en Lucas 16?',
      options: <String>[
        'Un contraste entre la indiferencia y la compasión',
        'Una lección de agricultura',
        'Un consejo financiero práctico',
        'Una profecía sobre Roma',
      ],
      correctIndex: 0,
      explanation: 'Una parábola sobre las prioridades del corazón (Lucas 16).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué hace Zaqueo para mostrar su cambio de vida después de conocer a Jesús?',
      options: <String>[
        'Devuelve el cuádruple a quienes ha perjudicado',
        'Abandona la ciudad',
        'Termina ignorando a Jesús',
        'Se niega a compartir sus bienes',
      ],
      correctIndex: 0,
      explanation: 'Su generosidad refleja una conversión sincera (Lucas 19).',
    ),
    QuizQuestion(
      text: '¿Qué le pide a Jesús el malhechor arrepentido en el madero?',
      options: <String>[
        'Que se acuerde de él en su reino',
        'Que lo libere de inmediato',
        'Que castigue a sus acusadores',
        'Que demuestre públicamente su poder',
      ],
      correctIndex: 0,
      explanation: 'Jesús le promete el paraíso (Lucas 23).',
    ),
    QuizQuestion(
      text: '¿Qué sucede en el camino a Emaús después de la resurrección?',
      options: <String>[
        'Jesús resucitado explica las Escrituras a dos discípulos',
        'Los discípulos son arrestados',
        'Un ángel prohíbe todo viaje',
        'No sucede nada en particular',
      ],
      correctIndex: 0,
      explanation: 'Lo reconocen al compartir el pan (Lucas 24).',
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué promete Jesús a sus discípulos justo antes de su ascensión?',
      options: <String>[
        'Recibirán el poder del espíritu santo',
        'Gobernarán Roma de inmediato',
        'Nunca volverán a verlo',
        'Deberán huir de inmediato',
      ],
      correctIndex: 0,
      explanation: 'Una promesa esencial antes de Pentecostés (Hechos 1).',
    ),
    QuizQuestion(
      text: '¿Qué sucedió el día de Pentecostés?',
      options: <String>[
        'El espíritu santo fue derramado sobre los discípulos',
        'Un terremoto destruyó el templo',
        'Los apóstoles huyeron de Jerusalén',
        'No sucedió nada fuera de lo común',
      ],
      correctIndex: 0,
      explanation: 'La congregación cristiana comienza ese día (Hechos 2).',
    ),
    QuizQuestion(
      text: '¿Quién se convirtió en el primer mártir cristiano?',
      options: <String>['Esteban', 'Pedro', 'Solo Santiago', 'Felipe'],
      correctIndex: 0,
      explanation: 'Esteban es apedreado tras su discurso (Hechos 7).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo fue transformado Saulo en el camino a Damasco?',
      options: <String>[
        'Una luz y una voz de Jesús lo convirtieron',
        'Simplemente cambió de opinión por su cuenta',
        'Un rey lo obligó a cambiar',
        'No sucedió nada en ese camino',
      ],
      correctIndex: 0,
      explanation: 'Su encuentro con Jesús cambia su vida (Hechos 9).',
    ),
    QuizQuestion(
      text: '¿Qué visión recibe Pedro antes de encontrarse con Cornelio?',
      options: <String>[
        'Un gran lienzo con animales, que señala la apertura a los no judíos',
        'Una batalla celestial',
        'Un templo en llamas',
        'Un sueño sin significado',
      ],
      correctIndex: 0,
      explanation:
          'Esta visión prepara a Pedro para anunciar las buenas nuevas a las naciones (Hechos 10).',
    ),
    QuizQuestion(
      text: '¿Dónde se llamó «cristianos» a los discípulos por primera vez?',
      options: <String>['En Antioquía', 'En Jerusalén', 'En Roma', 'En Éfeso'],
      correctIndex: 0,
      explanation: 'Este nombre aparece primero en Antioquía (Hechos 11:26).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Antioquía'],
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué decisión importante toma el consejo de Jerusalén respecto a los conversos no judíos?',
      options: <String>[
        'No están obligados a la circuncisión mosaica',
        'Deben seguir toda la ley de Moisés',
        'Quedan excluidos de la congregación',
        'No se toma ninguna decisión',
      ],
      correctIndex: 0,
      explanation:
          'Una decisión clave para la expansión del cristianismo (Hechos 15).',
    ),
    QuizQuestion(
      text: '¿Qué sucedió con Pablo y Silas encarcelados en Filipos?',
      options: <String>[
        'Un terremoto abrió las puertas de la cárcel',
        'Escaparon en secreto',
        'Quedaron encerrados de por vida',
        'Nadie intervino',
      ],
      correctIndex: 0,
      explanation: 'Un milagro libera a los prisioneros (Hechos 16).',
    ),
    QuizQuestion(
      text:
          '¿Dónde pronunció Pablo su famoso discurso sobre el «Dios desconocido»?',
      options: <String>[
        'En el Areópago, en Atenas',
        'En Roma',
        'En Jerusalén',
        'En Corinto',
      ],
      correctIndex: 0,
      explanation: 'Pablo se dirige a los filósofos griegos (Hechos 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Areópago', 'Atenas'],
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué relata Pablo en su defensa tras ser arrestado en el templo?',
      options: <String>[
        'Su conversión en el camino a Damasco',
        'Una victoria militar',
        'Un viaje comercial',
        'Una disputa personal',
      ],
      correctIndex: 0,
      explanation:
          'Pablo da testimonio de su experiencia personal (Hechos 22).',
    ),
    QuizQuestion(
      text: '¿Por qué apeló Pablo al César?',
      options: <String>[
        'Para obtener un juicio justo como ciudadano romano',
        'Para evitar cualquier juicio',
        'Para ser liberado de inmediato',
        'Porque quería dejar el ministerio',
      ],
      correctIndex: 0,
      explanation:
          'Su condición de ciudadano romano le otorga ese derecho (Hechos 25).',
    ),
    QuizQuestion(
      text: '¿Qué sucedió después del naufragio en la isla de Malta?',
      options: <String>[
        'Una víbora mordió a Pablo sin hacerle daño',
        'Fue arrestado por los habitantes',
        'El barco zarpó de inmediato',
        'No sucedió nada en particular',
      ],
      correctIndex: 0,
      explanation:
          'Una señal milagrosa impresiona a los habitantes (Hechos 28).',
    ),
  ],
};

const Map<String, List<QuizQuestion>>
extraQuizzesEsC5 = <String, List<QuizQuestion>>{
  'Matthew#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué modelo de oración dio Jesús en el Sermón del Monte?',
      options: <String>[
        'La oración «Padre Nuestro»',
        'Una larga lista de peticiones',
        'Una oración secreta prohibida',
        'Ninguna oración concreta',
      ],
      correctIndex: 0,
      explanation: 'Jesús enseña a orar con sencillez (Mateo 6).',
    ),
    QuizQuestion(
      text:
          'Según Mateo 7, ¿a quién se parece el que pone en práctica las palabras de Jesús?',
      options: <String>[
        'A un hombre que construye su casa sobre la roca',
        'A un hombre que construye sobre la arena',
        'A un viajero sin rumbo',
        'A un rey sin reino',
      ],
      correctIndex: 0,
      explanation: 'La casa sobre la roca resiste las tormentas (Mateo 7:24).',
    ),
  ],
  'Matthew#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué hizo Jesús durante una tormenta en el mar de Galilea?',
      options: <String>[
        'La calmó con una palabra',
        'Remó más rápido',
        'Esperó a que pasara',
        'Huyó hacia la orilla',
      ],
      correctIndex: 0,
      explanation: 'El viento y el mar le obedecen (Mateo 8).',
    ),
    QuizQuestion(
      text: '¿A cuántos apóstoles eligió Jesús y envió a predicar?',
      options: <String>['A doce', 'A siete', 'A setenta', 'A tres'],
      correctIndex: 0,
      explanation: 'Los doce apóstoles son nombrados (Mateo 10).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['doce', '12'],
    ),
  ],
  'Matthew#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Según Mateo 18, ¿cuántas veces hay que perdonar a un hermano?',
      options: <String>[
        'Hasta 77 veces',
        'Solo tres veces',
        'Una sola vez',
        'Nunca',
      ],
      correctIndex: 0,
      explanation: 'Jesús enseña un perdón sin límites (Mateo 18:22).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['77 veces', '77'],
    ),
    QuizQuestion(
      text: '¿Qué hizo Jesús al entrar en el templo de Jerusalén?',
      options: <String>[
        'Expulsó a los comerciantes',
        'Ofreció un sacrificio',
        'Se escondió',
        'Coronó a un sacerdote',
      ],
      correctIndex: 0,
      explanation: 'Jesús purifica el templo (Mateo 21).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['mesas', 'templo', 'palomas'],
    ),
  ],
  'Matthew#3': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué señales anunció Jesús para la conclusión del sistema en Mateo 24?',
      options: <String>[
        'Guerras, hambrunas y terremotos',
        'Una paz mundial inmediata',
        'La desaparición del sol para siempre',
        'Ninguna señal',
      ],
      correctIndex: 0,
      explanation: 'Se describe una señal compuesta (Mateo 24).',
    ),
    QuizQuestion(
      text:
          '¿Qué misión encomendó Jesús a sus discípulos después de su resurrección?',
      options: <String>[
        'Hacer discípulos de personas de todas las naciones',
        'Quedarse escondidos en Jerusalén',
        'Construir un templo',
        'Esperar sin hacer nada',
      ],
      correctIndex: 0,
      explanation: 'El mandato misionero cierra el evangelio (Mateo 28:19).',
    ),
  ],
  'Mark#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿A quiénes llamó Jesús primero a orillas del mar de Galilea?',
      options: <String>[
        'A unos pescadores',
        'A unos sacerdotes',
        'A unos soldados',
        'A unos escribas',
      ],
      correctIndex: 0,
      explanation: 'Simón, Andrés y otros lo siguen (Marcos 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['publicanos', 'fariseos', 'pastores'],
    ),
    QuizQuestion(
      text: '¿Qué hizo Jesús por el hombre poseído de la región de Gerasa?',
      options: <String>[
        'Expulsó a los demonios que lo atormentaban',
        'Lo ignoró',
        'Lo envió a casa sin actuar',
        'Lo reprendió con severidad',
      ],
      correctIndex: 0,
      explanation: 'El hombre queda libre y recupera la razón (Marcos 5).',
    ),
  ],
  'Mark#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Con cuántos panes alimentó Jesús a unas 4000 personas?',
      options: <String>['Siete', 'Cinco', 'Doce', 'Dos'],
      correctIndex: 0,
      explanation: 'Un segundo milagro de multiplicación (Marcos 8).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['7'],
    ),
    QuizQuestion(
      text:
          'Según Jesús, ¿en qué hay que convertirse para entrar en el Reino de Dios?',
      options: <String>[
        'En un niño pequeño',
        'En alguien rico y poderoso',
        'En un líder reconocido',
        'En un sabio',
      ],
      correctIndex: 0,
      explanation: 'Jesús pone a los niños como ejemplo (Marcos 10).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['siervo', 'discípulo', 'pastor'],
    ),
  ],
  'Mark#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué pequeña ofrenda elogió Jesús en el templo?',
      options: <String>[
        'Las dos monedas de la viuda',
        'Una bolsa de oro',
        'Un cordero perfecto',
        'Una moneda de plata',
      ],
      correctIndex: 0,
      explanation: 'Ella dio todo lo que tenía (Marcos 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['rico', 'tesoro', 'sacerdote'],
    ),
    QuizQuestion(
      text: '¿Quién fue obligado a cargar el madero de tormento de Jesús?',
      options: <String>['Simón de Cirene', 'Pedro', 'Juan', 'Barrabás'],
      correctIndex: 0,
      explanation: 'Simón es requisado en el camino (Marcos 15).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Pedro', 'José', 'Judas'],
    ),
  ],
  'Luke#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿En qué ciudad nació Jesús?',
      options: <String>['Belén', 'Nazaret', 'Jerusalén', 'Capernaúm'],
      correctIndex: 0,
      explanation: 'El nacimiento tiene lugar en Belén (Lucas 2).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿A quiénes anunciaron primero los ángeles el nacimiento de Jesús?',
      options: <String>[
        'A unos pastores',
        'A unos reyes',
        'A los sacerdotes',
        'A Herodes',
      ],
      correctIndex: 0,
      explanation: 'Unos pastores reciben la buena noticia (Lucas 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['magos', 'reyes', 'sacerdotes'],
    ),
  ],
  'Luke#1': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿A cuántos discípulos envió Jesús a predicar de dos en dos en Lucas 10?',
      options: <String>['A setenta', 'A doce', 'A cien', 'A tres'],
      correctIndex: 0,
      explanation: 'Jesús amplía la predicación (Lucas 10).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['setenta', '70'],
    ),
    QuizQuestion(
      text:
          '¿Qué aconseja Jesús sobre la preocupación por la comida y el vestido?',
      options: <String>[
        'No preocuparse, sino buscar primero el Reino',
        'Acumular todo lo posible',
        'Dejar de trabajar por completo',
        'Preocuparse constantemente',
      ],
      correctIndex: 0,
      explanation: 'Jesús enseña a confiar en Dios (Lucas 12).',
    ),
  ],
  'Luke#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿A cuántos leprosos sanó Jesús, de los cuales solo uno volvió a dar las gracias?',
      options: <String>['A diez', 'A siete', 'A tres', 'A doce'],
      correctIndex: 0,
      explanation: 'Solo un samaritano vuelve a dar gracias (Lucas 17).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['diez', '10'],
    ),
    QuizQuestion(
      text: '¿Quién conspiró y traicionó a Jesús por dinero?',
      options: <String>['Judas Iscariote', 'Pedro', 'Tomás', 'Pilato'],
      correctIndex: 0,
      explanation: 'Judas entrega a Jesús (Lucas 22).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Judas'],
    ),
  ],
  'Acts#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Cuántas personas fueron bautizadas aproximadamente el día de Pentecostés?',
      options: <String>['Unas 3000', 'Unas 500', 'Unas 12', 'Unas 100'],
      correctIndex: 0,
      explanation: 'Un gran número responde al mensaje (Hechos 2).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['3000', 'tres mil'],
    ),
    QuizQuestion(
      text: '¿Quién cuidaba las ropas de los que apedreaban a Esteban?',
      options: <String>[
        'Saulo (más tarde Pablo)',
        'Pedro',
        'Bernabé',
        'Felipe',
      ],
      correctIndex: 0,
      explanation: 'Saulo aprobaba ese asesinato (Hechos 7-8).',
    ),
  ],
  'Acts#1': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿A quién envió el espíritu a anunciar las buenas nuevas al eunuco etíope?',
      options: <String>['A Felipe', 'A Pedro', 'A Pablo', 'A Juan'],
      correctIndex: 0,
      explanation: 'Felipe le explica las Escrituras (Hechos 8).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Felipe'],
    ),
    QuizQuestion(
      text: '¿Cómo fue liberado Pedro de la cárcel bajo Herodes?',
      options: <String>[
        'Por un ángel',
        'Sobornando a un guardia',
        'Por un terremoto',
        'Nadie lo ayudó',
      ],
      correctIndex: 0,
      explanation: 'Un ángel lo saca milagrosamente (Hechos 12).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['terremoto', 'Pablo', 'llaves'],
    ),
  ],
  'Acts#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué oficio ejercía Pablo junto con Aquila y Priscila?',
      options: <String>[
        'Fabricante de tiendas',
        'Pescador',
        'Carpintero',
        'Médico',
      ],
      correctIndex: 0,
      explanation: 'Pablo trabajaba con sus manos (Hechos 18).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['pescador', 'carpintero', 'médico'],
    ),
    QuizQuestion(
      text:
          '¿En qué ciudad la predicación de Pablo provocó un disturbio de los plateros de Diana/Artemisa?',
      options: <String>['Éfeso', 'Atenas', 'Corinto', 'Roma'],
      correctIndex: 0,
      explanation: 'Los artesanos temían por su negocio (Hechos 19).',
      type: QuizAnswerType.freeText,
    ),
  ],
  'Acts#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿Ante qué gobernantes testificó Pablo en Cesarea?',
      options: <String>[
        'Félix, Festo y el rey Agripa',
        'Pilato y Herodes',
        'Solo el Sanedrín',
        'El César en persona',
      ],
      correctIndex: 0,
      explanation: 'Pablo defiende su fe ante las autoridades (Hechos 24-26).',
    ),
    QuizQuestion(
      text:
          '¿A dónde llegó finalmente Pablo para esperar su juicio ante el César?',
      options: <String>['A Roma', 'A Jerusalén', 'A Antioquía', 'A Éfeso'],
      correctIndex: 0,
      explanation:
          'Pablo predica incluso bajo arresto domiciliario (Hechos 28).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Roma'],
    ),
  ],
};
