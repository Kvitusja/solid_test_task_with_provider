import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final Color decorationColour;
  final String? labelText;
  final TextEditingController fieldController;
  final void Function(String?) onChanged;
  const TextFormFieldWidget({
    Key? key,
    required this.fieldController,
    required this.decorationColour,
    required this.onChanged,
    this.labelText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return TextFormField(
        validator: validator,
        style: TextStyle(color: decorationColour),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        controller: fieldController,
        decoration: InputDecoration(
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: decorationColour),
            borderRadius: BorderRadius.circular(12),
          ),
          labelStyle: TextStyle(color: decorationColour),
        ),
        onChanged: onChanged,
      );
    });
  }
}
