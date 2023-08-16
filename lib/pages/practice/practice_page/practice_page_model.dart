import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/components/need_help_pop_up/need_help_pop_up_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/request_manager.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PracticePageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Logged in user information and course access checking api )] action in PracticePage widget.
  ApiCallResponse? memberShip;
  // Stores action output result for [Custom Action - getTabs] action in Container widget.
  List<int>? numTabs;
  // Stores action output result for [Custom Action - getTabs] action in Text widget.
  List<int>? tabs;
  // Model for navBar component.
  late NavBarModel navBarModel;

  /// Query cache managers for this widget.

  final _practiceTestsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> practiceTests({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _practiceTestsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPracticeTestsCache() => _practiceTestsManager.clear();
  void clearPracticeTestsCacheKey(String? uniqueKey) =>
      _practiceTestsManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  void dispose() {
    unfocusNode.dispose();
    navBarModel.dispose();

    /// Dispose query cache managers for this widget.

    clearPracticeTestsCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
