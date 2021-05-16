import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hits_app/data/disk/model/firestore_track.dart';

class FirestoreService {
  Stream<List<FirestoreTrack>> getLikedTracks() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("liked_tracks")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => FirestoreTrack.fromJson(doc.data()))
        .toList());
  }

  Future<void> setTrack(FirestoreTrack track) {
    var options = SetOptions(merge: true);
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("liked_tracks")
        .doc(track.id)
        .set(track.toJson(), options)
        .then((value) => print("Track set"))
        .catchError((error) => print("Failed to set track: $error"));
  }

  Future<void> deleteTrack(String trackId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("liked_tracks")
        .doc(trackId)
        .delete()
        .then((value) => print("Track deleted"))
        .catchError((error) => print("Failed to delete track: $error"));
  }

  Future<void> addUserIfNeeded() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
          if (value.exists) {
            FirebaseFirestore.instance
                .collection("users")
                .add({"uid": FirebaseAuth.instance.currentUser!.uid,})
                .then((value) => print("User added"))
                .catchError((error) => print("Failed to add user: $error"));
          }
    });
  }

  Future<void> deleteLikedTracks() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("liked_tracks")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("liked_tracks")
          .doc(doc.id)
          .delete()
     ));
  }
}
