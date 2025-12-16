import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bookmark_provider.dart';
import '../../features/article/article_page.dart';

// 1️⃣ MAIN PAGE
class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final bookmarks = bookmarkProvider.bookmarks;

    return Scaffold(
      backgroundColor: const Color(0xFF5FA8A3),
      appBar: AppBar(
        title: const Text('Bookmarks'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: bookmarks.isEmpty
          ? const _EmptyBookmarks()
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: bookmarks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final article = bookmarks[index];
          return _BookmarkItem(article: article);
        },
      ),
    );
  }
}

// 2️⃣ EMPTY STATE WIDGET
class _EmptyBookmarks extends StatelessWidget {
  const _EmptyBookmarks();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark_border, size: 64, color: Colors.white70),
          SizedBox(height: 16),
          Text(
            "You haven't saved any articles yet.\nStart reading and bookmark now.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

// 3️⃣ BOOKMARK ITEM WIDGET ✅ FIXED SAFELY
class _BookmarkItem extends StatelessWidget {
  final dynamic article;

  const _BookmarkItem({required this.article});

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.imageUrl ?? '';
    final title = article.title ?? 'No title';
    final source = article.source ?? 'Unknown source';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticlePage(article: article),
          ),
        );
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_not_supported),
              ),
            )
                : Container(
              width: 80,
              height: 80,
              color: Colors.grey.shade300,
              child: const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  source,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              context.read<BookmarkProvider>().toggleBookmark(article);
            },
          ),
        ],
      ),
    );
  }
}
