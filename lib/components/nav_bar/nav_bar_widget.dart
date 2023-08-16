import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nav_bar_model.dart';
export 'nav_bar_model.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  @override
  _NavBarWidgetState createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  late NavBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        color: Color(0xFFD3E5F1),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                FFAppState().update(() {
                  FFAppState().homeVisibility = true;
                  FFAppState().testVisibility = false;
                  FFAppState().notesVisibility = false;
                });

                context.pushNamed('PracticePage');
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (FFAppState().homeVisibility)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Icon(
                            Icons.home,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ),
                      if (!FFAppState().homeVisibility)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Icon(
                            Icons.home_outlined,
                            color: Color(0xFF3D444D),
                            size: 28.0,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    'Practice',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FFAppState().homeVisibility
                              ? Colors.black
                              : Color(0xFF8E9BA3),
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
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
                _model.totalCreatedTest = await TestGroup
                    .listOfCustomCreatedTestsByTheUserOrderedByDateOfCreationDescendingCall
                    .call(
                  authToken: FFAppState().subjectToken,
                  first: 10,
                  offset: 0,
                );
                FFAppState().update(() {
                  FFAppState().homeVisibility = false;
                  FFAppState().testVisibility = true;
                  FFAppState().notesVisibility = false;
                });

                context.pushNamed('CreateAndPreviewTestPage');

                setState(() {});
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (FFAppState().testVisibility)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Icon(
                            Icons.mode_edit,
                            color: Colors.black,
                            size: 25.0,
                          ),
                        ),
                      if (!FFAppState().testVisibility)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF3D444D),
                            size: 25.0,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    'Test',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FFAppState().testVisibility
                              ? Colors.black
                              : Color(0xFF8E9BA3),
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
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
                FFAppState().update(() {
                  FFAppState().homeVisibility = false;
                  FFAppState().testVisibility = false;
                  FFAppState().notesVisibility = true;
                });

                context.pushNamed('NotesPage');
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (FFAppState().notesVisibility)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Icon(
                            Icons.book_sharp,
                            color: Colors.black,
                            size: 25.0,
                          ),
                        ),
                      if (!FFAppState().notesVisibility)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Icon(
                            Icons.book_outlined,
                            color: Color(0xFF3D444D),
                            size: 25.0,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    'Notes',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FFAppState().notesVisibility
                              ? Colors.black
                              : Color(0xFF8E9BA3),
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
