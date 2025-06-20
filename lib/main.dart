import 'package:flutter/material.dart';

void main() {
  runApp(NoiteAquiApp());
}

class NoiteAquiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noite Aqui',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Noite Aqui')),
        body: Center(child: Text('App base funcionando')),
      ),
    );
  }
}