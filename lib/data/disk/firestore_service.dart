import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hits_app/data/disk/model/firestore_track.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<FirestoreTrack>> getFavouriteTracks() {
    return _db
        .collection("users/" + FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => FirestoreTrack.fromJson(doc.data()))
        .toList());
  }

  Future<void> setTrack(FirestoreTrack track) {
    var options = SetOptions(merge: true);
    return _db
        .collection("users/" + FirebaseAuth.instance.currentUser!.uid)
        .doc(track.id)
        .set(track.toJson(), options);
  }

  Future<void> deleteTrack(String trackId) {
    return _db
        .collection("users/" + FirebaseAuth.instance.currentUser!.uid)
        .doc(trackId)
        .delete();
  }
}
