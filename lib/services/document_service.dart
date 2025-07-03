import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/document.dart';

class DocumentService {
  static final DocumentService _instance = DocumentService._internal();
  factory DocumentService() => _instance;
  DocumentService._internal();

  final List<Document> _documents = [];

  List<Document> getDocumentsByEmail(String email) {
    return _documents.where((doc) => doc.email == email).toList();
  }

  Future<String> saveDocument(File file, String email) async {
    final directory = await getApplicationDocumentsDirectory();
    final documentsDir = Directory('${directory.path}/documents');
    
    if (!await documentsDir.exists()) {
      await documentsDir.create(recursive: true);
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final savedFile = await file.copy('${documentsDir.path}/$fileName');

    final document = Document(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: file.path.split('/').last,
      email: email,
      filePath: savedFile.path,
      uploadDate: DateTime.now(),
      fileSize: await file.length(),
    );

    _documents.add(document);
    return savedFile.path;
  }

  Document? getDocumentById(String id) {
    try {
      return _documents.firstWhere((doc) => doc.id == id);
    } catch (e) {
      return null;
    }
  }

  void deleteDocument(String id) {
    _documents.removeWhere((doc) => doc.id == id);
  }
} 