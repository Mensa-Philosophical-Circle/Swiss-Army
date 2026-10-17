import 'package:phone_numbers_parser/phone_numbers_parser.dart' as pnp;

/// A phone number with its country code (+2348051234567), split the way a phone field wants it, and checked against
/// the real numbering plan of its country (libphonenumber's rules, the same ones most APIs use).
class PhoneParts {
  const PhoneParts({required this.isoCode, required this.dialCode, required this.national});

  /// The country's ISO code (NG), for a country picker.
  final String isoCode;

  /// The country code with its plus (+234).
  final String dialCode;

  /// The number without the country code: what is typed in the field.
  final String national;

  String get full => '$dialCode$national';

  /// Splits [full] into its country and the number. A number that is not complete still splits, by its country code.
  /// With no country code to go by, the number is taken whole under [fallbackIso] (Nigeria by default).
  factory PhoneParts.parse(String full, {String fallbackIso = 'NG', String fallbackDialCode = '+234'}) {
    final text = full.trim();
    if (text.startsWith('+')) {
      try {
        final n = pnp.PhoneNumber.parse(text);
        return PhoneParts(isoCode: n.isoCode.name, dialCode: '+${n.countryCode}', national: n.nsn);
      } catch (_) {
        // Falls through: not a number that can be split.
      }
    }
    return PhoneParts(isoCode: fallbackIso, dialCode: fallbackDialCode, national: text.replaceAll(RegExp(r'\D'), ''));
  }

  /// Whether [full] (country code included) is a real number for its country. A number can have a plausible length and
  /// still not exist: +23491438433443 has one digit too many for Nigeria.
  static bool isValid(String full) {
    final text = full.trim();
    if (!text.startsWith('+')) return false;
    try {
      return pnp.PhoneNumber.parse(text).isValid();
    } catch (_) {
      return false;
    }
  }
}
