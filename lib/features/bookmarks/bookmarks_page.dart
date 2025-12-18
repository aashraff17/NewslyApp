import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/bookmark_provider.dart';
import '../../data/model/article_model.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final bookmarks = bookmarkProvider.bookmarks;
    const primaryColor = Color(0xFF5FA8A3);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          'Saved Articles',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: bookmarks.isEmpty
            ? const _EmptyBookmarks()
            : ListView.builder(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 100),
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final article = bookmarks[index];
            // Added Dismissible for modern swipe-to-remove interaction
            return Dismissible(
              key: Key(article.url),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                bookmarkProvider.toggleBookmark(article);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Removed from bookmarks')),
                );
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
              ),
              child: _BookmarkItem(article: article),
            );
          },
        ),
      ),
    );
  }
}

class _EmptyBookmarks extends StatelessWidget {
  const _EmptyBookmarks();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF5FA8A3).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bookmark_add_outlined, size: 80, color: Color(0xFF5FA8A3)),
            ),
            const SizedBox(height: 24),
            const Text(
              "Your Reading List is Empty",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Saved articles will appear here for you to read later even when you're offline.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], height: 1.5),
            ),
            const SizedBox(height: 32),
// Inside your BookmarksPage build method
            ElevatedButton(
              onPressed: () {
                // This takes the user back to the MainLayout/Home page
                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5FA8A3), // Your brand color
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Start Browsing',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BookmarkItem extends StatelessWidget {
  final Article article;

  const _BookmarkItem({required this.article});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF5FA8A3);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push('/article', extra: article),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Hero animation for smooth transition
                Hero(
                  tag: article.url,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: article.imageUrl != null && article.imageUrl!.isNotEmpty
                        ? Image.network(
                      article.imageUrl!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(),
                    )
                        : _buildPlaceholder(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.source != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            article.source!.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${article.publishedAt?.day}/${article.publishedAt?.month}/${article.publishedAt?.year}",
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[100],
      child: const Icon(Icons.image_outlined, color: Colors.grey),
    );
  }
}