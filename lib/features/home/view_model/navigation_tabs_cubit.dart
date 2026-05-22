import 'package:engineers_syndicate_project/features/buildings/view/pages/buildings_screen.dart';
import 'package:engineers_syndicate_project/features/home/view/pages/home_screen.dart';
import 'package:engineers_syndicate_project/features/home/view_model/navigation_tabs_state.dart';
import 'package:engineers_syndicate_project/features/profile/view/pages/my_profile_screen.dart';
import 'package:engineers_syndicate_project/features/reservation/view/pages/my_reservation_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationTabsCubit extends Cubit<NavigationTabsState> {
  NavigationTabsCubit() : super(const NavigationTabsState(0));

  final PageController pageController = PageController();

  final pages = [
    HomeScreen(),
    BuildingsScreen(),
    MyReservationScreen(),
    MyProfileScreen(),
  ];

  void changePage(int index) {
    final int pageDifference = (state.currentIndex - index).abs();
    emit(NavigationTabsState(index));

    if (pageDifference == 1) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      pageController.jumpToPage(index);
    }
  }

  void updateIndex(int index) {
    emit(NavigationTabsState(index));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
