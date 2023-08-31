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
import 'practice_quetions_page_model.dart';
export 'practice_quetions_page_model.dart';

class PracticeQuetionsPageWidget extends StatefulWidget {
  const PracticeQuetionsPageWidget({
    Key? key,
    String? testId,
    int? offset,
    int? numberOfQuestions,
  })  : this.testId = testId ?? 'dfgdfg',
        this.offset = offset ?? 0,
        this.numberOfQuestions = numberOfQuestions ?? 0,
        super(key: key);

  final String testId;
  final int offset;
  final int numberOfQuestions;

  @override
  _PracticeQuetionsPageWidgetState createState() =>
      _PracticeQuetionsPageWidgetState();
}

class _PracticeQuetionsPageWidgetState
    extends State<PracticeQuetionsPageWidget> {
  late PracticeQuetionsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PracticeQuetionsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (true) {
        setState(() {
          _model.isLoading = true;
        });
        _model.statusList = await PracticeGroup
            .getStatusOfAllPracticeQuestionsForATestForAGivenUserCall
            .call(
          testIdInt: functions.getIntFromBase64(widget.testId),
          authToken: FFAppState().subjectToken,
        );
        _model.newStatusList = await actions.chkJson(
          PracticeGroup.getStatusOfAllPracticeQuestionsForATestForAGivenUserCall
              .allQuestions(
                (_model.statusList?.jsonBody ?? ''),
              )!
              .toList(),
        );
        setState(() {
          FFAppState().allQuestionsStatus =
              _model.newStatusList!.toList().cast<dynamic>();
        });
        setState(() {
          _model.isLoading = false;
        });
      }
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
        title: 'PracticeQuetionsPage',
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
                              0.0, 0.0, 10.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'PracticeTestPage',
                                queryParameters: {
                                  'testId': serializeParam(
                                    widget.testId,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 29.0,
                            ),
                          ),
                        ),
                        Text(
                          FFAppState()
                              .topicNameForEachPage
                              .maybeHandleOverflow(maxChars: 25),
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: Colors.black,
                                fontSize: 18.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineMediumFamily),
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ToggleIcon(
                          onPressed: () async {
                            setState(() => _model.filtered = !_model.filtered);
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Bookmarked Questions'),
                                  content: Text(
                                      'You will only see bookmarked qusetions. To see all questions, click on the filter again'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            setState(() {
                              _model.filtered = true;
                            });
                          },
                          value: _model.filtered,
                          onIcon: Icon(
                            Icons.filter_alt,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 25.0,
                          ),
                          offIcon: Icon(
                            Icons.filter_alt,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 25.0,
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
                                      child: BubbleQuestionsWidget(
                                        testId: widget.testId,
                                        numberOfQuestions:
                                            widget.numberOfQuestions,
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
                child: Stack(
                  children: [
                    Column(
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
                                          final quetionList = functions
                                                  .testQueTempList(
                                                      widget.numberOfQuestions)
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
                                                            widget.offset,
                                                            0,
                                                          ),
                                                          quetionList.length -
                                                              1)),
                                              onPageChanged: (_) async {
                                                setState(() {
                                                  _model.showConfetti = false;
                                                });
                                              },
                                              scrollDirection: Axis.horizontal,
                                              itemCount: quetionList.length,
                                              itemBuilder:
                                                  (context, quetionListIndex) {
                                                final quetionListItem =
                                                    quetionList[
                                                        quetionListIndex];
                                                return Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: Stack(
                                                    children: [
                                                      FutureBuilder<
                                                          ApiCallResponse>(
                                                        future: FFAppState()
                                                            .testQuestionsCache(
                                                          uniqueQueryKey:
                                                              '${widget.testId}${functions.getOffsetInt(quetionListIndex).toString()}10${'${DateTime.now().day}-${DateTime.now().month}'}',
                                                          overrideCache:
                                                              FFAppState()
                                                                      .userIdInt ==
                                                                  null,
                                                          requestFn: () =>
                                                              PracticeGroup
                                                                  .getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall
                                                                  .call(
                                                            testId:
                                                                widget.testId,
                                                            offset: functions
                                                                .getOffsetInt(
                                                                    quetionListIndex),
                                                            first: 10,
                                                            bookmark:
                                                                _model.filtered,
                                                            authToken:
                                                                FFAppState()
                                                                    .subjectToken,
                                                          ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          final columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse =
                                                              snapshot.data!;
                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          10.0,
                                                                          10.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      minWidth:
                                                                          double
                                                                              .infinity,
                                                                      minHeight:
                                                                          double
                                                                              .infinity,
                                                                      maxWidth:
                                                                          double
                                                                              .infinity,
                                                                      maxHeight:
                                                                          double
                                                                              .infinity,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x00FFFFFF),
                                                                    ),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
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
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium,
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
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                15.0,
                                                                                10.0,
                                                                                15.0,
                                                                                0.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      if (getJsonField(
                                                                                            FFAppState().allQuestionsStatus[quetionListIndex],
                                                                                            r'''$.bookmarkQuestion''',
                                                                                          ) !=
                                                                                          null)
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            setState(() {
                                                                                              FFAppState().allQuestionsStatus = functions.getupdatedBookmarkRemove(FFAppState().allQuestionsStatus.toList(), FFAppState().bookMarkEmptyJson, quetionListIndex).toList().cast<dynamic>();
                                                                                            });
                                                                                            _model.apiResultdn0 = await PracticeGroup.createOrDeleteBookmarkForAPracticeQuestionByAUserCall.call(
                                                                                              questionId: (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionIdArr(
                                                                                                columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                              ) as List)
                                                                                                  .map<String>((s) => s.toString())
                                                                                                  .toList()[functions.getOffsetListQueIndex(quetionListIndex)],
                                                                                              userId: functions.getBase64OfUserId(FFAppState().userIdInt),
                                                                                              authToken: FFAppState().subjectToken,
                                                                                            );

                                                                                            setState(() {});
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.bookmark_sharp,
                                                                                            color: Color(0xFF00629F),
                                                                                            size: 24.0,
                                                                                          ),
                                                                                        ),
                                                                                      if (getJsonField(
                                                                                            FFAppState().allQuestionsStatus[quetionListIndex],
                                                                                            r'''$.bookmarkQuestion''',
                                                                                          ) ==
                                                                                          null)
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            setState(() {
                                                                                              FFAppState().allQuestionsStatus = functions.getupdatedBookmark(FFAppState().allQuestionsStatus.toList(), FFAppState().bookMarkEmptyJson, quetionListIndex).toList().cast<dynamic>();
                                                                                            });
                                                                                            _model.apiResultdn1 = await PracticeGroup.createOrDeleteBookmarkForAPracticeQuestionByAUserCall.call(
                                                                                              questionId: (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionIdArr(
                                                                                                columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                              ) as List)
                                                                                                  .map<String>((s) => s.toString())
                                                                                                  .toList()[functions.getOffsetListQueIndex(quetionListIndex)],
                                                                                              userId: functions.getBase64OfUserId(FFAppState().userIdInt),
                                                                                              authToken: FFAppState().subjectToken,
                                                                                            );

                                                                                            setState(() {});
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.bookmark_border,
                                                                                            color: Color(0xFF00629F),
                                                                                            size: 24.0,
                                                                                          ),
                                                                                        ),
                                                                                    ],
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
                                                                                          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                                          child: Padding(
                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                            child: Container(
                                                                                              height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                              child: ReportAproblemWidget(
                                                                                                testId: widget.testId,
                                                                                                questionId: (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionIdArr(
                                                                                                  columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                                ) as List)
                                                                                                    .map<String>((s) => s.toString())
                                                                                                    .toList()[functions.getOffsetListQueIndex(quetionListIndex)],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ).then((value) => setState(() {}));
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.more_vert,
                                                                                    color: Color(0xFF00629F),
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                10.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: wrapWithModel(
                                                                                model: _model.customHtmlViewModels1.getModel(
                                                                                  'QuestionListId:${getJsonField(
                                                                                    quetionListItem,
                                                                                    r'''$.id''',
                                                                                  ).toString()}',
                                                                                  quetionListIndex,
                                                                                ),
                                                                                updateCallback: () => setState(() {}),
                                                                                child: CustomHtmlViewWidget(
                                                                                  key: Key(
                                                                                    'Keya0y_${'QuestionListId:${getJsonField(
                                                                                      quetionListItem,
                                                                                      r'''$.id''',
                                                                                    ).toString()}'}',
                                                                                  ),
                                                                                  questionStr: '${functions.converHtmlIntoString((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testHtmlQuestionsArr(
                                                                                    columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                  ) as List).map<String>((s) => s.toString()).toList()[functions.getOffsetListQueIndex(quetionListIndex)])}',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Builder(
                                                                            builder:
                                                                                (context) {
                                                                              final queNumbers = FFAppState().questionNumbers.toList();
                                                                              return Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: List.generate(queNumbers.length, (queNumbersIndex) {
                                                                                  final queNumbersItem = queNumbers[queNumbersIndex];
                                                                                  return Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        var _shouldSetState = false;
                                                                                        if (getJsonField(
                                                                                              FFAppState().allQuestionsStatus[quetionListIndex],
                                                                                              r'''$.userAnswer''',
                                                                                            ) ==
                                                                                            null) {
                                                                                          setState(() {
                                                                                            _model.showConfetti = (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionCorrectOptionIndices(
                                                                                                      columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                                    ) as List)
                                                                                                        .map<String>((s) => s.toString())
                                                                                                        .toList()[functions.getOffsetListQueIndex(quetionListIndex)]
                                                                                                        .toString() ==
                                                                                                    queNumbersIndex.toString() &&
                                                                                                (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionCorrectOptionIndices(
                                                                                                      columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                                    ) as List)
                                                                                                        .map<String>((s) => s.toString())
                                                                                                        .toList()[functions.getOffsetListQueIndex(quetionListIndex)]
                                                                                                        .toString() !=
                                                                                                    null &&
                                                                                                queNumbersIndex.toString() != null;
                                                                                          });
                                                                                        } else {
                                                                                          if (_shouldSetState) setState(() {});
                                                                                          return;
                                                                                        }

                                                                                        setState(() {
                                                                                          FFAppState().allQuestionsStatus = functions.getUpdatedQuestionsStatusList(FFAppState().allQuestionsStatus.toList(), quetionListIndex, queNumbersIndex).toList().cast<dynamic>();
                                                                                        });
                                                                                        _model.apiResultixv = await PracticeGroup.createAnswerForAPracticeQuestionByAUserWithSpecificMarkedOptionCall.call(
                                                                                          questionId: (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionIdArr(
                                                                                            columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                          ) as List)
                                                                                              .map<String>((s) => s.toString())
                                                                                              .toList()[functions.getOffsetListQueIndex(quetionListIndex)],
                                                                                          userId: functions.getBase64OfUserId(FFAppState().userIdInt),
                                                                                          userAnswer: queNumbersIndex,
                                                                                          authToken: FFAppState().subjectToken,
                                                                                        );
                                                                                        _shouldSetState = true;
                                                                                        if (_shouldSetState) setState(() {});
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
                                                                                            color: getJsonField(
                                                                                                      FFAppState().allQuestionsStatus[quetionListIndex],
                                                                                                      r'''$.userAnswer''',
                                                                                                    ) !=
                                                                                                    null
                                                                                                ? ((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionCorrectOptionIndices(
                                                                                                          columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                                        ) as List)
                                                                                                            .map<String>((s) => s.toString())
                                                                                                            .toList()[functions.getOffsetListQueIndex(quetionListIndex)]
                                                                                                            .toString() ==
                                                                                                        queNumbersIndex.toString()
                                                                                                    ? Color(0xFF5EB85E)
                                                                                                    : ((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionCorrectOptionIndices(
                                                                                                                  columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                                                )[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                                                queNumbersIndex) &&
                                                                                                            (getJsonField(
                                                                                                                  FFAppState().allQuestionsStatus[quetionListIndex],
                                                                                                                  r'''$.userAnswer.userAnswer''',
                                                                                                                ) !=
                                                                                                                queNumbersIndex)
                                                                                                        ? Color(0xFF5E5E5E)
                                                                                                        : (getJsonField(
                                                                                                                  FFAppState().allQuestionsStatus[quetionListIndex],
                                                                                                                  r'''$.userAnswer.userAnswer''',
                                                                                                                ) ==
                                                                                                                queNumbersIndex
                                                                                                            ? Color(0xFFFF2424)
                                                                                                            : Color(0xFF5EB85E))))
                                                                                                : Color(0xFF00629F),
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
                                                                                              if ((getJsonField(
                                                                                                        FFAppState().allQuestionsStatus[quetionListIndex],
                                                                                                        r'''$.userAnswer''',
                                                                                                      ) !=
                                                                                                      null) &&
                                                                                                  ((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionCorrectPercentages(
                                                                                                            columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                                          ) as List)
                                                                                                              .map<String>((s) => s.toString())
                                                                                                              .toList()[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                                          null &&
                                                                                                      (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestionCorrectPercentages(
                                                                                                            columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                                          ) as List)
                                                                                                              .map<String>((s) => s.toString())
                                                                                                              .toList()[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                                          ''))
                                                                                                Text(
                                                                                                  ' ( ${functions.getOptionCorrectPercentage(PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testQuestions(
                                                                                                        columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                                      )[functions.getOffsetListQueIndex(quetionListIndex)], queNumbersIndex)}% )',
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
                                                                          if ((getJsonField(
                                                                                    FFAppState().allQuestionsStatus[quetionListIndex],
                                                                                    r'''$.userAnswer''',
                                                                                  ) !=
                                                                                  null) &&
                                                                              (((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testHtmlExplanationsArr(
                                                                                            columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                          ) as List)
                                                                                              .map<String>((s) => s.toString())
                                                                                              .toList()[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                          null &&
                                                                                      (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testHtmlExplanationsArr(
                                                                                            columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                          ) as List)
                                                                                              .map<String>((s) => s.toString())
                                                                                              .toList()[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                          '') &&
                                                                                  ((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testHtmlExplanationsArr(
                                                                                        columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                      ) as List)
                                                                                          .map<String>((s) => s.toString())
                                                                                          .toList()[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                      'null')))
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    if ((String var1) {
                                                                                      return !RegExp(r'<(audio|iframe|table)\b[^>]*>').hasMatch(var1);
                                                                                    }((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testHtmlFullExplanationsArr(
                                                                                      columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                    ) as List)
                                                                                        .map<String>((s) => s.toString())
                                                                                        .toList()[functions.getOffsetListQueIndex(quetionListIndex)]))
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
                                                                                            'Keyb4a_${'QuestionListId:${getJsonField(
                                                                                              quetionListItem,
                                                                                              r'''$.id''',
                                                                                            ).toString()}'}',
                                                                                          ),
                                                                                          questionStr: '${functions.converHtmlIntoString((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testHtmlExplanationsArr(
                                                                                            columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                          ) as List).map<String>((s) => s.toString()).toList()[functions.getOffsetListQueIndex(quetionListIndex)])}',
                                                                                        ),
                                                                                      ),
                                                                                    if ((String var1) {
                                                                                      return RegExp(r'<(audio|iframe|table)\b[^>]*>').hasMatch(var1);
                                                                                    }((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testHtmlFullExplanationsArr(
                                                                                      columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                    ) as List)
                                                                                        .map<String>((s) => s.toString())
                                                                                        .toList()[functions.getOffsetListQueIndex(quetionListIndex)]))
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                        height: 380.0,
                                                                                        child: custom_widgets.CustomWebView(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                          height: 380.0,
                                                                                          src: '<style>iframe { max-width: 640px !important;  max-height: 360px !important; position: static !important; } .youtube-embed-wrapper { max-width: 640px !important;  max-height: 360px !important; padding-bottom: 0px !important; position: static !important; height: 100% !important; } body{font-size: 16px;}</style>${functions.converHtmlIntoString((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.testHtmlFullExplanationsArr(
                                                                                            columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                          ) as List).map<String>((s) => s.toString()).toList()[functions.getOffsetListQueIndex(quetionListIndex)])}',
                                                                                        ),
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          if (((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.questionExams(
                                                                                        columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                      ) as List)
                                                                                          .map<String>((s) => s.toString())
                                                                                          .toList()[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                      null &&
                                                                                  (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.questionExams(
                                                                                        columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                      ) as List)
                                                                                          .map<String>((s) => s.toString())
                                                                                          .toList()[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                      '') &&
                                                                              ((PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.questionExams(
                                                                                    columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                  ) as List)
                                                                                      .map<String>((s) => s.toString())
                                                                                      .toList()[functions.getOffsetListQueIndex(quetionListIndex)] !=
                                                                                  'null'))
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 120.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 100.0,
                                                                                    height: 30.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                                    ),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Text(
                                                                                        (PracticeGroup.getPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsCall.questionExams(
                                                                                          columnGetPracticeQuestionsForATestGivenIdOffsetAndFirstNQuestionsResponse.jsonBody,
                                                                                        ) as List)
                                                                                            .map<String>((s) => s.toString())
                                                                                            .toList()[functions.getOffsetListQueIndex(quetionListIndex)],
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 1.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
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
                                                                      size:
                                                                          60.0,
                                                                    ),
                                                                    showLoadingIndicator:
                                                                        true,
                                                                    onPressed: quetionListIndex ==
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
                                                                      size:
                                                                          60.0,
                                                                    ),
                                                                    showLoadingIndicator:
                                                                        true,
                                                                    onPressed: quetionListIndex ==
                                                                            (widget.numberOfQuestions -
                                                                                1)
                                                                        ? null
                                                                        : () async {
                                                                            await _model.pageViewController?.nextPage(
                                                                              duration: Duration(milliseconds: 300),
                                                                              curve: Curves.ease,
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
                                                  ),
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
