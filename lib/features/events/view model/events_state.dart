import 'package:engineers_syndicate_project/features/events/model/event_model.dart';

abstract class EventsState {
  final int currentIndex;
  const EventsState(this.currentIndex);
}

class EventsInitial extends EventsState {
  const EventsInitial() : super(0);
}

class EventsLoading extends EventsState {
  const EventsLoading() : super(0);
}

class EventsLoaded extends EventsState {
  final List<EventModel> events;
  const EventsLoaded({required this.events, required int currentIndex}) 
      : super(currentIndex);
}

class EventsError extends EventsState {
  final String message;
  const EventsError({required this.message, required int currentIndex}) 
      : super(currentIndex);
}