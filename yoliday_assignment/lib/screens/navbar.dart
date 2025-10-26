import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yoliday_assignment/utils/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key, // Corrected super.key usage
    required this.currentIndex,
    required this.onTap,
  });

  // Define the common duration for all transitions
  static const Duration _animationDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    
    final List<_NavBarItem> items = [
      _NavBarItem(
        iconPath: 'assets/Home svg.png',
        label: 'Home',
        index: 0,
      ),
      _NavBarItem(
        iconPath: 'assets/Portfolia svg.png', 
        label: 'Portfolio',
        index: 1,
      ),
      _NavBarItem(
        iconPath: 'assets/Input svg.png', 
        label: 'Input',
        index: 2,
      ),
      _NavBarItem(
        iconPath: 'assets/Profile svg.png', 
        label: 'Profile',
        index: 3,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      height: 70.h + MediaQuery.of(context).padding.bottom,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          final bool isSelected = item.index == currentIndex;
          // Define target and inactive colors, as used in the original logic
          final Color targetColor = AppColors.primaryOrange;
          final Color inactiveColor = AppColors.inactiveIcon;

          return Expanded(
            child: InkWell(
              onTap: () => onTap(item.index),
              child: SizedBox(
                height: 70.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Indicator Container (Now Animated)
                    AnimatedContainer(
                      duration: _animationDuration,
                      curve: Curves.easeOut,
                      height: 3.h,
                      // Animate width from 0 to 30.w
                      width: isSelected ? 30.w : 0, 
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryOrange : Colors.transparent,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(5.r),
                        ),
                      ),
                    ),
                    
                    // Icon and Text Color (Now Animated)
                    TweenAnimationBuilder<Color?>(
                      // Tween between the inactive color and the selected color
                      tween: ColorTween(begin: inactiveColor, end: isSelected ? targetColor : inactiveColor),
                      duration: _animationDuration,
                      builder: (context, color, child) {
                        return Column(
                          children: [
                            // Custom Image Icon wrapped in ColorFiltered
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                color!, // Use the animated color for the filter
                                BlendMode.srcIn, 
                              ),
                              child: Image.asset(
                                item.iconPath,
                                width: 18.sp, 
                                height: 20.sp, 
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback Icon logic remains the same
                                  IconData fallbackIcon = Icons.error;
                                  if (item.index == 0) fallbackIcon = Icons.home;
                                  if (item.index == 1) fallbackIcon = Icons.work;
                                  if (item.index == 2) fallbackIcon = Icons.add_box_outlined;
                                  if (item.index == 3) fallbackIcon = Icons.person;

                                  return Icon(
                                    fallbackIcon,
                                    size: 20.sp,
                                    color: color, // Use the animated color for the fallback icon
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 4.h),
                            
                            // Text
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: color, // Use the animated color for the text
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
class _NavBarItem {
  
  final String iconPath;
  final String label;
  final int index;

  _NavBarItem({required this.iconPath, required this.label, required this.index});
}