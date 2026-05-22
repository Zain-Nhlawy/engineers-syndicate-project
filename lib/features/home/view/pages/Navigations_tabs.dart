import 'package:engineers_syndicate_project/features/home/view_model/navigation_tabs_cubit.dart';
import 'package:engineers_syndicate_project/features/home/view_model/navigation_tabs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationsTabs extends StatelessWidget {
  const NavigationsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => NavigationTabsCubit(),
      child: BlocBuilder<NavigationTabsCubit, NavigationTabsState>(
        builder: (context, state) {
          final cubit = context.read<NavigationTabsCubit>();

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                centerTitle: true,
                title: Row(
                  children: [
                    Image.asset('assets/images/logo.png', height: 50),
                    const SizedBox(width: 15),
                    Text(
                      'نقابة المهندسين السوريين',
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 25),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 0.8,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications, size: 28),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(250, 12),
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
            bottomNavigationBar: _buildModernNavBar(theme, state, cubit),
          );
        },
      ),
    );
  }

  Widget _buildModernNavBar(
    ThemeData theme,
    NavigationTabsState state,
    NavigationTabsCubit cubit,
  ) {
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        height: 80,
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
  }) {
    final isActive = state.currentIndex == index;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: 60,
              decoration: BoxDecoration(
                color: isActive
                    ? colorScheme.primaryContainer
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(
                icon,
                size: 32,
                color: isActive
                    ? colorScheme.surface
                    : colorScheme.surface.withOpacity(0.9),
              ),
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              sideWord,
              style: TextStyle(
                fontSize: 14,
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
