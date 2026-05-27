import 'package:engineers_syndicate_project/features/events/data/model/event_model.dart';
import 'package:engineers_syndicate_project/features/events/data/service/events_services.dart';
import 'package:engineers_syndicate_project/features/events/view%20model/events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventsServices _eventsServices = EventsServices();

  List<EventModel> events = [];

  EventsCubit() : super(const EventsInitial());

  void loadEvents() async {
    emit(EventsLoading());
    try {
      events = await _eventsServices.getEvents();
      emit(EventsLoaded(events: events, currentIndex: 0));
    } catch (e) {
      print("Error fetching events: $e");
    }
  }

  void updateIndex(int index) {
    if (state is EventsLoaded) {
      emit(EventsLoaded(events: events, currentIndex: index));
    }
  }
}
