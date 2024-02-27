import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatsapp_navigator/features/controllers/theme_provider_state.dart';

part 'theme_provider.g.dart';

final _lightTheme = ThemeData.light(useMaterial3: true);
final _darkTheme = ThemeData.dark(useMaterial3: true);

@riverpod
class ThemeSwitcher extends _$ThemeSwitcher {
  @override
  ThemeProviderState build() {
    return ThemeProviderState(
      theme: _darkTheme,
      themeSwitch: ThemeSwitch.dark,
    );
  }

  void toggleTheme() {
    state = state.themeSwitch == ThemeSwitch.dark
        ? state.copyWith(
            theme: _lightTheme,
            themeSwitch: ThemeSwitch.light,
          )
        : state.copyWith(
            theme: _darkTheme,
            themeSwitch: ThemeSwitch.dark,
          );
  }
}
