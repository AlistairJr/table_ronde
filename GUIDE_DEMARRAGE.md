# Guide de Démarrage Rapide - HiChat

## 🎯 Démarrer en 5 minutes

### 1. Installation de Flutter

Si vous n'avez pas encore Flutter :

**Windows** :
```bash
# Télécharger Flutter depuis flutter.dev
# Extraire dans C:\src\flutter
# Ajouter au PATH : C:\src\flutter\bin
flutter doctor
```

**macOS/Linux** :
```bash
# Télécharger et extraire Flutter
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
```

### 2. Configuration du projet

```bash
cd hichat_app
flutter pub get
```

### 3. Lancer l'application

**Sur émulateur Android** :
```bash
# Démarrer l'émulateur depuis Android Studio
# Ou via ligne de commande :
emulator -avd Pixel_4_API_30

# Lancer l'app
flutter run
```

**Sur émulateur iOS (macOS uniquement)** :
```bash
open -a Simulator
flutter run
```

**Sur appareil physique** :
```bash
# Activer le débogage USB sur Android
# Ou faire confiance au Mac sur iOS
flutter devices
flutter run -d <device_id>
```

## 🎨 Structure de l'application

### Flux de navigation

```
Splash Screen (3s)
    ↓
Welcome Screen
    ↓
├── Sign In → OTP → Home
└── Sign Up → OTP → Profile → PIN → Fingerprint → Home
```

### Écrans disponibles

1. **SplashScreen** - Animation de démarrage
2. **WelcomeScreen** - Page d'accueil avec animations
3. **LoginScreen** - Connexion avec téléphone
4. **SignupScreen** - Inscription
5. **OTPVerificationScreen** - Code de vérification
6. **ProfileSetupScreen** - Configuration du profil
7. **PinSetupScreen** - Création du code PIN
8. **FingerprintSetupScreen** - Empreinte digitale
9. **HomeScreen** - Liste des conversations
10. **ChatScreen** - Interface de chat

## 🔧 Personnalisation rapide

### Changer les couleurs

Éditez `/lib/utils/app_theme.dart` :

```dart
// Couleur principale
static const Color primaryBlue = Color(0xFF2B7FFF);

// Pour une couleur verte par exemple :
static const Color primaryBlue = Color(0xFF2DD36F);
```

### Ajouter votre logo

1. Créez un dossier `assets/images/` à la racine
2. Ajoutez votre logo (ex: `logo.png`)
3. Dans `pubspec.yaml`, décommentez :
```yaml
flutter:
  assets:
    - assets/images/
```
4. Utilisez-le dans le code :
```dart
Image.asset('assets/images/logo.png')
```

### Modifier le nom de l'application

**Android** : `android/app/src/main/AndroidManifest.xml`
```xml
<application android:label="Votre Nom App">
```

**iOS** : `ios/Runner/Info.plist`
```xml
<key>CFBundleName</key>
<string>Votre Nom App</string>
```

## 📱 Fonctionnalités actuelles

### ✅ Implémenté
- Interface utilisateur complète
- Navigation entre les écrans
- Animations et transitions
- Liste de conversations
- Interface de chat avec bulles
- Indicateurs de statut (en ligne/hors ligne)
- Compteur de messages non lus
- Saisie de messages
- Design responsive

### ❌ À implémenter
- Authentification réelle
- Base de données
- Envoi de messages réel
- Notifications push
- Appels audio/vidéo
- Partage de fichiers/images

## 🐛 Résolution de problèmes

### Erreur : "Package not found"
```bash
flutter pub get
flutter clean
flutter pub get
```

### Erreur : "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter run
```

### Erreur : "CocoaPods not installed" (iOS)
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
flutter run
```

### L'app ne s'affiche pas correctement
```bash
flutter clean
flutter pub get
flutter run
```

## 📚 Ressources utiles

### Documentation Flutter
- [flutter.dev](https://flutter.dev)
- [dart.dev](https://dart.dev)
- [pub.dev](https://pub.dev) - Packages Flutter

### Tutoriels recommandés
- Flutter Official Codelabs
- Flutter Widget of the Week (YouTube)
- Flutter Community (Medium)

### Packages utiles à ajouter

**Firebase (Backend complet)** :
```yaml
dependencies:
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  firebase_storage: ^latest
```

**Gestion d'état** :
```yaml
dependencies:
  provider: ^latest
  # ou
  riverpod: ^latest
  # ou
  bloc: ^latest
```

**HTTP/API** :
```yaml
dependencies:
  http: ^latest
  dio: ^latest
```

**Stockage local** :
```yaml
dependencies:
  shared_preferences: ^latest
  hive: ^latest
  sqflite: ^latest
```

## 🚀 Prochaines étapes

### Niveau débutant
1. Modifier les couleurs du thème
2. Ajouter de nouveaux utilisateurs dans la liste
3. Personnaliser les messages
4. Changer les textes

### Niveau intermédiaire
1. Ajouter SharedPreferences pour sauvegarder les données
2. Implémenter une vraie validation de formulaire
3. Créer un écran de paramètres
4. Ajouter un mode sombre

### Niveau avancé
1. Intégrer Firebase pour l'authentification
2. Utiliser Firestore pour stocker les messages
3. Implémenter la messagerie en temps réel
4. Ajouter les notifications push
5. Créer un système d'appels vidéo

## 💡 Conseils

1. **Utilisez Hot Reload** : Appuyez sur `r` dans le terminal pour recharger l'UI
2. **Utilisez Hot Restart** : Appuyez sur `R` pour redémarrer l'app
3. **DevTools** : `flutter pub global activate devtools` puis `flutter pub global run devtools`
4. **Debugging** : Utilisez VS Code ou Android Studio avec les extensions Flutter
5. **Format du code** : `flutter format lib/`

## 📞 Besoin d'aide ?

- Stack Overflow (tag : flutter)
- GitHub Issues
- Discord Flutter Community
- Reddit r/FlutterDev

---

Bon développement ! 🎉
