import 'dart:math';

import 'quiz_facts_de.dart';
import 'quiz_facts_en.dart';
import 'quiz_facts_es.dart';
import 'quiz_facts_it.dart';
import 'quiz_facts_pl.dart';
import 'quiz_facts_pt.dart';
import 'quiz_facts_ru.dart';
import 'quiz_facts_zh.dart';

/// One "did you know" note per checkpoint, shown on the quiz round-up once
/// the questions are done. French is the source of truth, exactly like
/// `quiz_data.dart`: anything a translation doesn't cover falls back to the
/// French text rather than vanishing.
///
/// Every fact here has to be checkable straight from the passage the quiz
/// covers — a verse reference, a name's meaning, a number the text itself
/// gives. Nothing inferred, nothing "traditionally said to be": a reader
/// who looks it up should find exactly what this claims, and a fact that
/// can't meet that bar simply isn't written.
///
/// Authored a book at a time on purpose. A checkpoint with no entry shows
/// no card at all, which is the right outcome — better a missing note than
/// a hastily written one.
const Map<String, String> _checkpointFacts = <String, String>{
  'Genesis#0':
      'Le nom « Genèse » vient d’un mot grec signifiant « origine ». En '
      'hébreu, le livre porte simplement son premier mot : Beréshith, '
      '« Au commencement » (Genèse 1:1).',
  'Genesis#1':
      'Après le Déluge, Dieu a désigné l’arc-en-ciel comme le signe de '
      'son alliance avec toute chair vivant sur la terre (Genèse 9:12-16).',
  'Genesis#2':
      'C’est Dieu lui-même qui a changé le nom d’Abram en Abraham, qui '
      'signifie « père d’une multitude », et celui de Saraï en Sara '
      '(Genèse 17:5, 15).',
  'Genesis#3':
      'Après son rêve de l’escalier atteignant le ciel, Jacob a appelé '
      'l’endroit Béthel, ce qui signifie « maison de Dieu » '
      '(Genèse 28:12, 19).',
  'Genesis#4':
      'Jacob a reçu le nom d’Israël après avoir lutté toute la nuit ; '
      'c’est de ce nom que la nation entière a hérité (Genèse 32:28).',
  'Genesis#5':
      'Ses frères ont vendu Joseph pour vingt pièces d’argent, et il a été '
      'emmené en Égypte (Genèse 37:28).',
  'Genesis#6':
      'La Genèse se termine par la mort de Joseph à 110 ans et par sa '
      'demande que ses ossements quittent un jour l’Égypte — une demande '
      'exaucée bien plus tard (Genèse 50:24-26).',
  'Exodus#0':
      'Le nom de Moïse lui a été donné par la fille de Pharaon, qui a dit : « Je l’ai tiré de l’eau » (Exode 2:10).',
  'Exodus#1':
      'À la Pâque, Jéhovah a fait de ce mois-là le premier mois de l’année pour Israël : leur calendrier a changé cette nuit-là (Exode 12:2).',
  'Exodus#2':
      'Après la victoire sur Amalec, Moïse a bâti un autel qu’il a appelé Jéhovah-Nissi, c’est-à-dire « Jéhovah est mon signal » (Exode 17:15).',
  'Exodus#3':
      'Pour le tabernacle, Jéhovah a choisi Betsaléel par son nom et l’a rempli de son esprit, lui donnant sagesse et savoir-faire (Exode 31:2, 3).',
  'Exodus#4':
      'Après avoir parlé avec Jéhovah, le visage de Moïse rayonnait, au point que les Israélites avaient peur de s’approcher de lui (Exode 34:29, 30).',
  'Leviticus#0':
      'Dès ces premiers chapitres, la Loi précise que la graisse et le sang appartiennent à Jéhovah et ne devaient jamais être mangés (Lévitique 3:16, 17).',
  'Leviticus#1':
      'Pour déclarer pur quelqu’un qui avait guéri de la lèpre, on prenait deux oiseaux : l’un était offert, l’autre relâché vivant en pleine campagne (Lévitique 14:4-7).',
  'Leviticus#2':
      'Le jour des Propitiations, deux boucs étaient tirés au sort : l’un pour Jéhovah, l’autre « pour Azazel », envoyé au désert en emportant les fautes du peuple (Lévitique 16:8-10, 21, 22).',
  'Leviticus#3':
      'L’année du Jubilé était annoncée au son du cor, le jour des Propitiations, et on proclamait « la liberté dans le pays pour tous ses habitants » (Lévitique 25:9, 10).',
  'Numbers#0':
      'C’est ici que se trouve la bénédiction que les prêtres devaient prononcer sur Israël : « Que Jéhovah te bénisse et te garde » (Nombres 6:24-26).',
  'Numbers#1':
      'Les espions ont exploré Canaan pendant 40 jours ; Israël a ensuite erré 40 ans, « une année pour chaque jour » (Nombres 13:25 ; 14:34).',
  'Numbers#2':
      'Jéhovah a fait parler l’ânesse de Balaam, qui a demandé à son maître pourquoi il la frappait (Nombres 22:28).',
  'Numbers#3':
      'Les filles de Tselophehad ont réclamé un héritage, faute de fils dans leur famille ; Jéhovah a répondu qu’elles avaient raison (Nombres 27:1-7).',
  'Numbers#4':
      'Sur ordre de Jéhovah, Moïse a mis par écrit toutes les étapes du voyage depuis l’Égypte : la liste complète est en Nombres 33:2.',
  'Deuteronomy#0':
      'Jéhovah a demandé que ses paroles soient inculquées aux enfants, et qu’on en parle assis chez soi, en marchant, en se couchant et en se levant (Deutéronome 6:6, 7).',
  'Deuteronomy#1':
      'Pendant les 40 ans au désert, les vêtements des Israélites ne se sont pas usés et leurs pieds n’ont pas enflé (Deutéronome 8:4).',
  'Deuteronomy#2':
      'Un roi d’Israël devait écrire pour lui-même une copie de la Loi et la lire tous les jours de sa vie (Deutéronome 17:18-20).',
  'Deuteronomy#3':
      'La Loi demandait un parapet autour du toit d’une maison neuve, pour que personne ne tombe et que la famille ne se rende pas coupable de sang (Deutéronome 22:8).',
  'Deuteronomy#4':
      'À sa mort, Moïse avait 120 ans, et pourtant ses yeux n’étaient pas affaiblis et sa vigueur n’avait pas disparu (Deutéronome 34:7).',
  'Joshua#0':
      'Douze pierres prises au milieu du Jourdain ont été dressées à Guilgal, pour que les enfants demandent un jour : « Que signifient ces pierres ? » (Josué 4:6, 20-22).',
  'Joshua#1':
      'Le jour où le soleil s’est arrêté, il n’y a jamais eu de jour semblable, ni avant ni après, où Jéhovah a écouté la voix d’un homme (Josué 10:14).',
  'Joshua#2':
      'Le livre conclut qu’aucune des bonnes promesses de Jéhovah envers Israël n’a manqué : toutes se sont réalisées (Josué 21:45).',
  'Judges#0':
      'Débora, prophétesse, jugeait Israël assise sous un palmier entre Rama et Béthel, et c’est là que les Israélites montaient la trouver pour leurs litiges (Juges 4:4, 5).',
  'Judges#1':
      'Quand on lui a proposé de régner, Guédéon a refusé : « Ce n’est pas moi qui dominerai sur vous, c’est Jéhovah qui dominera sur vous » (Juges 8:23).',
  'Judges#2':
      'À sa mort, Samson a fait périr plus de Philistins qu’il n’en avait fait périr pendant toute sa vie (Juges 16:30).',
  'Ruth#0':
      'De retour à Bethléhem, Naomi a demandé qu’on ne l’appelle plus Naomi mais Mara, c’est-à-dire « amère », tant son sort lui semblait amer (Ruth 1:20).',
  'Ruth#1':
      'Boaz a béni Ruth en ces termes : « Que Jéhovah récompense ta façon d’agir », elle qui était venue chercher refuge sous ses ailes (Ruth 2:12).',
  'Ruth#2':
      'Autrefois en Israël, pour valider un rachat ou un échange, on retirait sa sandale et on la donnait à l’autre : c’était la manière d’attester l’accord (Ruth 4:7).',
  '1 Samuel#0':
      'Chaque année, la mère de Samuel lui apportait un petit manteau sans manches qu’elle lui avait fait, quand elle montait avec son mari pour le sacrifice annuel (1 Samuel 2:19).',
  '1 Samuel#1':
      'Au moment de choisir le futur roi, Jéhovah a dit à Samuel : « L’homme voit ce qui apparaît aux yeux, mais Jéhovah, lui, voit ce qu’est le cœur » (1 Samuel 16:7).',
  '1 Samuel#2':
      'Goliath mesurait six coudées et un empan, soit environ 2,90 m, et la seule pointe de sa lance pesait près de 7 kg (1 Samuel 17:4, 7).',
  '1 Samuel#3':
      'David a épargné Saül une seconde fois : il s’est glissé dans son camp endormi et n’a emporté que la lance et la gourde d’eau posées près de sa tête (1 Samuel 26:11, 12).',
  '2 Samuel#0':
      'David a régné 40 ans en tout : sept ans et demi à Hébron sur Juda, puis 33 ans à Jérusalem sur tout Israël (2 Samuel 5:4, 5).',
  '2 Samuel#1':
      'David a fait rechercher Mephibosheth, le fils de Jonathan, infirme des deux pieds, pour qu’il mange en permanence à la table du roi (2 Samuel 9:7, 13).',
  '2 Samuel#2':
      'Quand on a voulu lui offrir l’aire de battage, David a refusé : « Je n’offrirai pas à Jéhovah mon Dieu des sacrifices qui ne me coûtent rien » (2 Samuel 24:24).',
  '1 Kings#0':
      'Le temple a été bâti avec des pierres entièrement taillées à la carrière : sur le chantier, on n’a entendu ni marteau, ni hache, ni aucun outil de fer (1 Rois 6:7).',
  '1 Kings#1':
      'En inaugurant le temple, Salomon a reconnu : « Le ciel, oui le ciel des cieux, ne peut pas te contenir ; combien moins cette maison que j’ai bâtie ! » (1 Rois 8:27).',
  '1 Kings#2':
      'Après le Carmel, Jéhovah n’était ni dans le vent violent, ni dans le tremblement de terre, ni dans le feu, mais dans une voix calme et basse (1 Rois 19:11, 12).',
  '2 Kings#0':
      'Quand une hache empruntée est tombée dans le Jourdain, Élisée a jeté un morceau de bois à cet endroit et le fer est remonté à la surface (2 Rois 6:5-7).',
  '2 Kings#1':
      'Ce sont quatre lépreux assis à l’entrée de la ville qui ont découvert le camp araméen abandonné, et ils se sont dit : « Ce jour est un jour de bonne nouvelle » (2 Rois 7:3, 9).',
  '2 Kings#2':
      'En une seule nuit, l’ange de Jéhovah a frappé 185 000 hommes dans le camp assyrien (2 Rois 19:35).',
  '2 Kings#3':
      'Comme signe donné à Ézéchias, l’ombre est revenue en arrière de dix degrés sur l’escalier d’Achaz (2 Rois 20:9-11).',
  '1 Chronicles#0':
      'Le livre s’ouvre sur un seul mot : « Adam ». Les généalogies qui suivent occupent neuf chapitres avant le premier récit (1 Chroniques 1:1).',
  '1 Chronicles#1':
      'David a reconnu pourquoi le premier transport de l’Arche avait mal tourné : on ne s’était pas conformé à la règle, car elle devait être portée sur les épaules par les Lévites (1 Chroniques 15:13, 15).',
  '1 Chronicles#2':
      'Bien qu’il n’ait pas eu le droit de bâtir le temple, David en a préparé les matériaux en très grande quantité pour son fils (1 Chroniques 22:5, 14).',
  '1 Chronicles#3':
      'Dans sa prière finale, David a reconnu devant Jéhovah : « Tout vient de toi, et c’est de ta main que nous t’avons donné » (1 Chroniques 29:14).',
  '2 Chronicles#0':
      'Pour l’inauguration du temple, Salomon a offert 22 000 bovins et 120 000 moutons, et la fête a duré sept jours (2 Chroniques 7:5, 8, 9).',
  '2 Chronicles#1':
      'Après avoir tout vu par elle-même, la reine de Séba a déclaré qu’on ne lui avait pas rapporté la moitié de la sagesse de Salomon (2 Chroniques 9:6).',
  '2 Chronicles#2':
      '« Les yeux de Jéhovah parcourent toute la terre pour montrer sa force en faveur de ceux dont le cœur est tout entier à lui » (2 Chroniques 16:9).',
  '2 Chronicles#3':
      'Dès le premier mois de son règne, Ézéchias a rouvert les portes du temple que son père Achaz avait fermées (2 Chroniques 28:24 ; 29:3).',
  '2 Chronicles#4':
      'Pendant les 70 ans de désolation, le pays a « acquitté ses sabbats », se reposant enfin comme la Loi le prévoyait (2 Chroniques 36:21).',
  'Ezra#0':
      'Les cris de joie et les pleurs se mêlaient tellement que le peuple ne pouvait pas les distinguer, et le bruit s’entendait de loin (Esdras 3:13).',
  'Ezra#1':
      'Sur ordre de Darius, on a fouillé les archives, et c’est à Ecbatane qu’on a retrouvé le rouleau contenant le décret de Cyrus (Esdras 6:1, 2).',
  'Ezra#2':
      'L’argent et l’or destinés au temple ont été pesés et confiés à des prêtres désignés par leur nom, puis pesés de nouveau à l’arrivée à Jérusalem (Esdras 8:24-30, 33, 34).',
  'Nehemiah#0':
      'Avant d’annoncer son projet, Néhémie est sorti de nuit inspecter les murailles en secret, sans dire à personne ce que son Dieu lui avait mis au cœur (Néhémie 2:12-16).',
  'Nehemiah#1':
      'Les lévites lisaient le livre de la Loi à haute voix et en expliquaient le sens, si bien que le peuple comprenait ce qui était lu (Néhémie 8:8).',
  'Nehemiah#2':
      'Pour l’inauguration de la muraille, deux grands chœurs de louange ont marché en sens opposés sur le mur avant de se rejoindre à la maison de Dieu (Néhémie 12:31, 38, 40).',
  'Esther#0':
      'Le banquet du roi Assuérus a duré 180 jours, suivi d’une fête de sept jours pour tous les habitants de Suse (Esther 1:4, 5).',
  'Esther#1':
      'Avant d’aller vers le roi sans y avoir été appelée, Esther a demandé un jeûne de trois jours et a dit : « Si je dois mourir, je mourrai » (Esther 4:16).',
  'Esther#2':
      'Le nom « Pourim » vient de « Pour », le sort qu’Haman avait jeté pour choisir le jour de l’extermination (Esther 9:24-26).',
  'Job#0':
      'Après avoir tout perdu, Job a dit : « Jéhovah a donné, Jéhovah a repris. Que le nom de Jéhovah continue d’être loué ! » (Job 1:21).',
  'Job#1':
      'Job a comparé l’espoir à un arbre : même coupé, il repousse, et ses rejets ne manquent pas (Job 14:7).',
  'Job#2':
      'Job a souhaité que ses paroles soient écrites dans un livre et gravées pour toujours dans le roc, avec un stylet de fer et du plomb (Job 19:23, 24).',
  'Job#3':
      'Job a écrit que Dieu étend le nord au-dessus du vide et « suspend la terre sur rien » (Job 26:7).',
  'Job#4':
      'Dans son serment d’innocence, Job a déclaré : « J’ai conclu une alliance avec mes yeux », pour ne pas regarder une jeune fille avec convoitise (Job 31:1).',
  'Job#5':
      'Fait rare dans les Écritures, les trois filles de Job sont nommées, et leur père leur a donné un héritage parmi leurs frères (Job 42:14, 15).',
  'Psalms#0':
      'Le Psaume 19 dit que les rappels de Jéhovah sont plus désirables que l’or, et plus doux que le miel qui coule des rayons (Psaume 19:10).',
  'Psalms#1':
      'David a écrit : « J’ai été jeune et je suis devenu vieux, mais je n’ai jamais vu de juste complètement abandonné » (Psaume 37:25).',
  'Psalms#2':
      'Le Psaume 51 rappelle que les sacrifices qui plaisent à Dieu sont un esprit brisé, et qu’un cœur brisé et broyé n’est pas rejeté (Psaume 51:17).',
  'Psalms#3':
      'Le Psaume 72 se termine par une note qui marque une étape du recueil : « Ici se terminent les prières de David, fils de Jessé » (Psaume 72:20).',
  'Psalms#4':
      'Le Psaume 90 est attribué à Moïse ; il y écrit que mille ans sont aux yeux de Dieu comme le jour d’hier qui vient de passer (Psaume 90:4).',
  'Psalms#5':
      'Le Psaume 103 dit que Jéhovah éloigne de nous nos transgressions autant que l’est se trouve loin de l’ouest (Psaume 103:12).',
  'Psalms#6':
      'Le Psaume 119 compte 176 versets, répartis en 22 sections de 8 versets, une pour chaque lettre de l’alphabet hébreu (Psaume 119:1-176).',
  'Psalms#7':
      'Le Psaume 139 déclare : « Je te loue parce que j’ai été fait d’une manière stupéfiante et prodigieuse » (Psaume 139:14).',
  'Proverbs#0':
      'Proverbes invite le paresseux à observer la fourmi : elle n’a ni chef, ni officier, ni gouverneur, et prépare pourtant sa nourriture pendant l’été (Proverbes 6:6-8).',
  'Proverbs#1':
      '« Mieux vaut un plat de légumes là où il y a de l’amour qu’un taureau engraissé là où il y a de la haine » (Proverbes 15:17).',
  'Proverbs#2':
      '« Un cœur joyeux est un bon remède, mais un esprit abattu dessèche les os » (Proverbes 17:22).',
  'Proverbs#3':
      'Proverbes 30 relève quatre créatures parmi les plus petites de la terre et pourtant très sages d’instinct : les fourmis, les damans, les criquets et le lézard (Proverbes 30:24-28).',
  'Ecclesiastes#0':
      '« Une corde triple ne se rompt pas vite » : l’Ecclésiaste illustre ainsi la force de ceux qui se soutiennent mutuellement (Ecclésiaste 4:12).',
  'Ecclesiastes#1':
      '« Doux est le sommeil de celui qui travaille », qu’il mange peu ou beaucoup, alors que l’abondance du riche ne le laisse pas dormir (Ecclésiaste 5:12).',
  'Ecclesiastes#2':
      'L’Ecclésiaste déclare que « les morts ne savent rien du tout » : ils n’ont plus de récompense, et leur souvenir est oublié (Ecclésiaste 9:5).',
  'Song of Solomon#0':
      '« Attrapez pour nous les renards, les petits renards qui ravagent les vignes » : une image restée célèbre du Cantique (Cantique 2:15).',
  'Song of Solomon#1':
      'Le bien-aimé compare la Shulamite à « un jardin fermé » et à « une source scellée », image d’une fidélité réservée à lui seul (Cantique 4:12).',
  'Song of Solomon#2':
      '« Si un homme donnait tous les biens de sa maison pour l’amour, on le mépriserait complètement » : l’amour véritable ne s’achète pas (Cantique 8:7).',
  'Isaiah#0':
      '« Même si vos péchés sont comme l’écarlate, ils deviendront blancs comme la neige » (Ésaïe 1:18).',
  'Isaiah#1':
      'À propos du règne annoncé, Ésaïe écrit : « L’accroissement de son gouvernement et la paix n’auront pas de fin » (Ésaïe 9:7).',
  'Isaiah#2':
      'Sur cette montagne, Jéhovah prépare pour tous les peuples un festin de mets riches et de vins vieillis (Ésaïe 25:6).',
  'Isaiah#3':
      '« Tes oreilles entendront derrière toi une parole : “C’est ici le chemin, marchez-y” » (Ésaïe 30:21).',
  'Isaiah#4':
      '« Ceux qui espèrent en Jéhovah reprendront des forces ; ils s’élèveront avec des ailes comme des aigles » (Ésaïe 40:31).',
  'Isaiah#5':
      '« Vous êtes mes témoins, déclare Jéhovah, oui, mon serviteur que j’ai choisi » (Ésaïe 43:10).',
  'Isaiah#6':
      '« Ma parole qui sort de ma bouche ne reviendra pas vers moi sans résultat » (Ésaïe 55:11).',
  'Isaiah#7':
      '« Ils bâtiront des maisons et les habiteront, ils planteront des vignes et en mangeront les fruits » (Ésaïe 65:21).',
  'Jeremiah#0':
      'Jéhovah reproche deux fautes à son peuple : l’avoir abandonné, lui la source d’eau vive, et s’être creusé des citernes fissurées qui ne retiennent pas l’eau (Jérémie 2:13).',
  'Jeremiah#1':
      '« N’y a-t-il pas de baume en Galaad ? » demande Jérémie devant la blessure de son peuple (Jérémie 8:22).',
  'Jeremiah#2':
      'Malgré les persécutions, Jérémie a dit que la parole de Dieu était dans son cœur « comme un feu brûlant », enfermé dans ses os (Jérémie 20:9).',
  'Jeremiah#3':
      '« Je sais bien les pensées que je forme à votre sujet : des pensées de paix et non de malheur » (Jérémie 29:11).',
  'Jeremiah#4':
      'Le roi Joachim a découpé au canif le rouleau de Jérémie et l’a brûlé morceau par morceau ; Jérémie l’a alors dicté de nouveau à Baruch (Jérémie 36:23, 32).',
  'Jeremiah#5':
      'À Baruch, épuisé, Jéhovah a dit : « Tu continues à rechercher pour toi de grandes choses. Cesse de les rechercher » (Jérémie 45:5).',
  'Jeremiah#6':
      'Le dernier chapitre donne le compte précis des exilés emmenés à Babylone lors de trois déportations successives (Jérémie 52:28-30).',
  'Lamentations#0':
      'Les chapitres 1, 2 et 4 sont des acrostiches : chaque verset commence par une lettre successive de l’alphabet hébreu, ce qui donne 22 versets par chapitre (Lamentations 1:1-22).',
  'Lamentations#1':
      '« Il est bon pour l’homme de porter le joug pendant sa jeunesse » (Lamentations 3:27).',
  'Lamentations#2':
      'Les fils de Sion, autrefois estimés à leur poids en or, sont maintenant considérés comme de simples cruches de terre (Lamentations 4:2).',
  'Ezekiel#0':
      'Quand Ézékiel a mangé le rouleau qui lui était donné, il l’a trouvé « doux comme du miel » dans sa bouche (Ézékiel 3:3).',
  'Ezekiel#1':
      'Jéhovah cite trois hommes justes — Noé, Daniel et Job — en disant que même eux ne sauveraient que leur propre vie (Ézékiel 14:14).',
  'Ezekiel#2':
      '« Je ne prends aucun plaisir à la mort de celui qui meurt », déclare le Souverain Seigneur Jéhovah (Ézékiel 18:32).',
  'Ezekiel#3':
      'Il a été annoncé que Tyr, la riche cité marchande, deviendrait un rocher nu, « un lieu où l’on étend les filets » (Ézékiel 26:4, 5, 14).',
  'Ezekiel#4':
      '« Je vous donnerai un cœur nouveau et je mettrai en vous un esprit nouveau » (Ézékiel 36:26).',
  'Ezekiel#5':
      'Sur les deux rives du fleuve poussent des arbres qui portent du fruit chaque mois, et dont les feuilles servent à guérir (Ézékiel 47:12).',
  'Daniel#0':
      'Nebucadnetsar a perdu la raison et a vécu comme un animal pendant « sept temps », jusqu’à reconnaître que le Très-Haut domine sur le royaume des hommes (Daniel 4:32, 33).',
  'Daniel#1':
      'Daniel a expliqué les mots écrits sur le mur : le règne avait été compté, le roi pesé dans la balance, et le royaume allait être divisé (Daniel 5:25-28).',
  'Daniel#2':
      '« Beaucoup de gens circuleront çà et là, et la vraie connaissance deviendra abondante » (Daniel 12:4).',
  'Hosea#0':
      'Jéhovah promet : « Je te fiancerai à moi pour toujours », dans la justice, le droit, l’amour fidèle et la miséricorde (Osée 2:19).',
  'Hosea#1':
      '« Efforçons-nous de connaître Jéhovah » : sa venue est comparée à la pluie d’automne et de printemps sur la terre (Osée 6:3).',
  'Hosea#2':
      'Osée invite le peuple à offrir « les jeunes taureaux de nos lèvres », c’est-à-dire la louange exprimée à haute voix (Osée 14:2).',
  'Joel#0':
      'Joël décrit des vagues successives d’insectes : ce que laisse le premier, le suivant le dévore (Joël 1:4).',
  'Joel#1':
      'Jéhovah promet de compenser « les années qu’ont dévorées les sauterelles » (Joël 2:25).',
  'Joel#2':
      'À l’inverse de l’image d’Ésaïe, Joël appelle les nations à forger leurs socs de charrue en épées pour le jour du jugement (Joël 3:10).',
  'Amos#0':
      'Jéhovah ne fait rien sans avoir d’abord révélé sa décision à ses serviteurs les prophètes (Amos 3:7).',
  'Amos#1':
      '« Que la justice coule comme les eaux, et la droiture comme un torrent qui ne tarit pas » (Amos 5:24).',
  'Amos#2':
      'Amos annonce une famine d’un genre particulier : non pas de pain ni d’eau, mais d’entendre les paroles de Jéhovah (Amos 8:11).',
  'Obadiah#0':
      'Le plus court livre des Écritures hébraïques ne compte qu’un seul chapitre, et il se termine par ces mots : « La royauté appartiendra à Jéhovah » (Abdias 21).',
  'Jonah#0':
      'Pendant que la tempête menaçait de briser le bateau, Jonas dormait profondément dans la cale (Jonas 1:5).',
  'Jonah#1':
      'Ninive était si grande qu’il fallait trois jours de marche pour la parcourir, et elle comptait plus de 120 000 habitants (Jonas 3:3 ; 4:11).',
  'Jonah#2':
      'Le livre se termine par une question restée sans réponse : Jéhovah demande à Jonas s’il ne devrait pas avoir pitié d’une si grande ville (Jonas 4:11).',
  'Micah#0':
      'Michée annonce que Samarie deviendra « un tas de ruines dans les champs », un endroit où l’on plante des vignes (Michée 1:6).',
  'Micah#1':
      'Bethléhem est décrite comme « trop petite pour être comptée parmi les milliers de Juda », et c’est pourtant de là que devait venir le dirigeant (Michée 5:2).',
  'Micah#2':
      '« Qu’est-ce que Jéhovah demande de toi ? Pratiquer la justice, aimer la bonté et marcher modestement avec ton Dieu » (Michée 6:8).',
  'Nahum#0':
      '« Jéhovah est bon, il est une forteresse au jour de la détresse, et il connaît ceux qui se réfugient en lui » (Nahum 1:7).',
  'Nahum#1':
      'La chute de Ninive est décrite comme une scène vue de près : chars lancés à toute allure, boucliers rougis, éclairs de lances (Nahum 2:3, 4).',
  'Nahum#2':
      'Ninive est appelée « la ville sanguinaire », remplie de mensonge et de butin, et sa chute est annoncée comme définitive (Nahum 3:1).',
  'Habakkuk#0':
      'Habacuc ose demander à Jéhovah pourquoi il le laisse voir l’injustice sans intervenir, et il attend sa réponse à son poste de garde (Habacuc 1:3 ; 2:1).',
  'Habakkuk#1':
      '« La terre sera remplie de la connaissance de la gloire de Jéhovah comme les eaux couvrent la mer » (Habacuc 2:14).',
  'Habakkuk#2':
      'Même si le figuier ne fleurit pas et qu’il n’y a plus de troupeau, Habacuc déclare qu’il exultera en Jéhovah (Habacuc 3:17, 18).',
  'Zephaniah#0':
      'Sophonie annonce que Jéhovah fouillera Jérusalem « avec des lampes » pour y trouver ceux qui se figent sur leur lie (Sophonie 1:12).',
  'Zephaniah#1':
      '« Cherchez Jéhovah, vous tous, humbles de la terre… peut-être serez-vous cachés au jour de sa colère » (Sophonie 2:3).',
  'Zephaniah#2':
      'Le livre s’achève sur une image inattendue : Jéhovah lui-même se réjouira de son peuple avec des cris de joie (Sophonie 3:17).',
  'Haggai#0':
      'Aggée reproche au peuple d’habiter des maisons lambrissées pendant que la maison de Jéhovah reste en ruine, et il l’invite à « réfléchir à sa conduite » (Aggée 1:4, 5).',
  'Zechariah#0':
      'Une des visions montre un homme mesurant Jérusalem au cordeau ; la ville sera si peuplée qu’elle restera sans muraille, Jéhovah étant lui-même « une muraille de feu » autour d’elle (Zacharie 2:1-5).',
  'Zechariah#1':
      '« Ce n’est pas par une force militaire ni par la puissance, mais par mon esprit », a déclaré Jéhovah à Zorobabel (Zacharie 4:6).',
  'Zechariah#2':
      'Zacharie annonce que dix hommes de toutes les langues des nations saisiront le pan du vêtement d’un Juif en disant : « Nous voulons aller avec vous » (Zacharie 8:23).',
  'Malachi#0':
      'Jéhovah demande aux prêtres d’essayer d’offrir leurs bêtes malades à leur gouverneur, pour leur faire mesurer ce qu’ils lui présentaient à lui (Malachie 1:8).',
  'Malachi#1':
      '« Mettez-moi à l’épreuve », dit Jéhovah au sujet des dîmes, promettant d’ouvrir les écluses des cieux (Malachie 3:10).',
  'Malachi#2':
      'Un « livre de souvenir » est écrit devant Jéhovah pour ceux qui le craignent et qui méditent sur son nom (Malachie 3:16).',
  'Matthew#0':
      'Dans la prière modèle, la toute première demande de Jésus concerne le nom de Dieu : « Que ton nom soit sanctifié » (Matthieu 6:9).',
  'Matthew#1':
      '« Venez à moi, vous tous qui peinez… car mon joug est doux et ma charge est légère » (Matthieu 11:28-30).',
  'Matthew#2':
      '« Le Fils de l’homme est venu non pas pour être servi, mais pour servir et donner sa vie comme rançon en échange de beaucoup » (Matthieu 20:28).',
  'Matthew#3':
      '« Cette bonne nouvelle du Royaume sera prêchée dans toute la terre habitée, en témoignage pour toutes les nations » (Matthieu 24:14).',
  'Mark#0':
      'Marc est le plus court des Évangiles, et il avance vite : le mot « aussitôt » y revient sans cesse, dès les premiers récits (Marc 1:10, 12, 18).',
  'Mark#1':
      'Jésus a nourri environ 5 000 hommes, et il est resté douze paniers de morceaux (Marc 6:43, 44).',
  'Mark#2':
      'Jésus a fait remarquer que la veuve pauvre, en donnant deux petites pièces, avait mis plus que tous les autres, car elle a donné tout ce qu’elle avait pour vivre (Marc 12:42-44).',
  'Luke#0':
      'Luc explique sa méthode : il a recherché toutes choses avec exactitude depuis le début, pour les écrire « dans un ordre logique » (Luc 1:3).',
  'Luke#1':
      '« Il y aura plus de joie dans le ciel pour un seul pécheur qui se repent que pour 99 justes » (Luc 15:7).',
  'Luke#2':
      'Quand on lui a demandé de faire taire ses disciples, Jésus a répondu que s’ils se taisaient, les pierres crieraient (Luc 19:40).',
  'John#0':
      'Jean rapporte que Jésus a appelé le temple « la maison de mon Père » et en a chassé les marchands avec un fouet de cordes (Jean 2:15, 16).',
  'John#1':
      'Le verset le plus court des Écritures grecques se trouve devant la tombe de Lazare : « Jésus pleura » (Jean 11:35).',
  'John#2':
      'Jean conclut en disant que si tout ce que Jésus a fait était écrit, le monde ne pourrait pas contenir les rouleaux (Jean 21:25).',
  'Acts#0':
      'Avant son ascension, Jésus a dit que ses disciples seraient témoins « jusque dans la région la plus lointaine de la terre » (Actes 1:8).',
  'Acts#1':
      'C’est à Antioche que les disciples ont été appelés chrétiens pour la première fois, par une direction divine (Actes 11:26).',
  'Acts#2':
      'À Bérée, les habitants ont été jugés plus nobles parce qu’ils examinaient chaque jour les Écritures pour vérifier ce qu’on leur enseignait (Actes 17:11).',
  'Acts#3':
      'Le livre des Actes se termine sans conclusion : Paul, prisonnier à Rome, prêche encore « sans empêchement » pendant deux ans (Actes 28:30, 31).',
  'Romans#0':
      '« Tous ont péché et n’atteignent pas à la gloire de Dieu » : c’est la base de l’argument de Paul (Romains 3:23).',
  'Romans#1':
      '« Le salaire que paie le péché, c’est la mort, mais le don que Dieu donne, c’est la vie éternelle » (Romains 6:23).',
  'Romans#2':
      'Paul énumère tout ce qui ne peut pas nous séparer de l’amour de Dieu : ni mort, ni vie, ni anges, ni choses présentes ou à venir (Romains 8:38, 39).',
  '1 Corinthians#0':
      'Paul rappelle que Dieu a choisi « les choses sottes du monde » pour couvrir de honte les sages (1 Corinthiens 1:27).',
  '1 Corinthians#1':
      'C’est ici que Paul rapporte l’institution du Repas du Seigneur, avec les paroles « Faites ceci en souvenir de moi » (1 Corinthiens 11:24, 25).',
  '1 Corinthians#2':
      '« Ne vous y trompez pas : les mauvaises fréquentations ruinent les habitudes utiles » (1 Corinthiens 15:33).',
  '2 Corinthians#0':
      'Paul appelle Jéhovah « le Dieu de toute consolation », qui nous console pour que nous puissions consoler les autres (2 Corinthiens 1:3, 4).',
  '2 Corinthians#1':
      'Nous avons ce trésor « dans des vases de terre », pour que la puissance extraordinaire vienne de Dieu et non de nous (2 Corinthiens 4:7).',
  '2 Corinthians#2':
      'Paul énumère ce qu’il a enduré : naufrages, coups, dangers de toutes sortes, et une nuit et un jour passés dans les profondeurs (2 Corinthiens 11:25).',
  'Galatians#0':
      'Paul raconte qu’il a repris Céphas « en face », parce qu’il était manifestement dans son tort (Galates 2:11).',
  'Galatians#1':
      'La loi a servi de « précepteur » conduisant à Christ, jusqu’à ce que la foi arrive (Galates 3:24).',
  'Galatians#2':
      'Le fruit de l’esprit est énuméré en neuf qualités : amour, joie, paix, patience, bienveillance, bonté, foi, douceur, maîtrise de soi (Galates 5:22, 23).',
  'Ephesians#0':
      '« C’est par cette faveur imméritée que vous avez été sauvés, par le moyen de la foi… c’est le don de Dieu » (Éphésiens 2:8, 9).',
  'Ephesians#1':
      'Paul demande qu’on ne laisse pas le soleil se coucher sur son irritation (Éphésiens 4:26).',
  'Ephesians#2':
      'L’armure complète est décrite pièce par pièce : ceinture de vérité, cuirasse de justice, bouclier de la foi, casque du salut, épée de l’esprit (Éphésiens 6:14-17).',
  'Philippians#0':
      'Emprisonné, Paul se réjouit que sa situation ait servi à faire avancer la bonne nouvelle, connue même dans la garde prétorienne (Philippiens 1:12, 13).',
  'Philippians#1':
      'Jésus est présenté comme celui qui « s’est vidé lui-même » et s’est humilié jusqu’à la mort sur un poteau (Philippiens 2:7, 8).',
  'Philippians#2':
      '« Pour toutes choses j’ai la force grâce à celui qui me donne de la puissance » (Philippiens 4:13).',
  'Colossians#0':
      'Christ y est présenté comme « l’image du Dieu invisible, le premier-né de toute création » (Colossiens 1:15).',
  'Colossians#1':
      'Paul met en garde contre ceux qui pourraient entraîner les chrétiens « par la philosophie et une vaine tromperie » (Colossiens 2:8).',
  'Colossians#2':
      'Paul demande que sa lettre soit lue aussi à Laodicée, et que celle venant de Laodicée soit lue à Colosses (Colossiens 4:16).',
  '1 Thessalonians#0':
      'Paul rappelle qu’il travaillait nuit et jour pour n’être à la charge de personne pendant qu’il prêchait (1 Thessaloniciens 2:9).',
  '1 Thessalonians#1':
      'Paul a préféré rester seul à Athènes et envoyer Timothée, tant il voulait des nouvelles de leur foi (1 Thessaloniciens 3:1, 2).',
  '1 Thessalonians#2':
      'Les morts sont décrits comme « endormis », et ceux qui restent n’auront aucune avance sur eux (1 Thessaloniciens 4:13, 15).',
  '2 Thessalonians#0':
      'Paul remercie Dieu parce que la foi des Thessaloniciens grandit beaucoup et que leur amour augmente (2 Thessaloniciens 1:3).',
  '2 Thessalonians#1':
      'Paul demande de tenir ferme aux enseignements reçus, transmis « soit de vive voix, soit par une lettre » (2 Thessaloniciens 2:15).',
  '2 Thessalonians#2':
      '« Si quelqu’un ne veut pas travailler, qu’il ne mange pas non plus » (2 Thessaloniciens 3:10).',
  '1 Timothy#0':
      'Paul se décrit comme ayant été autrefois un blasphémateur et un persécuteur, à qui la miséricorde a pourtant été faite (1 Timothée 1:13).',
  '1 Timothy#1':
      '« Que personne ne méprise ta jeunesse » : Timothée devait convaincre par son exemple, pas par son âge (1 Timothée 4:12).',
  '1 Timothy#2':
      '« L’amour de l’argent est une racine de toutes sortes de choses mauvaises » (1 Timothée 6:10).',
  '2 Timothy#0':
      'Paul rappelle la foi sincère de Timothée, présente d’abord chez sa grand-mère Loïs et sa mère Eunice (2 Timothée 1:5).',
  '2 Timothy#1':
      '« Toute Écriture est inspirée de Dieu et utile pour enseigner » (2 Timothée 3:16).',
  '2 Timothy#2':
      'Vers la fin de sa vie, Paul écrit qu’il a combattu le beau combat, achevé la course et gardé la foi (2 Timothée 4:7).',
  'Titus#0':
      'Paul dit avoir laissé Tite en Crète pour corriger ce qui était défectueux et établir des anciens ville par ville (Tite 1:5).',
  'Titus#1':
      'Les hommes d’âge mûr, les femmes, les jeunes et les serviteurs reçoivent chacun un conseil adapté à leur situation (Tite 2:2-10).',
  'Titus#2':
      'Paul demande de rappeler aux chrétiens d’être « prêts à toute œuvre bonne » et de ne parler en mal de personne (Tite 3:1, 2).',
  'Philemon#0':
      'Paul renvoie Onésime à son maître en demandant qu’il soit reçu non plus comme un esclave, mais comme un frère bien-aimé (Philémon 15, 16).',
  'Hebrews#0':
      'Le Fils est décrit comme « le reflet de la gloire » de Dieu et l’empreinte exacte de son être même (Hébreux 1:3).',
  'Hebrews#1':
      'Melkitsédeq apparaît dans le récit sans père, sans mère et sans généalogie inscrite : rien de tout cela n’a été consigné (Hébreux 7:3).',
  'Hebrews#2':
      'Après la longue liste de fidèles du chapitre 11, Paul les appelle « une si grande nuée de témoins » (Hébreux 12:1).',
  'James#0':
      '« Que chacun soit prompt à entendre, lent à parler, lent à la colère » (Jacques 1:19).',
  'James#1':
      'Jacques compare la langue à un petit feu capable d’embraser une grande forêt (Jacques 3:5).',
  'James#2':
      '« La supplication du juste a beaucoup de force » : Élie est cité en exemple, un homme « avec des sentiments comme les nôtres » (Jacques 5:16, 17).',
  '1 Peter#0':
      'Pierre appelle les chrétiens « des pierres vivantes » qui sont bâties ensemble en une maison spirituelle (1 Pierre 2:5).',
  '1 Peter#1':
      'Il faut être « toujours prêts à présenter une défense » à qui demande la raison de notre espérance, mais avec douceur et profond respect (1 Pierre 3:15).',
  '1 Peter#2':
      '« Rejetez sur lui toutes vos inquiétudes, car il se soucie de vous » (1 Pierre 5:7).',
  '2 Peter#0':
      'Aucune prophétie n’est venue de l’initiative de l’homme : des hommes ont parlé de la part de Dieu, portés par l’esprit saint (2 Pierre 1:21).',
  '2 Peter#1':
      'Pierre rappelle que Noé, « prédicateur de justice », a été préservé avec sept autres personnes (2 Pierre 2:5).',
  '2 Peter#2':
      'Pour Jéhovah, « un jour est comme mille ans, et mille ans comme un jour » (2 Pierre 3:8).',
  '1 John#0':
      '« Si nous confessons nos péchés, il est fidèle et juste pour nous les pardonner » (1 Jean 1:9).',
  '1 John#1':
      '« Aimons, non pas en parole ni avec la langue, mais en action et vérité » (1 Jean 3:18).',
  '1 John#2':
      '« Dieu est amour » : cette phrase courte résume tout ce que Jean vient d’expliquer (1 Jean 4:8).',
  '2 John#0':
      'Jean écrit qu’il aimerait mieux ne pas se servir « de papier et d’encre », mais venir parler de vive voix (2 Jean 12).',
  '3 John#0':
      'Jean écrit qu’il n’a pas de plus grande joie que d’entendre que ses enfants continuent à marcher dans la vérité (3 Jean 4).',
  'Jude#0':
      'Jude rapporte que Michel l’archange, en discutant au sujet du corps de Moïse, n’a pas osé porter de jugement injurieux (Jude 9).',
  'Revelation#0':
      'Le livre promet un bonheur à celui qui lit à haute voix et à ceux qui écoutent les paroles de cette prophétie (Révélation 1:3).',
  'Revelation#1':
      'Parmi les événements annoncés : le temps de « saccager ceux qui saccagent la terre » (Révélation 11:18).',
  'Revelation#2':
      'La promesse finale : Dieu essuiera toute larme, et la mort ne sera plus (Révélation 21:4).',
};

final Map<String, Map<String, String>> _factsCache =
    <String, Map<String, String>>{};

Map<String, String> _factsFor(String? languageCode) {
  final String cacheKey = languageCode ?? '';
  return _factsCache[cacheKey] ??= () {
    final Map<String, String> translated = switch (languageCode) {
      'en' => checkpointFactsEn,
      'de' => checkpointFactsDe,
      'pl' => checkpointFactsPl,
      'it' => checkpointFactsIt,
      'es' => checkpointFactsEs,
      'pt' => checkpointFactsPt,
      'ru' => checkpointFactsRu,
      'zh' => checkpointFactsZh,
      _ => const <String, String>{},
    };
    return <String, String>{..._checkpointFacts, ...translated};
  }();
}

/// The fact for [checkpointId] in [languageCode], or null when none has been
/// authored yet — the round-up simply omits the card in that case.
String? checkpointFactFor(String checkpointId, {String? languageCode}) =>
    _factsFor(languageCode)[checkpointId];

/// A fact drawn at random from [checkpointIds], or null if none of them has
/// one authored.
///
/// For quizzes that aren't tied to a single checkpoint — a whole-book quiz,
/// or the mixed review quiz. Callers pass only checkpoints the reader has
/// already covered, so the round-up can't spoil a passage they haven't
/// reached yet.
String? randomCheckpointFact(
  Iterable<String> checkpointIds, {
  String? languageCode,
  Random? random,
}) {
  final Map<String, String> facts = _factsFor(languageCode);
  final List<String> available = checkpointIds
      .where(facts.containsKey)
      .toList(growable: false);
  if (available.isEmpty) {
    return null;
  }
  return facts[available[(random ?? Random()).nextInt(available.length)]];
}
