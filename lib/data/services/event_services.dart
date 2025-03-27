import 'package:allevents_pro/data/models/events_model.dart';
import 'package:dio/dio.dart';

class EventService {
  final Dio _dio = Dio();

  //! Fetch Events by Category
  Future<List<EventModel>> fetchEventsByCategory(String categoryUrl) async {
    try {
      final response = await _dio.get(categoryUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> eventItems = responseData['item'] ?? [];

        return EventModel.fromJsonList(eventItems);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Invalid request");
      } else if (response.statusCode == 404) {
        throw Exception("Not Found: The requested resource was not found");
      } else {
        throw Exception(
          "Failed to load events. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error fetching events: $e");
    }
  }
}
