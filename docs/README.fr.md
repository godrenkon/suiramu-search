<p align="right">
🌐 <a href="../README.md">日本語</a> | <a href="README.en.md">English</a> | <a href="README.zh.md">中文</a> | <a href="README.ko.md">한국어</a> | <a href="README.es.md">Español</a> | <b>Français</b>
</p>

# 🌐 Suiramu Search (S.S.)

**Un environnement d'accès à l'apprentissage pour les étudiants, entièrement centré sur « rechercher » et « regarder des vidéos »**

Suiramu Search exécute un vrai navigateur Chromium sur GitHub Codespaces, et vous accédez à internet à travers lui. Rien n'est installé sur votre propre ordinateur : tout fonctionne dans le navigateur.

![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-active-brightgreen)

---

## 🎯 Qu'est-ce que c'est ?

Suiramu Search (**S.S.** en abrégé) propose **deux modes**. Choisissez celui qui correspond à ce que vous voulez faire.

| Mode | À utiliser pour | Optimisé pour |
|---|---|---|
| 🔍 **Mode recherche** | Faire des recherches, rédiger des rapports, lire | Texte net, léger |
| 🎬 **Mode vidéo** | Regarder YouTube et sites similaires | Vidéo fluide, avec le son |

Plutôt que de tout faire sur un seul écran, Suiramu bascule entre les modes pour que chacun soit réellement confortable à utiliser.

---

## 🚀 Comment l'utiliser (3 étapes)

### Étape 1 : Ouvrir un Codespace

Cliquez sur le bouton vert **« Code »** de cette page → onglet **« Codespaces »** → **« Create codespace on main »**

La configuration se lance automatiquement la première fois (environ 3 à 5 minutes).

### Étape 2 : Démarrer un mode

Dans le terminal en bas de l'écran, tapez l'une des commandes suivantes puis appuyez sur Entrée.

**Pour faire des recherches et lire :**
```bash
npm run search
```

**Pour regarder des vidéos :**
```bash
npm run video
```

### Étape 3 : Ouvrir l'écran

- Cliquez sur l'onglet **« Ports »** en bas de l'écran
- Cliquez sur l'icône du globe (🌐) sur la ligne `6080`
- Un nouvel onglet s'ouvre automatiquement avec Suiramu (sans écran de configuration de connexion)

**Le mode vidéo nécessite une étape supplémentaire :**
- Appuyez une fois sur le bouton de lecture du **🔊 lecteur audio** en bas de l'écran
- (Les navigateurs bloquent la lecture automatique du son, ce clic manuel est donc nécessaire la première fois)

---

## 🔁 Si vous fermez accidentellement l'onglet Suiramu

Pas besoin de retourner dans le terminal pour retaper une commande. Faites un clic droit n'importe où sur le fond vide de l'écran, un menu pour rouvrir Suiramu apparaîtra.

```
Clic droit → Suiramu → 🔍 Ouvrir Suiramu (Recherche)
Clic droit → Suiramu → 🎬 Ouvrir Suiramu (Vidéo)
```

En cliquant dessus, l'écran de Suiramu se rouvre instantanément. Les services en arrière-plan (comme la sauvegarde des données) continuent de fonctionner, vous retrouvez donc directement où vous en étiez.

---

## 🔄 Changer de mode

Appuyez sur `Ctrl + C` dans le terminal pour arrêter le mode actuel, puis lancez l'autre commande.

```bash
# Exemple : passer du mode recherche au mode vidéo
Ctrl + C            ← arrêter le mode actuel
npm run video        ← démarrer le mode vidéo
```

---

## 🔍 Fonctionnalités du mode recherche

- Recherchez ou tapez directement une URL dans la barre de recherche au centre de l'écran
- Choisissez votre moteur de recherche parmi **Google / Bing / DuckDuckGo / Wikipedia** (menu déroulant au-dessus de la barre de recherche)
- Enregistrez vos sites fréquemment utilisés sous forme d'icônes (ajoutez avec le bouton ＋, supprimez avec un clic droit)
- Les onglets multiples et l'historique de navigation fonctionnent exactement comme dans un vrai navigateur Chromium
  - `Ctrl + T` : nouvel onglet　`Ctrl + H` : historique　`Ctrl + Shift + T` : rouvrir un onglet fermé

---

## 🎬 Fonctionnalités du mode vidéo

- Des icônes de raccourci vers YouTube / Twitch / Niconico / Vimeo sont présentes dès le départ
- Les paramètres de transmission d'écran sont ajustés pour une lecture vidéo fluide
- Le son est diffusé via un canal dédié (un haut-parleur virtuel dans le Codespace → un flux audio)
- Vous pouvez aussi rechercher des vidéos depuis la barre de recherche (elle redirige vers la recherche YouTube)

### Une remarque honnête sur le son

Comme le son est diffusé via le réseau, il ne peut pas être **parfaitement continu ni sans latence**. Attendez-vous à un délai de quelques centaines de millisecondes à environ une seconde, et à des coupures occasionnelles selon votre connexion. Cela dit, il est ajusté pour rester utilisable en pratique.

Si la vidéo ou le son saccade :
- Améliorer les caractéristiques de la machine de votre Codespace peut aider (`Settings → Codespaces → Machine type`)
- Réduire la qualité vidéo sur le site lui-même aide souvent aussi

---

## 💾 À propos du stockage des données (intégration avec le compte GitHub)

Les sites enregistrés (favoris) sont automatiquement stockés dans **un dépôt privé rien que pour vous**, `<votre-nom-d'utilisateur>/suiramu-data`.

- Ce dépôt est créé automatiquement la première fois que vous lancez l'outil (Private)
- Les nouveaux sites que vous ajoutez y sont sauvegardés automatiquement en quelques secondes
- La création d'un nouveau Codespace chargera automatiquement les mêmes données
- Aucune adresse e-mail ni mot de passe n'est jamais saisi ni stocké (l'outil réutilise simplement l'authentification GitHub déjà présente dans votre Codespace)

---

## 🌍 Langues prises en charge

Utilisez le menu déroulant en haut à droite pour changer la langue d'affichage :

🇯🇵 日本語 / 🇺🇸 English / 🇨🇳 中文 / 🇰🇷 한국어 / 🇪🇸 Español / 🇫🇷 Français

Pour traduire un site externe que vous visitez, la fonction de traduction intégrée de Chromium fonctionne normalement (clic droit sur la page → « Traduire »).

### Saisir en japonais, chinois, coréen, etc.

Par défaut, seule la saisie alphanumérique est disponible. Si vous souhaitez taper dans une langue nécessitant une méthode de saisie (comme le japonais ou le chinois), exécutez **la commande correspondant à votre langue** une fois dans le terminal du Codespace. Le framework de saisie lui-même (fcitx5) est déjà installé ; vous n'ajoutez que le moteur spécifique à la langue.

| Langue | Commande à exécuter dans le terminal |
|---|---|
| 🇯🇵 Japonais | `sudo apt-get install -y fcitx5-mozc` |
| 🇨🇳 Chinois (simplifié) | `sudo apt-get install -y fcitx5-pinyin` |
| 🇹🇼 Chinois (traditionnel) | `sudo apt-get install -y fcitx5-chewing` |
| 🇰🇷 Coréen | `sudo apt-get install -y fcitx5-hangul` |
| 🇻🇳 Vietnamien | `sudo apt-get install -y fcitx5-unikey` |
| 🇹🇭 Thaï | `sudo apt-get install -y fcitx5-libthai` |

Après l'installation, relancez `npm run search` (ou `video`) pour commencer à l'utiliser.

**Utilisation (identique pour toutes les langues) :**
- Cliquez dans un champ de saisie et tapez ; des propositions de conversion apparaîtront automatiquement
- Activez/désactivez la méthode de saisie avec la touche demi-largeur/pleine largeur, ou `Ctrl + Space`

Pour les langues non listées ci-dessus, un paquet `fcitx5-` est souvent disponible aussi. Vous pouvez le rechercher dans le terminal :

```bash
apt-cache search fcitx5
```

---

## ✉️ Contact / Suggestions

Utilisez « Contact / Suggestions » dans le menu latéral pour envoyer un message via un formulaire simple. L'envoi ouvre un écran de création d'Issue GitHub (un compte GitHub est requis).

Pour publier directement, allez [ici](https://github.com/godrenkon/suiramu-search/issues/new/choose).

---

## 🔒 À propos de la confidentialité

- L'icône « Compte » n'est qu'un simple profil avec un nom d'affichage, stocké uniquement dans le navigateur de votre Codespace
- Les données des sites enregistrés sont stockées dans un dépôt privé sous votre propre compte GitHub, et ne sont jamais envoyées à un serveur géré par le projet Suiramu
- Aucune adresse e-mail ni mot de passe n'est jamais demandé

---

## 🛠️ Détails techniques (pour les curieux)

| Technologie | Rôle |
|---|---|
| GitHub Codespaces | L'environnement d'exécution (votre propre PC jetable) |
| Xvfb | Écran virtuel |
| Chromium | Le navigateur réel qui s'exécute |
| x11vnc + noVNC | Transmet l'écran à votre navigateur web |
| PulseAudio + ffmpeg | Diffusion audio en mode vidéo |
| GitHub CLI (`gh`) | Persiste les favoris (en utilisant votre propre dépôt privé) |

Le mode recherche et le mode vidéo utilisent des réglages de compression noVNC/x11vnc différents (équilibrant qualité d'image et fréquence d'images) pour optimiser chaque cas d'usage.

---

## ⚠️ Questions fréquentes

**Q. En ouvrant le port 6080, un bureau vide apparaît au lieu de Chromium**
R. Il y a deux causes courantes.

1. **Le port a été ouvert avant d'exécuter `npm run search` ou `npm run video`** — L'écran de Suiramu n'apparaît qu'après avoir exécuté la commande. Exécutez d'abord la commande dans le terminal, puis ouvrez l'onglet des ports.
2. **Le navigateur n'a pas réussi à démarrer** — exécutez ceci dans le terminal pour vérifier s'il y a des erreurs :
   ```bash
   cat /tmp/suiramu-chrome.log
   ```
   Si c'est vide ou affiche une erreur, essayez de relancer la configuration :
   ```bash
   npm run setup
   ```

**Q. Le message « Authentification GitHub introuvable » s'affiche**
R. Cela apparaît lorsque l'authentification nécessaire à la sauvegarde automatique des favoris (dans votre dépôt privé) est introuvable. Tout le reste continue de fonctionner normalement ; les favoris sont simplement sauvegardés temporairement dans le Codespace. Pour activer la persistance, essayez ceci dans le terminal :
   ```bash
   gh auth login
   ```
   Puis relancez `npm run search` (ou `video`).

**Q. Je veux utiliser le mode recherche et le mode vidéo en même temps**
R. Actuellement, chaque Codespace ne peut exécuter qu'un seul mode à la fois. Si vous voulez utiliser les deux, ouvrez un second Codespace dans votre navigateur et démarrez l'autre mode là-bas (attention aux limites du plan gratuit de GitHub).

**Q. Y a-t-il une limite de temps d'utilisation des Codespaces ?**
R. Cela dépend du type de compte GitHub que vous avez. Consultez la page des paramètres GitHub pour plus de détails.

**Q. Puis-je utiliser des sites nécessitant une connexion (comme le portail de mon école) ?**
R. Oui. Comme un vrai navigateur Chromium fonctionne, vous pouvez vous connecter et l'utiliser normalement.

---

## 📞 Support

- 🐛 Signaler un bug / suggérer une fonctionnalité : [Issues](https://github.com/godrenkon/suiramu-search/issues/new/choose)

---

*Fait pour les étudiants qui veulent simplement chercher et regarder, sans complications.*
