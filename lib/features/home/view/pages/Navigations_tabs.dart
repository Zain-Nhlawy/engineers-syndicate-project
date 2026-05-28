import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engineers_syndicate_project/features/home/view_model/navigation_tabs_cubit.dart';
import 'package:engineers_syndicate_project/features/home/view_model/navigation_tabs_state.dart';

class NavigationsTabs extends StatelessWidget {
  const NavigationsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return BlocProvider(
      create: (context) => NavigationTabsCubit(),
      child: BlocBuilder<NavigationTabsCubit, NavigationTabsState>(
        builder: (context, state) {
          final cubit = context.read<NavigationTabsCubit>();

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(screenHeight * 0.08),
              child: AppBar(
                centerTitle: true,
                backgroundColor: theme.colorScheme.surface,
                leadingWidth: 0,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: screenHeight * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Flexible(
                      child: Text(
                        'نقابة المهندسين السوريين',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.secondary,
                          width: 0.8,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          size: screenWidth * 0.065,
                        ),
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                      screenWidth * 0.55,
                      screenHeight * 0.015,
                    ),
                  ),
                ),
              ),
            ),
            extendBody: true,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: const Color(0xFFEDEBE0).withOpacity(0.90),
                  ),
                ),
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                PageView(
                  controller: cubit.pageController,
                  children: cubit.pages,
                  onPageChanged: (index) {
                    cubit.updateIndex(index);
                  },
                ),
              ],
            ),
            bottomNavigationBar: _buildModernNavBar(
              theme,
              state,
              cubit,
              screenWidth,
              screenHeight,
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernNavBar(
    ThemeData theme,
    NavigationTabsState state,
    NavigationTabsCubit cubit,
    double screenWidth,
    double screenHeight,
  ) {
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.085,
          vertical: screenHeight * 0.01,
        ),
        height: screenHeight * 0.09,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildNavItem(
                icon: Icons.home_outlined,
                index: 0,
                theme: theme,
                state: state,
                cubit: cubit,
                sideWord: "الرئيسية",
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.maps_home_work_outlined,
                index: 1,
                theme: theme,
                state: state,
                cubit: cubit,
                sideWord: "الأبنية",
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.bookmark_outline,
                index: 2,
                theme: theme,
                state: state,
                cubit: cubit,
                sideWord: "حجوزاتي",
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.person_outline,
                index: 3,
                theme: theme,
                state: state,
                cubit: cubit,
                sideWord: "ملفي",
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required ThemeData theme,
    required NavigationTabsState state,
    required NavigationTabsCubit cubit,
    required String sideWord,
    required double screenWidth,
    required double screenHeight,
  }) {
    final isActive = state.currentIndex == index;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => cubit.changePage(index),
            borderRadius: BorderRadius.circular(32),
            splashColor: colorScheme.primary.withOpacity(0.1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              width: screenWidth * 0.125,
              decoration: BoxDecoration(
                color: isActive
                    ? colorScheme.primaryContainer
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(
                icon,
                size: screenWidth * 0.06,
                color: isActive
                    ? colorScheme.surface
                    : colorScheme.surface.withOpacity(0.9),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.002),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              sideWord,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: isActive
                    ? colorScheme.surface
                    : colorScheme.surface.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
