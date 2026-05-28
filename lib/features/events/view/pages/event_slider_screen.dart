import 'dart:async';
import 'package:engineers_syndicate_project/features/events/view/widgets/event_card_widget.dart';
import 'package:engineers_syndicate_project/features/events/view%20model/event_cubit.dart';
import 'package:engineers_syndicate_project/features/events/view%20model/events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsSliderScreen extends StatefulWidget {
  const EventsSliderScreen({super.key});

  @override
  State<EventsSliderScreen> createState() => _EventsSliderScreenState();
}

class _EventsSliderScreenState extends State<EventsSliderScreen> {
  late final theme = Theme.of(context);
  final PageController _pageController = PageController(
    viewportFraction: 0.78,
    initialPage: 0,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;

      final cubit = context.read<EventsCubit>();
      if (cubit.state is EventsLoaded) {
        final currentState = cubit.state as EventsLoaded;
        final totalEvents = currentState.events.length;

        if (totalEvents <= 1) return;

        int nextIndex = currentState.currentIndex + 1;

        if (nextIndex >= totalEvents) {
          nextIndex = 0;
        }

        if (_pageController.hasClients) {
          if (nextIndex == 0) {
            _pageController.jumpToPage(0);
          } else {
            _pageController.animateToPage(
              nextIndex,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventsInitial || state is EventsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is EventsLoaded) {
          if (state.events.isEmpty) return const SizedBox.shrink();

          int indicatorCount = state.events.length > 3
              ? 3
              : state.events.length;
          int activeIndicatorIndex = state.currentIndex % indicatorCount;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: screenHeight * 0.25,
                width: screenWidth * 0.9,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: state.events.length,
                  onPageChanged: (index) {
                    context.read<EventsCubit>().updateIndex(index);
                  },
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 0.0;

                        if (_pageController.hasClients &&
                            _pageController.position.haveDimensions) {
                          double currentPage =
                              (_pageController.page ??
                                      _pageController.initialPage)
                                  .toDouble();
                          value = currentPage - index;
                          value = value.abs();
                        } else {
                          value = (index == 0) ? 0.0 : 1.0;
                        }
                        double scale = (1 - (value * 0.1)).clamp(0.85, 1.0);
                        double opacity = (1 - (value * 0.5)).clamp(0.6, 1.0);

                        return Transform.scale(
                          scale: scale,
                          child: Opacity(opacity: opacity, child: child),
                        );
                      },
                      child: EventCardWidget(event: state.events[index]),
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(indicatorCount, (index) {
                  final isSelected = activeIndicatorIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                    ),
                    height: screenHeight * 0.01,
                    width: isSelected ? screenWidth * 0.04 : screenWidth * 0.02,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(screenWidth * 0.01),
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.grey.withOpacity(0.4),
                    ),
                  );
                }),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
