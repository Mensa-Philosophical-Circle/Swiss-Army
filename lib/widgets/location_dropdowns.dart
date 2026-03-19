import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/material.dart';
import 'package:swiss_army_component/data/nigeria_data.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

/// A dropdown to select a Country.
class CountryDropdown extends StatefulWidget {
  const CountryDropdown({
    super.key,
    required this.onChanged,
    this.value,
    this.label = 'Country',
    this.hint = 'Select Country',
    this.fieldStyle = TextFieldStyle.outlined,
    this.height,
  });

  final ValueChanged<csc.Country?> onChanged;
  final csc.Country? value;
  final String label;
  final String hint;
  final TextFieldStyle fieldStyle;

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  late Future<List<csc.Country>> _countriesFuture;

  @override
  void initState() {
    super.initState();
    _countriesFuture = csc.getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<csc.Country>>(
      future: _countriesFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final countries = snapshot.data ?? [];

        return AppDropdown<csc.Country>(
          label: widget.label,
          hint: widget.hint,
          value: widget.value,
          isLoading: isLoading,
          fieldStyle: widget.fieldStyle,
          items: countries.map((csc.Country country) {
            return DropdownMenuItem<csc.Country>(
              value: country,
              child: Text(country.name),
            );
          }).toList(),
          onChanged: widget.onChanged,
        );
      },
    );
  }
}

class StateDropdown extends StatefulWidget {
  const StateDropdown({
    super.key,
    required this.country,
    required this.onChanged,
    this.value,
    this.label = 'State / Region',
    this.hint = 'Select State',
    this.fieldStyle = TextFieldStyle.outlined,
    this.height,
  });

  final csc.Country? country;
  final ValueChanged<csc.State?> onChanged;
  final csc.State? value;
  final String label;
  final String hint;
  final TextFieldStyle fieldStyle;

  @override
  State<StateDropdown> createState() => _StateDropdownState();
}

class _StateDropdownState extends State<StateDropdown> {
  late Future<List<csc.State>> _statesFuture;

  @override
  void initState() {
    super.initState();
    _updateStates();
  }

  @override
  void didUpdateWidget(covariant StateDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.country != widget.country) {
      _updateStates();
    }
  }

  void _updateStates() {
    if (widget.country != null) {
      if (widget.country!.isoCode == 'NG') {
        _statesFuture = Future.value(NigeriaData.getStates());
      } else {
        _statesFuture = csc.getStatesOfCountry(widget.country!.isoCode);
      }
    } else {
      _statesFuture = Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<csc.State>>(
      future: _statesFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final states = snapshot.data ?? [];
        final bool isDisabled = widget.country == null || states.isEmpty;

        return AppDropdown<csc.State>(
          label: widget.label,
          hint: widget.country == null
              ? 'Select Country First'
              : (states.isEmpty && !isLoading
                    ? 'No states found'
                    : widget.hint),
          value: widget.value,
          isLoading: isLoading,
          enabled: !isDisabled,
          fieldStyle: widget.fieldStyle,
          items: states.map((csc.State state) {
            return DropdownMenuItem<csc.State>(
              value: state,
              child: Text(state.name),
            );
          }).toList(),
          onChanged: widget.onChanged,
        );
      },
    );
  }
}

class CityDropdown extends StatefulWidget {
  const CityDropdown({
    super.key,
    required this.country,
    required this.state,
    required this.onChanged,
    this.value,
    this.label = 'City / LGA',
    this.hint = 'Select City',
    this.fieldStyle = TextFieldStyle.outlined,
    this.height,
  });

  final csc.Country? country;
  final csc.State? state;
  final ValueChanged<csc.City?> onChanged;
  final csc.City? value;
  final String label;
  final String hint;
  final TextFieldStyle fieldStyle;

  @override
  State<CityDropdown> createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  late Future<List<csc.City>> _citiesFuture;

  @override
  void initState() {
    super.initState();
    _updateCities();
  }

  @override
  void didUpdateWidget(covariant CityDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.country != widget.country ||
        oldWidget.state != widget.state) {
      _updateCities();
    }
  }

  void _updateCities() {
    if (widget.country != null && widget.state != null) {
      if (widget.country!.isoCode == 'NG') {
        _citiesFuture = Future.value(
          NigeriaData.getLgas(widget.state!.isoCode),
        );
      } else {
        _citiesFuture = csc.getStateCities(
          widget.country!.isoCode,
          widget.state!.isoCode,
        );
      }
    } else {
      _citiesFuture = Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<csc.City>>(
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final cities = snapshot.data ?? [];
        final bool isDisabled =
            widget.country == null || widget.state == null || cities.isEmpty;

        // Custom label logic: If user wants "LGA", they pass label='LGA'.
        // We just display the list of cities/districts provided by the package.

        return AppDropdown<csc.City>(
          label: widget.label,
          hint: (widget.country == null || widget.state == null)
              ? 'Select State First'
              : (cities.isEmpty && !isLoading
                    ? 'No cities found'
                    : widget.hint),
          value: widget.value,
          isLoading: isLoading,
          enabled: !isDisabled,
          fieldStyle: widget.fieldStyle,
          items: cities.map((csc.City city) {
            return DropdownMenuItem<csc.City>(
              value: city,
              child: Text(city.name),
            );
          }).toList(),
          onChanged: widget.onChanged,
        );
      },
      future: _citiesFuture,
    );
  }
}
