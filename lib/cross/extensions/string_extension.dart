extension StringExtension on String{

	String margin({int left=0, int right=0}){
		String space = " ";
		String strLeft = this.padLeft(this.length + left, space);
		String strRight = strLeft.padRight(strLeft.length + right, space);
		return strRight;
	}

	String firstUpperCase() {
		return "${this[0].toUpperCase()}${this.substring(1)}";
	}

	String repeat(int length){
		var result = '';
		for(var i=0; i< length; i++)
			result += this;
		return result;
	}
}