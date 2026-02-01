# 🎨 TableRonde - Interface Style Feed Social

## 📱 Nouveau Design Inspiré de Discord/X

L'interface d'accueil de TableRonde a été redesignée pour offrir une expérience similaire aux applications sociales modernes comme Discord, X (Twitter), et les plateformes de feed.

## 🖼️ Structure de l'Interface

```
┌─────────────────────────────────────────────────────────┐
│  [Sidebar]    │    [Top Bar]        │    [Right Panel] │
│               ├─────────────────────┤                   │
│  - Logo       │                     │   - Modules      │
│  - Search     │   FEED PRINCIPAL   │   - Stats        │
│  - Nav        │                     │                   │
│  - Messages   │   [Posts...]        │                   │
│  - Profile    │                     │                   │
└─────────────────────────────────────────────────────────┘
```

## 🔲 Composants de l'Interface

### 1. **Sidebar Gauche** (280px)
```
┌──────────────────────┐
│ 🟦 TableRonde       │ ← Logo et nom
├──────────────────────┤
│ 🔍 Recherche Rapide │ ← Barre de recherche
├──────────────────────┤
│ 🏠 Fil d'actualités │ ← Navigation principale
│ 📢 Annonces         │   avec badges (+9 Posts)
│ 👥 Membres          │
│ 📊 Activités        │
├──────────────────────┤
│ Messages Privés   + │ ← Section messages
├──────────────────────┤
│ • TZ-Game      🟢   │ ← Liste de contacts
│ • Not A Loli   🟢   │   avec statut en ligne
│ • NYAJ<oo>          │
│ • T4zor             │
│ ...                 │
├──────────────────────┤
│ 👤 Vous        ⚙️  │ ← Profil utilisateur
└──────────────────────┘
```

**Fonctionnalités:**
- Navigation rapide entre sections
- Badge de notification sur le fil
- Liste de contacts avec statut en ligne (point vert)
- Clic sur contact → ouvre le chat
- Bouton paramètres en bas

### 2. **Top Bar** (Header)
```
┌────────────────────────────────────────────┐
│ ← → [espace] ✏️ ❤️  [Rechercher...] 🔍   │
└────────────────────────────────────────────┘
```

**Éléments:**
- Flèches navigation arrière/avant
- Bouton créer post (✏️)
- Bouton favoris (❤️)
- Barre de recherche de posts

### 3. **Feed Principal** (Centre)

Chaque post contient:

```
┌─────────────────────────────────────────────┐
│ 🔵 Jean Dupont ✓ @jeandupont      2h   ⋯  │ ← Header
├─────────────────────────────────────────────┤
│                                             │
│ Nouvelle formation Flutter disponible !    │ ← Contenu
│ Rejoignez-nous ce samedi pour apprendre... │
│                                             │
│ [Image optionnelle si présente]            │
│                                             │
├─────────────────────────────────────────────┤
│ ❤️ 24    💬 8    ↗️                        │ ← Actions
└─────────────────────────────────────────────┘
```

**Éléments du post:**
- Avatar circulaire avec initiale
- Nom de l'auteur
- Badge vérifié (✓)
- Username (@xxx)
- Temps relatif (2h)
- Menu options (⋯)
- Contenu texte
- Image (optionnel)
- Compteurs likes/commentaires
- Bouton partage

### 4. **Right Sidebar** (Panel de droite - 320px)

**Section Modules:**
```
┌────────────────────────┐
│ Modules                │
├────────────────────────┤
│ 🤝 Social          →  │
│ 💰 Finance         →  │
│ 📚 Éducation       →  │
│ 🎮 Jeux            →  │
└────────────────────────┘
```

**Section Statistiques:**
```
┌────────────────────────┐
│ Statistiques           │
├────────────────────────┤
│ 💬 Messages non lus   │
│    12                  │
│                        │
│ 📝 Devoirs en attente │
│    5                   │
│                        │
│ 💰 Solde disponible   │
│    150€                │
└────────────────────────┘
```

## 🎨 Style et Couleurs

### Couleurs principales
```dart
Sidebar:           #202225 (Card Dark)
Feed Background:   #36393F (Background Dark)
Post Cards:        #202225 (Card Dark)
Right Panel:       #202225 (Card Dark)
Borders:           #2F3136 (Surface Dark)
Primary Blue:      #5865F2 (Discord Blurple)
```

### Typographie
- **Noms d'auteurs:** Noto Sans, 600, 16px
- **Usernames:** Roboto, 400, 12px
- **Contenu:** Roboto, 400, 14px
- **Labels:** Roboto, 600, 12px

### Espacements
- Padding posts: 20px
- Margin entre posts: 1px (border)
- Sidebar padding: 20px
- Gap icône-texte: 12px

## 🔄 Flux de Navigation

### Depuis le Feed
```
Clic sur contact (sidebar) → Chat privé
Clic sur post → Détails du post
Clic sur module (droite) → Module spécifique
Clic sur avatar → Profil utilisateur
```

### Types de Posts
Les posts sont catégorisés par type:
- **education** → 📚 Éducation
- **finance** → 💰 Finance  
- **gaming** → 🎮 Jeux
- **social** → 🤝 Social

## 💡 Cas d'Usage

### Scénario 1: Consulter les actualités
```
1. Ouvrir l'app
2. Par défaut sur "Fil d'actualités"
3. Scroller pour voir les posts
4. Cliquer sur ❤️ pour liker
5. Cliquer sur 💬 pour commenter
```

### Scénario 2: Envoyer un message
```
1. Chercher contact dans sidebar
2. Cliquer sur le nom
3. Ouvre l'interface de chat
4. Envoyer message
```

### Scénario 3: Accéder à un module
```
1. Voir les modules dans le panel de droite
2. Cliquer sur "Finance" par exemple
3. Navigation vers le module Finance
```

### Scénario 4: Créer un post
```
1. Cliquer sur ✏️ dans la top bar
2. Modal de création de post
3. Écrire contenu
4. Publier
```

## 🔧 Personnalisation

### Modifier les posts du feed
**Fichier:** `lib/screens/home_screen.dart`

```dart
final List<Map<String, dynamic>> _feedPosts = [
  {
    'author': 'Votre Nom',
    'username': '@votreusername',
    'avatar': 'V',
    'time': '1h',
    'content': 'Votre contenu ici...',
    'imageUrl': null,
    'likes': 10,
    'comments': 5,
    'type': 'social',
  },
];
```

### Ajouter un contact
Dans la méthode `_buildSidebar()`:

```dart
_buildMessageItem('Nouveau Contact', 'N', true),
```

### Changer la largeur de la sidebar
```dart
Container(
  width: 280, // Modifier ici (280px par défaut)
  ...
)
```

### Changer la largeur du panel droit
```dart
Container(
  width: 320, // Modifier ici (320px par défaut)
  ...
)
```

## 📱 Responsive Design

L'interface est optimisée pour les grands écrans (desktop/tablet). Pour mobile:
- Sidebar en drawer (menu hamburger)
- Feed pleine largeur
- Panel droit caché ou en bas

## ⚡ Fonctionnalités Interactives

### Déjà implémenté
- ✅ Navigation sidebar
- ✅ Affichage des posts
- ✅ Statuts en ligne
- ✅ Compteurs likes/commentaires
- ✅ Navigation vers modules
- ✅ Navigation vers chats

### À implémenter (backend nécessaire)
- [ ] Création de posts en temps réel
- [ ] Like/Unlike fonctionnel
- [ ] Système de commentaires
- [ ] Notifications live
- [ ] Recherche de posts
- [ ] Filtres par type de post
- [ ] Upload d'images dans posts
- [ ] Mentions (@username)
- [ ] Hashtags (#tag)

## 🎯 Avantages du Design

1. **Familier** : Interface similaire à Discord/X
2. **Efficient** : Navigation rapide entre sections
3. **Social** : Feed engageant et interactif
4. **Organisé** : Sidebar claire et structurée
5. **Informatif** : Stats visibles en permanence

## 🔄 Comparaison avec l'ancien design

### Ancien Design (Hub)
```
- Grille 2x2 de modules
- Section bienvenue
- Stats horizontales
- Activité récente en liste
```

### Nouveau Design (Feed)
```
+ Sidebar de navigation complète
+ Feed social scrollable
+ Panel de modules toujours visible
+ Liste de contacts avec statut
+ Top bar avec actions rapides
```

## 📊 Métriques d'Interface

- **Sidebar:** 280px (fixe)
- **Feed:** Flexible (prend l'espace restant)
- **Right Panel:** 320px (fixe)
- **Top Bar:** 60px (hauteur)
- **Post:** Variable (min 150px)
- **Total Width:** Min 1280px recommandé

## 🚀 Prochaines Améliorations

### Court terme
1. Animation de scroll infini
2. Pull-to-refresh
3. Skeleton loaders
4. Transitions entre posts

### Moyen terme
1. Stories à la Instagram
2. Live streaming
3. Réactions emoji étendues
4. Système de récompenses

### Long terme
1. IA de recommandation de contenu
2. Modération automatique
3. Analytics avancés
4. Monétisation créateurs

---

**TableRonde Feed** - Une expérience sociale moderne ! 🎉

Version: 2.0.0  
Dernière mise à jour: Février 2026
