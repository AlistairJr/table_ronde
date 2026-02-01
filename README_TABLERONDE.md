# 🎯 TableRonde - Écosystème Communautaire Complet

## 📱 Vue d'ensemble

**TableRonde** est une application Flutter complète qui combine 4 modules essentiels pour créer un écosystème communautaire intégré. L'application utilise un design moderne inspiré de Discord (interface) et Telegram (chat).

## 🌟 Les 4 Modules Principaux

### 1. 🤝 Social et Communication
**Fonctionnalités:**
- ✅ Messagerie instantanée (individuelle et groupes)
- ✅ Profils utilisateurs avec statut en ligne
- ✅ Système d'annonces communautaires
- ✅ Liste des membres
- ✅ Partage de médias
- ✅ Bulles de chat style Telegram

**Navigation:** Accueil → Module "Social" → 3 onglets (Chats, Annonces, Membres)

### 2. 💰 Système Financier
**Fonctionnalités:**
- ✅ Visualisation du solde total
- ✅ Historique des transactions
- ✅ Système d'épargne collective
- ✅ Statistiques (reçu/dépensé)
- ✅ Actions rapides (Envoyer, Recevoir, Épargner)
- ✅ Objectifs d'épargne avec progression

**Navigation:** Accueil → Module "Finance" → 3 onglets (Solde, Transactions, Épargne)

### 3. 📚 Espace Pédagogique
**Fonctionnalités:**
- ✅ Gestion des devoirs avec dates limites
- ✅ Partage et téléchargement de documents
- ✅ Prise de notes collaborative
- ✅ Indicateurs de statut (urgent, en cours, terminé)
- ✅ Support multi-formats (PDF, DOCX, PPTX)

**Navigation:** Accueil → Module "Éducation" → 3 onglets (Devoirs, Documents, Notes)

### 4. 🎮 Espace Divertissement
**Fonctionnalités:**
- ✅ Classements avec podium top 3
- ✅ Système de défis et progression
- ✅ Jeux multijoueurs en ligne
- ✅ Indicateurs de joueurs en ligne
- ✅ Récompenses en points

**Navigation:** Accueil → Module "Jeux" → 3 onglets (Classements, Défis, Multijoueur)

## 🎨 Design

### Palette de couleurs
```dart
// Discord-inspired
Background Dark:    #36393F
Surface Dark:       #2F3136
Card Dark:          #202225
Primary Blue:       #5865F2 (Discord Blurple)

// Module colors
Social:             #5865F2 (Bleu)
Finance:            #3BA55D (Vert)
Éducation:          #FAA81A (Jaune)
Jeux:               #A855F7 (Violet)

// Telegram-style chat
Outgoing Bubble:    #0088CC
Incoming Bubble:    #40444B
```

### Typographie
- **Titres:** Noto Sans (600-700)
- **Corps:** Roboto (400-600)

## 📁 Structure du Projet

```
tableronde_app/
├── lib/
│   ├── main.dart                          # Point d'entrée
│   ├── models/
│   │   └── chat_model.dart               # Modèles de données
│   ├── screens/
│   │   ├── splash_screen.dart            # Écran de démarrage
│   │   ├── welcome_screen.dart           # Bienvenue
│   │   ├── login_screen.dart             # Connexion
│   │   ├── signup_screen.dart            # Inscription
│   │   ├── otp_verification_screen.dart  # Vérification OTP
│   │   ├── profile_setup_screen.dart     # Configuration profil
│   │   ├── pin_setup_screen.dart         # Code PIN
│   │   ├── fingerprint_setup_screen.dart # Empreinte
│   │   ├── home_screen.dart              # ⭐ Hub principal
│   │   ├── social_screen.dart            # 🤝 Module Social
│   │   ├── finance_screen.dart           # 💰 Module Finance
│   │   ├── education_screen.dart         # 📚 Module Éducation
│   │   ├── games_screen.dart             # 🎮 Module Jeux
│   │   └── chat_screen.dart              # Interface de chat
│   └── utils/
│       └── app_theme.dart                # Thème global
└── pubspec.yaml
```

## 🚀 Installation

### Prérequis
```bash
Flutter SDK >=3.0.0
Dart SDK
Android Studio / Xcode
```

### Étapes
```bash
cd hichat_app  # (sera renommé tableronde_app)
flutter pub get
flutter run
```

## 📊 Écran d'accueil (Hub)

L'écran d'accueil est le centre névralgique de TableRonde avec :

### 1. Section Bienvenue
- Avatar utilisateur
- Message de bienvenue personnalisé
- Gradient bleu Discord

### 2. Statistiques Rapides
```
┌─────────────┬─────────────┬─────────────┐
│   💬 12     │   📝 5      │   💰 150€   │
│  Messages   │   Devoirs   │   Épargne   │
└─────────────┴─────────────┴─────────────┘
```

### 3. Grille de Modules (2x2)
```
┌──────────────┬──────────────┐
│   🤝 Social  │  💰 Finance  │
│   Messagerie │  Transactions│
└──────────────┴──────────────┘
┌──────────────┬──────────────┐
│ 📚 Éducation │   🎮 Jeux    │
│   Devoirs    │  Classements │
└──────────────┴──────────────┘
```

### 4. Activité Récente
- Feed des dernières actions
- 3 types: Messages, Devoirs, Transactions
- Horodatage relatif

### 5. Navigation Inférieure
```
[🏠 Accueil] [💬 Messages] [🔍 Explorer] [👤 Profil]
```

## 🔑 Fonctionnalités Clés

### Authentification
1. Splash screen animé (3s)
2. Écran de bienvenue
3. Connexion/Inscription par téléphone
4. Vérification OTP (4 chiffres)
5. Configuration profil
6. Code PIN (pavé numérique)
7. Empreinte digitale (optionnel)

### Module Social
**Onglet Chats:**
- Liste des conversations
- Badges de messages non lus
- Statut en ligne
- Navigation vers chat individuel

**Onglet Annonces:**
- Publications importantes
- Icônes par type
- Auteur et date

**Onglet Membres:**
- Liste de tous les membres
- Rôles et statuts
- Bouton message direct

### Module Finance
**Onglet Solde:**
- Carte de solde principal
- Stats reçu/dépensé
- Actions rapides

**Onglet Transactions:**
- Historique complet
- Filtrage par type
- Détails des transactions

**Onglet Épargne:**
- Objectifs d'épargne
- Barres de progression
- Épargne collective

### Module Éducation
**Onglet Devoirs:**
- Liste avec statut (urgent, en cours, terminé)
- Dates limites
- Indicateurs visuels

**Onglet Documents:**
- Fichiers partagés
- Icônes par type
- Bouton téléchargement

**Onglet Notes:**
- Notes collaboratives
- Codes couleur
- Édition rapide

### Module Jeux
**Onglet Classements:**
- Podium top 3 visuel
- Liste classement complet
- Points et rangs

**Onglet Défis:**
- Challenges actifs
- Barres de progression
- Récompenses

**Onglet Multijoueur:**
- Jeux disponibles
- Joueurs en ligne
- Bouton "Jouer"

## 🎯 Cas d'Usage

### Scénario 1: Communication
```
1. Utilisateur ouvre l'app
2. Voit 3 nouveaux messages sur l'accueil
3. Clique sur module "Social"
4. Ouvre la conversation
5. Envoie un message avec bulles Telegram
```

### Scénario 2: Gestion Finances
```
1. Membre reçoit cotisation
2. Notification apparaît
3. Ouvre module "Finance"
4. Voit transaction dans l'historique
5. Ajoute à l'épargne collective
```

### Scénario 3: Devoirs
```
1. Professeur ajoute devoir
2. Apparaît dans "Éducation"
3. Élève voit statut "urgent"
4. Télécharge documents associés
5. Marque comme terminé
```

### Scénario 4: Compétition
```
1. Joueur lance un défi
2. Autres membres rejoignent
3. Points ajoutés au classement
4. Progression du défi mise à jour
5. Récompense débloquée
```

## 🔧 Personnalisation

### Changer les couleurs de modules
Dans `home_screen.dart`:
```dart
final List<Map<String, dynamic>> _modules = [
  {
    'color': AppTheme.primaryBlue,  // Changer ici
    // ...
  },
];
```

### Ajouter un nouveau module
1. Créer `new_module_screen.dart`
2. Ajouter dans `main.dart` routes
3. Ajouter dans `_modules` de `home_screen.dart`
4. Créer l'icône et la couleur

### Modifier le thème
Dans `app_theme.dart`:
```dart
static const Color primaryBlue = Color(0xFF5865F2);
// Changer selon vos préférences
```

## 📈 Prochaines Étapes

### Phase 1: Backend (Recommandé)
- [ ] Intégration Firebase
  - Authentication
  - Firestore Database
  - Cloud Storage
  - Cloud Messaging
- [ ] API REST personnalisée
- [ ] WebSocket pour temps réel

### Phase 2: Fonctionnalités Avancées
- [ ] Notifications push
- [ ] Appels audio/vidéo
- [ ] Partage de fichiers réel
- [ ] Synchronisation multi-appareils
- [ ] Mode hors ligne

### Phase 3: Modules Supplémentaires
- [ ] Calendrier événements
- [ ] Système de votes
- [ ] Marketplace interne
- [ ] Analytics et rapports

### Phase 4: Optimisation
- [ ] Tests unitaires
- [ ] Tests d'intégration
- [ ] Performance monitoring
- [ ] Accessibilité (a11y)

## 🛠️ Technologies Utilisées

- **Framework:** Flutter 3.x
- **Langage:** Dart
- **UI:** Material Design 3
- **Fonts:** Noto Sans, Roboto (via Google Fonts)
- **Architecture:** MVC modulaire
- **État:** setState (peut migrer vers Provider/Riverpod)

## 📱 Plateformes Supportées

- ✅ Android
- ✅ iOS
- 🔄 Web (avec ajustements)
- 🔄 Desktop (Windows, macOS, Linux)

## 🤝 Contribution

Pour contribuer au projet:
1. Fork le repository
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit (`git commit -m 'Add AmazingFeature'`)
4. Push (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📄 License

Projet éducatif et communautaire.

## 📞 Support

Pour questions ou problèmes:
- Ouvrir une issue sur GitHub
- Contacter l'équipe de développement

---

**TableRonde** - L'écosystème complet pour votre communauté ! 🚀

Version: 1.0.0
Dernière mise à jour: Février 2026
