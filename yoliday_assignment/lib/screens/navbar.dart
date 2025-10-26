
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yoliday_assignment/utils/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define the items for the bottom navigation bar
    final List<_NavBarItem> items = [
      _NavBarItem(
        iconPath: 'assets/icons/home.png', // Placeholder for Home Icon
        label: 'Home',
        index: 0,
      ),
      _NavBarItem(
        iconPath: 'assets/icons/portfolio.png', // Placeholder for Portfolio Icon
        label: 'Portfolio',
        index: 1,
      ),
      _NavBarItem(
        iconPath: 'assets/icons/input.png', // Placeholder for Input Icon
        label: 'Input',
        index: 2,
      ),
      _NavBarItem(
        iconPath: 'assets/icons/profile.png', // Placeholder for Profile Icon
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
          final Color color = isSelected ? AppColors.primaryOrange : AppColors.inactiveIcon;

          return InkWell(
            onTap: () => onTap(item.index),
            child: SizedBox(
              height: 70.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Indicator Container
                  Container(
                    height: 3.h,
                    width: isSelected ? 30.w : 0,
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryOrange : Colors.transparent,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(5.r),
                      ),
                    ),
                  ),
                  // Custom Image Icon (Tinted with ColorFiltered)
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      color, // Applies the selected/inactive color
                      BlendMode.srcIn, // Tints the asset image
                    ),
                    child: Image.asset(
                      item.iconPath,
                      width: 18.sp, // Responsive size for the image icon
                      height: 20.sp, // Responsive size for the image icon
                      errorBuilder: (context, error, stackTrace) {
                        // IMPORTANT: Fallback to standard Flutter icons if asset is missing or fails to load
                        IconData fallbackIcon = Icons.error;
                        if (item.index == 0) fallbackIcon = Icons.home;
                        if (item.index == 1) fallbackIcon = Icons.work;
                        if (item.index == 2) fallbackIcon = Icons.add_box_outlined;
                        if (item.index == 3) fallbackIcon = Icons.person;

                        return Icon(
                          fallbackIcon,
                          size: 20.sp,
                          color: color, 
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Label
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: color,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
class _NavBarItem {
  // Changed from IconData icon to String iconPath
  final String iconPath;
  final String label;
  final int index;

  _NavBarItem({required this.iconPath, required this.label, required this.index});
}