class NewsCategory {
  final String label;
  final String apiValue;
  final String emoji;

  const NewsCategory({
    required this.label,
    required this.apiValue,
    required this.emoji,
  });
}

const List<NewsCategory> newsCategories = [
  NewsCategory(label: 'Sports', apiValue: 'sports', emoji: '🏈'),
  NewsCategory(label: 'Politics', apiValue: 'nation', emoji: '🏛️'),
  NewsCategory(label: 'Business', apiValue: 'business', emoji: '💼'),
  NewsCategory(label: 'Technology', apiValue: 'technology', emoji: '💻'),
  NewsCategory(label: 'Health', apiValue: 'health', emoji: '🩺'),
  NewsCategory(label: 'Entertainment', apiValue: 'entertainment', emoji: '🎬'),
  NewsCategory(label: 'Science', apiValue: 'science', emoji: '🔬'),
  NewsCategory(label: 'World', apiValue: 'world', emoji: '🌍'),
];