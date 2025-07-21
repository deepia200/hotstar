import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
// _buildEditableField(
// label: 'IFSC Code',
// controller: _ifscController,
// validator: (v) => v!.isEmpty ? 'Enter IFSC code' : null,
// keyboardType: TextInputType.text,
// inputFormatters: [
// LengthLimitingTextInputFormatter(11),
// FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
// UpperCaseTextFormatter(), // auto convert to uppercase
// ],
// maxLength: 11,
// ),

//
// _buildEditableField(
// label: 'PAN Number',
// controller: _panNumberController,
// validator: (v) => v!.isEmpty ? 'Enter PAN number' : null,
// keyboardType: TextInputType.text, // PAN has letters + numbers
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
// UpperCaseTextFormatter(), // custom formatter to auto uppercase
// ],
// maxLength: 10,
// ),
