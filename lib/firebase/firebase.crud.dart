import 'package:cloud_firestore/cloud_firestore.dart';

import '../Respones/response.dart';

final FirebaseFirestore _firebase=FirebaseFirestore.instance;
final CollectionReference _collection=_firebase.collection('Tasks');

class FirebaseCrud{


  static Future<Respones>addTask({required  dateTime,required title,required subTitle,required description})async{
Respones respones=Respones();
    DocumentReference documentReference=_collection.doc();
    Map<String,dynamic>data=<String,dynamic>{
'dateTime':dateTime,

'title':title,
'subTitle':subTitle,
'description':description,

    };

    var result=await documentReference.set(data)
    .whenComplete(() {
      respones.code=200;
      respones.message="Successfuly Add";
      
    }).catchError((e){
      
respones.code=500;
respones.message=e;
    });

return respones;

  }

  static Stream<QuerySnapshot> readTask(){
    final CollectionReference allTasks=_collection;
    return allTasks.snapshots();
  }

  static Future<Respones>updateTasks({ required  id,required title,required subTitle,required description})async{
    Respones respones=Respones();
    DocumentReference documentReference=_collection.doc(id);
    Map<String,dynamic>data=<String,dynamic>{
      'id':id,
'title':title,
'subTitle':subTitle,
'description':description,

    };
    await documentReference.update(data)
    .whenComplete(() {
      respones.code=200;
      respones.message="Successfuly Add";
      
    }).catchError((e){
respones.code=500;
respones.message=e;
    });

return respones;
    
  }
  //delete

  static Future<Respones> deleteTask({required String id }) async{
Respones respones=Respones();
DocumentReference documentReference=_collection.doc(id);
await documentReference.delete()
.whenComplete(() {
      respones.code=200;
      respones.message="Successfuly Add";
      
    }).catchError((e){
respones.code=500;
respones.message=e;
    });

return respones;
    
  }



  }


