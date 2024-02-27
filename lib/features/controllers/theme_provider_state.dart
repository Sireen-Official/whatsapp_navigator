import 'package:flutter/material.dart';

enum ThemeSwitch { light, dark }

class ThemeProviderState {
  final ThemeData theme;
  final ThemeSwitch themeSwitch;
  ThemeProviderState({
    required this.theme,
    required this.themeSwitch,
  });

  ThemeProviderState copyWith({
    ThemeData? theme,
    ThemeSwitch? themeSwitch,
  }) {
    return ThemeProviderState(
      theme: theme ?? this.theme,
      themeSwitch: themeSwitch ?? this.themeSwitch,
    );
  }
}
