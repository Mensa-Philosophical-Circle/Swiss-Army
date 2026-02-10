import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiss_army_component/data/nigeria_data.dart'; // Import custom data

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Check Custom Nigeria Data correctness', () async {
    // 1. Check Country exists in standard package (we still use standard country list)
    final countries = await csc.getAllCountries();
    countries.firstWhere(
      (c) => c.name.toLowerCase() == 'nigeria',
      orElse: () => throw Exception('Nigeria not found'),
    );
    
    // 2. Verify NigeriaData States
    final customStates = NigeriaData.getStates();
    if (customStates.isEmpty) {
      throw Exception('Custom NigeriaData returned no states!');
    }
    

    // 3. Verify LGAs for Lagos
    final lagosValues = customStates.where(
      (s) => s.name.contains('Lagos') && s.isoCode == 'LA',
    );
    if (lagosValues.isEmpty) {
      throw Exception('Lagos state not found in custom data');
    }
    final lagos = lagosValues.first;

   
    final lgas = NigeriaData.getLgas(lagos.isoCode);
    if (lgas.length != 20) {
      if (kDebugMode) {
        print('WARNING: Expected 20 LGAs, found ${lgas.length}');
      }
      // List found to debug
      if (kDebugMode) {
        print('LGAs Found: ${lgas.map((c) => c.name).join(', ')}');
      }
      if (lgas.length < 10) {
        if (kDebugMode) {
          print('WARNING: Expected 20 LGAs, found ${lgas.length}');
        }
        throw Exception('Too few LGAs found, data likely incorrect.');
      }
    }

    // Check for Alimosho (key indicator of correct data)
    final hasAlimosho = lgas.any((c) => c.name == 'Alimosho');
    if (hasAlimosho) {
      if (kDebugMode) {
        print('SUCCESS: Alimosho LGA found!');
      }
    } else {
      throw Exception('FAILURE: Alimosho LGA missing from custom data!');
    }

    // Check for FCT Area Councils?
    final fctValues = customStates.where(
      (s) =>
          s.name.contains('Federal Capital Territory') ||
          s.name.contains('Abuja'),
    );
    if (fctValues.isNotEmpty) {
      final fct = fctValues.first;
      final fctLgas = NigeriaData.getLgas(fct.isoCode);
      if (kDebugMode) {
        print('FCT Area Councils found: ${fctLgas.length} (Expected 6)');
      }
      if (fctLgas.length != 6) {
        if (kDebugMode) {
          print('WARNING: Expected 6 FCT councils, found ${fctLgas.length}');
        }
        // List found to debug
        if (kDebugMode) {
          print('FCT Councils: ${fctLgas.map((c) => c.name).join(', ')}');
        }
        if (fctLgas.length < 10) {
          if (kDebugMode) {
            print('WARNING: Expected 6 FCT councils, found ${fctLgas.length}');
          }
          throw Exception('Too few FCT councils found, data likely incorrect.');
        }
      }
    }
  });
}
