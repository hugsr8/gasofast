import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:gasofast/src/models/gasolinera_model.dart';

class GasolineraProvider{

  final cloud_firestore.FirebaseFirestore _firestore = cloud_firestore.FirebaseFirestore.instance;

  Future<List<GasolineraModel>> getGasolineras() async {
    List<GasolineraModel> gasolinerasList = [];

    cloud_firestore.CollectionReference reference  = _firestore.collection('gas_stations');

    final cloud_firestore.QuerySnapshot result = await reference.get();
    final List<cloud_firestore.DocumentSnapshot> documents = result.docs;
    
    for (var doc in documents) { 
      gasolinerasList.add(GasolineraModel(doc.reference.id, doc['location_latitude'], doc['location_longitude'], 
      doc['name'], doc['price_diesel'], doc['price_especial'], doc['price_regular'], doc['cover_img']));
    }

    return gasolinerasList;
  }

  Future<List<GasolineraModel>> getGasolinera(String idGasolinera) async {

    String idGasolineraFinal = idGasolinera;

    if(idGasolinera.contains('(')){
      int indexParentesis1 = idGasolinera.indexOf('(');
      int indexParentesis2 = idGasolinera.indexOf(')');
      idGasolineraFinal = idGasolinera.substring(indexParentesis1 + 1, indexParentesis2);
    }

    

    List<GasolineraModel> gasolinerasList = [];
    
    cloud_firestore.CollectionReference reference  = _firestore.collection('gas_stations');

    final cloud_firestore.DocumentSnapshot doc = await reference.doc(idGasolineraFinal).get();
    
    gasolinerasList.add(GasolineraModel(doc.reference.id, doc['location_latitude'], doc['location_longitude'], 
      doc['name'], doc['price_diesel'], doc['price_especial'], doc['price_regular'], doc['cover_img']));

    return gasolinerasList;
  }
}