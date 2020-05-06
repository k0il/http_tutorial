import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

ProgressDialog pr;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () {
                konekHttp();
              },
              color: Colors.lightBlueAccent,
              child:
                  Text('Connect Http', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void konekHttp() async {
    pr.show();
    try {
      var url = "https://k0il.net/testpost.php";
      var response = await http.post(url, body: {
        'user': "k0il",
        'pass': "123456"
      }).timeout(const Duration(seconds: 90));

      print(response.body);
      pr.hide();
      Fluttertoast.showToast(
          msg: response.body, toastLength: Toast.LENGTH_LONG);
    } on TimeoutException catch (e) {
      pr.hide();
      print("Connection Timeout");
      Fluttertoast.showToast(
          msg: "Connection Timeout", toastLength: Toast.LENGTH_LONG);
    } on Error catch (e) {
      pr.hide();
      print("Http Connection Error");
      Fluttertoast.showToast(
          msg: "Http Connection Error", toastLength: Toast.LENGTH_LONG);
    }
  }
}
