import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys =>
      {
        'en_US': {
          'email_hint': 'Enter email',
          'login text below logo' : 'Please sign-in to your account and start the adventure'
        },
        'ur_PK': {
          'email_hint': 'Type here in Urdu'
        },
      };
}