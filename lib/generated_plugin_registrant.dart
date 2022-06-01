//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars

import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:sign_in_with_apple_web/sign_in_with_apple_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  GoogleSignInPlugin.registerWith(registrar);
  SignInWithApplePlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
