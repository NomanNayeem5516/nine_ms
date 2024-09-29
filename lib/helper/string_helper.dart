class StringHelper{
  static final StringHelper _singleton = StringHelper._internal();

  factory StringHelper() {
    return _singleton;
  }

  StringHelper._internal();
  static const String logIn='LogIn';
  static const String enterEmail='Enter Email';
  static const String enterName='Enter Name';
  static const String enterPassword='Enter Password';
  static const String enterJob='Enter Job';
  static const String map='Map';
  static const String list='List';
  static const String getMapList='Get API with Map & List';
  static const String welCome='WelCome';
  static const String have='Do You Have Any Account';
}