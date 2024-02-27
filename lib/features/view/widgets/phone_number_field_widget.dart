import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/home_page.dart';

class PhoneNumberField extends ConsumerWidget {
  const PhoneNumberField({
    super.key,
    required this.number,
    this.validator,
  });
  final String? Function(String? value)? validator;

  final TextEditingController number;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: number,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: TextButton(
          onPressed: () {
            showCountryPicker(
              context: context,
              onSelect: (value) {
                ref.read(selectedCountryCode.notifier).state =
                    "+${value.phoneCode}";
              },
              favorite: ["IN"],
              showPhoneCode: true,
              showWorldWide: false,
              customFlagBuilder: (country) => SizedBox(
                width: 24,
                // height: 12,
                child: Image.network(
                  "https://flagsapi.com/${country.countryCode}/flat/64.png",
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              countryListTheme: CountryListThemeData(
                bottomSheetHeight: MediaQuery.sizeOf(context).height / 2,
                borderRadius: BorderRadius.circular(15),
                inputDecoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(),
                  hintText: "Search country",
                ),
              ),
            );
          },
          child: Text(ref.watch(selectedCountryCode)),
        ),
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        hintText: "WhatsApp phone number",
        label: const Text("Phone Number"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counterText: '',
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 10,
    );
  }
}
