import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/model/event.dart';
import 'package:event_planning/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, option) =>
              Event.fromFireStore(snapshot.data()),
          toFirestore: (event, _) => event.toFireStore(),
        );
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (myUser, _) => myUser.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot = await getUserCollection().doc(id).get();
    return querySnapshot.data();
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    var collection = getEventCollection(uId); // collection
    var docRef = collection.doc(); // document
    event.id = docRef.id; // auto id
    return docRef.set(event); // add event
  }
}

//  json(Java Script Object Notation) =>  Format data
// json Object => {} , json Array => []
/*
firebase => json
developers => object
function convert json to object------> (from Fire store)
function convert object to json------> (to Fire store)
 */
