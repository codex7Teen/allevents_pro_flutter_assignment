import 'package:intl/intl.dart';

class EventModel {
  final String eventId;
  final String eventName;
  final String thumbUrl;
  final String largeThumbUrl;
  final int startTime;
  final int endTime;
  final String location;
  final Venue venue;
  final String eventUrl;
  final String bannerUrl;
  final List<String> categories;
  final TicketInfo tickets;

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.thumbUrl,
    required this.largeThumbUrl,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.venue,
    required this.eventUrl,
    required this.bannerUrl,
    required this.categories,
    required this.tickets,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: _parseString(json['event_id']),
      eventName: _parseString(json['eventname']),
      thumbUrl: _parseString(json['thumb_url']),
      largeThumbUrl: _parseString(json['thumb_url_large']),
      startTime: _parseInteger(json['start_time']),
      endTime: _parseInteger(json['end_time']),
      location: _parseString(json['location']),
      venue: Venue.fromJson(json['venue'] ?? {}),
      eventUrl: _parseString(json['event_url']),
      bannerUrl: _parseString(json['banner_url']),
      categories: _parseStringList(json['categories']),
      tickets: TicketInfo.fromJson(json['tickets'] ?? {}),
    );
  }

  // Utility method to safely parse strings
  static String _parseString(dynamic value) {
    return value?.toString() ?? '';
  }

  // Utility method to safely parse integers
  static int _parseInteger(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // Utility method to safely parse string lists
  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((item) => item?.toString() ?? '').toList();
    }
    return [];
  }

  // Convert timestamp to readable date
  String get formattedStartDate {
    return DateFormat(
      'EEE, MMM d, yyyy',
    ).format(DateTime.fromMillisecondsSinceEpoch(startTime * 1000));
  }

  // Convert timestamp to readable time
  String get formattedStartTime {
    return DateFormat(
      'h:mm a',
    ).format(DateTime.fromMillisecondsSinceEpoch(startTime * 1000));
  }

  static List<EventModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EventModel.fromJson(json)).toList();
  }
}

class Venue {
  final String street;
  final String city;
  final String state;
  final String country;
  final double latitude;
  final double longitude;
  final String fullAddress;

  Venue({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      street: _parseString(json['street']),
      city: _parseString(json['city']),
      state: _parseString(json['state']),
      country: _parseString(json['country']),
      latitude: _parseDouble(json['latitude']),
      longitude: _parseDouble(json['longitude']),
      fullAddress: _parseString(json['full_address']),
    );
  }

  // Utility method to safely parse doubles
  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static String _parseString(dynamic value) {
    return value?.toString() ?? '';
  }
}

class TicketInfo {
  final bool hasTickets;
  final String ticketUrl;
  final String ticketCurrency;
  final double minTicketPrice;
  final double maxTicketPrice;

  TicketInfo({
    required this.hasTickets,
    required this.ticketUrl,
    required this.ticketCurrency,
    required this.minTicketPrice,
    required this.maxTicketPrice,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) {
    return TicketInfo(
      hasTickets: _parseBool(json['has_tickets']),
      ticketUrl: _parseString(json['ticket_url']),
      ticketCurrency: _parseString(json['ticket_currency']),
      minTicketPrice: _parseDouble(json['min_ticket_price']),
      maxTicketPrice: _parseDouble(json['max_ticket_price']),
    );
  }

  // Utility method to safely parse doubles
  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  // Utility method to safely parse strings
  static String _parseString(dynamic value) {
    return value?.toString() ?? '';
  }

  // Utility method to safely parse booleans
  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }
}
