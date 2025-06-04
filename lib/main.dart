import 'package:flutter/material.dart';
import 'natoPhoneticAlphabet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NATO Phonetic Alphabet Translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'NATO phonetic alphabet translator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String translatedWord = "";

  void wordSubmitted(String word) {
    List<String> tr = [];
    setState(() {
      for (int i = 0; i < word.length; i++){
        String str = word[i];
        String? translated = natoPhoneticAlphabet[str];
        //if char not in alphabet
        translated ??= word[i];
        //add to the string list of translated words
        tr.add(translated);
      }
      //make a string that contains the translated results
      for(String str in tr){
        translatedWord = translatedWord + str + '\n';
      }
    });
  }

  dialogBox(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          content: const Column(
              mainAxisSize: MainAxisSize.min
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(widget.title),
      ),
      bottomSheet:
        TextField(
          decoration:  InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Say something'
          ),
          onSubmitted: (String value) async{
            translatedWord = "";
            wordSubmitted(value);
          },
        ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.shade100,
          image: const DecorationImage(image : AssetImage("assets/images/compass.png" ), opacity: 0.1)
        ),
      child:
        Center(
          child:
            SingleChildScrollView(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    translatedWord,
                    style:  TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ],
              ),
            ),
        ),
    ),
    );
  }
}
