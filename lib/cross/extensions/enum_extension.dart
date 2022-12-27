extension EnumExtension on Object {

  String get name => toString().split('.').last;

}
