import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  final List<Map<String, dynamic>> _feedPosts = [
    {
      'author': 'Jean Dupont',
      'username': '@jeandupont',
      'avatar': 'J',
      'time': '2h',
      'content': 'Nouvelle formation Flutter disponible ! Rejoignez-nous ce samedi pour apprendre les bases du développement mobile.',
      'imageUrl': null,
      'likes': 24,
      'comments': 8,
      'type': 'education',
    },
    {
      'author': 'Marie Martin',
      'username': '@mariemartin',
      'avatar': 'M',
      'time': '4h',
      'content': 'La cotisation du mois est disponible. N\'oubliez pas de faire votre contribution avant le 5 du mois !',
      'imageUrl': null,
      'likes': 45,
      'comments': 12,
      'type': 'finance',
    },
    {
      'author': 'Paul Dubois',
      'username': '@pauldubois',
      'avatar': 'P',
      'time': '6h',
      'content': 'Nouveau record ! Je suis maintenant #1 du classement Quiz Battle 🎮🏆',
      'imageUrl': null,
      'likes': 67,
      'comments': 23,
      'type': 'gaming',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 900;

    if (isSmallScreen) {
      return Scaffold(
        backgroundColor: AppTheme.backgroundDark,
        appBar: AppBar(
          backgroundColor: AppTheme.cardDark,
          title: Text('TableRonde', style: AppTheme.headingMedium.copyWith(fontSize: 18)),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.dashboard),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: AppTheme.cardDark,
          child: _buildSidebar(isMobile: true),
        ),
        endDrawer: Drawer(
          backgroundColor: AppTheme.cardDark,
          child: _buildRightSidebar(isMobile: true),
        ),
        body: _buildFeed(),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildSidebar({bool isMobile = false}) {
    return Container(
      width: isMobile ? null : 280,
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        border: isMobile ? null : Border(
          right: BorderSide(
            color: AppTheme.surfaceDark,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header with logo
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.group_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'TableRonde',
                  style: AppTheme.headingMedium.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.backgroundDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AppTheme.textSecondary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Recherche Rapide',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Navigation items
          _buildNavItem(
            0,
            Icons.home_rounded,
            'Fil d\'actualités',
            badge: '+9 Posts',
          ),
          _buildNavItem(1, Icons.campaign_rounded, 'Annonces'),
          _buildNavItem(2, Icons.people_rounded, 'Membres'),
          _buildNavItem(3, Icons.timeline_rounded, 'Activités'),
          
          const SizedBox(height: 24),
          
          // Messages section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Messages Privés',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: AppTheme.textSecondary,
                    size: 18,
                  ),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Message list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildMessageItem('TZ-Game', 'T', true),
                _buildMessageItem('Not A Loli Zone', 'N', true),
                _buildMessageItem('NYAJ<oo>', 'N', false),
                _buildMessageItem('T4zor', 'T', false),
                _buildMessageItem('Ralphon', 'R', true),
                _buildMessageItem('Fadil', 'F', true),
                _buildMessageItem('Tedy', 'T', false),
                _buildMessageItem('Ryan', 'R', false),
              ],
            ),
          ),
          
          // Bottom user profile
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark.withOpacity(0.5),
              border: Border(
                top: BorderSide(color: AppTheme.surfaceDark, width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.person, color: Colors.pink, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Vous',
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, size: 18),
                  color: AppTheme.textSecondary,
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, {String? badge}) {
    final isSelected = _selectedIndex == index;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.surfaceDark : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppTheme.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTheme.bodyMedium.copyWith(
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(String name, String initial, bool online) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/social');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        margin: const EdgeInsets.only(bottom: 2),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (online)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppTheme.onlineGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.cardDark, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _buildFeed()),
              _buildRightSidebar(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        border: Border(
          bottom: BorderSide(color: AppTheme.surfaceDark, width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.textPrimary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            color: AppTheme.textPrimary,
            onPressed: () {},
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit_note),
            color: AppTheme.textPrimary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            color: AppTheme.textPrimary,
            onPressed: () {},
          ),
          Container(
            width: 200,
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Rechercher un post...',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                Icon(Icons.search, color: AppTheme.textSecondary, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeed() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _feedPosts.length,
      itemBuilder: (context, index) {
        return _buildPost(_feedPosts[index]);
      },
    );
  }

  Widget _buildPost(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        border: Border(
          bottom: BorderSide(color: AppTheme.surfaceDark, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    post['avatar'],
                    style: AppTheme.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post['author'],
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: AppTheme.primaryBlue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          post['username'],
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                post['time'],
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                color: AppTheme.textSecondary,
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Post content
          Text(
            post['content'],
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textPrimary,
              height: 1.5,
            ),
          ),
          
          if (post['imageUrl'] != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 300,
                color: AppTheme.surfaceDark,
                child: const Center(
                  child: Icon(Icons.image, size: 48, color: Colors.white24),
                ),
              ),
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Post actions
          Row(
            children: [
              _buildPostAction(Icons.favorite_border, post['likes'].toString()),
              const SizedBox(width: 24),
              _buildPostAction(Icons.chat_bubble_outline, post['comments'].toString()),
              const SizedBox(width: 24),
              _buildPostAction(Icons.share_outlined, ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostAction(IconData icon, String count) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.textSecondary),
          if (count.isNotEmpty) ...[
            const SizedBox(width: 6),
            Text(
              count,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRightSidebar({bool isMobile = false}) {
    return Container(
      width: isMobile ? null : 320,
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        border: isMobile ? null : Border(
          left: BorderSide(color: AppTheme.surfaceDark, width: 1),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Modules section
          Text(
            'Modules',
            style: AppTheme.headingSmall.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          _buildModuleCard('Social', Icons.people_rounded, AppTheme.primaryBlue, '/social'),
          _buildModuleCard('Finance', Icons.account_balance_wallet_rounded, AppTheme.successColor, '/finance'),
          _buildModuleCard('Éducation', Icons.school_rounded, AppTheme.warningColor, '/education'),
          _buildModuleCard('Jeux', Icons.sports_esports_rounded, Colors.purple, '/games'),
          
          const SizedBox(height: 24),
          
          // Quick stats
          Text(
            'Statistiques',
            style: AppTheme.headingSmall.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatItem('Messages non lus', '12', Icons.chat_bubble),
          _buildStatItem('Devoirs en attente', '5', Icons.assignment),
          _buildStatItem('Solde disponible', '150€', Icons.account_balance_wallet),
        ],
      ),
    );
  }

  Widget _buildModuleCard(String title, IconData icon, Color color, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
                Text(
                  value,
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
