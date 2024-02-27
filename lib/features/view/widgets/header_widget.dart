import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_navigator/features/controllers/theme_provider.dart';
import 'package:whatsapp_navigator/features/controllers/theme_provider_state.dart';

class HeaderWidget extends ConsumerWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text("WhatsApp Navigator"),
      actions: [
        IconButton(
          onPressed: () {
            ref.read(themeSwitcherProvider.notifier).toggleTheme();
          },
          icon: Icon(
            ref.watch(themeSwitcherProvider).themeSwitch == ThemeSwitch.dark
                ? Icons.brightness_4_sharp
                : Icons.brightness_5,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
