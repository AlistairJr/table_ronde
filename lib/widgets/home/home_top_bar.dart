import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class HomeTopBar extends StatefulWidget {
  final VoidCallback? onCreatePost;
  
  const HomeTopBar({
    super.key,
    this.onCreatePost,
  });

  @override
  State<HomeTopBar> createState() => _HomeTopBarState();
}

class _HomeTopBarState extends State<HomeTopBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showModuleSelector(BuildContext context) {
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
                'Navigation Rapide',
                style: AppTheme.headingMedium.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 24),
              _buildQuickNavItem(
                context,
                Icons.people_rounded,
                'Module Social',
                'Conversations et communauté',
                AppTheme.primaryBlue,
                '/social',
              ),
              _buildQuickNavItem(
                context,
                Icons.account_balance_wallet_rounded,
                'Module Finance',
                'Transactions et épargne',
                AppTheme.successColor,
                '/finance',
              ),
              _buildQuickNavItem(
                context,
                Icons.school_rounded,
                'Module Éducation',
                'Devoirs et documents',
                AppTheme.warningColor,
                '/education',
              ),
              _buildQuickNavItem(
                context,
                Icons.sports_esports_rounded,
                'Module Jeux',
                'Classements et défis',
                Colors.purple,
                '/games',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickNavItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
    String route,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Rechercher',
            style: AppTheme.headingMedium.copyWith(color: Colors.white),
          ),
          content: TextField(
            controller: _searchController,
            autofocus: true,
            style: AppTheme.bodyMedium.copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Rechercher des posts, membres...',
              hintStyle: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
              prefixIcon: const Icon(Icons.search, color: AppTheme.primaryBlue),
              filled: true,
              fillColor: AppTheme.cardDark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Annuler',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
              ),
              child: const Text('Rechercher'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            tooltip: 'Retour',
          ),
          IconButton(
            icon: const Icon(Icons.dashboard_outlined),
            color: AppTheme.textPrimary,
            onPressed: () => _showModuleSelector(context),
            tooltip: 'Modules',
          ),
          const SizedBox(width: 16),
          
          if (MediaQuery.of(context).size.width > 1200) ...[
            _buildModuleButton(
              context,
              Icons.people_rounded,
              'Social',
              AppTheme.primaryBlue,
              '/social',
            ),
            _buildModuleButton(
              context,
              Icons.account_balance_wallet_rounded,
              'Finance',
              AppTheme.successColor,
              '/finance',
            ),
            _buildModuleButton(
              context,
              Icons.school_rounded,
              'Éducation',
              AppTheme.warningColor,
              '/education',
            ),
            _buildModuleButton(
              context,
              Icons.sports_esports_rounded,
              'Jeux',
              Colors.purple,
              '/games',
            ),
          ],
          
          const Spacer(),
          
          IconButton(
            icon: const Icon(Icons.edit_note),
            color: AppTheme.textPrimary,
            onPressed: widget.onCreatePost,
            tooltip: 'Créer un post',
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            color: AppTheme.textPrimary,
            onPressed: () {},
            tooltip: 'Favoris',
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: AppTheme.textPrimary,
            onPressed: () {},
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 12),
          
          InkWell(
            onTap: () => _showSearchDialog(context),
            child: Container(
              width: 200,
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppTheme.backgroundDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.surfaceDark,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Rechercher...',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: AppTheme.textSecondary, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleButton(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    String route,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTheme.bodySmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
