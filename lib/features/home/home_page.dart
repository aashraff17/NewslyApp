import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';
import '../../core/constants/categories.dart';
import '../../core/constants/countries.dart';
import '../../providers/bookmark_provider.dart';
import 'article_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<NewsProvider>().fetchNews(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = context.watch<NewsProvider>();
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFF5FA8A3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Browse'),
        actions: [
          // Country dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: newsProvider.selectedCountry,
              dropdownColor: const Color(0xFF5FA8A3),
              icon: const Icon(Icons.public, color: Colors.white),
              items: countries.map((c) {
                return DropdownMenuItem(
                  value: c.code,
                  child: Text(
                    c.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  newsProvider.changeCountry(value);
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: newsCategories.map((cat) {
                final isSelected =
                    newsProvider.selectedCategory == cat.apiValue;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text('${cat.emoji} ${cat.label}'),
                    selected: isSelected,
                    onSelected: (_) {
                      newsProvider.changeCategory(cat.apiValue);
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),

          // News list / grid
          Expanded(
            child: newsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : isWide
                ? GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: newsProvider.articles.length,
              itemBuilder: (_, index) {
                return _NewsCard(
                    article: newsProvider.articles[index]);
              },
            )
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: newsProvider.articles.length,
              itemBuilder: (_, index) {
                return _NewsCard(
                    article: newsProvider.articles[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final article;

  const _NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final isSaved = bookmarkProvider.isBookmarked(article);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticlePage(article: article),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl.isNotEmpty)
              Image.network(
                article.imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          bookmarkProvider.toggleBookmark(article);
                        },
                        icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
