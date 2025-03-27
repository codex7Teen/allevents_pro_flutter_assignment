import 'package:allevents_pro/core/config/app_router.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/data/models/events_model.dart';
import 'package:allevents_pro/data/repositories/event_repository.dart';
import 'package:allevents_pro/shared/custom_snackbar.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();

  // List to store events
  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  // Loading state for events
  bool _isEventsLoading = false;
  bool get isEventsLoading => _isEventsLoading;

  // Error state
  String? _eventError;
  String? get eventError => _eventError;

  // View mode (list or grid)
  bool _isGridView = false;
  bool get isGridView => _isGridView;

  // Toggle view mode
  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  // Fetch events method
  Future<void> fetchEventsByCategory(
    BuildContext context, 
    CategoryModel category
  ) async {
    try {
      // Set loading state to true
      _isEventsLoading = true;
      _eventError = null;
      notifyListeners();

      // Fetch events from repository
      final fetchedEvents = await _eventRepository.getEventsByCategory(category.data);

      // Update events
      _events = fetchedEvents;

      // Optional: Show success message
      CustomSnackbar.show(
        context,
        message: 'Events loaded successfully',
        type: SnackBarType.success,
      );
    } catch (e) {
      // Set error state
      _eventError = e.toString();

      // Show error snackbar
      CustomSnackbar.show(
        context,
        message: 'Failed to load events: $e',
        type: SnackBarType.error,
      );
    } finally {
      // Set loading state to false
      _isEventsLoading = false;
      notifyListeners();
    }
  }

  // Method to open event details
  void navigateToEventDetails(BuildContext context, EventModel event) {
    try {
      // Example navigation - adjust based on your app's routing
      router.pushNamed('event_details', extra: event);
    } catch (e) {
      CustomSnackbar.show(
        context,
        message: 'Failed to navigate to event details',
        type: SnackBarType.error,
      );
    }
  }

  // Method to refresh events
  Future<void> refreshEvents(BuildContext context, CategoryModel category) async {
    await fetchEventsByCategory(context, category);
  }
}