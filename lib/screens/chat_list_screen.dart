import 'package:flutter/material.dart';
import 'package:tableronde_app/models/chat_model.dart';
import 'package:tableronde_app/utils/app_theme.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<ChatModel> _allChats = [
    ChatModel(
      id: '1',
      name: 'T4zor',
      lastMessage: 'Il me dit f*ck you mdr.',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      avatarUrl: 'assets/images/Avatar1.png',
      isOnline: true,
      unreadCount: 1,
    ),
    ChatModel(
      id: '2',
      name: 'Tk-Porky',
      lastMessage: 'Seigneur.💔🙌 !!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 4)),
      avatarUrl: 'assets/images/Avatar2.png',
      isOnline: false,
      unreadCount: 0,
    ),
    ChatModel(
      id: '3',
      name: 'AlistairJr',
      lastMessage: 'N\'oubliez pas de mettre à jour...',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      avatarUrl: '',
      isOnline: true,
      unreadCount: 3,
    ),
  ];

  List<ChatModel> _filteredChats = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredChats = _allChats;
    _searchController.addListener(_filterChats);
  }

  void _filterChats() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredChats = _allChats.where((chat) {
        return chat.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showConversationMenu(BuildContext context, ChatModel chat) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      builder: (builder) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.notifications_off, color: AppTheme.textSecondary),
              title: const Text('Désactiver les notifications', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement mute notifications
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: AppTheme.textSecondary),
              title: const Text('Bloquer', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement block user
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppTheme.errorColor),
              title: const Text('Supprimer', style: TextStyle(color: AppTheme.errorColor)),
              onTap: () {
                setState(() {
                  _allChats.remove(chat);
                  _filterChats();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cardDark,
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: AppTheme.cardDark,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu selection
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'mark_all_read',
                child: Text('Tous marqués comme lu'),
              ),
              const PopupMenuItem<String>(
                value: 'important',
                child: Text('Importants'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                hintStyle: TextStyle(color: AppTheme.textSecondary),
                prefixIcon: Icon(Icons.search, color: AppTheme.textSecondary),
                filled: true,
                fillColor: AppTheme.backgroundDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredChats.length,
              itemBuilder: (context, index) {
                final chat = _filteredChats[index];
                return Card(
                  color: AppTheme.backgroundDark,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: (chat.avatarUrl != null && chat.avatarUrl!.isNotEmpty)
                              ? AssetImage(chat.avatarUrl!)
                              : null,
                          child: (chat.avatarUrl == null || chat.avatarUrl!.isEmpty) ? Text(chat.name[0]) : null,
                        ),
                        if (chat.isOnline)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppTheme.onlineGreen,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.backgroundDark,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(chat.name, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(
                      chat.lastMessage ?? '',
                      style: const TextStyle(color: AppTheme.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          chat.lastMessageTime != null ? '${chat.lastMessageTime!.hour}:${chat.lastMessageTime!.minute.toString().padLeft(2, '0')}' : '',
                          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                        ),
                        if (chat.unreadCount > 0) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryBlue,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${chat.unreadCount}',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ]
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: chat,
                      );
                    },
                    onLongPress: () {
                      _showConversationMenu(context, chat);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}
