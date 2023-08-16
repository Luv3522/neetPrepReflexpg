import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderPageModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool is6MonthChecked = true;

  bool is1YearChecked = false;

  String amount = '';

  String title = '';

  String fee = '';

  String cc = '216413';

  bool loading = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for NameTextField widget.
  TextEditingController? nameTextFieldController1;
  String? Function(BuildContext, String?)? nameTextFieldController1Validator;
  // State field(s) for EmailTextField widget.
  TextEditingController? emailTextFieldController1;
  String? Function(BuildContext, String?)? emailTextFieldController1Validator;
  // State field(s) for PhoneTextField widget.
  TextEditingController? phoneTextFieldController1;
  String? Function(BuildContext, String?)? phoneTextFieldController1Validator;
  // Stores action output result for [Backend Call - API (Create payment for a user for a course and course offer and get checksum)] action in Container widget.
  ApiCallResponse? paymentDetails;
  // Stores action output result for [Custom Action - loginRevenueCat] action in Container widget.
  dynamic? loggedInUserId;
  // Stores action output result for [Backend Call - API (Create User Course on iOS payment)] action in Container widget.
  ApiCallResponse? courseCreationResponse0;
  // Stores action output result for [Backend Call - API (Create payment for a user for a course and course offer and get checksum)] action in Container widget.
  ApiCallResponse? iosPayment;
  // Stores action output result for [RevenueCat - Purchase] action in Container widget.
  bool? isPurchaseSuccessful;
  // Stores action output result for [Backend Call - API (Create User Course on iOS payment)] action in Container widget.
  ApiCallResponse? courseCreationResponse;
  // State field(s) for NameTextField widget.
  TextEditingController? nameTextFieldController2;
  String? Function(BuildContext, String?)? nameTextFieldController2Validator;
  // State field(s) for EmailTextField widget.
  TextEditingController? emailTextFieldController2;
  String? Function(BuildContext, String?)? emailTextFieldController2Validator;
  // State field(s) for PhoneTextField widget.
  TextEditingController? phoneTextFieldController2;
  String? Function(BuildContext, String?)? phoneTextFieldController2Validator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    nameTextFieldController1?.dispose();
    emailTextFieldController1?.dispose();
    phoneTextFieldController1?.dispose();
    nameTextFieldController2?.dispose();
    emailTextFieldController2?.dispose();
    phoneTextFieldController2?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
