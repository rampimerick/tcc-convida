import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  final TextEditingController _searchController =
  new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: "Endereço: ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.5)),
                  icon: Icon(Icons.event_note)),
              //Validations:
              validator: (value) {
                if (value.isEmpty) {
                  return 'Entre com um endereço válido';
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}
