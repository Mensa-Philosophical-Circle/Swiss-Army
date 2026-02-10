// OTP Security Features Test

import 'package:flutter_test/flutter_test.dart';
import 'package:swiss_army_component/utils/utils.dart';

void main() {
  setUp(() {
    // Reset to defaults before each test
    OTPSecurityConfig.resetToDefaults();
    OTPSecurityConfig.enableSecurityLogging = false;
  });

  group('OTP Security Config Defaults', () {
    test('OTP security is OFF by default', () {
      expect(OTPSecurityConfig.enforceValidation, false);
    });

    test('Default limits are set correctly', () {
      expect(OTPSecurityConfig.maxOTPLength, 10);
      expect(OTPSecurityConfig.minOTPLength, 4);
      expect(OTPSecurityConfig.maxPinSize, 100.0);
      expect(OTPSecurityConfig.minPinSize, 30.0);
      expect(OTPSecurityConfig.maxFontSize, 48.0);
      expect(OTPSecurityConfig.minFontSize, 12.0);
    });
  });

  group('Security OFF - Values Pass Through', () {
    test('validateOTPLength returns original value when security OFF', () {
      final result = validateOTPLength(20, defaultValue: 6);
      expect(result, 20);
    });

    test('validatePinSize returns original value when security OFF', () {
      final result = validatePinSize(500.0, defaultValue: 56.0);
      expect(result, 500.0);
    });

    test('validateOTPFontSize returns original value when security OFF', () {
      final result = validateOTPFontSize(100.0, defaultValue: 20.0);
      expect(result, 100.0);
    });

    test('validateOTPBorderWidth returns original value when security OFF', () {
      final result = validateOTPBorderWidth(10.0, defaultValue: 1.5);
      expect(result, 10.0);
    });

    test(
      'validateOTPBorderRadius returns original value when security OFF',
      () {
        final result = validateOTPBorderRadius(200.0, defaultValue: 12.0);
        expect(result, 200.0);
      },
    );

    test('validateOTPSpacing returns original value when security OFF', () {
      final result = validateOTPSpacing(100.0, defaultValue: 4.0);
      expect(result, 100.0);
    });
  });

  group('Security ON - Values Validated', () {
    setUp(() {
      OTPSecurityConfig.enableSecurity();
    });

    test('validateOTPLength clamps to max when security ON', () {
      final result = validateOTPLength(20, defaultValue: 6);
      expect(result, OTPSecurityConfig.maxOTPLength);
    });

    test('validateOTPLength clamps to min when security ON', () {
      final result = validateOTPLength(2, defaultValue: 6);
      expect(result, OTPSecurityConfig.minOTPLength);
    });

    test('validatePinSize clamps to max when security ON', () {
      final result = validatePinSize(500.0, defaultValue: 56.0);
      expect(result, OTPSecurityConfig.maxPinSize);
    });

    test('validatePinSize clamps to min when security ON', () {
      final result = validatePinSize(10.0, defaultValue: 56.0);
      expect(result, OTPSecurityConfig.minPinSize);
    });

    test('validateOTPFontSize clamps to max when security ON', () {
      final result = validateOTPFontSize(100.0, defaultValue: 20.0);
      expect(result, OTPSecurityConfig.maxFontSize);
    });

    test('validateOTPFontSize clamps to min when security ON', () {
      final result = validateOTPFontSize(5.0, defaultValue: 20.0);
      expect(result, OTPSecurityConfig.minFontSize);
    });

    test('validateOTPBorderWidth clamps to max when security ON', () {
      final result = validateOTPBorderWidth(10.0, defaultValue: 1.5);
      expect(result, OTPSecurityConfig.maxBorderWidth);
    });

    test('validateOTPBorderWidth prevents negative values', () {
      final result = validateOTPBorderWidth(-5.0, defaultValue: 1.5);
      expect(result, 0);
    });

    test('validateOTPBorderRadius clamps to max when security ON', () {
      final result = validateOTPBorderRadius(200.0, defaultValue: 12.0);
      expect(result, OTPSecurityConfig.maxBorderRadius);
    });

    test('validateOTPBorderRadius prevents negative values', () {
      final result = validateOTPBorderRadius(-10.0, defaultValue: 12.0);
      expect(result, 0);
    });

    test('validateOTPSpacing clamps to max when security ON', () {
      final result = validateOTPSpacing(100.0, defaultValue: 4.0);
      expect(result, OTPSecurityConfig.maxSpacing);
    });

    test('validateOTPSpacing prevents negative values', () {
      final result = validateOTPSpacing(-5.0, defaultValue: 4.0);
      expect(result, 0);
    });
  });

  group('Per-Widget Override', () {
    test('enableSecurity=false overrides global ON setting', () {
      OTPSecurityConfig.enableSecurity();
      expect(OTPSecurityConfig.enforceValidation, true);

      // Per-widget override should bypass validation
      final result = validateOTPLength(
        20,
        defaultValue: 6,
        enableSecurity: false,
      );
      expect(result, 20); // Not clamped
    });

    test('enableSecurity=true overrides global OFF setting', () {
      expect(OTPSecurityConfig.enforceValidation, false);

      // Per-widget override should enforce validation
      final result = validateOTPLength(
        20,
        defaultValue: 6,
        enableSecurity: true,
      );
      expect(result, OTPSecurityConfig.maxOTPLength); // Clamped
    });

    test('enableSecurity=true for pinSize overrides global OFF', () {
      expect(OTPSecurityConfig.enforceValidation, false);

      final result = validatePinSize(
        500.0,
        defaultValue: 56.0,
        enableSecurity: true,
      );
      expect(result, OTPSecurityConfig.maxPinSize);
    });
  });

  group('Input Sanitization', () {
    test('sanitizeOTP removes non-digits for numeric OTP', () {
      final result = '12a3b4c5'.sanitizeOTP();
      expect(result, '12345');
    });

    test('sanitizeOTP removes special characters', () {
      final result = '12-34-56'.sanitizeOTP();
      expect(result, '123456');
    });

    test('sanitizeOTP handles empty string', () {
      final result = ''.sanitizeOTP();
      expect(result, '');
    });

    test('sanitizeOTP alphanumeric mode keeps letters', () {
      final result = 'AB12CD'.sanitizeOTP(numericOnly: false);
      expect(result, 'AB12CD');
    });

    test('sanitizeOTP alphanumeric mode removes special chars', () {
      final result = 'AB-12@CD!'.sanitizeOTP(numericOnly: false);
      expect(result, 'AB12CD');
    });
  });

  group('Custom Limits', () {
    setUp(() {
      OTPSecurityConfig.enableSecurity();
    });

    test('Custom maxOTPLength is respected', () {
      OTPSecurityConfig.maxOTPLength = 8;
      final result = validateOTPLength(12, defaultValue: 6);
      expect(result, 8);
    });

    test('Custom maxPinSize is respected', () {
      OTPSecurityConfig.maxPinSize = 80.0;
      final result = validatePinSize(100.0, defaultValue: 56.0);
      expect(result, 80.0);
    });

    test('Custom maxFontSize is respected', () {
      OTPSecurityConfig.maxFontSize = 32.0;
      final result = validateOTPFontSize(50.0, defaultValue: 20.0);
      expect(result, 32.0);
    });
  });

  group('Enable/Disable Methods', () {
    test('enableSecurity() sets enforceValidation to true', () {
      expect(OTPSecurityConfig.enforceValidation, false);
      OTPSecurityConfig.enableSecurity();
      expect(OTPSecurityConfig.enforceValidation, true);
    });

    test('disableSecurity() sets enforceValidation to false', () {
      OTPSecurityConfig.enableSecurity();
      expect(OTPSecurityConfig.enforceValidation, true);
      OTPSecurityConfig.disableSecurity();
      expect(OTPSecurityConfig.enforceValidation, false);
    });

    test('resetToDefaults() restores all default values', () {
      OTPSecurityConfig.enableSecurity();
      OTPSecurityConfig.maxOTPLength = 20;
      OTPSecurityConfig.maxPinSize = 200.0;

      OTPSecurityConfig.resetToDefaults();

      expect(OTPSecurityConfig.enforceValidation, false);
      expect(OTPSecurityConfig.maxOTPLength, 10);
      expect(OTPSecurityConfig.maxPinSize, 100.0);
    });
  });

  group('OTP Attempt Tracker', () {
    test('allows attempts within limit', () {
      final tracker = OTPAttemptTracker(maxAttempts: 3);

      expect(tracker.recordAttempt(), true);
      expect(tracker.attempts, 1);
      expect(tracker.recordAttempt(), true);
      expect(tracker.attempts, 2);
    });

    test('locks out after max attempts', () {
      final tracker = OTPAttemptTracker(maxAttempts: 3);

      tracker.recordAttempt();
      tracker.recordAttempt();
      expect(tracker.recordAttempt(), false); // 3rd attempt triggers lockout

      expect(tracker.isLockedOut, true);
    });

    test('resetAttempts clears count and lockout', () {
      final tracker = OTPAttemptTracker(maxAttempts: 2);

      tracker.recordAttempt();
      tracker.recordAttempt(); // Triggers lockout

      expect(tracker.isLockedOut, true);

      tracker.resetAttempts();

      expect(tracker.isLockedOut, false);
      expect(tracker.attempts, 0);
    });

    test('clearLockout removes lockout', () {
      final tracker = OTPAttemptTracker(maxAttempts: 1);

      tracker.recordAttempt(); // Triggers lockout
      expect(tracker.isLockedOut, true);

      tracker.clearLockout();
      expect(tracker.isLockedOut, false);
    });

    test('remainingLockout returns correct duration', () {
      final tracker = OTPAttemptTracker(
        maxAttempts: 1,
        lockoutDuration: const Duration(seconds: 60),
      );

      tracker.recordAttempt(); // Triggers lockout

      final remaining = tracker.remainingLockout;
      expect(remaining.inSeconds, greaterThan(55));
      expect(remaining.inSeconds, lessThanOrEqualTo(60));
    });

    test('maxAttempts 0 means no limit', () {
      final tracker = OTPAttemptTracker(maxAttempts: 0);

      // Should allow unlimited attempts
      for (int i = 0; i < 100; i++) {
        expect(tracker.recordAttempt(), true);
      }
      expect(tracker.isLockedOut, false);
    });
  });

  group('Safe Callbacks', () {
    test('safeOTPCallback executes without crashing', () {
      String? capturedValue;
      safeOTPCallback(
        (value) {
          capturedValue = value;
        },
        '123456',
        context: 'test',
      );

      expect(capturedValue, '123456');
    });

    test('safeOTPCallback handles null callback', () {
      expect(() => safeOTPCallback(null, '123456'), returnsNormally);
    });

    test('safeOTPCallback catches errors', () {
      OTPSecurityConfig.enableSecurityLogging = false;
      expect(
        () => safeOTPCallback(
          (value) {
            throw Exception('Test error');
          },
          '123456',
          context: 'test',
        ),
        returnsNormally,
      );
      OTPSecurityConfig.enableSecurityLogging = true;
    });

    test('safeOTPVoidCallback executes without crashing', () {
      bool called = false;
      safeOTPVoidCallback(() {
        called = true;
      }, context: 'test');

      expect(called, true);
    });

    test('safeOTPVoidCallback handles null callback', () {
      expect(() => safeOTPVoidCallback(null), returnsNormally);
    });
  });

  group('Default Values', () {
    test('validateOTPLength returns default when null', () {
      final result = validateOTPLength(null, defaultValue: 6);
      expect(result, 6);
    });

    test('validatePinSize returns default when null', () {
      final result = validatePinSize(null, defaultValue: 56.0);
      expect(result, 56.0);
    });

    test('validateOTPFontSize returns default when null', () {
      final result = validateOTPFontSize(null, defaultValue: 20.0);
      expect(result, 20.0);
    });

    test('validateOTPBorderWidth returns default when null', () {
      final result = validateOTPBorderWidth(null, defaultValue: 1.5);
      expect(result, 1.5);
    });

    test('validateOTPBorderRadius returns default when null', () {
      final result = validateOTPBorderRadius(null, defaultValue: 12.0);
      expect(result, 12.0);
    });

    test('validateOTPSpacing returns default when null', () {
      final result = validateOTPSpacing(null, defaultValue: 4.0);
      expect(result, 4.0);
    });
  });
}
