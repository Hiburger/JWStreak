import 'package:flutter/widgets.dart';

import 'bible_data.dart';
import 'l10n/app_localizations.dart';
import 'quiz_data_en.dart';
import 'quiz_data_es.dart';
import 'quiz_data_it.dart';
import 'quiz_data_pt.dart';
import 'quiz_data_ru.dart';
import 'quiz_data_zh.dart';

/// A single multiple-choice question.
class QuizQuestion {
  const QuizQuestion({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String text;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}

/// A checkpoint reached at the end of a book segment. Always carries a
/// reflection [prompt]; [questions] is empty when no quiz has been authored yet.
class Checkpoint {
  const Checkpoint({
    required this.id,
    required this.bookId,
    required this.index,
    required this.fromChapter,
    required this.afterChapter,
    required this.questions,
  });

  final String id; // "bookId#index", stable key for DB rows
  final String bookId;
  final int index;
  final int fromChapter; // first chapter of this segment
  final int afterChapter; // last chapter of this segment
  final List<QuizQuestion> questions;

  bool get hasQuiz => questions.isNotEmpty;
}

/// Localized "BookName X-Y" (or "BookName X" for a single-chapter segment)
/// title for [cp], displayed in place of the (removed) authoring-language
/// title field.
String localizedCheckpointTitle(BuildContext context, Checkpoint cp) {
  final BibleBook book = bibleBookById(cp.bookId)!;
  final String name = localizedBookName(context, book);
  return cp.fromChapter == cp.afterChapter
      ? '$name ${cp.afterChapter}'
      : '$name ${cp.fromChapter}-${cp.afterChapter}';
}

/// One of 8 rotating reflection prompts, translated into the current UI
/// language, picked by [cp.index] the same way as the (removed) authoring-
/// language prompt field.
String localizedReflectionPrompt(BuildContext context, Checkpoint cp) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  final List<String> prompts = <String>[
    l10n.reflectionPrompt0,
    l10n.reflectionPrompt1,
    l10n.reflectionPrompt2,
    l10n.reflectionPrompt3,
    l10n.reflectionPrompt4,
    l10n.reflectionPrompt5,
    l10n.reflectionPrompt6,
    l10n.reflectionPrompt7,
  ];
  return prompts[cp.index % prompts.length];
}

/// Number of checkpoints for a book, scaled by its length.
int _checkpointCount(int chapters) {
  if (chapters <= 2) {
    return 1;
  }
  final int scaled = (chapters / 8).ceil();
  return scaled.clamp(3, 8);
}

/// Authored quizzes, keyed by checkpoint id (`bookId#index`).
const Map<String, List<QuizQuestion>> _authoredQuizzes =
    <String, List<QuizQuestion>>{
      'Genesis#0': <QuizQuestion>[
        QuizQuestion(
          text: 'En combien de jours de création la Bible décrit-elle '
              'l’œuvre de Dieu ?',
          options: <String>['Six jours', 'Sept jours', 'Trois jours', 'Quarante jours'],
          correctIndex: 0,
          explanation:
              'La Genèse décrit six jours de création ; Dieu se repose le '
              'septième (Genèse 1 et 2).',
        ),
        QuizQuestion(
          text: 'Qui furent le premier homme et la première femme ?',
          options: <String>['Adam et Ève', 'Caïn et Abel', 'Noé et sa femme', 'Abraham et Sara'],
          correctIndex: 0,
          explanation: 'Adam et Ève sont les premiers humains (Genèse 2).',
        ),
        QuizQuestion(
          text: 'Qui a tué son frère Abel ?',
          options: <String>['Caïn', 'Seth', 'Noé', 'Cham'],
          correctIndex: 0,
          explanation: 'Caïn tue son frère Abel par jalousie (Genèse 4).',
        ),
        QuizQuestion(
          text: 'Pourquoi Dieu a-t-il amené le Déluge ?',
          options: <String>[
            'À cause de la méchanceté des hommes',
            'À cause d’une sécheresse',
            'Pour agrandir les mers',
            'Sans raison donnée',
          ],
          correctIndex: 0,
          explanation:
              'La méchanceté des humains était grande sur la terre '
              '(Genèse 6).',
        ),
      ],
      'Genesis#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel signe Dieu a-t-il donné comme promesse de ne plus '
              'détruire la terre par un déluge ?',
          options: <String>['L’arc-en-ciel', 'Une étoile', 'Un olivier', 'Le tonnerre'],
          correctIndex: 0,
          explanation:
              'L’arc-en-ciel est le signe de l’alliance (Genèse 9).',
        ),
        QuizQuestion(
          text: 'Comment s’appelait la tour que les hommes ont voulu '
              'construire ?',
          options: <String>['La tour de Babel', 'La tour de Sion', 'La tour de David', 'La tour d’Our'],
          correctIndex: 0,
          explanation:
              'À Babel, Dieu confond leur langage (Genèse 11).',
        ),
        QuizQuestion(
          text: 'Qui Dieu a-t-il appelé à quitter Our ?',
          options: <String>['Abram (Abraham)', 'Lot', 'Isaac', 'Jacob'],
          correctIndex: 0,
          explanation:
              'Dieu appelle Abram et lui fait des promesses (Genèse 12).',
        ),
      ],
      'Exodus#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi les Égyptiens ont-ils réduit les Israélites en '
              'esclavage ?',
          options: <String>[
            'Ils craignaient qu’ils deviennent trop nombreux',
            'Ils voulaient leurs terres',
            'Une dette impayée',
            'Une guerre perdue',
          ],
          correctIndex: 0,
          explanation:
              'Un nouveau roi craint la multiplication des Israélites '
              '(Exode 1).',
        ),
        QuizQuestion(
          text: 'Dans quoi la mère de Moïse l’a-t-elle caché bébé ?',
          options: <String>[
            'Un panier en jonc sur le Nil',
            'Une grotte',
            'Une tente',
            'Un puits',
          ],
          correctIndex: 0,
          explanation:
              'Moïse est déposé dans un panier en jonc parmi les roseaux '
              '(Exode 2).',
        ),
        QuizQuestion(
          text: 'Comment Dieu est-il apparu à Moïse au mont Horeb ?',
          options: <String>[
            'Un buisson en feu qui ne se consume pas',
            'Une colonne de nuée',
            'Un ange visible',
            'Un tremblement de terre',
          ],
          correctIndex: 0,
          explanation:
              'Dieu parle à Moïse depuis un buisson ardent (Exode 3).',
        ),
      ],
      'Exodus#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle fête Dieu institue-t-il avant de faire sortir '
              'Israël d’Égypte ?',
          options: <String>['La Pâque', 'La Pentecôte', 'Les Tabernacles', 'Le Sabbat'],
          correctIndex: 0,
          explanation:
              'La Pâque commémore la protection des Israélites lors de la '
              'dernière plaie (Exode 12).',
        ),
        QuizQuestion(
          text: 'Comment Dieu a-t-il ouvert un passage pour Israël ?',
          options: <String>[
            'En séparant les eaux de la mer Rouge',
            'En asséchant le Jourdain',
            'En creusant un tunnel',
            'En envoyant un pont de pierre',
          ],
          correctIndex: 0,
          explanation:
              'La mer Rouge se sépare pour laisser passer Israël (Exode 14).',
        ),
        QuizQuestion(
          text: 'Quelle nourriture Dieu a-t-il fait tomber du ciel dans le '
              'désert ?',
          options: <String>['La manne', 'Du pain d’orge', 'Des figues', 'Du miel'],
          correctIndex: 0,
          explanation: 'La manne apparaît chaque matin (Exode 16).',
        ),
      ],
      'Exodus#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui a conseillé à Moïse de déléguer la résolution des '
              'litiges ?',
          options: <String>['Jéthro, son beau-père', 'Aaron', 'Josué', 'Miriam'],
          correctIndex: 0,
          explanation:
              'Jéthro suggère de nommer des chefs pour juger les affaires '
              'courantes (Exode 18).',
        ),
        QuizQuestion(
          text: 'Où Dieu a-t-il donné les Dix Commandements ?',
          options: <String>['Au mont Sinaï', 'Au mont Nébo', 'À Cadès', 'À Béthel'],
          correctIndex: 0,
          explanation: 'La loi est donnée au mont Sinaï (Exode 19-20).',
        ),
        QuizQuestion(
          text: 'Quel commandement interdit de désirer les biens d’autrui ?',
          options: <String>[
            'Le dixième (« Tu ne convoiteras pas »)',
            'Le premier',
            'Le cinquième',
            'Le septième',
          ],
          correctIndex: 0,
          explanation:
              'Le dixième commandement interdit la convoitise (Exode 20:17).',
        ),
      ],
      'Exodus#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Que fallait-il construire selon les instructions divines '
              'données à Moïse ?',
          options: <String>['Le tabernacle', 'Un palais', 'Un mur', 'Un temple en pierre'],
          correctIndex: 0,
          explanation:
              'Dieu donne des plans détaillés pour le tabernacle (Exode 25).',
        ),
        QuizQuestion(
          text: 'Qu’a fabriqué le peuple pendant l’absence de Moïse sur la '
              'montagne ?',
          options: <String>['Un veau d’or', 'Une statue de pierre', 'Un autel de bois', 'Un temple'],
          correctIndex: 0,
          explanation:
              'Le peuple façonne un veau d’or et l’adore (Exode 32).',
        ),
      ],
      'Exodus#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’est-ce qui recouvrait le tabernacle une fois achevé, '
              'signe de la présence de Dieu ?',
          options: <String>['Une nuée', 'Un feu visible en plein jour', 'Un arc-en-ciel', 'Une étoile'],
          correctIndex: 0,
          explanation:
              'La nuée couvre la tente de réunion et la gloire de Jéhovah '
              'la remplit (Exode 40).',
        ),
        QuizQuestion(
          text: 'Qui a fini par tailler de nouvelles tables de pierre après '
              'que Moïse a brisé les premières ?',
          options: <String>['Moïse, sur ordre de Dieu', 'Aaron', 'Josué', 'Betsaléel'],
          correctIndex: 0,
          explanation:
              'Dieu ordonne à Moïse de tailler deux nouvelles tables '
              '(Exode 34).',
        ),
      ],
      'Matthew#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui a annoncé la venue de Jésus en prêchant dans le '
              'désert ?',
          options: <String>['Jean le Baptiste', 'Élie', 'Ésaïe', 'Zacharie'],
          correctIndex: 0,
          explanation:
              'Jean le Baptiste prépare le chemin de Jésus (Matthieu 3).',
        ),
        QuizQuestion(
          text: 'Combien de temps Jésus a-t-il jeûné avant d’être tenté par '
              'le Diable ?',
          options: <String>['40 jours', '7 jours', '3 jours', '100 jours'],
          correctIndex: 0,
          explanation:
              'Jésus jeûne 40 jours et 40 nuits (Matthieu 4).',
        ),
        QuizQuestion(
          text: 'Selon le Sermon sur la montagne, qui est déclaré heureux ?',
          options: <String>[
            'Ceux qui ont conscience de leur pauvreté spirituelle',
            'Les riches',
            'Les puissants',
            'Les célèbres',
          ],
          correctIndex: 0,
          explanation:
              'Les Béatitudes commencent par les pauvres en esprit '
              '(Matthieu 5:3).',
        ),
      ],
      'Matthew#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Combien de pains et de poissons Jésus a-t-il utilisés pour '
              'nourrir environ 5 000 hommes ?',
          options: <String>['5 pains et 2 poissons', '2 pains et 5 poissons', '7 pains', '12 pains'],
          correctIndex: 0,
          explanation:
              'Jésus multiplie 5 pains et 2 poissons (Matthieu 14).',
        ),
        QuizQuestion(
          text: 'Qu’a fait Pierre en voyant Jésus marcher sur l’eau ?',
          options: <String>[
            'Il a essayé de marcher sur l’eau aussi',
            'Il s’est caché',
            'Il a fui',
            'Il n’a rien fait',
          ],
          correctIndex: 0,
          explanation:
              'Pierre marche vers Jésus mais commence à s’enfoncer par '
              'manque de foi (Matthieu 14).',
        ),
        QuizQuestion(
          text: 'Qui a demandé la tête de Jean le Baptiste sur un plat ?',
          options: <String>['La fille d’Hérodiade', 'Hérode lui-même', 'Un soldat', 'Pilate'],
          correctIndex: 0,
          explanation:
              'La danseuse, à l’instigation de sa mère, réclame la tête de '
              'Jean (Matthieu 14).',
        ),
      ],
      'Matthew#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Pierre a-t-il répondu quand Jésus a demandé « Qui '
              'dites-vous que je suis ? » ?',
          options: <String>[
            'Tu es le Christ, le Fils du Dieu vivant',
            'Tu es Élie',
            'Tu es un prophète',
            'Je ne sais pas',
          ],
          correctIndex: 0,
          explanation: 'Pierre reconnaît Jésus comme le Christ (Matthieu 16).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé lors de la transfiguration ?',
          options: <String>[
            'Le visage de Jésus a brillé comme le soleil',
            'Jésus a disparu',
            'Une tempête s’est levée',
            'Jésus a marché sur l’eau',
          ],
          correctIndex: 0,
          explanation:
              'Jésus est transfiguré devant Pierre, Jacques et Jean '
              '(Matthieu 17).',
        ),
        QuizQuestion(
          text: 'Sur quel animal Jésus est-il entré à Jérusalem ?',
          options: <String>['Un ânon', 'Un cheval blanc', 'Un chameau', 'À pied'],
          correctIndex: 0,
          explanation:
              'Jésus entre monté sur un ânon, selon la prophétie '
              '(Matthieu 21).',
        ),
      ],
      'Matthew#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’a institué Jésus lors de son dernier repas avec ses '
              'apôtres ?',
          options: <String>[
            'Le repas du souvenir de sa mort',
            'Une fête annuelle de la moisson',
            'Un jeûne collectif',
            'Un pèlerinage',
          ],
          correctIndex: 0,
          explanation:
              'Jésus institue le repas commémoratif avec le pain et le vin '
              '(Matthieu 26).',
        ),
        QuizQuestion(
          text: 'Qui a livré Jésus pour trente pièces d’argent ?',
          options: <String>['Judas Iscariote', 'Pierre', 'Thomas', 'Barabbas'],
          correctIndex: 0,
          explanation: 'Judas trahit Jésus (Matthieu 26).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé le troisième jour après la mort de '
              'Jésus ?',
          options: <String>[
            'Il est ressuscité',
            'Le temple a été détruit',
            'Il est monté au ciel',
            'Rien de particulier',
          ],
          correctIndex: 0,
          explanation: 'Jésus ressuscite le troisième jour (Matthieu 28).',
        ),
      ],
      'John#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Selon Jean 1, qui était « la Parole » (le Logos) auprès de '
              'Dieu au commencement ?',
          options: <String>[
            'Le Fils de Dieu, avant de devenir humain',
            'Un ange',
            'Moïse',
            'Le Saint-Esprit'],
          correctIndex: 0,
          explanation:
              'La Parole était auprès de Dieu et devient chair en Jésus '
              '(Jean 1).',
        ),
        QuizQuestion(
          text: 'Quel a été le premier miracle de Jésus, à Cana ?',
          options: <String>[
            'Changer l’eau en vin',
            'Guérir un aveugle',
            'Nourrir une foule',
            'Calmer une tempête',
          ],
          correctIndex: 0,
          explanation:
              'Jésus change l’eau en vin lors d’un mariage (Jean 2).',
        ),
        QuizQuestion(
          text: 'Que doit faire, selon Jésus, une personne pour « voir le '
              'royaume de Dieu » ?',
          options: <String>['Naître de nouveau', 'Jeûner 40 jours', 'Aller au temple', 'Devenir prêtre'],
          correctIndex: 0,
          explanation:
              'Jésus l’explique à Nicodème (Jean 3).',
        ),
      ],
      'John#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Jésus se décrit-il en Jean 10 ?',
          options: <String>['Le bon berger', 'Le lion', 'Le grand prêtre', 'Le juge'],
          correctIndex: 0,
          explanation:
              'Jésus se présente comme le bon berger qui donne sa vie pour '
              'ses brebis (Jean 10).',
        ),
        QuizQuestion(
          text: 'Qui Jésus a-t-il ramené à la vie après quatre jours dans '
              'le tombeau ?',
          options: <String>['Lazare', 'Jaïrus', 'Le fils de la veuve', 'Un centurion'],
          correctIndex: 0,
          explanation: 'Jésus ressuscite Lazare (Jean 11).',
        ),
        QuizQuestion(
          text: 'Qu’a fait Jésus pour ses apôtres avant le dernier repas, '
              'en exemple d’humilité ?',
          options: <String>[
            'Il leur a lavé les pieds',
            'Il les a bénis un par un',
            'Il a partagé ses biens',
            'Il a prié pour chacun d’eux publiquement',
          ],
          correctIndex: 0,
          explanation: 'Jésus lave les pieds de ses disciples (Jean 13).',
        ),
      ],
      'John#2': <QuizQuestion>[
        QuizQuestion(
          text: 'À quoi Jésus compare-t-il sa relation avec ses disciples '
              'en Jean 15 ?',
          options: <String>['Un cep et ses sarments', 'Un berger et son troupeau', 'Un roi et ses sujets', 'Un père et ses enfants'],
          correctIndex: 0,
          explanation: 'Jésus est le cep, ses disciples les sarments (Jean 15).',
        ),
        QuizQuestion(
          text: 'Qui a coupé l’oreille d’un homme lors de l’arrestation de '
              'Jésus ?',
          options: <String>['Pierre', 'Jean', 'Jacques', 'André'],
          correctIndex: 0,
          explanation: 'Pierre frappe Malchus avec une épée (Jean 18).',
        ),
        QuizQuestion(
          text: 'Qui a d’abord douté de la résurrection avant de toucher '
              'les blessures de Jésus ?',
          options: <String>['Thomas', 'Pierre', 'Jean', 'Philippe'],
          correctIndex: 0,
          explanation: 'Thomas doute puis croit (Jean 20).',
        ),
      ],
      'Leviticus#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel type de sacrifice était entièrement brûlé sur l’autel ?',
          options: <String>[
            'L’holocauste',
            'L’offrande de communion',
            'L’offrande de céréales',
            'L’offrande pour le péché',
          ],
          correctIndex: 0,
          explanation:
              'L’holocauste est intégralement consumé sur l’autel '
              '(Lévitique 1).',
        ),
        QuizQuestion(
          text: 'Combien de sortes d’offrandes principales sont décrites '
              'dans ces premiers chapitres ?',
          options: <String>['Cinq', 'Deux', 'Dix', 'Trois'],
          correctIndex: 0,
          explanation:
              'Holocauste, offrande de céréales, de communion, pour le '
              'péché et de culpabilité (Lévitique 1-7).',
        ),
        QuizQuestion(
          text: 'Qui devait apporter les offrandes à l’entrée de la tente '
              'de réunion ?',
          options: <String>[
            'La personne elle-même, avec l’aide des prêtres',
            'Seulement les prêtres',
            'Seulement les anciens',
            'Un envoyé du roi',
          ],
          correctIndex: 0,
          explanation:
              'L’offrant amène lui-même son animal, les prêtres officient '
              '(Lévitique 1-7).',
        ),
      ],
      'Leviticus#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Nadab et Abihou sont-ils morts ?',
          options: <String>[
            'Ils ont offert un feu non autorisé devant Jéhovah',
            'Ils ont désobéi à Moïse',
            'Ils ont mangé un aliment impur',
            'Ils ont refusé de servir',
          ],
          correctIndex: 0,
          explanation:
              'Les fils d’Aaron offrent un « feu étranger » et meurent '
              '(Lévitique 10).',
        ),
        QuizQuestion(
          text: 'Quel critère rendait un animal terrestre pur à manger ?',
          options: <String>[
            'Sabot fendu et rumination',
            'Vivre uniquement dans le désert',
            'Être domestiqué',
            'Avoir des plumes',
          ],
          correctIndex: 0,
          explanation:
              'Les animaux purs ruminent et ont le sabot fendu '
              '(Lévitique 11).',
        ),
        QuizQuestion(
          text: 'Quelle affection cutanée est examinée en détail par les '
              'prêtres dans ces chapitres ?',
          options: <String>['La lèpre', 'La variole', 'Les brûlures seules', 'L’acné'],
          correctIndex: 0,
          explanation:
              'Les prêtres examinent les signes de lèpre sur la peau, les '
              'vêtements et les maisons (Lévitique 13-14).',
        ),
      ],
      'Leviticus#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Une fois par an, quel jour solennel les péchés de la '
              'nation étaient-ils couverts ?',
          options: <String>[
            'Le jour des Propitiations (Yom Kippour)',
            'La Pâque',
            'Le Sabbat',
            'La Pentecôte',
          ],
          correctIndex: 0,
          explanation:
              'Le grand prêtre fait propitiation pour la nation une fois '
              'l’an (Lévitique 16).',
        ),
        QuizQuestion(
          text: 'Quel commandement bien connu apparaît dans le « code de '
              'sainteté » de Lévitique 19 ?',
          options: <String>[
            'Aime ton prochain comme toi-même',
            'Ne vole pas de bétail',
            'Repose-toi sept ans',
            'Honore le roi',
          ],
          correctIndex: 0,
          explanation:
              'Lévitique 19:18 est cité plus tard par Jésus lui-même.',
        ),
        QuizQuestion(
          text: 'Que devait-on éviter selon Lévitique 17 concernant la '
              'nourriture ?',
          options: <String>[
            'Consommer du sang',
            'Manger la nuit',
            'Manger seul',
            'Manger du pain',
          ],
          correctIndex: 0,
          explanation:
              'La consommation de sang est interdite (Lévitique 17).',
        ),
      ],
      'Leviticus#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelles fêtes annuelles sont énumérées en Lévitique 23 ?',
          options: <String>[
            'Pâque, Pentecôte, Trompettes, Propitiations, Tabernacles',
            'Seulement la Pâque',
            'Le Nouvel An et rien d’autre',
            'Uniquement des jeûnes',
          ],
          correctIndex: 0,
          explanation:
              'Le calendrier des fêtes couvre toute l’année religieuse '
              '(Lévitique 23).',
        ),
        QuizQuestion(
          text: 'Que devait-on faire tous les 50 ans, lors du Jubilé ?',
          options: <String>[
            'Rendre les terres et libérer les esclaves hébreux',
            'Détruire les récoltes',
            'Élire un nouveau grand prêtre',
            'Réviser la loi',
          ],
          correctIndex: 0,
          explanation:
              'L’année du Jubilé restaure les terres et les libertés '
              '(Lévitique 25).',
        ),
        QuizQuestion(
          text: 'Que promet Lévitique 26 en cas de fidélité à l’alliance ?',
          options: <String>[
            'Des bénédictions ; la désobéissance entraîne des malheurs',
            'Rien de particulier',
            'Une richesse immédiate sans condition',
            'La guerre systématique',
          ],
          correctIndex: 0,
          explanation:
              'Bénédictions et malédictions conditionnelles sont détaillées '
              '(Lévitique 26).',
        ),
      ],
      'Numbers#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Israël a-t-il fait un recensement au désert du '
              'Sinaï ?',
          options: <String>[
            'Pour dénombrer les hommes aptes à la guerre',
            'Pour taxer chaque famille',
            'Pour choisir un roi',
            'Pour répartir des terres',
          ],
          correctIndex: 0,
          explanation:
              'Le recensement dénombre les hommes de 20 ans et plus aptes '
              'à combattre (Nombres 1).',
        ),
        QuizQuestion(
          text: 'Qui était chargé du transport et du service du '
              'tabernacle ?',
          options: <String>['Les Lévites', 'Les prêtres seuls', 'Les anciens', 'Les guerriers'],
          correctIndex: 0,
          explanation:
              'Les Lévites reçoivent des tâches précises pour le '
              'tabernacle (Nombres 3-4).',
        ),
        QuizQuestion(
          text: 'Que devait faire une personne ayant fait le vœu de '
              'naziréat ?',
          options: <String>[
            'S’abstenir de vin et ne pas se couper les cheveux',
            'Jeûner 40 jours',
            'Vivre seule au désert',
            'Offrir tout son bétail',
          ],
          correctIndex: 0,
          explanation:
              'Le vœu de naziréat impose des restrictions particulières '
              '(Nombres 6).',
        ),
      ],
      'Numbers#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui Dieu a-t-il chargé d’aider Moïse à porter le fardeau '
              'du peuple ?',
          options: <String>[
            '70 anciens',
            'Les 12 espions',
            'Aaron seul',
            'Josué seul',
          ],
          correctIndex: 0,
          explanation:
              '70 anciens reçoivent l’esprit pour partager la '
              'responsabilité (Nombres 11).',
        ),
        QuizQuestion(
          text: 'Que sont devenus Miriam et Aaron après avoir critiqué '
              'Moïse ?',
          options: <String>[
            'Miriam a été frappée de lèpre',
            'Ils ont été bannis définitivement',
            'Rien ne leur est arrivé',
            'Ils ont perdu leur voix',
          ],
          correctIndex: 0,
          explanation: 'Miriam devient lépreuse sept jours (Nombres 12).',
        ),
        QuizQuestion(
          text: 'Combien d’espions ont donné un rapport encourageant sur '
              'Canaan ?',
          options: <String>['Deux (Josué et Caleb)', 'Douze', 'Aucun', 'Cinq'],
          correctIndex: 0,
          explanation:
              'Seuls Josué et Caleb encouragent le peuple à entrer '
              '(Nombres 13-14).',
        ),
      ],
      'Numbers#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui s’est révolté contre l’autorité de Moïse et Aaron ?',
          options: <String>['Koré et ses partisans', 'Josué', 'Caleb', 'Balaam'],
          correctIndex: 0,
          explanation:
              'La rébellion de Koré est engloutie par la terre '
              '(Nombres 16).',
        ),
        QuizQuestion(
          text: 'Quel signe a confirmé le choix d’Aaron comme grand '
              'prêtre ?',
          options: <String>[
            'Son bâton a fleuri',
            'Une voix céleste',
            'Un feu sur l’autel',
            'Une étoile',
          ],
          correctIndex: 0,
          explanation: 'Le bâton d’Aaron bourgeonne et fleurit (Nombres 17).',
        ),
        QuizQuestion(
          text: 'Pourquoi Moïse n’a-t-il pas pu entrer dans la Terre '
              'promise ?',
          options: <String>[
            'Il a frappé le rocher au lieu de lui parler',
            'Il a désobéi à un ordre de guerre',
            'Il a adoré une idole',
            'Il était trop âgé',
          ],
          correctIndex: 0,
          explanation:
              'Moïse frappe le rocher par colère, sans respecter la '
              'sainteté de Dieu (Nombres 20).',
        ),
      ],
      'Numbers#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui Balaq a-t-il engagé pour maudire Israël ?',
          options: <String>['Balaam', 'Koré', 'Og', 'Sihon'],
          correctIndex: 0,
          explanation:
              'Balaam est appelé à maudire Israël mais le bénit '
              '(Nombres 23-24).',
        ),
        QuizQuestion(
          text: 'Qui a agi avec zèle pour arrêter le fléau lors de '
              'l’apostasie de Baal Péor ?',
          options: <String>['Phinéas', 'Josué', 'Éléazar seul', 'Caleb'],
          correctIndex: 0,
          explanation:
              'Phinéas intervient et le fléau s’arrête (Nombres 25).',
        ),
        QuizQuestion(
          text: 'Qui Moïse a-t-il désigné comme son successeur ?',
          options: <String>['Josué', 'Caleb', 'Éléazar', 'Phinéas'],
          correctIndex: 0,
          explanation:
              'Josué est établi devant Éléazar et l’assemblée '
              '(Nombres 27).',
        ),
      ],
      'Numbers#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre quel peuple Israël a-t-il mené une guerre de '
              'jugement ?',
          options: <String>['Madian', 'Édom', 'Moab entier', 'Égypte'],
          correctIndex: 0,
          explanation: 'La guerre contre Madian est relatée (Nombres 31).',
        ),
        QuizQuestion(
          text: 'Quelles tribus ont demandé à s’installer à l’est du '
              'Jourdain ?',
          options: <String>[
            'Ruben, Gad et la moitié de Manassé',
            'Juda et Benjamin',
            'Lévi et Siméon',
            'Éphraïm seul',
          ],
          correctIndex: 0,
          explanation:
              'Ces tribus obtiennent des terres à l’est, à condition '
              'd’aider à la conquête (Nombres 32).',
        ),
        QuizQuestion(
          text: 'Que devaient être les villes de refuge ?',
          options: <String>[
            'Des lieux où fuir en cas de meurtre involontaire',
            'Des capitales régionales',
            'Des centres commerciaux',
            'Des lieux de culte uniquement',
          ],
          correctIndex: 0,
          explanation:
              'Les villes de refuge protègent celui qui a tué sans '
              'intention (Nombres 35).',
        ),
      ],
      'Deuteronomy#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel grand commandement Moïse répète-t-il en Deutéronome '
              '6, appelé le Shema ?',
          options: <String>[
            'Jéhovah est un, aime-le de tout ton cœur',
            'Ne mange pas de porc',
            'Célèbre chaque nouvelle lune',
            'Ne travaille jamais',
          ],
          correctIndex: 0,
          explanation:
              'Le Shema (Deutéronome 6:4, 5) est central dans la foi '
              'd’Israël.',
        ),
        QuizQuestion(
          text: 'Que rappelle Moïse au sujet des dix commandements dans '
              'ces chapitres ?',
          options: <String>[
            'Il les répète au peuple avant l’entrée en Canaan',
            'Il les annule',
            'Il en ajoute dix autres',
            'Il les réserve aux prêtres',
          ],
          correctIndex: 0,
          explanation:
              'Moïse redonne les dix commandements (Deutéronome 5).',
        ),
        QuizQuestion(
          text: 'Pourquoi Israël devait-il se méfier des nations de '
              'Canaan ?',
          options: <String>[
            'À cause du risque d’idolâtrie',
            'À cause de leur richesse',
            'À cause de leur langue',
            'À cause de leur roi',
          ],
          correctIndex: 0,
          explanation:
              'Le danger d’adopter leurs dieux est souligné '
              '(Deutéronome 7).',
        ),
      ],
      'Deuteronomy#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que devait rappeler à Israël le souvenir de la manne au '
              'désert ?',
          options: <String>[
            'Que l’homme ne vit pas de pain seul, mais de la parole de Dieu',
            'Que Dieu punit toujours',
            'Que le désert est maudit',
            'Que la nourriture n’a pas d’importance',
          ],
          correctIndex: 0,
          explanation: 'Deutéronome 8:3, citée plus tard par Jésus.',
        ),
        QuizQuestion(
          text: 'Quel événement du désert Moïse rappelle-t-il pour '
              'avertir contre l’orgueil ?',
          options: <String>[
            'Le veau d’or',
            'La traversée de la mer Rouge',
            'Le don de la manne',
            'La construction du tabernacle',
          ],
          correctIndex: 0,
          explanation:
              'Le veau d’or illustre la rébellion passée '
              '(Deutéronome 9).',
        ),
        QuizQuestion(
          text: 'Où les Israélites devaient-ils apporter leurs '
              'sacrifices, selon Deutéronome 12 ?',
          options: <String>[
            'Au seul lieu que Jéhovah choisirait',
            'Où ils le souhaitaient',
            'Dans chaque village',
            'Uniquement à leur domicile',
          ],
          correctIndex: 0,
          explanation:
              'Un lieu unique de culte est prescrit (Deutéronome 12).',
        ),
      ],
      'Deuteronomy#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que devait-on faire des dettes tous les sept ans ?',
          options: <String>[
            'Les annuler (année de relâche)',
            'Les doubler',
            'Les transmettre aux enfants',
            'Rien de spécial',
          ],
          correctIndex: 0,
          explanation:
              'L’année de relâche efface les dettes (Deutéronome 15).',
        ),
        QuizQuestion(
          text: 'Quel prophète futur, semblable à Moïse, est annoncé en '
              'Deutéronome 18 ?',
          options: <String>[
            'Un prophète que Dieu susciterait',
            'Un roi étranger',
            'Un ange',
            'Un juge unique',
          ],
          correctIndex: 0,
          explanation:
              'Cette prophétie est appliquée au Christ dans les Écritures '
              'grecques (Deutéronome 18).',
        ),
        QuizQuestion(
          text: 'Combien de témoins étaient nécessaires pour établir une '
              'accusation ?',
          options: <String>['Deux ou trois', 'Un seul suffisait', 'Dix', 'Aucun n’était requis'],
          correctIndex: 0,
          explanation:
              'La loi exige plusieurs témoins (Deutéronome 19).',
        ),
      ],
      'Deuteronomy#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle offrande annuelle rappelait la libération '
              'd’Égypte ?',
          options: <String>[
            'L’offrande des prémices',
            'Le sacrifice du Jubilé',
            'L’offrande de la dîme uniquement',
            'Le repas du souvenir',
          ],
          correctIndex: 0,
          explanation:
              'La déclaration des prémices rappelle la sortie d’Égypte '
              '(Deutéronome 26).',
        ),
        QuizQuestion(
          text: 'Que devaient faire les Israélites en entrant à Canaan, '
              'sur le mont Ébal ?',
          options: <String>[
            'Ériger un autel et proclamer bénédictions et malédictions',
            'Construire un palais',
            'Établir la capitale',
            'Détruire tous les arbres',
          ],
          correctIndex: 0,
          explanation:
              'La cérémonie sur les monts Guérizim/Ébal est instituée '
              '(Deutéronome 27).',
        ),
        QuizQuestion(
          text: 'Quel principe régissait les lois sur le divorce dans ces '
              'chapitres ?',
          options: <String>[
            'Un acte de divorce écrit était exigé',
            'Le divorce était interdit sous toute forme',
            'Seule la femme pouvait divorcer',
            'Aucune règle n’existait',
          ],
          correctIndex: 0,
          explanation:
              'La loi encadre le divorce par un document formel '
              '(Deutéronome 24).',
        ),
      ],
      'Deuteronomy#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Que promettent les chapitres 28 en cas de fidélité à '
              'l’alliance ?',
          options: <String>[
            'Des bénédictions ; la désobéissance entraîne des malédictions',
            'Rien de concret',
            'Une guerre immédiate',
            'La richesse sans condition',
          ],
          correctIndex: 0,
          explanation:
              'Bénédictions et malédictions détaillées (Deutéronome 28).',
        ),
        QuizQuestion(
          text: 'Quel choix Moïse présente-t-il au peuple en '
              'Deutéronome 30 ?',
          options: <String>[
            'La vie et la mort, la bénédiction et la malédiction',
            'Rester ou partir en Égypte',
            'Servir Aaron ou Josué',
            'Payer une taxe ou non',
          ],
          correctIndex: 0,
          explanation:
              'Le peuple est appelé à « choisir la vie » '
              '(Deutéronome 30:19).',
        ),
        QuizQuestion(
          text: 'Où Moïse est-il mort, sans entrer en Terre promise ?',
          options: <String>[
            'Sur le mont Nebo',
            'À Jéricho',
            'Sur le mont Sinaï',
            'À Bethléhem',
          ],
          correctIndex: 0,
          explanation:
              'Moïse contemple le pays du haut du Nebo avant de mourir '
              '(Deutéronome 34).',
        ),
      ],
      'Joshua#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle instruction Jéhovah répète-t-il à Josué au début '
              'du livre ?',
          options: <String>[
            'Sois fort et courageux',
            'Reste caché',
            'Attends dix ans',
            'Retourne en Égypte',
          ],
          correctIndex: 0,
          explanation:
              'Jéhovah encourage Josué à plusieurs reprises (Josué 1).',
        ),
        QuizQuestion(
          text: 'Qui a caché les espions israélites à Jéricho ?',
          options: <String>['Rahab', 'Une prophétesse', 'Le roi lui-même', 'Personne'],
          correctIndex: 0,
          explanation: 'Rahab cache les espions sur son toit (Josué 2).',
        ),
        QuizQuestion(
          text: 'Comment les murailles de Jéricho sont-elles tombées ?',
          options: <String>[
            'Après une procession et le son des trompettes',
            'Par un tremblement de terre naturel',
            'Par un siège de plusieurs mois',
            'Par la trahison d’un habitant',
          ],
          correctIndex: 0,
          explanation:
              'Après sept tours et le son des trompettes, les murs '
              'tombent (Josué 6).',
        ),
      ],
      'Joshua#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment les Gabaonites ont-ils évité la destruction ?',
          options: <String>[
            'En se faisant passer pour des voyageurs venus de loin',
            'En attaquant les premiers',
            'En payant un tribut immédiat',
            'En se convertissant publiquement',
          ],
          correctIndex: 0,
          explanation:
              'Leur ruse pousse Israël à conclure un traité de paix '
              '(Josué 9).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé d’extraordinaire lors de la bataille '
              'contre les cinq rois amorites ?',
          options: <String>[
            'Le soleil s’est arrêté',
            'Une éclipse totale',
            'Une pluie de feu',
            'Un tremblement de terre les a séparés',
          ],
          correctIndex: 0,
          explanation:
              'Jéhovah combat pour Israël et le soleil s’arrête '
              '(Josué 10).',
        ),
        QuizQuestion(
          text: 'Quelle part de terre Caleb a-t-il réclamée à 85 ans ?',
          options: <String>['Hébron', 'Jéricho', 'Silo', 'Béthel'],
          correctIndex: 0,
          explanation:
              'Caleb reste fidèle et reçoit Hébron (Josué 14).',
        ),
      ],
      'Joshua#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Où le tabernacle a-t-il été dressé après la conquête '
              'initiale ?',
          options: <String>['À Silo', 'À Jérusalem', 'À Hébron', 'À Béthel'],
          correctIndex: 0,
          explanation:
              'La tente de réunion est établie à Silo (Josué 18).',
        ),
        QuizQuestion(
          text: 'Pourquoi les tribus de l’est ont-elles élevé un autel '
              'près du Jourdain ?',
          options: <String>[
            'Comme témoignage de leur appartenance à Israël',
            'Pour déclarer leur indépendance',
            'Pour adorer un autre dieu',
            'Sur ordre d’un roi étranger',
          ],
          correctIndex: 0,
          explanation:
              'L’autel est un témoin, non un lieu de sacrifice rival '
              '(Josué 22).',
        ),
        QuizQuestion(
          text: 'Quelle déclaration célèbre Josué fait-il à Sichem avant '
              'sa mort ?',
          options: <String>[
            'Moi et ma maison, nous servirons Jéhovah',
            'Nous retournons en Égypte',
            'Un roi nous gouvernera',
            'La guerre continuera toujours',
          ],
          correctIndex: 0,
          explanation:
              'Josué appelle le peuple à choisir qui servir (Josué 24).',
        ),
      ],
      'Judges#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel cycle se répète tout au long du livre des Juges ?',
          options: <String>[
            'Infidélité, oppression, appel à Dieu, délivrance',
            'Paix perpétuelle',
            'Guerre civile continue',
            'Migration constante',
          ],
          correctIndex: 0,
          explanation:
              'Ce cycle structure tout le livre (Juges 2).',
        ),
        QuizQuestion(
          text: 'Qui a vaincu Sisera avec l’aide de Débora ?',
          options: <String>['Baraq', 'Éhud', 'Othniel', 'Guédéon'],
          correctIndex: 0,
          explanation:
              'Débora et Baraq mènent Israël à la victoire (Juges 4).',
        ),
        QuizQuestion(
          text: 'Comment Guédéon a-t-il réduit son armée à 300 hommes ?',
          options: <String>[
            'En observant comment ils buvaient de l’eau',
            'En tirant au sort',
            'En choisissant les plus jeunes',
            'En choisissant les plus riches',
          ],
          correctIndex: 0,
          explanation:
              'Le test de l’eau sélectionne 300 hommes (Juges 7).',
        ),
      ],
      'Judges#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’est-il arrivé après qu’Abimélek se soit proclamé roi ?',
          options: <String>[
            'Il a massacré ses frères puis a péri lui-même',
            'Il a régné en paix longtemps',
            'Il a été chassé sans violence',
            'Il a fondé une dynastie durable',
          ],
          correctIndex: 0,
          explanation:
              'Abimélek meurt sous une meule jetée par une femme '
              '(Juges 9).',
        ),
        QuizQuestion(
          text: 'Quel vœu tragique Jephté a-t-il fait avant la bataille ?',
          options: <String>[
            'Offrir la première personne sortant de sa maison',
            'Jeûner un an',
            'Détruire sa maison',
            'Ne jamais se marier',
          ],
          correctIndex: 0,
          explanation:
              'Sa fille sort la première à sa rencontre (Juges 11).',
        ),
        QuizQuestion(
          text: 'Comment reconnaissait-on les Éphraïmites au passage du '
              'Jourdain ?',
          options: <String>[
            'Ils ne pouvaient pas prononcer « Shibboleth » correctement',
            'À leurs vêtements',
            'À leur accent chantant',
            'À leur armement',
          ],
          correctIndex: 0,
          explanation:
              'Le mot de passe démasque les fuyards (Juges 12).',
        ),
      ],
      'Judges#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Avec quelle arme improvisée Samson a-t-il vaincu mille '
              'Philistins ?',
          options: <String>[
            'Une mâchoire d’âne',
            'Une épée',
            'Une fronde',
            'Un bâton',
          ],
          correctIndex: 0,
          explanation: 'Samson frappe avec une mâchoire d’âne (Juges 15).',
        ),
        QuizQuestion(
          text: 'Qui a livré le secret de la force de Samson aux '
              'Philistins ?',
          options: <String>['Delila', 'Sa mère', 'Un juge rival', 'Un prêtre'],
          correctIndex: 0,
          explanation:
              'Delila découvre que sa force vient de ses cheveux '
              '(Juges 16).',
        ),
        QuizQuestion(
          text: 'Quelle phrase résume l’état d’Israël à la fin du livre ?',
          options: <String>[
            'Chacun faisait ce qui était droit à ses propres yeux',
            'Un roi juste régnait',
            'La paix régnait partout',
            'Les prêtres gouvernaient bien',
          ],
          correctIndex: 0,
          explanation:
              'Cette remarque conclut plusieurs récits du livre '
              '(Juges 17, 21).',
        ),
      ],
      'Ruth#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Naomi et sa famille sont-elles parties à Moab ?',
          options: <String>[
            'À cause d’une famine à Bethléhem',
            'Pour fuir une guerre',
            'Pour affaires',
            'Sur ordre d’un juge',
          ],
          correctIndex: 0,
          explanation:
              'La famine pousse Élimélek à émigrer (Ruth 1).',
        ),
        QuizQuestion(
          text: 'Quelle décision Ruth prend-elle envers Naomi ?',
          options: <String>[
            'Rester avec elle : « où tu iras, j’irai »',
            'Retourner chez son propre peuple',
            'Se remarier immédiatement à Moab',
            'Rester seule à Moab',
          ],
          correctIndex: 0,
          explanation:
              'Ruth exprime un attachement loyal célèbre (Ruth 1:16).',
        ),
        QuizQuestion(
          text: 'Que sont devenus les maris de Naomi et de ses belles-filles ?',
          options: <String>[
            'Ils sont tous morts à Moab',
            'Ils sont retournés à Bethléhem',
            'Ils ont prospéré à Moab',
            'Ils ont fondé une ville',
          ],
          correctIndex: 0,
          explanation:
              'Élimélek, puis ses deux fils, meurent à Moab (Ruth 1).',
        ),
      ],
      'Ruth#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que faisait Ruth dans les champs de Boaz ?',
          options: <String>[
            'Elle glanait les épis laissés par les moissonneurs',
            'Elle vendait des tissus',
            'Elle gardait les troupeaux',
            'Elle enseignait la loi',
          ],
          correctIndex: 0,
          explanation:
              'Ruth glane pour nourrir Naomi et elle-même (Ruth 2).',
        ),
        QuizQuestion(
          text: 'Comment Boaz a-t-il montré de la bonté envers Ruth ?',
          options: <String>[
            'En lui permettant de glaner en sécurité et en partageant son repas',
            'En l’ignorant poliment',
            'En la renvoyant du champ',
            'En exigeant un paiement',
          ],
          correctIndex: 0,
          explanation:
              'Boaz protège Ruth et la traite avec faveur (Ruth 2).',
        ),
        QuizQuestion(
          text: 'Que conseille Naomi à Ruth au sujet de Boaz ?',
          options: <String>[
            'D’aller à l’aire de battage et de se faire connaître de lui',
            'De l’éviter complètement',
            'De partir à Moab',
            'De se marier avec un autre homme',
          ],
          correctIndex: 0,
          explanation:
              'Naomi guide Ruth vers un possible rachat (Ruth 3).',
        ),
      ],
      'Ruth#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Boaz a-t-il réglé la question du droit de rachat '
              'devant les anciens ?',
          options: <String>[
            'Un parent plus proche a renoncé à son droit publiquement',
            'Un tirage au sort a décidé',
            'Le roi a tranché',
            'Personne n’a été consulté',
          ],
          correctIndex: 0,
          explanation:
              'La procédure légale se déroule à la porte de la ville '
              '(Ruth 4).',
        ),
        QuizQuestion(
          text: 'Qui Ruth et Boaz ont-ils eu comme fils ?',
          options: <String>['Obed', 'David', 'Isaï', 'Salomon'],
          correctIndex: 0,
          explanation: 'Obed devient le grand-père de David (Ruth 4).',
        ),
        QuizQuestion(
          text: 'Pourquoi le livre de Ruth se termine-t-il avec une '
              'généalogie ?',
          options: <String>[
            'Pour relier Ruth à la lignée menant à David',
            'Par simple tradition littéraire',
            'Pour clore un débat juridique',
            'Pour honorer Moab',
          ],
          correctIndex: 0,
          explanation:
              'La généalogie relie Ruth à David (Ruth 4:17-22).',
        ),
      ],
      '1 Samuel#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’a promis Anne à Jéhovah si elle avait un fils ?',
          options: <String>[
            'Le vouer à son service toute sa vie',
            'Lui offrir la moitié de ses biens',
            'Construire un temple',
            'Devenir prêtresse elle-même',
          ],
          correctIndex: 0,
          explanation:
              'Anne voue Samuel au service du tabernacle (1 Samuel 1).',
        ),
        QuizQuestion(
          text: 'Comment Jéhovah a-t-il appelé le jeune Samuel ?',
          options: <String>[
            'En prononçant son nom la nuit, plusieurs fois',
            'Par un ange visible',
            'Par un rêve unique',
            'Par une voix publique',
          ],
          correctIndex: 0,
          explanation:
              'Samuel croit d’abord qu’Éli l’appelle (1 Samuel 3).',
        ),
        QuizQuestion(
          text: 'Pourquoi le peuple a-t-il demandé un roi à Samuel ?',
          options: <String>[
            'Pour être comme les autres nations',
            'Sur ordre direct de Jéhovah',
            'À cause d’une invasion immédiate',
            'Parce que Samuel le proposait',
          ],
          correctIndex: 0,
          explanation:
              'Le peuple rejette le gouvernement direct de Dieu '
              '(1 Samuel 8).',
        ),
      ],
      '1 Samuel#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui Samuel a-t-il oint en secret comme premier roi '
              'd’Israël ?',
          options: <String>['Saül', 'David', 'Jonathan', 'Abner'],
          correctIndex: 0,
          explanation: 'Samuel oint Saül discrètement (1 Samuel 9-10).',
        ),
        QuizQuestion(
          text: 'Pourquoi Samuel a-t-il annoncé le rejet de Saül comme '
              'roi ?',
          options: <String>[
            'Saül a offert un sacrifice sans attendre Samuel',
            'Saül a perdu une bataille',
            'Saül a refusé de régner',
            'Saül a fui devant l’ennemi',
          ],
          correctIndex: 0,
          explanation:
              'Saül désobéit en offrant lui-même le sacrifice '
              '(1 Samuel 13).',
        ),
        QuizQuestion(
          text: 'Pourquoi Saül a-t-il été définitivement rejeté comme '
              'roi par Jéhovah ?',
          options: <String>[
            'Il a désobéi en épargnant Agag et le meilleur du bétail',
            'Il a perdu une bataille mineure',
            'Il a vieilli trop vite',
            'Il a demandé de l’aide à Samuel',
          ],
          correctIndex: 0,
          explanation:
              'La désobéissance concernant Amalek scelle son rejet '
              '(1 Samuel 15).',
        ),
      ],
      '1 Samuel#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Avec quelle arme David a-t-il vaincu Goliath ?',
          options: <String>['Une fronde et une pierre', 'Une épée', 'Une lance', 'Ses mains nues'],
          correctIndex: 0,
          explanation:
              'David refuse l’armure et utilise sa fronde '
              '(1 Samuel 17).',
        ),
        QuizQuestion(
          text: 'Quel sentiment a poussé Saül à vouloir tuer David après '
              'sa victoire ?',
          options: <String>['La jalousie', 'La peur des Philistins', 'La colère de Samuel', 'Un conseil de Jonathan'],
          correctIndex: 0,
          explanation:
              'Les chants de louange pour David rendent Saül jaloux '
              '(1 Samuel 18).',
        ),
        QuizQuestion(
          text: 'Qui a aidé David à échapper à Saül en le prévenant du '
              'danger ?',
          options: <String>['Jonathan', 'Abner', 'Samuel seul', 'Un prêtre inconnu'],
          correctIndex: 0,
          explanation:
              'Jonathan avertit David grâce à un signal convenu '
              '(1 Samuel 20).',
        ),
      ],
      '1 Samuel#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Que fait David quand il a l’occasion de tuer Saül dans '
              'une grotte ?',
          options: <String>[
            'Il l’épargne et coupe seulement un pan de son vêtement',
            'Il le tue immédiatement',
            'Il s’enfuit sans agir',
            'Il négocie une paix',
          ],
          correctIndex: 0,
          explanation:
              'David refuse de toucher « l’oint de Jéhovah » '
              '(1 Samuel 24).',
        ),
        QuizQuestion(
          text: 'Qui a évité un conflit entre David et Nabal par sa '
              'sagesse ?',
          options: <String>['Abigaïl', 'Mical', 'Une servante', 'Le grand prêtre'],
          correctIndex: 0,
          explanation:
              'Abigaïl apaise David avec des provisions (1 Samuel 25).',
        ),
        QuizQuestion(
          text: 'Qui Saül et Jonathan meurent-ils dans la bataille finale '
              'du livre ?',
          options: <String>[
            'Sur le mont Guilboa contre les Philistins',
            'À Jérusalem',
            'À Hébron',
            'À Guibea',
          ],
          correctIndex: 0,
          explanation:
              'Saül et ses fils meurent au Guilboa (1 Samuel 31).',
        ),
      ],
      '2 Samuel#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment David a-t-il réagi à la mort de Saül et '
              'Jonathan ?',
          options: <String>[
            'Il a composé un chant de deuil (une lamentation)',
            'Il s’est réjoui',
            'Il a ignoré la nouvelle',
            'Il a attaqué immédiatement',
          ],
          correctIndex: 0,
          explanation:
              'David compose « le Chant de l’arc » (2 Samuel 1).',
        ),
        QuizQuestion(
          text: 'Quelle ville David a-t-il conquise pour en faire sa '
              'capitale ?',
          options: <String>['Jérusalem', 'Hébron', 'Silo', 'Guibea'],
          correctIndex: 0,
          explanation:
              'David prend la forteresse de Sion (2 Samuel 5).',
        ),
        QuizQuestion(
          text: 'Quelle promesse Jéhovah fait-il à David par '
              'l’intermédiaire du prophète Nathan ?',
          options: <String>[
            'Un descendant régnera pour toujours',
            'David bâtira lui-même le temple',
            'David vivra éternellement',
            'David deviendra prêtre',
          ],
          correctIndex: 0,
          explanation:
              'L’alliance davidique promet une dynastie éternelle '
              '(2 Samuel 7).',
        ),
      ],
      '2 Samuel#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Avec qui David a-t-il commis l’adultère, entraînant le '
              'meurtre d’Urie ?',
          options: <String>['Bath-Shéba', 'Mical', 'Abigaïl', 'Tamar'],
          correctIndex: 0,
          explanation:
              'David fait tuer Urie pour cacher son péché '
              '(2 Samuel 11).',
        ),
        QuizQuestion(
          text: 'Comment le prophète Nathan a-t-il confronté David sur '
              'son péché ?',
          options: <String>[
            'Par une parabole sur un homme riche et un pauvre',
            'En le dénonçant publiquement',
            'Par une lettre anonyme',
            'En quittant son service',
          ],
          correctIndex: 0,
          explanation:
              'La parabole pousse David à reconnaître sa faute '
              '(2 Samuel 12).',
        ),
        QuizQuestion(
          text: 'Qui s’est révolté contre son père David pour prendre le '
              'trône ?',
          options: <String>['Absalom', 'Amnon', 'Salomon', 'Adonija'],
          correctIndex: 0,
          explanation:
              'La rébellion d’Absalom commence (2 Samuel 15).',
        ),
      ],
      '2 Samuel#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel conseil a fait échouer le plan rapide d’Ahitofel '
              'contre David ?',
          options: <String>[
            'Celui de Houshaï, resté fidèle à David',
            'Celui de Joab',
            'Celui d’un prêtre',
            'Celui de Salomon',
          ],
          correctIndex: 0,
          explanation:
              'Houshaï retarde l’attaque et sauve David (2 Samuel 17).',
        ),
        QuizQuestion(
          text: 'Comment Absalom est-il mort ?',
          options: <String>[
            'Suspendu par les cheveux à un arbre, tué par Joab',
            'Au combat singulier contre David',
            'Empoisonné',
            'En exil, de vieillesse',
          ],
          correctIndex: 0,
          explanation:
              'Absalom reste accroché puis Joab le transperce '
              '(2 Samuel 18).',
        ),
        QuizQuestion(
          text: 'Quel acte de David a provoqué une peste sur Israël vers '
              'la fin du livre ?',
          options: <String>[
            'Un recensement du peuple',
            'La construction d’un palais',
            'Un mariage interdit',
            'Un refus de sacrifice',
          ],
          correctIndex: 0,
          explanation:
              'Le recensement déplaît à Dieu et une peste s’ensuit '
              '(2 Samuel 24).',
        ),
      ],
      '1 Kings#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui a tenté de s’emparer du trône avant la mort de '
              'David ?',
          options: <String>['Adonija', 'Absalom', 'Joab seul', 'Nathan'],
          correctIndex: 0,
          explanation:
              'Adonija se proclame roi sans l’accord de David '
              '(1 Rois 1).',
        ),
        QuizQuestion(
          text: 'Que demande Salomon à Jéhovah au tout début de son '
              'règne ?',
          options: <String>[
            'Un cœur compréhensif pour juger le peuple',
            'La richesse avant tout',
            'La victoire militaire',
            'Une longue vie sans condition',
          ],
          correctIndex: 0,
          explanation:
              'Salomon demande la sagesse, ce qui plaît à Dieu '
              '(1 Rois 3).',
        ),
        QuizQuestion(
          text: 'Qui a aidé Salomon à fournir des matériaux pour '
              'construire le temple ?',
          options: <String>['Hiram, roi de Tyr', 'Le pharaon d’Égypte', 'La reine de Séba', 'Le roi de Moab'],
          correctIndex: 0,
          explanation:
              'Hiram fournit du bois de cèdre et des artisans '
              '(1 Rois 5).',
        ),
      ],
      '1 Kings#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que se passe-t-il lorsque le temple est achevé et '
              'dédié ?',
          options: <String>[
            'La gloire de Jéhovah remplit le temple',
            'Un tremblement de terre survient',
            'Le peuple se révolte',
            'Salomon quitte Jérusalem',
          ],
          correctIndex: 0,
          explanation:
              'La nuée de gloire remplit la maison (1 Rois 8).',
        ),
        QuizQuestion(
          text: 'Pourquoi le royaume de Salomon a-t-il fini par se '
              'fragiliser spirituellement ?',
          options: <String>[
            'Ses femmes étrangères ont détourné son cœur',
            'Il a perdu une guerre',
            'Il a été exilé',
            'Il a manqué de richesse',
          ],
          correctIndex: 0,
          explanation:
              'L’idolâtrie de ses femmes entraîne son infidélité '
              '(1 Rois 11).',
        ),
        QuizQuestion(
          text: 'Que fait Jéroboam après la division du royaume pour '
              'empêcher le peuple d’aller à Jérusalem ?',
          options: <String>[
            'Il installe des veaux d’or à Béthel et à Dan',
            'Il détruit toutes les routes',
            'Il interdit tout culte',
            'Il construit un nouveau temple identique',
          ],
          correctIndex: 0,
          explanation:
              'Jéroboam introduit un culte idolâtre rival '
              '(1 Rois 12).',
        ),
      ],
      '1 Kings#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui a annoncé une sécheresse punitive au roi Achab ?',
          options: <String>['Élie', 'Élisée', 'Michée', 'Abdias'],
          correctIndex: 0,
          explanation:
              'Élie annonce l’absence de pluie ni rosée '
              '(1 Rois 17).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé lors du défi sur le mont Carmel ?',
          options: <String>[
            'Le feu de Jéhovah a consumé le sacrifice d’Élie',
            'Une pluie soudaine est tombée en premier',
            'Les prophètes de Baal ont gagné',
            'Rien ne s’est produit',
          ],
          correctIndex: 0,
          explanation:
              'Jéhovah répond par le feu devant tout Israël '
              '(1 Rois 18).',
        ),
        QuizQuestion(
          text: 'Pourquoi Achab et Jézabel ont-ils fait tuer Naboth ?',
          options: <String>[
            'Pour s’emparer de sa vigne',
            'Pour un crime qu’il avait commis',
            'Pour une dette impayée',
            'Sur ordre d’un prophète',
          ],
          correctIndex: 0,
          explanation:
              'Jézabel orchestre un faux procès contre Naboth '
              '(1 Rois 21).',
        ),
      ],
      '2 Kings#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Élie a-t-il quitté la terre ?',
          options: <String>[
            'Emporté au ciel dans un tourbillon',
            'Il est mort de vieillesse',
            'Il a été exilé',
            'Il a disparu sans explication',
          ],
          correctIndex: 0,
          explanation:
              'Élisée voit Élie emporté par un tourbillon '
              '(2 Rois 2).',
        ),
        QuizQuestion(
          text: 'Quel miracle Élisée a-t-il accompli pour la femme '
              'shunamite ?',
          options: <String>[
            'Il a ramené son fils à la vie',
            'Il a multiplié son troupeau',
            'Il l’a guérie de la lèpre',
            'Il a reconstruit sa maison',
          ],
          correctIndex: 0,
          explanation:
              'Élisée ressuscite l’enfant de la Shunamite '
              '(2 Rois 4).',
        ),
        QuizQuestion(
          text: 'Comment Naaman a-t-il été guéri de la lèpre ?',
          options: <String>[
            'En se baignant sept fois dans le Jourdain',
            'Par un onguent spécial',
            'Par une prière collective',
            'Par un jeûne prolongé',
          ],
          correctIndex: 0,
          explanation:
              'Naaman obéit à l’instruction d’Élisée malgré son '
              'scepticisme (2 Rois 5).',
        ),
      ],
      '2 Kings#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment le siège de Samarie a-t-il été levé de façon '
              'inattendue ?',
          options: <String>[
            'L’armée aramééenne a fui, effrayée par un bruit',
            'Une armée alliée est arrivée',
            'Une trêve a été signée',
            'Le roi aramééen est mort au combat',
          ],
          correctIndex: 0,
          explanation:
              'Jéhovah fait entendre un bruit qui panique l’ennemi '
              '(2 Rois 7).',
        ),
        QuizQuestion(
          text: 'Qui Jéhu a-t-il éliminé pour purifier la royauté '
              'd’Israël ?',
          options: <String>[
            'Joram, Jézabel et la maison d’Achab',
            'Seulement les prophètes de Baal',
            'Les rois de Juda',
            'Les Assyriens',
          ],
          correctIndex: 0,
          explanation:
              'Jéhu exécute le jugement annoncé contre la maison '
              'd’Achab (2 Rois 9-10).',
        ),
        QuizQuestion(
          text: 'Comment le jeune Joas a-t-il été protégé avant de '
              'devenir roi ?',
          options: <String>[
            'Caché dans le temple par sa tante',
            'Envoyé à l’étranger',
            'Élevé par un prophète isolé',
            'Protégé par l’armée assyrienne',
          ],
          correctIndex: 0,
          explanation:
              'Joas échappe au massacre d’Athalie (2 Rois 11).',
        ),
      ],
      '2 Kings#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que devient le royaume du nord (Israël) après le siège '
              'assyrien ?',
          options: <String>[
            'Samarie tombe et le peuple est déporté',
            'Il conquiert l’Assyrie',
            'Il signe une paix durable',
            'Rien ne change vraiment',
          ],
          correctIndex: 0,
          explanation:
              'La chute de Samarie marque la fin du royaume du nord '
              '(2 Rois 17).',
        ),
        QuizQuestion(
          text: 'Comment Ézéchias a-t-il réagi à la lettre menaçante de '
              'Sennachérib ?',
          options: <String>[
            'Il l’a déployée devant Jéhovah et a prié',
            'Il s’est rendu sans résister',
            'Il a fui la ville',
            'Il a ignoré la menace',
          ],
          correctIndex: 0,
          explanation:
              'La prière d’Ézéchias précède la délivrance miraculeuse '
              '(2 Rois 19).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé pour l’armée assyrienne assiégeant '
              'Jérusalem ?',
          options: <String>[
            'Un ange en a frappé un grand nombre en une nuit',
            'Elle a été vaincue au combat',
            'Elle s’est simplement retirée',
            'Une épidémie l’a affaiblie lentement',
          ],
          correctIndex: 0,
          explanation:
              'L’intervention divine sauve Jérusalem (2 Rois 19).',
        ),
      ],
      '2 Kings#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’a découvert le grand prêtre Hilqiya sous le règne de '
              'Josias ?',
          options: <String>[
            'Le livre de la loi, perdu dans le temple',
            'Un trésor d’or',
            'Une tombe royale',
            'Une nouvelle source d’eau',
          ],
          correctIndex: 0,
          explanation:
              'La découverte relance la réforme religieuse de Josias '
              '(2 Rois 22).',
        ),
        QuizQuestion(
          text: 'Quelle grande fête Josias a-t-il célébrée après sa '
              'réforme ?',
          options: <String>['La Pâque', 'Les Tabernacles', 'La Pentecôte', 'Le Jubilé'],
          correctIndex: 0,
          explanation:
              'Une Pâque mémorable est célébrée (2 Rois 23).',
        ),
        QuizQuestion(
          text: 'Comment le livre des Rois se termine-t-il ?',
          options: <String>[
            'Par la chute de Jérusalem et la destruction du temple',
            'Par le couronnement d’un roi juste et durable',
            'Par une grande victoire militaire',
            'Par le retour immédiat de l’exil',
          ],
          correctIndex: 0,
          explanation:
              'Le récit se conclut sur l’exil à Babylone (2 Rois 25).',
        ),
      ],
      '1 Chronicles#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Par quelles généalogies ce livre commence-t-il ?',
          options: <String>[
            'D’Adam jusqu’aux douze tribus d’Israël',
            'Uniquement la lignée de David',
            'Seulement les prêtres',
            'Les rois d’Égypte',
          ],
          correctIndex: 0,
          explanation:
              'Les listes remontent à Adam (1 Chroniques 1-2).',
        ),
        QuizQuestion(
          text: 'De quelle tribu la lignée royale de David est-elle '
              'issue ?',
          options: <String>['Juda', 'Lévi', 'Benjamin', 'Éphraïm'],
          correctIndex: 0,
          explanation:
              'La généalogie de Juda inclut la maison de David '
              '(1 Chroniques 2-3).',
        ),
        QuizQuestion(
          text: 'Quelles tribus se sont établies à l’est du Jourdain '
              'selon ces généalogies ?',
          options: <String>[
            'Ruben, Gad et la moitié de Manassé',
            'Juda et Benjamin',
            'Lévi et Siméon',
            'Dan et Nephtali',
          ],
          correctIndex: 0,
          explanation:
              'Leur territoire et leurs chefs sont rappelés '
              '(1 Chroniques 5).',
        ),
      ],
      '1 Chronicles#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Uzza est-il mort en transportant l’Arche ?',
          options: <String>[
            'Il l’a touchée alors qu’elle glissait, contre les règles divines',
            'Il l’a volée',
            'Il a refusé de la porter',
            'Il s’est moqué du cortège',
          ],
          correctIndex: 0,
          explanation:
              'Le transport ne respectait pas les instructions divines '
              '(1 Chroniques 13).',
        ),
        QuizQuestion(
          text: 'Comment l’Arche a-t-elle finalement été transportée '
              'correctement à Jérusalem ?',
          options: <String>[
            'Portée par les Lévites, comme la loi le prescrivait',
            'Sur un chariot tiré par des bœufs',
            'Par bateau',
            'Par les prêtres égyptiens',
          ],
          correctIndex: 0,
          explanation:
              'David corrige l’erreur précédente (1 Chroniques 15).',
        ),
        QuizQuestion(
          text: 'Contre qui David a-t-il remporté des victoires notables '
              'dans ces chapitres ?',
          options: <String>[
            'Les Philistins',
            'Les Égyptiens',
            'Les Babyloniens',
            'Les Perses',
          ],
          correctIndex: 0,
          explanation:
              'David bat les Philistins à plusieurs reprises '
              '(1 Chroniques 14).',
        ),
      ],
      '1 Chronicles#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel chant Asaph a-t-il composé lors de l’installation '
              'de l’Arche ?',
          options: <String>[
            'Un chant de louange et d’action de grâce',
            'Un chant de deuil',
            'Une prophétie de malheur',
            'Un chant de guerre',
          ],
          correctIndex: 0,
          explanation:
              'Ce psaume de louange est confié à Asaph '
              '(1 Chroniques 16).',
        ),
        QuizQuestion(
          text: 'Pourquoi David n’a-t-il pas pu construire le temple '
              'lui-même ?',
          options: <String>[
            'Il avait versé beaucoup de sang à la guerre',
            'Il manquait de richesse',
            'Il n’avait pas de plan',
            'Le peuple s’y opposait',
          ],
          correctIndex: 0,
          explanation:
              'Jéhovah réserve cette tâche à Salomon (1 Chroniques 22 ; '
              '28).',
        ),
        QuizQuestion(
          text: 'Où David a-t-il acheté l’emplacement du futur temple ?',
          options: <String>[
            'L’aire de battage d’Ornân (Arauna)',
            'Un champ près d’Hébron',
            'Une colline à Silo',
            'Un terrain donné par Hiram',
          ],
          correctIndex: 0,
          explanation:
              'David y bâtit un autel après la peste '
              '(1 Chroniques 21).',
        ),
      ],
      '1 Chronicles#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment David a-t-il organisé le service des Lévites ?',
          options: <String>[
            'En groupes avec des tâches précises réparties',
            'Ils n’avaient aucune organisation',
            'Un seul homme s’occupait de tout',
            'Ils étaient dispensés de service',
          ],
          correctIndex: 0,
          explanation:
              'Les Lévites sont répartis par fonctions '
              '(1 Chroniques 23).',
        ),
        QuizQuestion(
          text: 'Quel rôle les musiciens désignés par David jouaient-ils ?',
          options: <String>[
            'Prophétiser et louer avec des instruments',
            'Combattre en première ligne',
            'Juger les procès',
            'Enseigner uniquement la lecture',
          ],
          correctIndex: 0,
          explanation:
              'Asaph, Héman et Yedoutoun dirigent la musique sacrée '
              '(1 Chroniques 25).',
        ),
        QuizQuestion(
          text: 'Quelle a été la dernière grande action publique de '
              'David avant sa mort ?',
          options: <String>[
            'Charger Salomon et le peuple de bâtir le temple',
            'Mener une dernière guerre',
            'Réviser toutes les lois',
            'Partir en exil volontaire',
          ],
          correctIndex: 0,
          explanation:
              'David prie et bénit l’assemblée avant de mourir '
              '(1 Chroniques 28-29).',
        ),
      ],
      '2 Chronicles#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que demande Salomon à Jéhovah au début de son règne ?',
          options: <String>[
            'La sagesse et la connaissance pour gouverner',
            'La richesse avant tout',
            'Une armée puissante',
            'Une vie sans épreuve',
          ],
          correctIndex: 0,
          explanation:
              'Sa demande plaît à Dieu qui lui donne aussi la richesse '
              '(2 Chroniques 1).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé lorsque le temple a été dédié ?',
          options: <String>[
            'Le feu est descendu du ciel et la gloire a rempli la maison',
            'Un tremblement de terre a tout détruit',
            'Rien de particulier ne s’est produit',
            'Le peuple s’est dispersé',
          ],
          correctIndex: 0,
          explanation:
              'Une manifestation spectaculaire confirme l’approbation '
              'divine (2 Chroniques 7).',
        ),
        QuizQuestion(
          text: 'Quelle prière Salomon prononce-t-il lors de la '
              'dédicace ?',
          options: <String>[
            'Une supplication pour que Dieu entende les prières faites '
                'vers ce lieu',
            'Une demande de richesse supplémentaire',
            'Une déclaration de guerre',
            'Un chant de deuil',
          ],
          correctIndex: 0,
          explanation:
              'Salomon demande que Dieu écoute depuis les cieux '
              '(2 Chroniques 6).',
        ),
      ],
      '2 Chronicles#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui a rendu visite à Salomon pour éprouver sa sagesse ?',
          options: <String>[
            'La reine de Séba',
            'Le roi d’Assyrie',
            'Le pharaon d’Égypte',
            'Le roi de Tyr',
          ],
          correctIndex: 0,
          explanation:
              'Elle est impressionnée par sa sagesse et sa richesse '
              '(2 Chroniques 9).',
        ),
        QuizQuestion(
          text: 'Pourquoi le royaume s’est-il divisé sous Roboam ?',
          options: <String>[
            'Son refus d’alléger le joug imposé par Salomon',
            'Une invasion étrangère',
            'La mort subite du roi',
            'Un accord pacifique de partage',
          ],
          correctIndex: 0,
          explanation:
              'Sa dureté pousse dix tribus à suivre Jéroboam '
              '(2 Chroniques 10).',
        ),
        QuizQuestion(
          text: 'Comment Asa a-t-il réagi face à l’invasion éthiopienne ?',
          options: <String>[
            'Il a prié Jéhovah avant la bataille et a vaincu',
            'Il s’est rendu sans combattre',
            'Il a fui avec son armée',
            'Il a payé un lourd tribut',
          ],
          correctIndex: 0,
          explanation:
              'Sa confiance en Dieu est récompensée (2 Chroniques 14).',
        ),
      ],
      '2 Chronicles#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle maladie a frappé Asa après qu’il ait négligé de '
              'chercher Jéhovah ?',
          options: <String>[
            'Une grave maladie aux pieds',
            'La lèpre',
            'La cécité',
            'Une paralysie totale',
          ],
          correctIndex: 0,
          explanation:
              'Il consulte les médecins plutôt que Dieu '
              '(2 Chroniques 16).',
        ),
        QuizQuestion(
          text: 'Pourquoi Josaphat a-t-il été réprimandé par un '
              'prophète ?',
          options: <String>[
            'Pour son alliance avec le méchant roi Achab',
            'Pour avoir négligé le temple',
            'Pour avoir refusé la guerre',
            'Pour avoir aboli les fêtes',
          ],
          correctIndex: 0,
          explanation:
              'Son alliance avec Achab est critiquée (2 Chroniques 19).',
        ),
        QuizQuestion(
          text: 'Comment Josaphat a-t-il remporté une victoire sans '
              'combattre ?',
          options: <String>[
            'En priant, pendant que ses ennemis s’entretuaient',
            'Grâce à une trêve négociée',
            'Par une fuite stratégique',
            'Grâce à un traité avec l’Égypte',
          ],
          correctIndex: 0,
          explanation:
              'La confiance en Dieu précède une délivrance miraculeuse '
              '(2 Chroniques 20).',
        ),
      ],
      '2 Chronicles#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment le jeune Joas a-t-il été sauvé du massacre '
              'd’Athalie ?',
          options: <String>[
            'Caché dans le temple par sa tante',
            'Envoyé secrètement à l’étranger',
            'Adopté par un prêtre étranger',
            'Protégé par une armée alliée',
          ],
          correctIndex: 0,
          explanation:
              'Yehoshéba le cache jusqu’à son couronnement '
              '(2 Chroniques 22-23).',
        ),
        QuizQuestion(
          text: 'Pourquoi Ozias (Ouzziya) a-t-il été frappé de lèpre ?',
          options: <String>[
            'Il a voulu offrir de l’encens, réservé aux prêtres',
            'Il a refusé de payer la dîme',
            'Il a insulté un prophète',
            'Il a négligé l’armée',
          ],
          correctIndex: 0,
          explanation:
              'Son orgueil le pousse à outrepasser son rôle '
              '(2 Chroniques 26).',
        ),
        QuizQuestion(
          text: 'Que fait Ézéchias dès le début de son règne ?',
          options: <String>[
            'Il rouvre et purifie le temple',
            'Il déclare la guerre à l’Assyrie',
            'Il abolit toutes les fêtes',
            'Il déplace la capitale',
          ],
          correctIndex: 0,
          explanation:
              'Ézéchias entreprend une grande réforme religieuse '
              '(2 Chroniques 29).',
        ),
      ],
      '2 Chronicles#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle grande fête Ézéchias a-t-il organisée après la '
              'purification du temple ?',
          options: <String>['Une Pâque exceptionnelle', 'Les Tabernacles', 'Le Jubilé', 'La Pentecôte'],
          correctIndex: 0,
          explanation:
              'Cette Pâque rassemble Juda et une partie d’Israël '
              '(2 Chroniques 30).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé après que Manassé se soit repenti en '
              'captivité ?',
          options: <String>[
            'Jéhovah l’a ramené à Jérusalem et il a fait des réformes',
            'Il est resté captif à vie',
            'Il a été exécuté',
            'Rien n’a changé',
          ],
          correctIndex: 0,
          explanation:
              'Son repentir sincère change son sort '
              '(2 Chroniques 33).',
        ),
        QuizQuestion(
          text: 'Comment le livre des Chroniques se termine-t-il ?',
          options: <String>[
            'Par le décret de Cyrus autorisant le retour et la '
                'reconstruction du temple',
            'Par la destruction finale sans espoir',
            'Par le couronnement d’un nouveau roi davidique',
            'Par une guerre civile prolongée',
          ],
          correctIndex: 0,
          explanation:
              'Le décret de Cyrus ouvre la voie au retour d’exil '
              '(2 Chroniques 36).',
        ),
      ],
      'Ezra#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui a autorisé les exilés à retourner reconstruire le '
              'temple ?',
          options: <String>['Cyrus, roi de Perse', 'Nabuchodonosor', 'Darius seul', 'Xerxès'],
          correctIndex: 0,
          explanation:
              'Cyrus publie un décret libérateur (Esdras 1).',
        ),
        QuizQuestion(
          text: 'Qu’ont fait les exilés dès leur retour, avant même '
              'd’achever le temple ?',
          options: <String>[
            'Ils ont reconstruit l’autel pour offrir des sacrifices',
            'Ils ont élu un nouveau roi',
            'Ils ont attaqué leurs voisins',
            'Ils ont refusé tout culte',
          ],
          correctIndex: 0,
          explanation:
              'L’autel est restauré avant les fondations (Esdras 3).',
        ),
        QuizQuestion(
          text: 'Quelle réaction mêlée a suivi la pose des fondations du '
              'nouveau temple ?',
          options: <String>[
            'Joie des jeunes, pleurs des anciens qui se souvenaient du premier',
            'Indifférence générale',
            'Colère unanime',
            'Fuite du peuple',
          ],
          correctIndex: 0,
          explanation:
              'Le contraste avec le temple de Salomon émeut les '
              'anciens (Esdras 3).',
        ),
      ],
      'Ezra#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment les travaux de reconstruction ont-ils été '
              'interrompus ?',
          options: <String>[
            'Des adversaires locaux ont fait cesser les travaux',
            'Un tremblement de terre a tout détruit',
            'Le peuple a manqué de matériaux',
            'Les ouvriers sont partis d’eux-mêmes',
          ],
          correctIndex: 0,
          explanation:
              'L’opposition politique bloque le chantier (Esdras 4).',
        ),
        QuizQuestion(
          text: 'Qui a encouragé la reprise des travaux du temple par '
              'leurs prophéties ?',
          options: <String>[
            'Aggée et Zacharie',
            'Ézéchiel et Daniel',
            'Isaïe et Jérémie',
            'Osée et Amos',
          ],
          correctIndex: 0,
          explanation:
              'Leurs messages relancent la construction (Esdras 5).',
        ),
        QuizQuestion(
          text: 'Qui est arrivé plus tard de Babylone avec un groupe '
              'supplémentaire d’exilés ?',
          options: <String>['Esdras, prêtre et scribe', 'Néhémie', 'Zorobabel', 'Mardochée'],
          correctIndex: 0,
          explanation:
              'Esdras arrive sous le règne d’Artaxerxès (Esdras 7).',
        ),
      ],
      'Ezra#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Esdras n’a-t-il pas demandé d’escorte armée '
              'pour le voyage ?',
          options: <String>[
            'Il avait exprimé sa confiance en la protection de Dieu',
            'Le roi la lui avait refusée',
            'Le voyage était sans danger',
            'Il avait déjà une armée',
          ],
          correctIndex: 0,
          explanation:
              'Esdras avait témoigné de la protection divine '
              '(Esdras 8).',
        ),
        QuizQuestion(
          text: 'Quel problème a profondément attristé Esdras à son '
              'arrivée ?',
          options: <String>[
            'Des mariages avec des femmes des nations environnantes',
            'Un manque d’offrandes',
            'Une famine',
            'Une guerre civile',
          ],
          correctIndex: 0,
          explanation:
              'Esdras déchire ses vêtements de douleur (Esdras 9).',
        ),
        QuizQuestion(
          text: 'Comment le peuple a-t-il répondu à l’appel d’Esdras ?',
          options: <String>[
            'En confessant sa faute et en corrigeant la situation',
            'En refusant tout changement',
            'En expulsant Esdras',
            'En ignorant l’appel',
          ],
          correctIndex: 0,
          explanation:
              'Une réforme collective a lieu (Esdras 10).',
        ),
      ],
      'Nehemiah#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Néhémie a-t-il réagi en apprenant l’état des '
              'murailles de Jérusalem ?',
          options: <String>[
            'Il a pleuré, jeûné et prié',
            'Il est resté indifférent',
            'Il a démissionné de son poste',
            'Il a organisé une fête',
          ],
          correctIndex: 0,
          explanation:
              'Sa douleur le pousse à agir (Néhémie 1).',
        ),
        QuizQuestion(
          text: 'Qu’a demandé Néhémie au roi Artaxerxès ?',
          options: <String>[
            'La permission d’aller reconstruire les murailles',
            'De l’or pour lui-même',
            'Un poste plus élevé à la cour',
            'La liberté de quitter le service du roi',
          ],
          correctIndex: 0,
          explanation:
              'Le roi accepte et lui fournit des ressources '
              '(Néhémie 2).',
        ),
        QuizQuestion(
          text: 'Comment les bâtisseurs ont-ils réagi face aux moqueries '
              'et menaces ?',
          options: <String>[
            'Ils ont travaillé une main occupée, l’autre tenant une arme',
            'Ils ont arrêté le chantier',
            'Ils ont fui la ville',
            'Ils ont négocié avec les opposants',
          ],
          correctIndex: 0,
          explanation:
              'Vigilance et détermination caractérisent le chantier '
              '(Néhémie 4).',
        ),
      ],
      'Nehemiah#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle injustice sociale Néhémie a-t-il dénoncée parmi '
              'le peuple ?',
          options: <String>[
            'Des prêts abusifs qui appauvrissaient les pauvres',
            'Le refus de payer la dîme',
            'Le non-respect du sabbat uniquement',
            'La corruption des juges',
          ],
          correctIndex: 0,
          explanation:
              'Néhémie corrige cette pratique injuste (Néhémie 5).',
        ),
        QuizQuestion(
          text: 'En combien de temps la muraille de Jérusalem a-t-elle '
              'été achevée ?',
          options: <String>['52 jours', 'Un an', 'Dix ans', 'Une semaine'],
          correctIndex: 0,
          explanation:
              'Un exploit malgré une forte opposition (Néhémie 6).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé lorsqu’Esdras a lu la Loi '
              'publiquement au peuple ?',
          options: <String>[
            'Le peuple a d’abord pleuré, puis a célébré avec joie',
            'Le peuple s’est révolté',
            'Personne n’a écouté',
            'La lecture a été interrompue',
          ],
          correctIndex: 0,
          explanation:
              'La fête des Tentes suit cette lecture émouvante '
              '(Néhémie 8).',
        ),
      ],
      'Nehemiah#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’a fait le peuple après la lecture de la Loi et la '
              'confession nationale ?',
          options: <String>[
            'Il a signé un engagement écrit à obéir à Dieu',
            'Il a quitté Jérusalem',
            'Il a aboli les fêtes',
            'Il a exilé les prêtres',
          ],
          correctIndex: 0,
          explanation:
              'Une alliance écrite scelle cet engagement (Néhémie 9-10).',
        ),
        QuizQuestion(
          text: 'Comment la dédicace de la muraille a-t-elle été '
              'célébrée ?',
          options: <String>[
            'Par des processions de chant et d’action de grâce',
            'Par un jeûne silencieux',
            'Par une cérémonie militaire',
            'Par la fermeture des portes',
          ],
          correctIndex: 0,
          explanation:
              'Deux chœurs font le tour de la muraille en chantant '
              '(Néhémie 12).',
        ),
        QuizQuestion(
          text: 'Quelle réforme Néhémie a-t-il imposée à son retour '
              'd’un second mandat ?',
          options: <String>[
            'Le respect strict du sabbat et l’expulsion de Tobiya',
            'L’abolition du temple',
            'Un nouveau recensement',
            'La construction d’un palais',
          ],
          correctIndex: 0,
          explanation:
              'Néhémie corrige plusieurs abus revenus en son absence '
              '(Néhémie 13).',
        ),
      ],
      'Esther#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi la reine Vashti a-t-elle été destituée ?',
          options: <String>[
            'Elle a refusé de paraître devant le roi et ses invités',
            'Elle a comploté contre le roi',
            'Elle est tombée malade',
            'Elle a quitté le palais',
          ],
          correctIndex: 0,
          explanation:
              'Son refus entraîne sa disgrâce (Esther 1).',
        ),
        QuizQuestion(
          text: 'Qui Mardochée a-t-il élevée et qui est devenue reine ?',
          options: <String>['Esther, sa cousine', 'Sa fille', 'Sa sœur', 'Une esclave étrangère'],
          correctIndex: 0,
          explanation:
              'Esther est choisie comme nouvelle reine (Esther 2).',
        ),
        QuizQuestion(
          text: 'Pourquoi Haman voulait-il exterminer tous les Juifs de '
              'l’empire ?',
          options: <String>[
            'Mardochée refusait de s’incliner devant lui',
            'Les Juifs avaient une dette envers lui',
            'Le roi le lui avait ordonné',
            'Une guerre venait d’éclater',
          ],
          correctIndex: 0,
          explanation:
              'La colère d’Haman se transforme en complot génocidaire '
              '(Esther 3).',
        ),
      ],
      'Esther#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle phrase célèbre Mardochée adresse-t-il à Esther '
              'pour la convaincre d’agir ?',
          options: <String>[
            '« Qui sait si ce n’est pas pour un temps comme celui-ci... »',
            '« Fuis pendant qu’il est temps »',
            '« Ce n’est pas notre problème »',
            '« Le roi ne t’écoutera jamais »',
          ],
          correctIndex: 0,
          explanation:
              'Cet appel pousse Esther à intervenir (Esther 4).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé quand le roi ne trouvait pas le '
              'sommeil ?',
          options: <String>[
            'Il a découvert que Mardochée n’avait jamais été récompensé',
            'Il a convoqué Esther immédiatement',
            'Il a fait exécuter Haman sur-le-champ',
            'Il a annulé son décret',
          ],
          correctIndex: 0,
          explanation:
              'Ce détail providentiel retourne la situation (Esther 6).',
        ),
        QuizQuestion(
          text: 'Comment Esther a-t-elle dévoilé le complot d’Haman ?',
          options: <String>[
            'Lors d’un second banquet, devant le roi',
            'Par une lettre anonyme',
            'En public devant tout le peuple',
            'Par l’intermédiaire d’un serviteur',
          ],
          correctIndex: 0,
          explanation:
              'Haman est démasqué et exécuté (Esther 7).',
        ),
      ],
      'Esther#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment le nouveau décret a-t-il contré celui d’Haman ?',
          options: <String>[
            'Il autorisait les Juifs à se défendre',
            'Il annulait totalement le premier décret',
            'Il exilait tous les Perses',
            'Il ne changeait rien',
          ],
          correctIndex: 0,
          explanation:
              'Un décret irrévocable devait être contré par un autre '
              '(Esther 8).',
        ),
        QuizQuestion(
          text: 'Quelle fête a été instituée pour commémorer cette '
              'délivrance ?',
          options: <String>['Pourim', 'La Pâque', 'Les Tabernacles', 'Le Jubilé'],
          correctIndex: 0,
          explanation:
              'Pourim célèbre encore aujourd’hui cet événement '
              '(Esther 9).',
        ),
        QuizQuestion(
          text: 'Quelle position Mardochée a-t-il finalement occupée ?',
          options: <String>[
            'Une position élevée, seconde après le roi',
            'Il a été exilé',
            'Il est resté un simple fonctionnaire',
            'Il a quitté la Perse',
          ],
          correctIndex: 0,
          explanation:
              'Mardochée œuvre pour le bien de son peuple (Esther 10).',
        ),
      ],
      'Job#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel défi Satan lance-t-il à Dieu au sujet de Job ?',
          options: <String>[
            'Job ne servirait Dieu que par intérêt personnel',
            'Job n’existe pas vraiment',
            'Job est déjà infidèle',
            'Job veut abandonner sa famille',
          ],
          correctIndex: 0,
          explanation:
              'Satan met en doute la motivation de Job (Job 1).',
        ),
        QuizQuestion(
          text: 'Comment Job a-t-il réagi après avoir tout perdu ?',
          options: <String>[
            'Il n’a pas péché ni accusé Dieu de mal',
            'Il a maudit Dieu',
            'Il s’est vengé',
            'Il a abandonné sa foi',
          ],
          correctIndex: 0,
          explanation:
              'Son intégrité reste intacte malgré l’épreuve (Job 1).',
        ),
        QuizQuestion(
          text: 'Que conseille la femme de Job après sa maladie ?',
          options: <String>[
            'De maudire Dieu et de mourir',
            'De consulter un médecin',
            'De fuir loin de chez eux',
            'De patienter en silence',
          ],
          correctIndex: 0,
          explanation:
              'Job refuse ce conseil désespéré (Job 2).',
        ),
      ],
      'Job#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel argument principal Bildad avance-t-il dans son '
              'premier discours ?',
          options: <String>[
            'La sagesse des ancêtres prouve que Dieu est juste',
            'Dieu n’existe pas',
            'Job est innocent',
            'La souffrance n’a aucune cause',
          ],
          correctIndex: 0,
          explanation:
              'Bildad s’appuie sur la tradition (Job 8).',
        ),
        QuizQuestion(
          text: 'Que désire profondément Job dans sa réponse à Bildad ?',
          options: <String>[
            'Un médiateur entre lui et Dieu',
            'De l’argent pour ses dettes',
            'La vengeance contre ses amis',
            'Un nouveau troupeau immédiatement',
          ],
          correctIndex: 0,
          explanation:
              'Job aspire à plaider sa cause équitablement (Job 9).',
        ),
        QuizQuestion(
          text: 'Que conseille Tsophar à Job dans son premier discours ?',
          options: <String>[
            'De se repentir d’un péché caché',
            'De quitter sa famille',
            'De consulter un autre sage',
            'De rester silencieux à jamais',
          ],
          correctIndex: 0,
          explanation:
              'Tsophar suppose que Job cache une faute (Job 11).',
        ),
      ],
      'Job#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle affirmation célèbre Job prononce-t-il malgré sa '
              'souffrance ?',
          options: <String>[
            '« Je sais que mon rédempteur est vivant »',
            '« Dieu m’a abandonné pour toujours »',
            '« La vie n’a aucun sens »',
            '« Je préfère mourir maintenant »',
          ],
          correctIndex: 0,
          explanation:
              'Cette déclaration d’espoir marque Job 19.',
        ),
        QuizQuestion(
          text: 'Quel constat Job fait-il sur le sort des méchants ?',
          options: <String>[
            'Ils semblent souvent prospérer malgré leur conduite',
            'Ils sont toujours punis immédiatement',
            'Ils n’existent pas vraiment',
            'Ils finissent toujours pauvres',
          ],
          correctIndex: 0,
          explanation:
              'Job remet en question la théorie simpliste de ses amis '
              '(Job 21).',
        ),
        QuizQuestion(
          text: 'Comment Job décrit-il le traitement reçu de ses amis '
              'dans ces chapitres ?',
          options: <String>[
            'Il se sent abandonné et incompris par eux',
            'Il les remercie chaleureusement',
            'Il approuve tous leurs arguments',
            'Il ne les mentionne pas',
          ],
          correctIndex: 0,
          explanation:
              'Job exprime sa détresse face à leur manque de compassion '
              '(Job 16-17).',
        ),
      ],
      'Job#3': <QuizQuestion>[
        QuizQuestion(
          text: 'De quoi Eliphaz accuse-t-il précisément Job dans son '
              'troisième discours ?',
          options: <String>[
            'De péchés spécifiques comme l’oppression des pauvres',
            'D’avoir volé un temple',
            'D’avoir renié sa famille',
            'D’avoir menti au roi',
          ],
          correctIndex: 0,
          explanation:
              'Les accusations d’Eliphaz se précisent, sans preuve '
              '(Job 22).',
        ),
        QuizQuestion(
          text: 'Que désire ardemment Job dans sa réponse ?',
          options: <String>[
            'Présenter sa cause directement devant Dieu',
            'Fuir loin de sa famille',
            'Obtenir la richesse',
            'Se venger de ses amis',
          ],
          correctIndex: 0,
          explanation:
              'Job cherche une audience équitable (Job 23).',
        ),
        QuizQuestion(
          text: 'Quel thème central Job développe-t-il au chapitre 28 ?',
          options: <String>[
            'La valeur incomparable de la sagesse',
            'La richesse minière',
            'La géographie du désert',
            'Les lois du sacrifice',
          ],
          correctIndex: 0,
          explanation:
              'Ce poème célèbre la sagesse, plus précieuse que l’or '
              '(Job 28).',
        ),
      ],
      'Job#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Que rappelle Job en évoquant ses jours passés ?',
          options: <String>[
            'Le respect et l’honneur qu’il recevait autrefois',
            'Sa pauvreté d’origine',
            'Une vie de guerre constante',
            'Son enfance à l’étranger',
          ],
          correctIndex: 0,
          explanation:
              'Job contraste son passé honoré avec sa situation actuelle '
              '(Job 29).',
        ),
        QuizQuestion(
          text: 'Que déclare Job dans son serment final d’innocence ?',
          options: <String>[
            'Il affirme n’avoir commis aucune des fautes énumérées',
            'Il avoue plusieurs péchés',
            'Il refuse de répondre',
            'Il accuse Dieu directement',
          ],
          correctIndex: 0,
          explanation:
              'Job clôt sa défense par un vaste serment (Job 31).',
        ),
        QuizQuestion(
          text: 'Qui est Élihu, qui prend la parole après les trois '
              'amis ?',
          options: <String>[
            'Un jeune homme qui s’estime porteur de sagesse',
            'Un ange envoyé par Dieu',
            'Un quatrième ami âgé',
            'Le fils de Job',
          ],
          correctIndex: 0,
          explanation:
              'Élihu intervient car les anciens n’ont pas convaincu '
              '(Job 32).',
        ),
      ],
      'Job#5': <QuizQuestion>[
        QuizQuestion(
          text: 'D’où Jéhovah parle-t-il finalement à Job ?',
          options: <String>[
            'Du sein d’une tempête',
            'D’un rêve',
            'D’un ange visible',
            'Il n’a jamais répondu',
          ],
          correctIndex: 0,
          explanation:
              'Dieu répond enfin, mais par des questions (Job 38).',
        ),
        QuizQuestion(
          text: 'Sur quoi portent principalement les questions de '
              'Jéhovah à Job ?',
          options: <String>[
            'La création et la maîtrise du monde naturel',
            'Les péchés cachés de Job',
            'La politique des nations',
            'Les rituels du temple',
          ],
          correctIndex: 0,
          explanation:
              'Dieu montre l’immensité de sa sagesse créatrice '
              '(Job 38-41).',
        ),
        QuizQuestion(
          text: 'Comment l’histoire de Job se conclut-elle ?',
          options: <String>[
            'Job se repent avec humilité et Dieu restaure le double de ses biens',
            'Job meurt dans la pauvreté',
            'Job maudit Dieu jusqu’à la fin',
            'Ses amis sont récompensés à sa place',
          ],
          correctIndex: 0,
          explanation:
              'Jéhovah bénit Job plus qu’auparavant (Job 42).',
        ),
      ],
      // Psalms is a 150-chapter collection of songs/poems rather than a
      // narrative — each checkpoint highlights 2-3 well-known psalms from its
      // range instead of attempting exhaustive coverage.
      'Psalms#0': <QuizQuestion>[
        QuizQuestion(
          text: 'À quoi le Psaume 1 compare-t-il l’homme heureux qui médite '
              'la loi de Dieu ?',
          options: <String>[
            'Un arbre planté près de cours d’eau',
            'Une pierre solide',
            'Un oiseau en vol',
            'Une lampe allumée',
          ],
          correctIndex: 0,
          explanation:
              'L’image de l’arbre fertile ouvre le livre (Psaume 1).',
        ),
        QuizQuestion(
          text: 'Que célèbre le Psaume 19 dans sa première partie ?',
          options: <String>[
            'La gloire de Dieu manifestée dans les cieux',
            'La victoire d’un roi',
            'La construction du temple',
            'Une bataille remportée',
          ],
          correctIndex: 0,
          explanation:
              '« Les cieux racontent la gloire de Dieu » (Psaume 19:1).',
        ),
        QuizQuestion(
          text: 'Quelle question le Psaume 8 pose-t-il face à l’immensité '
              'de la création ?',
          options: <String>[
            'Qu’est-ce que l’homme pour que tu te souviennes de lui ?',
            'Pourquoi la mer est-elle si vaste ?',
            'Où est situé le jardin d’Éden ?',
            'Combien d’étoiles existe-t-il ?',
          ],
          correctIndex: 0,
          explanation:
              'Le psalmiste s’émerveille de la place donnée à l’homme '
              '(Psaume 8:4).',
        ),
      ],
      'Psalms#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment le Psaume 23 décrit-il Jéhovah ?',
          options: <String>[
            'Comme un berger qui prend soin de ses brebis',
            'Comme un juge sévère',
            'Comme un roi lointain',
            'Comme un guerrier vengeur',
          ],
          correctIndex: 0,
          explanation:
              '« Jéhovah est mon berger » (Psaume 23:1).',
        ),
        QuizQuestion(
          text: 'Quelle parole prophétique du Psaume 22 a été citée par '
              'Jésus sur le poteau de supplice ?',
          options: <String>[
            '« Mon Dieu, mon Dieu, pourquoi m’as-tu abandonné ? »',
            '« Je suis venu pour juger »',
            '« Voici mon serviteur »',
            '« Le royaume approche »',
          ],
          correctIndex: 0,
          explanation:
              'Cette citation relie ce psaume à la passion du Christ '
              '(Psaume 22:1).',
        ),
        QuizQuestion(
          text: 'Que déclare le Psaume 34 sur la bonté de Jéhovah ?',
          options: <String>[
            'Goûtez et voyez comme Jéhovah est bon',
            'Sa bonté reste cachée',
            'Elle ne concerne que les prêtres',
            'Elle se limite à Israël',
          ],
          correctIndex: 0,
          explanation:
              'Une invitation à expérimenter la bonté divine (Psaume '
              '34:8).',
        ),
      ],
      'Psalms#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle prière touchante David a-t-il composée après son '
              'péché avec Bath-Shéba ?',
          options: <String>[
            'Le Psaume 51, demandant un cœur pur',
            'Un chant de victoire militaire',
            'Une prophétie sur Babylone',
            'Un chant de couronnement',
          ],
          correctIndex: 0,
          explanation:
              '« Crée en moi un cœur pur, ô Dieu » (Psaume 51:10).',
        ),
        QuizQuestion(
          text: 'À quoi le psalmiste compare-t-il son désir ardent de '
              'Dieu au Psaume 42 ?',
          options: <String>[
            'Une biche qui soupire après des cours d’eau',
            'Un lion affamé',
            'Un oiseau en cage',
            'Un marchand pressé',
          ],
          correctIndex: 0,
          explanation:
              'Une image de soif spirituelle intense (Psaume 42:1).',
        ),
        QuizQuestion(
          text: 'Quelle affirmation centrale fait le Psaume 46 ?',
          options: <String>[
            'Dieu est notre refuge et notre force',
            'Les nations vivront toujours en paix',
            'Le temple ne sera jamais détruit',
            'Le roi est notre seul espoir',
          ],
          correctIndex: 0,
          explanation:
              '« Dieu est pour nous un refuge et une force » '
              '(Psaume 46:1).',
        ),
      ],
      'Psalms#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Pour qui le Psaume 72 est-il une prière de bénédiction '
              'concernant un règne juste et prospère ?',
          options: <String>[
            'Pour le roi (Salomon, et prophétiquement le Messie)',
            'Pour les prêtres uniquement',
            'Pour les nations ennemies',
            'Pour les prophètes',
          ],
          correctIndex: 0,
          explanation:
              'Ce psaume messianique décrit un règne de paix durable '
              '(Psaume 72).',
        ),
        QuizQuestion(
          text: 'Quel dilemme trouble Asaph dans le Psaume 73 ?',
          options: <String>[
            'La prospérité apparente des méchants',
            'La pauvreté du temple',
            'L’absence de pluie',
            'Le silence des prophètes',
          ],
          correctIndex: 0,
          explanation:
              'Asaph résout ce trouble en entrant au sanctuaire de Dieu '
              '(Psaume 73:17).',
        ),
        QuizQuestion(
          text: 'Quelle image décrit la marche puissante de Dieu dans le '
              'Psaume 68 ?',
          options: <String>[
            'Il chevauche à travers le désert pour son peuple',
            'Il reste caché en permanence',
            'Il navigue sur les mers uniquement',
            'Il combat seul sans intervention',
          ],
          correctIndex: 0,
          explanation:
              'Un langage poétique de puissance divine (Psaume 68).',
        ),
      ],
      'Psalms#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Que demande Moïse à Dieu dans le Psaume 90 concernant '
              'la brièveté de la vie ?',
          options: <String>[
            'Nous enseigner à compter nos jours avec sagesse',
            'Prolonger indéfiniment la vie humaine',
            'Effacer le souvenir de la mort',
            'Accélérer le temps',
          ],
          correctIndex: 0,
          explanation:
              '« Enseigne-nous à bien compter nos jours » (Psaume '
              '90:12).',
        ),
        QuizQuestion(
          text: 'Quelle promesse de protection le Psaume 91 offre-t-il ?',
          options: <String>[
            'Celui qui habite sous l’abri du Très-Haut est protégé',
            'Aucune promesse n’est faite',
            'Seuls les rois sont protégés',
            'La protection dépend des sacrifices',
          ],
          correctIndex: 0,
          explanation:
              'Une image de refuge sous les ailes divines (Psaume 91).',
        ),
        QuizQuestion(
          text: 'Que dit le Psaume 84 sur la demeure de Dieu ?',
          options: <String>[
            'Qu’elle est infiniment désirable et aimée',
            'Qu’elle est menaçante',
            'Qu’elle sera bientôt détruite',
            'Qu’elle est réservée aux rois',
          ],
          correctIndex: 0,
          explanation:
              '« Que tes demeures sont aimables ! » (Psaume 84:1).',
        ),
      ],
      'Psalms#5': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle invitation ouvre le Psaume 100 ?',
          options: <String>[
            'Poussez des cris de joie et entrez avec reconnaissance',
            'Gardez le silence total',
            'Fuyez loin du temple',
            'Pleurez sur vos péchés',
          ],
          correctIndex: 0,
          explanation:
              'Un appel joyeux à la louange collective (Psaume 100).',
        ),
        QuizQuestion(
          text: 'Que rappelle le Psaume 103 sur le pardon de Dieu ?',
          options: <String>[
            'Il pardonne toutes nos fautes, comme un père compatit',
            'Il ne pardonne jamais',
            'Le pardon dépend du sacrifice quotidien',
            'Seuls les prêtres sont pardonnés',
          ],
          correctIndex: 0,
          explanation:
              'Une image tendre de compassion paternelle (Psaume '
              '103:13).',
        ),
        QuizQuestion(
          text: 'Quelle parole du Psaume 110 est appliquée au Christ dans '
              'les Écritures grecques ?',
          options: <String>[
            '« Assieds-toi à ma droite »',
            '« Tu seras roi de Babylone »',
            '« Retourne en Égypte »',
            '« Construis mon temple »',
          ],
          correctIndex: 0,
          explanation:
              'Jésus lui-même cite ce verset (Psaume 110:1).',
        ),
      ],
      'Psalms#6': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel est le sujet principal du Psaume 119, le plus long '
              'chapitre de la Bible ?',
          options: <String>[
            'L’amour pour la loi et la parole de Dieu',
            'Une bataille historique',
            'La construction du temple',
            'Un voyage en Égypte',
          ],
          correctIndex: 0,
          explanation:
              'Chaque section médite sur la loi divine (Psaume 119).',
        ),
        QuizQuestion(
          text: 'D’où le psalmiste dit-il que vient son secours au '
              'Psaume 121 ?',
          options: <String>[
            'De Jéhovah, créateur des cieux et de la terre',
            'Des montagnes elles-mêmes',
            'De l’armée du roi',
            'Des prêtres du temple',
          ],
          correctIndex: 0,
          explanation:
              '« Je lève les yeux vers les montagnes... mon secours '
              'vient de Jéhovah » (Psaume 121).',
        ),
        QuizQuestion(
          text: 'Que rappelle le Psaume 127 au sujet des projets '
              'humains ?',
          options: <String>[
            'Sans Jéhovah, les bâtisseurs travaillent en vain',
            'Le succès dépend uniquement de l’effort',
            'La chance seule décide',
            'Les enfants ne sont pas une bénédiction',
          ],
          correctIndex: 0,
          explanation:
              '« Si Jéhovah ne bâtit la maison... » (Psaume 127:1).',
        ),
      ],
      'Psalms#7': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle scène déchirante ouvre le Psaume 137 ?',
          options: <String>[
            'Les exilés pleurant au bord des fleuves de Babylone',
            'Une fête de couronnement',
            'Une bataille victorieuse',
            'La construction du temple',
          ],
          correctIndex: 0,
          explanation:
              '« Au bord des fleuves de Babylone, nous pleurions » '
              '(Psaume 137:1).',
        ),
        QuizQuestion(
          text: 'Comment le Psaume 145 décrit-il Jéhovah ?',
          options: <String>[
            'Grand et digne de louanges sans limite',
            'Distant et indifférent',
            'Sévère uniquement',
            'Silencieux face à son peuple',
          ],
          correctIndex: 0,
          explanation:
              'Un psaume de louange généreuse (Psaume 145:3).',
        ),
        QuizQuestion(
          text: 'Quel appel conclut le tout dernier psaume, le Psaume '
              '150 ?',
          options: <String>[
            'Que tout ce qui respire loue Yah',
            'Que tout se taise à jamais',
            'Que seuls les rois louent Dieu',
            'Que la musique soit interdite',
          ],
          correctIndex: 0,
          explanation:
              'Le livre se termine par un appel universel à la louange '
              '(Psaume 150:6).',
        ),
      ],
      'Proverbs#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Selon Proverbes 1, quel est le commencement de la '
              'connaissance ?',
          options: <String>[
            'La crainte de Jéhovah',
            'La richesse',
            'L’expérience seule',
            'L’éducation formelle',
          ],
          correctIndex: 0,
          explanation:
              'Ce principe fondamental ouvre le livre (Proverbes 1:7).',
        ),
        QuizQuestion(
          text: 'Que conseille Proverbes 3 au sujet de la confiance ?',
          options: <String>[
            'Se confier en Jéhovah de tout son cœur',
            'Compter uniquement sur sa propre intelligence',
            'Éviter toute décision importante',
            'Suivre l’avis de la majorité',
          ],
          correctIndex: 0,
          explanation:
              '« Confie-toi en Jéhovah de tout ton cœur » (Proverbes '
              '3:5).',
        ),
        QuizQuestion(
          text: 'Comment la sagesse est-elle personnifiée en Proverbes 8 ?',
          options: <String>[
            'Comme une voix qui appelle publiquement les hommes',
            'Comme un trésor cité mais invisible',
            'Comme un roi silencieux',
            'Comme un livre fermé',
          ],
          correctIndex: 0,
          explanation:
              'La sagesse crie sur les places publiques (Proverbes 8).',
        ),
      ],
      'Proverbs#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que dit Proverbes 15 sur la manière de répondre à la '
              'colère ?',
          options: <String>[
            'Une réponse douce détourne la fureur',
            'Il faut toujours répondre avec force',
            'Le silence est toujours préférable',
            'La colère doit être ignorée totalement',
          ],
          correctIndex: 0,
          explanation:
              '« Une réponse douce calme la fureur » (Proverbes 15:1).',
        ),
        QuizQuestion(
          text: 'Que dit Proverbes 16 sur nos projets et Jéhovah ?',
          options: <String>[
            'Remets tes œuvres à Jéhovah et tes projets réussiront',
            'Les projets humains ne dépendent que de nous',
            'Jéhovah ignore nos décisions quotidiennes',
            'Il vaut mieux ne rien planifier',
          ],
          correctIndex: 0,
          explanation:
              '« Recommande à Jéhovah tes œuvres » (Proverbes 16:3).',
        ),
        QuizQuestion(
          text: 'Que représente la femme sage qui bâtit sa maison en '
              'Proverbes 14 ?',
          options: <String>[
            'La sagesse pratique qui construit et préserve',
            'Une reine étrangère',
            'Une simple ouvrière',
            'Un personnage mineur sans portée',
          ],
          correctIndex: 0,
          explanation:
              'L’image illustre l’effet constructif de la sagesse '
              '(Proverbes 14:1).',
        ),
      ],
      'Proverbs#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que dit Proverbes 18 sur le pouvoir de la langue ?',
          options: <String>[
            'La mort et la vie sont au pouvoir de la langue',
            'Elle n’a aucune influence réelle',
            'Elle ne concerne que les dirigeants',
            'Elle est toujours inoffensive',
          ],
          correctIndex: 0,
          explanation:
              'Une image forte sur l’impact des paroles (Proverbes '
              '18:21).',
        ),
        QuizQuestion(
          text: 'Que dit Proverbes 19 sur la bonté envers les pauvres ?',
          options: <String>[
            'C’est comme prêter à Jéhovah lui-même',
            'C’est une perte de temps',
            'Cela ne concerne que les riches',
            'Cela affaiblit la société',
          ],
          correctIndex: 0,
          explanation:
              '« Qui a pitié du pauvre prête à Jéhovah » (Proverbes '
              '19:17).',
        ),
        QuizQuestion(
          text: 'Selon Proverbes 22, que vaut-il mieux qu’une grande '
              'richesse ?',
          options: <String>[
            'Une bonne réputation',
            'Un grand palais',
            'Une armée puissante',
            'Un vaste territoire',
          ],
          correctIndex: 0,
          explanation:
              '« Une bonne réputation vaut mieux que de grandes '
              'richesses » (Proverbes 22:1).',
        ),
      ],
      'Proverbs#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Que dit Proverbes 27 sur l’effet d’un ami sur un autre ?',
          options: <String>[
            'Le fer aiguise le fer, un homme en stimule un autre',
            'Les amis n’ont aucune influence',
            'Il vaut mieux rester seul',
            'Les amis affaiblissent le caractère',
          ],
          correctIndex: 0,
          explanation:
              'Une image d’influence mutuelle positive (Proverbes '
              '27:17).',
        ),
        QuizQuestion(
          text: 'Que dit Proverbes 29 sur l’absence de direction '
              'spirituelle ?',
          options: <String>[
            'Sans vision, le peuple est sans retenue',
            'Le peuple prospère toujours seul',
            'Les visions sont sans importance',
            'Le peuple préfère l’absence de règles',
          ],
          correctIndex: 0,
          explanation:
              'Une mise en garde sur le manque de guidance (Proverbes '
              '29:18).',
        ),
        QuizQuestion(
          text: 'Que célèbre le poème final de Proverbes 31 ?',
          options: <String>[
            'La femme capable et vertueuse',
            'La richesse d’un roi',
            'Une victoire militaire',
            'La construction d’un palais',
          ],
          correctIndex: 0,
          explanation:
              'Un acrostiche loue la femme vaillante (Proverbes 31).',
        ),
      ],
      'Ecclesiastes#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel constat récurrent ouvre le livre de l’Ecclésiaste ?',
          options: <String>[
            'Tout est vanité (vapeur, futilité) sous le soleil',
            'Tout est parfaitement stable',
            'La richesse résout tout',
            'Rien ne change jamais',
          ],
          correctIndex: 0,
          explanation:
              'Ce thème structure tout le livre (Ecclésiaste 1:2).',
        ),
        QuizQuestion(
          text: 'Qu’a découvert Salomon après avoir cherché plaisir, '
              'travaux et sagesse ?',
          options: <String>[
            'Tout cela, sans Dieu, reste vain',
            'Le plaisir seul suffit au bonheur',
            'Le travail garantit toujours la satisfaction',
            'La sagesse humaine résout tout',
          ],
          correctIndex: 0,
          explanation:
              'Son expérience personnelle illustre la futilité sans Dieu '
              '(Ecclésiaste 2).',
        ),
        QuizQuestion(
          text: 'Que rappelle le célèbre passage sur « un temps pour '
              'tout » ?',
          options: <String>[
            'Il y a une saison appropriée pour chaque chose',
            'Le temps n’a aucune importance',
            'Tout doit se faire immédiatement',
            'Le passé ne compte pas',
          ],
          correctIndex: 0,
          explanation:
              'Ce poème rythmé ouvre Ecclésiaste 3.',
        ),
      ],
      'Ecclesiastes#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que conseille Ecclésiaste 5 au sujet des vœux faits à '
              'Dieu ?',
          options: <String>[
            'Mieux vaut ne pas faire de vœu que d’y manquer',
            'Il faut multiplier les vœux',
            'Les vœux n’ont aucune valeur',
            'Seuls les prêtres peuvent faire des vœux',
          ],
          correctIndex: 0,
          explanation:
              'La prudence dans la parole envers Dieu est soulignée '
              '(Ecclésiaste 5:4, 5).',
        ),
        QuizQuestion(
          text: 'Que dit Ecclésiaste 7 sur la réputation ?',
          options: <String>[
            'Un bon nom vaut mieux que l’huile parfumée',
            'La réputation n’a aucune valeur',
            'Seule la richesse compte',
            'Le nom ne survit jamais',
          ],
          correctIndex: 0,
          explanation:
              'Un jugement de valeur sur l’intégrité (Ecclésiaste 7:1).',
        ),
        QuizQuestion(
          text: 'Que recommande Ecclésiaste 8 envers l’autorité '
              'établie ?',
          options: <String>[
            'Obéir sagement, sans précipitation à contester',
            'Toujours défier les dirigeants',
            'Ignorer complètement la loi',
            'Fuir toute responsabilité civile',
          ],
          correctIndex: 0,
          explanation:
              'Une prudence pratique est conseillée (Ecclésiaste 8).',
        ),
      ],
      'Ecclesiastes#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que rappelle Ecclésiaste 9 sur nos activités '
              'quotidiennes ?',
          options: <String>[
            'Fais ton travail de toutes tes forces, tant que tu vis',
            'Le travail est sans valeur',
            'Il vaut mieux rester inactif',
            'Seuls les riches doivent travailler',
          ],
          correctIndex: 0,
          explanation:
              'Un appel à l’engagement plein dans la vie (Ecclésiaste '
              '9:10).',
        ),
        QuizQuestion(
          text: 'Que conseille Ecclésiaste 11 à propos de la générosité ?',
          options: <String>[
            'Jette ton pain sur les eaux, il reviendra',
            'Garde toutes tes ressources pour toi-même',
            'La générosité est toujours inutile',
            'Il faut attendre la certitude avant d’agir',
          ],
          correctIndex: 0,
          explanation:
              'Une image d’investissement généreux et confiant '
              '(Ecclésiaste 11:1).',
        ),
        QuizQuestion(
          text: 'Quelle est la conclusion finale du livre de '
              'l’Ecclésiaste ?',
          options: <String>[
            'Crains Dieu et observe ses commandements',
            'Recherche uniquement le plaisir',
            'Rien n’a vraiment de sens',
            'La richesse est le but ultime',
          ],
          correctIndex: 0,
          explanation:
              'Cette conclusion résume tout le livre (Ecclésiaste '
              '12:13).',
        ),
      ],
      'Song of Solomon#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel sentiment domine l’ouverture du Cantique des '
              'cantiques ?',
          options: <String>[
            'Un amour ardent entre la Shulamite et son bien-aimé',
            'Un conflit familial',
            'Une négociation commerciale',
            'Un jugement royal',
          ],
          correctIndex: 0,
          explanation:
              'Le livre célèbre l’amour conjugal sincère (Cantique 1).',
        ),
        QuizQuestion(
          text: 'Que fait la Shulamite dans son rêve au chapitre 3 ?',
          options: <String>[
            'Elle cherche son bien-aimé dans la ville',
            'Elle fuit vers un pays lointain',
            'Elle se marie avec un autre homme',
            'Elle oublie complètement son amour',
          ],
          correctIndex: 0,
          explanation:
              'Son attachement reste fidèle même dans le rêve '
              '(Cantique 3).',
        ),
        QuizQuestion(
          text: 'Comment la Shulamite exprime-t-elle son attachement '
              'exclusif ?',
          options: <String>[
            '« Je suis à mon bien-aimé, et mon bien-aimé est à moi »',
            '« Je préfère la richesse à l’amour »',
            '« L’amour n’a pas d’importance pour moi »',
            '« Je resterai seule pour toujours »',
          ],
          correctIndex: 0,
          explanation:
              'Cette formule revient comme un refrain (Cantique 2:16).',
        ),
      ],
      'Song of Solomon#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment le bien-aimé décrit-il la beauté de la '
              'Shulamite au chapitre 4 ?',
          options: <String>[
            'Par une série d’images poétiques élogieuses',
            'De façon froide et distante',
            'En la comparant à une ennemie',
            'Il ne la décrit pas du tout',
          ],
          correctIndex: 0,
          explanation:
              'Un poème d’éloge détaillé lui est consacré (Cantique 4).',
        ),
        QuizQuestion(
          text: 'Que se passe-t-il quand le bien-aimé vient frapper à sa '
              'porte au chapitre 5 ?',
          options: <String>[
            'Elle tarde à ouvrir et il est déjà reparti',
            'Elle ouvre immédiatement avec joie',
            'Elle refuse de le voir',
            'Il n’est jamais venu',
          ],
          correctIndex: 0,
          explanation:
              'Ce moment manqué crée un regret poignant (Cantique 5).',
        ),
        QuizQuestion(
          text: 'À qui la Shulamite décrit-elle son bien-aimé après cet '
              'épisode ?',
          options: <String>[
            'Aux filles de Jérusalem',
            'À sa mère uniquement',
            'Au roi Salomon',
            'À personne, elle garde le silence',
          ],
          correctIndex: 0,
          explanation:
              'Sa description enthousiaste suit (Cantique 5).',
        ),
      ],
      'Song of Solomon#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle affirmation célèbre sur l’amour se trouve au '
              'chapitre 8 ?',
          options: <String>[
            'L’amour est fort comme la mort',
            'L’amour s’achète avec de l’argent',
            'L’amour est sans importance',
            'L’amour ne dure jamais',
          ],
          correctIndex: 0,
          explanation:
              '« De grandes eaux ne peuvent éteindre l’amour » '
              '(Cantique 8:6, 7).',
        ),
        QuizQuestion(
          text: 'Que symbolisent les « grandes eaux » incapables '
              'd’éteindre l’amour ?',
          options: <String>[
            'Les épreuves qui ne peuvent détruire un amour véritable',
            'Une inondation littérale',
            'La richesse du royaume',
            'Le pouvoir du roi',
          ],
          correctIndex: 0,
          explanation:
              'Une métaphore puissante sur la résilience de l’amour '
              '(Cantique 8).',
        ),
        QuizQuestion(
          text: 'Quel ton domine la fin du Cantique des cantiques ?',
          options: <String>[
            'La célébration d’un amour fidèle et partagé',
            'Une rupture définitive',
            'Un jugement sévère',
            'Un avertissement de guerre',
          ],
          correctIndex: 0,
          explanation:
              'Le livre se conclut sur une note d’amour accompli '
              '(Cantique 8).',
        ),
      ],
      'Isaiah#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que promet Ésaïe 2 pour l’avenir concernant la guerre ?',
          options: <String>[
            'Les nations forgeront leurs épées en socs de charrue',
            'Les guerres seront plus fréquentes',
            'Un seul empire dominera pour toujours',
            'Aucun changement n’est prédit',
          ],
          correctIndex: 0,
          explanation:
              'Une vision de paix universelle (Ésaïe 2:4).',
        ),
        QuizQuestion(
          text: 'Que voit Ésaïe lors de sa vision de commission '
              'prophétique ?',
          options: <String>[
            'Jéhovah sur un trône élevé, entouré de séraphins',
            'Une bataille céleste',
            'Un désert silencieux',
            'Une ville en ruine seulement',
          ],
          correctIndex: 0,
          explanation:
              'Un charbon touche ses lèvres, purifiant sa bouche '
              '(Ésaïe 6).',
        ),
        QuizQuestion(
          text: 'Quel signe Ésaïe annonce-t-il au roi Achaz au chapitre '
              '7 ?',
          options: <String>[
            'Une jeune femme concevra un fils, Emmanuel',
            'Une victoire militaire immédiate',
            'La destruction totale de Juda',
            'Une famine prolongée',
          ],
          correctIndex: 0,
          explanation:
              '« Emmanuel » signifie « Dieu avec nous » (Ésaïe 7:14).',
        ),
      ],
      'Isaiah#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle prophétie messianique célèbre se trouve en '
              'Ésaïe 9 ?',
          options: <String>[
            'Un enfant est né, le gouvernement sur son épaule',
            'Un roi étranger dominera pour toujours',
            'Le temple sera reconstruit immédiatement',
            'La paix ne viendra jamais',
          ],
          correctIndex: 0,
          explanation:
              'Ce passage annonce un règne de paix (Ésaïe 9:6, 7).',
        ),
        QuizQuestion(
          text: 'Quelle image pacifique illustre Ésaïe 11 concernant '
              'le règne futur ?',
          options: <String>[
            'Le loup habitera avec l’agneau',
            'Les lions domineront les hommes',
            'Les déserts resteront stériles',
            'Les nations resteront divisées',
          ],
          correctIndex: 0,
          explanation:
              'Une harmonie totale est promise (Ésaïe 11:6).',
        ),
        QuizQuestion(
          text: 'Comment Ésaïe 14 décrit-il la chute orgueilleuse du '
              'roi de Babylone ?',
          options: <String>[
            'Comme une étoile brillante tombée du ciel',
            'Comme un roi éternellement triomphant',
            'Comme un allié fidèle d’Israël',
            'Comme un simple marchand',
          ],
          correctIndex: 0,
          explanation:
              'Une image saisissante de déchéance (Ésaïe 14:12).',
        ),
      ],
      'Isaiah#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel geste symbolique Ésaïe accomplit-il contre '
              'l’Égypte et Cush ?',
          options: <String>[
            'Marcher pieds nus et sans vêtement de dessus',
            'Brûler ses vêtements',
            'Jeûner pendant un an',
            'Construire un autel',
          ],
          correctIndex: 0,
          explanation:
              'Ce signe illustre la honte de la captivité à venir '
              '(Ésaïe 20).',
        ),
        QuizQuestion(
          text: 'Quel jugement universel Ésaïe 24 annonce-t-il ?',
          options: <String>[
            'La terre entière sera bouleversée et dévastée',
            'Seule une nation sera jugée',
            'Aucun jugement n’aura lieu',
            'Le jugement concernera seulement les rois',
          ],
          correctIndex: 0,
          explanation:
              'Une portée mondiale est décrite (Ésaïe 24).',
        ),
        QuizQuestion(
          text: 'Que promet Ésaïe 25 concernant la mort ?',
          options: <String>[
            'Jéhovah engloutira la mort pour toujours',
            'La mort restera invincible',
            'Seuls les riches y échapperont',
            'Rien n’est dit sur la mort',
          ],
          correctIndex: 0,
          explanation:
              'Une espérance extraordinaire est exprimée (Ésaïe '
              '25:8).',
        ),
      ],
      'Isaiah#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Que promet Ésaïe 26 à celui dont l’esprit s’appuie sur '
              'Dieu ?',
          options: <String>[
            'Une paix parfaite',
            'Une richesse immédiate',
            'Une armée invincible',
            'Une longévité garantie',
          ],
          correctIndex: 0,
          explanation:
              '« Tu garderas dans une paix parfaite » (Ésaïe 26:3).',
        ),
        QuizQuestion(
          text: 'Quelle pierre précieuse Jéhovah pose-t-il en Sion selon '
              'Ésaïe 28 ?',
          options: <String>[
            'Une pierre angulaire, un fondement éprouvé',
            'Un simple caillou',
            'Une pierre maudite',
            'Aucune pierre n’est mentionnée',
          ],
          correctIndex: 0,
          explanation:
              'Une image messianique de fondement sûr (Ésaïe 28:16).',
        ),
        QuizQuestion(
          text: 'Contre qui Ésaïe met-il en garde le peuple concernant '
              'une alliance militaire ?',
          options: <String>[
            'Contre la confiance en l’Égypte plutôt qu’en Jéhovah',
            'Contre une alliance avec Babylone uniquement',
            'Contre tout commerce extérieur',
            'Contre les prêtres locaux',
          ],
          correctIndex: 0,
          explanation:
              'Chercher secours en Égypte est critiqué (Ésaïe 30-31).',
        ),
      ],
      'Isaiah#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Que deviendra le désert selon la promesse d’Ésaïe 35 ?',
          options: <String>[
            'Il fleurira comme une rose',
            'Il restera stérile pour toujours',
            'Il deviendra une mer',
            'Il sera abandonné définitivement',
          ],
          correctIndex: 0,
          explanation:
              'Une transformation joyeuse est promise (Ésaïe 35:1).',
        ),
        QuizQuestion(
          text: 'Comment Jéhovah a-t-il répondu à la prière '
              'd’Ézéchias face à Sennachérib ?',
          options: <String>[
            'Un ange a frappé l’armée assyrienne en une nuit',
            'Ézéchias a dû se rendre',
            'Une famine a affaibli Juda',
            'Aucune réponse n’est venue',
          ],
          correctIndex: 0,
          explanation:
              'Une délivrance spectaculaire suit la prière '
              '(Ésaïe 37).',
        ),
        QuizQuestion(
          text: 'Que rappelle Ésaïe 40 sur la nature humaine face à '
              'Dieu ?',
          options: <String>[
            'Toute chair est comme l’herbe qui se fane',
            'L’homme est éternel par nature',
            'Dieu dépend de l’homme',
            'La parole de Dieu change souvent',
          ],
          correctIndex: 0,
          explanation:
              '« La parole de notre Dieu subsiste toujours » '
              '(Ésaïe 40:8).',
        ),
      ],
      'Isaiah#5': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Ésaïe 42 décrit-il la douceur du serviteur de '
              'Jéhovah ?',
          options: <String>[
            'Il ne brisera pas le roseau déjà cassé',
            'Il détruira tout sur son passage',
            'Il ignorera les faibles',
            'Il agira avec violence systématique',
          ],
          correctIndex: 0,
          explanation:
              'Une douceur remarquable caractérise ce serviteur '
              '(Ésaïe 42:3).',
        ),
        QuizQuestion(
          text: 'Quel roi étranger est nommé à l’avance par Ésaïe comme '
              'libérateur d’Israël ?',
          options: <String>['Cyrus', 'Nabuchodonosor', 'Darius', 'Xerxès'],
          correctIndex: 0,
          explanation:
              'Une prophétie remarquable nomme Cyrus (Ésaïe 44-45).',
        ),
        QuizQuestion(
          text: 'Que dit Ésaïe 48 sur l’attitude passée du peuple '
              'envers les commandements de Dieu ?',
          options: <String>[
            'Si seulement ils y avaient prêté attention plus tôt',
            'Ils ont toujours parfaitement obéi',
            'Les commandements n’avaient pas d’importance',
            'Dieu n’a jamais rien demandé',
          ],
          correctIndex: 0,
          explanation:
              'Un regret exprimé sur leur manque d’écoute '
              '(Ésaïe 48:18).',
        ),
      ],
      'Isaiah#6': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Ésaïe 53 décrit-il la souffrance du serviteur '
              'de Jéhovah ?',
          options: <String>[
            'Il a été transpercé à cause de nos transgressions',
            'Il a vécu sans jamais souffrir',
            'Il a régné immédiatement sans épreuve',
            'Il a été honoré dès sa naissance',
          ],
          correctIndex: 0,
          explanation:
              'Un chapitre central sur la souffrance rédemptrice '
              '(Ésaïe 53:5).',
        ),
        QuizQuestion(
          text: 'Quelle invitation gratuite est lancée en Ésaïe 55 ?',
          options: <String>[
            'Venez acheter du vin et du lait sans argent',
            'Payez cher pour obtenir la sagesse',
            'Seuls les riches peuvent venir',
            'Aucune invitation n’est faite',
          ],
          correctIndex: 0,
          explanation:
              'Une offre généreuse et universelle (Ésaïe 55:1).',
        ),
        QuizQuestion(
          text: 'Que définit Ésaïe 58 comme un « jeûne » véritable aux '
              'yeux de Dieu ?',
          options: <String>[
            'Partager son pain avec l’affamé et libérer les opprimés',
            'S’abstenir uniquement de nourriture',
            'Porter des vêtements spéciaux',
            'Rester silencieux toute une journée',
          ],
          correctIndex: 0,
          explanation:
              'Le jeûne authentique se traduit en actes de justice '
              '(Ésaïe 58:6, 7).',
        ),
      ],
      'Isaiah#7': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle image d’espoir ouvre Ésaïe 60 pour Sion ?',
          options: <String>[
            'Lève-toi, resplendis, ta lumière est venue',
            'Reste dans l’obscurité pour toujours',
            'Fuis loin de ta ville',
            'Attends sans espoir',
          ],
          correctIndex: 0,
          explanation:
              'Un appel lumineux à la restauration (Ésaïe 60:1).',
        ),
        QuizQuestion(
          text: 'Quelle déclaration d’Ésaïe 61 Jésus a-t-il lue dans la '
              'synagogue de Nazareth ?',
          options: <String>[
            '« L’esprit du Souverain Seigneur est sur moi »',
            '« Je viendrai juger le monde entier »',
            '« Le temple sera détruit »',
            '« Personne ne sera sauvé »',
          ],
          correctIndex: 0,
          explanation:
              'Jésus applique ce passage à lui-même (Luc 4, citant '
              'Ésaïe 61:1).',
        ),
        QuizQuestion(
          text: 'Que promet Ésaïe 65 concernant l’avenir de la '
              'création ?',
          options: <String>[
            'De nouveaux cieux et une nouvelle terre',
            'La destruction finale sans restauration',
            'Un royaume limité à une seule nation',
            'La fin de toute vie animale',
          ],
          correctIndex: 0,
          explanation:
              'Une promesse d’espérance conclut le livre '
              '(Ésaïe 65:17).',
        ),
      ],
      'Jeremiah#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que dit Jéhovah à Jérémie sur son appel avant même sa '
              'naissance ?',
          options: <String>[
            '« Avant que je te forme dans le ventre, je te connaissais »',
            'Il l’a choisi seulement à l’âge adulte',
            'Jérémie s’est proposé lui-même',
            'Aucun appel particulier n’est mentionné',
          ],
          correctIndex: 0,
          explanation:
              'Une vocation prophétique établie dès avant sa '
              'naissance (Jérémie 1:5).',
        ),
        QuizQuestion(
          text: 'À quoi Jéhovah compare-t-il l’infidélité d’Israël au '
              'chapitre 2 ?',
          options: <String>[
            'À une épouse qui a oublié son mari',
            'À un roi fidèle',
            'À un serviteur exemplaire',
            'À une nation toujours loyale',
          ],
          correctIndex: 0,
          explanation:
              'Une image d’abandon relationnel (Jérémie 2).',
        ),
        QuizQuestion(
          text: 'Quelle fausse confiance Jérémie dénonce-t-il au '
              'chapitre 7 ?',
          options: <String>[
            'Répéter « c’est le temple de Jéhovah » comme une formule '
                'magique',
            'La confiance excessive en Jérémie lui-même',
            'La confiance dans l’armée seule',
            'La confiance dans les prophètes étrangers',
          ],
          correctIndex: 0,
          explanation:
              'Le peuple croit à tort que le temple les protège '
              'automatiquement (Jérémie 7).',
        ),
      ],
      'Jeremiah#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle question célèbre Jérémie pose-t-il au chapitre '
              '12 ?',
          options: <String>[
            'Pourquoi la voie des méchants prospère-t-elle ?',
            'Pourquoi Babylone est-elle si faible ?',
            'Pourquoi le temple est-il vide ?',
            'Pourquoi les prêtres sont-ils absents ?',
          ],
          correctIndex: 0,
          explanation:
              'Jérémie exprime une plainte sincère (Jérémie 12:1).',
        ),
        QuizQuestion(
          text: 'Que symbolise la ceinture de lin gâtée en Jérémie 13 ?',
          options: <String>[
            'La corruption de l’orgueil de Juda',
            'La richesse retrouvée du peuple',
            'Une alliance solide avec l’Égypte',
            'La pureté du sacerdoce',
          ],
          correctIndex: 0,
          explanation:
              'Un signe visuel de décadence morale (Jérémie 13).',
        ),
        QuizQuestion(
          text: 'Que révèle Jérémie 17 sur le cœur humain ?',
          options: <String>[
            'Il est trompeur plus que toute autre chose',
            'Il est naturellement bon',
            'Il ne change jamais',
            'Il est sans importance pour Dieu',
          ],
          correctIndex: 0,
          explanation:
              'Une évaluation franche de la nature humaine '
              '(Jérémie 17:9).',
        ),
      ],
      'Jeremiah#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle illustration Jéhovah donne-t-il à Jérémie chez '
              'le potier ?',
          options: <String>[
            'Comme l’argile dans la main du potier, Israël est dans la '
                'main de Dieu',
            'Le potier symbolise un roi étranger',
            'L’argile représente la richesse',
            'Aucune leçon spirituelle n’en est tirée',
          ],
          correctIndex: 0,
          explanation:
              'Une image de souveraineté divine (Jérémie 18).',
        ),
        QuizQuestion(
          text: 'Comment Jérémie a-t-il été traité après avoir prophétisé '
              'contre Jérusalem ?',
          options: <String>[
            'Il a été frappé et mis aux ceps par Pashehour',
            'Il a été honoré publiquement',
            'Il a été nommé grand prêtre',
            'Il a été envoyé en ambassade',
          ],
          correctIndex: 0,
          explanation:
              'Jérémie souffre pour son message fidèle (Jérémie 20).',
        ),
        QuizQuestion(
          text: 'Quel choix Jérémie propose-t-il au peuple assiégé au '
              'chapitre 21 ?',
          options: <String>[
            'Se rendre à Babylone (vie) ou résister (mort)',
            'Fuir en Égypte immédiatement',
            'Attaquer Babylone en premier',
            'Négocier avec l’Assyrie',
          ],
          correctIndex: 0,
          explanation:
              'Un choix difficile mais clair est présenté '
              '(Jérémie 21).',
        ),
      ],
      'Jeremiah#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Que promet Jérémie 23 concernant un futur roi juste ?',
          options: <String>[
            'Un « germe juste » régnera avec sagesse',
            'Aucun roi juste ne viendra jamais',
            'Les faux bergers régneront pour toujours',
            'Le royaume disparaîtra sans successeur',
          ],
          correctIndex: 0,
          explanation:
              'Une promesse messianique contraste avec les mauvais '
              'bergers (Jérémie 23:5).',
        ),
        QuizQuestion(
          text: 'Combien d’années de captivité à Babylone Jérémie '
              'annonce-t-il ?',
          options: <String>['70 ans', '7 ans', '40 ans', '400 ans'],
          correctIndex: 0,
          explanation:
              'Cette durée précise est prophétisée (Jérémie 25:11).',
        ),
        QuizQuestion(
          text: 'Que conseille Jérémie aux exilés à Babylone dans sa '
              'lettre ?',
          options: <String>[
            'Bâtir des maisons et rechercher la paix de la ville',
            'Se révolter immédiatement',
            'Refuser tout travail',
            'Ignorer les autorités locales',
          ],
          correctIndex: 0,
          explanation:
              'Un conseil réaliste pour vivre en exil (Jérémie 29).',
        ),
      ],
      'Jeremiah#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Que promet Jéhovah dans la célèbre prophétie de la '
              'nouvelle alliance ?',
          options: <String>[
            'Sa loi sera inscrite dans le cœur du peuple',
            'Un nouveau temple sera bâti immédiatement',
            'Aucune alliance future n’est prévue',
            'Le sacerdoce sera aboli sans remplacement',
          ],
          correctIndex: 0,
          explanation:
              'Une alliance intérieure et personnelle est annoncée '
              '(Jérémie 31:33).',
        ),
        QuizQuestion(
          text: 'Quel geste symbolique Jérémie accomplit-il en pleine '
              'crise, achetant un champ ?',
          options: <String>[
            'Il exprime sa foi en une restauration future',
            'Il cherche à s’enrichir personnellement',
            'Il fuit la ville assiégée',
            'Il négocie avec Babylone',
          ],
          correctIndex: 0,
          explanation:
              'Cet achat témoigne d’espérance malgré le siège '
              '(Jérémie 32).',
        ),
        QuizQuestion(
          text: 'Quel exemple de fidélité les Rékabites offrent-ils à '
              'Juda ?',
          options: <String>[
            'Leur obéissance stricte au commandement de leur ancêtre',
            'Leur richesse abondante',
            'Leur pouvoir militaire',
            'Leur alliance avec l’Égypte',
          ],
          correctIndex: 0,
          explanation:
              'Leur fidélité contraste avec l’infidélité de Juda '
              '(Jérémie 35).',
        ),
      ],
      'Jeremiah#5': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui a sauvé Jérémie jeté dans une citerne boueuse ?',
          options: <String>['Ébed-Mélek', 'Baruch', 'Guedalia', 'Ismaël'],
          correctIndex: 0,
          explanation:
              'Cet Éthiopien intervient courageusement (Jérémie 38).',
        ),
        QuizQuestion(
          text: 'Qui a été nommé gouverneur après la chute de '
              'Jérusalem, puis assassiné ?',
          options: <String>['Guedalia', 'Sédécias', 'Ismaël', 'Baruch'],
          correctIndex: 0,
          explanation:
              'Son assassinat provoque de nouveaux troubles '
              '(Jérémie 40-41).',
        ),
        QuizQuestion(
          text: 'Que fait le reste du peuple malgré l’avertissement de '
              'Jérémie de rester au pays ?',
          options: <String>[
            'Il fuit en Égypte en emmenant Jérémie',
            'Il se soumet pleinement au conseil du prophète',
            'Il attaque Babylone',
            'Il se disperse vers l’Assyrie',
          ],
          correctIndex: 0,
          explanation:
              'Leur désobéissance aggrave leur situation '
              '(Jérémie 43).',
        ),
      ],
      'Jeremiah#6': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre quelles nations les derniers chapitres de '
              'Jérémie prononcent-ils des jugements ?',
          options: <String>[
            'L’Égypte, les Philistins, Moab, Ammon, Babylone et d’autres',
            'Seulement Israël',
            'Aucune nation étrangère',
            'Uniquement Juda',
          ],
          correctIndex: 0,
          explanation:
              'Une série d’oracles contre les nations conclut le '
              'livre (Jérémie 46-51).',
        ),
        QuizQuestion(
          text: 'Quel signe symbolique accompagne la prophétie contre '
              'Babylone remise à Seraïa ?',
          options: <String>[
            'Le rouleau est jeté dans l’Euphrate pour couler',
            'Il est brûlé publiquement',
            'Il est lu devant le roi de Babylone',
            'Il est caché dans le temple',
          ],
          correctIndex: 0,
          explanation:
              'Une image de la chute définitive de Babylone '
              '(Jérémie 51).',
        ),
        QuizQuestion(
          text: 'Comment le livre de Jérémie se termine-t-il '
              'historiquement ?',
          options: <String>[
            'Par la libération de Jehoïakîn de prison à Babylone',
            'Par le retour immédiat de tout le peuple',
            'Par la reconstruction du temple',
            'Par une victoire militaire de Juda',
          ],
          correctIndex: 0,
          explanation:
              'Un épilogue historique clôt le livre (Jérémie 52).',
        ),
      ],
      'Lamentations#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Lamentations 1 décrit-il Jérusalem après sa '
              'chute ?',
          options: <String>[
            'Comme une ville autrefois peuplée, maintenant solitaire',
            'Comme une ville en pleine prospérité',
            'Comme une capitale intacte',
            'Comme un lieu de fête continue',
          ],
          correctIndex: 0,
          explanation:
              '« Comme elle est assise solitaire ! » ouvre le livre '
              '(Lamentations 1:1).',
        ),
        QuizQuestion(
          text: 'Que décrit Lamentations 2 concernant la colère de '
              'Jéhovah ?',
          options: <String>[
            'Elle s’est déversée sur Sion à cause de son infidélité',
            'Elle a épargné totalement la ville',
            'Elle visait uniquement les nations voisines',
            'Elle n’a eu aucun effet visible',
          ],
          correctIndex: 0,
          explanation:
              'La destruction est présentée comme un jugement mérité '
              '(Lamentations 2).',
        ),
        QuizQuestion(
          text: 'Quel ton domine l’ensemble de ces deux premiers '
              'chapitres ?',
          options: <String>[
            'Un deuil profond sur la ville détruite',
            'Une célébration joyeuse',
            'Une indifférence totale',
            'Un triomphe militaire',
          ],
          correctIndex: 0,
          explanation:
              'Le livre est une élégie funèbre (Lamentations 1-2).',
        ),
      ],
      'Lamentations#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle affirmation d’espoir se trouve au cœur du '
              'chapitre 3 malgré la souffrance ?',
          options: <String>[
            'Les bontés de Jéhovah se renouvellent chaque matin',
            'Il n’y a aucun espoir possible',
            'La souffrance ne finira jamais',
            'Dieu a complètement abandonné son peuple',
          ],
          correctIndex: 0,
          explanation:
              '« Grande est ta fidélité » (Lamentations 3:22, 23).',
        ),
        QuizQuestion(
          text: 'Comment l’auteur se décrit-il personnellement au '
              'chapitre 3 ?',
          options: <String>[
            'Comme un homme qui a vu l’affliction',
            'Comme un roi triomphant',
            'Comme un simple observateur extérieur',
            'Comme un prêtre en fête',
          ],
          correctIndex: 0,
          explanation:
              'Une expérience personnelle de souffrance est partagée '
              '(Lamentations 3:1).',
        ),
        QuizQuestion(
          text: 'Quelle attitude le chapitre 3 recommande-t-il face à '
              'l’épreuve ?',
          options: <String>[
            'Attendre Jéhovah en silence avec espérance',
            'Se venger immédiatement',
            'Abandonner toute foi',
            'Fuir loin de toute communauté',
          ],
          correctIndex: 0,
          explanation:
              'Une patience confiante est encouragée '
              '(Lamentations 3:25, 26).',
        ),
      ],
      'Lamentations#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle souffrance extrême le chapitre 4 rappelle-t-il '
              'durant le siège ?',
          options: <String>[
            'Une famine sévère parmi les habitants',
            'Une abondance de nourriture',
            'Une paix inattendue',
            'Un afflux de richesses',
          ],
          correctIndex: 0,
          explanation:
              'La famine du siège est décrite avec réalisme '
              '(Lamentations 4).',
        ),
        QuizQuestion(
          text: 'Que demande la prière finale du chapitre 5 ?',
          options: <String>[
            'Que Jéhovah restaure son peuple comme autrefois',
            'Que la ville reste en ruine à jamais',
            'Qu’aucun retour ne soit possible',
            'Que le peuple oublie son passé',
          ],
          correctIndex: 0,
          explanation:
              '« Fais-nous revenir à toi » conclut le livre '
              '(Lamentations 5:21).',
        ),
        QuizQuestion(
          text: 'Quel sentiment domine la prière collective du dernier '
              'chapitre ?',
          options: <String>[
            'Une humble supplication malgré la honte du passé',
            'Une fierté renouvelée',
            'Une indifférence à l’avenir',
            'Une colère contre Dieu',
          ],
          correctIndex: 0,
          explanation:
              'Le peuple reconnaît sa situation et implore la '
              'restauration (Lamentations 5).',
        ),
      ],
      'Ezekiel#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que voit Ézékiel dans sa vision inaugurale du '
              'chapitre 1 ?',
          options: <String>[
            'Le char céleste de Jéhovah avec des créatures vivantes',
            'Une simple tempête de sable',
            'Un temple en flammes',
            'Une armée en marche',
          ],
          correctIndex: 0,
          explanation:
              'Une vision impressionnante ouvre le livre (Ézékiel 1).',
        ),
        QuizQuestion(
          text: 'Que doit faire Ézékiel avec le rouleau qui lui est '
              'donné ?',
          options: <String>['Le manger', 'Le brûler', 'Le cacher', 'Le vendre'],
          correctIndex: 0,
          explanation:
              'Un signe symbolique d’assimilation du message '
              '(Ézékiel 3).',
        ),
        QuizQuestion(
          text: 'Quelle idolâtrie secrète Ézékiel voit-il pratiquée dans '
              'le temple même ?',
          options: <String>[
            'Le culte du soleil et d’idoles cachées par les anciens',
            'Aucune idolâtrie n’est trouvée',
            'Seul un autel vide est vu',
            'Un festin public légitime',
          ],
          correctIndex: 0,
          explanation:
              'Une vision révèle la corruption cachée (Ézékiel 8).',
        ),
      ],
      'Ezekiel#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui reçoit une marque protectrice avant le jugement de '
              'Jérusalem ?',
          options: <String>[
            'Ceux qui gémissent à cause des pratiques abominables',
            'Tous les habitants sans distinction',
            'Seuls les prêtres',
            'Seuls les riches',
          ],
          correctIndex: 0,
          explanation:
              'Une distinction est faite selon l’attitude du cœur '
              '(Ézékiel 9).',
        ),
        QuizQuestion(
          text: 'Que se passe-t-il de significatif avec la gloire de '
              'Jéhovah en Ézékiel 10-11 ?',
          options: <String>[
            'Elle quitte le temple et la ville',
            'Elle s’installe définitivement',
            'Elle se manifeste plus fortement',
            'Rien ne change',
          ],
          correctIndex: 0,
          explanation:
              'Un signe grave de jugement imminent (Ézékiel 10-11).',
        ),
        QuizQuestion(
          text: 'À quoi Jérusalem est-elle comparée dans la parabole '
              'du chapitre 16 ?',
          options: <String>[
            'À une épouse infidèle élevée par Dieu depuis sa naissance',
            'À une reine toujours fidèle',
            'À un roi puissant',
            'À une ville jamais fondée',
          ],
          correctIndex: 0,
          explanation:
              'Une allégorie saisissante de l’infidélité (Ézékiel 16).',
        ),
      ],
      'Ezekiel#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que déclare Ézékiel 18 sur la responsabilité '
              'individuelle ?',
          options: <String>[
            'L’âme qui pèche, c’est elle qui mourra',
            'Les enfants portent toujours la faute des parents',
            'Nul n’est responsable de ses actes',
            'Seuls les rois sont jugés',
          ],
          correctIndex: 0,
          explanation:
              'Un principe de justice individuelle est établi '
              '(Ézékiel 18:20).',
        ),
        QuizQuestion(
          text: 'Que cherche Jéhovah en Ézékiel 22, sans le trouver ?',
          options: <String>[
            'Un homme pour se tenir dans la brèche',
            'Un nouveau roi',
            'Un temple à reconstruire',
            'Un prophète étranger',
          ],
          correctIndex: 0,
          explanation:
              'L’absence d’intercesseur aggrave le jugement '
              '(Ézékiel 22:30).',
        ),
        QuizQuestion(
          text: 'Quel signe personnel douloureux Ézékiel vit-il au '
              'chapitre 24 ?',
          options: <String>[
            'La mort de sa femme, sans qu’il puisse la pleurer publiquement',
            'La perte de sa maison',
            'Un exil immédiat',
            'Une maladie grave',
          ],
          correctIndex: 0,
          explanation:
              'Ce signe illustre l’ampleur du choc à venir '
              '(Ézékiel 24).',
        ),
      ],
      'Ezekiel#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre quelles nations voisines les oracles de ces '
              'chapitres sont-ils dirigés ?',
          options: <String>[
            'Ammon, Moab, Édom, les Philistins et Tyr',
            'Seulement l’Égypte',
            'Seulement Babylone',
            'Aucune nation étrangère',
          ],
          correctIndex: 0,
          explanation:
              'Une série de jugements contre les nations (Ézékiel '
              '25-28).',
        ),
        QuizQuestion(
          text: 'Comment Tyr est-elle décrite dans la lamentation '
              'poétique la concernant ?',
          options: <String>[
            'Comme un magnifique navire marchand',
            'Comme une ville sans commerce',
            'Comme une nation pacifique',
            'Comme une alliée fidèle d’Israël',
          ],
          correctIndex: 0,
          explanation:
              'Une image maritime illustre sa gloire passée '
              '(Ézékiel 27).',
        ),
        QuizQuestion(
          text: 'À quoi l’Égypte est-elle comparée dans le jugement qui '
              'la concerne ?',
          options: <String>[
            'À un grand cèdre finalement abattu',
            'À un roc inébranlable',
            'À une mer paisible',
            'À un désert vide',
          ],
          correctIndex: 0,
          explanation:
              'Une image de grandeur suivie de chute (Ézékiel 31).',
        ),
      ],
      'Ezekiel#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel rôle Ézékiel reçoit-il envers son peuple ?',
          options: <String>[
            'Celui de guetteur, chargé d’avertir',
            'Celui de roi',
            'Celui de simple scribe',
            'Celui de juge militaire',
          ],
          correctIndex: 0,
          explanation:
              'Sa responsabilité d’avertisseur est définie (Ézékiel '
              '33).',
        ),
        QuizQuestion(
          text: 'Que voit Ézékiel dans la célèbre vision de la vallée '
              'des ossements desséchés ?',
          options: <String>[
            'Des ossements reprenant vie, image de la restauration d’Israël',
            'Une bataille sanglante en cours',
            'Un désert sans espoir',
            'Une ville prospère',
          ],
          correctIndex: 0,
          explanation:
              'Une image puissante de résurrection nationale '
              '(Ézékiel 37).',
        ),
        QuizQuestion(
          text: 'Que symbolisent les deux bâtons joints en un seul en '
              'Ézékiel 37 ?',
          options: <String>[
            'La réunification de Juda et d’Israël',
            'Une alliance avec l’Égypte',
            'La division définitive du peuple',
            'La destruction du temple',
          ],
          correctIndex: 0,
          explanation:
              'Un seul peuple réuni sous un seul berger (Ézékiel '
              '37:19).',
        ),
      ],
      'Ezekiel#5': <QuizQuestion>[
        QuizQuestion(
          text: 'Que revient faire la gloire de Jéhovah dans la vision '
              'du nouveau temple ?',
          options: <String>[
            'Elle remplit à nouveau la maison',
            'Elle reste absente définitivement',
            'Elle se manifeste ailleurs seulement',
            'Rien ne se produit',
          ],
          correctIndex: 0,
          explanation:
              'Un retour symbolique de la présence divine (Ézékiel '
              '43).',
        ),
        QuizQuestion(
          text: 'Que produit le fleuve qui sort du temple selon '
              'Ézékiel 47 ?',
          options: <String>[
            'Une eau qui guérit et donne la vie partout où elle passe',
            'Une inondation destructrice',
            'Une simple curiosité sans effet',
            'Une eau réservée aux prêtres uniquement',
          ],
          correctIndex: 0,
          explanation:
              'Une image de restauration abondante (Ézékiel 47:9).',
        ),
        QuizQuestion(
          text: 'Comment la ville finale est-elle nommée à la fin du '
              'livre ?',
          options: <String>['« Jéhovah est là »', '« La cité éternelle »', '« Nouvelle Babylone »', '« La ville sainte » seulement'],
          correctIndex: 0,
          explanation:
              'Ce nom résume l’espérance du livre (Ézékiel 48:35).',
        ),
      ],
      'Daniel#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Daniel et ses compagnons ont-ils refusé la '
              'nourriture du roi ?',
          options: <String>[
            'Pour rester fidèles à leurs principes',
            'Parce qu’ils n’avaient pas faim',
            'Par manque de moyens',
            'Sur ordre du roi lui-même',
          ],
          correctIndex: 0,
          explanation:
              'Leur intégrité est récompensée par la santé (Daniel 1).',
        ),
        QuizQuestion(
          text: 'Que représente la statue du songe de Nebucadnetsar '
              'interprétée par Daniel ?',
          options: <String>[
            'Une succession de royaumes mondiaux',
            'Une simple œuvre d’art',
            'Un rêve sans signification',
            'Une prophétie sur Daniel personnellement',
          ],
          correctIndex: 0,
          explanation:
              'Un royaume final établi par Dieu surpasse tous les '
              'autres (Daniel 2).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé quand Shadrak, Méshak et '
              'Abed-Nego ont refusé d’adorer la statue d’or ?',
          options: <String>[
            'Ils ont été protégés dans la fournaise ardente',
            'Ils ont été immédiatement exécutés',
            'Ils se sont soumis finalement',
            'Ils ont fui le royaume',
          ],
          correctIndex: 0,
          explanation:
              'Un miracle démontre la protection divine (Daniel 3).',
        ),
      ],
      'Daniel#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel message mystérieux apparaît sur le mur pendant le '
              'festin de Belshatsar ?',
          options: <String>[
            'Une écriture annonçant la chute du royaume',
            'Un poème de célébration',
            'Une liste de trésors',
            'Un message de paix',
          ],
          correctIndex: 0,
          explanation:
              'Babylone tombe cette nuit-là même (Daniel 5).',
        ),
        QuizQuestion(
          text: 'Pourquoi Daniel a-t-il été jeté dans la fosse aux '
              'lions ?',
          options: <String>[
            'Il continuait de prier malgré un décret l’interdisant',
            'Il avait volé au roi',
            'Il avait trahi le royaume',
            'Il refusait de travailler',
          ],
          correctIndex: 0,
          explanation:
              'Sa fidélité à la prière est mise à l’épreuve (Daniel 6).',
        ),
        QuizQuestion(
          text: 'Que voit Daniel dans sa vision des quatre bêtes ?',
          options: <String>[
            'Des royaumes successifs, puis un royaume éternel donné à '
                'un « fils d’homme »',
            'Une simple scène pastorale',
            'La fin immédiate du monde',
            'Une guerre sans signification prophétique',
          ],
          correctIndex: 0,
          explanation:
              'Une vision clé sur la domination éternelle promise '
              '(Daniel 7).',
        ),
      ],
      'Daniel#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que fait Daniel avant de recevoir la prophétie des '
              '« 70 semaines » ?',
          options: <String>[
            'Il prie et confesse les péchés de son peuple',
            'Il organise un festin',
            'Il quitte Babylone',
            'Il consulte des devins',
          ],
          correctIndex: 0,
          explanation:
              'Sa prière sincère précède la réponse de Gabriel '
              '(Daniel 9).',
        ),
        QuizQuestion(
          text: 'Qui apparaît à Daniel près du Tigre pour lui expliquer '
              'un conflit céleste ?',
          options: <String>[
            'Un messager céleste envoyé après un combat spirituel',
            'Un roi humain uniquement',
            'Un simple songe sans messager',
            'Nabuchodonosor en personne',
          ],
          correctIndex: 0,
          explanation:
              'Une lutte spirituelle est révélée à Daniel (Daniel 10).',
        ),
        QuizQuestion(
          text: 'Quelle espérance finale conclut le livre de Daniel ?',
          options: <String>[
            'Une résurrection est promise, et la purification du peuple',
            'La fin sans aucun espoir',
            'La destruction totale sans avenir',
            'Le silence définitif de Dieu',
          ],
          correctIndex: 0,
          explanation:
              'Michael se lève et une espérance de résurrection est '
              'donnée (Daniel 12).',
        ),
      ],
      'Hosea#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’a demandé Jéhovah à Osée pour illustrer '
              'l’infidélité d’Israël ?',
          options: <String>[
            'Épouser une femme infidèle, Gomer',
            'Construire un nouvel autel',
            'Partir en exil volontaire',
            'Jeûner pendant un an',
          ],
          correctIndex: 0,
          explanation:
              'Le mariage d’Osée illustre la relation Dieu-Israël '
              '(Osée 1).',
        ),
        QuizQuestion(
          text: 'Quel manque Jéhovah reproche-t-il à son peuple au '
              'chapitre 4 ?',
          options: <String>[
            'Le manque de connaissance de Dieu',
            'Le manque de richesse',
            'Le manque de rois compétents',
            'Le manque de terres',
          ],
          correctIndex: 0,
          explanation:
              '« Mon peuple périt par manque de connaissance » '
              '(Osée 4:6).',
        ),
      ],
      'Hosea#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que préfère Jéhovah au sacrifice, selon Osée 6 ?',
          options: <String>['L’amour fidèle (la bonté de cœur)', 'Des offrandes abondantes', 'Un temple plus grand', 'Des cérémonies plus longues'],
          correctIndex: 0,
          explanation:
              '« Je prends plaisir à la bonté de cœur, non aux '
              'sacrifices » (Osée 6:6).',
        ),
        QuizQuestion(
          text: 'Que récolte Israël après avoir « semé le vent » selon '
              'Osée 8 ?',
          options: <String>['La tempête', 'La paix durable', 'La richesse', 'Rien de particulier'],
          correctIndex: 0,
          explanation:
              'Une image des conséquences de l’infidélité (Osée 8:7).',
        ),
      ],
      'Hosea#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Jéhovah exprime-t-il son attachement paternel '
              'à Éphraïm en Osée 11 ?',
          options: <String>[
            '« Comment pourrais-je t’abandonner, Éphraïm ? »',
            'Il déclare vouloir l’oublier définitivement',
            'Il refuse toute compassion',
            'Il ignore complètement son sort',
          ],
          correctIndex: 0,
          explanation:
              'Une tendresse paternelle malgré la rébellion '
              '(Osée 11:8).',
        ),
        QuizQuestion(
          text: 'Quelle promesse finale conclut le livre d’Osée ?',
          options: <String>[
            'Jéhovah guérira leur infidélité et les aimera librement',
            'Israël restera puni pour toujours',
            'Aucune restauration n’est promise',
            'Le peuple sera totalement effacé',
          ],
          correctIndex: 0,
          explanation:
              'Un appel final à la repentance et l’espoir (Osée 14).',
        ),
      ],
      'Joel#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel fléau frappe le pays au début du livre de Joël ?',
          options: <String>['Une invasion de sauterelles', 'Une guerre civile', 'Une sécheresse de dix ans', 'Une épidémie'],
          correctIndex: 0,
          explanation:
              'Un fléau sans précédent est décrit (Joël 1).',
        ),
        QuizQuestion(
          text: 'Quel appel Joël lance-t-il face à ce désastre ?',
          options: <String>['Se lamenter et jeûner', 'Célébrer une fête', 'Ignorer l’événement', 'Émigrer immédiatement'],
          correctIndex: 0,
          explanation:
              'Un appel à la repentance collective (Joël 1).',
        ),
      ],
      'Joel#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que demande Joël 2 plutôt qu’un simple rite extérieur ?',
          options: <String>[
            'Déchirer son cœur, et non ses vêtements',
            'Offrir plus de sacrifices',
            'Construire un nouveau temple',
            'Payer une amende',
          ],
          correctIndex: 0,
          explanation:
              'Une repentance sincère est demandée (Joël 2:13).',
        ),
        QuizQuestion(
          text: 'Quelle promesse de Joël 2 est citée par Pierre le jour '
              'de la Pentecôte ?',
          options: <String>[
            'Je répandrai mon esprit sur toute chair',
            'Je détruirai le temple',
            'Je bénirai uniquement les prêtres',
            'Aucune promesse notable',
          ],
          correctIndex: 0,
          explanation:
              'Citée en Actes 2 lors de la Pentecôte (Joël 2:28).',
        ),
      ],
      'Joel#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Où les nations sont-elles jugées selon Joël 3 ?',
          options: <String>['Dans la vallée de la Décision', 'À Babylone', 'À Ninive', 'En Égypte'],
          correctIndex: 0,
          explanation:
              'Un jugement collectif y est annoncé (Joël 3:14).',
        ),
        QuizQuestion(
          text: 'Que promet Joël 3 à Juda après le jugement des '
              'nations ?',
          options: <String>['Bénédiction et restauration', 'Une destruction définitive', 'Un exil supplémentaire', 'Rien de particulier'],
          correctIndex: 0,
          explanation:
              'Une conclusion pleine d’espérance (Joël 3).',
        ),
      ],
      'Amos#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre quelles nations Amos prononce-t-il des '
              'jugements au début du livre ?',
          options: <String>[
            'Damas, Gaza, Tyr, Édom, Ammon, Moab, puis Juda et Israël',
            'Seulement l’Égypte',
            'Seulement Babylone',
            'Aucune nation étrangère',
          ],
          correctIndex: 0,
          explanation:
              'Une série d’oracles précède le message central '
              '(Amos 1-2).',
        ),
        QuizQuestion(
          text: 'Que déclare Amos 3 sur la manière dont Dieu agit ?',
          options: <String>[
            'Il ne fait rien sans le révéler à ses prophètes',
            'Il agit toujours dans le secret total',
            'Il n’intervient jamais dans l’histoire',
            'Il n’a pas besoin de messagers',
          ],
          correctIndex: 0,
          explanation:
              'Le rôle prophétique est souligné (Amos 3:7).',
        ),
      ],
      'Amos#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui Amos 4 critique-t-il en les comparant aux « vaches '
              'de Basan » ?',
          options: <String>[
            'Les femmes riches qui oppriment les pauvres',
            'Les prêtres uniquement',
            'Les prophètes étrangers',
            'Les rois voisins',
          ],
          correctIndex: 0,
          explanation:
              'Une critique sociale directe (Amos 4:1).',
        ),
        QuizQuestion(
          text: 'Que demande Amos 5 au peuple concernant la justice ?',
          options: <String>[
            'Que la justice roule comme les eaux',
            'Que la justice soit reportée indéfiniment',
            'Que seuls les riches soient jugés',
            'Que la justice reste symbolique',
          ],
          correctIndex: 0,
          explanation:
              'Un appel célèbre à la justice réelle (Amos 5:24).',
        ),
      ],
      'Amos#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel instrument symbolique Dieu utilise-t-il dans une '
              'vision pour juger Israël ?',
          options: <String>['Un fil à plomb', 'Une balance vide', 'Une trompette brisée', 'Un sceptre royal'],
          correctIndex: 0,
          explanation:
              'L’image teste la droiture d’un mur (Amos 7).',
        ),
        QuizQuestion(
          text: 'Que promet Amos 9 malgré le jugement annoncé ?',
          options: <String>[
            'La restauration de la « hutte tombée » de David',
            'La destruction définitive sans espoir',
            'L’oubli total du peuple',
            'La fin de toute promesse divine',
          ],
          correctIndex: 0,
          explanation:
              'Une note d’espérance conclut le livre (Amos 9:11).',
        ),
      ],
      'Obadiah#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre qui le court livre d’Abdias est-il dirigé ?',
          options: <String>['Édom', 'Babylone', 'Ninive', 'L’Égypte'],
          correctIndex: 0,
          explanation:
              'Édom est jugé pour sa violence envers son frère '
              'Jacob (Abdias 1).',
        ),
        QuizQuestion(
          text: 'Quelle affirmation conclut le livre d’Abdias ?',
          options: <String>[
            'Le royaume appartiendra à Jéhovah',
            'Édom dominera pour toujours',
            'Israël disparaîtra définitivement',
            'Aucun jugement n’aura lieu',
          ],
          correctIndex: 0,
          explanation:
              'Une affirmation de la souveraineté divine (Abdias 21).',
        ),
      ],
      'Jonah#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Jonas a-t-il fui vers Tarsis au lieu d’aller '
              'à Ninive ?',
          options: <String>[
            'Il voulait échapper à la mission confiée par Jéhovah',
            'Il ignorait la mission',
            'Il avait déjà accompli sa tâche',
            'Ninive l’avait invité personnellement',
          ],
          correctIndex: 0,
          explanation:
              'Jonas tente de fuir sa mission (Jonas 1).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé quand Jonas a été jeté à la mer ?',
          options: <String>[
            'Il a été avalé par un grand poisson',
            'Il a nagé jusqu’au rivage seul',
            'Il s’est noyé immédiatement',
            'Un navire l’a repêché aussitôt',
          ],
          correctIndex: 0,
          explanation:
              'Un événement extraordinaire le sauve (Jonas 1:17).',
        ),
      ],
      'Jonah#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que fait Jonas depuis l’intérieur du poisson ?',
          options: <String>['Il prie Jéhovah', 'Il dort profondément', 'Il proteste avec colère', 'Il reste silencieux'],
          correctIndex: 0,
          explanation:
              'Une prière de détresse et de reconnaissance (Jonas 2).',
        ),
        QuizQuestion(
          text: 'Comment Ninive a-t-elle réagi au message de Jonas ?',
          options: <String>[
            'La ville entière s’est repentie, du roi au peuple',
            'Elle a ignoré totalement le message',
            'Elle a expulsé Jonas immédiatement',
            'Elle a déclaré la guerre à Israël',
          ],
          correctIndex: 0,
          explanation:
              'Un repentir collectif surprenant (Jonas 3).',
        ),
      ],
      'Jonah#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Jonas était-il mécontent après la repentance '
              'de Ninive ?',
          options: <String>[
            'Il aurait préféré que Dieu détruise la ville',
            'Il voulait plus d’argent',
            'Il voulait rester à Ninive',
            'Il n’était pas du tout mécontent',
          ],
          correctIndex: 0,
          explanation:
              'Jonas peine à accepter la miséricorde divine (Jonas 4).',
        ),
        QuizQuestion(
          text: 'Que veut enseigner Jéhovah à Jonas avec la plante qui '
              'se fane ?',
          options: <String>[
            'L’importance de la compassion, même envers des étrangers',
            'L’inutilité de toute compassion',
            'La valeur uniquement matérielle des plantes',
            'Un simple fait botanique',
          ],
          correctIndex: 0,
          explanation:
              'Une leçon sur la compassion divine (Jonas 4).',
        ),
      ],
      'Micah#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre quelles villes le jugement de Michée est-il '
              'annoncé au début du livre ?',
          options: <String>['Samarie et Jérusalem', 'Ninive et Babylone', 'Tyr et Sidon', 'Damas seul'],
          correctIndex: 0,
          explanation:
              'Les deux capitales sont visées (Michée 1).',
        ),
        QuizQuestion(
          text: 'Quel abus social Michée 2 dénonce-t-il ?',
          options: <String>[
            'La convoitise de champs et de maisons volés aux pauvres',
            'Le manque de sacrifices',
            'L’absence de fêtes religieuses',
            'Le manque de prêtres',
          ],
          correctIndex: 0,
          explanation:
              'Une injustice sociale est condamnée (Michée 2).',
        ),
      ],
      'Micah#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que promet Michée 5 concernant un dirigeant futur ?',
          options: <String>[
            'Il viendra de Bethléhem',
            'Il viendra de Babylone',
            'Il viendra d’Égypte',
            'Aucun lieu n’est précisé',
          ],
          correctIndex: 0,
          explanation:
              'Une prophétie messianique précise (Michée 5:2).',
        ),
        QuizQuestion(
          text: 'Quelle vision de paix Michée 4 partage-t-il, semblable '
              'à Ésaïe ?',
          options: <String>[
            'Les épées transformées en socs de charrue',
            'Une guerre perpétuelle',
            'La destruction de toutes les nations',
            'Un silence total sur l’avenir',
          ],
          correctIndex: 0,
          explanation:
              'Une image de paix universelle (Michée 4:3).',
        ),
      ],
      'Micah#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que requiert Jéhovah de l’homme selon Michée 6 ?',
          options: <String>[
            'Pratiquer la justice, aimer la bonté, marcher humblement avec Dieu',
            'Offrir uniquement des sacrifices coûteux',
            'Construire de grands temples',
            'Éviter toute activité publique',
          ],
          correctIndex: 0,
          explanation:
              'Un résumé célèbre de la piété authentique (Michée '
              '6:8).',
        ),
        QuizQuestion(
          text: 'Quelle espérance Michée exprime-t-il malgré la '
              'corruption ambiante ?',
          options: <String>[
            'Dieu montrera de nouveau sa compassion',
            'Aucun espoir n’est possible',
            'Le jugement sera définitif sans pardon',
            'Le peuple doit se venger seul',
          ],
          correctIndex: 0,
          explanation:
              'Une confiance renouvelée conclut le livre (Michée 7).',
        ),
      ],
      'Nahum#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Nahum 1 décrit-il le caractère de Jéhovah ?',
          options: <String>[
            'Patient mais puissant dans sa justice',
            'Indifférent aux injustices',
            'Faible face aux nations',
            'Sans aucune émotion',
          ],
          correctIndex: 0,
          explanation:
              'Un équilibre entre patience et puissance (Nahum 1).',
        ),
        QuizQuestion(
          text: 'À qui Nahum offre-t-il du réconfort malgré le jugement '
              'annoncé ?',
          options: <String>['À ceux qui se réfugient en lui', 'Aux habitants de Ninive uniquement', 'Aux rois étrangers', 'À personne'],
          correctIndex: 0,
          explanation:
              'Une consolation pour les fidèles (Nahum 1:7).',
        ),
      ],
      'Nahum#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que décrit avec intensité Nahum 2 ?',
          options: <String>['Le siège et la chute de Ninive', 'La construction d’un temple', 'Une fête de la moisson', 'Un couronnement royal'],
          correctIndex: 0,
          explanation:
              'Une description vivante de bataille (Nahum 2).',
        ),
        QuizQuestion(
          text: 'Quel ton domine cette description de la chute de '
              'Ninive ?',
          options: <String>['Un jugement inévitable et complet', 'Une simple mise en garde légère', 'Un espoir de paix durable', 'Une négociation en cours'],
          correctIndex: 0,
          explanation:
              'La fin de Ninive est présentée comme certaine '
              '(Nahum 2).',
        ),
      ],
      'Nahum#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Nahum 3 qualifie-t-il Ninive ?',
          options: <String>['La ville sanguinaire', 'La ville sainte', 'La ville de la paix', 'La ville bénie'],
          correctIndex: 0,
          explanation:
              'Un jugement sévère pour sa violence (Nahum 3:1).',
        ),
        QuizQuestion(
          text: 'Quelle est l’issue finale annoncée pour Ninive ?',
          options: <String>['Une destruction totale', 'Une restauration future', 'Une alliance avec Israël', 'Un simple avertissement sans suite'],
          correctIndex: 0,
          explanation:
              'Le livre se termine sur la chute irréversible de la '
              'ville (Nahum 3).',
        ),
      ],
      'Habakkuk#0': <QuizQuestion>[
        QuizQuestion(
          text: 'De quoi Habacuc se plaint-il au début du livre ?',
          options: <String>[
            'De l’injustice et de la violence qui persistent sans réponse',
            'D’un manque de nourriture',
            'D’une invasion imminente uniquement',
            'D’un conflit personnel avec un prêtre',
          ],
          correctIndex: 0,
          explanation:
              'Une plainte sincère face à l’injustice (Habacuc 1).',
        ),
        QuizQuestion(
          text: 'Quelle réponse surprenante Dieu donne-t-il à Habacuc ?',
          options: <String>[
            'Il utilisera les Chaldéens (Babyloniens) pour juger',
            'Il ne fera rien du tout',
            'Il détruira immédiatement Babylone',
            'Il ignorera la situation',
          ],
          correctIndex: 0,
          explanation:
              'Une réponse qui trouble davantage le prophète '
              '(Habacuc 1).',
        ),
      ],
      'Habakkuk#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle vérité célèbre Habacuc 2 affirme-t-il sur le '
              'juste ?',
          options: <String>[
            'Le juste vivra par sa fidélité',
            'Le juste doit toujours douter',
            'Seule la richesse sauve le juste',
            'Le juste n’a aucune espérance',
          ],
          correctIndex: 0,
          explanation:
              'Une déclaration reprise plus tard dans les Écritures '
              'grecques (Habacuc 2:4).',
        ),
        QuizQuestion(
          text: 'Que remplira toute la terre selon Habacuc 2 ?',
          options: <String>[
            'La connaissance de la gloire de Jéhovah',
            'La richesse des nations',
            'Le silence total',
            'La domination de Babylone pour toujours',
          ],
          correctIndex: 0,
          explanation:
              'Une promesse universelle d’espérance (Habacuc 2:14).',
        ),
      ],
      'Habakkuk#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle attitude Habacuc adopte-t-il dans sa prière '
              'finale malgré l’absence de récolte ?',
          options: <String>[
            'Il se réjouira quand même en Jéhovah',
            'Il abandonnera sa foi',
            'Il maudira Dieu',
            'Il fuira loin de son pays',
          ],
          correctIndex: 0,
          explanation:
              'Une confiance qui dépasse les circonstances '
              '(Habacuc 3:17, 18).',
        ),
        QuizQuestion(
          text: 'Comment le livre d’Habacuc se conclut-il ?',
          options: <String>[
            'Par un chant de confiance en la force donnée par Dieu',
            'Par un jugement sans espoir',
            'Par une liste de lois',
            'Par un silence complet',
          ],
          correctIndex: 0,
          explanation:
              'Un psaume de foi termine le livre (Habacuc 3).',
        ),
      ],
      'Zephaniah#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel événement central Sophonie 1 annonce-t-il ?',
          options: <String>[
            'Le grand jour de Jéhovah, jour de jugement',
            'Une fête de la moisson',
            'La construction d’un nouveau palais',
            'Une alliance commerciale',
          ],
          correctIndex: 0,
          explanation:
              'Un jugement universel est annoncé (Sophonie 1).',
        ),
        QuizQuestion(
          text: 'Sur qui ce jugement porte-t-il en premier lieu ?',
          options: <String>['Juda et Jérusalem', 'Seulement l’Égypte', 'Seulement Ninive', 'Seulement Édom'],
          correctIndex: 0,
          explanation:
              'Le jugement commence par le peuple de Dieu '
              '(Sophonie 1).',
        ),
      ],
      'Zephaniah#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que conseille Sophonie 2 avant l’arrivée du jugement ?',
          options: <String>['Chercher Jéhovah et l’humilité', 'Se réjouir sans souci', 'Ignorer les avertissements', 'Fuir sans réfléchir'],
          correctIndex: 0,
          explanation:
              'Un appel urgent à la repentance (Sophonie 2:3).',
        ),
        QuizQuestion(
          text: 'Quelles nations sont aussi jugées dans ce chapitre ?',
          options: <String>['Les nations voisines comme Moab et Ammon', 'Seulement Israël', 'Aucune autre nation', 'Seulement Babylone'],
          correctIndex: 0,
          explanation:
              'Le jugement s’étend aux nations environnantes '
              '(Sophonie 2).',
        ),
      ],
      'Zephaniah#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle promesse joyeuse conclut le livre de Sophonie ?',
          options: <String>[
            'Jéhovah se réjouira de son peuple avec des chants',
            'Le jugement restera permanent',
            'Aucune restauration n’est promise',
            'Le peuple sera oublié pour toujours',
          ],
          correctIndex: 0,
          explanation:
              'Une image touchante de joie divine (Sophonie 3:17).',
        ),
        QuizQuestion(
          text: 'Que promet Sophonie 3 concernant un reste fidèle ?',
          options: <String>[
            'Il sera purifié et rassemblé',
            'Il disparaîtra complètement',
            'Il sera exilé pour toujours',
            'Il n’aura aucun avenir',
          ],
          correctIndex: 0,
          explanation:
              'Un espoir de restauration pour les fidèles '
              '(Sophonie 3).',
        ),
      ],
      'Haggai#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel reproche Aggée adresse-t-il au peuple revenu '
              'd’exil ?',
          options: <String>[
            'Ils avaient négligé la reconstruction du temple',
            'Ils avaient trop travaillé au temple',
            'Ils n’avaient pas assez d’argent, ce qui était compréhensible',
            'Ils avaient bâti trop de temples',
          ],
          correctIndex: 0,
          explanation:
              'Le peuple priorisait ses propres maisons (Aggée 1).',
        ),
        QuizQuestion(
          text: 'Quelle promesse encourage la reprise des travaux du '
              'temple ?',
          options: <String>[
            'La gloire de cette maison surpassera la précédente',
            'Le temple ne sera jamais achevé',
            'Aucun encouragement n’est donné',
            'Le temple sera abandonné définitivement',
          ],
          correctIndex: 0,
          explanation:
              'Un encouragement fort pour Zorobabel et le peuple '
              '(Aggée 2:9).',
        ),
      ],
      'Zechariah#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel type de révélations reçoit Zacharie au début du '
              'livre ?',
          options: <String>[
            'Une série de visions nocturnes symboliques',
            'Un simple discours public',
            'Une lettre d’un roi étranger',
            'Un décret royal uniquement',
          ],
          correctIndex: 0,
          explanation:
              'Huit visions nocturnes structurent ces chapitres '
              '(Zacharie 1-5).',
        ),
        QuizQuestion(
          text: 'Que symbolise la purification de Josué le grand '
              'prêtre dans une de ces visions ?',
          options: <String>[
            'Le pardon et le renouvellement du sacerdoce',
            'La condamnation définitive des prêtres',
            'La fin du sacerdoce',
            'Un simple changement de vêtements sans signification',
          ],
          correctIndex: 0,
          explanation:
              'Ses vêtements sales sont remplacés par des vêtements '
              'de fête (Zacharie 3).',
        ),
      ],
      'Zechariah#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment le roi messianique futur est-il décrit en '
              'Zacharie 9 ?',
          options: <String>[
            'Humble, monté sur un ânon',
            'Conquérant sur un char de guerre',
            'Invisible et sans forme',
            'Accompagné d’une grande armée',
          ],
          correctIndex: 0,
          explanation:
              'Une prophétie accomplie lors de l’entrée triomphale de '
              'Jésus (Zacharie 9:9).',
        ),
        QuizQuestion(
          text: 'Que répond Zacharie 7-8 à la question sur le jeûne '
              'rituel ?',
          options: <String>[
            'La justice et la miséricorde comptent plus que le rite',
            'Le jeûne seul suffit toujours',
            'Le jeûne doit être aboli immédiatement',
            'Aucune réponse n’est donnée',
          ],
          correctIndex: 0,
          explanation:
              'Un accent sur l’attitude du cœur plutôt que le rituel '
              '(Zacharie 7-8).',
        ),
      ],
      'Zechariah#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle prophétie de Zacharie 11 est associée à la '
              'trahison de Judas ?',
          options: <String>[
            'Les trente pièces d’argent',
            'La destruction du temple',
            'La chute de Babylone',
            'Un jugement contre l’Égypte',
          ],
          correctIndex: 0,
          explanation:
              'Ce détail est repris dans les récits évangéliques '
              '(Zacharie 11:12, 13).',
        ),
        QuizQuestion(
          text: 'Comment le livre de Zacharie se conclut-il '
              'concernant l’avenir ?',
          options: <String>[
            'Jéhovah deviendra roi sur toute la terre',
            'Le monde restera divisé pour toujours',
            'Aucun espoir final n’est donné',
            'Jérusalem disparaîtra définitivement',
          ],
          correctIndex: 0,
          explanation:
              'Une vision universelle de royauté divine (Zacharie '
              '14:9).',
        ),
      ],
      'Malachi#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel reproche Malachie adresse-t-il aux prêtres au '
              'chapitre 1 ?',
          options: <String>[
            'Offrir des sacrifices défectueux à Jéhovah',
            'Ne jamais offrir de sacrifices',
            'Trop prier',
            'Construire un second temple',
          ],
          correctIndex: 0,
          explanation:
              'Le mépris envers les offrandes est dénoncé '
              '(Malachie 1).',
        ),
        QuizQuestion(
          text: 'Comment Malachie 1 illustre-t-il l’amour de Jéhovah '
              'pour son peuple ?',
          options: <String>[
            'En contrastant Jacob et Ésaü',
            'En ignorant totalement Israël',
            'En favorisant une autre nation',
            'En ne faisant aucune distinction',
          ],
          correctIndex: 0,
          explanation:
              'Un contraste souligne la faveur accordée à Jacob '
              '(Malachie 1:2, 3).',
        ),
      ],
      'Malachi#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que demande Malachie 3 concernant les dîmes ?',
          options: <String>[
            'Apporter la dîme entière et « mettre Dieu à l’épreuve »',
            'Supprimer totalement la dîme',
            'La réserver uniquement aux riches',
            'L’offrir seulement une fois par vie',
          ],
          correctIndex: 0,
          explanation:
              'Un défi à faire confiance à Dieu concrètement '
              '(Malachie 3:10).',
        ),
        QuizQuestion(
          text: 'Quel messager Malachie 3 annonce-t-il avant la venue '
              'du Seigneur ?',
          options: <String>[
            'Un messager qui préparera le chemin',
            'Un roi étranger',
            'Un nouveau prêtre uniquement',
            'Aucun messager n’est mentionné',
          ],
          correctIndex: 0,
          explanation:
              'Une prophétie liée à Jean le Baptiste (Malachie 3:1).',
        ),
      ],
      'Malachi#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel jour redoutable Malachie 4 annonce-t-il ?',
          options: <String>[
            'Le grand et redoutable jour de Jéhovah',
            'Un jour de fête sans conséquence',
            'Un simple jour de marché',
            'Aucun jour particulier',
          ],
          correctIndex: 0,
          explanation:
              'Une image de jugement final (Malachie 4:1).',
        ),
        QuizQuestion(
          text: 'Qui Malachie annonce-t-il devoir revenir avant ce '
              'jour ?',
          options: <String>['Élie', 'Moïse', 'David', 'Salomon'],
          correctIndex: 0,
          explanation:
              'Cette prophétie est reliée à Jean le Baptiste dans les '
              'Évangiles (Malachie 4:5).',
        ),
      ],
      'Mark#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui prépare le chemin devant Jésus au début de Marc ?',
          options: <String>['Jean le Baptiste', 'Élie en personne', 'Un ange', 'Le grand prêtre'],
          correctIndex: 0,
          explanation:
              'Jean baptise et annonce la venue de Jésus (Marc 1).',
        ),
        QuizQuestion(
          text: 'Comment Jésus a-t-il montré son autorité en guérissant '
              'le paralytique descendu par le toit ?',
          options: <String>[
            'En pardonnant ses péchés avant de le guérir',
            'En exigeant un sacrifice préalable',
            'En le renvoyant sans réponse',
            'En consultant les pharisiens d’abord',
          ],
          correctIndex: 0,
          explanation:
              'Le pardon précède la guérison physique (Marc 2).',
        ),
        QuizQuestion(
          text: 'Que raconte la parabole du semeur en Marc 4 ?',
          options: <String>[
            'Différents accueils réservés à la parole de Dieu',
            'Une simple leçon d’agriculture',
            'Un jugement contre les agriculteurs',
            'Une prophétie sur la famine',
          ],
          correctIndex: 0,
          explanation:
              'Les types de terrain illustrent les cœurs (Marc 4).',
        ),
      ],
      'Mark#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que s’est-il passé lorsque les cinq mille ont été '
              'nourris ?',
          options: <String>[
            'Cinq pains et deux poissons ont suffi et sont restés',
            'Chacun avait apporté sa propre nourriture',
            'La foule est repartie affamée',
            'Un marché a été improvisé',
          ],
          correctIndex: 0,
          explanation:
              'Un miracle de multiplication (Marc 6).',
        ),
        QuizQuestion(
          text: 'Quelle scène extraordinaire se produit sur la '
              'montagne en Marc 9 ?',
          options: <String>['La transfiguration de Jésus', 'Un tremblement de terre', 'Une tempête violente', 'Un jugement public'],
          correctIndex: 0,
          explanation:
              'Jésus apparaît glorieux avec Moïse et Élie (Marc 9).',
        ),
        QuizQuestion(
          text: 'Comment Jésus entre-t-il à Jérusalem en Marc 11 ?',
          options: <String>['Monté sur un ânon, acclamé par la foule', 'En secret, sans être vu', 'Avec une armée', 'À cheval en conquérant'],
          correctIndex: 0,
          explanation:
              'L’entrée triomphale accomplit une prophétie (Marc 11).',
        ),
      ],
      'Mark#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel grand commandement Jésus cite-t-il en Marc 12 ?',
          options: <String>[
            'Aimer Dieu de tout son cœur et son prochain comme soi-même',
            'Payer scrupuleusement l’impôt',
            'Jeûner chaque semaine',
            'Éviter tout contact avec les étrangers',
          ],
          correctIndex: 0,
          explanation:
              'Jésus résume la loi en deux commandements (Marc 12).',
        ),
        QuizQuestion(
          text: 'Qu’a institué Jésus lors du dernier repas avec ses '
              'disciples ?',
          options: <String>[
            'Le repas commémoratif de sa mort',
            'Une nouvelle fête annuelle',
            'Un jeûne collectif',
            'Un pèlerinage obligatoire',
          ],
          correctIndex: 0,
          explanation:
              'Le pain et le vin symbolisent son sacrifice (Marc 14).',
        ),
        QuizQuestion(
          text: 'Que découvrent les femmes venues au tombeau le '
              'troisième jour ?',
          options: <String>[
            'Le tombeau est vide, Jésus est ressuscité',
            'Le corps de Jésus est encore là',
            'Le tombeau est scellé et inaccessible',
            'Rien d’inhabituel',
          ],
          correctIndex: 0,
          explanation:
              'La résurrection est annoncée par un ange (Marc 16).',
        ),
      ],
      'Luke#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui annonce à Marie qu’elle sera la mère de Jésus ?',
          options: <String>['L’ange Gabriel', 'Un prêtre', 'Jean le Baptiste', 'Un rêve seulement'],
          correctIndex: 0,
          explanation:
              'Gabriel annonce la naissance miraculeuse (Luc 1).',
        ),
        QuizQuestion(
          text: 'Qui a rendu témoignage à Jésus enfant lors de sa '
              'présentation au temple ?',
          options: <String>['Siméon et Anne', 'Hérode', 'Les grands prêtres', 'Personne'],
          correctIndex: 0,
          explanation:
              'Deux fidèles âgés reconnaissent le Messie (Luc 2).',
        ),
        QuizQuestion(
          text: 'Quel discours célèbre Jésus prononce-t-il en Luc 6 ?',
          options: <String>[
            'Le sermon dans la plaine, avec bonheurs et malheurs',
            'Un discours sur les impôts',
            'Une annonce de guerre',
            'Un jugement contre Rome',
          ],
          correctIndex: 0,
          explanation:
              'Un enseignement moral majeur (Luc 6).',
        ),
      ],
      'Luke#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle parabole célèbre illustre l’amour du prochain '
              'en Luc 10 ?',
          options: <String>['Le bon Samaritain', 'Le fils prodigue', 'Le semeur', 'Les dix vierges'],
          correctIndex: 0,
          explanation:
              'Un exemple de compassion envers un étranger (Luc 10).',
        ),
        QuizQuestion(
          text: 'Quelles trois paraboles Jésus raconte-t-il en Luc 15 '
              'sur ce qui est perdu ?',
          options: <String>[
            'La brebis perdue, la pièce perdue, le fils prodigue',
            'Le semeur, le filet, la perle',
            'Le figuier, la vigne, le blé',
            'Les talents, les mines, le trésor',
          ],
          correctIndex: 0,
          explanation:
              'Trois images de la joie retrouvée (Luc 15).',
        ),
        QuizQuestion(
          text: 'Que révèle la parabole du riche et de Lazare en '
              'Luc 16 ?',
          options: <String>[
            'Un contraste entre indifférence et compassion',
            'Une leçon sur l’agriculture',
            'Un conseil financier pratique',
            'Une prophétie sur Rome',
          ],
          correctIndex: 0,
          explanation:
              'Une parabole sur les priorités du cœur (Luc 16).',
        ),
      ],
      'Luke#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que fait Zachée pour montrer son changement de vie '
              'après avoir rencontré Jésus ?',
          options: <String>[
            'Il rend le quadruple à ceux qu’il a lésés',
            'Il quitte la ville',
            'Il ignore Jésus finalement',
            'Il refuse de partager ses biens',
          ],
          correctIndex: 0,
          explanation:
              'Sa générosité illustre sa conversion sincère (Luc 19).',
        ),
        QuizQuestion(
          text: 'Que demande le malfaiteur repentant à Jésus sur le '
              'poteau ?',
          options: <String>[
            'De se souvenir de lui dans son royaume',
            'De le libérer immédiatement',
            'De punir ses accusateurs',
            'De prouver sa puissance publiquement',
          ],
          correctIndex: 0,
          explanation:
              'Jésus lui promet le paradis (Luc 23).',
        ),
        QuizQuestion(
          text: 'Que se passe-t-il sur le chemin d’Emmaüs après la '
              'résurrection ?',
          options: <String>[
            'Jésus ressuscité explique les Écritures à deux disciples',
            'Les disciples sont arrêtés',
            'Un ange interdit tout voyage',
            'Rien de particulier ne se produit',
          ],
          correctIndex: 0,
          explanation:
              'Ils le reconnaissent en partageant le pain (Luc 24).',
        ),
      ],
      'Acts#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que promet Jésus à ses disciples juste avant son '
              'ascension ?',
          options: <String>[
            'Ils recevront la puissance de l’esprit saint',
            'Ils règneront immédiatement sur Rome',
            'Ils ne le reverront jamais',
            'Ils devront fuir aussitôt',
          ],
          correctIndex: 0,
          explanation:
              'Une promesse essentielle avant Pentecôte (Actes 1).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé le jour de la Pentecôte ?',
          options: <String>[
            'L’esprit saint a été répandu sur les disciples',
            'Un tremblement de terre a détruit le temple',
            'Les apôtres ont fui Jérusalem',
            'Rien d’inhabituel ne s’est produit',
          ],
          correctIndex: 0,
          explanation:
              'La congrégation chrétienne commence ce jour-là '
              '(Actes 2).',
        ),
        QuizQuestion(
          text: 'Qui est devenu le premier martyr chrétien ?',
          options: <String>['Étienne', 'Pierre', 'Jacques seul', 'Philippe'],
          correctIndex: 0,
          explanation:
              'Étienne est lapidé après son discours (Actes 7).',
        ),
      ],
      'Acts#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Saul a-t-il été transformé sur le chemin de '
              'Damas ?',
          options: <String>[
            'Une lumière et une voix de Jésus l’ont converti',
            'Il a simplement changé d’avis seul',
            'Un roi l’a forcé à changer',
            'Rien ne s’est produit sur ce chemin',
          ],
          correctIndex: 0,
          explanation:
              'Sa rencontre avec Jésus change sa vie (Actes 9).',
        ),
        QuizQuestion(
          text: 'Quelle vision Pierre reçoit-il avant de rencontrer '
              'Corneille ?',
          options: <String>[
            'Une grande toile avec des animaux, signifiant l’ouverture '
                'aux non-Juifs',
            'Une bataille céleste',
            'Un temple en flammes',
            'Un rêve sans signification',
          ],
          correctIndex: 0,
          explanation:
              'Cette vision prépare Pierre à annoncer la bonne '
              'nouvelle aux nations (Actes 10).',
        ),
        QuizQuestion(
          text: 'Où les disciples ont-ils été appelés « chrétiens » '
              'pour la première fois ?',
          options: <String>['À Antioche', 'À Jérusalem', 'À Rome', 'À Éphèse'],
          correctIndex: 0,
          explanation:
              'Ce nom apparaît d’abord à Antioche (Actes 11:26).',
        ),
      ],
      'Acts#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle décision importante prend le conseil de '
              'Jérusalem concernant les non-Juifs convertis ?',
          options: <String>[
            'Ils ne sont pas tenus à la circoncision mosaïque',
            'Ils doivent suivre toute la loi de Moïse',
            'Ils sont exclus de la congrégation',
            'Aucune décision n’est prise',
          ],
          correctIndex: 0,
          explanation:
              'Une décision clé pour l’expansion du christianisme '
              '(Actes 15).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé pour Paul et Silas emprisonnés à '
              'Philippes ?',
          options: <String>[
            'Un tremblement de terre a ouvert les portes de la prison',
            'Ils se sont évadés secrètement',
            'Ils sont restés enfermés à vie',
            'Personne n’est intervenu',
          ],
          correctIndex: 0,
          explanation:
              'Un miracle libère les prisonniers (Actes 16).',
        ),
        QuizQuestion(
          text: 'Où Paul a-t-il prononcé son célèbre discours sur le '
              '« Dieu inconnu » ?',
          options: <String>['À l’Aréopage, à Athènes', 'À Rome', 'À Jérusalem', 'À Corinthe'],
          correctIndex: 0,
          explanation:
              'Paul s’adresse aux philosophes grecs (Actes 17).',
        ),
      ],
      'Acts#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Que raconte Paul dans sa défense après son arrestation '
              'au temple ?',
          options: <String>[
            'Sa conversion sur le chemin de Damas',
            'Une victoire militaire',
            'Un voyage commercial',
            'Une dispute personnelle',
          ],
          correctIndex: 0,
          explanation:
              'Paul témoigne de son expérience personnelle (Actes 22).',
        ),
        QuizQuestion(
          text: 'Pourquoi Paul a-t-il fait appel à César ?',
          options: <String>[
            'Pour obtenir un procès équitable en tant que citoyen romain',
            'Pour éviter tout procès',
            'Pour être libéré immédiatement',
            'Parce qu’il voulait quitter le ministère',
          ],
          correctIndex: 0,
          explanation:
              'Son statut de citoyen romain lui donne ce droit '
              '(Actes 25).',
        ),
        QuizQuestion(
          text: 'Que s’est-il passé après le naufrage sur l’île de '
              'Malte ?',
          options: <String>[
            'Paul a été mordu par une vipère sans être blessé',
            'Il a été arrêté par les habitants',
            'Le navire est reparti immédiatement',
            'Rien de particulier ne s’est produit',
          ],
          correctIndex: 0,
          explanation:
              'Un signe miraculeux impressionne les habitants '
              '(Actes 28).',
        ),
      ],
      'Romans#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que déclare Paul sur la situation de tous les humains, '
              'Juifs et non-Juifs, en Romains 3 ?',
          options: <String>[
            'Tous ont péché et sont privés de la gloire de Dieu',
            'Seuls les non-Juifs ont péché',
            'Personne n’a réellement péché',
            'Seuls les dirigeants sont responsables',
          ],
          correctIndex: 0,
          explanation:
              'Une base essentielle de l’argument de Paul (Romains '
              '3:23).',
        ),
        QuizQuestion(
          text: 'Sur quoi repose la justification selon Romains 3-4, '
              'illustrée par Abraham ?',
          options: <String>[
            'La foi, et non les œuvres de la loi',
            'Uniquement les sacrifices rituels',
            'La richesse personnelle',
            'L’origine ethnique',
          ],
          correctIndex: 0,
          explanation:
              'Abraham a été déclaré juste par la foi (Romains 4).',
        ),
      ],
      'Romans#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que déclare Romains 8 sur l’amour de Dieu envers les '
              'chrétiens ?',
          options: <String>[
            'Rien ne peut nous séparer de l’amour de Dieu',
            'Cet amour est conditionnel et fragile',
            'Il ne concerne que quelques élus',
            'Il disparaît en cas d’épreuve',
          ],
          correctIndex: 0,
          explanation:
              'Une affirmation puissante conclut ce chapitre '
              '(Romains 8:38, 39).',
        ),
        QuizQuestion(
          text: 'Que dit Romains 10 sur le salut ?',
          options: <String>[
            'Quiconque invoque le nom de Jéhovah sera sauvé',
            'Seuls les prêtres peuvent être sauvés',
            'Le salut dépend uniquement de la naissance',
            'Aucun salut n’est possible pour les nations',
          ],
          correctIndex: 0,
          explanation:
              'Une promesse universelle est citée (Romains 10:13).',
        ),
      ],
      'Romans#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que demande Romains 12 aux chrétiens concernant leur '
              'vie quotidienne ?',
          options: <String>[
            'S’offrir comme un sacrifice vivant à Dieu',
            'Éviter toute activité sociale',
            'Se retirer complètement du monde',
            'Ne jamais utiliser leurs dons',
          ],
          correctIndex: 0,
          explanation:
              'Un appel à une consécration pratique (Romains 12:1).',
        ),
        QuizQuestion(
          text: 'Quel principe Romains 13 établit-il concernant les '
              'autorités ?',
          options: <String>[
            'Être soumis aux autorités supérieures',
            'Ignorer systématiquement les lois',
            'Se révolter contre tout gouvernement',
            'Payer des impôts uniquement si on le souhaite',
          ],
          correctIndex: 0,
          explanation:
              'Un principe de respect civique est enseigné '
              '(Romains 13).',
        ),
      ],
      '1 Corinthians#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel problème Paul aborde-t-il dès le début de cette '
              'lettre ?',
          options: <String>[
            'Les divisions et rivalités dans la congrégation',
            'Un manque de nourriture',
            'Une invasion militaire',
            'Une absence totale de foi',
          ],
          correctIndex: 0,
          explanation:
              'Des factions autour de différents enseignants posaient '
              'problème (1 Corinthiens 1).',
        ),
        QuizQuestion(
          text: 'À quoi Paul compare-t-il l’église dans 1 Corinthiens 3 '
              '?',
          options: <String>[
            'Au temple de Dieu',
            'À une armée',
            'À un simple bâtiment vide',
            'À une entreprise commerciale',
          ],
          correctIndex: 0,
          explanation:
              'Une image sacrée souligne la responsabilité collective '
              '(1 Corinthiens 3:16).',
        ),
      ],
      '1 Corinthians#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Paul aborde-t-il la question de la nourriture '
              'offerte aux idoles ?',
          options: <String>[
            'L’amour et la conscience du prochain priment sur la liberté',
            'Il l’interdit absolument sans exception',
            'Il l’encourage sans réserve',
            'Il refuse d’aborder le sujet',
          ],
          correctIndex: 0,
          explanation:
              'Un équilibre entre liberté et considération pour '
              'autrui (1 Corinthiens 8).',
        ),
        QuizQuestion(
          text: 'Quelle attitude Paul adopte-t-il pour gagner les gens '
              'à l’Évangile, selon 1 Corinthiens 9 ?',
          options: <String>[
            'Devenir toutes choses pour tous, dans la mesure du possible',
            'Rester rigide dans toutes ses habitudes',
            'Éviter tout contact avec les autres cultures',
            'Exiger un paiement pour prêcher',
          ],
          correctIndex: 0,
          explanation:
              'Une flexibilité motivée par l’amour (1 Corinthiens '
              '9:22).',
        ),
      ],
      '1 Corinthians#2': <QuizQuestion>[
        QuizQuestion(
          text: 'À quoi Paul compare-t-il la diversité des dons '
              'spirituels dans la congrégation ?',
          options: <String>[
            'Aux différentes parties d’un même corps',
            'À des rivaux séparés',
            'À des étrangers sans lien',
            'À des dons sans utilité',
          ],
          correctIndex: 0,
          explanation:
              'Une image d’unité malgré la diversité (1 Corinthiens '
              '12).',
        ),
        QuizQuestion(
          text: 'Quelle qualité Paul décrit-il comme supérieure à tous '
              'les dons dans le célèbre chapitre 13 ?',
          options: <String>['L’amour', 'La richesse', 'La renommée', 'Le pouvoir'],
          correctIndex: 0,
          explanation:
              'Sans amour, tout le reste est vain (1 Corinthiens 13).',
        ),
      ],
      '2 Corinthians#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Paul décrit-il le réconfort qu’il a reçu dans '
              'l’épreuve ?',
          options: <String>[
            'Un réconfort à partager ensuite avec d’autres',
            'Un réconfort réservé uniquement à lui-même',
            'Une absence totale de réconfort',
            'Un réconfort venant seulement des hommes',
          ],
          correctIndex: 0,
          explanation:
              'Le réconfort divin se transmet aux autres '
              '(2 Corinthiens 1).',
        ),
        QuizQuestion(
          text: 'À quoi Paul compare-t-il les chrétiens transformés en '
              '2 Corinthiens 3-4 ?',
          options: <String>[
            'À des trésors précieux dans des vases d’argile fragiles',
            'À des rois puissants',
            'À des guerriers invincibles',
            'À des statues immuables',
          ],
          correctIndex: 0,
          explanation:
              'Une image d’humilité et de puissance divine '
              '(2 Corinthiens 4:7).',
        ),
      ],
      '2 Corinthians#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel appel central Paul lance-t-il en 2 Corinthiens 5 ?',
          options: <String>['Réconciliez-vous avec Dieu', 'Cherchez la richesse avant tout', 'Évitez toute prédication', 'Fuyez toute responsabilité'],
          correctIndex: 0,
          explanation:
              'Le message central de la réconciliation (2 Corinthiens '
              '5:20).',
        ),
        QuizQuestion(
          text: 'Quel principe Paul enseigne-t-il sur le don généreux '
              'en 2 Corinthiens 9 ?',
          options: <String>[
            'Dieu aime celui qui donne joyeusement',
            'Le don doit toujours être forcé',
            'Seuls les riches doivent donner',
            'Le don n’a pas d’importance',
          ],
          correctIndex: 0,
          explanation:
              '« Dieu aime celui qui donne joyeusement » '
              '(2 Corinthiens 9:7).',
        ),
      ],
      '2 Corinthians#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Paul répond-il à son « écharde dans la '
              'chair » en 2 Corinthiens 12 ?',
          options: <String>[
            'Il accepte que la puissance de Dieu s’accomplisse dans la '
                'faiblesse',
            'Il abandonne son ministère',
            'Il exige une guérison immédiate',
            'Il accuse Dieu d’injustice',
          ],
          correctIndex: 0,
          explanation:
              '« Ma puissance s’accomplit dans la faiblesse » '
              '(2 Corinthiens 12:9).',
        ),
        QuizQuestion(
          text: 'Quel appel final Paul lance-t-il en 2 Corinthiens 13 ?',
          options: <String>[
            'S’examiner soi-même pour voir si l’on est dans la foi',
            'Ignorer tout examen personnel',
            'Juger sévèrement les autres uniquement',
            'Abandonner toute réflexion spirituelle',
          ],
          correctIndex: 0,
          explanation:
              'Un appel à l’introspection sincère (2 Corinthiens '
              '13:5).',
        ),
      ],
      'Galatians#0': <QuizQuestion>[
        QuizQuestion(
          text: 'D’où Paul affirme-t-il tenir son autorité apostolique ?',
          options: <String>[
            'Directement de Jésus Christ, non des hommes',
            'De la nomination des apôtres de Jérusalem seulement',
            'De sa propre décision personnelle',
            'D’une tradition familiale',
          ],
          correctIndex: 0,
          explanation:
              'Paul défend la légitimité de sa mission (Galates 1).',
        ),
        QuizQuestion(
          text: 'Pourquoi Paul a-t-il repris Pierre publiquement ?',
          options: <String>[
            'Pierre évitait par hypocrisie de manger avec les non-Juifs',
            'Pierre avait volé de l’argent',
            'Pierre avait renié sa foi',
            'Pierre refusait de prêcher',
          ],
          correctIndex: 0,
          explanation:
              'Une incohérence pratique est corrigée (Galates 2).',
        ),
      ],
      'Galatians#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Sur quoi repose la justification selon Galates 3, '
              'illustrée par Abraham ?',
          options: <String>[
            'La foi, et non les œuvres de la loi',
            'La descendance biologique uniquement',
            'La richesse personnelle',
            'Le statut social',
          ],
          correctIndex: 0,
          explanation:
              'Un principe central repris de la vie d’Abraham '
              '(Galates 3:6).',
        ),
        QuizQuestion(
          text: 'Quel rôle la loi a-t-elle joué selon Galates 3-4, en '
              'attendant Christ ?',
          options: <String>[
            'Celui d’un pédagogue menant à Christ',
            'Un moyen définitif de salut',
            'Un simple rituel sans signification',
            'Une malédiction sans but',
          ],
          correctIndex: 0,
          explanation:
              'La loi préparait à la venue du Messie (Galates 3:24).',
        ),
      ],
      'Galatians#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel fruit de l’esprit Galates 5 met-il en avant, en '
              'contraste avec les œuvres de la chair ?',
          options: <String>[
            'Amour, joie, paix, patience et autres qualités',
            'Richesse et pouvoir',
            'Ambition personnelle',
            'Domination sur les autres',
          ],
          correctIndex: 0,
          explanation:
              'Une liste de qualités chrétiennes essentielles '
              '(Galates 5:22, 23).',
        ),
        QuizQuestion(
          text: 'Que conseille Galates 6 concernant les fardeaux des '
              'autres ?',
          options: <String>[
            'Les porter les uns des autres',
            'Les ignorer complètement',
            'Les juger sévèrement',
            'Les éviter à tout prix',
          ],
          correctIndex: 0,
          explanation:
              'Un appel à l’entraide fraternelle (Galates 6:2).',
        ),
      ],
      'Ephesians#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Par quoi les chrétiens sont-ils sauvés selon '
              'Éphésiens 2 ?',
          options: <String>[
            'Par la grâce, au moyen de la foi, non par les œuvres',
            'Uniquement par leurs bonnes actions',
            'Par leur origine ethnique',
            'Par leur richesse matérielle',
          ],
          correctIndex: 0,
          explanation:
              'Un principe fondamental du salut (Éphésiens 2:8, 9).',
        ),
        QuizQuestion(
          text: 'Que réalise Christ entre Juifs et non-Juifs selon '
              'Éphésiens 2 ?',
          options: <String>[
            'Il les unit en une seule humanité nouvelle',
            'Il maintient une séparation permanente',
            'Il favorise un groupe au détriment de l’autre',
            'Il ignore cette distinction',
          ],
          correctIndex: 0,
          explanation:
              'Le mur de séparation est abattu (Éphésiens 2:14).',
        ),
      ],
      'Ephesians#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel « mystère » Paul dit-il avoir reçu à révéler aux '
              'nations ?',
          options: <String>[
            'Que les non-Juifs sont cohéritiers de la promesse',
            'Un secret réservé à quelques privilégiés',
            'Un enseignement caché sur les anges',
            'Une prophétie sur Rome',
          ],
          correctIndex: 0,
          explanation:
              'Une inclusion inattendue des nations (Éphésiens 3:6).',
        ),
        QuizQuestion(
          text: 'Que doivent « revêtir » les chrétiens selon '
              'Éphésiens 4 ?',
          options: <String>[
            'La nouvelle personnalité, semblable à Dieu',
            'Des vêtements somptueux',
            'Une richesse visible',
            'Un statut social supérieur',
          ],
          correctIndex: 0,
          explanation:
              'Un changement intérieur profond est demandé '
              '(Éphésiens 4:24).',
        ),
      ],
      'Ephesians#2': <QuizQuestion>[
        QuizQuestion(
          text: 'À quoi Paul compare-t-il la relation entre le mari et '
              'sa femme en Éphésiens 5 ?',
          options: <String>[
            'À la relation entre Christ et la congrégation',
            'À une simple association commerciale',
            'À une hiérarchie sans amour',
            'À une compétition permanente',
          ],
          correctIndex: 0,
          explanation:
              'Un modèle d’amour sacrificiel est proposé '
              '(Éphésiens 5:25).',
        ),
        QuizQuestion(
          text: 'Que représente « l’armure complète de Dieu » en '
              'Éphésiens 6 ?',
          options: <String>[
            'Des qualités spirituelles pour résister au combat spirituel',
            'Un équipement militaire littéral',
            'Une simple métaphore sans application',
            'Un uniforme religieux',
          ],
          correctIndex: 0,
          explanation:
              'Chaque pièce symbolise une qualité protectrice '
              '(Éphésiens 6:11-17).',
        ),
      ],
      'Philippians#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Paul perçoit-il sa situation d’emprisonnement '
              'dans cette lettre ?',
          options: <String>[
            'Il s’en réjouit, car cela sert à l’avancement de '
                'l’Évangile',
            'Il en est totalement désespéré',
            'Il abandonne son ministère',
            'Il accuse ses geôliers sans espoir',
          ],
          correctIndex: 0,
          explanation:
              'Une attitude positive malgré l’épreuve (Philippiens 1).',
        ),
        QuizQuestion(
          text: 'Quelle déclaration célèbre résume la perspective de '
              'Paul sur la vie et la mort ?',
          options: <String>[
            '« Pour moi, vivre c’est Christ, et mourir est un gain »',
            '« La vie n’a aucun sens »',
            '« Mieux vaut fuir toute épreuve »',
            '« La mort est à éviter à tout prix »',
          ],
          correctIndex: 0,
          explanation:
              'Une confiance totale en Christ (Philippiens 1:21).',
        ),
      ],
      'Philippians#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel exemple d’humilité Paul propose-t-il en '
              'Philippiens 2 ?',
          options: <String>[
            'Christ, qui s’est abaissé jusqu’à devenir esclave',
            'Un roi puissant et glorieux',
            'Un philosophe célèbre',
            'Un général victorieux',
          ],
          correctIndex: 0,
          explanation:
              'Un modèle d’humilité extrême (Philippiens 2:5-8).',
        ),
        QuizQuestion(
          text: 'Que dit Paul avoir abandonné pour gagner Christ en '
              'Philippiens 3 ?',
          options: <String>[
            'Tous ses avantages et réalisations passées',
            'Rien de particulier',
            'Uniquement sa nationalité',
            'Sa vie de prière',
          ],
          correctIndex: 0,
          explanation:
              'Il considère tout comme une perte face à Christ '
              '(Philippiens 3:8).',
        ),
      ],
      'Philippians#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que promet Philippiens 4 à ceux qui prient sans '
              'anxiété ?',
          options: <String>[
            'La paix de Dieu qui surpasse toute pensée',
            'Une richesse immédiate',
            'L’absence totale de problèmes',
            'Rien de particulier',
          ],
          correctIndex: 0,
          explanation:
              'Une promesse de paix intérieure (Philippiens 4:6, 7).',
        ),
        QuizQuestion(
          text: 'Quelle affirmation de confiance Paul fait-il sur sa '
              'force personnelle ?',
          options: <String>[
            '« Je peux tout par celui qui me fortifie »',
            '« Je réussis seul, sans aide »',
            '« Je dépends uniquement des hommes »',
            '« Rien ne me soutient vraiment »',
          ],
          correctIndex: 0,
          explanation:
              'Une confiance placée en Christ (Philippiens 4:13).',
        ),
      ],
      'Colossians#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Colossiens 1 décrit-il la position de Christ '
              'par rapport à la création ?',
          options: <String>[
            'Tout a été créé par lui et pour lui',
            'Il est une créature parmi d’autres, sans distinction',
            'Il n’a aucun rôle dans la création',
            'Il est postérieur à toute création',
          ],
          correctIndex: 0,
          explanation:
              'Une place centrale est accordée à Christ (Colossiens '
              '1:16).',
        ),
        QuizQuestion(
          text: 'Quel « mystère » Paul dit-il avoir la mission de '
              'révéler ?',
          options: <String>[
            'Christ en vous, l’espérance de la gloire',
            'Un enseignement réservé secrètement à quelques-uns',
            'Une prophétie sur Rome',
            'Un rituel caché du temple',
          ],
          correctIndex: 0,
          explanation:
              'Une vérité désormais rendue publique (Colossiens '
              '1:27).',
        ),
      ],
      'Colossians#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre quoi Paul met-il en garde en Colossiens 2 ?',
          options: <String>[
            'La philosophie vide et les traditions humaines',
            'La prière elle-même',
            'La foi authentique',
            'L’enseignement des apôtres',
          ],
          correctIndex: 0,
          explanation:
              'Une mise en garde contre les fausses doctrines '
              '(Colossiens 2:8).',
        ),
        QuizQuestion(
          text: 'Que doivent « revêtir » les chrétiens selon '
              'Colossiens 3 ?',
          options: <String>[
            'La nouvelle personnalité, avec compassion et amour',
            'Des vêtements coûteux',
            'Une attitude de supériorité',
            'Rien de particulier',
          ],
          correctIndex: 0,
          explanation:
              'Un changement intérieur concret est demandé '
              '(Colossiens 3:10, 12).',
        ),
      ],
      'Colossians#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Paul encourage-t-il à se comporter envers les '
              'personnes extérieures à la foi ?',
          options: <String>[
            'Avec sagesse, en profitant bien du temps',
            'Avec indifférence totale',
            'En les évitant systématiquement',
            'Avec mépris ouvert',
          ],
          correctIndex: 0,
          explanation:
              'Un comportement avisé est recommandé (Colossiens 4:5).',
        ),
        QuizQuestion(
          text: 'Quel ton caractérise la fin de la lettre aux '
              'Colossiens ?',
          options: <String>[
            'Des salutations personnelles chaleureuses',
            'Un jugement sévère',
            'Une liste de lois supplémentaires',
            'Un silence abrupt',
          ],
          correctIndex: 0,
          explanation:
              'Paul termine par des salutations affectueuses '
              '(Colossiens 4).',
        ),
      ],
      '1 Thessalonians#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Paul décrit-il la foi des Thessaloniciens ?',
          options: <String>[
            'Un exemple pour les croyants environnants',
            'Faible et hésitante',
            'Inexistante au départ',
            'Basée uniquement sur la crainte',
          ],
          correctIndex: 0,
          explanation:
              'Leur foi est devenue un modèle reconnu '
              '(1 Thessaloniciens 1).',
        ),
        QuizQuestion(
          text: 'Comment Paul décrit-il son ministère parmi eux ?',
          options: <String>[
            'Sincère, comme une mère prenant soin de ses enfants',
            'Intéressé et calculateur',
            'Distant et froid',
            'Basé sur la flatterie',
          ],
          correctIndex: 0,
          explanation:
              'Une image tendre de son dévouement '
              '(1 Thessaloniciens 2:7).',
        ),
      ],
      '1 Thessalonians#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Pourquoi Paul a-t-il envoyé Timothée aux '
              'Thessaloniciens ?',
          options: <String>[
            'Pour affermir leur foi face aux épreuves',
            'Pour collecter de l’argent uniquement',
            'Pour les réprimander sévèrement',
            'Pour mettre fin à la congrégation',
          ],
          correctIndex: 0,
          explanation:
              'Un souci pastoral motive cet envoi (1 Thessaloniciens '
              '3).',
        ),
        QuizQuestion(
          text: 'Quel sentiment Paul exprime-t-il en apprenant leur '
              'fidélité persistante ?',
          options: <String>['Une grande joie', 'De la déception', 'De l’indifférence', 'De la colère'],
          correctIndex: 0,
          explanation:
              'Leur constance le réconforte profondément '
              '(1 Thessaloniciens 3:8, 9).',
        ),
      ],
      '1 Thessalonians#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment 1 Thessaloniciens 4 décrit-il la résurrection '
              'des croyants ?',
          options: <String>[
            'Ils seront enlevés pour rencontrer le Seigneur',
            'Ils resteront indéfiniment dans la tombe',
            'Aucune résurrection n’est mentionnée',
            'Seuls quelques privilégiés ressusciteront',
          ],
          correctIndex: 0,
          explanation:
              'Une espérance centrale pour les croyants '
              '(1 Thessaloniciens 4:17).',
        ),
        QuizQuestion(
          text: 'À quoi le jour de Jéhovah est-il comparé en '
              '1 Thessaloniciens 5 ?',
          options: <String>['À un voleur dans la nuit', 'À une fête prévisible', 'À un jour ordinaire', 'À un simple avertissement sans effet'],
          correctIndex: 0,
          explanation:
              'Une image d’arrivée soudaine et inattendue '
              '(1 Thessaloniciens 5:2).',
        ),
      ],
      '2 Thessalonians#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Paul encourage-t-il les Thessaloniciens '
              'persécutés ?',
          options: <String>[
            'En rappelant le jugement juste que Dieu rendra',
            'En leur promettant une fin immédiate des épreuves',
            'En les blâmant pour leur situation',
            'En les incitant à abandonner la foi',
          ],
          correctIndex: 0,
          explanation:
              'Une espérance de justice divine les encourage '
              '(2 Thessaloniciens 1).',
        ),
        QuizQuestion(
          text: 'Quelle inquiétude Paul corrige-t-il concernant le '
              'jour du Seigneur ?',
          options: <String>[
            'Croire à tort qu’il était déjà arrivé',
            'Croire qu’il n’arriverait jamais',
            'Ignorer totalement le sujet',
            'Penser qu’il fallait cesser de prier',
          ],
          correctIndex: 0,
          explanation:
              'Une confusion est clarifiée (2 Thessaloniciens 2:2).',
        ),
      ],
      '2 Thessalonians#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que doit se manifester avant le jour du Seigneur '
              'selon 2 Thessaloniciens 2 ?',
          options: <String>['L’homme d’illégalité', 'Un roi juste', 'Une paix universelle', 'Rien de particulier'],
          correctIndex: 0,
          explanation:
              'Un signe précurseur est annoncé (2 Thessaloniciens '
              '2:3).',
        ),
        QuizQuestion(
          text: 'Quel encouragement Paul donne-t-il malgré cette '
              'annonce troublante ?',
          options: <String>[
            'Rester fermes dans les enseignements reçus',
            'Abandonner toute espérance',
            'Cesser toute activité chrétienne',
            'Se disperser immédiatement',
          ],
          correctIndex: 0,
          explanation:
              'Un appel à la persévérance (2 Thessaloniciens 2:15).',
        ),
      ],
      '2 Thessalonians#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel principe Paul établit-il concernant le travail '
              'en 2 Thessaloniciens 3 ?',
          options: <String>[
            'Si quelqu’un ne veut pas travailler, qu’il ne mange pas '
                'non plus',
            'Le travail est inutile pour les chrétiens',
            'Seuls les riches doivent travailler',
            'Le travail remplace la foi',
          ],
          correctIndex: 0,
          explanation:
              'Une mise en garde contre l’oisiveté (2 Thessaloniciens '
              '3:10).',
        ),
        QuizQuestion(
          text: 'Comment Paul conclut-il cette lettre ?',
          options: <String>[
            'Par une salutation de sa propre main, signe d’authenticité',
            'Par un silence abrupt',
            'Par une nouvelle accusation',
            'Par une liste de règles supplémentaires',
          ],
          correctIndex: 0,
          explanation:
              'Sa signature garantit l’authenticité de la lettre '
              '(2 Thessaloniciens 3:17).',
        ),
      ],
      '1 Timothy#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre quoi Paul met-il en garde Timothée dès le '
              'début de la lettre ?',
          options: <String>[
            'Les enseignements différents et les fables sans fin',
            'Le manque de richesse',
            'Un excès de prière',
            'Le mariage en général',
          ],
          correctIndex: 0,
          explanation:
              'Paul veut préserver la pureté de l’enseignement '
              '(1 Timothée 1).',
        ),
        QuizQuestion(
          text: 'Pour qui Paul demande-t-il que des prières soient '
              'faites en 1 Timothée 2 ?',
          options: <String>[
            'Pour tous les hommes, y compris les rois et autorités',
            'Uniquement pour les apôtres',
            'Uniquement pour sa propre famille',
            'Pour personne en particulier',
          ],
          correctIndex: 0,
          explanation:
              'Une prière inclusive est recommandée (1 Timothée 2:1, '
              '2).',
        ),
      ],
      '1 Timothy#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelles qualités sont exigées des surveillants selon '
              '1 Timothée 3 ?',
          options: <String>[
            'Être irréprochables, maîtres d’eux-mêmes, hospitaliers',
            'Être riches avant tout',
            'Être jeunes uniquement',
            'Avoir une grande renommée publique',
          ],
          correctIndex: 0,
          explanation:
              'Des critères moraux précis sont donnés '
              '(1 Timothée 3).',
        ),
        QuizQuestion(
          text: 'Que dit 1 Timothée 4 sur l’exercice physique comparé '
              'à la piété ?',
          options: <String>[
            'La piété est utile à tout, l’exercice physique est '
                'limité',
            'L’exercice physique est plus important',
            'Aucun des deux n’a de valeur',
            'Seul l’exercice physique compte vraiment',
          ],
          correctIndex: 0,
          explanation:
              'Un ordre de priorité est établi (1 Timothée 4:8).',
        ),
      ],
      '1 Timothy#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que recommande 1 Timothée 5 concernant les veuves '
              'dans le besoin ?',
          options: <String>[
            'Que la famille en prenne soin en priorité',
            'De les ignorer complètement',
            'De leur interdire toute aide',
            'De les exclure de la congrégation',
          ],
          correctIndex: 0,
          explanation:
              'La responsabilité familiale est soulignée '
              '(1 Timothée 5:4).',
        ),
        QuizQuestion(
          text: 'Que dit 1 Timothée 6 sur l’amour de l’argent ?',
          options: <String>[
            'C’est une racine de toutes sortes de choses nuisibles',
            'C’est toujours une bonne chose',
            'Cela n’a aucune conséquence',
            'Cela garantit le bonheur',
          ],
          correctIndex: 0,
          explanation:
              'Un avertissement célèbre sur la cupidité '
              '(1 Timothée 6:10).',
        ),
      ],
      '2 Timothy#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que demande Paul à Timothée concernant son don reçu '
              'par l’imposition des mains ?',
          options: <String>[
            'De le raviver comme un feu',
            'De l’oublier définitivement',
            'De le garder secret',
            'De le transmettre à un étranger',
          ],
          correctIndex: 0,
          explanation:
              'Un encouragement à rester actif spirituellement '
              '(2 Timothée 1:6).',
        ),
        QuizQuestion(
          text: 'De quoi Paul dit-il ne pas avoir honte ?',
          options: <String>[
            'De la bonne nouvelle concernant Christ',
            'De sa nationalité',
            'De sa richesse',
            'De son passé uniquement',
          ],
          correctIndex: 0,
          explanation:
              'Une fermeté malgré l’emprisonnement (2 Timothée 1:8).',
        ),
      ],
      '2 Timothy#1': <QuizQuestion>[
        QuizQuestion(
          text: 'À quoi Paul compare-t-il Timothée pour illustrer '
              'l’endurance nécessaire ?',
          options: <String>[
            'À un bon soldat de Christ',
            'À un simple spectateur',
            'À un juge impartial',
            'À un marchand prudent',
          ],
          correctIndex: 0,
          explanation:
              'Une image de discipline et de sacrifice '
              '(2 Timothée 2:3).',
        ),
        QuizQuestion(
          text: 'Que dit 2 Timothée 3 sur l’utilité des Écritures ?',
          options: <String>[
            'Elles sont inspirées de Dieu et utiles pour enseigner',
            'Elles sont dépassées et inutiles',
            'Elles ne concernent que les prêtres',
            'Elles doivent être ignorées',
          ],
          correctIndex: 0,
          explanation:
              'Une déclaration célèbre sur l’inspiration biblique '
              '(2 Timothée 3:16).',
        ),
      ],
      '2 Timothy#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle charge Paul donne-t-il à Timothée au chapitre '
              '4 ?',
          options: <String>[
            'Prêcher la parole, en toute saison',
            'Se retirer du ministère',
            'Attendre un signe avant d’agir',
            'Garder le silence prudemment',
          ],
          correctIndex: 0,
          explanation:
              'Un appel pressant à la fidélité (2 Timothée 4:2).',
        ),
        QuizQuestion(
          text: 'Comment Paul résume-t-il sa vie à la fin de cette '
              'lettre ?',
          options: <String>[
            'J’ai combattu le bon combat, achevé la course, gardé la foi',
            'J’ai échoué dans ma mission',
            'Je regrette mon ministère',
            'Je n’ai rien accompli',
          ],
          correctIndex: 0,
          explanation:
              'Un bilan de fidélité empreint de confiance '
              '(2 Timothée 4:7).',
        ),
      ],
      'Titus#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelles qualités Tite doit-il rechercher chez les '
              'anciens à établir en Crète ?',
          options: <String>[
            'Être irréprochables et attachés à un enseignement sain',
            'Être riches avant tout',
            'Être connus publiquement seulement',
            'Être jeunes uniquement',
          ],
          correctIndex: 0,
          explanation:
              'Des critères moraux stricts sont donnés (Tite 1).',
        ),
        QuizQuestion(
          text: 'Contre qui Paul met-il en garde à cause de leur '
              'mauvaise influence en Crète ?',
          options: <String>[
            'Les faux enseignants trompeurs',
            'Les autorités romaines',
            'Les familles pauvres',
            'Les commerçants honnêtes',
          ],
          correctIndex: 0,
          explanation:
              'Un avertissement clair est donné (Tite 1:10, 11).',
        ),
      ],
      'Titus#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que doit enseigner Tite aux différents groupes de la '
              'congrégation selon le chapitre 2 ?',
          options: <String>[
            'Un comportement sain et conforme à un enseignement '
                'salutaire',
            'Rien de spécifique',
            'Uniquement des règles financières',
            'Un isolement complet du monde',
          ],
          correctIndex: 0,
          explanation:
              'Des conseils adaptés à chaque groupe sont donnés '
              '(Tite 2).',
        ),
        QuizQuestion(
          text: 'Que nous enseigne la grâce de Dieu selon Tite 2 ?',
          options: <String>[
            'À vivre pieusement dans le présent système de choses',
            'À rechercher uniquement le plaisir',
            'À ignorer toute règle morale',
            'À se retirer de la société',
          ],
          correctIndex: 0,
          explanation:
              'La grâce forme le caractère chrétien (Tite 2:12).',
        ),
      ],
      'Titus#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que recommande Titre 3 concernant les autorités '
              'civiles ?',
          options: <String>[
            'Leur être soumis et prêt à toute œuvre bonne',
            'Les défier systématiquement',
            'Les ignorer totalement',
            'Refuser de payer les impôts',
          ],
          correctIndex: 0,
          explanation:
              'Un esprit de coopération civile est encouragé (Tite '
              '3:1).',
        ),
        QuizQuestion(
          text: 'Que faut-il éviter selon Tite 3 concernant les '
              'débats ?',
          options: <String>[
            'Les controverses stupides et les disputes sur la loi',
            'Toute conversation publique',
            'L’enseignement biblique',
            'La prière collective',
          ],
          correctIndex: 0,
          explanation:
              'Un conseil pratique pour préserver l’unité (Tite '
              '3:9).',
        ),
      ],
      'Philemon#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que demande Paul à Philémon au sujet d’Onésime ?',
          options: <String>[
            'De le recevoir comme un frère bien-aimé, non comme un '
                'esclave',
            'De le punir sévèrement',
            'De le vendre à un autre maître',
            'De l’ignorer complètement',
          ],
          correctIndex: 0,
          explanation:
              'Un appel à la réconciliation fraternelle (Philémon 1).',
        ),
        QuizQuestion(
          text: 'Comment Paul propose-t-il de régler toute dette '
              'd’Onésime envers Philémon ?',
          options: <String>[
            'Il propose de la prendre à son propre compte',
            'Il exige que Philémon l’efface sans discussion',
            'Il ignore totalement la question',
            'Il demande à l’Église de payer',
          ],
          correctIndex: 0,
          explanation:
              'Un geste personnel de médiation (Philémon 1:18, 19).',
        ),
      ],
      'Hebrews#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Dieu a-t-il finalement parlé aux hommes selon '
              'Hébreux 1 ?',
          options: <String>['Par son Fils', 'Uniquement par des anges', 'Par des rêves seulement', 'Il n’a jamais parlé'],
          correctIndex: 0,
          explanation:
              'Une révélation supérieure à travers Christ (Hébreux '
              '1:1, 2).',
        ),
        QuizQuestion(
          text: 'Que décrit Hébreux 4 concernant la parole de Dieu ?',
          options: <String>[
            'Elle est vivante et pénètre plus qu’une épée à deux '
                'tranchants',
            'Elle est figée et sans effet',
            'Elle ne concerne que les prêtres',
            'Elle a disparu avec le temps',
          ],
          correctIndex: 0,
          explanation:
              'Une image puissante de la parole divine (Hébreux 4:12).',
        ),
        QuizQuestion(
          text: 'Contre quoi le chapitre 3 met-il en garde, à partir '
              'de l’exemple du désert ?',
          options: <String>[
            'Un cœur incrédule qui s’éloigne de Dieu',
            'Un excès de générosité',
            'Un excès de prière',
            'Le simple fait de voyager',
          ],
          correctIndex: 0,
          explanation:
              'La génération du désert sert d’avertissement '
              '(Hébreux 3:12).',
        ),
      ],
      'Hebrews#1': <QuizQuestion>[
        QuizQuestion(
          text: 'À quel ordre sacerdotal ancien Christ est-il comparé '
              'dans cette lettre ?',
          options: <String>['Melchisédek', 'Aaron seul', 'Lévi seul', 'Aucun ordre particulier'],
          correctIndex: 0,
          explanation:
              'Un sacerdoce supérieur et permanent (Hébreux 7).',
        ),
        QuizQuestion(
          text: 'Que rend possible la nouvelle alliance selon Hébreux '
              '8 ?',
          options: <String>[
            'Une relation intérieure renouvelée avec Dieu',
            'Un simple changement de rituel extérieur',
            'La fin de toute alliance avec Dieu',
            'Aucun changement réel',
          ],
          correctIndex: 0,
          explanation:
              'Une alliance supérieure est instaurée (Hébreux 8:10).',
        ),
        QuizQuestion(
          text: 'Que purifie le sang de Christ selon Hébreux 9 ?',
          options: <String>[
            'La conscience, des œuvres mortes',
            'Uniquement le corps physique',
            'Rien de spirituel',
            'Seulement les objets du temple',
          ],
          correctIndex: 0,
          explanation:
              'Une purification intérieure profonde (Hébreux 9:14).',
        ),
      ],
      'Hebrews#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel principe fondamental Hébreux 10-11 mettent-ils '
              'en avant concernant le salut ?',
          options: <String>[
            'Le juste vivra par la foi',
            'Le salut dépend uniquement des rituels',
            'La foi n’a aucune importance',
            'Seules les œuvres extérieures comptent',
          ],
          correctIndex: 0,
          explanation:
              'Une citation clé reprise d’Habacuc (Hébreux 10:38).',
        ),
        QuizQuestion(
          text: 'Quels exemples le célèbre chapitre 11 met-il en '
              'valeur ?',
          options: <String>[
            'Abel, Noé, Abraham et d’autres fidèles par la foi',
            'Uniquement les rois d’Israël',
            'Seulement les prêtres',
            'Aucun exemple concret',
          ],
          correctIndex: 0,
          explanation:
              'Le « chapitre de la foi » cite de nombreux exemples '
              '(Hébreux 11).',
        ),
        QuizQuestion(
          text: 'Comment Hébreux 13 décrit-il Jésus Christ à travers '
              'le temps ?',
          options: <String>[
            'Le même hier, aujourd’hui et éternellement',
            'Changeant selon les époques',
            'Différent pour chaque génération',
            'Inconnaissable',
          ],
          correctIndex: 0,
          explanation:
              'Une affirmation de constance et fiabilité '
              '(Hébreux 13:8).',
        ),
      ],
      'James#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que doit-on demander avec foi selon Jacques 1 ?',
          options: <String>['La sagesse', 'La richesse', 'La popularité', 'Le pouvoir'],
          correctIndex: 0,
          explanation:
              'Dieu donne la sagesse généreusement (Jacques 1:5).',
        ),
        QuizQuestion(
          text: 'Que dit Jacques 2 sur la relation entre la foi et les '
              'œuvres ?',
          options: <String>[
            'La foi sans les œuvres est morte',
            'Les œuvres n’ont aucune importance',
            'Seule la foi compte, sans action',
            'Les œuvres remplacent totalement la foi',
          ],
          correctIndex: 0,
          explanation:
              'Une foi authentique se manifeste en actes '
              '(Jacques 2:26).',
        ),
      ],
      'James#1': <QuizQuestion>[
        QuizQuestion(
          text: 'À quoi Jacques 3 compare-t-il le pouvoir de la langue '
              '?',
          options: <String>[
            'À un petit feu capable d’embraser une grande forêt',
            'À un instrument sans conséquence',
            'À un simple outil neutre',
            'À une force toujours positive',
          ],
          correctIndex: 0,
          explanation:
              'Une image forte sur l’impact des paroles (Jacques 3:5).',
        ),
        QuizQuestion(
          text: 'Comment Jacques 3 distingue-t-il la sagesse d’en haut '
              'de la sagesse terrestre ?',
          options: <String>[
            'La sagesse divine est pure et pacifique',
            'Les deux sagesses sont identiques',
            'La sagesse terrestre est toujours meilleure',
            'Aucune différence n’est faite',
          ],
          correctIndex: 0,
          explanation:
              'Un contraste clair est établi (Jacques 3:17).',
        ),
      ],
      'James#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que conseille Jacques 4 face à l’incertitude de '
              'l’avenir ?',
          options: <String>[
            'Ne pas se vanter du lendemain',
            'Planifier sans jamais tenir compte de Dieu',
            'Ignorer complètement l’avenir',
            'Se fier uniquement à la chance',
          ],
          correctIndex: 0,
          explanation:
              'Une leçon d’humilité pratique (Jacques 4:13-15).',
        ),
        QuizQuestion(
          text: 'Que doit faire une personne malade selon Jacques 5 ?',
          options: <String>[
            'Appeler les anciens pour prier avec foi',
            'Attendre seule sans aide',
            'Consulter uniquement un devin',
            'Ignorer sa condition',
          ],
          correctIndex: 0,
          explanation:
              'Un encouragement à la prière communautaire '
              '(Jacques 5:14).',
        ),
      ],
      '1 Peter#0': <QuizQuestion>[
        QuizQuestion(
          text: 'À quoi les chrétiens sont-ils nés de nouveau selon '
              '1 Pierre 1 ?',
          options: <String>[
            'À une espérance vivante par la résurrection de Christ',
            'À une richesse matérielle immédiate',
            'À une vie sans épreuve',
            'À un statut social supérieur',
          ],
          correctIndex: 0,
          explanation:
              'Une espérance fondée sur la résurrection (1 Pierre '
              '1:3).',
        ),
        QuizQuestion(
          text: 'À quoi les chrétiens sont-ils comparés en 1 Pierre 2 ?',
          options: <String>[
            'À des pierres vivantes formant une maison spirituelle',
            'À des étrangers sans lien',
            'À des simples spectateurs',
            'À des juges suprêmes',
          ],
          correctIndex: 0,
          explanation:
              'Une image de communauté bâtie ensemble (1 Pierre 2:5).',
        ),
      ],
      '1 Peter#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel exemple 1 Pierre 3 propose-t-il face à la '
              'souffrance injuste ?',
          options: <String>[
            'Christ, qui a souffert pour nous laisser un modèle',
            'La vengeance immédiate',
            'La fuite systématique',
            'L’indifférence totale',
          ],
          correctIndex: 0,
          explanation:
              'Un modèle de patience et d’intégrité (1 Pierre 3:18).',
        ),
        QuizQuestion(
          text: 'Quelle attitude 1 Pierre 3 recommande-t-il face à '
              'ceux qui posent des questions sur la foi ?',
          options: <String>[
            'Être prêt à se défendre avec douceur et respect',
            'Refuser toute discussion',
            'Répondre avec mépris',
            'Éviter systématiquement le sujet',
          ],
          correctIndex: 0,
          explanation:
              'Une réponse respectueuse est encouragée (1 Pierre 3:15).',
        ),
      ],
      '1 Peter#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que dit 1 Pierre 4 sur l’amour entre chrétiens ?',
          options: <String>[
            'Il couvre une multitude de péchés',
            'Il n’a aucune valeur pratique',
            'Il doit rester superficiel',
            'Il est réservé à quelques-uns',
          ],
          correctIndex: 0,
          explanation:
              'Une qualité essentielle à cultiver (1 Pierre 4:8).',
        ),
        QuizQuestion(
          text: 'Quelle attitude 1 Pierre 5 demande-t-il aux anciens '
              'envers le troupeau ?',
          options: <String>[
            'Le guider volontairement, avec humilité, non par contrainte',
            'Le dominer avec autorité stricte',
            'L’ignorer largement',
            'Rechercher un gain personnel',
          ],
          correctIndex: 0,
          explanation:
              'Un modèle de direction humble est encouragé '
              '(1 Pierre 5:2, 3).',
        ),
      ],
      '2 Peter#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que Pierre encourage-t-il à ajouter à la foi en '
              '2 Pierre 1 ?',
          options: <String>[
            'La vertu, la connaissance et d’autres qualités',
            'Uniquement la richesse',
            'Rien de particulier',
            'Le pouvoir politique',
          ],
          correctIndex: 0,
          explanation:
              'Une croissance spirituelle progressive est encouragée '
              '(2 Pierre 1:5-7).',
        ),
        QuizQuestion(
          text: 'Comment 2 Pierre 1 décrit-il l’origine de la '
              'prophétie biblique ?',
          options: <String>[
            'Des hommes ont parlé poussés par l’esprit saint',
            'Elle vient uniquement de l’imagination humaine',
            'Elle n’a aucune origine divine',
            'Elle provient de traditions populaires',
          ],
          correctIndex: 0,
          explanation:
              'Une affirmation sur l’inspiration divine (2 Pierre '
              '1:21).',
        ),
      ],
      '2 Peter#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre qui 2 Pierre 2 met-il sévèrement en garde ?',
          options: <String>[
            'Les faux enseignants et faux prophètes',
            'Les autorités civiles',
            'Les nouveaux convertis',
            'Les anciens fidèles',
          ],
          correctIndex: 0,
          explanation:
              'Un avertissement détaillé est donné (2 Pierre 2).',
        ),
        QuizQuestion(
          text: 'Quels exemples historiques 2 Pierre 2 cite-t-il comme '
              'avertissement ?',
          options: <String>[
            'Le déluge et la destruction de Sodome',
            'La construction du temple',
            'La sortie d’Égypte uniquement',
            'Le règne de Salomon',
          ],
          correctIndex: 0,
          explanation:
              'Des exemples de jugement passé (2 Pierre 2:5, 6).',
        ),
      ],
      '2 Peter#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que diront les moqueurs des derniers jours selon '
              '2 Pierre 3 ?',
          options: <String>[
            'Où est la promesse de sa présence ?',
            'Le jugement est déjà arrivé',
            'Rien de particulier',
            'Ils approuveront pleinement la prophétie',
          ],
          correctIndex: 0,
          explanation:
              'Un scepticisme est annoncé à l’avance (2 Pierre 3:4).',
        ),
        QuizQuestion(
          text: 'Que promet 2 Pierre 3 après le jugement final ?',
          options: <String>[
            'De nouveaux cieux et une nouvelle terre où la justice '
                'habite',
            'La fin définitive sans avenir',
            'Un retour à l’état initial sans changement',
            'Aucune promesse particulière',
          ],
          correctIndex: 0,
          explanation:
              'Une espérance de renouveau (2 Pierre 3:13).',
        ),
      ],
      '1 John#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que devons-nous faire selon 1 Jean 1 si nous avons '
              'péché ?',
          options: <String>[
            'Confesser nos péchés pour être purifiés',
            'Les cacher soigneusement',
            'Les ignorer complètement',
            'Nous justifier sans reconnaître la faute',
          ],
          correctIndex: 0,
          explanation:
              'Une promesse de pardon sincère (1 Jean 1:9).',
        ),
        QuizQuestion(
          text: 'Comment 1 Jean 2 nous met-il en garde contre '
              '« l’amour du monde » ?',
          options: <String>[
            'Il est incompatible avec l’amour du Père',
            'Il est encouragé sans réserve',
            'Il n’a aucune conséquence',
            'Il est nécessaire au salut',
          ],
          correctIndex: 0,
          explanation:
              'Un choix clair est demandé (1 Jean 2:15).',
        ),
      ],
      '1 John#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment 1 Jean 3 définit-il les enfants de Dieu par '
              'rapport aux enfants du Diable ?',
          options: <String>[
            'Par leurs actes de justice ou d’injustice',
            'Par leur richesse',
            'Par leur origine géographique',
            'Par leur âge',
          ],
          correctIndex: 0,
          explanation:
              'Le comportement révèle l’appartenance (1 Jean 3:10).',
        ),
        QuizQuestion(
          text: 'Quel commandement central 1 Jean 3 met-il en avant ?',
          options: <String>['S’aimer les uns les autres', 'Éviter tout contact social', 'Rechercher la richesse', 'Juger sévèrement les autres'],
          correctIndex: 0,
          explanation:
              'Un test essentiel de la foi authentique (1 Jean 3:11).',
        ),
      ],
      '1 John#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment 1 Jean 4 définit-il Dieu directement ?',
          options: <String>['Dieu est amour', 'Dieu est distant', 'Dieu est indifférent', 'Dieu est sévère uniquement'],
          correctIndex: 0,
          explanation:
              'Une déclaration centrale de la lettre (1 Jean 4:8).',
        ),
        QuizQuestion(
          text: 'Que dit 1 Jean 5 sur ce qui triomphe du monde ?',
          options: <String>['Notre foi', 'La richesse', 'Le pouvoir humain', 'La chance'],
          correctIndex: 0,
          explanation:
              'Une victoire fondée sur la foi (1 Jean 5:4).',
        ),
      ],
      '2 John#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Contre quoi 2 Jean met-il en garde concernant les '
              'visiteurs enseignants ?',
          options: <String>[
            'Ne pas accueillir ceux qui nient que Christ est venu dans '
                'la chair',
            'Refuser tout visiteur sans exception',
            'Accueillir n’importe quel enseignement',
            'Ignorer totalement la doctrine',
          ],
          correctIndex: 0,
          explanation:
              'Une vigilance doctrinale est demandée (2 Jean 1:7, 10).',
        ),
        QuizQuestion(
          text: 'Quel commandement Jean rappelle-t-il comme fondamental '
              'dans cette courte lettre ?',
          options: <String>['S’aimer les uns les autres', 'Éviter toute assemblée', 'Chercher la richesse', 'Ignorer les nouveaux venus'],
          correctIndex: 0,
          explanation:
              'Un rappel constant de l’amour fraternel (2 Jean 1:5).',
        ),
      ],
      '3 John#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Pour quelle qualité Gaïus est-il félicité dans cette '
              'lettre ?',
          options: <String>[
            'Son hospitalité envers les frères itinérants',
            'Sa richesse personnelle',
            'Son silence prudent',
            'Son isolement volontaire',
          ],
          correctIndex: 0,
          explanation:
              'Sa générosité est mise en exemple (3 Jean 1:5).',
        ),
        QuizQuestion(
          text: 'Quel comportement Diotréphès manifeste-t-il dans '
              'cette lettre ?',
          options: <String>[
            'Un orgueil qui refuse l’autorité et rejette les frères',
            'Une grande humilité',
            'Une générosité exemplaire',
            'Un profond respect pour Jean',
          ],
          correctIndex: 0,
          explanation:
              'Un comportement problématique est dénoncé (3 Jean '
              '1:9, 10).',
        ),
      ],
      'Jude#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que demande Jude à ses lecteurs face aux infiltrés '
              'impies ?',
          options: <String>[
            'Combattre vigoureusement pour la foi',
            'Ignorer totalement la situation',
            'Rejoindre les infiltrés',
            'Abandonner toute conviction',
          ],
          correctIndex: 0,
          explanation:
              'Un appel ferme à la fidélité (Jude 1:3).',
        ),
        QuizQuestion(
          text: 'Quels exemples Jude cite-t-il comme avertissements '
              'historiques ?',
          options: <String>[
            'Sodome et les anges rebelles',
            'La construction du temple',
            'Le règne de Salomon',
            'La sortie d’Égypte uniquement',
          ],
          correctIndex: 0,
          explanation:
              'Des exemples de jugement passé (Jude 1:6, 7).',
        ),
      ],
      'Revelation#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Que voit Jean au début de sa vision en Révélation 1 ?',
          options: <String>[
            'Christ glorifié parmi des chandeliers d’or',
            'Une simple lettre écrite',
            'Un désert vide',
            'Une bataille terrestre',
          ],
          correctIndex: 0,
          explanation:
              'Une vision impressionnante ouvre le livre '
              '(Révélation 1).',
        ),
        QuizQuestion(
          text: 'À combien de congrégations les lettres des chapitres '
              '2-3 sont-elles adressées ?',
          options: <String>['Sept', 'Douze', 'Trois', 'Une seule'],
          correctIndex: 0,
          explanation:
              'Sept messages personnalisés sont donnés (Révélation '
              '2-3).',
        ),
        QuizQuestion(
          text: 'Qui seul est trouvé digne d’ouvrir le rouleau scellé '
              'en Révélation 5 ?',
          options: <String>[
            'L’Agneau, qui a été immolé',
            'Un ange puissant',
            'Un roi terrestre',
            'Personne ne peut l’ouvrir',
          ],
          correctIndex: 0,
          explanation:
              'Christ seul mérite cet honneur (Révélation 5:5-9).',
        ),
      ],
      'Revelation#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Que combat Micaël dans la vision de Révélation 12 ?',
          options: <String>['Le dragon (Satan)', 'Une armée humaine', 'Un roi terrestre', 'Un simple animal'],
          correctIndex: 0,
          explanation:
              'Une guerre céleste est décrite (Révélation 12:7).',
        ),
        QuizQuestion(
          text: 'Que représentent les 144 000 mentionnés avec '
              'l’Agneau en Révélation 14 ?',
          options: <String>[
            'Un groupe rassemblé avec l’Agneau sur le mont Sion',
            'Une armée militaire littérale',
            'Un peuple étranger',
            'Un simple symbole sans signification',
          ],
          correctIndex: 0,
          explanation:
              'Un groupe distinct associé à l’Agneau (Révélation 14:1).',
        ),
        QuizQuestion(
          text: 'Que contiennent les sept dernières plaies annoncées '
              'en Révélation 15 ?',
          options: <String>[
            'L’achèvement de la colère de Dieu',
            'Des bénédictions immédiates',
            'Une simple célébration',
            'Rien de significatif',
          ],
          correctIndex: 0,
          explanation:
              'Une étape finale du jugement divin (Révélation 15:1).',
        ),
      ],
      'Revelation#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Que devient « Babylone la Grande » selon Révélation '
              '17-18 ?',
          options: <String>[
            'Elle est jugée et détruite complètement',
            'Elle règne éternellement',
            'Elle devient une alliée fidèle',
            'Rien ne lui arrive',
          ],
          correctIndex: 0,
          explanation:
              'Sa chute est décrite avec des lamentations '
              '(Révélation 18).',
        ),
        QuizQuestion(
          text: 'Que se passe-t-il pour Satan au début de Révélation '
              '20 ?',
          options: <String>[
            'Il est lié pour mille ans',
            'Il devient roi éternel',
            'Il est immédiatement détruit',
            'Rien ne change pour lui',
          ],
          correctIndex: 0,
          explanation:
              'Une période de restriction lui est imposée '
              '(Révélation 20:2, 3).',
        ),
        QuizQuestion(
          text: 'Que promet Révélation 21-22 concernant la douleur et '
              'la mort ?',
          options: <String>[
            'Elles disparaîtront complètement',
            'Elles continueront pour toujours',
            'Elles s’intensifieront',
            'Rien n’est promis à ce sujet',
          ],
          correctIndex: 0,
          explanation:
              'Une espérance magnifique conclut la Bible '
              '(Révélation 21:4).',
        ),
      ],
    };

/// Computes the ordered list of checkpoints for a book (segment boundaries,
/// reflection prompt and any authored quiz).
// Additional questions merged on top of [_authoredQuizzes] for the flagship
// books (deeper quizzes), plus the previously-missing Genesis checkpoints
// (#2-#6, covering Genesis 15-50).
const Map<String, List<QuizQuestion>> _extraQuizzes =
    <String, List<QuizQuestion>>{
      'Genesis#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel arbre, au milieu du jardin d’Éden, était interdit à '
              'Adam et Ève ?',
          options: <String>[
            'L’arbre de la connaissance du bon et du mauvais',
            'L’arbre de vie uniquement',
            'Un figuier',
            'Un olivier',
          ],
          correctIndex: 0,
          explanation:
              'Dieu interdit ce seul arbre (Genèse 2:17).',
        ),
        QuizQuestion(
          text: 'Qui a trompé Ève pour qu’elle mange du fruit défendu ?',
          options: <String>['Le serpent', 'Caïn', 'Un ange', 'Adam'],
          correctIndex: 0,
          explanation:
              'Le serpent la pousse à désobéir (Genèse 3).',
        ),
      ],
      'Genesis#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel oiseau, envoyé par Noé, est revenu avec une feuille '
              'd’olivier ?',
          options: <String>['La colombe', 'Le corbeau', 'L’aigle', 'Le moineau'],
          correctIndex: 0,
          explanation:
              'La colombe montre que les eaux baissaient (Genèse 8).',
        ),
        QuizQuestion(
          text: 'Qui a béni Abram, étant roi de Salem et prêtre du Dieu '
              'Très-Haut ?',
          options: <String>['Melchisédek', 'Lot', 'Pharaon', 'Isaac'],
          correctIndex: 0,
          explanation:
              'Melchisédek bénit Abram après une victoire (Genèse 14).',
        ),
      ],
      'Genesis#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel signe de l’alliance Dieu a-t-il donné à Abraham ?',
          options: <String>['La circoncision', 'Un tatouage', 'Un anneau', 'Un bâton'],
          correctIndex: 0,
          explanation:
              'La circoncision marque l’alliance (Genèse 17).',
        ),
        QuizQuestion(
          text: 'Comment s’appelait le fils d’Abraham et d’Agar ?',
          options: <String>['Ismaël', 'Isaac', 'Ésaü', 'Jacob'],
          correctIndex: 0,
          explanation:
              'Ismaël naît d’Agar la servante (Genèse 16).',
        ),
        QuizQuestion(
          text: 'Quelles villes Dieu a-t-il détruites à cause de leur '
              'méchanceté ?',
          options: <String>['Sodome et Gomorrhe', 'Babel et Ur', 'Ninive et Tyr', 'Béthel et Aï'],
          correctIndex: 0,
          explanation:
              'Le feu détruit ces villes ; Lot est sauvé (Genèse 19).',
        ),
      ],
      'Genesis#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’est-ce que Dieu a demandé à Abraham d’offrir sur le '
              'mont Moria ?',
          options: <String>['Son fils Isaac', 'Un bélier', 'Sa tente', 'Ses troupeaux'],
          correctIndex: 0,
          explanation:
              'Dieu arrête Abraham et fournit un bélier (Genèse 22).',
        ),
        QuizQuestion(
          text: 'Contre quoi Ésaü a-t-il vendu son droit d’aînesse à '
              'Jacob ?',
          options: <String>['Un plat de lentilles', 'De l’or', 'Un troupeau', 'Une tente'],
          correctIndex: 0,
          explanation:
              'Ésaü méprise son droit d’aînesse (Genèse 25).',
        ),
        QuizQuestion(
          text: 'Qu’a vu Jacob en rêve à Béthel ?',
          options: <String>[
            'Une échelle atteignant le ciel avec des anges',
            'Une mer déchaînée',
            'Un buisson en feu',
            'Une ville en ruine',
          ],
          correctIndex: 0,
          explanation:
              'Dieu confirme ses promesses à Jacob (Genèse 28).',
        ),
      ],
      'Genesis#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel nouveau nom Jacob a-t-il reçu après avoir lutté '
              'avec l’ange ?',
          options: <String>['Israël', 'Édom', 'Abraham', 'Éphraïm'],
          correctIndex: 0,
          explanation:
              'Le nom Israël signifie « il lutte avec Dieu » (Genèse 32).',
        ),
        QuizQuestion(
          text: 'Combien de fils Jacob a-t-il eus, ancêtres des tribus '
              'd’Israël ?',
          options: <String>['Douze', 'Dix', 'Sept', 'Quatorze'],
          correctIndex: 0,
          explanation:
              'Ses douze fils fondent les tribus d’Israël (Genèse 35).',
        ),
        QuizQuestion(
          text: 'Avec qui Jacob s’est-il réconcilié après des années de '
              'séparation ?',
          options: <String>['Son frère Ésaü', 'Laban', 'Pharaon', 'Isaac'],
          correctIndex: 0,
          explanation:
              'Les deux frères se retrouvent en paix (Genèse 33).',
        ),
      ],
      'Genesis#5': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’ont fait les frères de Joseph par jalousie ?',
          options: <String>[
            'Ils l’ont vendu comme esclave',
            'Ils l’ont couronné roi',
            'Ils l’ont abandonné en Égypte',
            'Ils l’ont ignoré',
          ],
          correctIndex: 0,
          explanation:
              'Joseph est vendu et emmené en Égypte (Genèse 37).',
        ),
        QuizQuestion(
          text: 'Quel vêtement particulier Jacob avait-il offert à '
              'Joseph ?',
          options: <String>['Une belle tunique', 'Une couronne', 'Une armure', 'Un manteau de prêtre'],
          correctIndex: 0,
          explanation:
              'Ce cadeau attise la jalousie de ses frères (Genèse 37).',
        ),
        QuizQuestion(
          text: 'Qu’a interprété Joseph pour Pharaon, annonçant sept '
              'années de famine ?',
          options: <String>['Ses rêves', 'Un livre ancien', 'Les étoiles', 'Un oracle'],
          correctIndex: 0,
          explanation:
              'Joseph interprète les rêves de Pharaon (Genèse 41).',
        ),
      ],
      'Genesis#6': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment Joseph a-t-il traité ses frères une fois qu’il '
              's’est fait connaître ?',
          options: <String>[
            'Il leur a pardonné',
            'Il les a emprisonnés à vie',
            'Il les a chassés',
            'Il les a ignorés',
          ],
          correctIndex: 0,
          explanation:
              'Joseph pardonne et les nourrit (Genèse 45).',
        ),
        QuizQuestion(
          text: 'Où Jacob et sa famille se sont-ils installés en Égypte ?',
          options: <String>['Au pays de Goshen', 'À Memphis', 'À Thèbes', 'Au Sinaï'],
          correctIndex: 0,
          explanation:
              'Pharaon leur donne la région de Goshen (Genèse 47).',
        ),
        QuizQuestion(
          text: 'Comment Joseph voyait-il le mal que ses frères lui '
              'avaient fait ?',
          options: <String>[
            'Dieu l’avait tourné en bien pour sauver des vies',
            'Comme une injustice à venger',
            'Comme sans importance',
            'Comme un simple accident',
          ],
          correctIndex: 0,
          explanation:
              'Une déclaration célèbre de foi (Genèse 50:20).',
        ),
      ],
      'Exodus#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui était le frère de Moïse, désigné comme son '
              'porte-parole ?',
          options: <String>['Aaron', 'Josué', 'Jéthro', 'Caleb'],
          correctIndex: 0,
          explanation:
              'Aaron parle au peuple pour Moïse (Exode 4).',
        ),
        QuizQuestion(
          text: 'Par quel nom Dieu s’est-il désigné à Moïse au buisson '
              'ardent ?',
          options: <String>[
            '« Je serai ce que je serai »',
            '« Le Tout-Puissant seul »',
            '« Le Dieu caché »',
            '« Le roi des rois »',
          ],
          correctIndex: 0,
          explanation:
              'Dieu révèle la signification de son nom (Exode 3:14).',
        ),
      ],
      'Exodus#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle fut la dixième et dernière plaie d’Égypte ?',
          options: <String>[
            'La mort des premiers-nés',
            'Les sauterelles',
            'Les ténèbres',
            'La grêle',
          ],
          correctIndex: 0,
          explanation:
              'Cette plaie décide Pharaon à libérer Israël (Exode 12).',
        ),
        QuizQuestion(
          text: 'Que devaient mettre les Israélites sur leurs portes lors '
              'de la Pâque ?',
          options: <String>['Du sang d’agneau', 'De l’huile', 'De la farine', 'Un signe de cendre'],
          correctIndex: 0,
          explanation:
              'Le sang protège leurs premiers-nés (Exode 12).',
        ),
      ],
      'Exodus#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Comment de l’eau a-t-elle jailli pour le peuple assoiffé '
              'à Horeb ?',
          options: <String>[
            'Moïse a frappé le rocher',
            'Une source est apparue seule',
            'Il a plu abondamment',
            'Un puits a été creusé',
          ],
          correctIndex: 0,
          explanation:
              'Sur ordre de Dieu, Moïse frappe le rocher (Exode 17).',
        ),
        QuizQuestion(
          text: 'Combien de commandements composent le Décalogue donné au '
              'Sinaï ?',
          options: <String>['Dix', 'Sept', 'Douze', 'Cinq'],
          correctIndex: 0,
          explanation:
              'Les Dix Commandements sont donnés au Sinaï (Exode 20).',
        ),
      ],
      'Exodus#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Que devait contenir l’arche de l’alliance ?',
          options: <String>[
            'Les tables de la Loi',
            'De l’or et de l’argent',
            'Des rouleaux de prophéties',
            'Des offrandes de nourriture',
          ],
          correctIndex: 0,
          explanation:
              'Les tables des commandements y sont placées (Exode 25).',
        ),
        QuizQuestion(
          text: 'Qui a fabriqué le veau d’or pendant l’absence de Moïse ?',
          options: <String>['Aaron', 'Josué', 'Hour', 'Betsaléel'],
          correctIndex: 0,
          explanation:
              'Aaron cède à la demande du peuple (Exode 32).',
        ),
      ],
      'Exodus#4': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’est-ce qui caractérisait le visage de Moïse après '
              'qu’il ait parlé à Dieu ?',
          options: <String>['Il rayonnait', 'Il était voilé de tristesse', 'Il avait vieilli', 'Rien de particulier'],
          correctIndex: 0,
          explanation:
              'Moïse devait voiler son visage rayonnant (Exode 34).',
        ),
        QuizQuestion(
          text: 'Qu’est-ce qui remplissait le tabernacle une fois achevé ?',
          options: <String>[
            'La gloire de Jéhovah (une nuée)',
            'De la fumée d’encens seule',
            'Une lumière artificielle',
            'Rien de visible',
          ],
          correctIndex: 0,
          explanation:
              'La nuée signale la présence divine (Exode 40).',
        ),
      ],
      'Matthew#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel modèle de prière Jésus a-t-il donné dans le Sermon '
              'sur la montagne ?',
          options: <String>[
            'La prière « Notre Père »',
            'Une longue liste de vœux',
            'Une prière secrète interdite',
            'Aucune prière précise',
          ],
          correctIndex: 0,
          explanation:
              'Jésus enseigne à prier simplement (Matthieu 6).',
        ),
        QuizQuestion(
          text: 'À quoi ressemble celui qui met en pratique les paroles '
              'de Jésus, selon Matthieu 7 ?',
          options: <String>[
            'Un homme qui bâtit sa maison sur le roc',
            'Un homme qui bâtit sur le sable',
            'Un voyageur sans but',
            'Un roi sans royaume',
          ],
          correctIndex: 0,
          explanation:
              'La maison sur le roc résiste aux tempêtes (Matthieu 7:24).',
        ),
      ],
      'Matthew#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Qu’a fait Jésus lors d’une tempête sur la mer de '
              'Galilée ?',
          options: <String>['Il l’a calmée d’un mot', 'Il a ramé plus vite', 'Il a attendu la fin', 'Il a fui vers la rive'],
          correctIndex: 0,
          explanation:
              'Le vent et la mer lui obéissent (Matthieu 8).',
        ),
        QuizQuestion(
          text: 'Combien d’apôtres Jésus a-t-il choisis et envoyés '
              'prêcher ?',
          options: <String>['Douze', 'Sept', 'Soixante-dix', 'Trois'],
          correctIndex: 0,
          explanation:
              'Les douze apôtres sont nommés (Matthieu 10).',
        ),
      ],
      'Matthew#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Combien de fois faut-il pardonner à son frère, selon '
              'Matthieu 18 ?',
          options: <String>[
            'Jusqu’à 77 fois',
            'Trois fois seulement',
            'Une seule fois',
            'Jamais',
          ],
          correctIndex: 0,
          explanation:
              'Jésus enseigne un pardon sans limite (Matthieu 18:22).',
        ),
        QuizQuestion(
          text: 'Qu’a fait Jésus en entrant dans le temple à Jérusalem ?',
          options: <String>[
            'Il a chassé les marchands',
            'Il a offert un sacrifice',
            'Il s’est caché',
            'Il a couronné un prêtre',
          ],
          correctIndex: 0,
          explanation:
              'Jésus purifie le temple (Matthieu 21).',
        ),
      ],
      'Matthew#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Quels signes Jésus a-t-il annoncés pour la conclusion du '
              'système en Matthieu 24 ?',
          options: <String>[
            'Guerres, famines et tremblements de terre',
            'Une paix mondiale immédiate',
            'La disparition du soleil pour toujours',
            'Aucun signe',
          ],
          correctIndex: 0,
          explanation:
              'Un signe composé est décrit (Matthieu 24).',
        ),
        QuizQuestion(
          text: 'Quelle mission Jésus a-t-il confiée à ses disciples '
              'après sa résurrection ?',
          options: <String>[
            'Faire des disciples de gens de toutes les nations',
            'Rester cachés à Jérusalem',
            'Construire un temple',
            'Attendre sans rien faire',
          ],
          correctIndex: 0,
          explanation:
              'L’ordre missionnaire clôt l’évangile (Matthieu 28:19).',
        ),
      ],
      'Mark#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui Jésus a-t-il appelés en premier au bord de la mer de '
              'Galilée ?',
          options: <String>['Des pêcheurs', 'Des prêtres', 'Des soldats', 'Des scribes'],
          correctIndex: 0,
          explanation:
              'Simon, André et d’autres le suivent (Marc 1).',
        ),
        QuizQuestion(
          text: 'Qu’a fait Jésus pour l’homme possédé de la région de '
              'Gérasa ?',
          options: <String>[
            'Il a chassé les démons qui le tourmentaient',
            'Il l’a ignoré',
            'Il l’a renvoyé chez lui sans agir',
            'Il l’a réprimandé sévèrement',
          ],
          correctIndex: 0,
          explanation:
              'L’homme est libéré et retrouve la raison (Marc 5).',
        ),
      ],
      'Mark#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Avec combien de pains Jésus a-t-il nourri environ 4000 '
              'personnes ?',
          options: <String>['Sept', 'Cinq', 'Douze', 'Deux'],
          correctIndex: 0,
          explanation:
              'Un second miracle de multiplication (Marc 8).',
        ),
        QuizQuestion(
          text: 'Que faut-il devenir, selon Jésus, pour entrer dans le '
              'Royaume de Dieu ?',
          options: <String>['Comme un petit enfant', 'Riche et puissant', 'Un chef reconnu', 'Un savant'],
          correctIndex: 0,
          explanation:
              'Jésus accueille les enfants en exemple (Marc 10).',
        ),
      ],
      'Mark#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quelle petite offrande Jésus a-t-il louée au temple ?',
          options: <String>[
            'Les deux piécettes de la veuve',
            'Un sac d’or',
            'Un agneau parfait',
            'Une pièce d’argent',
          ],
          correctIndex: 0,
          explanation:
              'Elle a donné tout ce qu’elle avait (Marc 12).',
        ),
        QuizQuestion(
          text: 'Qui a été contraint de porter le poteau de supplice de '
              'Jésus ?',
          options: <String>['Simon de Cyrène', 'Pierre', 'Jean', 'Barabbas'],
          correctIndex: 0,
          explanation:
              'Simon est réquisitionné en chemin (Marc 15).',
        ),
      ],
      'Luke#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Dans quelle ville Jésus est-il né ?',
          options: <String>['Bethléhem', 'Nazareth', 'Jérusalem', 'Capernaüm'],
          correctIndex: 0,
          explanation:
              'La naissance a lieu à Bethléhem (Luc 2).',
        ),
        QuizQuestion(
          text: 'À qui les anges ont-ils annoncé en premier la naissance '
              'de Jésus ?',
          options: <String>['À des bergers', 'À des rois', 'Aux prêtres', 'À Hérode'],
          correctIndex: 0,
          explanation:
              'Des bergers reçoivent la bonne nouvelle (Luc 2).',
        ),
      ],
      'Luke#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Combien de disciples Jésus a-t-il envoyés prêcher deux '
              'par deux en Luc 10 ?',
          options: <String>['Soixante-dix', 'Douze', 'Cent', 'Trois'],
          correctIndex: 0,
          explanation:
              'Jésus élargit la prédication (Luc 10).',
        ),
        QuizQuestion(
          text: 'Que conseille Jésus au sujet de l’inquiétude pour la '
              'nourriture et le vêtement ?',
          options: <String>[
            'Ne pas s’inquiéter, mais chercher d’abord le Royaume',
            'Amasser le plus possible',
            'Cesser tout travail',
            'S’inquiéter constamment',
          ],
          correctIndex: 0,
          explanation:
              'Jésus enseigne la confiance en Dieu (Luc 12).',
        ),
      ],
      'Luke#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Combien de lépreux Jésus a-t-il guéris, dont un seul est '
              'revenu remercier ?',
          options: <String>['Dix', 'Sept', 'Trois', 'Douze'],
          correctIndex: 0,
          explanation:
              'Seul un Samaritain revient rendre grâce (Luc 17).',
        ),
        QuizQuestion(
          text: 'Qui a comploté et trahi Jésus pour de l’argent ?',
          options: <String>['Judas Iscariote', 'Pierre', 'Thomas', 'Pilate'],
          correctIndex: 0,
          explanation:
              'Judas livre Jésus (Luc 22).',
        ),
      ],
      'Acts#0': <QuizQuestion>[
        QuizQuestion(
          text: 'Combien de personnes environ ont été baptisées le jour '
              'de la Pentecôte ?',
          options: <String>['Environ 3000', 'Environ 500', 'Environ 12', 'Environ 100'],
          correctIndex: 0,
          explanation:
              'Un grand nombre répond au message (Actes 2).',
        ),
        QuizQuestion(
          text: 'Qui gardait les vêtements de ceux qui lapidaient '
              'Étienne ?',
          options: <String>['Saul (plus tard Paul)', 'Pierre', 'Barnabas', 'Philippe'],
          correctIndex: 0,
          explanation:
              'Saul approuvait ce meurtre (Actes 7-8).',
        ),
      ],
      'Acts#1': <QuizQuestion>[
        QuizQuestion(
          text: 'Qui l’esprit a-t-il envoyé annoncer la bonne nouvelle à '
              'l’eunuque éthiopien ?',
          options: <String>['Philippe', 'Pierre', 'Paul', 'Jean'],
          correctIndex: 0,
          explanation:
              'Philippe lui explique les Écritures (Actes 8).',
        ),
        QuizQuestion(
          text: 'Comment Pierre a-t-il été libéré de prison sous Hérode ?',
          options: <String>['Par un ange', 'En soudoyant un garde', 'Par un tremblement de terre', 'Personne ne l’a aidé'],
          correctIndex: 0,
          explanation:
              'Un ange le fait sortir miraculeusement (Actes 12).',
        ),
      ],
      'Acts#2': <QuizQuestion>[
        QuizQuestion(
          text: 'Quel métier Paul exerçait-il avec Aquila et Priscille ?',
          options: <String>['Fabricant de tentes', 'Pêcheur', 'Charpentier', 'Médecin'],
          correctIndex: 0,
          explanation:
              'Paul travaillait de ses mains (Actes 18).',
        ),
        QuizQuestion(
          text: 'Dans quelle ville la prédication de Paul a-t-elle '
              'provoqué une émeute des orfèvres de Diane/Artémis ?',
          options: <String>['Éphèse', 'Athènes', 'Corinthe', 'Rome'],
          correctIndex: 0,
          explanation:
              'Les artisans craignaient pour leur commerce (Actes 19).',
        ),
      ],
      'Acts#3': <QuizQuestion>[
        QuizQuestion(
          text: 'Devant quels dirigeants Paul a-t-il témoigné à '
              'Césarée ?',
          options: <String>[
            'Félix, Festus et le roi Agrippa',
            'Pilate et Hérode',
            'Le Sanhédrin seul',
            'César en personne',
          ],
          correctIndex: 0,
          explanation:
              'Paul défend sa foi devant les autorités (Actes 24-26).',
        ),
        QuizQuestion(
          text: 'Où Paul est-il finalement arrivé pour attendre son '
              'procès devant César ?',
          options: <String>['À Rome', 'À Jérusalem', 'À Antioche', 'À Éphèse'],
          correctIndex: 0,
          explanation:
              'Paul prêche même en résidence surveillée (Actes 28).',
        ),
      ],
    };

/// Merges the French base content with a language's translated overrides
/// (when present), falling back to French per-checkpoint for anything not
/// yet translated in that language.
Map<String, List<QuizQuestion>> _authoredQuizzesFor(String? languageCode) {
  final Map<String, List<QuizQuestion>> translated = switch (languageCode) {
    'en' => authoredQuizzesEn,
    'it' => authoredQuizzesIt,
    'es' => authoredQuizzesEs,
    'pt' => authoredQuizzesPt,
    'ru' => authoredQuizzesRu,
    'zh' => authoredQuizzesZh,
    _ => const <String, List<QuizQuestion>>{},
  };
  return <String, List<QuizQuestion>>{..._authoredQuizzes, ...translated};
}

Map<String, List<QuizQuestion>> _extraQuizzesFor(String? languageCode) {
  final Map<String, List<QuizQuestion>> translated = switch (languageCode) {
    'en' => extraQuizzesEn,
    'it' => extraQuizzesIt,
    'es' => extraQuizzesEs,
    'pt' => extraQuizzesPt,
    'ru' => extraQuizzesRu,
    'zh' => extraQuizzesZh,
    _ => const <String, List<QuizQuestion>>{},
  };
  return <String, List<QuizQuestion>>{..._extraQuizzes, ...translated};
}

/// Builds the checkpoints for [book]. Pass [languageCode] (e.g. from
/// `Localizations.localeOf(context).languageCode`) to get quiz questions
/// translated into that language where available (falling back to French
/// per-checkpoint for anything not yet translated). Omit it when only the
/// checkpoint structure/count is needed (that's identical across languages).
List<Checkpoint> checkpointsForBook(BibleBook book, {String? languageCode}) {
  final Map<String, List<QuizQuestion>> authored = _authoredQuizzesFor(languageCode);
  final Map<String, List<QuizQuestion>> extra = _extraQuizzesFor(languageCode);
  final int count = _checkpointCount(book.chapters);
  final List<Checkpoint> result = <Checkpoint>[];
  int previous = 0;
  for (int i = 0; i < count; i++) {
    int boundary = ((book.chapters * (i + 1)) / count).round();
    if (boundary <= previous) {
      boundary = previous + 1;
    }
    if (i == count - 1) {
      boundary = book.chapters;
    }
    final String id = '${book.id}#$i';
    result.add(
      Checkpoint(
        id: id,
        bookId: book.id,
        index: i,
        fromChapter: previous + 1,
        afterChapter: boundary,
        questions: <QuizQuestion>[
          ...?authored[id],
          ...?extra[id],
        ],
      ),
    );
    previous = boundary;
  }
  return result;
}

/// Builds a mixed "review" quiz drawing questions from every authored quiz the
/// user has already unlocked (i.e. whose chapters are all read). Used to let a
/// user earn back a streak freeze. Returns up to [count] questions in random
/// order; the returned list may be shorter (or empty) if little is unlocked.
List<QuizQuestion> buildReviewQuiz(
  Set<String> readChapterKeys, {
  int count = 5,
  String? languageCode,
}) {
  final List<QuizQuestion> pool = <QuizQuestion>[];
  for (final BibleBook book in kBibleBooks) {
    for (final Checkpoint cp in checkpointsForBook(book, languageCode: languageCode)) {
      if (!cp.hasQuiz) {
        continue;
      }
      bool unlocked = true;
      for (int c = 1; c <= cp.afterChapter; c++) {
        if (!readChapterKeys.contains(bibleChapterKey(book.id, c))) {
          unlocked = false;
          break;
        }
      }
      if (unlocked) {
        pool.addAll(cp.questions);
      }
    }
  }
  pool.shuffle();
  return pool.take(count).toList();
}

/// All questions from every quiz checkpoint of [book], combined — used for
/// the "quiz complet du livre" once every checkpoint is done.
List<QuizQuestion> allQuestionsForBook(BibleBook book, {String? languageCode}) {
  final List<QuizQuestion> all = <QuizQuestion>[];
  for (final Checkpoint cp in checkpointsForBook(book, languageCode: languageCode)) {
    all.addAll(cp.questions);
  }
  return all;
}

/// Maximum stars obtainable from a book's checkpoint quizzes (3 per quiz
/// checkpoint; the optional full-book quiz is not counted).
int bookMaxStars(BibleBook book) =>
    checkpointsForBook(book).where((Checkpoint c) => c.hasQuiz).length * 3;

/// Maximum stars obtainable across the whole Bible.
int totalMaxStars() =>
    kBibleBooks.fold<int>(0, (int sum, BibleBook b) => sum + bookMaxStars(b));
