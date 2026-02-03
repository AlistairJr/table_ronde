import 'package:flutter/material.dart';
import '../../../models/chat_model.dart';
import '../../../utils/app_theme.dart';

/// Widget to display a video message with play button
class VideoMessage extends StatelessWidget {
  final MessageModel message;
  final Function(String) onVideoTap;

  const VideoMessage({
    super.key,
    required this.message,
    required this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (message.attachmentUrl != null &&
            message.attachmentUrl!.isNotEmpty) {
          onVideoTap(message.attachmentUrl!);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 240,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1),
            ),
            child: message.attachmentUrl != null &&
                    message.attachmentUrl!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        // Video thumbnail placeholder
                        Container(
                          color: Colors.black,
                          child: const Center(
                            child: Icon(
                              Icons.videocam,
                              color: Colors.white30,
                              size: 80,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Text(
                            message.attachmentName ?? 'Vidéo',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 4)
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.videocam,
                          color: Colors.white30,
                          size: 60,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message.attachmentName ?? 'Vidéo',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          // Play button overlay
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}
