import 'package:allevents_pro/core/config/app_router.dart';
import 'package:flutter/material.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/data/models/events_model.dart';
import 'package:allevents_pro/data/repositories/event_repository.dart';
import 'package:allevents_pro/shared/custom_snackbar.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();

  // Original list of events
  List<EventModel> _originalEvents = [];
  
  // Filtered list of events for search
  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  // Other existing properties remain the same
  bool _isEventsLoading = false;
  bool get isEventsLoading => _isEventsLoading;

  String? _eventError;
  String? get eventError => _eventError;

  bool _isGridView = false;
  bool get isGridView => _isGridView;

  bool _isSearchStarted = false;
  bool get isSearchStarted => _isSearchStarted;

  // New method to search events
  void searchEvents(String query) {
    if (query.isEmpty) {
      // If query is empty, restore original events
      _events = List.from(_originalEvents);
      _isSearchStarted = false;
    } else {
      _isSearchStarted = true;
      // Filter events based on event name or location
      _events = _originalEvents.where((event) {
        final nameLower = event.eventName.toLowerCase();
        final locationLower = event.location.toLowerCase();
        final queryLower = query.toLowerCase();
        
        return nameLower.contains(queryLower) || 
               locationLower.contains(queryLower);
      }).toList();
    }
    notifyListeners();
  }

  // Modify existing fetchEventsByCategory to store original events
  Future<void> fetchEventsByCategory(
    BuildContext context,
    CategoryModel category,
  ) async {
    try {
      _isEventsLoading = true;
      _eventError = null;
      notifyListeners();

      final fetchedEvents = await _eventRepository.getEventsByCategory(
        category.data,
      );

      // Store original and current events
      _originalEvents = fetchedEvents;
      _events = List.from(_originalEvents);

    } catch (e) {
      _eventError = e.toString();
      CustomSnackbar.show(
        context,
        message: 'Failed to load events: $e',
        type: SnackBarType.error,
      );
    } finally {
      _isEventsLoading = false;
      notifyListeners();
    }
  }

  // Other existing methods remain the same
  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void navigateToEventDetails(BuildContext context, EventModel event) {
    try {
      router.pushNamed('event_details', extra: event);
    } catch (e) {
      CustomSnackbar.show(
        context,
        message: 'Failed to navigate to event details',
        type: SnackBarType.error,
      );
    }
  }

  Future<void> refreshEvents(
    BuildContext context,
    CategoryModel category,
  ) async {
    await fetchEventsByCategory(context, category);
  }
}
