// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HomeChartStruct extends FFFirebaseStruct {
  HomeChartStruct({
    double? temperature,
    double? humidity,
    double? gas,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _temperature = temperature,
        _humidity = humidity,
        _gas = gas,
        super(firestoreUtilData);

  // "Temperature" field.
  double? _temperature;
  double get temperature => _temperature ?? 32.0;
  set temperature(double? val) => _temperature = val;

  void incrementTemperature(double amount) =>
      temperature = temperature + amount;

  bool hasTemperature() => _temperature != null;

  // "Humidity" field.
  double? _humidity;
  double get humidity => _humidity ?? 70.0;
  set humidity(double? val) => _humidity = val;

  void incrementHumidity(double amount) => humidity = humidity + amount;

  bool hasHumidity() => _humidity != null;

  // "Gas" field.
  double? _gas;
  double get gas => _gas ?? 100.0;
  set gas(double? val) => _gas = val;

  void incrementGas(double amount) => gas = gas + amount;

  bool hasGas() => _gas != null;

  static HomeChartStruct fromMap(Map<String, dynamic> data) => HomeChartStruct(
        temperature: castToType<double>(data['Temperature']),
        humidity: castToType<double>(data['Humidity']),
        gas: castToType<double>(data['Gas']),
      );

  static HomeChartStruct? maybeFromMap(dynamic data) => data is Map
      ? HomeChartStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Temperature': _temperature,
        'Humidity': _humidity,
        'Gas': _gas,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Temperature': serializeParam(
          _temperature,
          ParamType.double,
        ),
        'Humidity': serializeParam(
          _humidity,
          ParamType.double,
        ),
        'Gas': serializeParam(
          _gas,
          ParamType.double,
        ),
      }.withoutNulls;

  static HomeChartStruct fromSerializableMap(Map<String, dynamic> data) =>
      HomeChartStruct(
        temperature: deserializeParam(
          data['Temperature'],
          ParamType.double,
          false,
        ),
        humidity: deserializeParam(
          data['Humidity'],
          ParamType.double,
          false,
        ),
        gas: deserializeParam(
          data['Gas'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'HomeChartStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HomeChartStruct &&
        temperature == other.temperature &&
        humidity == other.humidity &&
        gas == other.gas;
  }

  @override
  int get hashCode => const ListEquality().hash([temperature, humidity, gas]);
}

HomeChartStruct createHomeChartStruct({
  double? temperature,
  double? humidity,
  double? gas,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HomeChartStruct(
      temperature: temperature,
      humidity: humidity,
      gas: gas,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HomeChartStruct? updateHomeChartStruct(
  HomeChartStruct? homeChart, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    homeChart
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHomeChartStructData(
  Map<String, dynamic> firestoreData,
  HomeChartStruct? homeChart,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (homeChart == null) {
    return;
  }
  if (homeChart.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && homeChart.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final homeChartData = getHomeChartFirestoreData(homeChart, forFieldValue);
  final nestedData = homeChartData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = homeChart.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHomeChartFirestoreData(
  HomeChartStruct? homeChart, [
  bool forFieldValue = false,
]) {
  if (homeChart == null) {
    return {};
  }
  final firestoreData = mapToFirestore(homeChart.toMap());

  // Add any Firestore field values
  homeChart.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHomeChartListFirestoreData(
  List<HomeChartStruct>? homeCharts,
) =>
    homeCharts?.map((e) => getHomeChartFirestoreData(e, true)).toList() ?? [];
