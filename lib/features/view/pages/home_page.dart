import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_navigator/features/view/widgets/header_widget.dart';

import '../widgets/phone_number_field_widget.dart';

final selectedCountryCode = StateProvider<String>((ref) {
  return '+91';
});

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final number = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const HeaderWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: PhoneNumberField(
                  number: number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number is empty";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () async {
                  // final url =
                  //     "whatsapp://send?phone=${ref.watch(selectedCountryCode).replaceAll("+", '')}${number.text}";
                  if (formKey.currentState!.validate()) {
                    final chatUrl =
                        "https://wa.me/${ref.watch(selectedCountryCode).replaceAll("+", '')}${number.text}";
                    try {
                      launchUrl(
                        Uri.parse(chatUrl),
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Could not launch WhatsApp"),
                          ),
                        );
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Open in WhatsApp App"),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final url =
                        "https://web.whatsapp.com/send?phone=${ref.watch(selectedCountryCode).replaceAll("+", '')}${number.text}";
                    try {
                      launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.inAppBrowserView,
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Could not launch WhatsApp"),
                          ),
                        );
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Open in WhatsApp Web"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
