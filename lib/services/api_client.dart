import 'package:flutter_assesment/constants/api_urls.dart';
import 'package:http/http.dart' as http;
class ApiClient {
final String baseUrl=ApiUrls.baseUrl ;
Future<Map<String,dynamic>> post(
    String endpoint,
    Map<String, dynamic> body) async{
  final response  = await http.post(
    Uri.parse('$baseUrl/$endpoint'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: body.isNotEmpty ? body : null,
  );

  if(response.statusCode >= 200 && response.statusCode < 300) {
    return Future.value({
      'status': true,
      'data': response.body,
    });
  }else{
    throw Exception(
      'Failed to post data: ${response.statusCode} - ${response.reasonPhrase}',
    );
  }

}


}