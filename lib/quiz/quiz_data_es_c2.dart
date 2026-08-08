import 'quiz_data.dart';

const Map<String, List<QuizQuestion>>
authoredQuizzesEsC2 = <String, List<QuizQuestion>>{
  '1 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué prometió Ana a Jehová si tenía un hijo?',
      options: <String>[
        'Consagrarlo a su servicio toda su vida',
        'Ofrecerle la mitad de sus bienes',
        'Construir un templo',
        'Convertirse ella misma en sacerdotisa',
      ],
      correctIndex: 0,
      explanation:
          'Ana consagra a Samuel al servicio del tabernáculo (1 Samuel 1).',
    ),
    QuizQuestion(
      text: '¿Cómo llamó Jehová al joven Samuel?',
      options: <String>[
        'Pronunciando su nombre de noche, varias veces',
        'Mediante un ángel visible',
        'Mediante un sueño único',
        'Mediante una voz pública',
      ],
      correctIndex: 0,
      explanation:
          'Samuel cree al principio que es Elí quien lo llama (1 Samuel 3).',
    ),
    QuizQuestion(
      text: '¿Por qué el pueblo le pidió un rey a Samuel?',
      options: <String>[
        'Para ser como las demás naciones',
        'Por orden directa de Jehová',
        'A causa de una invasión inminente',
        'Porque Samuel lo proponía',
      ],
      correctIndex: 0,
      explanation:
          'El pueblo rechaza el gobierno directo de Dios (1 Samuel 8).',
    ),
  ],
  '1 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿A quién ungió Samuel en secreto como primer rey de Israel?',
      options: <String>['Saúl', 'David', 'Jonatán', 'Abner'],
      correctIndex: 0,
      explanation: 'Samuel unge a Saúl discretamente (1 Samuel 9-10).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Por qué anunció Samuel el rechazo de Saúl como rey?',
      options: <String>[
        'Saúl ofreció un sacrificio sin esperar a Samuel',
        'Saúl perdió una batalla',
        'Saúl se negó a reinar',
        'Saúl huyó ante el enemigo',
      ],
      correctIndex: 0,
      explanation:
          'Saúl desobedece al ofrecer él mismo el sacrificio (1 Samuel 13).',
    ),
    QuizQuestion(
      text: '¿Por qué fue Saúl definitivamente rechazado como rey por Jehová?',
      options: <String>[
        'Desobedeció al perdonar a Agag y lo mejor del ganado',
        'Perdió una batalla menor',
        'Envejeció demasiado rápido',
        'Pidió ayuda a Samuel',
      ],
      correctIndex: 0,
      explanation:
          'La desobediencia respecto a Amalec sella su rechazo (1 Samuel 15).',
    ),
  ],
  '1 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Con qué arma venció David a Goliat?',
      options: <String>[
        'Una honda y una piedra',
        'Una espada',
        'Una lanza',
        'Sus propias manos',
      ],
      correctIndex: 0,
      explanation: 'David rechaza la armadura y usa su honda (1 Samuel 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['espada', 'lanza', 'escudo'],
    ),
    QuizQuestion(
      text:
          '¿Qué sentimiento llevó a Saúl a querer matar a David tras su victoria?',
      options: <String>[
        'Los celos',
        'El miedo a los filisteos',
        'La ira de Samuel',
        'Un consejo de Jonatán',
      ],
      correctIndex: 0,
      explanation:
          'Los cantos de alabanza a David despiertan los celos de Saúl (1 Samuel 18).',
    ),
    QuizQuestion(
      text: '¿Quién ayudó a David a escapar de Saúl advirtiéndole del peligro?',
      options: <String>[
        'Jonatán',
        'Abner',
        'Solo Samuel',
        'Un sacerdote desconocido',
      ],
      correctIndex: 0,
      explanation:
          'Jonatán avisa a David mediante una señal acordada (1 Samuel 20).',
      type: QuizAnswerType.freeText,
    ),
  ],
  '1 Samuel#3': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué hace David cuando tiene la oportunidad de matar a Saúl en una cueva?',
      options: <String>[
        'Lo perdona y solo corta un extremo de su manto',
        'Lo mata de inmediato',
        'Huye sin actuar',
        'Negocia la paz',
      ],
      correctIndex: 0,
      explanation:
          'David se niega a tocar al «ungido de Jehová» (1 Samuel 24).',
    ),
    QuizQuestion(
      text:
          '¿Quién evitó un conflicto entre David y Nabal gracias a su sabiduría?',
      options: <String>['Abigail', 'Mical', 'Una sierva', 'El sumo sacerdote'],
      correctIndex: 0,
      explanation: 'Abigail calma a David con provisiones (1 Samuel 25).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Dónde mueren Saúl y Jonatán en la batalla final del libro?',
      options: <String>[
        'En el monte Gilboa, contra los filisteos',
        'En Jerusalén',
        'En Hebrón',
        'En Guibeá',
      ],
      correctIndex: 0,
      explanation: 'Saúl y sus hijos mueren en Gilboa (1 Samuel 31).',
    ),
  ],
  '2 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo reaccionó David ante la muerte de Saúl y Jonatán?',
      options: <String>[
        'Compuso un canto fúnebre (una lamentación)',
        'Se alegró',
        'Ignoró la noticia',
        'Atacó de inmediato',
      ],
      correctIndex: 0,
      explanation: 'David compone «el Canto del arco» (2 Samuel 1).',
    ),
    QuizQuestion(
      text: '¿Qué ciudad conquistó David para convertirla en su capital?',
      options: <String>['Jerusalén', 'Hebrón', 'Silo', 'Guibeá'],
      correctIndex: 0,
      explanation: 'David toma la fortaleza de Sion (2 Samuel 5).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Qué promesa le hace Jehová a David por medio del profeta Natán?',
      options: <String>[
        'Un descendiente reinará para siempre',
        'David construirá él mismo el templo',
        'David vivirá eternamente',
        'David se convertirá en sacerdote',
      ],
      correctIndex: 0,
      explanation:
          'El pacto davídico promete una dinastía eterna (2 Samuel 7).',
    ),
  ],
  '2 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Con quién cometió David adulterio, lo que llevó al asesinato de Urías?',
      options: <String>['Betsabé', 'Mical', 'Abigail', 'Tamar'],
      correctIndex: 0,
      explanation:
          'David hace matar a Urías para ocultar su pecado (2 Samuel 11).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Cómo confrontó el profeta Natán a David respecto a su pecado?',
      options: <String>[
        'Con una parábola sobre un hombre rico y un pobre',
        'Denunciándolo públicamente',
        'Con una carta anónima',
        'Dejando su servicio',
      ],
      correctIndex: 0,
      explanation:
          'La parábola lleva a David a reconocer su falta (2 Samuel 12).',
    ),
    QuizQuestion(
      text: '¿Quién se rebeló contra su padre David para tomar el trono?',
      options: <String>['Absalón', 'Amnón', 'Salomón', 'Adonías'],
      correctIndex: 0,
      explanation: 'Comienza la rebelión de Absalón (2 Samuel 15).',
      type: QuizAnswerType.freeText,
    ),
  ],
  '2 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué consejo hizo fracasar el plan rápido de Ahitófel contra David?',
      options: <String>[
        'El de Husai, que se mantuvo fiel a David',
        'El de Joab',
        'El de un sacerdote',
        'El de Salomón',
      ],
      correctIndex: 0,
      explanation: 'Husai retrasa el ataque y salva a David (2 Samuel 17).',
    ),
    QuizQuestion(
      text: '¿Cómo murió Absalón?',
      options: <String>[
        'Colgado del cabello en un árbol, y muerto por Joab',
        'En combate singular contra David',
        'Envenenado',
        'En el exilio, de vejez',
      ],
      correctIndex: 0,
      explanation:
          'Absalón queda colgado y luego Joab lo atraviesa (2 Samuel 18).',
    ),
    QuizQuestion(
      text:
          '¿Qué acto de David provocó una peste sobre Israel hacia el final del libro?',
      options: <String>[
        'Un censo del pueblo',
        'La construcción de un palacio',
        'Un matrimonio prohibido',
        'Una negativa a ofrecer sacrificio',
      ],
      correctIndex: 0,
      explanation:
          'El censo desagrada a Dios y sobreviene una peste (2 Samuel 24).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['guerra', 'templo', 'altar'],
    ),
  ],
  '1 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Quién intentó apoderarse del trono antes de la muerte de David?',
      options: <String>['Adonías', 'Absalón', 'Solo Joab', 'Natán'],
      correctIndex: 0,
      explanation:
          'Adonías se proclama rey sin el consentimiento de David (1 Reyes 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Qué le pide Salomón a Jehová al comienzo mismo de su reinado?',
      options: <String>[
        'Un corazón comprensivo para juzgar al pueblo',
        'La riqueza por encima de todo',
        'La victoria militar',
        'Una larga vida sin condiciones',
      ],
      correctIndex: 0,
      explanation: 'Salomón pide sabiduría, lo cual agrada a Dios (1 Reyes 3).',
    ),
    QuizQuestion(
      text:
          '¿Quién ayudó a Salomón a proporcionar materiales para construir el templo?',
      options: <String>[
        'Hiram, rey de Tiro',
        'El faraón de Egipto',
        'La reina de Sabá',
        'El rey de Moab',
      ],
      correctIndex: 0,
      explanation: 'Hiram proporciona madera de cedro y artesanos (1 Reyes 5).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Hiram'],
    ),
  ],
  '1 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué ocurre cuando el templo queda terminado y dedicado?',
      options: <String>[
        'La gloria de Jehová llena el templo',
        'Sobreviene un terremoto',
        'El pueblo se rebela',
        'Salomón abandona Jerusalén',
      ],
      correctIndex: 0,
      explanation: 'La nube de gloria llena la casa (1 Reyes 8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['nube', 'fuego', 'arca'],
    ),
    QuizQuestion(
      text:
          '¿Por qué terminó debilitándose espiritualmente el reino de Salomón?',
      options: <String>[
        'Sus esposas extranjeras desviaron su corazón',
        'Perdió una guerra',
        'Fue exiliado',
        'Le faltó riqueza',
      ],
      correctIndex: 0,
      explanation:
          'La idolatría de sus esposas provoca su infidelidad (1 Reyes 11).',
    ),
    QuizQuestion(
      text:
          '¿Qué hace Jeroboam tras la división del reino para impedir que el pueblo vaya a Jerusalén?',
      options: <String>[
        'Instala becerros de oro en Betel y en Dan',
        'Destruye todos los caminos',
        'Prohíbe todo culto',
        'Construye un nuevo templo idéntico',
      ],
      correctIndex: 0,
      explanation: 'Jeroboam introduce un culto idolátrico rival (1 Reyes 12).',
    ),
  ],
  '1 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Quién anunció al rey Acab una sequía como castigo?',
      options: <String>['Elías', 'Eliseo', 'Miqueas', 'Abdías'],
      correctIndex: 0,
      explanation: 'Elías anuncia que no habrá lluvia ni rocío (1 Reyes 17).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: '¿Qué ocurrió durante el desafío en el monte Carmelo?',
      options: <String>[
        'El fuego de Jehová consumió el sacrificio de Elías',
        'Cayó primero una lluvia repentina',
        'Los profetas de Baal ganaron',
        'No ocurrió nada',
      ],
      correctIndex: 0,
      explanation:
          'Jehová responde con fuego delante de todo Israel (1 Reyes 18).',
    ),
    QuizQuestion(
      text: '¿Por qué hicieron Acab y Jezabel que mataran a Nabot?',
      options: <String>[
        'Para apoderarse de su viña',
        'Por un delito que había cometido',
        'Por una deuda impagada',
        'Por orden de un profeta',
      ],
      correctIndex: 0,
      explanation:
          'Jezabel orquesta un juicio falso contra Nabot (1 Reyes 21).',
    ),
  ],
  '2 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo dejó Elías la tierra?',
      options: <String>[
        'Llevado al cielo en un torbellino',
        'Murió de vejez',
        'Fue exiliado',
        'Desapareció sin explicación',
      ],
      correctIndex: 0,
      explanation:
          'Eliseo ve a Elías ser llevado por un torbellino (2 Reyes 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Eliseo', 'carro', 'manto'],
    ),
    QuizQuestion(
      text: '¿Qué milagro realizó Eliseo para la mujer sunamita?',
      options: <String>[
        'Devolvió la vida a su hijo',
        'Multiplicó su rebaño',
        'La curó de la lepra',
        'Reconstruyó su casa',
      ],
      correctIndex: 0,
      explanation: 'Eliseo resucita al hijo de la sunamita (2 Reyes 4).',
    ),
    QuizQuestion(
      text: '¿Cómo fue curado Naamán de la lepra?',
      options: <String>[
        'Bañándose siete veces en el Jordán',
        'Con un ungüento especial',
        'Con una oración colectiva',
        'Con un ayuno prolongado',
      ],
      correctIndex: 0,
      explanation:
          'Naamán obedece la instrucción de Eliseo pese a su escepticismo (2 Reyes 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Damasco', 'aceite', 'sacerdote'],
    ),
  ],
  '2 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo se levantó inesperadamente el sitio de Samaria?',
      options: <String>[
        'El ejército arameo huyó, asustado por un ruido',
        'Llegó un ejército aliado',
        'Se firmó una tregua',
        'El rey arameo murió en combate',
      ],
      correctIndex: 0,
      explanation:
          'Jehová hace oír un ruido que aterra al enemigo (2 Reyes 7).',
    ),
    QuizQuestion(
      text: '¿A quiénes eliminó Jehú para purificar la realeza de Israel?',
      options: <String>[
        'A Joram, Jezabel y la casa de Acab',
        'Solo a los profetas de Baal',
        'A los reyes de Judá',
        'A los asirios',
      ],
      correctIndex: 0,
      explanation:
          'Jehú ejecuta el juicio anunciado contra la casa de Acab (2 Reyes 9-10).',
    ),
    QuizQuestion(
      text: '¿Cómo fue protegido el joven Joás antes de convertirse en rey?',
      options: <String>[
        'Escondido en el templo por su tía',
        'Enviado al extranjero',
        'Criado por un profeta apartado',
        'Protegido por el ejército asirio',
      ],
      correctIndex: 0,
      explanation: 'Joás escapa a la masacre de Atalía (2 Reyes 11).',
    ),
  ],
  '2 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué sucede con el reino del norte (Israel) tras el asedio asirio?',
      options: <String>[
        'Samaria cae y el pueblo es deportado',
        'Conquista Asiria',
        'Firma una paz duradera',
        'Nada cambia realmente',
      ],
      correctIndex: 0,
      explanation:
          'La caída de Samaria marca el fin del reino del norte (2 Reyes 17).',
    ),
    QuizQuestion(
      text: '¿Cómo reaccionó Ezequías ante la carta amenazante de Senaquerib?',
      options: <String>[
        'La desplegó ante Jehová y oró',
        'Se rindió sin resistir',
        'Huyó de la ciudad',
        'Ignoró la amenaza',
      ],
      correctIndex: 0,
      explanation:
          'La oración de Ezequías precede a la liberación milagrosa (2 Reyes 19).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['carta', 'Isaías', 'templo'],
    ),
    QuizQuestion(
      text: '¿Qué le ocurrió al ejército asirio que sitiaba Jerusalén?',
      options: <String>[
        'Un ángel hirió a gran número de ellos en una sola noche',
        'Fue vencido en combate',
        'Simplemente se retiró',
        'Una epidemia lo fue debilitando poco a poco',
      ],
      correctIndex: 0,
      explanation: 'La intervención divina salva a Jerusalén (2 Reyes 19).',
    ),
  ],
  '2 Kings#3': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué descubrió el sumo sacerdote Hilcías durante el reinado de Josías?',
      options: <String>[
        'El libro de la ley, perdido en el templo',
        'Un tesoro de oro',
        'Una tumba real',
        'Un nuevo manantial de agua',
      ],
      correctIndex: 0,
      explanation:
          'El hallazgo impulsa la reforma religiosa de Josías (2 Reyes 22).',
    ),
    QuizQuestion(
      text: '¿Qué gran fiesta celebró Josías tras su reforma?',
      options: <String>[
        'La Pascua',
        'los Tabernáculos',
        'Pentecostés',
        'el Jubileo',
      ],
      correctIndex: 0,
      explanation: 'Se celebra una Pascua memorable (2 Reyes 23).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Pascua'],
    ),
    QuizQuestion(
      text: '¿Cómo termina el libro de los Reyes?',
      options: <String>[
        'Con la caída de Jerusalén y la destrucción del templo',
        'Con la coronación de un rey justo y duradero',
        'Con una gran victoria militar',
        'Con el regreso inmediato del exilio',
      ],
      correctIndex: 0,
      explanation:
          'El relato concluye con el exilio en Babilonia (2 Reyes 25).',
    ),
  ],
  '1 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Con qué genealogías comienza este libro?',
      options: <String>[
        'Desde Adán hasta las doce tribus de Israel',
        'Únicamente el linaje de David',
        'Solo los sacerdotes',
        'Los reyes de Egipto',
      ],
      correctIndex: 0,
      explanation: 'Las listas se remontan hasta Adán (1 Crónicas 1-2).',
    ),
    QuizQuestion(
      text: '¿De qué tribu procede el linaje real de David?',
      options: <String>['Judá', 'Leví', 'Benjamín', 'Efraín'],
      correctIndex: 0,
      explanation:
          'La genealogía de Judá incluye la casa de David (1 Crónicas 2-3).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text:
          '¿Qué tribus se establecieron al este del Jordán según estas genealogías?',
      options: <String>[
        'Rubén, Gad y la media tribu de Manasés',
        'Judá y Benjamín',
        'Leví y Simeón',
        'Dan y Neftalí',
      ],
      correctIndex: 0,
      explanation: 'Se recuerdan su territorio y sus jefes (1 Crónicas 5).',
    ),
  ],
  '1 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Por qué murió Uza al transportar el Arca?',
      options: <String>[
        'La tocó cuando se deslizaba, contraviniendo las normas divinas',
        'La robó',
        'Se negó a llevarla',
        'Se burló del cortejo',
      ],
      correctIndex: 0,
      explanation:
          'El transporte no respetaba las instrucciones divinas (1 Crónicas 13).',
    ),
    QuizQuestion(
      text:
          '¿Cómo fue finalmente transportada de manera correcta el Arca a Jerusalén?',
      options: <String>[
        'Llevada por los levitas, como prescribía la ley',
        'En una carreta tirada por bueyes',
        'En barco',
        'Por sacerdotes egipcios',
      ],
      correctIndex: 0,
      explanation: 'David corrige el error anterior (1 Crónicas 15).',
    ),
    QuizQuestion(
      text:
          '¿Contra quiénes obtuvo David victorias notables en estos capítulos?',
      options: <String>[
        'Los filisteos',
        'Los egipcios',
        'Los babilonios',
        'Los persas',
      ],
      correctIndex: 0,
      explanation:
          'David derrota a los filisteos en varias ocasiones (1 Crónicas 14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['filisteos'],
    ),
  ],
  '1 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué canto compuso Asaf con motivo de la instalación del Arca?',
      options: <String>[
        'Un canto de alabanza y acción de gracias',
        'Un canto fúnebre',
        'Una profecía de desgracia',
        'Un canto de guerra',
      ],
      correctIndex: 0,
      explanation: 'Este salmo de alabanza se confía a Asaf (1 Crónicas 16).',
    ),
    QuizQuestion(
      text: '¿Por qué no pudo David construir él mismo el templo?',
      options: <String>[
        'Había derramado mucha sangre en la guerra',
        'Le faltaba riqueza',
        'No tenía ningún plano',
        'El pueblo se oponía',
      ],
      correctIndex: 0,
      explanation: 'Jehová reserva esta tarea a Salomón (1 Crónicas 22; 28).',
    ),
    QuizQuestion(
      text: '¿Dónde compró David el terreno del futuro templo?',
      options: <String>[
        'La era de trillar de Ornán (Arauna)',
        'Un campo cerca de Hebrón',
        'Una colina en Silo',
        'Un terreno donado por Hiram',
      ],
      correctIndex: 0,
      explanation:
          'David construye allí un altar después de la peste (1 Crónicas 21).',
    ),
  ],
  '1 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo organizó David el servicio de los levitas?',
      options: <String>[
        'En grupos con tareas precisas repartidas',
        'No tenían ninguna organización',
        'Un solo hombre se ocupaba de todo',
        'Estaban exentos de servicio',
      ],
      correctIndex: 0,
      explanation:
          'Los levitas se distribuyen según sus funciones (1 Crónicas 23).',
    ),
    QuizQuestion(
      text: '¿Qué papel desempeñaban los músicos designados por David?',
      options: <String>[
        'Profetizar y alabar con instrumentos',
        'Combatir en primera línea',
        'Juzgar los pleitos',
        'Enseñar únicamente la lectura',
      ],
      correctIndex: 0,
      explanation:
          'Asaf, Hemán y Jedutún dirigen la música sagrada (1 Crónicas 25).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['ofrecer', 'construir', 'juzgar'],
    ),
    QuizQuestion(
      text:
          '¿Cuál fue la última gran actuación pública de David antes de morir?',
      options: <String>[
        'Encargar a Salomón y al pueblo que construyeran el templo',
        'Dirigir una última guerra',
        'Revisar todas las leyes',
        'Partir a un exilio voluntario',
      ],
      correctIndex: 0,
      explanation:
          'David ora y bendice a la asamblea antes de morir (1 Crónicas 28-29).',
    ),
  ],
  '2 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué le pide Salomón a Jehová al comienzo de su reinado?',
      options: <String>[
        'Sabiduría y conocimiento para gobernar',
        'La riqueza por encima de todo',
        'Un ejército poderoso',
        'Una vida sin pruebas',
      ],
      correctIndex: 0,
      explanation:
          'Su petición agrada a Dios, quien además le da riqueza (2 Crónicas 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['riquezas', 'honra', 'victoria'],
    ),
    QuizQuestion(
      text: '¿Qué ocurrió cuando el templo fue dedicado?',
      options: <String>[
        'Bajó fuego del cielo y la gloria llenó la casa',
        'Un terremoto lo destruyó todo',
        'No ocurrió nada en particular',
        'El pueblo se dispersó',
      ],
      correctIndex: 0,
      explanation:
          'Una manifestación espectacular confirma la aprobación divina (2 Crónicas 7).',
    ),
    QuizQuestion(
      text: '¿Qué oración pronuncia Salomón durante la dedicación?',
      options: <String>[
        'Una súplica para que Dios escuche las oraciones dirigidas hacia ese lugar',
        'Una petición de riqueza adicional',
        'Una declaración de guerra',
        'Un canto fúnebre',
      ],
      correctIndex: 0,
      explanation:
          'Salomón pide que Dios escuche desde los cielos (2 Crónicas 6).',
    ),
  ],
  '2 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Quién visitó a Salomón para poner a prueba su sabiduría?',
      options: <String>[
        'La reina de Sabá',
        'El rey de Asiria',
        'El faraón de Egipto',
        'El rey de Tiro',
      ],
      correctIndex: 0,
      explanation:
          'Ella queda impresionada por su sabiduría y su riqueza (2 Crónicas 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Salomón', 'oro', 'Egipto'],
    ),
    QuizQuestion(
      text: '¿Por qué se dividió el reino bajo Roboam?',
      options: <String>[
        'Su negativa a aliviar el yugo impuesto por Salomón',
        'Una invasión extranjera',
        'La muerte repentina del rey',
        'Un acuerdo pacífico de reparto',
      ],
      correctIndex: 0,
      explanation:
          'Su dureza empuja a diez tribus a seguir a Jeroboam (2 Crónicas 10).',
    ),
    QuizQuestion(
      text: '¿Cómo reaccionó Asa ante la invasión etíope?',
      options: <String>[
        'Oró a Jehová antes de la batalla y venció',
        'Se rindió sin combatir',
        'Huyó con su ejército',
        'Pagó un pesado tributo',
      ],
      correctIndex: 0,
      explanation: 'Su confianza en Dios es recompensada (2 Crónicas 14).',
    ),
  ],
  '2 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué enfermedad afectó a Asa después de que descuidara buscar a Jehová?',
      options: <String>[
        'Una grave enfermedad en los pies',
        'La lepra',
        'La ceguera',
        'Una parálisis total',
      ],
      correctIndex: 0,
      explanation: 'Consulta a los médicos en lugar de a Dios (2 Crónicas 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['lepra', 'ceguera', 'fiebre'],
    ),
    QuizQuestion(
      text: '¿Por qué fue reprendido Josafat por un profeta?',
      options: <String>[
        'Por su alianza con el malvado rey Acab',
        'Por haber descuidado el templo',
        'Por haberse negado a la guerra',
        'Por haber abolido las fiestas',
      ],
      correctIndex: 0,
      explanation: 'Se critica su alianza con Acab (2 Crónicas 19).',
    ),
    QuizQuestion(
      text: '¿Cómo obtuvo Josafat una victoria sin combatir?',
      options: <String>[
        'Orando, mientras sus enemigos se mataban entre sí',
        'Gracias a una tregua negociada',
        'Mediante una huida estratégica',
        'Gracias a un tratado con Egipto',
      ],
      correctIndex: 0,
      explanation:
          'La confianza en Dios precede a una liberación milagrosa (2 Crónicas 20).',
    ),
  ],
  '2 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo fue salvado el joven Joás de la masacre de Atalía?',
      options: <String>[
        'Escondido en el templo por su tía',
        'Enviado en secreto al extranjero',
        'Adoptado por un sacerdote extranjero',
        'Protegido por un ejército aliado',
      ],
      correctIndex: 0,
      explanation: 'Josabet lo esconde hasta su coronación (2 Crónicas 22-23).',
    ),
    QuizQuestion(
      text: '¿Por qué fue Uzías (Ozías) golpeado con lepra?',
      options: <String>[
        'Quiso ofrecer incienso, algo reservado a los sacerdotes',
        'Se negó a pagar el diezmo',
        'Insultó a un profeta',
        'Descuidó el ejército',
      ],
      correctIndex: 0,
      explanation:
          'Su orgullo lo lleva a sobrepasar su función (2 Crónicas 26).',
    ),
    QuizQuestion(
      text: '¿Qué hace Ezequías desde el comienzo mismo de su reinado?',
      options: <String>[
        'Reabre y purifica el templo',
        'Declara la guerra a Asiria',
        'Abole todas las fiestas',
        'Traslada la capital',
      ],
      correctIndex: 0,
      explanation:
          'Ezequías emprende una gran reforma religiosa (2 Crónicas 29).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Pascua', 'ídolos', 'muralla'],
    ),
  ],
  '2 Chronicles#4': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué gran fiesta organizó Ezequías tras la purificación del templo?',
      options: <String>[
        'Una Pascua excepcional',
        'los Tabernáculos',
        'el Jubileo',
        'Pentecostés',
      ],
      correctIndex: 0,
      explanation:
          'Esta Pascua reúne a Judá y a parte de Israel (2 Crónicas 30).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Tabernáculos', 'Pentecostés', 'ayuno'],
    ),
    QuizQuestion(
      text: '¿Qué pasó después de que Manasés se arrepintiera en cautiverio?',
      options: <String>[
        'Jehová lo hizo volver a Jerusalén y llevó a cabo reformas',
        'Permaneció cautivo de por vida',
        'Fue ejecutado',
        'Nada cambió',
      ],
      correctIndex: 0,
      explanation:
          'Su sincero arrepentimiento cambia su suerte (2 Crónicas 33).',
    ),
    QuizQuestion(
      text: '¿Cómo termina el libro de Crónicas?',
      options: <String>[
        'Con el decreto de Ciro que autoriza el regreso y la reconstrucción del templo',
        'Con la destrucción final sin esperanza',
        'Con la coronación de un nuevo rey davídico',
        'Con una guerra civil prolongada',
      ],
      correctIndex: 0,
      explanation:
          'El decreto de Ciro abre el camino al regreso del exilio (2 Crónicas 36).',
    ),
  ],
  'Ezra#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Quién autorizó a los exiliados a regresar para reconstruir el templo?',
      options: <String>[
        'Ciro, rey de Persia',
        'Nabucodonosor',
        'Solo Darío',
        'Jerjes',
      ],
      correctIndex: 0,
      explanation: 'Ciro publica un decreto liberador (Esdras 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Ciro'],
    ),
    QuizQuestion(
      text:
          '¿Qué hicieron los exiliados nada más regresar, incluso antes de terminar el templo?',
      options: <String>[
        'Reconstruyeron el altar para ofrecer sacrificios',
        'Eligieron un nuevo rey',
        'Atacaron a sus vecinos',
        'Rechazaron todo culto',
      ],
      correctIndex: 0,
      explanation: 'El altar se restaura antes que los cimientos (Esdras 3).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['templo', 'muralla', 'ciudad'],
    ),
    QuizQuestion(
      text:
          '¿Qué reacción mezclada siguió a la colocación de los cimientos del nuevo templo?',
      options: <String>[
        'Alegría de los jóvenes, llanto de los ancianos que recordaban el primero',
        'Indiferencia general',
        'Ira unánime',
        'Huida del pueblo',
      ],
      correctIndex: 0,
      explanation:
          'El contraste con el templo de Salomón conmueve a los ancianos (Esdras 3).',
    ),
  ],
  'Ezra#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo fueron interrumpidos los trabajos de reconstrucción?',
      options: <String>[
        'Adversarios locales hicieron que se detuvieran las obras',
        'Un terremoto lo destruyó todo',
        'Al pueblo le faltaron materiales',
        'Los obreros se marcharon por su cuenta',
      ],
      correctIndex: 0,
      explanation: 'La oposición política bloquea la obra (Esdras 4).',
    ),
    QuizQuestion(
      text:
          '¿Quiénes animaron a reanudar las obras del templo mediante sus profecías?',
      options: <String>[
        'Hageo y Zacarías',
        'Ezequiel y Daniel',
        'Isaías y Jeremías',
        'Oseas y Amós',
      ],
      correctIndex: 0,
      explanation: 'Sus mensajes reactivan la construcción (Esdras 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Esdras', 'Nehemías', 'Ciro'],
    ),
    QuizQuestion(
      text:
          '¿Quién llegó más tarde desde Babilonia con un grupo adicional de exiliados?',
      options: <String>[
        'Esdras, sacerdote y escriba',
        'Nehemías',
        'Zorobabel',
        'Mardoqueo',
      ],
      correctIndex: 0,
      explanation: 'Esdras llega durante el reinado de Artajerjes (Esdras 7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Esdras'],
    ),
  ],
  'Ezra#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Por qué no pidió Esdras una escolta armada para el viaje?',
      options: <String>[
        'Había expresado su confianza en la protección de Dios',
        'El rey se la había negado',
        'El viaje no entrañaba peligro',
        'Ya contaba con un ejército',
      ],
      correctIndex: 0,
      explanation:
          'Esdras había dado testimonio de la protección divina (Esdras 8).',
    ),
    QuizQuestion(
      text: '¿Qué problema entristeció profundamente a Esdras a su llegada?',
      options: <String>[
        'Matrimonios con mujeres de las naciones vecinas',
        'Una falta de ofrendas',
        'Una hambruna',
        'Una guerra civil',
      ],
      correctIndex: 0,
      explanation: 'Esdras rasga sus vestiduras de dolor (Esdras 9).',
    ),
    QuizQuestion(
      text: '¿Cómo respondió el pueblo al llamado de Esdras?',
      options: <String>[
        'Confesando su falta y corrigiendo la situación',
        'Negándose a todo cambio',
        'Expulsando a Esdras',
        'Ignorando el llamado',
      ],
      correctIndex: 0,
      explanation: 'Tiene lugar una reforma colectiva (Esdras 10).',
    ),
  ],
  'Nehemiah#0': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Cómo reaccionó Nehemías al enterarse del estado de las murallas de Jerusalén?',
      options: <String>[
        'Lloró, ayunó y oró',
        'Permaneció indiferente',
        'Renunció a su cargo',
        'Organizó una fiesta',
      ],
      correctIndex: 0,
      explanation: 'Su dolor lo impulsa a actuar (Nehemías 1).',
    ),
    QuizQuestion(
      text: '¿Qué le pidió Nehemías al rey Artajerjes?',
      options: <String>[
        'Permiso para ir a reconstruir las murallas',
        'Oro para sí mismo',
        'Un puesto más elevado en la corte',
        'La libertad de dejar el servicio del rey',
      ],
      correctIndex: 0,
      explanation: 'El rey acepta y le proporciona recursos (Nehemías 2).',
    ),
    QuizQuestion(
      text: '¿Cómo reaccionaron los constructores ante las burlas y amenazas?',
      options: <String>[
        'Trabajaron con una mano ocupada y la otra sosteniendo un arma',
        'Detuvieron la obra',
        'Huyeron de la ciudad',
        'Negociaron con los opositores',
      ],
      correctIndex: 0,
      explanation:
          'Vigilancia y determinación caracterizan la obra (Nehemías 4).',
    ),
  ],
  'Nehemiah#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué injusticia social denunció Nehemías entre el pueblo?',
      options: <String>[
        'Préstamos abusivos que empobrecían a los pobres',
        'La negativa a pagar el diezmo',
        'Solo la falta de respeto al sábado',
        'La corrupción de los jueces',
      ],
      correctIndex: 0,
      explanation: 'Nehemías corrige esta práctica injusta (Nehemías 5).',
    ),
    QuizQuestion(
      text: '¿En cuánto tiempo se terminó la muralla de Jerusalén?',
      options: <String>['52 días', 'Un año', 'Diez años', 'Una semana'],
      correctIndex: 0,
      explanation: 'Una hazaña a pesar de una fuerte oposición (Nehemías 6).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['52'],
    ),
    QuizQuestion(
      text: '¿Qué ocurrió cuando Esdras leyó la Ley públicamente al pueblo?',
      options: <String>[
        'El pueblo lloró primero y luego celebró con alegría',
        'El pueblo se rebeló',
        'Nadie escuchó',
        'La lectura fue interrumpida',
      ],
      correctIndex: 0,
      explanation:
          'La fiesta de los Tabernáculos sigue a esta emotiva lectura (Nehemías 8).',
    ),
  ],
  'Nehemiah#2': <QuizQuestion>[
    QuizQuestion(
      text:
          '¿Qué hizo el pueblo después de la lectura de la Ley y la confesión nacional?',
      options: <String>[
        'Firmó un compromiso escrito de obedecer a Dios',
        'Abandonó Jerusalén',
        'Abolió las fiestas',
        'Desterró a los sacerdotes',
      ],
      correctIndex: 0,
      explanation: 'Un pacto escrito sella este compromiso (Nehemías 9-10).',
    ),
    QuizQuestion(
      text: '¿Cómo se celebró la dedicación de la muralla?',
      options: <String>[
        'Con procesiones de cánticos y acción de gracias',
        'Con un ayuno silencioso',
        'Con una ceremonia militar',
        'Con el cierre de las puertas',
      ],
      correctIndex: 0,
      explanation: 'Dos coros recorren la muralla cantando (Nehemías 12).',
    ),
    QuizQuestion(
      text: '¿Qué reforma impuso Nehemías a su regreso de un segundo mandato?',
      options: <String>[
        'El estricto respeto del sábado y la expulsión de Tobías',
        'La abolición del templo',
        'Un nuevo censo',
        'La construcción de un palacio',
      ],
      correctIndex: 0,
      explanation:
          'Nehemías corrige varios abusos que habían resurgido en su ausencia (Nehemías 13).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesEsC2 =
    <String, List<QuizQuestion>>{};
