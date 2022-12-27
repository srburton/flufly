import 'dart:io';

import 'dart:ui';

class PlatformHelper {

	static Locale get locale
		=> Locale(Platform.localeName.substring(0, 2), Platform.localeName.substring(3, 5));

}