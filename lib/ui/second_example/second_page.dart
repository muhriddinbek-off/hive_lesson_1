import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/user.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var userDate = Hive.box('user');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Second example'),
      ),
      body: Column(
        children: [
          _getUser(name, 'Full Name'),
          _getUser(phone, 'Phone Number'),
          Expanded(
              child: ListView.builder(
            itemCount: userDate.values.length,
            itemBuilder: (context, index) {
              List<User> data = userDate.values.toList().cast();
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(data[index].name),
                subtitle: Text(data[index].phoneNumber.toString()),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {});
                    userDate.deleteAt(index);
                  },
                ),
              );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            userDate.add(User(name: name.text, phoneNumber: int.parse(phone.text)));
            name.clear();
            phone.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _getUser(TextEditingController controller, String title) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
