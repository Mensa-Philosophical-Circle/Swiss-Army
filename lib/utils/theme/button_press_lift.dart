import 'package:flutter/material.dart';

/// `ElevatedButton.styleFrom` lifts a button by 6 while it is pressed, even at
/// `elevation: 0`, which draws a shadow under a button that is being held.
extension ButtonPressLift on ButtonStyle {
  /// This style with the same elevation whether the button is pressed or not.
  /// A style with no elevation of its own is left for the theme to decide.
  ButtonStyle withoutPressLift() {
    final resting = elevation?.resolve(const <WidgetState>{});
    if (resting == null) return this;
    return copyWith(
      elevation: WidgetStateProperty.fromMap(<WidgetStatesConstraint, double>{
        WidgetState.disabled: 0,
        WidgetState.any: resting,
      }),
    );
  }
}
