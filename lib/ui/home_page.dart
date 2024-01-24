import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var name = Hive.box('myBox');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                hintText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  name.put(1, title.text);
                },
                child: const Text('Add user change')),
            const SizedBox(height: 20),
            Text('${name.get(1)}', style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
