import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Uncomment when you add the packages to pubspec.yaml:
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/platform_channels/file_manager_support.dart';
// import 'package:file_picker/file_picker.dart';

import '../utils/app_theme.dart';
import '../models/chat_model.dart';
import '../widgets/chats/sticker_model.dart';
import '../models/gif_model.dart';
import '../widgets/chats/sticker_picker.dart';
import '../widgets/chats/gif_picker.dart';
import '../widgets/chats/user_profile_sheet.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // ── controllers ──────────────────────────────────────────────────────────
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // ── state ────────────────────────────────────────────────────────────────
  final List<MessageModel> _messages = [];
  late ChatModel _chat;
  bool _isTyping = false;
  bool _hasText = false;

  // ── edit / reply state ───────────────────────────────────────────────────
  MessageModel? _replyTo;       // message currently being replied to
  MessageModel? _editingMsg;    // message currently being edited

  // ──────────────────────────────────────────────────────────────────────────
  // LIFECYCLE
  // ──────────────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadSampleMessages();
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chat = ModalRoute.of(context)!.settings.arguments as ChatModel;
  }

  void _onTextChanged() {
    final hasText = _messageController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SAMPLE DATA
  // ──────────────────────────────────────────────────────────────────────────

  void _loadSampleMessages() {
    _messages.addAll([
      MessageModel(
        id: 'msg_1',
        text: 'Hey! How are you doing? 😊',
        isSentByMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg_2',
        text: "I'm great! Thanks for asking. How about you?",
        isSentByMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg_3',
        text: "I'm doing well! Just working on some projects.",
        isSentByMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg_4',
        text: 'Want to meet up later? Maybe grab some coffee?',
        isSentByMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 48)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg_5',
        text: "Sure! That sounds great. What time works for you?",
        isSentByMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg_6',
        text: 'How about 5 PM at the usual spot?',
        isSentByMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
        isRead: true,
      ),
      MessageModel(
        id: 'msg_7',
        text: "Perfect! See you there! 👍",
        isSentByMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: true,
      ),
    ]);
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SEND / EDIT ACTIONS
  // ──────────────────────────────────────────────────────────────────────────

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // --- editing an existing message ---
    if (_editingMsg != null) {
      setState(() {
        _editingMsg!.text = text;
        _editingMsg!.isEdited = true;
        _editingMsg = null;
      });
      _messageController.clear();
      return;
    }

    // --- new message (possibly a reply) ---
    setState(() {
      _messages.add(
        MessageModel(
          text: text,
          isSentByMe: true,
          timestamp: DateTime.now(),
          isRead: false,
          replyToId: _replyTo?.id,
        ),
      );
      _replyTo = null;
    });
    _messageController.clear();
    _scrollToBottom();
  }

  void _deleteMessage(MessageModel msg) {
    setState(() {
      msg.isDeleted = true;
      msg.text = '';
    });
  }

  void _startEdit(MessageModel msg) {
    setState(() {
      _editingMsg = msg;
      _replyTo = null;
      _messageController.text = msg.text;
    });
  }

  void _startReply(MessageModel msg) {
    setState(() {
      _replyTo = msg;
      _editingMsg = null;
      _messageController.clear();
    });
    // focus the text field
    Future.microtask(() => FocusManager.instance.primaryFocus?.requestFocus());
  }

  void _cancelEditOrReply() {
    setState(() {
      _editingMsg = null;
      _replyTo = null;
      _messageController.clear();
    });
  }

  // ──────────────────────────────────────────────────────────────────────────
  // STICKER / GIF
  // ──────────────────────────────────────────────────────────────────────────

  Future<void> _openStickerPicker() async {
    final StickerModel? sticker = await showModalBottomSheet<StickerModel>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const StickerPicker(),
    );
    if (sticker != null && mounted) {
      setState(() {
        _messages.add(
          MessageModel(
            text: sticker.name,
            isSentByMe: true,
            timestamp: DateTime.now(),
            type: MessageType.sticker,
            stickerUrl: sticker.assetPath,
            replyToId: _replyTo?.id,
          ),
        );
        _replyTo = null;
      });
      _scrollToBottom();
    }
  }

  Future<void> _openGifPicker() async {
    final GifModel? gif = await showModalBottomSheet<GifModel>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const GifPicker(),
    );
    if (gif != null && mounted) {
      setState(() {
        _messages.add(
          MessageModel(
            text: gif.title,
            isSentByMe: true,
            timestamp: DateTime.now(),
            type: MessageType.gif,
            gifUrl: gif.assetPath,
            replyToId: _replyTo?.id,
          ),
        );
        _replyTo = null;
      });
      _scrollToBottom();
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // ATTACHMENTS  (image_picker / file_picker stubs)
  // ──────────────────────────────────────────────────────────────────────────

  Future<void> _pickFromGallery() async {
    // REAL IMPLEMENTATION:
    // final ImagePicker picker = ImagePicker();
    // final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    // if (file == null) return;
    // Simulate a picked image:
    _addAttachment(
      type: MessageType.image,
      url: 'assets/images/sample_image.jpg', // replace with file.path
      name: 'sample_image.jpg',              // replace with file.name
    );
  }

  Future<void> _pickFromCamera() async {
    // REAL IMPLEMENTATION:
    // final ImagePicker picker = ImagePicker();
    // final XFile? file = await picker.pickImage(source: ImageSource.camera);
    // if (file == null) return;
    _addAttachment(
      type: MessageType.image,
      url: 'assets/images/camera_capture.jpg',
      name: 'camera_capture.jpg',
    );
  }

  Future<void> _pickDocument() async {
    // REAL IMPLEMENTATION:
    // FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // if (result == null) return;
    // final file = result.files.single;
    _addAttachment(
      type: MessageType.document,
      url: 'assets/docs/sample_document.pdf',
      name: 'sample_document.pdf',
    );
  }

  Future<void> _pickVideo() async {
    // REAL IMPLEMENTATION:
    // final ImagePicker picker = ImagePicker();
    // final XFile? file = await picker.pickVideo(source: ImageSource.gallery);
    // if (file == null) return;
    _addAttachment(
      type: MessageType.video,
      url: 'assets/videos/sample_video.mp4',
      name: 'sample_video.mp4',
    );
  }

  void _addAttachment({
    required MessageType type,
    required String url,
    required String name,
  }) {
    if (!mounted) return;
    setState(() {
      _messages.add(
        MessageModel(
          text: name,
          isSentByMe: true,
          timestamp: DateTime.now(),
          type: type,
          attachmentUrl: url,
          attachmentName: name,
          replyToId: _replyTo?.id,
        ),
      );
      _replyTo = null;
    });
    _scrollToBottom();
  }

  // ──────────────────────────────────────────────────────────────────────────
  // USER PROFILE
  // ──────────────────────────────────────────────────────────────────────────

  void _showUserProfile() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => UserProfileSheet(chat: _chat),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SCROLL
  // ──────────────────────────────────────────────────────────────────────────

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ──────────────────────────────────────────────────────────────────────────
  // BUILD – root
  // ──────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // message list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showDateSep = index == 0 ||
                    !_isSameDay(message.timestamp, _messages[index - 1].timestamp);
                return Column(
                  children: [
                    if (showDateSep) _buildDateSeparator(message.timestamp),
                    _buildMessageBubble(message),
                  ],
                );
              },
            ),
          ),

          // ── reply / edit bar ──
          if (_replyTo != null || _editingMsg != null)
            _buildReplyOrEditBar(),

          // ── input row ──
          _buildMessageInput(),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // APP BAR
  // ──────────────────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.cardDark,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: InkWell(
        onTap: () {},
        child: Row(
          children: [
            // avatar – tappable → profile sheet
            GestureDetector(
              onTap: _showUserProfile,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: _chat.avatarUrl != null && _chat.avatarUrl!.isNotEmpty
                        ? NetworkImage(_chat.avatarUrl!)
                        : null,
                    child: _chat.avatarUrl == null || _chat.avatarUrl!.isEmpty
                        ? Text(_chat.name[0])
                        : null,
                    radius: 20,
                  ),
                  if (_chat.isOnline)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppTheme.onlineGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.cardDark, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // name + status + chevron
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _chat.name,
                        style: AppTheme.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (_isTyping)
                        Text(
                          'typing...',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.primaryBlue,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      else
                        Text(
                          _chat.isOnline ? 'online' : 'last seen recently',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.chevron_right, color: AppTheme.textSecondary, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // REPLY / EDIT BAR
  // ──────────────────────────────────────────────────────────────────────────

  Widget _buildReplyOrEditBar() {
    final isReply = _replyTo != null;
    final msg = isReply ? _replyTo! : _editingMsg!;

    return Container(
      color: AppTheme.cardDark,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // left accent bar
          Container(
            width: 3,
            height: 42,
            decoration: BoxDecoration(
              color: isReply ? AppTheme.primaryBlue : Colors.amber,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),

          // label + preview text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isReply ? 'Replying to ${msg.isSentByMe ? "you" : _chat.name}' : 'Editing message',
                  style: TextStyle(
                    color: isReply ? AppTheme.primaryBlue : Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  msg.isDeleted ? 'This message was deleted' : (msg.text.isNotEmpty ? msg.text : _typeLabel(msg.type)),
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // close button
          GestureDetector(
            onTap: _cancelEditOrReply,
            child: const Icon(Icons.close, color: AppTheme.textSecondary, size: 22),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // DATE SEPARATOR
  // ──────────────────────────────────────────────────────────────────────────

  Widget _buildDateSeparator(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _formatDate(date),
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // MESSAGE BUBBLE
  // ──────────────────────────────────────────────────────────────────────────

  Widget _buildMessageBubble(MessageModel message) {
    if (message.isDeleted) return _buildDeletedBubble(message);

    final isSentByMe = message.isSentByMe;

    // find the replied-to message (if any)
    MessageModel? repliedMsg;
    if (message.replyToId != null) {
      repliedMsg = _messages.firstWhere((m) => m.id == message.replyToId, orElse: () => MessageModel(
        id: 'ghost',
        text: 'Original message was deleted',
        isSentByMe: false,
        timestamp: DateTime.now(),
        isDeleted: true,
      ));
    }

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            // avatar (other user)
            if (!isSentByMe) ...[
              GestureDetector(
                onTap: _showUserProfile,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: _chat.avatarUrl != null && _chat.avatarUrl!.isNotEmpty
                          ? NetworkImage(_chat.avatarUrl!)
                          : null,
                      child: _chat.avatarUrl == null || _chat.avatarUrl!.isEmpty
                          ? Text(_chat.name[0])
                          : null,
                      radius: 18,
                    ),
                    if (_chat.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppTheme.onlineGreen,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.backgroundDark, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
            ],

            // bubble content
            Flexible(
              child: Column(
                crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // sender name (other user only)
                  if (!isSentByMe)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, left: 10),
                      child: Text(
                        _chat.name,
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  // long-press context menu wrapper
                  GestureDetector(
                    onLongPress: () => _showMessageOptions(message),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.65,
                      ),
                      decoration: BoxDecoration(
                        color: isSentByMe ? AppTheme.chatBubbleOutgoing : AppTheme.chatBubbleIncoming,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(18),
                          topRight: const Radius.circular(18),
                          bottomLeft: isSentByMe ? const Radius.circular(18) : const Radius.circular(4),
                          bottomRight: isSentByMe ? const Radius.circular(4) : const Radius.circular(18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── quoted reply preview ──
                          if (repliedMsg != null) _buildReplyPreview(repliedMsg),

                          // ── body based on type ──
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            child: _buildBubbleBody(message),
                          ),

                          // ── timestamp + read indicator ──
                          Padding(
                            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (message.isEdited)
                                  const Text(
                                    'edited ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color.fromRGBO(255, 255, 255, 0.55),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                Text(
                                  _formatTime(message.timestamp),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color.fromRGBO(255, 255, 255, 0.55),
                                  ),
                                ),
                                if (isSentByMe) ...[
                                  const SizedBox(width: 4),
                                  Icon(
                                    message.isRead ? Icons.done_all : Icons.done,
                                    size: 15,
                                    color: message.isRead
                                        ? AppTheme.telegramBlue.withOpacity(0.8)
                                        : Colors.white.withOpacity(0.55),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (isSentByMe) const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }

  // ── deleted bubble ──
  Widget _buildDeletedBubble(MessageModel message) {
    final isSentByMe = message.isSentByMe;
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        child: Row(
          mainAxisAlignment: isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isSentByMe) ...[
              const SizedBox(width: 24 + 6), // placeholder for avatar width
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSentByMe
                    ? AppTheme.chatBubbleOutgoing.withOpacity(0.6)
                    : AppTheme.chatBubbleIncoming.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: isSentByMe ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: isSentByMe ? const Radius.circular(4) : const Radius.circular(18),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lock, size: 14, color: Color.fromRGBO(255, 255, 255, 0.6)),
                  const SizedBox(width: 6),
                  const Text(
                    'This message was deleted',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── reply preview inside bubble ──
  Widget _buildReplyPreview(MessageModel replied) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: AppTheme.primaryBlue, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            replied.isSentByMe ? 'You' : _chat.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            replied.isDeleted
                ? 'This message was deleted'
                : (replied.text.isNotEmpty ? replied.text : _typeLabel(replied.type)),
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

  // ── bubble body switch ──
  Widget _buildBubbleBody(MessageModel msg) {
    switch (msg.type) {
      case MessageType.sticker:
        return _buildStickerBody(msg);
      case MessageType.gif:
        return _buildGifBody(msg);
      case MessageType.image:
        return _buildImageBody(msg);
      case MessageType.video:
        return _buildVideoBody(msg);
      case MessageType.document:
        return _buildDocumentBody(msg);
      case MessageType.text:
      default:
        return Text(
          msg.text,
          style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
        );
    }
  }

  Widget _buildStickerBody(MessageModel msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // placeholder emoji container (replace with Image.asset when assets exist)
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text('🏷️', style: const TextStyle(fontSize: 64)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          msg.text, // sticker name
          style: const TextStyle(color: Color.fromRGBO(255,255,255,0.7), fontSize: 12, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildGifBody(MessageModel msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 180,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('GIF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                const SizedBox(height: 4),
                Text(msg.text, style: const TextStyle(color: Color.fromRGBO(255,255,255,0.7), fontSize: 13)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageBody(MessageModel msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image, color: Colors.white70, size: 48),
                const SizedBox(height: 6),
                Text(msg.attachmentName ?? 'Image', style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoBody(MessageModel msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
                ),
                const SizedBox(height: 6),
                Text(msg.attachmentName ?? 'Video', style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentBody(MessageModel msg) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.insert_drive_file, color: AppTheme.primaryBlue, size: 24),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.attachmentName ?? 'Document',
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Tap to open',
              style: TextStyle(color: Color.fromRGBO(255,255,255,0.55), fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // LONG-PRESS CONTEXT MENU
  // ──────────────────────────────────────────────────────────────────────────

  void _showMessageOptions(MessageModel msg) {
    if (msg.isDeleted) return;

    final actions = <_OptionItem>[
      _OptionItem(Icons.reply, 'Reply', () => _startReply(msg)),
      _OptionItem(Icons.copy, 'Copy', () {
        Clipboard.setData(ClipboardData(text: msg.text));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied'), duration: Duration(seconds: 1)),
        );
      }),
    ];

    // edit & delete only for own messages
    if (msg.isSentByMe && msg.type == MessageType.text) {
      actions.add(_OptionItem(Icons.edit, 'Edit', () => _startEdit(msg)));
    }
    if (msg.isSentByMe) {
      actions.add(_OptionItem(Icons.delete_outline, 'Delete', () => _deleteMessage(msg), isDestructive: true));
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.textSecondary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                ...actions.map((action) => ListTile(
                  leading: Icon(action.icon, color: action.isDestructive ? Colors.redAccent : Colors.white70),
                  title: Text(
                    action.label,
                    style: TextStyle(
                      color: action.isDestructive ? Colors.redAccent : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    action.onTap();
                  },
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // INPUT ROW
  // ──────────────────────────────────────────────────────────────────────────

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: AppTheme.cardDark,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppTheme.textSecondary.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // emoji
                    IconButton(
                      iconSize: 22,
                      icon: const Icon(Icons.emoji_emotions_outlined, color: AppTheme.textSecondary),
                      onPressed: () { /* TODO: emoji picker */ },
                    ),
                    // text field
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        style: AppTheme.bodyMedium.copyWith(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: _editingMsg != null ? 'Edit message…' : 'Message',
                          hintStyle: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                    // sticker
                    IconButton(
                      iconSize: 22,
                      icon: const Icon(Icons.sticky_note_2_outlined, color: AppTheme.textSecondary),
                      onPressed: _openStickerPicker,
                    ),
                    // gif
                    IconButton(
                      iconSize: 22,
                      icon: const Icon(Icons.gif_box_outlined, color: AppTheme.textSecondary),
                      onPressed: _openGifPicker,
                    ),
                    // attachment
                    IconButton(
                      iconSize: 22,
                      icon: const Icon(Icons.attach_file, color: AppTheme.textSecondary),
                      onPressed: _showAttachmentOptions,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // ── mic / send button ──
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: AppTheme.telegramBubbleGradient,
                borderRadius: BorderRadius.circular(21),
              ),
              child: IconButton(
                icon: Icon(
                  _hasText ? Icons.send : Icons.mic,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  if (_hasText) {
                    _sendMessage();
                  } else {
                    // TODO: start voice recording
                  }
                },
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // ATTACHMENT BOTTOM SHEET
  // ──────────────────────────────────────────────────────────────────────────

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.textSecondary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _attachOption(Icons.photo_library, 'Gallery', Colors.purple, () {
                      Navigator.pop(ctx);
                      _pickFromGallery();
                    }),
                    _attachOption(Icons.camera_alt, 'Camera', Colors.pink, () {
                      Navigator.pop(ctx);
                      _pickFromCamera();
                    }),
                    _attachOption(Icons.insert_drive_file, 'Document', Colors.blue, () {
                      Navigator.pop(ctx);
                      _pickDocument();
                    }),
                    _attachOption(Icons.video_library, 'Video', Colors.green, () {
                      Navigator.pop(ctx);
                      _pickVideo();
                    }),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _attachOption(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(29),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTheme.bodySmall.copyWith(color: AppTheme.textPrimary)),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // FORMATTERS / HELPERS
  // ──────────────────────────────────────────────────────────────────────────

  String _formatTime(DateTime ts) {
    final diff = DateTime.now().difference(ts);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inHours < 24) {
      return '${ts.hour.toString().padLeft(2, '0')}:${ts.minute.toString().padLeft(2, '0')}';
    }
    return '${ts.day}/${ts.month}';
  }

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) {
      return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _typeLabel(MessageType type) {
    switch (type) {
      case MessageType.sticker:  return '🏷️ Sticker';
      case MessageType.gif:      return '🎬 GIF';
      case MessageType.image:    return '🖼️ Image';
      case MessageType.video:    return '🎥 Video';
      case MessageType.document: return '📄 Document';
      case MessageType.text:     return '';
    }
  }
}

// small data class used by the context-menu builder
class _OptionItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  _OptionItem(this.icon, this.label, this.onTap, {this.isDestructive = false});
}