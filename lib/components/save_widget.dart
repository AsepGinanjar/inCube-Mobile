import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'save_model.dart';
export 'save_model.dart';

class SaveWidget extends StatefulWidget {
  const SaveWidget({super.key});

  @override
  State<SaveWidget> createState() => _SaveWidgetState();
}

class _SaveWidgetState extends State<SaveWidget> {
  late SaveModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SaveModel());
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
            'Save',
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
