import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/news_provider.dart';
import '../../data/model/article_model.dart';

class CategoryArticlesPage extends StatefulWidget {
  final String category;
  const CategoryArticlesPage({super.key, required this.category});

  @override
  State<CategoryArticlesPage> createState() => _CategoryArticlesPageState();
}

class _CategoryArticlesPageState extends State<CategoryArticlesPage> {
  @override
  void initState() {
    super.initState();
    // Fetch news specifically for this category on init
    Future.microtask(() {
      context.read<NewsProvider>().fetchByCategory(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();
    final articles = provider.articles;
    const primaryColor = Color(0xFF5FA8A3);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        // Capitalize the first letter of the category for the title
        title: Text(
          widget.category[0].toUpperCase() + widget.category.substring(1),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () {
            // This checks if there is a page to go back to
            if (context.canPop()) {
              context.pop();
            } else {
              // If the user refreshed the browser or entered the URL directly
              context.go('/home');
            }
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator(color: primaryColor))
            : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return _ArticleCard(article: article, primaryColor: primaryColor);
          },
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Article article;
  final Color primaryColor;

  const _ArticleCard({required this.article, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.push('/article', extra: article),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image with Hero Transition
              Hero(
                tag: article.url,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: (article.imageUrl ?? '').isNotEmpty
                      ? Image.network(
                    article.imageUrl!,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholder(),
                  )
                      : _buildPlaceholder(),
                ),
              ),
              // 2. Article Text Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (article.source != null)
                      Text(
                        article.source!.toUpperCase(),
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (article.description != null)
                      Text(
                        article.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: 180,
      color: Colors.grey[200],
      child: const Icon(Icons.image_outlined, color: Colors.grey, size: 40),
    );
  }
}