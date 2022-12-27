import 'package:flufly/cross/extensions/regexp_extension.dart';

class PhoneHelper{
	
	static bool isValidByMaskCountry(String number, String mask, String prefixMask) {
		String numberClean = number.replaceAll(RegExpExtension.onlyNumberForReplace, '');
		String maskClean = mask.replaceAll(prefixMask, '');

		int maskLen = mask.length - maskClean.length;
		int numberLen = numberClean.length;

		if (maskLen == numberLen)
			return true;
		return false;
	}
}