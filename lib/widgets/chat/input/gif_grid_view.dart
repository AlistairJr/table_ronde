import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../services/tenor_gif_service.dart';

/// Grid view for displaying GIFs from Tenor API
class GifGridView extends StatefulWidget {
  final Function(String gifUrl) onGifSelected;
  final String? searchQuery;

  const GifGridView({
    super.key,
    required this.onGifSelected,
    this.searchQuery,
  });

  @override
  State<GifGridView> createState() => _GifGridViewState();
}

class _GifGridViewState extends State<GifGridView> {
  List<TenorGifModel> _gifs = [];
  bool _isLoading = true;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _loadGifs();
  }

  @override
  void didUpdateWidget(GifGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      _loadGifs();
    }
  }

  Future<void> _loadGifs() async {
    setState(() {
      _isLoading = true;
      _currentQuery = widget.searchQuery ?? '';
    });

    List<TenorGifModel> gifs;
    if (_currentQuery.isEmpty) {
      gifs = await TenorGifService.fetchTrending();
    } else {
      gifs = await TenorGifService.searchGifs(_currentQuery);
    }

    if (mounted) {
      setState(() {
        _gifs = gifs;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A884)),
        ),
      );
    }

    if (_gifs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.gif_box_outlined,
              size: 64,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              _currentQuery.isEmpty
                  ? 'No trending GIFs found'
                  : 'No GIFs found for "$_currentQuery"',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(6),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 1.0,
      ),
      itemCount: _gifs.length,
      itemBuilder: (context, index) {
        final gif = _gifs[index];
        return _GifGridItem(
          gif: gif,
          onTap: () => widget.onGifSelected(gif.fullUrl),
        );
      },
    );
  }
}

/// Individual GIF grid item
class _GifGridItem extends StatelessWidget {
  final TenorGifModel gif;
  final VoidCallback onTap;

  const _GifGridItem({
    required this.gif,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E2A30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: gif.previewUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: const Color(0xFF1E2A30),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: const Color(0xFF1E2A30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.broken_image,
                    color: Colors.white.withOpacity(0.3),
                    size: 32,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'GIF',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
