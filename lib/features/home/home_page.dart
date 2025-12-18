import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';
import '../../core/constants/categories.dart';
import '../../core/constants/countries.dart';
import '../../providers/bookmark_provider.dart';
import '../../data/model/article_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const brandColor = Color(0xFF5FA8A3);
    final scaffoldBg = isDark ? const Color(0xFF121212) : brandColor;

    final newsProvider = context.watch<NewsProvider>();
    final articles = newsProvider.articles;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
            'Browse News',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: newsProvider.selectedCountry,
                dropdownColor: isDark ? const Color(0xFF1E1E1E) : brandColor,
                icon: const Icon(Icons.language, color: Colors.white, size: 20),
                items: countries.map((c) => DropdownMenuItem(
                    value: c.code,
                    child: Text(c.name, style: const TextStyle(color: Colors.white))
                )).toList(),
                onChanged: (v) => v != null ? newsProvider.changeCountry(v) : null,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. CATEGORY BAR (Fixes Invisible Text)
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: newsCategories.length,
              itemBuilder: (context, index) {
                final cat = newsCategories[index];
                final isSelected = newsProvider.selectedCategory == cat.apiValue;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text('${cat.emoji} ${cat.label}'),
                    selected: isSelected,
                    onSelected: (_) => newsProvider.changeCategory(cat.apiValue),
                    selectedColor: Colors.white,
                    // Black opacity ensures white text is visible on the teal background
                    backgroundColor: Colors.black.withOpacity(0.15),
                    labelStyle: TextStyle(
                      color: isSelected ? brandColor : Colors.white,
                      fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                    ),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide.none,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // 2. MAIN NEWS SHEET
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)
                ),
                child: newsProvider.isLoading
                    ? const Center(child: CircularProgressIndicator(color: brandColor))
                    : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: articles.length,
                  itemBuilder: (context, index) => _ArticleTile(
                      article: articles[index],
                      brandColor: brandColor
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleTile extends StatelessWidget {
  final Article article;
  final Color brandColor;

  const _ArticleTile({required this.article, required this.brandColor});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookmarkProvider = context.watch<BookmarkProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10)
          )
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push('/article', extra: article),
        child: Column(
          children: [
            // IMAGE SECTION WITH 404/ERROR PROTECTION
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Hero(
                tag: article.url,
                child: article.imageUrl != null && article.imageUrl!.isNotEmpty
                    ? Image.network(
                  article.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // ✅ THIS REMOVES THE "HTTP 404" ERROR TEXT FROM UI
                  errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      height: 200,
                      color: isDark ? Colors.white10 : Colors.grey[100],
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  },
                )
                    : _buildPlaceholder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (article.source != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: brandColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            article.source!.toUpperCase(),
                            style: TextStyle(color: brandColor, fontSize: 10, fontWeight: FontWeight.w800),
                          ),
                        ),
                      IconButton(
                        onPressed: () => bookmarkProvider.toggleBookmark(article),
                        icon: Icon(
                          bookmarkProvider.isBookmarked(article) ? Icons.bookmark : Icons.bookmark_border,
                          color: bookmarkProvider.isBookmarked(article) ? brandColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : Colors.black87
                      )
                  ),
                  const SizedBox(height: 8),
                  Text(
                      article.description ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.grey[600],
                          fontSize: 14,
                          height: 1.4
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ PROFESSIONAL PLACEHOLDER WIDGET
  Widget _buildPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.newspaper_rounded, color: Colors.grey[500], size: 40),
          const SizedBox(height: 8),
          Text("News Image Preview", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}