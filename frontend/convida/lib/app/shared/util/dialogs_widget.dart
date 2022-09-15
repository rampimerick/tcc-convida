library my_prj.util.dialogs;

import 'package:flutter/material.dart';

void showSuccess(String s, String route, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(s),
        content: new Text("Pressione 'Ok' para continuar"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
              if (route == "nothing"){

              }
              else if (route == "pop") {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacementNamed(route);
              }
            },
          ),
        ],
      );
    },
  );
}
void showConfirm({String title, String content, Function onPressed, BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Sim"),
            onPressed: onPressed,
          ),
          new FlatButton(
            child: new Text("Não"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

void showError(String title, String content, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

// errorStatusCode(int statusCode, BuildContext context){
//   if (statusCode == 401) {
//     showError("Erro 401", "Não autorizado, favor logar novamente", context);
//   } else if (statusCode == 404) {
//     showError("Erro 404", "Evento ou usuário não foi encontrado", context);
//   } else if (statusCode == 500) {
//     showError("Erro 500", "Erro no servidor, favor tente novamente mais tarde",
//         context);
//   } else {
//     showError("Erro Desconhecido", "StatusCode: $statusCode", context);
//   }
// }
