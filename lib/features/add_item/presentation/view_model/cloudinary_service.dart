import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName = "dykjgar3u";
  final String uploadPreset = "item_image";

  Future<String> uploadImage(File imageFile) async {
    final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    final request = http.MultipartRequest("POST", url);
    request.fields['upload_preset'] = uploadPreset;
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        return data['secure_url'];
      } else {
        final errorResponse = await response.stream.bytesToString();
        print('خطأ في رفع الصورة: ${response.statusCode} - $errorResponse');
        throw Exception("فشل رفع الصورة عل ");
      }
    } catch (e) {
      print('خطأ في الاتصال بـ Cloudinary: $e');
      throw Exception("فشل الاتصال بـ ");
    }
  }
}
