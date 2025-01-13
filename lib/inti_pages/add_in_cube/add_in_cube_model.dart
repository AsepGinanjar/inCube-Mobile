import '/components/navbar_widget.dart';
import '/components/start_scan_widget.dart';
import '/components/submit_serial_number_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'add_in_cube_widget.dart' show AddInCubeWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddInCubeModel extends FlutterFlowModel<AddInCubeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StartScan component.
  late StartScanModel startScanModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for SubmitSerialNumber component.
  late SubmitSerialNumberModel submitSerialNumberModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    startScanModel = createModel(context, () => StartScanModel());
    submitSerialNumberModel =
        createModel(context, () => SubmitSerialNumberModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    startScanModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    submitSerialNumberModel.dispose();
    navbarModel.dispose();
  }
}
