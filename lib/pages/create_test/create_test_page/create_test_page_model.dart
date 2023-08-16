import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateTestPageModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  List<String> topicName = [];
  void addToTopicName(String item) => topicName.add(item);
  void removeFromTopicName(String item) => topicName.remove(item);
  void removeAtIndexFromTopicName(int index) => topicName.removeAt(index);
  void updateTopicNameAtIndex(int index, Function(String) updateFn) =>
      topicName[index] = updateFn(topicName[index]);

  List<String> subTopicName = [];
  void addToSubTopicName(String item) => subTopicName.add(item);
  void removeFromSubTopicName(String item) => subTopicName.remove(item);
  void removeAtIndexFromSubTopicName(int index) => subTopicName.removeAt(index);
  void updateSubTopicNameAtIndex(int index, Function(String) updateFn) =>
      subTopicName[index] = updateFn(subTopicName[index]);

  int subTopicIndex = 01;

  bool isMiniTest = true;

  bool isGrandTest = false;

  bool isCustomTest = false;

  bool isBookMarked = false;

  bool is10Que = false;

  bool is20Que = false;

  bool is50Que = false;

  bool is100Que = false;

  bool is200Que = false;

  int numberOfQuestions = 50;

  int bookMark = 1;

  dynamic topicIds;

  dynamic subjectIds;

  String selectedExam = 'BOTH';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Create custom test as per selected parameters)] action in Container widget.
  ApiCallResponse? apiResult96m;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
