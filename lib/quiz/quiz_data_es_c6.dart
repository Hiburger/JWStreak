import 'quiz_data.dart';

const Map<String, List<QuizQuestion>> authoredQuizzesEsC6 = <String, List<QuizQuestion>>{
  'Romans#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué declara Pablo sobre la situación de todos los seres '
          'humanos, judíos y no judíos, en Romanos 3?',
      options: <String>[
        'Todos han pecado y están privados de la gloria de Dios',
        'Solo los no judíos han pecado',
        'En realidad, nadie ha pecado',
        'Solo los dirigentes son responsables',
      ],
      correctIndex: 0,
      explanation:
          'Una base esencial del argumento de Pablo (Romanos 3:23).',
    ),
    QuizQuestion(
      text: '¿En qué se basa la justificación según Romanos 3 y 4, '
          'ilustrada con el ejemplo de Abrahán?',
      options: <String>[
        'La fe, y no las obras de la ley',
        'Únicamente los sacrificios rituales',
        'La riqueza personal',
        'El origen étnico',
      ],
      correctIndex: 0,
      explanation:
          'Abrahán fue declarado justo por su fe (Romanos 4).',
    ),
  ],
  'Romans#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué declara Romanos 8 sobre el amor de Dios hacia los '
          'cristianos?',
      options: <String>[
        'Nada puede separarnos del amor de Dios',
        'Ese amor es condicional y frágil',
        'Solo concierne a unos pocos elegidos',
        'Desaparece en tiempos de prueba',
      ],
      correctIndex: 0,
      explanation:
          'Una poderosa afirmación cierra este capítulo '
          '(Romanos 8:38, 39).',
    ),
    QuizQuestion(
      text: '¿Qué dice Romanos 10 sobre la salvación?',
      options: <String>[
        'Todo el que invoque el nombre de Jehová será salvo',
        'Solo los sacerdotes pueden salvarse',
        'La salvación depende únicamente del nacimiento',
        'No hay salvación posible para las naciones',
      ],
      correctIndex: 0,
      explanation:
          'Se cita una promesa universal (Romanos 10:13).',
    ),
  ],
  'Romans#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué pide Romanos 12 a los cristianos con respecto a su '
          'vida diaria?',
      options: <String>[
        'Ofrecerse como sacrificio vivo a Dios',
        'Evitar toda actividad social',
        'Apartarse por completo del mundo',
        'No usar nunca sus dones',
      ],
      correctIndex: 0,
      explanation:
          'Un llamado a una consagración práctica (Romanos 12:1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['culto', 'cuerpo', 'mente'],
    ),
    QuizQuestion(
      text: '¿Qué principio establece Romanos 13 con respecto a las '
          'autoridades?',
      options: <String>[
        'Estar sujetos a las autoridades superiores',
        'Ignorar sistemáticamente las leyes',
        'Rebelarse contra todo gobierno',
        'Pagar impuestos solo si se desea',
      ],
      correctIndex: 0,
      explanation:
          'Se enseña un principio de respeto cívico (Romanos 13).',
    ),
  ],
  '1 Corinthians#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué problema aborda Pablo desde el comienzo de esta '
          'carta?',
      options: <String>[
        'Las divisiones y rivalidades en la congregación',
        'Una falta de alimento',
        'Una invasión militar',
        'Una ausencia total de fe',
      ],
      correctIndex: 0,
      explanation:
          'Las facciones formadas en torno a distintos maestros '
          'causaban problemas (1 Corintios 1).',
    ),
    QuizQuestion(
      text: '¿Con qué compara Pablo a la iglesia en 1 Corintios 3?',
      options: <String>[
        'Con el templo de Dios',
        'Con un ejército',
        'Con un simple edificio vacío',
        'Con una empresa comercial',
      ],
      correctIndex: 0,
      explanation:
          'Una imagen sagrada subraya la responsabilidad colectiva '
          '(1 Corintios 3:16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['cuerpo', 'edificio', 'campo'],
    ),
  ],
  '1 Corinthians#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo aborda Pablo el tema de los alimentos ofrecidos a '
          'los ídolos?',
      options: <String>[
        'El amor y la conciencia del prójimo priman sobre la libertad',
        'Lo prohíbe de manera absoluta, sin excepción',
        'Lo aprueba sin ninguna reserva',
        'Se niega a tratar el tema',
      ],
      correctIndex: 0,
      explanation:
          'Un equilibrio entre libertad y consideración por los demás '
          '(1 Corintios 8).',
    ),
    QuizQuestion(
      text: '¿Qué actitud adopta Pablo para ganar a las personas para '
          'el Evangelio, según 1 Corintios 9?',
      options: <String>[
        'Hacerse todas las cosas para todos, en la medida de lo '
            'posible',
        'Mantenerse rígido en todos sus hábitos',
        'Evitar todo contacto con otras culturas',
        'Exigir un pago por predicar',
      ],
      correctIndex: 0,
      explanation:
          'Una flexibilidad motivada por el amor (1 Corintios 9:22).',
    ),
  ],
  '1 Corinthians#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Con qué compara Pablo la diversidad de dones espirituales '
          'en la congregación?',
      options: <String>[
        'Con las distintas partes de un mismo cuerpo',
        'Con rivales separados',
        'Con extraños sin relación entre sí',
        'Con dones sin ninguna utilidad',
      ],
      correctIndex: 0,
      explanation:
          'Una imagen de unidad en medio de la diversidad '
          '(1 Corintios 12).',
    ),
    QuizQuestion(
      text: '¿Qué cualidad describe Pablo como superior a todos los '
          'dones en el célebre capítulo 13?',
      options: <String>['El amor', 'La riqueza', 'La fama', 'El poder'],
      correctIndex: 0,
      explanation:
          'Sin amor, todo lo demás carece de valor (1 Corintios 13).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['amor'],
    ),
  ],
  '2 Corinthians#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo describe Pablo el consuelo que recibió en medio de '
          'la prueba?',
      options: <String>[
        'Un consuelo para compartir después con otros',
        'Un consuelo reservado únicamente para él mismo',
        'Una ausencia total de consuelo',
        'Un consuelo que proviene solo de los hombres',
      ],
      correctIndex: 0,
      explanation:
          'El consuelo divino se transmite a los demás '
          '(2 Corintios 1).',
    ),
    QuizQuestion(
      text: '¿Con qué compara Pablo a los cristianos transformados en '
          '2 Corintios 3 y 4?',
      options: <String>[
        'Con tesoros valiosos en frágiles vasijas de barro',
        'Con reyes poderosos',
        'Con guerreros invencibles',
        'Con estatuas inmutables',
      ],
      correctIndex: 0,
      explanation:
          'Una imagen de humildad y de poder divino '
          '(2 Corintios 4:7).',
    ),
  ],
  '2 Corinthians#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué llamado central hace Pablo en 2 Corintios 5?',
      options: <String>['Reconcíliense con Dios', 'Busquen la riqueza ante todo', 'Eviten toda predicación', 'Huyan de toda responsabilidad'],
      correctIndex: 0,
      explanation:
          'El mensaje central de la reconciliación (2 Corintios '
          '5:20).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['arrepiéntanse', 'oren', 'perdonen'],
    ),
    QuizQuestion(
      text: '¿Qué principio enseña Pablo sobre el dar con generosidad '
          'en 2 Corintios 9?',
      options: <String>[
        'Dios ama a quien da con alegría',
        'El dar siempre debe ser forzado',
        'Solo los ricos deben dar',
        'El dar carece de importancia',
      ],
      correctIndex: 0,
      explanation:
          '"Dios ama al dador alegre" (2 Corintios 9:7).',
    ),
  ],
  '2 Corinthians#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo responde Pablo a su «espina en la carne» en '
          '2 Corintios 12?',
      options: <String>[
        'Acepta que el poder de Dios se perfeccione en la debilidad',
        'Abandona su ministerio',
        'Exige una curación inmediata',
        'Acusa a Dios de injusticia',
      ],
      correctIndex: 0,
      explanation:
          '"Mi poder se perfecciona en la debilidad" '
          '(2 Corintios 12:9).',
    ),
    QuizQuestion(
      text: '¿Qué llamado final hace Pablo en 2 Corintios 13?',
      options: <String>[
        'Examinarse a sí mismo para ver si se está en la fe',
        'Ignorar todo examen personal',
        'Juzgar severamente solo a los demás',
        'Abandonar toda reflexión espiritual',
      ],
      correctIndex: 0,
      explanation:
          'Un llamado a la introspección sincera (2 Corintios 13:5).',
    ),
  ],
  'Galatians#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿De dónde afirma Pablo que proviene su autoridad '
          'apostólica?',
      options: <String>[
        'Directamente de Jesucristo, no de los hombres',
        'Solo del nombramiento de los apóstoles de Jerusalén',
        'De su propia decisión personal',
        'De una tradición familiar',
      ],
      correctIndex: 0,
      explanation:
          'Pablo defiende la legitimidad de su misión (Gálatas 1).',
    ),
    QuizQuestion(
      text: '¿Por qué reprendió Pablo a Pedro en público?',
      options: <String>[
        'Pedro evitaba por hipocresía comer con los no judíos',
        'Pedro había robado dinero',
        'Pedro había renegado de su fe',
        'Pedro se negaba a predicar',
      ],
      correctIndex: 0,
      explanation:
          'Se corrige una incoherencia práctica (Gálatas 2).',
    ),
  ],
  'Galatians#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿En qué se basa la justificación según Gálatas 3, '
          'ilustrada con el ejemplo de Abrahán?',
      options: <String>[
        'La fe, y no las obras de la ley',
        'Únicamente la descendencia biológica',
        'La riqueza personal',
        'La posición social',
      ],
      correctIndex: 0,
      explanation:
          'Un principio central retomado de la vida de Abrahán '
          '(Gálatas 3:6).',
    ),
    QuizQuestion(
      text: '¿Qué papel desempeñó la ley según Gálatas 3 y 4, mientras '
          'se esperaba a Cristo?',
      options: <String>[
        'El de un ayo que conducía a Cristo',
        'Un medio definitivo de salvación',
        'Un simple ritual sin significado',
        'Una maldición sin propósito',
      ],
      correctIndex: 0,
      explanation:
          'La ley preparaba la venida del Mesías (Gálatas 3:24).',
    ),
  ],
  'Galatians#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué fruto del espíritu destaca Gálatas 5, en contraste '
          'con las obras de la carne?',
      options: <String>[
        'Amor, gozo, paz, paciencia y otras cualidades',
        'Riqueza y poder',
        'Ambición personal',
        'Dominio sobre los demás',
      ],
      correctIndex: 0,
      explanation:
          'Una lista de cualidades cristianas esenciales '
          '(Gálatas 5:22, 23).',
    ),
    QuizQuestion(
      text: '¿Qué aconseja Gálatas 6 sobre las cargas de los demás?',
      options: <String>[
        'Llevarlas los unos de los otros',
        'Ignorarlas por completo',
        'Juzgarlas con severidad',
        'Evitarlas a toda costa',
      ],
      correctIndex: 0,
      explanation:
          'Un llamado a la ayuda mutua fraternal (Gálatas 6:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['propias', 'pecados', 'deudas'],
    ),
  ],
  'Ephesians#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Por medio de qué son salvos los cristianos según '
          'Efesios 2?',
      options: <String>[
        'Por gracia, mediante la fe, y no por las obras',
        'Únicamente por sus buenas acciones',
        'Por su origen étnico',
        'Por su riqueza material',
      ],
      correctIndex: 0,
      explanation:
          'Un principio fundamental de la salvación (Efesios 2:8, 9).',
    ),
    QuizQuestion(
      text: '¿Qué logra Cristo entre judíos y no judíos según '
          'Efesios 2?',
      options: <String>[
        'Los une en una sola humanidad nueva',
        'Mantiene una separación permanente',
        'Favorece a un grupo en perjuicio del otro',
        'Ignora esa distinción',
      ],
      correctIndex: 0,
      explanation:
          'El muro de separación es derribado (Efesios 2:14).',
    ),
  ],
  'Ephesians#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué «misterio» dice Pablo haber recibido para revelarlo '
          'a las naciones?',
      options: <String>[
        'Que los no judíos son coherederos de la promesa',
        'Un secreto reservado a unos pocos privilegiados',
        'Una enseñanza oculta sobre los ángeles',
        'Una profecía sobre Roma',
      ],
      correctIndex: 0,
      explanation:
          'Una inesperada inclusión de las naciones (Efesios 3:6).',
    ),
    QuizQuestion(
      text: '¿Qué deben «vestirse» los cristianos según Efesios 4?',
      options: <String>[
        'La nueva personalidad, semejante a Dios',
        'Ropas suntuosas',
        'Una riqueza visible',
        'Un estatus social superior',
      ],
      correctIndex: 0,
      explanation:
          'Se pide un profundo cambio interior (Efesios 4:24).',
    ),
  ],
  'Ephesians#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Con qué compara Pablo la relación entre el esposo y su '
          'esposa en Efesios 5?',
      options: <String>[
        'Con la relación entre Cristo y la congregación',
        'Con una simple asociación comercial',
        'Con una jerarquía sin amor',
        'Con una competencia permanente',
      ],
      correctIndex: 0,
      explanation:
          'Se propone un modelo de amor abnegado (Efesios 5:25).',
    ),
    QuizQuestion(
      text: '¿Qué representa «toda la armadura de Dios» en Efesios 6?',
      options: <String>[
        'Cualidades espirituales para resistir el combate espiritual',
        'Un equipo militar literal',
        'Una simple metáfora sin aplicación',
        'Un uniforme religioso',
      ],
      correctIndex: 0,
      explanation:
          'Cada pieza simboliza una cualidad protectora '
          '(Efesios 6:11-17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['armadura', 'escudo', 'espada'],
    ),
  ],
  'Philippians#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo percibe Pablo su encarcelamiento en esta carta?',
      options: <String>[
        'Se alegra, porque sirve para el avance del Evangelio',
        'Está totalmente desesperado por ello',
        'Abandona su ministerio',
        'Acusa a sus carceleros sin esperanza',
      ],
      correctIndex: 0,
      explanation:
          'Una actitud positiva a pesar de la prueba (Filipenses 1).',
    ),
    QuizQuestion(
      text: '¿Qué famosa declaración resume la perspectiva de Pablo '
          'sobre la vida y la muerte?',
      options: <String>[
        '"Para mí, el vivir es Cristo, y el morir, una ganancia"',
        '"La vida no tiene ningún sentido"',
        '"Mejor es huir de toda prueba"',
        '"La muerte debe evitarse a toda costa"',
      ],
      correctIndex: 0,
      explanation:
          'Una confianza total en Cristo (Filipenses 1:21).',
    ),
  ],
  'Philippians#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué ejemplo de humildad propone Pablo en Filipenses 2?',
      options: <String>[
        'Cristo, quien se rebajó hasta hacerse esclavo',
        'Un rey poderoso y glorioso',
        'Un filósofo célebre',
        'Un general victorioso',
      ],
      correctIndex: 0,
      explanation:
          'Un modelo de humildad extrema (Filipenses 2:5-8).',
    ),
    QuizQuestion(
      text: '¿Qué dice Pablo haber abandonado para ganar a Cristo en '
          'Filipenses 3?',
      options: <String>[
        'Todas sus ventajas y logros pasados',
        'Nada en particular',
        'Únicamente su nacionalidad',
        'Su vida de oración',
      ],
      correctIndex: 0,
      explanation:
          'Considera todo como pérdida frente a Cristo '
          '(Filipenses 3:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Cristo', 'justicia', 'ley'],
    ),
  ],
  'Philippians#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Qué promete Filipenses 4 a quienes oran sin ansiedad?',
      options: <String>[
        'La paz de Dios que sobrepasa todo pensamiento',
        'Una riqueza inmediata',
        'La ausencia total de problemas',
        'Nada en particular',
      ],
      correctIndex: 0,
      explanation:
          'Una promesa de paz interior (Filipenses 4:6, 7).',
    ),
    QuizQuestion(
      text: '¿Qué afirmación de confianza hace Pablo sobre su fuerza '
          'personal?',
      options: <String>[
        '"Para todo tengo fuerzas por medio de aquel que me da poder"',
        '"Lo logro solo, sin ninguna ayuda"',
        '"Dependo únicamente de los hombres"',
        '"Nada me sostiene realmente"',
      ],
      correctIndex: 0,
      explanation:
          'Una confianza depositada en Cristo (Filipenses 4:13).',
    ),
  ],
  'Colossians#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo describe Colosenses 1 la posición de Cristo con '
          'respecto a la creación?',
      options: <String>[
        'Todo fue creado por medio de él y para él',
        'Es una criatura más entre otras, sin distinción',
        'No tiene ningún papel en la creación',
        'Es posterior a toda la creación',
      ],
      correctIndex: 0,
      explanation:
          'Se otorga un lugar central a Cristo (Colosenses 1:16).',
    ),
    QuizQuestion(
      text: '¿Qué «misterio» dice Pablo tener la misión de revelar?',
      options: <String>[
        'Cristo en ustedes, la esperanza de la gloria',
        'Una enseñanza reservada en secreto a unos pocos',
        'Una profecía sobre Roma',
        'Un ritual oculto del templo',
      ],
      correctIndex: 0,
      explanation:
          'Una verdad ahora dada a conocer públicamente '
          '(Colosenses 1:27).',
    ),
  ],
  'Colossians#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Contra qué advierte Pablo en Colosenses 2?',
      options: <String>[
        'La filosofía vacía y las tradiciones humanas',
        'La oración misma',
        'La fe verdadera',
        'La enseñanza de los apóstoles',
      ],
      correctIndex: 0,
      explanation:
          'Una advertencia contra las falsas doctrinas '
          '(Colosenses 2:8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['circuncisión', 'ángeles', 'sombras'],
    ),
    QuizQuestion(
      text: '¿Qué deben «vestirse» los cristianos según Colosenses 3?',
      options: <String>[
        'La nueva personalidad, con compasión y amor',
        'Ropas costosas',
        'Una actitud de superioridad',
        'Nada en particular',
      ],
      correctIndex: 0,
      explanation:
          'Se pide un cambio interior concreto (Colosenses 3:10, 12).',
    ),
  ],
  'Colossians#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo anima Pablo a comportarse con las personas ajenas a '
          'la fe?',
      options: <String>[
        'Con sabiduría, aprovechando bien el tiempo',
        'Con total indiferencia',
        'Evitándolas de manera sistemática',
        'Con desprecio abierto',
      ],
      correctIndex: 0,
      explanation:
          'Se recomienda un comportamiento prudente (Colosenses 4:5).',
    ),
    QuizQuestion(
      text: '¿Qué tono caracteriza el final de la carta a los '
          'Colosenses?',
      options: <String>[
        'Saludos personales cálidos',
        'Un juicio severo',
        'Una lista de leyes adicionales',
        'Un silencio abrupto',
      ],
      correctIndex: 0,
      explanation:
          'Pablo termina con saludos afectuosos (Colosenses 4).',
    ),
  ],
  '1 Thessalonians#0': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo describe Pablo la fe de los tesalonicenses?',
      options: <String>[
        'Un ejemplo para los creyentes de los alrededores',
        'Débil y vacilante',
        'Inexistente al principio',
        'Basada únicamente en el temor',
      ],
      correctIndex: 0,
      explanation:
          'Su fe se convirtió en un modelo reconocido '
          '(1 Tesalonicenses 1).',
    ),
    QuizQuestion(
      text: '¿Cómo describe Pablo su ministerio entre ellos?',
      options: <String>[
        'Sincero, como una madre que cuida de sus hijos',
        'Interesado y calculador',
        'Distante y frío',
        'Basado en la adulación',
      ],
      correctIndex: 0,
      explanation:
          'Una imagen tierna de su dedicación '
          '(1 Tesalonicenses 2:7).',
    ),
  ],
  '1 Thessalonians#1': <QuizQuestion>[
    QuizQuestion(
      text: '¿Por qué envió Pablo a Timoteo a los tesalonicenses?',
      options: <String>[
        'Para afianzar su fe frente a las pruebas',
        'Para recaudar dinero únicamente',
        'Para reprenderlos con severidad',
        'Para poner fin a la congregación',
      ],
      correctIndex: 0,
      explanation:
          'Una preocupación pastoral motiva este envío '
          '(1 Tesalonicenses 3).',
    ),
    QuizQuestion(
      text: '¿Qué sentimiento expresa Pablo al saber de su fidelidad '
          'constante?',
      options: <String>['Una gran alegría', 'Decepción', 'Indiferencia', 'Enojo'],
      correctIndex: 0,
      explanation:
          'Su constancia lo reconforta profundamente '
          '(1 Tesalonicenses 3:8, 9).',
    ),
  ],
  '1 Thessalonians#2': <QuizQuestion>[
    QuizQuestion(
      text: '¿Cómo describe 1 Tesalonicenses 4 la resurrección de los '
          'creyentes?',
      options: <String>[
        'Serán arrebatados para encontrarse con el Señor',
        'Permanecerán en la tumba para siempre',
        'No se menciona ninguna resurrección',
        'Solo unos pocos privilegiados resucitarán',
      ],
      correctIndex: 0,
      explanation:
          'Una esperanza central para los creyentes '
          '(1 Tesalonicenses 4:17).',
    ),
    QuizQuestion(
      text: '¿Con qué se compara el día de Jehová en '
          '1 Tesalonicenses 5?',
      options: <String>['Con un ladrón en la noche', 'Con una fiesta previsible', 'Con un día ordinario', 'Con una simple advertencia sin efecto'],
      correctIndex: 0,
      explanation:
          'Una imagen de llegada repentina e inesperada '
          '(1 Tesalonicenses 5:2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['esposo', 'siervo', 'trompeta'],
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesEsC6 = <String, List<QuizQuestion>>{};
