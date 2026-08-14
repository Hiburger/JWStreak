const translations = {
  en: {
    _lang_code: "EN",
    _lang_label: "Change language",
    _html_lang: "en",
    title: "JW Streak Privacy Policy",
    meta_description: "Privacy Policy for JW Streak - an open-source, privacy-first Bible reading habit tracker.",
    h1: "JW Streak Privacy Policy",
    updated: "Last updated: August 14, 2026",
    intro: "JW Streak is a free, open-source Bible-reading habit tracker. This page explains, in plain terms, what happens to your data.",
    disclaimer: "<strong>JW Streak is an independent, unofficial project</strong> and is not affiliated with, endorsed by, or officially connected to Jehovah's Witnesses, the Watch Tower Bible and Tract Society, or JW.org. However, this project is entirely managed by one of Jehovah's Witnesses.",
    short_version_h: "Short version",
    short_version_p: "<strong>JW Streak collects nothing.</strong> There is no account, no server, and no analytics. Everything the app stores, such as your reading progress, notes, quiz results, streak, and settings stays in a local database on your device and is never transmitted anywhere.",
    local_storage_h: "What the app stores locally",
    local_storage_li1: "Which Bible chapters you've marked as read, and when",
    local_storage_li2: "Your personal notes and reflections",
    local_storage_li3: "Quiz results and earned achievements",
    local_storage_li4: "Your streak count and reminder schedule",
    local_storage_li5: "App preferences (theme, language, etc.)",
    local_storage_p: "All of this lives in a local SQLite database <strong>on your device</strong>. Uninstalling the app deletes it permanently. Nothing is backed up to a server we control, because we don't run one.",
    permissions_h: "Permissions the app requests",
    permissions_li1: "<strong>Notifications:</strong> To show your daily reading reminders.",
    permissions_li2: "<strong>Exact alarms:</strong> So reminders fire precisely at the time you scheduled.",
    permissions_li3: "<strong>Run at startup:</strong> To reschedule your reminders after your device restarts.",
    permissions_p: "None of these permissions involve sending data off your device.",
    network_h: "Network access",
    network_p1: "The app makes no network calls of its own: no analytics, no crash reporting, no ads, and no font or asset fetching at runtime. Every resource is bundled into the app itself.",
    network_p2: "The only time the app touches the network is when <strong>you tap a link</strong> to open a Bible passage: it opens either the JW Library app or jw.org in your browser depending on your preferences. Those external destinations are governed by their own privacy policies.",
    third_parties_h: "Third parties",
    third_parties_p: "We don't share data with third parties, because we don't collect any. No advertising SDKs, analytics SDKs, or tracking libraries are included in the app bundle.",
    children_h: "Children's & Minor's privacy",
    children_p: "The app doesn't collect personal information from anyone, including children.",
    open_source_h: "Open source",
    open_source_p: "JW Streak is free software (GNU GPLv3). You can inspect the full source code to verify every claim on this page:",
    github_btn: "View JWS on GitHub",
    changes_h: "Changes to this policy",
    changes_p: "If this policy ever changes, the update will be posted here with a revised \"last updated\" date.",
    footer_p: "Questions? Contact us at <a href=\"mailto:contact@olynthe.org\">contact@olynthe.org</a>",
    egg_streak_same_day: "Already checked in today! Streak: {n}/7",
    egg_streak_progress: "Streak: {n}/7 days. Come back tomorrow!",
    egg_streak_done: "Achievement unlocked! 7-day streak complete. Like JW Streak itself, this only lives on your device.",
    egg_visits: "You've visited this page {n} times."
  },
  fr: {
    _lang_code: "FR",
    _lang_label: "Changer de langue",
    _html_lang: "fr",
    title: "Politique de confidentialité de JW Streak",
    meta_description: "Politique de confidentialite de JW Streak - un suivi d'habitudes de lecture biblique open-source et respectueux de la vie privee.",
    h1: "Politique de confidentialité de JW Streak",
    updated: "Dernière mise à jour : 14 août 2026",
    intro: "JW Streak est un suivi d'habitudes de lecture biblique gratuit et open-source. Cette page explique, en termes simples, ce qui arrive à vos données.",
    disclaimer: "<strong>JW Streak est un projet indépendant et non officiel</strong> et n'est pas affilié, approuvé ou officiellement lié aux Témoins de Jéhovah, à la Watch Tower Bible and Tract Society, ni à JW.org. Toutefois, ce projet est entièrement géré par un Témoin de Jéhovah.",
    short_version_h: "En bref",
    short_version_p: "<strong>JW Streak ne collecte rien.</strong> Il n'y a pas de compte, pas de serveur et pas d'analytique. Tout ce que l'application stocke, comme votre progression de lecture, vos notes, vos résultats de quiz, votre série et vos paramètres, reste dans une base de données locale sur votre appareil et n'est jamais transmis nulle part.",
    local_storage_h: "Ce que l'application stocke localement",
    local_storage_li1: "Les chapitres bibliques que vous avez marqués comme lus, et quand",
    local_storage_li2: "Vos notes et réflexions personnelles",
    local_storage_li3: "Les résultats de quiz et les accomplissements obtenus",
    local_storage_li4: "Votre compteur de série et votre planning de rappels",
    local_storage_li5: "Les préférences de l'application (thème, langue, etc.)",
    local_storage_p: "Tout cela se trouve dans une base de données SQLite locale <strong>sur votre appareil</strong>. Désinstaller l'application les supprime définitivement. Rien n'est sauvegardé sur un serveur que nous contrôlons, car nous n'en exploitons aucun.",
    permissions_h: "Les autorisations demandées par l'application",
    permissions_li1: "<strong>Notifications :</strong> Pour afficher vos rappels de lecture quotidiens.",
    permissions_li2: "<strong>Alarmes exactes :</strong> Pour que les rappels se déclenchent précisément à l'heure que vous avez programmée.",
    permissions_li3: "<strong>Démarrage :</strong> Pour reprogrammer vos rappels après le redémarrage de votre appareil.",
    permissions_p: "Aucune de ces autorisations n'implique l'envoi de données en dehors de votre appareil.",
    network_h: "Accès au réseau",
    network_p1: "L'application n'effectue aucun appel réseau de son propre chef : pas d'analytique, pas de rapport de plantage, pas de publicité, et pas de récupération de polices ou de ressources au moment de l'exécution. Chaque ressource est intégrée dans l'application elle-même.",
    network_p2: "Le seul moment où l'application utilise le réseau, c'est lorsque <strong>vous appuyez sur un lien</strong> pour ouvrir un passage biblique : elle ouvre soit l'application JW Library, soit jw.org dans votre navigateur, selon vos préférences. Ces destinations externes sont régies par leurs propres politiques de confidentialité.",
    third_parties_h: "Tiers",
    third_parties_p: "Nous ne partageons aucune donnée avec des tiers, car nous n'en collectons aucune. Aucun SDK publicitaire, SDK d'analytique ou bibliothèque de suivi n'est inclus dans l'application.",
    children_h: "Confidentialité des enfants et des mineurs",
    children_p: "L'application ne collecte aucune donnée personnelle, y compris auprès des enfants.",
    open_source_h: "Open source",
    open_source_p: "JW Streak est un logiciel libre (GNU GPLv3). Vous pouvez consulter le code source complet pour vérifier chaque affirmation de cette page :",
    github_btn: "Voir JWS sur GitHub",
    changes_h: "Modifications de cette politique",
    changes_p: "Si cette politique change, la mise à jour sera publiée ici avec une nouvelle date de « dernière mise à jour ».",
    footer_p: "Des questions ? Contactez-nous à <a href=\"mailto:contact@olynthe.org\">contact@olynthe.org</a>",
    egg_streak_same_day: "Déjà pointé aujourd'hui ! Série : {n}/7",
    egg_streak_progress: "Série : {n}/7 jours. Reviens demain !",
    egg_streak_done: "Accomplissement débloqué ! Série de 7 jours. Comme JW Streak lui-même, ça ne vit que sur ton appareil.",
    egg_visits: "Tu as visité cette page {n} fois."
  },
  it: {
    _lang_code: "IT",
    _lang_label: "Cambia lingua",
    _html_lang: "it",
    title: "Informativa sulla privacy di JW Streak",
    meta_description: "Informativa sulla privacy di JW Streak - un'app open-source per tenere traccia delle abitudini di lettura della Bibbia, con un approccio privacy-first.",
    h1: "Informativa sulla privacy di JW Streak",
    updated: "Ultimo aggiornamento: 14 agosto 2026",
    intro: "JW Streak è un'app gratuita e open-source per tenere traccia delle abitudini di lettura della Bibbia. Questa pagina spiega, in termini semplici, cosa succede ai tuoi dati.",
    disclaimer: "<strong>JW Streak è un progetto indipendente e non ufficiale</strong> e non è affiliato, approvato o ufficialmente collegato ai Testimoni di Geova, alla Watch Tower Bible and Tract Society, né a JW.org. Tuttavia, questo progetto è interamente gestito da uno dei Testimoni di Geova.",
    short_version_h: "In breve",
    short_version_p: "<strong>JW Streak non raccoglie nulla.</strong> Non ci sono account, server o analisi. Tutto ciò che l'app memorizza, come i progressi di lettura, le note, i risultati dei quiz, la serie e le impostazioni, resta in un database locale sul tuo dispositivo e non viene mai trasmesso da nessuna parte.",
    local_storage_h: "Cosa l'app memorizza localmente",
    local_storage_li1: "Quali capitoli della Bibbia hai segnato come letti, e quando",
    local_storage_li2: "Le tue note e riflessioni personali",
    local_storage_li3: "I risultati dei quiz e i traguardi ottenuti",
    local_storage_li4: "Il conteggio della serie e la pianificazione dei promemoria",
    local_storage_li5: "Le preferenze dell'app (tema, lingua, ecc.)",
    local_storage_p: "Tutto questo si trova in un database SQLite locale <strong>sul tuo dispositivo</strong>. Disinstallare l'app li elimina definitivamente. Nulla viene salvato su un server che controlliamo, perché non ne gestiamo nessuno.",
    permissions_h: "Le autorizzazioni richieste dall'app",
    permissions_li1: "<strong>Notifiche:</strong> Per mostrare i promemoria di lettura giornalieri.",
    permissions_li2: "<strong>Allarmi esatti:</strong> Perché i promemoria si attivino precisamente all'orario che hai programmato.",
    permissions_li3: "<strong>Avvio:</strong> Per riprogrammare i promemoria dopo il riavvio del dispositivo.",
    permissions_p: "Nessuna di queste autorizzazioni comporta l'invio di dati al di fuori del tuo dispositivo.",
    network_h: "Accesso alla rete",
    network_p1: "L'app non effettua nessuna chiamata di rete di per sé: niente analisi, niente segnalazione di crash, niente pubblicità e nessun recupero di font o risorse durante l'esecuzione. Ogni risorsa è integrata nell'app stessa.",
    network_p2: "L'unica volta in cui l'app usa la rete è quando <strong>tocchi un collegamento</strong> per aprire un brano biblico: apre l'app JW Library oppure jw.org nel tuo browser, a seconda delle tue preferenze. Quelle destinazioni esterne sono regolate dalle rispettive informative sulla privacy.",
    third_parties_h: "Terze parti",
    third_parties_p: "Non condividiamo dati con terze parti, perché non ne raccogliamo nessuno. Nessun SDK pubblicitario, SDK di analisi o libreria di tracciamento è incluso nell'app.",
    children_h: "Privacy dei bambini e dei minori",
    children_p: "L'app non raccoglie informazioni personali da nessuno, inclusi i bambini.",
    open_source_h: "Open source",
    open_source_p: "JW Streak è software libero (GNU GPLv3). Puoi ispezionare il codice sorgente completo per verificare ogni affermazione su questa pagina:",
    github_btn: "Vedi JWS su GitHub",
    changes_h: "Modifiche a questa informativa",
    changes_p: "Se questa informativa cambia, l'aggiornamento sarà pubblicato qui con una nuova data di \"ultimo aggiornamento\".",
    footer_p: "Domande? Contattaci all'indirizzo <a href=\"mailto:contact@olynthe.org\">contact@olynthe.org</a>",
    egg_streak_same_day: "Già registrato oggi! Serie: {n}/7",
    egg_streak_progress: "Serie: {n}/7 giorni. Torna domani!",
    egg_streak_done: "Traguardo sbloccato! Serie di 7 giorni. Come JW Streak stesso, rimane solo sul tuo dispositivo.",
    egg_visits: "Hai visitato questa pagina {n} volte."
  },
  es: {
    _lang_code: "ES",
    _lang_label: "Cambiar idioma",
    _html_lang: "es",
    title: "Política de privacidad de JW Streak",
    meta_description: "Política de privacidad de JW Streak - una aplicación de código abierto para seguir tus hábitos de lectura de la Biblia, con enfoque privacy-first.",
    h1: "Política de privacidad de JW Streak",
    updated: "Última actualización: 14 de agosto de 2026",
    intro: "JW Streak es una aplicación gratuita y de código abierto para seguir tus hábitos de lectura de la Biblia. Esta página explica, en términos sencillos, qué ocurre con tus datos.",
    disclaimer: "<strong>JW Streak es un proyecto independiente y no oficial</strong> y no está afiliado, respaldado ni oficialmente vinculado a los Testigos de Jehová, a la Watch Tower Bible and Tract Society, ni a JW.org. Sin embargo, este proyecto es enteramente gestionado por uno de los Testigos de Jehová.",
    short_version_h: "En resumen",
    short_version_p: "<strong>JW Streak no recopila nada.</strong> No hay cuenta, ni servidor, ni analíticas. Todo lo que la aplicación almacena, como tu progreso de lectura, notas, resultados de cuestionarios, racha y ajustes, permanece en una base de datos local en tu dispositivo y nunca se transmite a ningún lugar.",
    local_storage_h: "Lo que la aplicación almacena localmente",
    local_storage_li1: "Qué capítulos de la Biblia has marcado como leídos, y cuándo",
    local_storage_li2: "Tus notas y reflexiones personales",
    local_storage_li3: "Resultados de cuestionarios y logros obtenidos",
    local_storage_li4: "Tu recuento de racha y la programación de recordatorios",
    local_storage_li5: "Las preferencias de la aplicación (tema, idioma, etc.)",
    local_storage_p: "Todo esto se encuentra en una base de datos SQLite local <strong>en tu dispositivo</strong>. Desinstalar la aplicación lo elimina de forma permanente. Nada se respalda en un servidor que controlemos, porque no gestionamos ninguno.",
    permissions_h: "Los permisos que solicita la aplicación",
    permissions_li1: "<strong>Notificaciones:</strong> Para mostrar tus recordatorios de lectura diarios.",
    permissions_li2: "<strong>Alarmas exactas:</strong> Para que los recordatorios se activen precisamente a la hora que programaste.",
    permissions_li3: "<strong>Inicio:</strong> Para reprogramar tus recordatorios después de reiniciar tu dispositivo.",
    permissions_p: "Ninguno de estos permisos implica enviar datos fuera de tu dispositivo.",
    network_h: "Acceso a la red",
    network_p1: "La aplicación no realiza ninguna llamada de red por sí misma: sin analíticas, sin informes de fallos, sin anuncios y sin recuperación de fuentes ni recursos en tiempo de ejecución. Cada recurso está integrado en la propia aplicación.",
    network_p2: "La única vez que la aplicación usa la red es cuando <strong>tocas un enlace</strong> para abrir un pasaje bíblico: abre la aplicación JW Library o jw.org en tu navegador, según tus preferencias. Esos destinos externos se rigen por sus propias políticas de privacidad.",
    third_parties_h: "Terceros",
    third_parties_p: "No compartimos datos con terceros, porque no recopilamos ninguno. No se incluyen SDKs publicitarios, SDKs de analíticas ni bibliotecas de seguimiento en la aplicación.",
    children_h: "Privacidad de niños y menores",
    children_p: "La aplicación no recopila información personal de nadie, incluidos los niños.",
    open_source_h: "Código abierto",
    open_source_p: "JW Streak es software libre (GNU GPLv3). Puedes inspeccionar el código fuente completo para verificar cada afirmación de esta página:",
    github_btn: "Ver JWS en GitHub",
    changes_h: "Cambios en esta política",
    changes_p: "Si esta política cambia, la actualización se publicará aquí con una nueva fecha de \"última actualización\".",
    footer_p: "¿Preguntas? Contáctanos en <a href=\"mailto:contact@olynthe.org\">contact@olynthe.org</a>",
    egg_streak_same_day: "¡Ya registraste hoy! Racha: {n}/7",
    egg_streak_progress: "Racha: {n}/7 días. ¡Vuelve mañana!",
    egg_streak_done: "¡Logro desbloqueado! Racha de 7 días. Como JW Streak mismo, esto solo permanece en tu dispositivo.",
    egg_visits: "Has visitado esta página {n} veces."
  },
  de: {
    _lang_code: "DE",
    _lang_label: "Sprache ändern",
    _html_lang: "de",
    title: "Datenschutzerklärung von JW Streak",
    meta_description: "Datenschutzerklärung von JW Streak - eine Open-Source-App zur Verfolgung deiner Bibellese-Gewohnheiten, mit Fokus auf Datenschutz.",
    h1: "Datenschutzerklärung von JW Streak",
    updated: "Letzte Aktualisierung: 14. August 2026",
    intro: "JW Streak ist eine kostenlose, Open-Source-App zur Verfolgung deiner Bibellese-Gewohnheiten. Diese Seite erklärt in einfachen Worten, was mit deinen Daten passiert.",
    disclaimer: "<strong>JW Streak ist ein unabhängiges, inoffizielles Projekt</strong> und ist nicht offiziell mit den Zeugen Jehovas, der Watch Tower Bible and Tract Society oder JW.org verbunden, von ihnen unterstützt oder angeschlossen. Dennoch wird dieses Projekt vollständig von einem Zeugen Jehovas verwaltet.",
    short_version_h: "Kurzversion",
    short_version_p: "<strong>JW Streak sammelt nichts.</strong> Es gibt kein Konto, keinen Server und keine Analysen. Alles, was die App speichert, wie deinen Lese Fortschritt, Notizen, Quizergebnisse, deine Serie und Einstellungen, bleibt in einer lokalen Datenbank auf deinem Gerät und wird nie irgendwo übertragen.",
    local_storage_h: "Was die App lokal speichert",
    local_storage_li1: "Welche Bibelkapitel du als gelesen markiert hast, und wann",
    local_storage_li2: "Deine persönlichen Notizen und Überlegungen",
    local_storage_li3: "Quizergebnisse und erzielte Erfolge",
    local_storage_li4: "Deinen Serien-Zähler und deinen Erinnerungsplan",
    local_storage_li5: "App-Einstellungen (Design, Sprache usw.)",
    local_storage_p: "All dies befindet sich in einer lokalen SQLite-Datenbank <strong>auf deinem Gerät</strong>. Beim Deinstallieren der App wird alles dauerhaft gelöscht. Es wird nichts auf einem von uns kontrollierten Server gesichert, weil wir keinen betreiben.",
    permissions_h: "Berechtigungen, die die App anfordert",
    permissions_li1: "<strong>Benachrichtigungen:</strong> Um deine täglichen Lese-Erinnerungen anzuzeigen.",
    permissions_li2: "<strong>Exakte Wecker:</strong> Damit Erinnerungen genau zur eingestellten Zeit ausgelöst werden.",
    permissions_li3: "<strong>Beim Start ausführen:</strong> Um deine Erinnerungen nach einem Neustart des Geräts neu zu planen.",
    permissions_p: "Keine dieser Berechtigungen beinhaltet das Senden von Daten von deinem Gerät weg.",
    network_h: "Netzwerkzugriff",
    network_p1: "Die App führt von sich aus keine Netzwerkaufrufe durch: keine Analysen, keine Absturzberichte, keine Werbung und kein Abrufen von Schriftarten oder Ressourcen zur Laufzeit. Jede Ressource ist in die App selbst integriert.",
    network_p2: "Die einzige Situation, in der die App das Netzwerk nutzt, ist, wenn <strong>du auf einen Link tippst</strong>, um eine Bibelstelle zu öffnen: Sie öffnet entweder die JW Library-App oder jw.org in deinem Browser, je nach deinen Einstellungen. Diese externen Ziele unterliegen ihren eigenen Datenschutzerklärungen.",
    third_parties_h: "Dritte",
    third_parties_p: "Wir teilen keine Daten mit Dritten, weil wir keine sammeln. In der App sind keine Werbe-SDKs, Analyse-SDKs oder Tracking-Bibliotheken enthalten.",
    children_h: "Datenschutz von Kindern und Minderjährigen",
    children_p: "Die App sammelt keine persönlichen Daten von niemandem, auch nicht von Kindern.",
    open_source_h: "Open Source",
    open_source_p: "JW Streak ist freie Software (GNU GPLv3). Du kannst den vollständigen Quellcode einsehen, um jede Aussage auf dieser Seite zu überprüfen:",
    github_btn: "JWS auf GitHub ansehen",
    changes_h: "Änderungen an dieser Richtlinie",
    changes_p: "Sollte sich diese Richtlinie ändern, wird die Aktualisierung hier mit einem neuen „Letzte Aktualisierung“-Datum veröffentlicht.",
    footer_p: "Fragen? Kontaktiere uns unter <a href=\"mailto:contact@olynthe.org\">contact@olynthe.org</a>",
    egg_streak_same_day: "Heute schon eingetragen! Serie: {n}/7",
    egg_streak_progress: "Serie: {n}/7 Tage. Komm morgen wieder!",
    egg_streak_done: "Erfolg freigeschaltet! 7-Tage-Serie. Wie JW Streak selbst, bleibt dies nur auf deinem Gerät.",
    egg_visits: "Du hast diese Seite {n} Mal besucht."
  }
};

const LANG_ORDER = ["en", "fr", "it", "es", "de"];
const STORAGE_KEY = "jw-streak-lang";
const THEME_KEY = "jw-streak-theme";
const VISITS_KEY = "jw-streak-visits";
const LOGO_STREAK_KEY = "jw-streak-logo-streak";
const LOGO_STREAK_DATE_KEY = "jw-streak-logo-date";

function isDarkActive() {
  return document.documentElement.getAttribute("data-theme") === "dark" ||
    (!document.documentElement.hasAttribute("data-theme") &&
      window.matchMedia("(prefers-color-scheme: dark)").matches);
}

function applyStoredTheme() {
  const stored = localStorage.getItem(THEME_KEY);
  if (stored === "dark") {
    document.documentElement.setAttribute("data-theme", "dark");
  } else if (stored === "light") {
    document.documentElement.setAttribute("data-theme", "light");
  }
}

function applyLang(lang) {
  const t = translations[lang];
  if (!t) return;

  document.documentElement.lang = t._html_lang;
  document.title = t.title;
  document.querySelector('meta[name="description"]').setAttribute("content", t.meta_description);

  document.querySelectorAll("[data-i18n]").forEach((el) => {
    const key = el.getAttribute("data-i18n");
    if (t[key] !== undefined) {
      el.innerHTML = t[key];
    }
  });

  const langLabel = document.querySelector(".lang-btn span");
  if (langLabel) langLabel.textContent = t._lang_code;
  const langBtn = document.querySelector(".lang-btn");
  if (langBtn) langBtn.setAttribute("aria-label", t._lang_label);
}

function currentLang() {
  const stored = localStorage.getItem(STORAGE_KEY);
  if (stored && translations[stored]) return stored;
  const browser = (navigator.language || "en").slice(0, 2).toLowerCase();
  return translations[browser] ? browser : "en";
}

function updateMenuActive(lang) {
  document.querySelectorAll(".lang-menu button").forEach((btn) => {
    btn.classList.toggle("active", btn.getAttribute("data-lang") === lang);
  });
}

function closeDropdown() {
  const dd = document.querySelector(".lang-dropdown");
  if (!dd) return;
  dd.classList.remove("open");
  const btn = dd.querySelector(".lang-btn");
  if (btn) btn.setAttribute("aria-expanded", "false");
}

let toastTimer;
function showToast(message) {
  const toast = document.querySelector(".toast");
  if (!toast) return;
  toast.textContent = message;
  toast.classList.add("show");
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => toast.classList.remove("show"), 4000);
}

function todayStr() {
  return new Date().toISOString().slice(0, 10);
}

function daysBetween(last, today) {
  const d1 = new Date(last + "T00:00:00");
  const d2 = new Date(today + "T00:00:00");
  return Math.round((d2 - d1) / 86400000);
}

function initEasterEggs() {
  // Visit counter, incremented on every page load
  const visits = parseInt(localStorage.getItem(VISITS_KEY) || "0", 10) + 1;
  localStorage.setItem(VISITS_KEY, visits);

  // Logo streak
  document.querySelector(".header-logo").addEventListener("click", () => {
    const t = translations[currentLang()];
    const last = localStorage.getItem(LOGO_STREAK_DATE_KEY);
    const today = todayStr();

    if (last === today) {
      const streak = parseInt(localStorage.getItem(LOGO_STREAK_KEY) || "0", 10);
      showToast(t.egg_streak_same_day.replace("{n}", streak));
      return;
    }

    let streak;
    if (last && daysBetween(last, today) === 1) {
      streak = parseInt(localStorage.getItem(LOGO_STREAK_KEY) || "0", 10) + 1;
    } else {
      streak = 1;
    }

    localStorage.setItem(LOGO_STREAK_KEY, streak);
    localStorage.setItem(LOGO_STREAK_DATE_KEY, today);

    if (streak >= 7) {
      showToast(t.egg_streak_done);
    } else {
      showToast(t.egg_streak_progress.replace("{n}", streak));
    }
  });

  // "Collects nothing" irony
  document.querySelector("#collects-nothing").addEventListener("click", () => {
    const t = translations[currentLang()];
    showToast(t.egg_visits.replace("{n}", visits));
  });
}

document.addEventListener("DOMContentLoaded", () => {
  applyStoredTheme();

  const lang = currentLang();
  applyLang(lang);
  updateMenuActive(lang);
  document.body.classList.add("ready");

  const dropdown = document.querySelector(".lang-dropdown");
  const langBtn = document.querySelector(".lang-btn");

  langBtn.addEventListener("click", (e) => {
    e.stopPropagation();
    const isOpen = dropdown.classList.toggle("open");
    langBtn.setAttribute("aria-expanded", isOpen ? "true" : "false");
  });

  document.querySelector(".lang-menu").addEventListener("click", (e) => {
    const btn = e.target.closest("button[data-lang]");
    if (!btn) return;
    const next = btn.getAttribute("data-lang");
    if (!translations[next]) return;
    localStorage.setItem(STORAGE_KEY, next);
    applyLang(next);
    updateMenuActive(next);
    closeDropdown();
  });

  document.addEventListener("click", () => closeDropdown());
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") closeDropdown();
  });

  document.querySelector(".theme-btn").addEventListener("click", () => {
    const next = isDarkActive() ? "light" : "dark";
    localStorage.setItem(THEME_KEY, next);
    document.documentElement.setAttribute("data-theme", next);
  });

  initEasterEggs();
});
