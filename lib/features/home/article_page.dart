import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/model/article_model.dart';
import '../../providers/bookmark_provider.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  const ArticlePage({super.key, required this.article});

  // Helper to open the full article URL
  Future<void> _openFullArticle(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF5FA8A3); // Project brand color
    final bookmarkProvider = context.watch<BookmarkProvider>(); //
    final isSaved = bookmarkProvider.isBookmarked(article); //
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. DYNAMIC COLLAPSING HEADER
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            stretch: true,
            backgroundColor: primaryColor,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.3),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
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
                    onPressed: () => bookmarkProvider.toggleBookmark(article), //
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: article.url, // Hero animation link
                child: (article.imageUrl ?? '').isNotEmpty
                    ? Image.network(
                  article.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
                )
                    : Container(color: primaryColor),
              ),
            ),
          ),

          // 2. ARTICLE CONTENT SECTION
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
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            article.source!.toUpperCase(),
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      if (article.publishedAt != null)
                        Text(
                          "${article.publishedAt!.day}/${article.publishedAt!.month}/${article.publishedAt!.year}",
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Headline
                  Text(
                    article.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Body Description
                  Text(
                    article.description ?? '',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[800],
                      height: 1.6,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Snippet Content
                  if (article.content != null)
                    Text(
                      article.content!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        height: 1.8,
                      ),
                    ),

                  const SizedBox(height: 120), // Padding for the bottom FAB
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. READ FULL STORY BUTTON
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () => _openFullArticle(article.url),
        icon: const Icon(Icons.open_in_new, color: Colors.white),
        label: const Text(
          "READ FULL STORY",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}