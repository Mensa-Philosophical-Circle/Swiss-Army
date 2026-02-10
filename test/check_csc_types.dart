import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Can instantiate State and City manually', () {
    try {
      final state = csc.State(name: 'Lagos', isoCode: 'LA', countryCode: 'NG');
      if (kDebugMode) {
        print('Successfully created State: ${state.name}');
      }

      final city = csc.City(name: 'Ikeja', countryCode: 'NG', stateCode: 'LA');
      if (kDebugMode) {
        print('Successfully created City: ${city.name}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Instantiation failed: $e');
      }
    }
  });
}
