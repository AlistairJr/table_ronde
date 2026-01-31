class ChatModel {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String? avatarUrl;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.avatarUrl,
  });
}

class MessageModel {
  final String text;
  final bool isSentByMe;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl;

  MessageModel({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
    this.isRead = false,
    this.imageUrl,
  });
}
