extension RegExpExtension on RegExp{
	/*
	* Accept: a-zA-Z
	* */
	static final onlyAlphabet =  RegExp(r'[a-zA-Z]');

	/*
	* Accept: a-zA-Z áéíóúÁÉÍÓÚ
	* */
	static final onlyAlphabetUtf8 = RegExp(r'[a-zA-Z\u00C0-\u00FF]');

	/*
	* Accept: 0-9 e /
	* */
	static final onlyDateCharacters  = RegExp(r'[0-9/]');

	/*
	* Replace ex:
	* Input: (19) 9 9747-0666
	* Output: 19997470666
	* */
	static final onlyNumberForReplace = RegExp(r'[\D]');

	/*
	* Regex example:
	* https://html.spec.whatwg.org/multipage/input.html#e-mail-state-(type=email)
	* */
	static final email = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

	/*
	* Example:
	* 	_srburton_
	* 	66_studio
	* 	666studiio
	* 	srburton
	* 	...
	* */
	static final nickname = RegExp(r'[a-zA-Z0-9_]');

}