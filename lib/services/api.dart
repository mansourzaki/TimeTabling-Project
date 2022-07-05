import 'package:http/http.dart' as http;

Future sendInput() async {
  
}

Future getSecondInput() async {}

Future getOutput(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}
