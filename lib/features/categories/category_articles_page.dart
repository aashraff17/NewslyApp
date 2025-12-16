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
    final articles = provider.articles;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          return ListTile(
            leading: (article.imageUrl ?? '').isNotEmpty
                ? Image.network(
              article.imageUrl!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            )
                : const SizedBox(width: 80, height: 80),
            title: Text(article.title ?? ''),
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
      ),
    );
  }


}
