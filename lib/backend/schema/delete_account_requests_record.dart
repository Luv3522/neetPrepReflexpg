import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DeleteAccountRequestsRecord extends FirestoreRecord {
  DeleteAccountRequestsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  int? _userId;
  int get userId => _userId ?? 0;
  bool hasUserId() => _userId != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  void _initializeFields() {
    _userId = castToType<int>(snapshotData['userId']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _uid = snapshotData['uid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('DeleteAccountRequests');

  static Stream<DeleteAccountRequestsRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => DeleteAccountRequestsRecord.fromSnapshot(s));

  static Future<DeleteAccountRequestsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => DeleteAccountRequestsRecord.fromSnapshot(s));

  static DeleteAccountRequestsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DeleteAccountRequestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DeleteAccountRequestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DeleteAccountRequestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DeleteAccountRequestsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DeleteAccountRequestsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDeleteAccountRequestsRecordData({
  int? userId,
  DateTime? createdAt,
  String? uid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'createdAt': createdAt,
      'uid': uid,
    }.withoutNulls,
  );

  return firestoreData;
}

class DeleteAccountRequestsRecordDocumentEquality
    implements Equality<DeleteAccountRequestsRecord> {
  const DeleteAccountRequestsRecordDocumentEquality();

  @override
  bool equals(
      DeleteAccountRequestsRecord? e1, DeleteAccountRequestsRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.createdAt == e2?.createdAt &&
        e1?.uid == e2?.uid;
  }

  @override
  int hash(DeleteAccountRequestsRecord? e) =>
      const ListEquality().hash([e?.userId, e?.createdAt, e?.uid]);

  @override
  bool isValidKey(Object? o) => o is DeleteAccountRequestsRecord;
}
