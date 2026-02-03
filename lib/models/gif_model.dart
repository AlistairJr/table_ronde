class GifModel {
  final String id;
  final String title;
  final String category;    // 'trending', 'funny', 'love', 'hello', 'good morning'
  final String assetPath;   // local asset path (replace with network URLs if using an API)
  final String thumbEmoji;  // fallback when asset is unavailable

  const GifModel({
    required this.id,
    required this.title,
    required this.category,
    required this.assetPath,
    required this.thumbEmoji,
  });
}

// ---------------------------------------------------------------------------
// Sample GIFs – grouped by category.  Replace assetPath with real URLs/assets.
// ---------------------------------------------------------------------------
const List<GifModel> sampleGifs = [
  // ── Trending ──
  GifModel(id: 't1', title: 'Mind Blown',     category: 'trending',      assetPath: 'assets/gifs/trending/mind_blown.gif',     thumbEmoji: '🤯'),
  GifModel(id: 't2', title: 'Dancing',        category: 'trending',      assetPath: 'assets/gifs/trending/dancing.gif',        thumbEmoji: '💃'),
  GifModel(id: 't3', title: 'Mic Drop',       category: 'trending',      assetPath: 'assets/gifs/trending/mic_drop.gif',       thumbEmoji: '🎤'),
  GifModel(id: 't4', title: 'High Five',      category: 'trending',      assetPath: 'assets/gifs/trending/high_five.gif',      thumbEmoji: '✋'),
  GifModel(id: 't5', title: 'Party',          category: 'trending',      assetPath: 'assets/gifs/trending/party.gif',          thumbEmoji: '🎉'),
  GifModel(id: 't6', title: 'Nailed It',      category: 'trending',      assetPath: 'assets/gifs/trending/nailed_it.gif',      thumbEmoji: '💯'),

  // ── Funny ──
  GifModel(id: 'fu1', title: 'LOL Cat',       category: 'funny',         assetPath: 'assets/gifs/funny/lol_cat.gif',           thumbEmoji: '😂'),
  GifModel(id: 'fu2', title: 'Fail',          category: 'funny',         assetPath: 'assets/gifs/funny/fail.gif',              thumbEmoji: '😆'),
  GifModel(id: 'fu3', title: 'Clumsy',        category: 'funny',         assetPath: 'assets/gifs/funny/clumsy.gif',            thumbEmoji: '🤣'),
  GifModel(id: 'fu4', title: 'Shrug',         category: 'funny',         assetPath: 'assets/gifs/funny/shrug.gif',             thumbEmoji: '🤷'),
  GifModel(id: 'fu5', title: 'Laugh Cry',     category: 'funny',         assetPath: 'assets/gifs/funny/laugh_cry.gif',         thumbEmoji: '😂'),
  GifModel(id: 'fu6', title: 'Sarcastic',     category: 'funny',         assetPath: 'assets/gifs/funny/sarcastic.gif',         thumbEmoji: '🙄'),

  // ── Love ──
  GifModel(id: 'l1',  title: 'Heart Eyes',    category: 'love',          assetPath: 'assets/gifs/love/heart_eyes.gif',         thumbEmoji: '😍'),
  GifModel(id: 'l2',  title: 'Kiss',          category: 'love',          assetPath: 'assets/gifs/love/kiss.gif',               thumbEmoji: '💋'),
  GifModel(id: 'l3',  title: 'Hearts',        category: 'love',          assetPath: 'assets/gifs/love/hearts.gif',             thumbEmoji: '💕'),
  GifModel(id: 'l4',  title: 'Hug',           category: 'love',          assetPath: 'assets/gifs/love/hug.gif',                thumbEmoji: '🤗'),
  GifModel(id: 'l5',  title: 'Rose',          category: 'love',          assetPath: 'assets/gifs/love/rose.gif',               thumbEmoji: '🌹'),
  GifModel(id: 'l6',  title: 'Cupid',         category: 'love',          assetPath: 'assets/gifs/love/cupid.gif',              thumbEmoji: '💘'),

  // ── Hello ──
  GifModel(id: 'h1',  title: 'Wave',          category: 'hello',         assetPath: 'assets/gifs/hello/wave.gif',              thumbEmoji: '👋'),
  GifModel(id: 'h2',  title: 'Hi There',      category: 'hello',         assetPath: 'assets/gifs/hello/hi_there.gif',          thumbEmoji: '🙋'),
  GifModel(id: 'h3',  title: 'Howdy',         category: 'hello',         assetPath: 'assets/gifs/hello/howdy.gif',             thumbEmoji: '🤠'),
  GifModel(id: 'h4',  title: 'Sup',           category: 'hello',         assetPath: 'assets/gifs/hello/sup.gif',               thumbEmoji: '😎'),
  GifModel(id: 'h5',  title: 'Peek',          category: 'hello',         assetPath: 'assets/gifs/hello/peek.gif',              thumbEmoji: '👀'),
  GifModel(id: 'h6',  title: 'Greetings',     category: 'hello',         assetPath: 'assets/gifs/hello/greetings.gif',         thumbEmoji: '🫡'),

  // ── Good Morning ──
  GifModel(id: 'gm1', title: 'Morning Sun',   category: 'good morning',  assetPath: 'assets/gifs/morning/morning_sun.gif',    thumbEmoji: '🌅'),
  GifModel(id: 'gm2', title: 'Coffee Time',   category: 'good morning',  assetPath: 'assets/gifs/morning/coffee_time.gif',    thumbEmoji: '☕'),
  GifModel(id: 'gm3', title: 'Stretching',    category: 'good morning',  assetPath: 'assets/gifs/morning/stretching.gif',     thumbEmoji: '🧘'),
  GifModel(id: 'gm4', title: 'Yawning',       category: 'good morning',  assetPath: 'assets/gifs/morning/yawning.gif',        thumbEmoji: '🥱'),
  GifModel(id: 'gm5', title: 'Sunrise',       category: 'good morning',  assetPath: 'assets/gifs/morning/sunrise.gif',        thumbEmoji: '🌄'),
  GifModel(id: 'gm6', title: 'Ready',         category: 'good morning',  assetPath: 'assets/gifs/morning/ready.gif',          thumbEmoji: '💪'),
];

List<String> get gifCategories => sampleGifs.map((g) => g.category).toSet().toList();

List<GifModel> gifsByCategory(String category) =>
    sampleGifs.where((g) => g.category == category).toList();
