import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class ActivitiesFeed extends StatelessWidget {
  const ActivitiesFeed({super.key});

  final List<Map<String, dynamic>> _activities = const [
    {
      'title': 'Session Among Us',
      'type': 'JEUX',
      'date': 'Ce soir, 21h00',
      'participants': 8,
      'maxParticipants': 10,
      'host': 'T4zor',
      'color': Color(0xFFAB47BC), // Purple
      'icon': Icons.sports_esports,
      'description': 'Petite session détente sur Among Us. Venez nombreux pour démasquer les imposteurs !',
    },
    {
      'title': 'Révision Flutter',
      'type': 'ÉTUDE',
      'date': 'Demain, 14h00',
      'participants': 3,
      'maxParticipants': 5,
      'host': 'AlistairJr',
      'color': Color(0xFF42A5F5), // Blue
      'icon': Icons.code,
      'description': 'On revoit les bases de la gestion d\'état avec Riverpod. Débutants acceptés.',
    },
    {
      'title': 'Discussion Crypto',
      'type': 'FINANCE',
      'date': 'Samedi, 18h00',
      'participants': 12,
      'maxParticipants': 20,
      'host': 'Tk-Porky',
      'color': Color(0xFF66BB6A), // Green
      'icon': Icons.attach_money,
      'description': 'Analyse du marché actuel et prédictions pour le mois à venir. Pas de conseils financiers.',
    },
    {
      'title': 'Soirée Ciné',
      'type': 'SOCIAL',
      'date': 'Dimanche, 20h30',
      'participants': 5,
      'maxParticipants': 10,
      'host': 'Not A Loli',
      'color': Color(0xFFFFA726), // Orange
      'icon': Icons.movie,
      'description': 'Visionnage de "Inception" sur Discord. Popcorn virtuel offert !',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        final activity = _activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppTheme.cardDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceDark),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppTheme.surfaceDark)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: activity['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(activity['icon'], color: activity['color'], size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity['title'],
                            style: AppTheme.headingSmall.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceDark,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  activity['type'],
                                  style: TextStyle(
                                    color: activity['color'],
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'par ${activity['host']}',
                                style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Body
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['description'],
                      style: AppTheme.bodyMedium.copyWith(color: AppTheme.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16, color: AppTheme.textSecondary),
                            const SizedBox(width: 6),
                            Text(
                              activity['date'],
                              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.group, size: 16, color: AppTheme.textSecondary),
                            const SizedBox(width: 6),
                            Text(
                              '${activity['participants']}/${activity['maxParticipants']}',
                              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Action
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Rejoindre l\'activité', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
