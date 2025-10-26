
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yoliday_assignment/controllers/portfolio_provider.dart';
import 'package:yoliday_assignment/screens/portfolio_card.dart';
import 'package:yoliday_assignment/utils/app_colors.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}


class _PortfolioPageState extends State<PortfolioPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildCustomTabBar() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          // 1. Full-width light gray divider line at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1.0,
              color: AppColors.lightText.withOpacity(0.3), // Light gray line
            ),
          ),
          // 2. The actual TabBar
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 8.h), // Vertical padding
            child: TabBar(
              controller: _tabController,
              // FIX 1: Set to true for scrollable behavior (like the image)
              isScrollable: true,
              
              // FIX 2: Set labelPadding to zero, we control spacing inside _buildTabItem
              labelPadding: EdgeInsets.zero,
              
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.zero,
              
              // --- TabBar Styling Updates ---
              labelColor: AppColors.searchIconColor, // Active tab text color (Red/Orange)
              unselectedLabelColor: AppColors.lightText, // Inactive tab text color (Gray)
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 3.h,
                  color: AppColors.searchIconColor, // Match indicator color to active text
                ),
                // Removed the insets property to make the indicator flush with the tab text
                insets: EdgeInsets.zero,
              ),
              tabs: [
                // FIX 3: Pass 'isFirst: true' to the first tab
                _buildTabItem('Project', isFirst: true),
                _buildTabItem('Saved'),
                _buildTabItem('Shared'),
                _buildTabItem('Achievement'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // FIX: Added isFirst parameter to control padding
  Widget _buildTabItem(String text, {bool isFirst = false}) {
    return Tab(
      // FIX 3 (continued): Wrap child in Padding to manually control spacing
      child: Padding(
        padding: EdgeInsets.only(
          // If it's the first tab, no left padding (flush left). Otherwise, 16.w indent.
          left: isFirst ? 16.w : 16.w, // Changed to 16.w for consistency if scrollable. Let's make the first tab flush left, so 0.
          
          // All tabs get 16.w right padding (this creates the space between tabs)
          right: 16.w,
        ),
        child: Text(
          text,
          // FIX: Restored the style for the tab text
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16.w,
        // Ensure the app bar title uses the same font style as the body if possible
        title: Text(
          'Portfolio',
          style: TextStyle(
            color: AppColors.darkText,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/shopping bag.png', // Replace with your actual asset path
              width: 24.sp,
              height: 24.sp,
              color: AppColors.darkOrange,
              // Fallback for demonstration if asset isn't available
              errorBuilder: (context, error, stackTrace) => FaIcon(
                FontAwesomeIcons.bagShopping,
                color: AppColors.darkText,
                size: 24.sp,
              ),
            ),
          ),
          // Changed from FaIcon to Image.asset for the Bell/Notification icon
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/notifications.png', // Replace with your actual asset path
              width: 24.sp,
              height: 24.sp,
              color: AppColors.darkOrange,
              // Fallback for demonstration if asset isn't available
              errorBuilder: (context, error, stackTrace) => FaIcon(
                FontAwesomeIcons.bell,
                color: AppColors.darkText,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          // FIX: Wrap the custom tab bar with Padding(padding: EdgeInsets.zero)
          // to remove the default horizontal padding applied by AppBar to its bottom widget.
          child: Padding(
            padding: EdgeInsets.zero,
            child: _buildCustomTabBar(),
          ),
        ),
      ),
      body: Column(
        children: [
          // TabBar View, currently only Portfolio (Index 0) has content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPortfolioList(context), // Project Tab
                const Center(child: Text('Saved ')),
                const Center(child: Text('Shared ')),
                const Center(child: Text('Achievement ')),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Context is required to watch the PortfolioProvider
  Widget _buildPortfolioList(BuildContext context) {
    // Watch the filtered items list from the provider
    final filteredItems = context.watch<PortfolioProvider>().filteredItems;

    return SafeArea(
      child: Stack(
        children: [
          // List of Cards (Scrollable)
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  // Pass context to search bar to allow it to read/write to provider
                  child: _buildSearchBar(context), 
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: PortfolioCard(item: filteredItems[index]),
                    );
                  },
                ),
              ),
              // Padding for the filter button
              SliverToBoxAdapter(
                child: SizedBox(height: 100.h),
              ),
            ],
          ),
          // Filter Button (Fixed at the bottom)
          Positioned(
            bottom: 10.h,
            left: 0,
            right: 0,
            child: Center(
              child: _buildFilterButton(),
            ),
          ),
        ],
      ),
    );
  }

  // Context is required to call the filter function on the provider
  Widget _buildSearchBar(BuildContext context) {
    // Read the provider to get access to the filterItems method
    final portfolioProvider = context.read<PortfolioProvider>();

    return Container(
      decoration: BoxDecoration(
        // Set background to white and add a subtle border for the outline shown in the image
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.lightText.withOpacity(0.3), width: 1.0),
      ),
      // Removed outer left padding
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              // Call the provider's filter method on text change
              onChanged: portfolioProvider.filterItems,
              decoration: InputDecoration(
                hintText: 'Search a project',
                hintStyle: TextStyle(
                  color: AppColors.lightText,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                // Removed prefixIcon, as the icon is now only in the button on the right
                // Add padding on left for text alignment and on right for gap before button
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              ),
            ),
          ),
          // Search Button (Red/Orange)
          Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              color: AppColors.searchIconColor,
              // Keep the radius only on the right to blend with the outer container
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 20.sp, // Slightly reduced icon size for a cleaner look
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildFilterButton() {
    return Container(
      width: 104.w,
      height: 34.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.darkOrange,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.filter,
            color: Colors.white,
            size: 14, // Using raw size for clarity without screenutil here
          ),
          SizedBox(width: 8),
          Text(
            'Filter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14, // Using raw size for clarity without screenutil here
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}