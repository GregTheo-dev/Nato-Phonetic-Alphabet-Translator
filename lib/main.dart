import 'package:flutter/material.dart';
import 'alphabet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nautical Alphabet Translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

  String translated_word = "";

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
        translated_word = translated_word + str + '\n';
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
      body: Center(
        child: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                translated_word,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Say something'
                ),
                onSubmitted: (String value) async{
                  wordSubmitted(value);
                },
              ),
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
