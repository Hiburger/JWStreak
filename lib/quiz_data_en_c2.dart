import 'quiz_data.dart';

const Map<String, List<QuizQuestion>> authoredQuizzesEnC2 = <String, List<QuizQuestion>>{
  '1 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'What did Hannah promise Jehovah if she had a son?',
      options: <String>[
        "To dedicate him to God's service for his whole life",
        'To offer him half of her possessions',
        'To build a temple',
        'To become a priestess herself',
      ],
      correctIndex: 0,
      explanation:
          'Hannah dedicates Samuel to service at the tabernacle (1 Samuel 1).',
    ),
    QuizQuestion(
      text: 'How did Jehovah call the young Samuel?',
      options: <String>[
        'By speaking his name at night, several times',
        'Through a visible angel',
        'Through a single dream',
        'Through a public voice',
      ],
      correctIndex: 0,
      explanation: 'Samuel first thinks Eli is calling him (1 Samuel 3).',
    ),
    QuizQuestion(
      text: 'Why did the people ask Samuel for a king?',
      options: <String>[
        'To be like the other nations',
        "By Jehovah's direct command",
        'Because of an immediate invasion',
        'Because Samuel suggested it',
      ],
      correctIndex: 0,
      explanation:
          "The people reject God's direct rulership (1 Samuel 8).",
    ),
  ],
  '1 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text: "Whom did Samuel secretly anoint as Israel's first king?",
      options: <String>['Saul', 'David', 'Jonathan', 'Abner'],
      correctIndex: 0,
      explanation: 'Samuel anoints Saul privately (1 Samuel 9-10).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: "Why did Samuel announce Saul's rejection as king?",
      options: <String>[
        'Saul offered a sacrifice without waiting for Samuel',
        'Saul lost a battle',
        'Saul refused to reign',
        'Saul fled from the enemy',
      ],
      correctIndex: 0,
      explanation:
          'Saul disobeys by offering the sacrifice himself (1 Samuel 13).',
    ),
    QuizQuestion(
      text: 'Why was Saul permanently rejected as king by Jehovah?',
      options: <String>[
        'He disobeyed by sparing Agag and the best of the livestock',
        'He lost a minor battle',
        'He aged too quickly',
        'He asked Samuel for help',
      ],
      correctIndex: 0,
      explanation:
          'His disobedience regarding Amalek seals his rejection '
          '(1 Samuel 15).',
    ),
  ],
  '1 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text: 'With what weapon did David defeat Goliath?',
      options: <String>['A sling and a stone', 'A sword', 'A spear', 'His bare hands'],
      correctIndex: 0,
      explanation:
          'David refuses the armor and uses his sling (1 Samuel 17).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['sword', 'shield', 'spear'],
    ),
    QuizQuestion(
      text: 'What feeling drove Saul to want to kill David after his victory?',
      options: <String>['Jealousy', 'Fear of the Philistines', "Samuel's anger", "Jonathan's advice"],
      correctIndex: 0,
      explanation:
          'The songs of praise for David make Saul jealous (1 Samuel 18).',
    ),
    QuizQuestion(
      text: 'Who helped David escape Saul by warning him of danger?',
      options: <String>['Jonathan', 'Abner', 'Samuel alone', 'An unknown priest'],
      correctIndex: 0,
      explanation:
          "Jonathan warns David using an agreed-upon signal (1 Samuel 20).",
      type: QuizAnswerType.freeText,
    ),
  ],
  '1 Samuel#3': <QuizQuestion>[
    QuizQuestion(
      text: 'What does David do when he has the chance to kill Saul in a '
          'cave?',
      options: <String>[
        'He spares him and only cuts off a corner of his garment',
        'He kills him immediately',
        'He flees without acting',
        'He negotiates peace',
      ],
      correctIndex: 0,
      explanation:
          'David refuses to touch "the anointed of Jehovah" '
          '(1 Samuel 24).',
    ),
    QuizQuestion(
      text: 'Who avoided a conflict between David and Nabal through her '
          'wisdom?',
      options: <String>['Abigail', 'Michal', 'A servant girl', 'The high priest'],
      correctIndex: 0,
      explanation:
          'Abigail calms David with provisions (1 Samuel 25).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Where do Saul and Jonathan die in the final battle of the '
          'book?',
      options: <String>[
        'On Mount Gilboa, fighting the Philistines',
        'In Jerusalem',
        'In Hebron',
        'In Gibeah',
      ],
      correctIndex: 0,
      explanation:
          'Saul and his sons die at Gilboa (1 Samuel 31).',
    ),
  ],
  '2 Samuel#0': <QuizQuestion>[
    QuizQuestion(
      text: 'How did David react to the death of Saul and Jonathan?',
      options: <String>[
        'He composed a song of mourning (a lament)',
        'He rejoiced',
        'He ignored the news',
        'He attacked immediately',
      ],
      correctIndex: 0,
      explanation:
          'David composes "the Song of the Bow" (2 Samuel 1).',
    ),
    QuizQuestion(
      text: 'What city did David conquer to make it his capital?',
      options: <String>['Jerusalem', 'Hebron', 'Shiloh', 'Gibeah'],
      correctIndex: 0,
      explanation:
          'David takes the stronghold of Zion (2 Samuel 5).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'What promise does Jehovah make to David through the prophet '
          'Nathan?',
      options: <String>[
        'A descendant will reign forever',
        'David himself will build the temple',
        'David will live forever',
        'David will become a priest',
      ],
      correctIndex: 0,
      explanation:
          'The Davidic covenant promises an everlasting dynasty '
          '(2 Samuel 7).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['temple', 'throne', 'covenant'],
    ),
  ],
  '2 Samuel#1': <QuizQuestion>[
    QuizQuestion(
      text: 'With whom did David commit adultery, leading to Uriah\'s '
          'murder?',
      options: <String>['Bathsheba', 'Michal', 'Abigail', 'Tamar'],
      correctIndex: 0,
      explanation:
          'David has Uriah killed to hide his sin (2 Samuel 11).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'How did the prophet Nathan confront David about his sin?',
      options: <String>[
        'Through a parable about a rich man and a poor man',
        'By denouncing him publicly',
        'Through an anonymous letter',
        'By leaving his service',
      ],
      correctIndex: 0,
      explanation:
          'The parable leads David to acknowledge his wrongdoing '
          '(2 Samuel 12).',
    ),
    QuizQuestion(
      text: 'Who rebelled against his father David to seize the throne?',
      options: <String>['Absalom', 'Amnon', 'Solomon', 'Adonijah'],
      correctIndex: 0,
      explanation:
          "Absalom's rebellion begins (2 Samuel 15).",
      type: QuizAnswerType.freeText,
    ),
  ],
  '2 Samuel#2': <QuizQuestion>[
    QuizQuestion(
      text: "Whose advice foiled Ahithophel's quick plan against David?",
      options: <String>[
        "Hushai's, who remained loyal to David",
        "Joab's",
        "A priest's",
        "Solomon's",
      ],
      correctIndex: 0,
      explanation:
          'Hushai delays the attack and saves David (2 Samuel 17).',
    ),
    QuizQuestion(
      text: 'How did Absalom die?',
      options: <String>[
        'Caught by his hair in a tree, killed by Joab',
        'In single combat against David',
        'By poisoning',
        'In exile, of old age',
      ],
      correctIndex: 0,
      explanation:
          'Absalom is left hanging, and Joab runs him through '
          '(2 Samuel 18).',
    ),
    QuizQuestion(
      text: "What act of David brought a plague on Israel near the end of "
          "the book?",
      options: <String>[
        'A census of the people',
        'The building of a palace',
        'A forbidden marriage',
        'A refusal to sacrifice',
      ],
      correctIndex: 0,
      explanation:
          'The census displeases God, and a plague follows '
          '(2 Samuel 24).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['plague', 'altar', 'Joab'],
    ),
  ],
  '1 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text: "Who tried to seize the throne before David's death?",
      options: <String>['Adonijah', 'Absalom', 'Joab alone', 'Nathan'],
      correctIndex: 0,
      explanation:
          "Adonijah proclaims himself king without David's consent "
          '(1 Kings 1).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'What does Solomon ask Jehovah for at the very start of his '
          'reign?',
      options: <String>[
        'An understanding heart to judge the people',
        'Riches above all',
        'Military victory',
        'A long life, no conditions attached',
      ],
      correctIndex: 0,
      explanation:
          'Solomon asks for wisdom, which pleases God (1 Kings 3).',
    ),
    QuizQuestion(
      text: 'Who helped Solomon supply materials to build the temple?',
      options: <String>['Hiram, king of Tyre', 'Pharaoh of Egypt', 'The queen of Sheba', 'The king of Moab'],
      correctIndex: 0,
      explanation:
          'Hiram supplies cedar wood and craftsmen (1 Kings 5).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Hiram'],
    ),
  ],
  '1 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: 'What happens when the temple is completed and dedicated?',
      options: <String>[
        "Jehovah's glory fills the temple",
        'An earthquake occurs',
        'The people revolt',
        'Solomon leaves Jerusalem',
      ],
      correctIndex: 0,
      explanation:
          'The cloud of glory fills the house (1 Kings 8).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['cloud', 'ark', 'priests'],
    ),
    QuizQuestion(
      text: "Why did Solomon's kingdom eventually weaken spiritually?",
      options: <String>[
        'His foreign wives turned his heart away',
        'He lost a war',
        'He was exiled',
        'He lacked wealth',
      ],
      correctIndex: 0,
      explanation:
          "His wives' idolatry leads him into unfaithfulness "
          '(1 Kings 11).',
    ),
    QuizQuestion(
      text: 'What does Jeroboam do after the kingdom divides, to keep the '
          'people from going to Jerusalem?',
      options: <String>[
        'He sets up golden calves at Bethel and Dan',
        'He destroys all the roads',
        'He bans all worship',
        'He builds an identical new temple',
      ],
      correctIndex: 0,
      explanation:
          'Jeroboam introduces a rival idolatrous worship '
          '(1 Kings 12).',
    ),
  ],
  '1 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Who announced a punishing drought to King Ahab?',
      options: <String>['Elijah', 'Elisha', 'Micaiah', 'Obadiah'],
      correctIndex: 0,
      explanation:
          'Elijah announces there will be neither rain nor dew '
          '(1 Kings 17).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'What happened during the contest on Mount Carmel?',
      options: <String>[
        "Jehovah's fire consumed Elijah's sacrifice",
        'A sudden rain fell first',
        'The prophets of Baal won',
        'Nothing happened',
      ],
      correctIndex: 0,
      explanation:
          "Jehovah answers with fire before all Israel (1 Kings 18).",
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Baal', 'altar', 'water'],
    ),
    QuizQuestion(
      text: 'Why did Ahab and Jezebel have Naboth killed?',
      options: <String>[
        'To seize his vineyard',
        'For a crime he had committed',
        'For an unpaid debt',
        "On a prophet's orders",
      ],
      correctIndex: 0,
      explanation:
          'Jezebel orchestrates a false trial against Naboth '
          '(1 Kings 21).',
    ),
  ],
  '2 Kings#0': <QuizQuestion>[
    QuizQuestion(
      text: 'How did Elijah leave the earth?',
      options: <String>[
        'Taken up to heaven in a windstorm',
        'He died of old age',
        'He was exiled',
        'He disappeared without explanation',
      ],
      correctIndex: 0,
      explanation:
          'Elisha sees Elijah taken up in a windstorm (2 Kings 2).',
    ),
    QuizQuestion(
      text: 'What miracle did Elisha perform for the Shunammite woman?',
      options: <String>[
        'He brought her son back to life',
        'He multiplied her flock',
        'He healed her of leprosy',
        'He rebuilt her house',
      ],
      correctIndex: 0,
      explanation:
          "Elisha restores the Shunammite's child to life "
          '(2 Kings 4).',
    ),
    QuizQuestion(
      text: 'How was Naaman healed of leprosy?',
      options: <String>[
        'By bathing seven times in the Jordan',
        'With a special ointment',
        'Through a collective prayer',
        'Through prolonged fasting',
      ],
      correctIndex: 0,
      explanation:
          "Naaman obeys Elisha's instruction despite his skepticism "
          '(2 Kings 5).',
    ),
  ],
  '2 Kings#1': <QuizQuestion>[
    QuizQuestion(
      text: 'How was the siege of Samaria unexpectedly lifted?',
      options: <String>[
        'The Aramean army fled, frightened by a noise',
        'An allied army arrived',
        'A truce was signed',
        'The Aramean king died in battle',
      ],
      correctIndex: 0,
      explanation:
          'Jehovah causes a noise that panics the enemy (2 Kings 7).',
    ),
    QuizQuestion(
      text: "Whom did Jehu eliminate to purge Israel's kingship?",
      options: <String>[
        'Joram, Jezebel, and the house of Ahab',
        'Only the prophets of Baal',
        'The kings of Judah',
        'The Assyrians',
      ],
      correctIndex: 0,
      explanation:
          'Jehu carries out the announced judgment against the house '
          'of Ahab (2 Kings 9-10).',
    ),
    QuizQuestion(
      text: 'How was young Joash protected before becoming king?',
      options: <String>[
        'Hidden in the temple by his aunt',
        'Sent abroad',
        'Raised by a lone prophet',
        'Protected by the Assyrian army',
      ],
      correctIndex: 0,
      explanation:
          "Joash escapes Athaliah's massacre (2 Kings 11).",
    ),
  ],
  '2 Kings#2': <QuizQuestion>[
    QuizQuestion(
      text: 'What becomes of the northern kingdom (Israel) after the '
          'Assyrian siege?',
      options: <String>[
        'Samaria falls and the people are deported',
        'It conquers Assyria',
        'It signs a lasting peace',
        'Nothing really changes',
      ],
      correctIndex: 0,
      explanation:
          'The fall of Samaria marks the end of the northern kingdom '
          '(2 Kings 17).',
    ),
    QuizQuestion(
      text: "How did Hezekiah react to Sennacherib's threatening letter?",
      options: <String>[
        'He spread it out before Jehovah and prayed',
        'He surrendered without resisting',
        'He fled the city',
        'He ignored the threat',
      ],
      correctIndex: 0,
      explanation:
          "Hezekiah's prayer precedes the miraculous deliverance "
          '(2 Kings 19).',
    ),
    QuizQuestion(
      text: 'What happened to the Assyrian army besieging Jerusalem?',
      options: <String>[
        'An angel struck down a great number of them in one night',
        'It was defeated in battle',
        'It simply withdrew',
        'An epidemic slowly weakened it',
      ],
      correctIndex: 0,
      explanation:
          'Divine intervention saves Jerusalem (2 Kings 19).',
    ),
  ],
  '2 Kings#3': <QuizQuestion>[
    QuizQuestion(
      text: 'What did the high priest Hilkiah discover during Josiah\'s '
          'reign?',
      options: <String>[
        'The book of the Law, lost in the temple',
        'A treasure of gold',
        'A royal tomb',
        'A new water source',
      ],
      correctIndex: 0,
      explanation:
          "The discovery sparks Josiah's religious reform (2 Kings 22).",
    ),
    QuizQuestion(
      text: 'What great festival did Josiah celebrate after his reform?',
      options: <String>['The Passover', 'The Festival of Booths', 'Pentecost', 'The Jubilee'],
      correctIndex: 0,
      explanation:
          'A memorable Passover is celebrated (2 Kings 23).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Passover'],
    ),
    QuizQuestion(
      text: 'How does the book of Kings end?',
      options: <String>[
        'With the fall of Jerusalem and the destruction of the temple',
        'With the crowning of a just, lasting king',
        'With a great military victory',
        'With an immediate return from exile',
      ],
      correctIndex: 0,
      explanation:
          'The account concludes with the exile to Babylon (2 Kings 25).',
    ),
  ],
  '1 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: 'What genealogies does this book begin with?',
      options: <String>[
        'From Adam down to the twelve tribes of Israel',
        "Only David's line",
        'Only the priests',
        'The kings of Egypt',
      ],
      correctIndex: 0,
      explanation:
          'The lists trace back to Adam (1 Chronicles 1-2).',
    ),
    QuizQuestion(
      text: "From which tribe does David's royal line come?",
      options: <String>['Judah', 'Levi', 'Benjamin', 'Ephraim'],
      correctIndex: 0,
      explanation:
          "Judah's genealogy includes the house of David "
          '(1 Chronicles 2-3).',
      type: QuizAnswerType.freeText,
    ),
    QuizQuestion(
      text: 'Which tribes settled east of the Jordan according to these '
          'genealogies?',
      options: <String>[
        'Reuben, Gad, and half of Manasseh',
        'Judah and Benjamin',
        'Levi and Simeon',
        'Dan and Naphtali',
      ],
      correctIndex: 0,
      explanation:
          'Their territory and leaders are recorded (1 Chronicles 5).',
    ),
  ],
  '1 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Why did Uzzah die while transporting the Ark?',
      options: <String>[
        "He touched it as it slipped, against God's instructions",
        'He stole it',
        'He refused to carry it',
        'He mocked the procession',
      ],
      correctIndex: 0,
      explanation:
          "The transport did not follow God's instructions "
          '(1 Chronicles 13).',
    ),
    QuizQuestion(
      text: 'How was the Ark finally transported correctly to Jerusalem?',
      options: <String>[
        'Carried by the Levites, as the Law prescribed',
        'On a cart pulled by oxen',
        'By boat',
        'By Egyptian priests',
      ],
      correctIndex: 0,
      explanation:
          'David corrects the earlier mistake (1 Chronicles 15).',
    ),
    QuizQuestion(
      text: 'Against whom did David win notable victories in these '
          'chapters?',
      options: <String>[
        'The Philistines',
        'The Egyptians',
        'The Babylonians',
        'The Persians',
      ],
      correctIndex: 0,
      explanation:
          'David defeats the Philistines several times '
          '(1 Chronicles 14).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Philistines'],
    ),
  ],
  '1 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text: 'What song did Asaph compose when the Ark was installed?',
      options: <String>[
        'A song of praise and thanksgiving',
        'A song of mourning',
        'A prophecy of disaster',
        'A war song',
      ],
      correctIndex: 0,
      explanation:
          'This psalm of praise is entrusted to Asaph '
          '(1 Chronicles 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['lament', 'psalm', 'trumpet'],
    ),
    QuizQuestion(
      text: 'Why was David unable to build the temple himself?',
      options: <String>[
        'He had shed much blood in war',
        'He lacked wealth',
        'He had no plan',
        'The people opposed it',
      ],
      correctIndex: 0,
      explanation:
          'Jehovah reserves this task for Solomon (1 Chronicles 22; '
          '28).',
    ),
    QuizQuestion(
      text: 'Where did David buy the site of the future temple?',
      options: <String>[
        'The threshing floor of Ornan (Araunah)',
        'A field near Hebron',
        'A hill in Shiloh',
        'Land given by Hiram',
      ],
      correctIndex: 0,
      explanation:
          'David builds an altar there after the plague '
          '(1 Chronicles 21).',
    ),
  ],
  '1 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: 'How did David organize the service of the Levites?',
      options: <String>[
        'Into groups with specific assigned tasks',
        'They had no organization at all',
        'One man handled everything',
        'They were exempted from service',
      ],
      correctIndex: 0,
      explanation:
          'The Levites are divided by function (1 Chronicles 23).',
    ),
    QuizQuestion(
      text: 'What role did the musicians appointed by David play?',
      options: <String>[
        'Prophesying and giving praise with instruments',
        'Fighting on the front lines',
        'Judging court cases',
        'Teaching reading only',
      ],
      correctIndex: 0,
      explanation:
          'Asaph, Heman, and Jeduthun direct the sacred music '
          '(1 Chronicles 25).',
    ),
    QuizQuestion(
      text: "What was David's last great public act before his death?",
      options: <String>[
        'Charging Solomon and the people to build the temple',
        'Waging one last war',
        'Revising all the laws',
        'Going into voluntary exile',
      ],
      correctIndex: 0,
      explanation:
          'David prays and blesses the assembly before dying '
          '(1 Chronicles 28-29).',
    ),
  ],
  '2 Chronicles#0': <QuizQuestion>[
    QuizQuestion(
      text: 'What does Solomon ask Jehovah for at the start of his reign?',
      options: <String>[
        'Wisdom and knowledge to govern',
        'Riches above all',
        'A powerful army',
        'A life without hardship',
      ],
      correctIndex: 0,
      explanation:
          'His request pleases God, who also gives him riches '
          '(2 Chronicles 1).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['riches', 'honor', 'temple'],
    ),
    QuizQuestion(
      text: 'What happened when the temple was dedicated?',
      options: <String>[
        'Fire came down from heaven and glory filled the house',
        'An earthquake destroyed everything',
        'Nothing in particular happened',
        'The people scattered',
      ],
      correctIndex: 0,
      explanation:
          'A spectacular manifestation confirms divine approval '
          '(2 Chronicles 7).',
    ),
    QuizQuestion(
      text: 'What prayer does Solomon offer at the dedication?',
      options: <String>[
        'A plea for God to hear the prayers made toward this place',
        'A request for more riches',
        'A declaration of war',
        'A song of mourning',
      ],
      correctIndex: 0,
      explanation:
          'Solomon asks God to listen from heaven (2 Chronicles 6).',
    ),
  ],
  '2 Chronicles#1': <QuizQuestion>[
    QuizQuestion(
      text: 'Who visited Solomon to test his wisdom?',
      options: <String>[
        'The queen of Sheba',
        'The king of Assyria',
        'Pharaoh of Egypt',
        'The king of Tyre',
      ],
      correctIndex: 0,
      explanation:
          'She is impressed by his wisdom and wealth (2 Chronicles 9).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Solomon', 'Egypt', 'Tyre'],
    ),
    QuizQuestion(
      text: 'Why did the kingdom divide under Rehoboam?',
      options: <String>[
        'His refusal to lighten the burden Solomon had imposed',
        'A foreign invasion',
        "The king's sudden death",
        'A peaceful agreement to divide it',
      ],
      correctIndex: 0,
      explanation:
          'His harshness drives ten tribes to follow Jeroboam '
          '(2 Chronicles 10).',
    ),
    QuizQuestion(
      text: 'How did Asa respond to the Ethiopian invasion?',
      options: <String>[
        'He prayed to Jehovah before the battle and won',
        'He surrendered without fighting',
        'He fled with his army',
        'He paid a heavy tribute',
      ],
      correctIndex: 0,
      explanation:
          'His trust in God is rewarded (2 Chronicles 14).',
    ),
  ],
  '2 Chronicles#2': <QuizQuestion>[
    QuizQuestion(
      text: 'What illness struck Asa after he neglected to seek Jehovah?',
      options: <String>[
        'A severe disease in his feet',
        'Leprosy',
        'Blindness',
        'Total paralysis',
      ],
      correctIndex: 0,
      explanation:
          'He consults physicians instead of God (2 Chronicles 16).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['eyes', 'hands', 'leprosy'],
    ),
    QuizQuestion(
      text: 'Why was Jehoshaphat rebuked by a prophet?',
      options: <String>[
        'For his alliance with the wicked King Ahab',
        'For neglecting the temple',
        'For refusing to go to war',
        'For abolishing the festivals',
      ],
      correctIndex: 0,
      explanation:
          'His alliance with Ahab is criticized (2 Chronicles 19).',
    ),
    QuizQuestion(
      text: 'How did Jehoshaphat win a victory without fighting?',
      options: <String>[
        'By praying, while his enemies turned on each other',
        'Through a negotiated truce',
        'Through a strategic retreat',
        'Through a treaty with Egypt',
      ],
      correctIndex: 0,
      explanation:
          'Trust in God precedes a miraculous deliverance '
          '(2 Chronicles 20).',
    ),
  ],
  '2 Chronicles#3': <QuizQuestion>[
    QuizQuestion(
      text: "How was young Joash saved from Athaliah's massacre?",
      options: <String>[
        'Hidden in the temple by his aunt',
        'Secretly sent abroad',
        'Adopted by a foreign priest',
        'Protected by an allied army',
      ],
      correctIndex: 0,
      explanation:
          'Jehoshabeath hides him until his coronation '
          '(2 Chronicles 22-23).',
    ),
    QuizQuestion(
      text: 'Why was Uzziah struck with leprosy?',
      options: <String>[
        'He tried to offer incense, a task reserved for priests',
        'He refused to pay the tithe',
        'He insulted a prophet',
        'He neglected the army',
      ],
      correctIndex: 0,
      explanation:
          'His pride leads him to overstep his role (2 Chronicles 26).',
    ),
    QuizQuestion(
      text: 'What does Hezekiah do at the very start of his reign?',
      options: <String>[
        'He reopens and purifies the temple',
        'He declares war on Assyria',
        'He abolishes all the festivals',
        'He moves the capital',
      ],
      correctIndex: 0,
      explanation:
          'Hezekiah undertakes a great religious reform '
          '(2 Chronicles 29).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['altar', 'Passover', 'gates'],
    ),
  ],
  '2 Chronicles#4': <QuizQuestion>[
    QuizQuestion(
      text: 'What great festival did Hezekiah organize after the '
          "temple's purification?",
      options: <String>['An extraordinary Passover', 'The Festival of Booths', 'The Jubilee', 'Pentecost'],
      correctIndex: 0,
      explanation:
          'This Passover gathers Judah and part of Israel '
          '(2 Chronicles 30).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Passover', 'the Passover'],
    ),
    QuizQuestion(
      text: 'What happened after Manasseh repented in captivity?',
      options: <String>[
        'Jehovah brought him back to Jerusalem and he carried out '
            'reforms',
        'He remained a captive for life',
        'He was executed',
        'Nothing changed',
      ],
      correctIndex: 0,
      explanation:
          'His sincere repentance changes his fate (2 Chronicles 33).',
    ),
    QuizQuestion(
      text: 'How does the book of Chronicles end?',
      options: <String>[
        "With Cyrus's decree authorizing the return and rebuilding of "
            'the temple',
        'With final, hopeless destruction',
        'With the crowning of a new Davidic king',
        'With a prolonged civil war',
      ],
      correctIndex: 0,
      explanation:
          "Cyrus's decree opens the way for the return from exile "
          '(2 Chronicles 36).',
    ),
  ],
  'Ezra#0': <QuizQuestion>[
    QuizQuestion(
      text: 'Who authorized the exiles to return and rebuild the temple?',
      options: <String>['Cyrus, king of Persia', 'Nebuchadnezzar', 'Darius alone', 'Xerxes'],
      correctIndex: 0,
      explanation:
          'Cyrus issues a liberating decree (Ezra 1).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Cyrus'],
    ),
    QuizQuestion(
      text: 'What did the exiles do as soon as they returned, even '
          'before finishing the temple?',
      options: <String>[
        'They rebuilt the altar to offer sacrifices',
        'They elected a new king',
        'They attacked their neighbors',
        'They refused all worship',
      ],
      correctIndex: 0,
      explanation:
          'The altar is restored before the foundation is laid '
          '(Ezra 3).',
    ),
    QuizQuestion(
      text: "What mixed reaction followed the laying of the new temple's "
          'foundation?',
      options: <String>[
        'Joy from the young, weeping from the elders who remembered '
            'the first one',
        'General indifference',
        'Unanimous anger',
        'The people fled',
      ],
      correctIndex: 0,
      explanation:
          "The contrast with Solomon's temple moves the elders to "
          'tears (Ezra 3).',
    ),
  ],
  'Ezra#1': <QuizQuestion>[
    QuizQuestion(
      text: 'How was the rebuilding work interrupted?',
      options: <String>[
        'Local adversaries forced the work to stop',
        'An earthquake destroyed everything',
        'The people ran out of materials',
        'The workers left on their own',
      ],
      correctIndex: 0,
      explanation:
          'Political opposition halts the project (Ezra 4).',
    ),
    QuizQuestion(
      text: 'Who encouraged the resumption of the temple work through '
          'their prophecies?',
      options: <String>[
        'Haggai and Zechariah',
        'Ezekiel and Daniel',
        'Isaiah and Jeremiah',
        'Hosea and Amos',
      ],
      correctIndex: 0,
      explanation:
          'Their messages spur the construction forward again '
          '(Ezra 5).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['Ezra', 'Nehemiah', 'Daniel'],
    ),
    QuizQuestion(
      text: 'Who arrived later from Babylon with an additional group of '
          'exiles?',
      options: <String>['Ezra, priest and scribe', 'Nehemiah', 'Zerubbabel', 'Mordecai'],
      correctIndex: 0,
      explanation:
          'Ezra arrives during the reign of Artaxerxes (Ezra 7).',
      type: QuizAnswerType.freeText,
      acceptedAnswers: <String>['Ezra'],
    ),
  ],
  'Ezra#2': <QuizQuestion>[
    QuizQuestion(
      text: 'Why did Ezra not request an armed escort for the journey?',
      options: <String>[
        "He had expressed his trust in God's protection",
        'The king had refused him one',
        'The journey was without danger',
        'He already had an army',
      ],
      correctIndex: 0,
      explanation:
          "Ezra had testified to God's protection (Ezra 8).",
    ),
    QuizQuestion(
      text: "What problem deeply grieved Ezra upon his arrival?",
      options: <String>[
        'Marriages with women from the surrounding nations',
        'A lack of offerings',
        'A famine',
        'A civil war',
      ],
      correctIndex: 0,
      explanation:
          'Ezra tears his garments in anguish (Ezra 9).',
    ),
    QuizQuestion(
      text: "How did the people respond to Ezra's appeal?",
      options: <String>[
        'By confessing their wrongdoing and correcting the situation',
        'By refusing any change',
        'By expelling Ezra',
        'By ignoring the appeal',
      ],
      correctIndex: 0,
      explanation:
          'A collective reform takes place (Ezra 10).',
    ),
  ],
  'Nehemiah#0': <QuizQuestion>[
    QuizQuestion(
      text: "How did Nehemiah react on learning the condition of "
          "Jerusalem's walls?",
      options: <String>[
        'He wept, fasted, and prayed',
        'He remained indifferent',
        'He resigned from his post',
        'He held a celebration',
      ],
      correctIndex: 0,
      explanation:
          'His grief moves him to act (Nehemiah 1).',
    ),
    QuizQuestion(
      text: 'What did Nehemiah ask King Artaxerxes for?',
      options: <String>[
        'Permission to go rebuild the walls',
        'Gold for himself',
        'A higher position at court',
        "Freedom to leave the king's service",
      ],
      correctIndex: 0,
      explanation:
          'The king agrees and provides him with resources '
          '(Nehemiah 2).',
      type: QuizAnswerType.wordBank,
      wordBankDistractors: <String>['temple', 'king', 'Jerusalem'],
    ),
    QuizQuestion(
      text: 'How did the builders respond to mockery and threats?',
      options: <String>[
        'They worked with one hand busy and the other holding a '
            'weapon',
        'They stopped the project',
        'They fled the city',
        'They negotiated with the opponents',
      ],
      correctIndex: 0,
      explanation:
          'Vigilance and determination mark the work (Nehemiah 4).',
    ),
  ],
  'Nehemiah#1': <QuizQuestion>[
    QuizQuestion(
      text: 'What social injustice did Nehemiah denounce among the '
          'people?',
      options: <String>[
        'Abusive loans that impoverished the poor',
        'Refusal to pay the tithe',
        'Disregard for the Sabbath alone',
        'Corruption among the judges',
      ],
      correctIndex: 0,
      explanation:
          'Nehemiah corrects this unjust practice (Nehemiah 5).',
    ),
    QuizQuestion(
      text: 'In how much time was the wall of Jerusalem completed?',
      options: <String>['52 days', 'One year', 'Ten years', 'One week'],
      correctIndex: 0,
      explanation:
          'A remarkable feat despite strong opposition (Nehemiah 6).',
    ),
    QuizQuestion(
      text: 'What happened when Ezra read the Law publicly to the '
          'people?',
      options: <String>[
        'The people first wept, then celebrated with joy',
        'The people revolted',
        'No one listened',
        'The reading was interrupted',
      ],
      correctIndex: 0,
      explanation:
          'The Festival of Booths follows this moving reading '
          '(Nehemiah 8).',
    ),
  ],
  'Nehemiah#2': <QuizQuestion>[
    QuizQuestion(
      text: 'What did the people do after the reading of the Law and the '
          'national confession?',
      options: <String>[
        'They signed a written pledge to obey God',
        'They left Jerusalem',
        'They abolished the festivals',
        'They exiled the priests',
      ],
      correctIndex: 0,
      explanation:
          'A written covenant seals this commitment (Nehemiah 9-10).',
    ),
    QuizQuestion(
      text: 'How was the dedication of the wall celebrated?',
      options: <String>[
        'With processions of singing and thanksgiving',
        'With a silent fast',
        'With a military ceremony',
        'By closing the gates',
      ],
      correctIndex: 0,
      explanation:
          'Two choirs walk around the wall singing (Nehemiah 12).',
    ),
    QuizQuestion(
      text: 'What reform did Nehemiah impose upon his return from a '
          'second term?',
      options: <String>[
        'Strict observance of the Sabbath and the expulsion of Tobiah',
        'Abolishing the temple',
        'A new census',
        'Building a palace',
      ],
      correctIndex: 0,
      explanation:
          'Nehemiah corrects several abuses that had returned during '
          'his absence (Nehemiah 13).',
    ),
  ],
};

const Map<String, List<QuizQuestion>> extraQuizzesEnC2 = <String, List<QuizQuestion>>{};
