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
    // Initial fetch of news when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF5FA8A3); // Main Brand Color
    final newsProvider = context.watch<NewsProvider>();
    final articles = newsProvider.articles;
    final isWide = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Browse News',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24),
        ),
        actions: [
          // Modernized Country Dropdown
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: newsProvider.selectedCountry,
                dropdownColor: primaryColor,
                icon: const Icon(Icons.language_rounded, color: Colors.white, size: 20),
                items: countries.map((c) {
                  return DropdownMenuItem(
                    value: c.code,
                    child: Text(
                      c.name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) newsProvider.changeCountry(value);
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. HORIZONTAL CATEGORIES BAR
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: newsCategories.length,
              itemBuilder: (context, index) {
                final cat = newsCategories[index];
                final isSelected = newsProvider.selectedCategory == cat.apiValue;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text('${cat.emoji} ${cat.label}'),
                    selected: isSelected,
                    onSelected: (_) => newsProvider.changeCategory(cat.apiValue),
                    selectedColor: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? primaryColor : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: isSelected ? 4 : 0,
                    side: BorderSide.none,
                    pressElevation: 8,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // 2. MAIN CONTENT SHEET
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: newsProvider.isLoading
                    ? const Center(child: CircularProgressIndicator(color: primaryColor))
                    : _buildNewsList(articles, isWide, primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList(List<Article> articles, bool isWide, Color color) {
    if (isWide) {
      return GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.75,
        ),
        itemCount: articles.length,
        itemBuilder: (context, index) => _ArticleTile(article: articles[index], primaryColor: color),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      itemCount: articles.length,
      itemBuilder: (context, index) => _ArticleTile(article: articles[index], primaryColor: color),
    );
  }
}

class _ArticleTile extends StatelessWidget {
  final Article article;
  final Color primaryColor;

  const _ArticleTile({required this.article, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final isSaved = bookmarkProvider.isBookmarked(article);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push('/article', extra: article),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Hero(
              tag: article.url,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: article.imageUrl != null
                    ? Image.network(
                  article.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
                )
                    : _buildImagePlaceholder(),
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
                      // Source Badge
                      if (article.source != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            article.source!.toUpperCase(),
                            style: TextStyle(color: primaryColor, fontSize: 10, fontWeight: FontWeight.w800),
                          ),
                        ),
                      // Bookmark Toggle
                      IconButton(
                        onPressed: () => bookmarkProvider.toggleBookmark(article),
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isSaved ? primaryColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Bold Title
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, height: 1.2),
                  ),
                  const SizedBox(height: 12),
                  // Muted Description
                  Text(
                    article.description ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[100],
      child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
    );
  }
}