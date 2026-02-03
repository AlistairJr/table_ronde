import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class EducationScreen extends StatefulWidget {
  final TabController tabController;

  const EducationScreen({
    super.key,
    required this.tabController,
  });

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        _buildHomeworkTab(),
        _buildDocumentsTab(),
        _buildNotesTab(),
      ],
    );
  }

  Widget _buildHomeworkTab() {
    final homework = [
      {
        'title': 'Mathématiques',
        'subtitle': 'Exercices chapitre 3 - Équations',
        'dueDate': 'Pour demain',
        'status': 'urgent',
        'icon': Icons.calculate,
        'color': AppTheme.errorColor,
      },
      {
        'title': 'Français',
        'subtitle': 'Rédaction sur la littérature moderne',
        'dueDate': 'Dans 3 jours',
        'status': 'pending',
        'icon': Icons.edit,
        'color': AppTheme.warningColor,
      },
      {
        'title': 'Histoire',
        'subtitle': 'Exposé sur la Renaissance',
        'dueDate': 'Dans 1 semaine',
        'status': 'normal',
        'icon': Icons.history_edu,
        'color': AppTheme.primaryBlue,
      },
      {
        'title': 'Sciences',
        'subtitle': 'TP Chimie - Réactions acido-basiques',
        'dueDate': 'Terminé',
        'status': 'completed',
        'icon': Icons.science,
        'color': AppTheme.successColor,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: homework.length,
      itemBuilder: (context, index) {
        final item = homework[index];
        return _buildHomeworkCard(item);
      },
    );
  }

  Widget _buildDocumentsTab() {
    final documents = [
      {
        'title': 'Cours de Flutter',
        'subtitle': 'Introduction aux widgets',
        'size': '2.4 MB',
        'type': 'PDF',
        'date': 'Ajouté hier',
        'icon': Icons.picture_as_pdf,
        'color': Colors.red,
      },
      {
        'title': 'Exercices Mathématiques',
        'subtitle': 'Chapitres 1-5 avec corrections',
        'size': '1.8 MB',
        'type': 'PDF',
        'date': '15/01/2026',
        'icon': Icons.picture_as_pdf,
        'color': Colors.red,
      },
      {
        'title': 'Présentation Histoire',
        'subtitle': 'La Renaissance en Europe',
        'size': '5.2 MB',
        'type': 'PPTX',
        'date': '14/01/2026',
        'icon': Icons.slideshow,
        'color': Colors.orange,
      },
      {
        'title': 'Notes de cours',
        'subtitle': 'Sciences Physiques',
        'size': '850 KB',
        'type': 'DOCX',
        'date': '12/01/2026',
        'icon': Icons.description,
        'color': Colors.blue,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final doc = documents[index];
        return _buildDocumentCard(doc);
      },
    );
  }

  Widget _buildNotesTab() {
    final notes = [
      {
        'title': 'Idées de projet',
        'content': 'Application mobile pour gérer les devoirs et partager des notes...',
        'date': 'Aujourd\'hui',
        'color': Colors.purple,
      },
      {
        'title': 'Révisions examen',
        'content': 'Points importants : - Chapitre 3 - Formules de trigonométrie...',
        'date': 'Hier',
        'color': Colors.blue,
      },
      {
        'title': 'Résumé cours',
        'content': 'Les points clés du cours d\'histoire sur la Renaissance...',
        'date': '15/01/2026',
        'color': Colors.green,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return _buildNoteCard(note);
      },
    );
  }

  Widget _buildHomeworkCard(Map<String, dynamic> item) {
    final isCompleted = item['status'] == 'completed';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (item['color'] as Color).withOpacity(0.3),
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
                  color: (item['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: AppTheme.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['subtitle'] as String,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppTheme.successColor,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: item['color'] as Color,
              ),
              const SizedBox(width: 4),
              Text(
                item['dueDate'] as String,
                style: AppTheme.bodySmall.copyWith(
                  color: item['color'] as Color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> doc) {
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (doc['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              doc['icon'] as IconData,
              color: doc['color'] as Color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc['title'] as String,
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doc['subtitle'] as String,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${doc['size']} • ${doc['date']}',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: AppTheme.primaryBlue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(Map<String, dynamic> note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (note['color'] as Color).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: note['color'] as Color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note['title'] as String,
                      style: AppTheme.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      note['date'] as String,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: AppTheme.primaryBlue, size: 20),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            note['content'] as String,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
