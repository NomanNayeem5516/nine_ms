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
  static const String have='Do You Have Any Account Please';
  static const String havenot ="Don't Have Any Account Please";
  static const String welcomeAgain ="Welcome Again";
  static const String signUpToContinue ="Sign up to continue";
  static const String name='Name';
  static const String email='Email';
  static const String signUp='Sign Up';
  static const String password='Password';
  static const String details='Details';
}