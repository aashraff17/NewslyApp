import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';
import '../article/article_page.dart';

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
    Future.microtask(() {
      context.read<NewsProvider>().fetchByCategory(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final articles = provider.articles;

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (_, index) {
        final article = articles[index];

        if (article.imageUrl == null || article.imageUrl!.isEmpty) {
          return const SizedBox(); // removes no-image news ✅
        }

        return ListTile(
          leading: Image.network(
            article.imageUrl!,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const SizedBox(),
          ),
          title: Text(article.title),
          subtitle: Text(article.description ?? ''),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArticlePage(article: article),
              ),
            );
          },
        );
      },
    );
  }
}
