// Event Repository - Handles fetching events data
import 'package:allevents_pro/data/models/events_model.dart';
import 'package:allevents_pro/data/services/event_services.dart';

class EventRepository {
  final EventService _eventService =
      EventService(); // Instance of event service

  /// Fetches events based on the given category URL
  Future<List<EventModel>> getEventsByCategory(String categoryUrl) async {
    return await _eventService.fetchEventsByCategory(categoryUrl);
  }
}
