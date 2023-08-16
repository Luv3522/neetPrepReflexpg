// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../../auth/firebase_auth/auth_util.dart';

import '../../backend/api_requests/api_calls.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future<dynamic> appleLogin(BuildContext context) async {
  var userData = null;
  final signInFunc = () async {
    try {
      /*if (kIsWeb) {
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
      }*/

      await authManager.signOut().catchError((_) => null);
      userData = await authManager.signInWithApple(context);
      dynamic userAccessInfo = await SignupGroup
          .googleLoginServerCallWithCodeReceivedFromGoogleAuthenticationCall
          .call(
        email: userData?.email.toLowerCase(),
        name: userData?.displayName,
        picture: userData?.photoUrl,
      );
      FFAppState().userIdInt =
          getJsonField((userAccessInfo?.jsonBody ?? ''), r'''$.id''');
      FFAppState().subjectToken =
          getJsonField((userAccessInfo?.jsonBody ?? ''), r'''$.token''');
    } catch (e) {
      print(e);
    }
  };

  await signInFunc();

  dynamic userJson = {
    "email": userData?.email,
    "profile": userData?.photoUrl,
    "name": userData?.displayName,
    "accessToken": null
  };

  return userJson;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
