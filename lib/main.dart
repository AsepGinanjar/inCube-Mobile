import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:in_cube/backend/mqtt/mqtt_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});

  // Tambahkan variabel untuk MQTT
  late MqttClient mqttClient;
  String mqttMessage = "No Data"; // Pesan terbaru dari MQTT
  bool isMqttConnected = false; // Status koneksi MQTT

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = inCubeFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 5000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
    // Inisialisasi MQTT
    _initializeMqtt();
  }

  @override
  void dispose() {
    authUserSub.cancel();
    mqttClient.disconnect();
    super.dispose();
  }

  // Inisialisasi MQTT
  Future<void> _initializeMqtt() async {
    try {
      mqttClient =
          await connect(); // Gunakan fungsi `connect` dari `mqtt_config.dart`
      mqttClient.subscribe(
          "IC0001/Temp", MqttQos.atMostOnce); // Langganan ke topik
      mqttClient.subscribe("IC0001/Humid", MqttQos.atMostOnce);

      // Dengarkan pesan dari broker
      mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final MqttPublishMessage message = c![0].payload as MqttPublishMessage;
        final String payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);

        // Update the state with the new data based on the topic
        setState(() {
          if (c[0].topic == "IC0001/Temp") {
            mqttMessage = "Temperature: $payload"; // Store temperature data
          } else if (c[0].topic == "IC0001/Humid") {
            mqttMessage = "Humidity: $payload"; // Store humidity data
          }
          isMqttConnected = true;
        });
        print('MQTT Message Received: $payload');
      });
    } catch (e) {
      print('Error connecting to MQTT: $e');
      setState(() {
        isMqttConnected = false;
      });
    }
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'InCube',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
      builder: (context, child) {
        // Menyediakan data MQTT untuk seluruh aplikasi
        return Stack(
          children: [
            child!,
            if (!isMqttConnected) // Menampilkan pesan jika MQTT tidak terhubung
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  color: Colors.redAccent,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'MQTT not connected',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
