import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataStreamRecord extends FirestoreRecord {
  DataStreamRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Temperature" field.
  double? _temperature;
  double get temperature => _temperature ?? 0.0;
  bool hasTemperature() => _temperature != null;

  // "Humidity" field.
  double? _humidity;
  double get humidity => _humidity ?? 0.0;
  bool hasHumidity() => _humidity != null;

  // "Gas" field.
  double? _gas;
  double get gas => _gas ?? 0.0;
  bool hasGas() => _gas != null;

  void _initializeFields() {
    _temperature = castToType<double>(snapshotData['Temperature']);
    _humidity = castToType<double>(snapshotData['Humidity']);
    _gas = castToType<double>(snapshotData['Gas']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('DataStream');

  static Stream<DataStreamRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DataStreamRecord.fromSnapshot(s));

  static Future<DataStreamRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DataStreamRecord.fromSnapshot(s));

  static DataStreamRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DataStreamRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DataStreamRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DataStreamRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DataStreamRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DataStreamRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDataStreamRecordData({
  double? temperature,
  double? humidity,
  double? gas,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Temperature': temperature,
      'Humidity': humidity,
      'Gas': gas,
    }.withoutNulls,
  );

  return firestoreData;
}

class DataStreamRecordDocumentEquality implements Equality<DataStreamRecord> {
  const DataStreamRecordDocumentEquality();

  @override
  bool equals(DataStreamRecord? e1, DataStreamRecord? e2) {
    return e1?.temperature == e2?.temperature &&
        e1?.humidity == e2?.humidity &&
        e1?.gas == e2?.gas;
  }

  @override
  int hash(DataStreamRecord? e) =>
      const ListEquality().hash([e?.temperature, e?.humidity, e?.gas]);

  @override
  bool isValidKey(Object? o) => o is DataStreamRecord;
}
