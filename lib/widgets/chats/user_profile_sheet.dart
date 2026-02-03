import 'package:flutter/material.dart';
import '../../models/chat_model.dart';
import '../../utils/app_theme.dart';

class UserProfileSheet extends StatelessWidget {
  final ChatModel chat;

  const UserProfileSheet({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── drag handle ──
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // ── avatar + online badge ──
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundImage: chat.avatarUrl != null && chat.avatarUrl!.isNotEmpty
                        ? NetworkImage(chat.avatarUrl!)
                        : null,
                    child: chat.avatarUrl == null || chat.avatarUrl!.isEmpty
                        ? Text(
                            chat.name[0],
                            style: const TextStyle(fontSize: 36, color: Colors.white),
                          )
                        : null,
                    radius: 52,
                    backgroundColor: AppTheme.primaryBlue.withOpacity(0.4),
                  ),
                  if (chat.isOnline)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppTheme.onlineGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.cardDark, width: 3),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // ── name ──
              Text(
                chat.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),

              // ── online / offline status ──
              Text(
                chat.isOnline ? 'Online' : 'Last seen recently',
                style: TextStyle(
                  color: chat.isOnline ? AppTheme.onlineGreen : AppTheme.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),

              // ── divider ──
              const Divider(color: AppTheme.surfaceDark, height: 1),
              const SizedBox(height: 16),

              // ── info rows ──
              if (chat.username != null)
                _infoRow(Icons.tag, 'Username', chat.username!),
              if (chat.phone != null)
                _infoRow(Icons.phone, 'Phone', chat.phone!),
              if (chat.bio != null)
                _infoRow(Icons.info_outline, 'Bio', chat.bio!),

              const SizedBox(height: 20),

              // ── action buttons ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionButton(context, Icons.phone, 'Call', () {
                    Navigator.pop(context);
                    // TODO: launch tel: URI
                  }),
                  _actionButton(context, Icons.message_outlined, 'Message', () {
                    Navigator.pop(context);
                    // already in chat — just close the sheet
                  }),
                  _actionButton(context, Icons.block, 'Block', () {
                    Navigator.pop(context);
                    // TODO: implement block logic
                  }, isDestructive: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.textSecondary, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final color = isDestructive ? Colors.redAccent : AppTheme.primaryBlue;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
