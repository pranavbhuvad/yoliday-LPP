import 'package:flutter/material.dart';
import 'package:yoliday_assignment/model/portfolio_model.dart';

class PortfolioProvider with ChangeNotifier {
  
  final List<PortfolioItem> _allPortfolioItems = [
    PortfolioItem(
      title: "Kemampuan Merangkum Tulisan",
      category: "BAHASA SUNDA",
      author: "Oleh Al-Baiqi Samaan",
      grade: "A",
      imageUrl: "assets/images/1.png", 
    ),
    PortfolioItem(
      title: "Pengembangan Karakter Kepemimpinan",
      category: "BAHASA SUNDA",
      author: "Oleh Al-Baiqi Samaan",
      grade: "A",
      imageUrl: "assets/images/2.png", // Placeholder URL
    ),
    PortfolioItem(
      title: "Analisis Struktur Puisi",
      category: "BAHASA INGGRIS",
      author: "Oleh Budi Utomo",
      grade: "B",
      imageUrl: "assets/images/3.png", // Placeholder URL
    ),
    PortfolioItem(
      title: "Proyek Pembuatan Website Portofolio",
      category: "TEKNOLOGI",
      author: "Oleh Candra Wijaya",
      grade: "A",
      imageUrl: "assets/images/4.png", // Placeholder URL
    ),
    PortfolioItem(
      title: "Studi Kasus Perubahan Iklim Global",
      category: "GEOGRAFI",
      author: "Oleh Dewi Sartika",
      grade: "A",
      imageUrl: "assets/images/1.png", // Placeholder URL
    ),
    PortfolioItem(
      title: "Perancangan Basis Data MySQL",
      category: "TEKNOLOGI",
      author: "Oleh Eka Putra",
      grade: "A",
      imageUrl: "assets/images/2.png", // Placeholder URL
    ),
  ];

  List<PortfolioItem> _filteredItems = [];
  String _searchQuery = '';

  PortfolioProvider() {
    _filteredItems = _allPortfolioItems;
  }

  List<PortfolioItem> get filteredItems => _filteredItems;
  String get searchQuery => _searchQuery;

  void filterItems(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredItems = _allPortfolioItems;
    } else {
      _filteredItems = _allPortfolioItems
          .where((item) => item.title.toLowerCase().contains(_searchQuery))
          .toList();
    }
    notifyListeners();
  }
}