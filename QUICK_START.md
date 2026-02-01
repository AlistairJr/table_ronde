# 🚀 Guide de Démarrage Rapide - TableRonde

## ⚡ Installation en 3 minutes

### 1. Extraire le projet
```bash
tar -xzf tableronde_v1.0.tar.gz
cd tableronde_app
```

### 2. Installer les dépendances
```bash
flutter pub get
```

### 3. Lancer l'application
```bash
flutter run
```

## 📱 Première Utilisation

### Authentification
1. **Splash Screen** → Animation 3 secondes
2. **Bienvenue** → "Commencer"
3. **Inscription** → Numéro de téléphone (+237)
4. **Code OTP** → Entrer 4 chiffres (ex: 1234)
5. **Profil** → Nom, username, email
6. **Code PIN** → Choisir 4 chiffres
7. **Empreinte** → Skip ou Configurer
8. **Accueil** → Hub principal !

## 🎯 Navigation Rapide

### Depuis l'Accueil
```
┌─────────────────────────────┐
│  TableRonde                  │
├─────────────────────────────┤
│  👤 Bonjour !               │
│  Bienvenue sur TableRonde    │
├─────────────────────────────┤
│  📊 Stats: 12 💬 | 5 📝 | 150€│
├─────────────────────────────┤
│  ┌──────────┬──────────┐    │
│  │🤝 Social │💰 Finance│    │
│  ├──────────┼──────────┤    │
│  │📚 Éduc.  │🎮 Jeux   │    │
│  └──────────┴──────────┘    │
├─────────────────────────────┤
│  📋 Activité récente         │
└─────────────────────────────┘
```

### 4 Modules Principaux

#### 🤝 Module Social
```bash
Accueil → Social → [Chats | Annonces | Membres]
```
- Conversations privées et groupes
- Annonces communautaires
- Liste des membres avec statut

#### 💰 Module Finance
```bash
Accueil → Finance → [Solde | Transactions | Épargne]
```
- Solde total: 1 250€
- Historique des transactions
- Objectifs d'épargne

#### 📚 Module Éducation
```bash
Accueil → Éducation → [Devoirs | Documents | Notes]
```
- Devoirs avec dates limites
- Documents partagés (PDF, DOCX)
- Notes collaboratives

#### 🎮 Module Jeux
```bash
Accueil → Jeux → [Classements | Défis | Multijoueur]
```
- Podium top 3
- Challenges avec progression
- Jeux en ligne

## 🎨 Personnalisation Rapide

### Changer la couleur principale
**Fichier:** `lib/utils/app_theme.dart`
```dart
static const Color primaryBlue = Color(0xFF5865F2); // Discord Blurple
// Changer en rouge:
static const Color primaryBlue = Color(0xFFFF4757);
```

### Modifier le nom de l'app
**Fichier:** `lib/screens/splash_screen.dart`
```dart
Text('TableRonde', ...)
// Changer en:
Text('VotreNom', ...)
```

### Ajouter des données de test

**Module Social** (`lib/screens/social_screen.dart`):
```dart
final List<ChatModel> _chats = [
  ChatModel(
    name: 'Votre Ami',
    message: 'Message de test',
    time: '10:00',
    unreadCount: 1,
    isOnline: true,
  ),
];
```

**Module Finance** (`lib/screens/finance_screen.dart`):
```dart
// Modifier le solde dans _buildBalanceTab()
Text('2 500,00 €', ...) // Au lieu de 1 250€
```

## 🔧 Structure du Code

### Écrans (Screens)
```
lib/screens/
├── splash_screen.dart          → Logo animé
├── welcome_screen.dart         → Bienvenue
├── login/signup_screen.dart    → Auth
├── home_screen.dart            → ⭐ HUB PRINCIPAL
├── social_screen.dart          → 🤝 Module Social
├── finance_screen.dart         → 💰 Module Finance
├── education_screen.dart       → 📚 Module Éducation
├── games_screen.dart           → 🎮 Module Jeux
└── chat_screen.dart            → 💬 Interface de chat
```

### Thème (Theme)
```
lib/utils/
└── app_theme.dart              → Couleurs, styles, thèmes
```

### Modèles (Models)
```
lib/models/
└── chat_model.dart             → ChatModel, MessageModel
```

## 🎯 Exemples d'Utilisation

### Ajouter un nouveau chat
Dans `social_screen.dart`:
```dart
ChatModel(
  name: 'Pierre Durand',
  message: 'À bientôt !',
  time: '14:30',
  unreadCount: 0,
  isOnline: false,
),
```

### Ajouter une transaction
Dans `finance_screen.dart`:
```dart
{
  'type': 'received',
  'title': 'Don',
  'subtitle': 'De Sophie',
  'amount': '+100,00€',
  'time': 'Aujourd\'hui',
  'icon': Icons.card_giftcard,
}
```

### Ajouter un devoir
Dans `education_screen.dart`:
```dart
{
  'title': 'Physique',
  'subtitle': 'TP sur l\'électricité',
  'dueDate': 'Dans 2 jours',
  'status': 'pending',
  'icon': Icons.bolt,
  'color': Colors.yellow,
}
```

### Ajouter un jeu
Dans `games_screen.dart`:
```dart
{
  'name': 'Chess Master',
  'players': '2 joueurs',
  'status': 'En ligne',
  'online': 20,
  'icon': Icons.chess,
  'color': Colors.brown,
}
```

## 🚦 Commandes Utiles

### Développement
```bash
# Hot reload
flutter run
# Puis appuyer sur 'r'

# Hot restart
# Appuyer sur 'R'

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Analyser le code
flutter analyze

# Formater le code
flutter format lib/

# Tests
flutter test
```

### Debugging
```bash
# Voir les logs
flutter logs

# Voir les appareils
flutter devices

# Nettoyer le build
flutter clean
flutter pub get
```

## 📊 Progression Recommandée

### Semaine 1 : Familiarisation
- [ ] Explorer tous les modules
- [ ] Tester les 4 onglets de chaque module
- [ ] Comprendre la navigation
- [ ] Personnaliser les couleurs

### Semaine 2 : Personnalisation
- [ ] Ajouter vos propres données
- [ ] Modifier les textes
- [ ] Changer le logo
- [ ] Adapter les couleurs de modules

### Semaine 3 : Backend
- [ ] Installer Firebase
- [ ] Configurer Authentication
- [ ] Setup Firestore
- [ ] Implémenter Cloud Storage

### Semaine 4 : Fonctionnalités
- [ ] Messages en temps réel
- [ ] Notifications push
- [ ] Upload de fichiers réel
- [ ] Synchronisation

## 🆘 Résolution de Problèmes

### Erreur: "Package not found"
```bash
flutter pub get
flutter clean
flutter pub get
```

### Erreur: "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter run
```

### L'app ne démarre pas
```bash
flutter doctor
flutter clean
flutter pub get
flutter run -v  # Mode verbose pour voir l'erreur
```

### Erreur de thème
Vérifier que `AppTheme.darkTheme` est bien défini dans `app_theme.dart`

## 💡 Astuces Pro

1. **Hot Reload** : Appuyez sur `r` pour recharger l'UI sans redémarrer
2. **DevTools** : `flutter pub global activate devtools`
3. **VS Code** : Installer l'extension "Flutter"
4. **Snippets** : Utiliser "stless" pour StatelessWidget, "stful" pour StatefulWidget
5. **Format automatique** : Activer "Format on Save" dans VS Code

## 📚 Ressources

- [Documentation Flutter](https://flutter.dev/docs)
- [Dart Language](https://dart.dev)
- [Material Design 3](https://m3.material.io)
- [Firebase Flutter](https://firebase.flutter.dev)

## 🎉 Prochaines Étapes

1. **Implémenter Firebase** pour backend réel
2. **Ajouter des tests** unitaires et d'intégration
3. **Optimiser** les performances
4. **Publier** sur Play Store / App Store
5. **Étendre** avec de nouveaux modules

---

**Bon développement avec TableRonde !** 🚀

Questions ? Consultez `README_TABLERONDE.md` pour la documentation complète.
