import 'package:flutter_test/flutter_test.dart';
import 'package:go2point/data/mock_routes.dart';
import 'package:go2point/models/trip_route.dart';

void main() {
  test('Every trip ID resolves uniquely to its own data', () {
    expect(mockRoutes.map((trip) => trip.id).toSet().length, mockRoutes.length);
    expect(findMockRoute(2)!.destination, 'Budapest, Hungary');
    expect(findMockRoute(4)!.destination, 'Bucharest, Romania');
    expect(findMockRoute(999), isNull);
    expect(findMockRoute(-1), isNull);
    expect(mockAlternativeRoutes[1], same(mockSavedRoutes.first));
  });

  test('Trip prices are consistent across the lists and details', () {
    expect(mockAlternativeRoutes.map((trip) => trip.totalPrice), [
      398,
      575,
      860,
    ]);
    expect(mockSavedRoutes.map((trip) => trip.totalPrice), [
      575,
      310,
      690,
      520,
    ]);
    expect(findMockRoute(2)!.isWithinBudget, isTrue);
    expect(findMockRoute(3)!.isWithinBudget, isFalse);
  });

  test('Every trip supplies the editor with complete steps and dates', () {
    for (final trip in mockRoutes) {
      expect(trip.steps.length, 6);
      expect(trip.hotel.kind, TripStepKind.hotel);
      expect(trip.event.kind, TripStepKind.event);
      expect(trip.stepOfKind(TripStepKind.transfer).from, contains(trip.city));
      expect(trip.eventDate.isBefore(trip.arrivalDate), isFalse);
      expect(trip.eventDate.isAfter(trip.departureDate), isFalse);
    }
  });
}
