enum TripRouteCategory { cheapest, balanced, luxury }

enum TripStepKind {
  flight,
  train,
  transfer,
  hotel,
  event,
  localTransport,
  returnTransfer,
}

class TripStep {
  final TripStepKind kind;
  final String title;
  final String from;
  final String to;
  final double price;

  const TripStep({
    required this.kind,
    required this.title,
    required this.from,
    required this.to,
    required this.price,
  });

  String get description => '$from → $to';
}

class TripRoute {
  final int id;
  final String city;
  final String country;
  final DateTime arrivalDate;
  final DateTime departureDate;
  final DateTime eventDate;
  final TripRouteCategory category;
  final String title;
  final String travelTime;
  final String transportChain;
  final String transfers;
  final String hotelInfo;
  final double budget;
  final bool isRecommended;
  final List<TripStep> steps;

  TripRoute({
    required this.id,
    required this.city,
    required this.country,
    required this.arrivalDate,
    required this.departureDate,
    required this.eventDate,
    required this.category,
    required this.title,
    required this.travelTime,
    required this.transportChain,
    required this.transfers,
    required this.hotelInfo,
    required List<TripStep> steps,
    this.budget = 600,
    this.isRecommended = false,
  }) : steps = List.unmodifiable(steps);

  String get destination => '$city, $country';
  String get dateRange =>
      '${formatTripDate(arrivalDate)} — ${formatTripDate(departureDate)}';
  double get totalPrice => steps.fold(0, (total, step) => total + step.price);
  bool get isWithinBudget => totalPrice <= budget;
  TripStep get outbound => steps.first;
  TripStep get hotel => stepOfKind(TripStepKind.hotel);
  TripStep get event => stepOfKind(TripStepKind.event);

  TripStep stepOfKind(TripStepKind kind) =>
      steps.firstWhere((step) => step.kind == kind);

  String get budgetDifference {
    final difference = totalPrice - budget;
    if (difference == 0) return 'Matches your ${formatEuro(budget)} budget';
    return '${formatEuro(difference.abs())} '
        '${difference < 0 ? 'under' : 'over'} your ${formatEuro(budget)} budget';
  }
}

String formatTripDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/'
    '${date.month.toString().padLeft(2, '0')}/${date.year}';

String formatTripPrice(double price) => price == price.roundToDouble()
    ? price.toStringAsFixed(0)
    : price.toStringAsFixed(2);

String formatEuro(double price) => '€${formatTripPrice(price)}';
