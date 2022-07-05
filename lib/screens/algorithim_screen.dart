import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlgorithimCalls extends StatefulWidget {
  const AlgorithimCalls({Key? key}) : super(key: key);

  @override
  State<AlgorithimCalls> createState() => _AlgorithimCallsState();
}

class _AlgorithimCallsState extends State<AlgorithimCalls> {
  http.Response? response1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Algorithim Functions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  response1 = await http.get(
                    Uri.parse('http://127.0.0.1:5000/generateoutput'),
                  );
                  setState(() {});
                },
                child: Text('Generate Final Output')),
            Text(response1 == null ? '' : response1!.statusCode.toString()),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
