# HiChat - Application de Messagerie Flutter

Une application de chat moderne et élégante construite avec Flutter, inspirée de la maquette HiChat UI Kit.

## ✨ Fonctionnalités

### Authentification
- 🚀 Écran de démarrage animé
- 👋 Écran d'accueil avec animations
- 📱 Connexion avec numéro de téléphone
- 📝 Inscription utilisateur
- 🔐 Vérification OTP (One-Time Password)
- 👤 Configuration du profil utilisateur
- 🔢 Configuration du code PIN
- 👆 Configuration de l'empreinte digitale

### Messagerie
- 💬 Liste des conversations
- 👥 Onglets (Chats, Groupes, Appels)
- 💭 Interface de chat en temps réel
- 📸 Support pour les images (à implémenter)
- ✅ Indicateurs de lecture des messages
- 🟢 Statut en ligne/hors ligne
- 🔔 Compteur de messages non lus

## 🎨 Design

L'application utilise un design moderne avec :
- **Couleur primaire** : Bleu (#2B7FFF)
- **Typographie** : Plus Jakarta Sans pour les titres, Inter pour le corps
- **Animations** : Transitions fluides et micro-interactions
- **Material Design 3** : Composants modernes de Flutter

## 📁 Structure du Projet

```
hichat_app/
├── lib/
│   ├── main.dart                          # Point d'entrée de l'application
│   ├── models/
│   │   └── chat_model.dart               # Modèles de données
│   ├── screens/
│   │   ├── splash_screen.dart            # Écran de démarrage
│   │   ├── welcome_screen.dart           # Écran d'accueil
│   │   ├── login_screen.dart             # Écran de connexion
│   │   ├── signup_screen.dart            # Écran d'inscription
│   │   ├── otp_verification_screen.dart  # Vérification OTP
│   │   ├── profile_setup_screen.dart     # Configuration du profil
│   │   ├── pin_setup_screen.dart         # Configuration du PIN
│   │   ├── fingerprint_setup_screen.dart # Configuration empreinte
│   │   ├── home_screen.dart              # Écran principal
│   │   └── chat_screen.dart              # Interface de chat
│   └── utils/
│       └── app_theme.dart                # Thème et styles
└── pubspec.yaml                          # Dépendances
```

## 🚀 Installation

### Prérequis
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / Xcode (pour les émulateurs)
- VS Code ou Android Studio (IDE)

### Étapes d'installation

1. **Cloner le projet** (ou créer les fichiers)
```bash
cd hichat_app
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Vérifier l'installation Flutter**
```bash
flutter doctor
```

4. **Lancer l'application**
```bash
# Sur émulateur Android/iOS
flutter run

# Sur appareil spécifique
flutter run -d <device_id>

# Liste des appareils disponibles
flutter devices
```

## 📦 Dépendances

- **google_fonts** (^6.1.0) : Pour les polices personnalisées
- **cupertino_icons** (^1.0.2) : Pour les icônes iOS

## 🎯 Utilisation

### Navigation dans l'application

1. **Démarrage** : L'écran splash s'affiche pendant 3 secondes
2. **Bienvenue** : Choisissez "Get Started" ou "Sign In"
3. **Connexion/Inscription** : Entrez votre numéro de téléphone
4. **Vérification OTP** : Saisissez le code à 4 chiffres
5. **Configuration du profil** : Ajoutez vos informations
6. **Sécurité** : Configurez votre PIN et empreinte digitale
7. **Chat** : Commencez à discuter !

### Fonctionnalités principales

#### Écran d'accueil
- Onglet "Chats" : Liste des conversations
- Onglet "Groups" : Groupes de discussion
- Onglet "Calls" : Historique des appels
- Bouton flottant (+) : Nouvelle conversation

#### Interface de chat
- Messages avec bulles colorées
- Horodatage des messages
- Indicateurs de lecture (✓✓)
- Statut en ligne
- Boutons d'actions (appel vidéo, appel vocal)
- Zone de saisie avec options (pièces jointes, caméra)

## 🔧 Personnalisation

### Modifier les couleurs

Éditez `lib/utils/app_theme.dart` :

```dart
static const Color primaryBlue = Color(0xFF2B7FFF);
static const Color lightBlue = Color(0xFF5B9FFF);
// ... autres couleurs
```

### Ajouter des fonctionnalités

1. **Backend** : Intégrer Firebase ou une API REST
2. **Messagerie en temps réel** : Utiliser WebSocket ou Firebase Realtime Database
3. **Notifications push** : Firebase Cloud Messaging
4. **Stockage local** : SQLite ou Hive
5. **Authentification** : Firebase Auth ou JWT

## 🛠️ Prochaines étapes

### Fonctionnalités à implémenter

- [ ] Authentification réelle (Firebase Auth)
- [ ] Base de données (Firestore/SQLite)
- [ ] Envoi de messages en temps réel
- [ ] Envoi d'images et de fichiers
- [ ] Appels audio/vidéo (WebRTC)
- [ ] Notifications push
- [ ] Groupes de discussion
- [ ] Profils utilisateur complets
- [ ] Paramètres de l'application
- [ ] Mode sombre
- [ ] Traductions (i18n)
- [ ] Recherche de messages
- [ ] Émojis et stickers

### Améliorations techniques

- [ ] Gestion d'état (Provider/Riverpod/Bloc)
- [ ] Tests unitaires et d'intégration
- [ ] Architecture MVVM ou Clean Architecture
- [ ] Optimisation des performances
- [ ] Gestion des erreurs améliorée
- [ ] Accessibilité (a11y)

## 📝 Notes de développement

### Points clés

1. **Animations** : Utilisent `AnimationController` et `Tween`
2. **Navigation** : Routes nommées dans `main.dart`
3. **Thème** : Centralisé dans `app_theme.dart`
4. **Responsive** : Utilise `MediaQuery` pour l'adaptation

### Bonnes pratiques

- Code modulaire et réutilisable
- Widgets séparés par fonctionnalité
- Constantes pour les valeurs répétitives
- Documentation des fonctions importantes

## 🐛 Problèmes connus

- Les avatars utilisent des icônes par défaut (à remplacer par de vraies images)
- Les messages sont en local (pas de synchronisation)
- L'authentification est simulée
- Les appels audio/vidéo ne sont pas implémentés

## 📄 License

Ce projet est un exemple éducatif basé sur la maquette HiChat UI Kit.

## 👨‍💻 Auteur

Créé comme démonstration d'une application de chat Flutter moderne.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📞 Support

Pour toute question ou problème, ouvrez une issue sur GitHub.

---

**Note** : Cette application est un projet de démonstration. Pour une utilisation en production, des fonctionnalités supplémentaires de sécurité et de performance doivent être implémentées.
