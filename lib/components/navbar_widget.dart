import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'navbar_model.dart';
export 'navbar_model.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late NavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: 390.0,
        height: 83.89,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SvgPicture.asset(
                  'assets/images/Subtract.svg',
                  width: 390.0,
                  height: 83.89,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      icon: Icon(
                        Icons.home_rounded,
                        color: FlutterFlowTheme.of(context).info,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        context.pushNamed(
                          'Homepage',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                            ),
                          },
                        );
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 50.0, 0.0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 8.0,
                          icon: Icon(
                            Icons.settings_rounded,
                            color: FlutterFlowTheme.of(context).info,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            context.pushNamed(
                              'setting',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 500),
                                ),
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 8.0,
                        icon: Icon(
                          Icons.bar_chart_rounded,
                          color: FlutterFlowTheme.of(context).info,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          context.pushNamed(
                            'Report',
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 500),
                              ),
                            },
                          );
                        },
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 8.0,
                      icon: Icon(
                        Icons.person,
                        color: FlutterFlowTheme.of(context).info,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        context.pushNamed(
                          'Profile',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                            ),
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -6.5),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 50.0,
                fillColor: Color(0xF1F1F1F1),
                icon: Icon(
                  Icons.egg_outlined,
                  color: Colors.black,
                  size: 55.0,
                ),
                onPressed: () async {
                  context.pushNamed(
                    'AddInCube',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 500),
                      ),
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
