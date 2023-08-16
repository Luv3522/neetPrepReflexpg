import '/backend/api_requests/api_calls.dart';
import '/components/bubble_track_for_test/bubble_track_for_test_widget.dart';
import '/components/custom_html_view/custom_html_view_widget.dart';
import '/components/test_count_down_timer/test_count_down_timer_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'test_page_model.dart';
export 'test_page_model.dart';

class TestPageWidget extends StatefulWidget {
  const TestPageWidget({
    Key? key,
    String? testId,
    this.testAttemptId,
  })  : this.testId = testId ?? 'dfgdfg',
        super(key: key);

  final String testId;
  final String? testAttemptId;

  @override
  _TestPageWidgetState createState() => _TestPageWidgetState();
}

class _TestPageWidgetState extends State<TestPageWidget> {
  late TestPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.isLoading = true;
      });
      _model.questionsList = await TestGroup
          .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
          .call(
        testAttemptId: widget.testAttemptId,
        authToken: FFAppState().subjectToken,
      );
      setState(() {
        FFAppState().questionList = TestGroup
            .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
            .questionsList(
              (_model.questionsList?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        FFAppState().testQueAnsList = functions
            .getTestQuestionsAnswerList(
                TestGroup
                    .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                    .numQuestions(
                  (_model.questionsList?.jsonBody ?? ''),
                ),
                TestGroup
                    .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                    .userAnswers(
                  (_model.questionsList?.jsonBody ?? ''),
                ),
                (TestGroup
                        .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                        .questionIdsList(
                  (_model.questionsList?.jsonBody ?? ''),
                ) as List)
                    .map<String>((s) => s.toString())
                    .toList()!
                    .toList())
            .toList()
            .cast<int>();
        FFAppState().secondsList = functions
            .getSecondsInEachPage(
                TestGroup
                    .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                    .numQuestions(
                  (_model.questionsList?.jsonBody ?? ''),
                ),
                TestGroup
                    .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                    .userQuestionWiseDurationInSec(
                  (_model.questionsList?.jsonBody ?? ''),
                ),
                (TestGroup
                        .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                        .questionIdsList(
                  (_model.questionsList?.jsonBody ?? ''),
                ) as List)
                    .map<String>((s) => s.toString())
                    .toList()!
                    .toList())
            .toList()
            .cast<int>();
      });
      setState(() {
        _model.isLoading = false;
        _model.minutes = valueOrDefault<int>(
              TestGroup
                  .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                  .durationInMin(
                (_model.questionsList?.jsonBody ?? ''),
              ),
              180,
            ) -
            1;
        _model.seconds = 59;
      });
      _model.instantTimer1 = InstantTimer.periodic(
        duration: Duration(milliseconds: 1000),
        callback: (timer) async {
          _model.secondsPerQuestion = (int var1, int var2) {
            return var1 >= var2 ? (var1 - var2) : 0;
          }(_model.instantTimer1.tick, _model.questionLoadedTime);
          if (_model.seconds == 0) {
            _model.minutes = _model.minutes! + -1;
            _model.seconds = 59;
            return;
          } else {
            _model.seconds = _model.seconds! + -1;
            return;
          }
        },
        startImmediately: true,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Title(
        title: 'TestPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Color(0xFFEDEDED),
              appBar: AppBar(
                backgroundColor: Color(0xFFD3E5F1),
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 20.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var _shouldSetState = false;
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text(
                                                'Are you submiting the test ?'),
                                            content: Text(
                                                'do you want to submit the test ?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                setState(() {
                                  FFAppState().questionsListInInt = functions
                                      .getQuestionIdListInInteger(
                                          FFAppState().questionList.toList(),
                                          FFAppState().testQueAnsList.toList())
                                      .toList()
                                      .cast<int>();
                                  FFAppState().answerListInInt = functions
                                      .getAnswerListInInteger(
                                          FFAppState().testQueAnsList.toList())
                                      .toList()
                                      .cast<int>();
                                  FFAppState().secondsListInInt = functions
                                      .getSecondsListInInt(
                                          FFAppState().secondsList.toList())
                                      .toList()
                                      .cast<int>();
                                });
                                _model.submitRes1 = await TestGroup
                                    .updateTestAttemptForATestByAUserBasedOnQuestionsAttemptedAndTimeSpendEtcCall
                                    .call(
                                  testId: widget.testId,
                                  userId: functions.getBase64OfUserId(
                                      FFAppState().userIdInt),
                                  authToken: FFAppState().subjectToken,
                                  testAttemptId: widget.testAttemptId,
                                  userAnswersJsonStr: functions
                                      .convertQuestionAndAnsIntoMapJson(
                                          FFAppState()
                                              .questionsListInInt
                                              .toList(),
                                          FFAppState()
                                              .answerListInInt
                                              .toList()),
                                  userQuestionWiseDurationInSecJsonStr:
                                      functions
                                          .convertQuestionAndAnsIntoMapJson(
                                              FFAppState()
                                                  .questionsListInInt
                                                  .toList(),
                                              FFAppState()
                                                  .secondsListInInt
                                                  .toList()),
                                  visitedQuestionsJsonStr: '{}',
                                  markedQuestionsJsonStr: '{}',
                                  elapsedDurationInSec: 200,
                                  currentQuestionOffset: 0,
                                  completed: true,
                                );
                                _shouldSetState = true;
                                setState(() {
                                  FFAppState().testAttemptId =
                                      widget.testAttemptId!;
                                });

                                context.pushNamed(
                                  'CreateTestResultPage',
                                  queryParameters: {
                                    'testAttemptId': serializeParam(
                                      getJsonField(
                                        (_model.questionsList?.jsonBody ?? ''),
                                        r'''$.data.testAttempt.id''',
                                      ).toString(),
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );

                                if (_shouldSetState) setState(() {});
                                return;
                              } else {
                                context.pop();
                                if (_shouldSetState) setState(() {});
                                return;
                              }

                              if (_shouldSetState) setState(() {});
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 29.0,
                            ),
                          ),
                        ),
                        Text(
                          'Test',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineMediumFamily),
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if ((_model.minutes != null) &&
                            (_model.seconds != null))
                          wrapWithModel(
                            model: _model.testCountDownTimerModel,
                            updateCallback: () => setState(() {}),
                            child: TestCountDownTimerWidget(
                              minutes: _model.minutes != null
                                  ? _model.minutes
                                  : valueOrDefault<int>(
                                      TestGroup
                                          .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                                          .durationInMin(
                                        (_model.questionsList?.jsonBody ?? ''),
                                      ),
                                      180,
                                    ),
                              seconds:
                                  _model.seconds != null ? _model.seconds : (0),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 20.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var _shouldSetState = false;
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Submit Test'),
                                            content: Text(
                                                'Are you sure you want to submit the test?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                setState(() {
                                  FFAppState().questionsListInInt = functions
                                      .getQuestionIdListInInteger(
                                          FFAppState().questionList.toList(),
                                          FFAppState().testQueAnsList.toList())
                                      .toList()
                                      .cast<int>();
                                  FFAppState().answerListInInt = functions
                                      .getAnswerListInInteger(
                                          FFAppState().testQueAnsList.toList())
                                      .toList()
                                      .cast<int>();
                                  FFAppState().secondsListInInt = functions
                                      .getSecondsListInInt(
                                          FFAppState().secondsList.toList())
                                      .toList()
                                      .cast<int>();
                                });
                                setState(() {
                                  _model.isLoading = true;
                                });
                                _model.submitRes = await TestGroup
                                    .updateTestAttemptForATestByAUserBasedOnQuestionsAttemptedAndTimeSpendEtcCall
                                    .call(
                                  testId: widget.testId,
                                  userId: functions.getBase64OfUserId(
                                      FFAppState().userIdInt),
                                  authToken: FFAppState().subjectToken,
                                  testAttemptId: widget.testAttemptId,
                                  userAnswersJsonStr: functions
                                      .convertQuestionAndAnsIntoMapJson(
                                          FFAppState()
                                              .questionsListInInt
                                              .toList(),
                                          FFAppState()
                                              .answerListInInt
                                              .toList()),
                                  userQuestionWiseDurationInSecJsonStr:
                                      functions
                                          .convertQuestionAndAnsIntoMapJson(
                                              FFAppState()
                                                  .questionsListInInt
                                                  .toList(),
                                              FFAppState()
                                                  .secondsListInInt
                                                  .toList()),
                                  visitedQuestionsJsonStr: '{}',
                                  markedQuestionsJsonStr: '{}',
                                  elapsedDurationInSec: 200,
                                  currentQuestionOffset: 0,
                                  completed: true,
                                );
                                _shouldSetState = true;
                                setState(() {
                                  _model.isLoading = false;
                                });

                                context.goNamed(
                                  'CreateTestResultPage',
                                  queryParameters: {
                                    'testAttemptId': serializeParam(
                                      widget.testAttemptId,
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );

                                if (_shouldSetState) setState(() {});
                                return;
                              } else {
                                if (_shouldSetState) setState(() {});
                                return;
                              }

                              if (_shouldSetState) setState(() {});
                            },
                            child: Text(
                              'Submit',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: Color(0xFF3474A1),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              barrierColor: Color(0x00000000),
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => FocusScope.of(context)
                                      .requestFocus(_model.unfocusNode),
                                  child: Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      child: BubbleTrackForTestWidget(
                                        testId: widget.testId,
                                        testAttemptId: widget.testAttemptId,
                                        numberOfQuestions: TestGroup
                                            .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                                            .numQuestions(
                                          (_model.questionsList?.jsonBody ??
                                              ''),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => setState(
                                () => _model.selectedPageNumber = value));

                            await _model.pageViewController?.animateToPage(
                              _model.selectedPageNumber!,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );

                            setState(() {});
                          },
                          child: Icon(
                            Icons.grid_view,
                            color: Color(0xFF00629F),
                            size: 29.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [],
                centerTitle: false,
                elevation: 2.0,
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (!_model.isLoading)
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      final quetionList =
                                          FFAppState().questionList.toList();
                                      return Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: PageView.builder(
                                          controller: _model
                                                  .pageViewController ??=
                                              PageController(
                                                  initialPage: min(
                                                      valueOrDefault<int>(
                                                        FFAppState().pageNumber,
                                                        0,
                                                      ),
                                                      quetionList.length - 1)),
                                          onPageChanged: (_) async {
                                            _model.questionLoadedTime =
                                                _model.instantTimer1.tick;
                                          },
                                          scrollDirection: Axis.horizontal,
                                          itemCount: quetionList.length,
                                          itemBuilder:
                                              (context, quetionListIndex) {
                                            final quetionListItem =
                                                quetionList[quetionListIndex];
                                            return Stack(
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    10.0,
                                                                    10.0,
                                                                    10.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 100.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x00FFFFFF),
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              2.0,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100.0,
                                                                            height:
                                                                                40.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFFD3E5F1),
                                                                            ),
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Text(
                                                                              (quetionListIndex + 1).toString(),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              2.0,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100.0,
                                                                            height:
                                                                                5.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .customHtmlViewModels
                                                                        .getModel(
                                                                      'QuestionListId:${getJsonField(
                                                                        quetionListItem,
                                                                        r'''$.id''',
                                                                      ).toString()}',
                                                                      quetionListIndex,
                                                                    ),
                                                                    updateCallback: () =>
                                                                        setState(
                                                                            () {}),
                                                                    child:
                                                                        CustomHtmlViewWidget(
                                                                      key: Key(
                                                                        'Keyu6d_${'QuestionListId:${getJsonField(
                                                                          quetionListItem,
                                                                          r'''$.id''',
                                                                        ).toString()}'}',
                                                                      ),
                                                                      questionStr:
                                                                          '${functions.converHtmlIntoString(getJsonField(
                                                                        quetionListItem,
                                                                        r'''$.question''',
                                                                      ).toString())}',
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          100.0),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      final queNumbers = FFAppState()
                                                                          .questionNumbers
                                                                          .toList();
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: List.generate(
                                                                            queNumbers.length,
                                                                            (queNumbersIndex) {
                                                                          final queNumbersItem =
                                                                              queNumbers[queNumbersIndex];
                                                                          return Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                10.0,
                                                                                10.0,
                                                                                0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                setState(() {
                                                                                  FFAppState().testQueAnsList = functions.insertValueInListInSpecificPosition(FFAppState().testQueAnsList.toList(), quetionListIndex, queNumbersIndex).toList().cast<int>();
                                                                                  FFAppState().secondsList = functions.insertSeconsInList(FFAppState().secondsList.toList(), quetionListIndex, _model.secondsPerQuestion).toList().cast<int>();
                                                                                });
                                                                                setState(() {
                                                                                  _model.secondsPerQuestion = 0;
                                                                                });
                                                                                setState(() {
                                                                                  FFAppState().questionsListInInt = functions.getQuestionIdListInInteger(FFAppState().questionList.toList(), FFAppState().testQueAnsList.toList()).toList().cast<int>();
                                                                                  FFAppState().answerListInInt = functions.getAnswerListInInteger(FFAppState().testQueAnsList.toList()).toList().cast<int>();
                                                                                  FFAppState().secondsListInInt = functions.getSecondsListInInt(FFAppState().secondsList.toList()).toList().cast<int>();
                                                                                });
                                                                                _model.updateTestAttempt = await TestGroup.updateTestAttemptForATestByAUserBasedOnQuestionsAttemptedAndTimeSpendEtcCall.call(
                                                                                  testId: widget.testId,
                                                                                  userId: functions.getBase64OfUserId(FFAppState().userIdInt),
                                                                                  authToken: FFAppState().subjectToken,
                                                                                  testAttemptId: widget.testAttemptId,
                                                                                  userAnswersJsonStr: functions.convertQuestionAndAnsIntoMapJson(FFAppState().questionsListInInt.toList(), FFAppState().answerListInInt.toList()),
                                                                                  userQuestionWiseDurationInSecJsonStr: functions.convertQuestionAndAnsIntoMapJson(FFAppState().questionsListInInt.toList(), FFAppState().secondsListInInt.toList()),
                                                                                  visitedQuestionsJsonStr: '{}',
                                                                                  markedQuestionsJsonStr: '{}',
                                                                                  elapsedDurationInSec: 200,
                                                                                  currentQuestionOffset: 0,
                                                                                );

                                                                                setState(() {});
                                                                              },
                                                                              child: Material(
                                                                                color: Colors.transparent,
                                                                                elevation: 4.0,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(25.0),
                                                                                ),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: 50.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FFAppState().testQueAnsList[quetionListIndex] < 4 ? (FFAppState().testQueAnsList[quetionListIndex] == queNumbersIndex ? Color(0xFF5EB85E) : Color(0xFF5E5E5E)) : Color(0xFF00629F),
                                                                                    borderRadius: BorderRadius.circular(25.0),
                                                                                  ),
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        queNumbersItem.toString(),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                              color: Colors.white,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(),
                                                    child: Visibility(
                                                      visible:
                                                          responsiveVisibility(
                                                        context: context,
                                                        phone: false,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                            child:
                                                                FlutterFlowIconButton(
                                                              borderColor: Colors
                                                                  .transparent,
                                                              borderRadius:
                                                                  60.0,
                                                              borderWidth: 1.0,
                                                              buttonSize: 120.0,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_back_ios,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent1,
                                                                size: 60.0,
                                                              ),
                                                              showLoadingIndicator:
                                                                  true,
                                                              onPressed:
                                                                  quetionListIndex ==
                                                                          0
                                                                      ? null
                                                                      : () async {
                                                                          await _model
                                                                              .pageViewController
                                                                              ?.previousPage(
                                                                            duration:
                                                                                Duration(milliseconds: 300),
                                                                            curve:
                                                                                Curves.ease,
                                                                          );
                                                                        },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        20.0,
                                                                        10.0),
                                                            child:
                                                                FlutterFlowIconButton(
                                                              borderColor: Colors
                                                                  .transparent,
                                                              borderRadius:
                                                                  60.0,
                                                              borderWidth: 1.0,
                                                              buttonSize: 120.0,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent1,
                                                                size: 60.0,
                                                              ),
                                                              showLoadingIndicator:
                                                                  true,
                                                              onPressed:
                                                                  quetionListIndex ==
                                                                          (TestGroup.getCompletedTestAttemptDataWithTestResultForATestAttemptCall.numQuestions(
                                                                                (_model.questionsList?.jsonBody ?? ''),
                                                                              ) -
                                                                              1)
                                                                      ? null
                                                                      : () async {
                                                                          await _model
                                                                              .pageViewController
                                                                              ?.nextPage(
                                                                            duration:
                                                                                Duration(milliseconds: 300),
                                                                            curve:
                                                                                Curves.ease,
                                                                          );
                                                                        },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_model.isLoading)
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 200.0,
                          child: custom_widgets.CustomLoader(
                            width: double.infinity,
                            height: 200.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
