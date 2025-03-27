import 'package:allevents_pro/data/models/events_model.dart';
import 'package:allevents_pro/data/services/event_services.dart';

class EventRepository {
  final EventService _eventService = EventService();

  Future<List<EventModel>> getEventsByCategory(String categoryUrl) async {
    return await _eventService.fetchEventsByCategory(categoryUrl);
  }
}