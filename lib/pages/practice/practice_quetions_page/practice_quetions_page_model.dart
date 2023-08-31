import '/backend/api_requests/api_calls.dart';
import '/components/bubble_questions/bubble_questions_widget.dart';
import '/components/custom_html_view/custom_html_view_widget.dart';
import '/components/report_aproblem/report_aproblem_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PracticeQuetionsPageModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool isLoading = false;

  int chkAnswer = 0;

  bool showConfetti = false;

  bool filtered = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Get Status of all Practice Questions for a test for a given user)] action in PracticeQuetionsPage widget.
  ApiCallResponse? statusList;
  // Stores action output result for [Custom Action - chkJson] action in PracticeQuetionsPage widget.
  List<dynamic>? newStatusList;
  // Stores action output result for [Bottom Sheet - BubbleQuestions] action in Icon widget.
  int? selectedPageNumber;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - API (Create or delete bookmark for a practice question by a user)] action in Icon widget.
  ApiCallResponse? apiResultdn0;
  // Stores action output result for [Backend Call - API (Create or delete bookmark for a practice question by a user)] action in Icon widget.
  ApiCallResponse? apiResultdn1;
  // Models for CustomHtmlView dynamic component.
  late FlutterFlowDynamicModels<CustomHtmlViewModel> customHtmlViewModels1;
  // Stores action output result for [Backend Call - API (Create answer for a practice question by a user with specific marked option )] action in Container widget.
  ApiCallResponse? apiResultixv;
  // Models for CustomHtmlView dynamic component.
  late FlutterFlowDynamicModels<CustomHtmlViewModel> customHtmlViewModels2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    customHtmlViewModels1 =
        FlutterFlowDynamicModels(() => CustomHtmlViewModel());
    customHtmlViewModels2 =
        FlutterFlowDynamicModels(() => CustomHtmlViewModel());
  }

  void dispose() {
    unfocusNode.dispose();
    customHtmlViewModels1.dispose();
    customHtmlViewModels2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
