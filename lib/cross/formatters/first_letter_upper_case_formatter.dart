import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FirstLetterUpperCaseFormatter extends TextInputFormatter {
	@override
	TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
		String value = newValue.text;
		if(value != null && value.length >= 1) {
			final first = newValue.text[0].toUpperCase();
			final body = newValue.text.substring(1);
			value = "$first$body";
		}
		return TextEditingValue(
			text: value,
			selection: newValue.selection,
		);
	}
}