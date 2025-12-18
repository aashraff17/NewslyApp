import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/model/article_model.dart';
import '../../providers/bookmark_provider.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  const ArticlePage({super.key, required this.article});

  // Function to launch the full URL in the browser
  Future<void> _openArticle(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the bookmark provider to check/toggle saved status
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final isSaved = bookmarkProvider.isBookmarked(article);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. DYNAMIC COLLAPSING HEADER
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xFF5FA8A3),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.3),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.3),
                  child: IconButton(
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? Colors.yellowAccent : Colors.white,
                    ),
                    onPressed: () => bookmarkProvider.toggleBookmark(article),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: article.imageUrl != null
                  ? Hero(
                tag: article.url, // Ensure this tag matches the one in HomePage
                child: Image.network(
                  article.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              )
                  : Container(color: const Color(0xFF5FA8A3)),
            ),
          ),

          // 2. CONTENT SECTION
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source & Date Metadata
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (article.source != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5FA8A3).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            article.source!.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF5FA8A3),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      if (article.publishedAt != null)
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              "${article.publishedAt!.day}/${article.publishedAt!.month}/${article.publishedAt!.year}",
                              style: const TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Bold Headline
                  Text(
                    article.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Italicized Description
                  if (article.description != null)
                    Text(
                      article.description!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Divider(thickness: 1),
                  ),

                  // Main Article Body Snippet
                  Text(
                    article.content ?? 'No detailed content available.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(height: 120), // Bottom padding for FAB
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. READ FULL STORY BUTTON
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF5FA8A3),
        elevation: 4,
        onPressed: () => _openArticle(article.url),
        icon: const Icon(Icons.menu_book_rounded, color: Colors.white),
        label: const Text(
          "READ FULL STORY",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}