import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

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
}