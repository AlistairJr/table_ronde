# Exemples de Code - HiChat

## 📝 Ajouter de nouvelles fonctionnalités

### 1. Ajouter un nouveau chat dans la liste

Dans `home_screen.dart`, ajoutez un nouvel élément dans `_chats` :

```dart
ChatModel(
  name: 'Votre Nom',
  message: 'Dernier message',
  time: 'Il y a 5m',
  unreadCount: 1,
  isOnline: true,
),
```

### 2. Créer un widget personnalisé

Créez un nouveau fichier `lib/widgets/custom_button.dart` :

```dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppTheme.primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                text,
                style: AppTheme.buttonText.copyWith(
                  color: AppTheme.primaryBlue,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              child: Text(text, style: AppTheme.buttonText),
            ),
    );
  }
}
```

Utilisation :
```dart
CustomButton(
  text: 'Continuer',
  onPressed: () {
    // Votre action
  },
)
```

### 3. Ajouter un écran de paramètres

Créez `lib/screens/settings_screen.dart` :

```dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres', style: AppTheme.headingMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Notifications'),
          _buildSwitchTile(
            title: 'Activer les notifications',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          
          const SizedBox(height: 24),
          
          _buildSectionTitle('Apparence'),
          _buildSwitchTile(
            title: 'Mode sombre',
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
          
          const SizedBox(height: 24),
          
          _buildSectionTitle('Compte'),
          _buildOptionTile(
            title: 'Modifier le profil',
            icon: Icons.person,
            onTap: () {},
          ),
          _buildOptionTile(
            title: 'Confidentialité',
            icon: Icons.lock,
            onTap: () {},
          ),
          _buildOptionTile(
            title: 'Sécurité',
            icon: Icons.security,
            onTap: () {},
          ),
          
          const SizedBox(height: 24),
          
          _buildOptionTile(
            title: 'Déconnexion',
            icon: Icons.logout,
            color: AppTheme.errorColor,
            onTap: () {
              // Déconnexion
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: AppTheme.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTheme.bodyLarge),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppTheme.primaryBlue),
        title: Text(
          title,
          style: AppTheme.bodyLarge.copyWith(color: color),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppTheme.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}
```

Ajoutez la route dans `main.dart` :
```dart
'/settings': (context) => const SettingsScreen(),
```

### 4. Implémenter SharedPreferences pour sauvegarder des données

Ajoutez la dépendance dans `pubspec.yaml` :
```yaml
dependencies:
  shared_preferences: ^2.2.2
```

Créez `lib/services/storage_service.dart` :

```dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Sauvegarder le nom d'utilisateur
  static Future<void> saveUsername(String username) async {
    await _prefs.setString('username', username);
  }

  // Récupérer le nom d'utilisateur
  static String? getUsername() {
    return _prefs.getString('username');
  }

  // Sauvegarder l'état de connexion
  static Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool('isLoggedIn', value);
  }

  // Vérifier si l'utilisateur est connecté
  static bool isLoggedIn() {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  // Effacer toutes les données
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}
```

Initialisez dans `main.dart` :
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const HiChatApp());
}
```

Utilisation :
```dart
// Sauvegarder
await StorageService.saveUsername('John Doe');

// Récupérer
String? username = StorageService.getUsername();

// Vérifier connexion
if (StorageService.isLoggedIn()) {
  // Rediriger vers home
}
```

### 5. Ajouter une barre de recherche

Créez `lib/widgets/search_bar_widget.dart` :

```dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchBarWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Rechercher...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTheme.bodyMedium,
          border: InputBorder.none,
          icon: Icon(Icons.search, color: AppTheme.textSecondary),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: AppTheme.textSecondary),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
        ),
      ),
    );
  }
}
```

Utilisation dans HomeScreen :
```dart
final _searchController = TextEditingController();
List<ChatModel> _filteredChats = [];

@override
void initState() {
  super.initState();
  _filteredChats = _chats;
}

void _filterChats(String query) {
  setState(() {
    if (query.isEmpty) {
      _filteredChats = _chats;
    } else {
      _filteredChats = _chats
          .where((chat) =>
              chat.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  });
}

// Dans le build
Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBarWidget(
        controller: _searchController,
        onChanged: _filterChats,
      ),
    ),
    Expanded(
      child: ListView.builder(
        itemCount: _filteredChats.length,
        itemBuilder: (context, index) {
          return _buildChatItem(_filteredChats[index]);
        },
      ),
    ),
  ],
)
```

### 6. Ajouter un indicateur de frappe (typing indicator)

Dans `chat_screen.dart`, ajoutez :

```dart
bool _isTyping = false;

Widget _buildTypingIndicator() {
  return AnimatedOpacity(
    opacity: _isTyping ? 1.0 : 0.0,
    duration: const Duration(milliseconds: 200),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            '${_chat.name} est en train d\'écrire',
            style: AppTheme.bodySmall.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppTheme.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Dans le build, avant la liste de messages
Column(
  children: [
    _buildTypingIndicator(),
    Expanded(
      child: ListView.builder(...),
    ),
  ],
)
```

### 7. Ajouter un écran de chargement

Créez `lib/widgets/loading_overlay.dart` :

```dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class LoadingOverlay {
  static void show(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryBlue,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(message, style: AppTheme.bodyMedium),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
```

Utilisation :
```dart
// Afficher
LoadingOverlay.show(context, message: 'Chargement...');

// Cacher
LoadingOverlay.hide(context);

// Exemple complet
void _login() async {
  LoadingOverlay.show(context, message: 'Connexion...');
  
  await Future.delayed(Duration(seconds: 2)); // Simulation
  
  LoadingOverlay.hide(context);
  Navigator.pushNamed(context, '/home');
}
```

### 8. Validation de formulaire avancée

Créez `lib/utils/validators.dart` :

```dart
class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Numéro de téléphone requis';
    }
    if (value.length < 9) {
      return 'Numéro invalide (minimum 9 chiffres)';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Seuls les chiffres sont autorisés';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email requis';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nom requis';
    }
    if (value.length < 2) {
      return 'Nom trop court';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mot de passe requis';
    }
    if (value.length < 6) {
      return 'Minimum 6 caractères';
    }
    return null;
  }
}
```

Utilisation :
```dart
TextFormField(
  controller: _emailController,
  validator: Validators.validateEmail,
  decoration: InputDecoration(
    hintText: 'Email',
  ),
)
```

---

## 🔧 Tips supplémentaires

### Déboguer facilement
```dart
print('Debug: $_variable');
debugPrint('Info importante');
```

### Formater le code automatiquement
```bash
flutter format lib/
```

### Analyser le code
```bash
flutter analyze
```

### Voir les performances
```dart
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true; // Montre les bordures
  runApp(MyApp());
}
```

### Navigation avec arguments
```dart
// Envoyer
Navigator.pushNamed(
  context,
  '/chat',
  arguments: {'userId': '123', 'name': 'John'},
);

// Recevoir
final args = ModalRoute.of(context)!.settings.arguments as Map;
String userId = args['userId'];
```

---

Ces exemples vous aideront à étendre rapidement votre application ! 🚀
