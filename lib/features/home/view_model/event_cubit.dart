import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:engineers_syndicate_project/features/home/data/event_model.dart';
import 'package:engineers_syndicate_project/features/home/view_model/events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(const EventsInitial());

  final List<EventModel> _mockEvents = [
    EventModel(
      title: 'حفل ذكرى التحرير',
      date: '8 ديسمبر - 7 مساءً',
      imageUrl: 'assets/images/logo.png',
    ),
    EventModel(
      title: 'حفل افتتاح المعرض',
      date: '9 ديسمبر - 5 مساءً',
      imageUrl: 'assets/images/logo.png',
    ),
    EventModel(
      title: 'ندوة حوارية ثقافية',
      date: '10 ديسمبر - 6 مساءً',
      imageUrl: 'assets/images/logo.png',
    ),
  ];

  void loadEvents() {
    emit(EventsLoaded(events: _mockEvents, currentIndex: 0));
  }

  void updateIndex(int index) {
    if (state is EventsLoaded) {
      emit(EventsLoaded(events: _mockEvents, currentIndex: index));
    }
  }
}
