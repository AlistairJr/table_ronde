import 'package:flutter/material.dart';
import '../../../models/chat_model.dart';
import '../../../utils/app_theme.dart';

/// Widget to display a preview of the message being replied to
class ReplyPreviewWidget extends StatelessWidget {
  final MessageModel repliedMessage;
  final ChatModel chat;

  const ReplyPreviewWidget({
    super.key,
    required this.repliedMessage,
    required this.chat,
  });

  String _typeLabel(MessageType type) {
    switch (type) {
      case MessageType.sticker:
        return 'Sticker';
      case MessageType.gif:
        return 'GIF';
      case MessageType.image:
        return 'Photo';
      case MessageType.video:
        return 'Vidéo';
      case MessageType.document:
        return 'Document';
      case MessageType.text:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: AppTheme.primaryBlue,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            repliedMessage.isSentByMe ? 'You' : chat.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            repliedMessage.isDeleted
                ? 'This message was deleted'
                : (repliedMessage.text.isNotEmpty
                    ? repliedMessage.text
                    : _typeLabel(repliedMessage.type)),
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
