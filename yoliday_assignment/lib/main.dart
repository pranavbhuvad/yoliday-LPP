import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yoliday_assignment/controllers/navigation_provider.dart';
import 'package:yoliday_assignment/controllers/portfolio_provider.dart';
import 'package:yoliday_assignment/screens/first_screen.dart';
import 'package:yoliday_assignment/utils/app_colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
      designSize: const Size(375, 812), 
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NavigationProvider()),
            ChangeNotifierProvider(create: (_) => PortfolioProvider()),
          ],
          child: MaterialApp(
            title: 'Portfolio App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              
              fontFamily: 'Roboto', 
            ),
            home: child,
          ),
        );
      },
      child: const RootScreen(),
    );
  }
}
