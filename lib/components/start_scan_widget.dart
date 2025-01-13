import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'start_scan_model.dart';
export 'start_scan_model.dart';

class StartScanWidget extends StatefulWidget {
  const StartScanWidget({super.key});

  @override
  State<StartScanWidget> createState() => _StartScanWidgetState();
}

class _StartScanWidgetState extends State<StartScanWidget> {
  late StartScanModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartScanModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 230.0,
        height: 44.0,
        decoration: BoxDecoration(
          color: Color(0xFFFFE066),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Text(
            'Start Scan',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
