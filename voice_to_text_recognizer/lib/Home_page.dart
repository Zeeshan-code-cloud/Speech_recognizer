// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text =
      "Click on the Mic button to recognized your voice and convert into text";
  bool isavailable = true;
  final speech_to_text_plugin = SpeechToText();
  bool stratRecord = false;
  @override
  void initState() {
    Make();
    // TODO: implement initState
    super.initState();
  }

  Make() async {
    isavailable = await speech_to_text_plugin.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Voice Recognizer",
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: GestureDetector(
                onTapUp: (value) {
                  stratRecord = false;

                  setState(() {});
                  speech_to_text_plugin.stop();
                },
                onTapDown: (value) {
                  stratRecord = true;
                  setState(() {});
                  if (isavailable) {
                    speech_to_text_plugin.listen(onResult: (value) {
                      setState(() {
                        text = value.recognizedWords;
                      });
                    });
                  }
                },
                child: AvatarGlow(
                  animate: stratRecord ? true : false,
                  glowColor: Colors.orange,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(
                        stratRecord ? Icons.speaker : Icons.speaker_outlined),
                  ),
                ))));
  }
}
