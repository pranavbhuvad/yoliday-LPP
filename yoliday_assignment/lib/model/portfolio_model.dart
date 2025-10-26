
// Data model for a portfolio card
class PortfolioItem {
  final String title;
  final String category;
  final String author;
  final String grade;
  final String imageUrl;

  PortfolioItem({
    required this.title,
    required this.category,
    required this.author,
    required this.grade,
    required this.imageUrl,
  });
}