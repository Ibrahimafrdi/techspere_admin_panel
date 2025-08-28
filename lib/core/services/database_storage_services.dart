import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseStorageServices {
  Future<String> uploadHtmlFileToFirebase(
    html.File htmlFile,
  ) async {
    try {
      print('uploading..................');
      // Create a reference to the location where you want to store the file
      final storageRef = FirebaseStorage.instance.ref().child('/images');

      // Use the `putBlob` method to upload the file
      final uploadTask = storageRef.putBlob(htmlFile);
      // Wait for the upload to complete
      final snapshot =
          await uploadTask.whenComplete(() => print('upload complete'));

      // Optionally, get the download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();
      print('File uploaded successfully! Download URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      return '';
    }
  }
}
