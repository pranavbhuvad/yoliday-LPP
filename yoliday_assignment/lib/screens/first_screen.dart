
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoliday_assignment/controllers/navigation_provider.dart';
import 'package:yoliday_assignment/screens/navbar.dart';
import 'package:yoliday_assignment/screens/portfolio_screen.dart';

class RootScreen extends StatelessWidget {
   const RootScreen({super.key});

  final List<Widget> _pages = const [
    // 0: Home Tab
    Scaffold(body: Center(child: Text('Home Screen'))),
    // 1: Portfolio Tab
    PortfolioPage(),
    // 2: Input Tab
    Scaffold(body: Center(child: Text('Input Screen'))),
    // 3: Profile Tab
    Scaffold(body: Center(child: Text('Profile Screen'))),
  ];

  @override
  Widget build(BuildContext context) {
    
    final currentIndex = context.watch<NavigationProvider>().currentIndex;

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        
        onTap: (index) => context.read<NavigationProvider>().setIndex(index),
      ),
    );
  }
}