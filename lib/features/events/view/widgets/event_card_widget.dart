import 'package:engineers_syndicate_project/features/events/data/model/event_model.dart';
import 'package:flutter/material.dart';

class EventCardWidget extends StatelessWidget {
  final EventModel event;
  const EventCardWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(0.08),
            blurRadius: screenWidth * 0.025,
            offset: Offset(0, screenHeight * 0.005),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(screenWidth * 0.04),
                ),
                child: Image.asset(
                  'assets/images/test.png',
                  height: screenHeight * 0.13,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: screenHeight * 0.13,
                      child: Icon(Icons.image, size: screenWidth * 0.12),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.03,
                ),
                child: Column(
                  children: [
                    Text(
                      event.eventTitle!,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Text(
                      event.startTimestamp!,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.primaryContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
