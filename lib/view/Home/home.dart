import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isChecked = false;
  var cont = 0;
  void onPressed() {
    cont++;
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                }),
            title: const Text('Atividade'),
            subtitle: const Text('Descrição'),
            trailing: const Icon(Icons.delete),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Título'),
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Descrição'),
                ),
                ElevatedButton(
                    onPressed: onPressed, child: const Text('Adicionar'))
              ],
            )),
          )
        ],
      ),
    );
  }
}
