import 'package:convida/app/screens/about_screen/about_controller.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter/material.dart';

class AboutWidget extends StatefulWidget {
  @override
  _AboutWidgetState createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  final String linkUfpr = "www.ufpr.br/portalufpr/";
  final String linkConvida = "convida.ufpr.br/portal/";

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    try {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Sobre", style: TextStyle(color: Colors.black)),
            centerTitle: true,
            iconTheme: IconThemeData(color: kPrimaryColor)),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            (queryData.orientation == Orientation.portrait)
                ? Container(
                    height: queryData.size.height / 6,
                    width: queryData.size.width / 6,
                    child: Image.asset(
                      //Image:
                      "assets/logos/logo-ufprconvida.png",
                      scale: 2,
                    ),
                  )
                : Container(
                    height: queryData.size.height / 4,
                    width: queryData.size.width / 4,
                    child: Image.asset(
                      //Image:
                      "assets/logos/logo-ufprconvida.png",
                      scale: 2,
                    ),
                  ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: const Text(
                    "As informações contidas neste aplicativo são de exclusiva responsabilidade dos usuários, tendo em vista que a alimentação dos dados é colaborativa e autorregulada.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: const Text(
                    //
                    "Equipe de Desenvolvimento:\n              - Eduardo Zen Motter\n              - Erick Rampim Garcia\n              - Lia Daiely Magalhães",
                    //O Aplicativo UFPRConVIDA foi desenvolvido por Eduardo Zen Motter, Erick Rampim Garcia e Lia Daiely Magalhães, estudantes de Tecnologia em Análise e Desenvolvimento de Sistemas - SEPT - UFPR
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      //"Agradecemos em especial aos professores: Alexander Robert Kutzke, Andreia de Jesus, Lis Andrea Pereira Soboll, Razer Anthom Nizer Rojas Montaño, os quais permitiram o devensolvimento e nos auxiliaram dando suporte para a criação deste aplicativo."
                      "Equipe Técnica:",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      //"Agradecemos em especial aos professores: Alexander Robert Kutzke, Andreia de Jesus, Lis Andrea Pereira Soboll, Razer Anthom Nizer Rojas Montaño, os quais permitiram o devensolvimento e nos auxiliaram dando suporte para a criação deste aplicativo."
                      "              - Alexander Robert Kutzke",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      //"Agradecemos em especial aos professores: Alexander Robert Kutzke, Andreia de Jesus, Lis Andrea Pereira Soboll, Razer Anthom Nizer Rojas Montaño, os quais permitiram o devensolvimento e nos auxiliaram dando suporte para a criação deste aplicativo."
                      "              - Andreia de Jesus",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      //"Agradecemos em especial aos professores: Alexander Robert Kutzke, Andreia de Jesus, Lis Andrea Pereira Soboll, Razer Anthom Nizer Rojas Montaño, os quais permitiram o devensolvimento e nos auxiliaram dando suporte para a criação deste aplicativo."
                      "              - Lis Andrea Pereira Soboll",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      //"Agradecemos em especial aos professores: Alexander Robert Kutzke, Andreia de Jesus, Lis Andrea Pereira Soboll, Razer Anthom Nizer Rojas Montaño, os quais permitiram o devensolvimento e nos auxiliaram dando suporte para a criação deste aplicativo."
                      "              - Razer Anthom N. R. Montaño ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    //
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: const Text(
                  "Apoio Técnico: \n              - AGTIC",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: const Text(
                    "Todas as imagens utilizadas foram produzidas pelos seguintes autores, \"Freepik\", \"Nikita Golubev\", \"Eucalyp\" e \"pongsakornRed\". Todos eles podem ser encontrados no site \"www.flaticon.com\"",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify),
              ),
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Mais informações em: ",
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                    child: Text("$linkUfpr",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline)),
                    onTap: () => openLink(linkUfpr, context)),
                InkWell(
                    child: Text("$linkConvida",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline)),
                    onTap: () => openLink(linkConvida, context))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Versão: ",
                  style: TextStyle(fontSize: 16),
                ),
                Text(kAppVersion,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ))
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      );
      // );
    } catch (e) {
      //print(e.toString());
      return CircularProgressIndicator();
    }
  }

//   openLink(String link) async {
//     String url;
//     if (link.contains("convida")) {
//       url = "http://$link";
//     } else {
//       url = "https://$link";
//     }
//
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       showError("Impossível abrir o link",
//           "Não foi possível abrir esse link: $link", context);
//     }
//   }
}
