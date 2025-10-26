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

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1.0,
              color: AppColors.lightText.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.zero,
              labelColor: AppColors.searchIconColor,
              unselectedLabelColor: AppColors.lightText,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 3.h,
                  color: AppColors.searchIconColor,
                ),
                insets: EdgeInsets.zero,
              ),
              tabs: [
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

  Widget _buildTabItem(String text, {bool isFirst = false}) {
    return Tab(
      child: Padding(
        padding: EdgeInsets.only(
          left: isFirst ? 16.w : 16.w,
          right: 16.w,
        ),
        child: Text(
          text,
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
              'assets/images/shopping bag.png',
              width: 24.sp,
              height: 24.sp,
              color: AppColors.darkOrange,
              errorBuilder: (context, error, stackTrace) => FaIcon(
                FontAwesomeIcons.bagShopping,
                color: AppColors.darkText,
                size: 24.sp,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/notifications.png',
              width: 24.sp,
              height: 24.sp,
              color: AppColors.darkOrange,
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
          child: Padding(
            padding: EdgeInsets.zero,
            child: _buildCustomTabBar(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPortfolioList(context),
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

  Widget _buildPortfolioList(BuildContext context) {
    final filteredItems = context.watch<PortfolioProvider>().filteredItems;

    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
              SliverToBoxAdapter(
                child: SizedBox(height: 100.h),
              ),
            ],
          ),
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

  Widget _buildSearchBar(BuildContext context) {
    final portfolioProvider = context.read<PortfolioProvider>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border:
            Border.all(color: AppColors.lightText.withOpacity(0.3), width: 1.0),
      ),
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: portfolioProvider.filterItems,
              decoration: InputDecoration(
                hintText: 'Search a project',
                hintStyle: TextStyle(
                  color: AppColors.lightText,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              ),
            ),
          ),
          //
          Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              color: AppColors.searchIconColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 20.sp,
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
            size: 14,
          ),
          SizedBox(width: 8),
          Text(
            'Filter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
