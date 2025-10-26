
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoliday_assignment/model/portfolio_model.dart';
import 'package:yoliday_assignment/utils/app_colors.dart';

class PortfolioCard extends StatelessWidget {
  final PortfolioItem item;

  const PortfolioCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.cardBorder, width: 1.0),
          boxShadow: [
            BoxShadow(
              // Using a slightly more transparent black to approximate the shadow in the design
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left: Image Placeholder
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
              child: Container(
                width: 120.w,
                height: 110.h,
                color: Colors.grey[200], // Placeholder background
                child: (item.imageUrl.isNotEmpty)
                    ? Image.asset(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Icon(Icons.photo_size_select_actual_outlined, color: Colors.grey),
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.photo_size_select_actual_outlined, color: Colors.grey),
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            // Center: Text Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: AppColors.darkText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.category,
                      style: TextStyle(
                        color: AppColors.lightText,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      item.author,
                      style: TextStyle(
                        color: AppColors.lightText,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right: Grade Badge
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, right: 12.w,bottom: 16.h),
                child: Container(
                  width: 50.w,
                  height: 26.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color.fromRGBO(243, 149, 25, 1),Color.fromRGBO(255, 205, 103, 1)],),
                    // color:Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      item.grade,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
