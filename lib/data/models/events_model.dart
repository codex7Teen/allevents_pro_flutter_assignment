import 'package:intl/intl.dart';

class EventModel {
  final String eventId; // Unique event identifier
  final String eventName; // Event name
  final String thumbUrl; // Thumbnail image URL
  final String largeThumbUrl; // Large thumbnail URL
  final int startTime; // Event start time (Unix timestamp)
  final int endTime; // Event end time (Unix timestamp)
  final String location; // Event location
  final Venue venue; // Venue details
  final String eventUrl; // URL to event details
  final String bannerUrl; // Event banner image
  final List<String> categories; // List of event categories
  final TicketInfo tickets; // Ticket information

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

  //! F A C T O R Y   C O N S T R U C T O R
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

  //! U T I L I T Y   M E T H O D S   F O R   D A T A   P A R S I N G
  static String _parseString(dynamic value) {
    return value?.toString() ?? '';
  }

  static int _parseInteger(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((item) => item?.toString() ?? '').toList();
    }
    return [];
  }

  //! F O R M A T   D A T E   &   T I M E
  String get formattedStartDate {
    return DateFormat(
      'EEE, MMM d, yyyy',
    ).format(DateTime.fromMillisecondsSinceEpoch(startTime * 1000));
  }

  String get formattedStartTime {
    return DateFormat(
      'h:mm a',
    ).format(DateTime.fromMillisecondsSinceEpoch(startTime * 1000));
  }

  //! C O N V E R T   J S O N   L I S T   T O   M O D E L   L I S T
  static List<EventModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EventModel.fromJson(json)).toList();
  }
}

class Venue {
  final String street; // Street address
  final String city; // City name
  final String state; // State name
  final String country; // Country name
  final double latitude; // Latitude coordinate
  final double longitude; // Longitude coordinate
  final String fullAddress; // Full venue address

  Venue({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
  });

  //! F A C T O R Y   C O N S T R U C T O R
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

  //! U T I L I T Y   M E T H O D S   F O R   D A T A   P A R S I N G
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
  final bool hasTickets; // Availability of tickets
  final String ticketUrl; // Ticket purchase URL
  final String ticketCurrency; // Currency type
  final double minTicketPrice; // Minimum ticket price
  final double maxTicketPrice; // Maximum ticket price

  TicketInfo({
    required this.hasTickets,
    required this.ticketUrl,
    required this.ticketCurrency,
    required this.minTicketPrice,
    required this.maxTicketPrice,
  });

  //! F A C T O R Y   C O N S T R U C T O R
  factory TicketInfo.fromJson(Map<String, dynamic> json) {
    return TicketInfo(
      hasTickets: _parseBool(json['has_tickets']),
      ticketUrl: _parseString(json['ticket_url']),
      ticketCurrency: _parseString(json['ticket_currency']),
      minTicketPrice: _parseDouble(json['min_ticket_price']),
      maxTicketPrice: _parseDouble(json['max_ticket_price']),
    );
  }

  //! U T I L I T Y   M E T H O D S   F O R   D A T A   P A R S I N G
  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static String _parseString(dynamic value) {
    return value?.toString() ?? '';
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }
}
