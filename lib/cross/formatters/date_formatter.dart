import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DateFormatter extends TextInputFormatter {

	 String? seperator;

	 static const int maxChars = 8;

	 DateFormatter({
		 this.seperator
	 }){
	 	seperator = (seperator != null)? seperator : "/";
	 }

	@override
	TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

		var text = format(newValue.text, seperator ?? '-');

		return newValue.copyWith(
				text: text,
				selection: updateCursorPosition(text)
		);
	}

	String format(String value, String seperator) {
		value = value.replaceAll(seperator, '');
		var newString = '';

		for (int i = 0; i < min(value.length, maxChars); i++) {
			newString += value[i];
			if ((i == 1 || i == 3) && i != value.length - 1) {
				newString += seperator;
			}
		}

		return newString;
	}

	TextSelection updateCursorPosition(String text)
		=> TextSelection.fromPosition(TextPosition(
				offset: text.length
		));
}