import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import 'package:in_cube/backend/mqtt/mqtt_config.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'homepage_model.dart';
export 'homepage_model.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({
    super.key,
    this.coba,
  });

  final String? coba;

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget>
    with TickerProviderStateMixin {
  late HomepageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  String temperature = "..."; // Variabel untuk suhu
  String humidity = "..."; // Variabel untuk suhu
  String errorMessage = ""; // Variabel untuk error
  late MqttClient mqttClient; // MQTT client instance
  // Fungsi untuk menghubungkan ke MQTT

  List<double> temperatureData = []; // List to store temperature data
  List<double> humidityData = []; // List to store humidity data
  List<DateTime> timeStamps = []; // List to store timestamps of data points

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageModel());

    // Animasi setup
    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);
    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    // Hubungkan ke MQTT service
    _initializeMqtt();
  }

  @override
  void dispose() {
    _model.dispose(); // Jangan diubah
    mqttClient.disconnect();
    super.dispose();
  }

  // Inisialisasi koneksi MQTT
  Future<void> _initializeMqtt() async {
    try {
      mqttClient =
          await connect(); // Memanggil fungsi connect dari mqtt_service.dart
      mqttClient.subscribe("IC0001/Temp", MqttQos.atMostOnce);
      mqttClient.subscribe("IC0001/Humid", MqttQos.atMostOnce); // New topic

      // Dengarkan pesan dari topik
      mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final MqttPublishMessage message = c![0].payload as MqttPublishMessage;
        final String payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);

        // Perbarui suhu di UI
        // Perbarui suhu atau kelembaban di UI berdasarkan topik
        setState(() {
          if (c[0].topic == "IC0001/Temp") {
            temperature = payload; // Update temperature
            temperatureData.add(double.tryParse(payload) ?? 0.0);
          } else if (c[0].topic == "IC0001/Humid") {
            // You can create a separate variable for humidity if needed
            humidity = payload;
            humidityData
                .add(double.tryParse(payload) ?? 0.0); // Store humidity value
            timeStamps.add(DateTime.now());
            print(
                "Received Humidity: $payload"); // You can use this value as needed
          }
        });
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error connecting to MQTT: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('MQTT Temperature Display'),
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 1.0),
                                        child: SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 20.0, 0.0, 0.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20.0,
                                                                16.0,
                                                                16.0,
                                                                16.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Welcome Back!',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter Tight',
                                                                color: Colors
                                                                    .black,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              Text(
                                                            valueOrDefault(
                                                                currentUserDocument
                                                                    ?.username,
                                                                ''),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter Tight',
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 15.0, 0.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: 37.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 15.0, 0.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: 220.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0x83000000),
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    10.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: StreamBuilder(
                                                          stream:
                                                              Stream.periodic(
                                                                  Duration(
                                                                      seconds:
                                                                          1)),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (temperatureData
                                                                    .isEmpty ||
                                                                humidityData
                                                                    .isEmpty) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor: AlwaysStoppedAnimation<
                                                                        Color>(FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary),
                                                                  ),
                                                                ),
                                                              );
                                                            }

                                                            // Ensure that temperatureData and humidityData have the same length
                                                            int minLength = temperatureData
                                                                        .length <
                                                                    humidityData
                                                                        .length
                                                                ? temperatureData
                                                                    .length
                                                                : humidityData
                                                                    .length;
                                                            List<DateTime>
                                                                validTimeStamps =
                                                                timeStamps
                                                                    .take(
                                                                        minLength)
                                                                    .toList();
                                                            List<double>
                                                                validTemperatureData =
                                                                temperatureData
                                                                    .take(
                                                                        minLength)
                                                                    .toList();
                                                            List<double>
                                                                validHumidityData =
                                                                humidityData
                                                                    .take(
                                                                        minLength)
                                                                    .toList();

                                                            return Container(
                                                              width: 370.0,
                                                              height: 200.0,
                                                              child:
                                                                  FlutterFlowLineChart(
                                                                data: [
                                                                  FFLineChartData(
                                                                    xData: validTimeStamps
                                                                        .map((e) =>
                                                                            e.toIso8601String())
                                                                        .toList(), // Use valid timestamps for X axis
                                                                    yData:
                                                                        validTemperatureData,
                                                                    settings:
                                                                        LineChartBarData(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              255,
                                                                              0,
                                                                              0),
                                                                      barWidth:
                                                                          2.0,
                                                                      isCurved:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                  FFLineChartData(
                                                                    xData: validTimeStamps
                                                                        .map((e) =>
                                                                            e.toIso8601String())
                                                                        .toList(), // Use valid timestamps for X axis
                                                                    yData:
                                                                        validHumidityData,
                                                                    settings:
                                                                        LineChartBarData(
                                                                      color: Color(
                                                                          0xFF7BD0EF),
                                                                      barWidth:
                                                                          2.0,
                                                                      isCurved:
                                                                          true,
                                                                    ),
                                                                  )
                                                                ],
                                                                chartStylingInfo:
                                                                    ChartStylingInfo(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  showBorder:
                                                                      false,
                                                                ),
                                                                axisBounds:
                                                                    AxisBounds(
                                                                  minY: 0.0,
                                                                  maxY: 100.0,
                                                                ),
                                                                xAxisLabelInfo:
                                                                    AxisLabelInfo(
                                                                  title:
                                                                      'Time (Hours)',
                                                                  titleTextStyle:
                                                                      GoogleFonts
                                                                          .getFont(
                                                                    'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                  reservedSize:
                                                                      32.0,
                                                                ),
                                                                yAxisLabelInfo:
                                                                    AxisLabelInfo(
                                                                  showLabels:
                                                                      true,
                                                                  labelTextStyle:
                                                                      GoogleFonts
                                                                          .getFont(
                                                                    'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                  labelInterval:
                                                                      10.0,
                                                                  reservedSize:
                                                                      40.0,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    height: 400.0,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        30.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              color: Color(
                                                                  0x00000000),
                                                              child:
                                                                  ExpandableNotifier(
                                                                controller: _model
                                                                    .expandableExpandableController,
                                                                child:
                                                                    ExpandablePanel(
                                                                  header: Text(
                                                                    'inCube 1',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                  collapsed:
                                                                      Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Text(
                                                                        'Click for more information',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Inter',
                                                                              color: Color(0x8A000000),
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  expanded:
                                                                      Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Divider(
                                                                        thickness:
                                                                            2.0,
                                                                        color: Color(
                                                                            0x1A000000),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'Running Status',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Poppins',
                                                                                  color: Colors.black,
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            15.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              329.0,
                                                                          height:
                                                                              180.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              GridView(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            gridDelegate:
                                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                                              crossAxisCount: 2,
                                                                              crossAxisSpacing: 10.0,
                                                                              mainAxisSpacing: 10.0,
                                                                              childAspectRatio: 2.0,
                                                                            ),
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            children: [
                                                                              SingleChildScrollView(
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Material(
                                                                                      color: Colors.transparent,
                                                                                      elevation: 2.0,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(0.0),
                                                                                          bottomRight: Radius.circular(0.0),
                                                                                          topLeft: Radius.circular(10.0),
                                                                                          topRight: Radius.circular(10.0),
                                                                                        ),
                                                                                      ),
                                                                                      child: Container(
                                                                                        width: 160.0,
                                                                                        height: 32.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFFFCC3F),
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(0.0),
                                                                                            bottomRight: Radius.circular(0.0),
                                                                                            topLeft: Radius.circular(10.0),
                                                                                            topRight: Radius.circular(10.0),
                                                                                          ),
                                                                                        ),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              'Egg',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Poppins',
                                                                                                    color: Color(0xFFF6F6F6),
                                                                                                    fontSize: 16.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Material(
                                                                                      color: Colors.transparent,
                                                                                      elevation: 2.0,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(10.0),
                                                                                          bottomRight: Radius.circular(10.0),
                                                                                          topLeft: Radius.circular(0.0),
                                                                                          topRight: Radius.circular(0.0),
                                                                                        ),
                                                                                      ),
                                                                                      child: Container(
                                                                                        width: 160.0,
                                                                                        height: 45.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(10.0),
                                                                                            bottomRight: Radius.circular(10.0),
                                                                                            topLeft: Radius.circular(0.0),
                                                                                            topRight: Radius.circular(0.0),
                                                                                          ),
                                                                                        ),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(-1.0, -1.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 2.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              'Active\n',
                                                                                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                    fontFamily: 'Plus Jakarta Sans',
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                            ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Material(
                                                                                    color: Colors.transparent,
                                                                                    elevation: 2.0,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(0.0),
                                                                                        bottomRight: Radius.circular(0.0),
                                                                                        topLeft: Radius.circular(10.0),
                                                                                        topRight: Radius.circular(10.0),
                                                                                      ),
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 160.0,
                                                                                      height: 32.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFE40000),
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(0.0),
                                                                                          bottomRight: Radius.circular(0.0),
                                                                                          topLeft: Radius.circular(10.0),
                                                                                          topRight: Radius.circular(10.0),
                                                                                        ),
                                                                                      ),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            'Temperature',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Poppins',
                                                                                                  color: Colors.white,
                                                                                                  fontSize: 16.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Material(
                                                                                    color: Colors.transparent,
                                                                                    elevation: 2.0,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(10.0),
                                                                                        bottomRight: Radius.circular(10.0),
                                                                                        topLeft: Radius.circular(0.0),
                                                                                        topRight: Radius.circular(0.0),
                                                                                      ),
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 160.0,
                                                                                      height: 45.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(10.0),
                                                                                          bottomRight: Radius.circular(10.0),
                                                                                          topLeft: Radius.circular(0.0),
                                                                                          topRight: Radius.circular(0.0),
                                                                                        ),
                                                                                      ),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Text(
                                                                                          '$temperature °C',
                                                                                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                fontFamily: 'Poppins',
                                                                                                color: Color(0xFFE40000),
                                                                                                fontSize: 20.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  // Pesan error jika gagal mendapatkan data dari MQTT
                                                                                  if (errorMessage.isNotEmpty) ...[
                                                                                    SizedBox(height: 16),
                                                                                    Text(
                                                                                      errorMessage,
                                                                                      style: TextStyle(color: Colors.red),
                                                                                    ),
                                                                                  ],
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Material(
                                                                                    color: Colors.transparent,
                                                                                    elevation: 2.0,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(0.0),
                                                                                        bottomRight: Radius.circular(0.0),
                                                                                        topLeft: Radius.circular(10.0),
                                                                                        topRight: Radius.circular(10.0),
                                                                                      ),
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 160.0,
                                                                                      height: 32.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFF51A1FF),
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(0.0),
                                                                                          bottomRight: Radius.circular(0.0),
                                                                                          topLeft: Radius.circular(10.0),
                                                                                          topRight: Radius.circular(10.0),
                                                                                        ),
                                                                                      ),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            'Humidity',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Poppins',
                                                                                                  color: Colors.white,
                                                                                                  fontSize: 16.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Material(
                                                                                    color: Colors.transparent,
                                                                                    elevation: 2.0,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(10.0),
                                                                                        bottomRight: Radius.circular(10.0),
                                                                                        topLeft: Radius.circular(0.0),
                                                                                        topRight: Radius.circular(0.0),
                                                                                      ),
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 160.0,
                                                                                      height: 45.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(10.0),
                                                                                          bottomRight: Radius.circular(10.0),
                                                                                          topLeft: Radius.circular(0.0),
                                                                                          topRight: Radius.circular(0.0),
                                                                                        ),
                                                                                      ),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Text(
                                                                                          '$humidity %',
                                                                                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                fontFamily: 'Poppins',
                                                                                                color: Color(0xFF51A1FF),
                                                                                                fontSize: 20.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  theme:
                                                                      ExpandableThemeData(
                                                                    tapHeaderToExpand:
                                                                        true,
                                                                    tapBodyToExpand:
                                                                        false,
                                                                    tapBodyToCollapse:
                                                                        false,
                                                                    headerAlignment:
                                                                        ExpandablePanelHeaderAlignment
                                                                            .center,
                                                                    hasIcon:
                                                                        true,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]
                                                .addToStart(
                                                    SizedBox(height: 30.0))
                                                .addToEnd(
                                                    SizedBox(height: 500.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: wrapWithModel(
                model: _model.navbarModel,
                updateCallback: () => safeSetState(() {}),
                child: NavbarWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
