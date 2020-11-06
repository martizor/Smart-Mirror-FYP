import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';

class Voice extends StatefulWidget {
  @override
  _ModulesState createState() => _ModulesState();
}

class _ModulesState extends State<Voice> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";


  void Add_Voice(String result) async {
    var url= "http://192.168.0.13:5000/Voice_post";
    var body = json.encode({"voice": result});
    var response2 = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    if (response2.body == "Done") {
      print("Success Posted");
    }
    else{
      print("Failed");
    }
  }

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler( () {
          setState(() {
            _isListening = false;
            if (_isListening == false && resultText != "") {
              Add_Voice(resultText);
            }
          });
    });
    _speechRecognition.activate().then(
          (result) => setState(() =>  _isAvailable = result),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice",style: TextStyle(fontFamily: 'RobotoMono',fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/Modules')
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                AvatarGlow(
                  animate: _isListening,
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 75.0,
                  duration: const Duration(milliseconds:  2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child:FloatingActionButton(
                  heroTag: "Mic",
                  child: Icon(Icons.mic),
                  onPressed: () {
                    if (_isAvailable && !_isListening)
                      _speechRecognition
                          .listen(locale: "en_AU")
                          .then((result) => setState(() => print('$result')));
                  },
                  backgroundColor: Colors.pink,
                ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.cyanAccent[100],
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Text(
              resultText,
              style: TextStyle(fontSize: 24.0),
            ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

