import 'package:firebase_storage/firebase_storage.dart';


Reference get firebaseStorage => FirebaseStorage.instance.ref();

class AuthFireStorage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String?>> getImages(List<String> imagePaths) async {
    List<String> downloadURLs = [];
    try {
      for (String path in imagePaths) {
        final imagePath = firebaseStorage.child(path);
        final downloadURL = await imagePath.getDownloadURL();

        downloadURLs.add(downloadURL);
      }

    //  logger.e('Image Path is $downloadURLs');
      return downloadURLs;
    } catch (e) {
     // logger.e('Image can not retreve $e');
    }
    return [];
  }
}
