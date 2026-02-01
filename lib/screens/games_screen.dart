import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppTheme.cardDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Espace Divertissement',
          style: AppTheme.headingMedium.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppTheme.cardDark,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.purple,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: AppTheme.textSecondary,
              labelStyle: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              tabs: const [
                Tab(text: 'CLASSEMENTS'),
                Tab(text: 'DÉFIS'),
                Tab(text: 'MULTIJOUEUR'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLeaderboardTab(),
          _buildChallengesTab(),
          _buildMultiplayerTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showNewGameDialog();
        },
        backgroundColor: Colors.purple,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Nouveau jeu', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildLeaderboardTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Top 3 Podium
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.withOpacity(0.3), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Top Joueurs',
                  style: AppTheme.headingMedium.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildPodiumPlace(2, 'Marie', '2850', Colors.grey),
                    const SizedBox(width: 8),
                    _buildPodiumPlace(1, 'Jean', '3420', Colors.amber),
                    const SizedBox(width: 8),
                    _buildPodiumPlace(3, 'Paul', '2150', Colors.brown),
                  ],
                ),
              ],
            ),
          ),
          // Rest of leaderboard
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: 7,
            itemBuilder: (context, index) {
              return _buildLeaderboardItem(
                index + 4,
                'Joueur ${index + 4}',
                '${2000 - (index * 150)}',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChallengesTab() {
    final challenges = [
      {
        'title': 'Champion du Quiz',
        'description': 'Répondre correctement à 50 questions',
        'progress': 0.75,
        'current': 38,
        'total': 50,
        'reward': '500 pts',
        'icon': Icons.quiz,
        'color': Colors.blue,
      },
      {
        'title': 'Marathonien',
        'description': 'Jouer 10 parties consécutives',
        'progress': 0.4,
        'current': 4,
        'total': 10,
        'reward': '300 pts',
        'icon': Icons.sports_score,
        'color': Colors.orange,
      },
      {
        'title': 'Social Butterfly',
        'description': 'Inviter 5 amis à rejoindre',
        'progress': 0.6,
        'current': 3,
        'total': 5,
        'reward': '1000 pts',
        'icon': Icons.people,
        'color': Colors.green,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return _buildChallengeCard(challenge);
      },
    );
  }

  Widget _buildMultiplayerTab() {
    final games = [
      {
        'name': 'Quiz Battle',
        'players': '2-4 joueurs',
        'status': 'En ligne',
        'online': 12,
        'icon': Icons.psychology,
        'color': Colors.blue,
      },
      {
        'name': 'Word Master',
        'players': '2-6 joueurs',
        'status': 'En ligne',
        'online': 8,
        'icon': Icons.text_fields,
        'color': Colors.green,
      },
      {
        'name': 'Math Challenge',
        'players': '2 joueurs',
        'status': 'En ligne',
        'online': 5,
        'icon': Icons.calculate,
        'color': Colors.orange,
      },
      {
        'name': 'Memory Game',
        'players': '2-4 joueurs',
        'status': 'En ligne',
        'online': 15,
        'icon': Icons.casino,
        'color': Colors.purple,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return _buildGameCard(game);
      },
    );
  }

  Widget _buildPodiumPlace(int rank, String name, String points, Color color) {
    final height = rank == 1 ? 120.0 : rank == 2 ? 100.0 : 80.0;
    
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Icon(
              rank == 1 ? Icons.emoji_events : Icons.person,
              color: color,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: AppTheme.bodyMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '$points pts',
          style: AppTheme.bodySmall.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              '#$rank',
              style: AppTheme.headingLarge.copyWith(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, String points) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.person, color: Colors.purple, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: AppTheme.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$points pts',
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.purple,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (challenge['color'] as Color).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (challenge['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  challenge['icon'] as IconData,
                  color: challenge['color'] as Color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge['title'] as String,
                      style: AppTheme.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      challenge['description'] as String,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (challenge['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  challenge['reward'] as String,
                  style: AppTheme.bodySmall.copyWith(
                    color: challenge['color'] as Color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: challenge['progress'] as double,
                    minHeight: 8,
                    backgroundColor: AppTheme.cardDark,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      challenge['color'] as Color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${challenge['current']}/${challenge['total']}',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: (game['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              game['icon'] as IconData,
              color: game['color'] as Color,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game['name'] as String,
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  game['players'] as String,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.onlineGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${game['online']} en ligne',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.onlineGreen,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: game['color'] as Color,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Jouer', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showNewGameDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nouveau jeu',
                style: AppTheme.headingMedium.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 24),
              _buildGameOption(Icons.psychology, 'Quiz rapide', Colors.blue),
              _buildGameOption(Icons.people, 'Partie privée', Colors.purple),
              _buildGameOption(Icons.emoji_events, 'Tournoi', Colors.orange),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGameOption(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppTheme.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
