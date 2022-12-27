import 'package:flufly/cross/extensions/regexp_extension.dart';

class MailHelper {

	static bool isValid(String email)
		=> RegExpExtension.email.hasMatch(email);

}