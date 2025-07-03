class Document {
  final String id;
  final String name;
  final String email;
  final String filePath;
  final DateTime uploadDate;
  final int fileSize;

  Document({
    required this.id,
    required this.name,
    required this.email,
    required this.filePath,
    required this.uploadDate,
    required this.fileSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'filePath': filePath,
      'uploadDate': uploadDate.toIso8601String(),
      'fileSize': fileSize,
    };
  }

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      filePath: json['filePath'],
      uploadDate: DateTime.parse(json['uploadDate']),
      fileSize: json['fileSize'],
    );
  }
} 