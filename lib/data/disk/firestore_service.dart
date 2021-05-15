import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hits_app/data/disk/model/firestore_track.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream<List<FirestoreTrack>> getAllTracks() {
  //   return _db
  //       .collection(
  //       "users/" + FirebaseAuth.instance.currentUser!.uid
  //       ).snapshots()
  //       .map((snapshot) => snapshot.docs
  //       .map((doc) => FirestoreTrack))
  // }

  // Stream<FirestoreTrack?> getTrack(String id) {
  //   return null;
  // }
  //
  // Future<void> setTrack(List<FirestoreTrack> tracks) {
  //
  // }
  //
  // Future<void>
}
