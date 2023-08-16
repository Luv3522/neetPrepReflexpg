// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWebUrlOnExcecption({
  String? msg,
  String? orderId,
  String? amount,
  String? txnToken,
  int? paymentId,
  String? mid,
}) async {
  print(msg);
  /* TODO: the below is a test url, we either need to change it to a relative path
  on the current url or provide an absolute url*/
  final url =
      'https://www.neetprep.com/payment/js_payment?orderId=$orderId&token=$txnToken&amount=$amount&paymentId=$paymentId&mid=$mid';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_self');
  } else {
    throw 'Could not launch $url';
  }
}

Future paytmIntegration(String orderId, String amount, String txnToken,
    int paymentId, String mid, String callbackUrl) async {
  print(orderId);
  print(amount);
  print(txnToken);
  print(mid);
  print(paymentId);
  print(callbackUrl);
  var response = AllInOneSdk.startTransaction(
      mid, orderId, amount, txnToken, callbackUrl, false, false);
  response.then((value) {
    print(value);
  }).catchError((onError) {
    if (onError is PlatformException) {
      print(onError.message! + " \n  " + onError.details.toString());
      openWebUrlOnExcecption(
        msg: "platform exception error",
        orderId: orderId,
        amount: amount,
        txnToken: txnToken,
        paymentId: paymentId,
        mid: mid,
      );
    } else {
      print(onError.toString());
      openWebUrlOnExcecption(
        msg: "not platform exception error",
        orderId: orderId,
        amount: amount,
        txnToken: txnToken,
        paymentId: paymentId,
        mid: mid,
      );
    }
  });
}
