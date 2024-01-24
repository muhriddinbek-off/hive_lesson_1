import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController title = TextEditingController();
  TextEditingController edit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var name = Hive.box('myBox');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
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
                  name.add(title.text);
                  title.clear();
                },
                child: const Text('Add user change')),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: name.values.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(name.values.toList()[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              edit.text = name.values.toList()[index];
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: TextField(
                                            controller: edit,
                                            decoration: const InputDecoration(
                                              hintText: 'Edit',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              name.putAt(index, edit.text);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Edit')),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              name.deleteAt(index);
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
