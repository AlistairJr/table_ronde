import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../../../../utils/app_theme.dart';
import '../input/gif_grid_view.dart';
import '../input/sticker_grid_view.dart';
import '../../../services/tenor_gif_service.dart';

class GifStickerPickerSheet extends StatefulWidget {
  final Function(String) onGifSelected;
  final Function(String) onStickerSelected;
  final TextEditingController? messageController;

  const GifStickerPickerSheet({
    super.key,
    required this.onGifSelected,
    required this.onStickerSelected,
    this.messageController,
  });

  @override
  State<GifStickerPickerSheet> createState() => _GifStickerPickerSheetState();
}

class _GifStickerPickerSheetState extends State<GifStickerPickerSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Trending';

  // Categories for the bottom bar
  final List<String> _categories = [
    'Trending',
    'Funny',
    'Love',
    'Happy',
    'Sad',
    'Angry',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to hide/show header based on index
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _searchQuery = category == 'Trending' ? '' : category;
      _searchController.text = _searchQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: const Color(0xFF0B141A), // Dark background like WhatsApp
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with Search and Tabs (Hide search for Emoji tab - index 0)
          _buildHeader(),

          // Content Area
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Emoji Tab
                EmojiPicker(
                  textEditingController: widget.messageController,
                  config: Config(
                    emojiViewConfig: EmojiViewConfig(
                      columns: 8,
                      emojiSizeMax: 32 * 1.0,
                      backgroundColor: const Color(0xFF0B141A),
                      buttonMode: ButtonMode.MATERIAL,
                    ),
                    categoryViewConfig: const CategoryViewConfig(
                      initCategory: Category.RECENT,
                      backgroundColor: Color(0xFF0B141A),
                      indicatorColor: AppTheme.primaryBlue,
                      iconColor: Colors.grey,
                      iconColorSelected: AppTheme.primaryBlue,
                      backspaceColor: AppTheme.primaryBlue,
                    ),
                    skinToneConfig: const SkinToneConfig(
                      dialogBackgroundColor: Colors.white,
                      indicatorColor: Colors.grey,
                    ),
                  ),
                ),

                // GIF Tab
                GifGridView(
                  onGifSelected: widget.onGifSelected,
                  searchQuery: _searchQuery,
                ),

                // Stickers Tab
                StickerGridView(
                  onStickerSelected: widget.onStickerSelected,
                  category: _searchQuery.isEmpty ? 'trending' : _searchQuery,
                ),
              ],
            ),
          ),

          // Bottom Category Bar (only separate specific Categories, maybe hide for Emoji)
          if (_tabController.index != 0) _buildCategoryBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1E2A30))),
      ),
      child: Column(
        children: [
          // Search Bar - Hide for Emoji (index 0)
          if (_tabController.index != 0) ...[
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2A30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: _tabController.index == 1
                      ? 'Search GIFs'
                      : 'Search Stickers',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.3),
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          color: Colors.white.withOpacity(0.3),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Tab Bar
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFF00A884),
            indicatorWeight: 3,
            labelColor: const Color(0xFF00A884),
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            onTap: (index) {
              // FocusScope.of(context).unfocus(); // Optional
            },
            tabs: const [
              Tab(text: 'Emoji'),
              Tab(text: 'GIF'),
              Tab(text: 'Stickers'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar() {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF1E2A30))),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return GestureDetector(
            onTap: () => _onCategorySelected(category),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: isSelected
                    ? const Border(
                        top: BorderSide(color: Color(0xFF00A884), width: 2))
                    : null,
                color:
                    isSelected ? const Color(0xFF1E2A30) : Colors.transparent,
              ),
              child: Text(
                category,
                style: TextStyle(
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
