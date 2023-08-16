import '/backend/api_requests/api_calls.dart';
import '/components/bubble_track_for_test_details/bubble_track_for_test_details_widget.dart';
import '/components/custom_html_view/custom_html_view_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'view_answer_page_model.dart';
export 'view_answer_page_model.dart';

class ViewAnswerPageWidget extends StatefulWidget {
  const ViewAnswerPageWidget({
    Key? key,
    this.testAttemptId,
  }) : super(key: key);

  final String? testAttemptId;

  @override
  _ViewAnswerPageWidgetState createState() => _ViewAnswerPageWidgetState();
}

class _ViewAnswerPageWidgetState extends State<ViewAnswerPageWidget> {
  late ViewAnswerPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewAnswerPageModel());

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

    return FutureBuilder<ApiCallResponse>(
      future: FFAppState().completedTestAttemptQuery(
        uniqueQueryKey: valueOrDefault<String>(
          widget.testAttemptId,
          'keyTestAttemptId',
        ),
        requestFn: () => TestGroup
            .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
            .call(
          testAttemptId: widget.testAttemptId,
          authToken: FFAppState().subjectToken,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFEDEDED),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse =
            snapshot.data!;
        return Title(
            title: 'ViewAnswerPage',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: GestureDetector(
              onTap: () =>
                  FocusScope.of(context).requestFocus(_model.unfocusNode),
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
                                  context.safePop();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 29.0,
                                ),
                              ),
                            ),
                            Text(
                              'Test Details',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineMediumFamily,
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .headlineMediumFamily),
                                  ),
                            ),
                          ],
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
                                      child: BubbleTrackForTestDetailsWidget(
                                        questionsStatus: functions
                                            .convertQuestionsStatus(TestGroup
                                                .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                                                .testAttemptDetail(
                                          viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse
                                              .jsonBody,
                                        )),
                                        testAttemptId: widget.testAttemptId,
                                        numberOfQuestions: TestGroup
                                            .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                                            .numQuestions(
                                          viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse
                                              .jsonBody,
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
                                          final quetionList = TestGroup
                                                  .getCompletedTestAttemptDataWithTestResultForATestAttemptCall
                                                  .questionsList(
                                                    viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse
                                                        .jsonBody,
                                                  )
                                                  ?.toList() ??
                                              [];
                                          return Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: PageView.builder(
                                              controller: _model
                                                      .pageViewController ??=
                                                  PageController(
                                                      initialPage: min(
                                                          valueOrDefault<int>(
                                                            FFAppState()
                                                                .pageNumber,
                                                            0,
                                                          ),
                                                          quetionList.length -
                                                              1)),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: quetionList.length,
                                              itemBuilder:
                                                  (context, quetionListIndex) {
                                                final quetionListItem =
                                                    quetionList[
                                                        quetionListIndex];
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
                                                              width: double
                                                                  .infinity,
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
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Material(
                                                                              color: Colors.transparent,
                                                                              elevation: 2.0,
                                                                              child: Container(
                                                                                width: 100.0,
                                                                                height: 40.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFFD3E5F1),
                                                                                ),
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Text(
                                                                                  (quetionListIndex + 1).toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        color: int.parse((TestGroup.getCompletedTestAttemptDataWithTestResultForATestAttemptCall.questionsStatus(
                                                                                                  viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse.jsonBody,
                                                                                                ) as List)
                                                                                                    .map<String>((s) => s.toString())
                                                                                                    .toList()[quetionListIndex]
                                                                                                    .toString()) ==
                                                                                                0
                                                                                            ? Color(0xFF5E5E5E)
                                                                                            : (int.parse((TestGroup.getCompletedTestAttemptDataWithTestResultForATestAttemptCall.questionsStatus(
                                                                                                      viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse.jsonBody,
                                                                                                    ) as List)
                                                                                                        .map<String>((s) => s.toString())
                                                                                                        .toList()[quetionListIndex]
                                                                                                        .toString()) ==
                                                                                                    1
                                                                                                ? Color(0xFF5EB85E)
                                                                                                : Color(0xFFFF2424)),
                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Material(
                                                                              color: Colors.transparent,
                                                                              elevation: 2.0,
                                                                              child: Container(
                                                                                width: 100.0,
                                                                                height: 5.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: int.parse((TestGroup.getCompletedTestAttemptDataWithTestResultForATestAttemptCall.questionsStatus(
                                                                                            viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse.jsonBody,
                                                                                          ) as List)
                                                                                              .map<String>((s) => s.toString())
                                                                                              .toList()[quetionListIndex]
                                                                                              .toString()) ==
                                                                                          0
                                                                                      ? Color(0xFF5E5E5E)
                                                                                      : (int.parse((TestGroup.getCompletedTestAttemptDataWithTestResultForATestAttemptCall.questionsStatus(
                                                                                                viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse.jsonBody,
                                                                                              ) as List)
                                                                                                  .map<String>((s) => s.toString())
                                                                                                  .toList()[quetionListIndex]
                                                                                                  .toString()) ==
                                                                                              1
                                                                                          ? Color(0xFF5EB85E)
                                                                                          : Color(0xFFFF2424)),
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          wrapWithModel(
                                                                        model: _model
                                                                            .customHtmlViewModels1
                                                                            .getModel(
                                                                          'QuestionListId:${getJsonField(
                                                                            quetionListItem,
                                                                            r'''$.id''',
                                                                          ).toString()}',
                                                                          quetionListIndex,
                                                                        ),
                                                                        updateCallback:
                                                                            () =>
                                                                                setState(() {}),
                                                                        child:
                                                                            CustomHtmlViewWidget(
                                                                          key:
                                                                              Key(
                                                                            'Keypcd_${'QuestionListId:${getJsonField(
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
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
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
                                                                                    color: getJsonField(
                                                                                              quetionListItem,
                                                                                              r'''$.correctOptionIndex''',
                                                                                            ) ==
                                                                                            queNumbersIndex
                                                                                        ? Color(0xFF5EB85E)
                                                                                        : (functions
                                                                                                    .getQuesUserAnswer(
                                                                                                        TestGroup.getCompletedTestAttemptDataWithTestResultForATestAttemptCall.userAnswers(
                                                                                                          viewAnswerPageGetCompletedTestAttemptDataWithTestResultForATestAttemptResponse.jsonBody,
                                                                                                        ),
                                                                                                        getJsonField(
                                                                                                          quetionListItem,
                                                                                                          r'''$.id''',
                                                                                                        ).toString())
                                                                                                    .toString() ==
                                                                                                queNumbersIndex.toString()
                                                                                            ? Color(0xFFFF2424)
                                                                                            : Color(0xFF5E5E5E)),
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
                                                                                      if (getJsonField(
                                                                                            quetionListItem,
                                                                                            r'''$.analytics''',
                                                                                          ) !=
                                                                                          null)
                                                                                        Text(
                                                                                          ' ( ${queNumbersIndex == 0 ? getJsonField(
                                                                                              quetionListItem,
                                                                                              r'''$.analytics.option1Percentage''',
                                                                                            ).toString() : (queNumbersIndex == 1 ? getJsonField(
                                                                                              quetionListItem,
                                                                                              r'''$.analytics.option2Percentage''',
                                                                                            ).toString() : (queNumbersIndex == 2 ? getJsonField(
                                                                                              quetionListItem,
                                                                                              r'''$.analytics.option3Percentage''',
                                                                                            ).toString() : getJsonField(
                                                                                              quetionListItem,
                                                                                              r'''$.analytics.option4Percentage''',
                                                                                            ).toString()))}% )',
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
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                    if (getJsonField(
                                                                          quetionListItem,
                                                                          r'''$.explanationWithoutAudio''',
                                                                        ) !=
                                                                        null)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                100.0),
                                                                            child:
                                                                                wrapWithModel(
                                                                              model: _model.customHtmlViewModels2.getModel(
                                                                                'QuestionListId:${getJsonField(
                                                                                  quetionListItem,
                                                                                  r'''$.id''',
                                                                                ).toString()}',
                                                                                quetionListIndex,
                                                                              ),
                                                                              updateCallback: () => setState(() {}),
                                                                              child: CustomHtmlViewWidget(
                                                                                key: Key(
                                                                                  'Keyak6_${'QuestionListId:${getJsonField(
                                                                                    quetionListItem,
                                                                                    r'''$.id''',
                                                                                  ).toString()}'}',
                                                                                ),
                                                                                questionStr: '${functions.converHtmlIntoString(getJsonField(
                                                                                  quetionListItem,
                                                                                  r'''$.explanationWithoutAudio''',
                                                                                ).toString())}',
                                                                              ),
                                                                            ),
                                                                          ),
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
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Visibility(
                                                          visible:
                                                              responsiveVisibility(
                                                            context: context,
                                                            phone: false,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                                child:
                                                                    FlutterFlowIconButton(
                                                                  borderColor:
                                                                      Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      60.0,
                                                                  borderWidth:
                                                                      1.0,
                                                                  buttonSize:
                                                                      120.0,
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
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
                                                                              await _model.pageViewController?.previousPage(
                                                                                duration: Duration(milliseconds: 300),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        20.0,
                                                                        10.0),
                                                                child:
                                                                    FlutterFlowIconButton(
                                                                  borderColor:
                                                                      Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      60.0,
                                                                  borderWidth:
                                                                      1.0,
                                                                  buttonSize:
                                                                      120.0,
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
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
                                                                  onPressed: quetionListIndex ==
                                                                          (_model.questionsStatus.length -
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
      },
    );
  }
}
