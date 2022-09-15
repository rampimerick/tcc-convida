import 'package:flutter/material.dart';
import 'package:convida/app/shared/global/constants.dart';

class OrganizationWidget extends StatefulWidget {
  final String healthType;
  final String sportType;
  final String partyType;
  //final String onlineType;
  final String artType;
  final String faithType;
  final String studyType;
  final String othersType;
  final String dataType;

  OrganizationWidget(
      {Key key,
      @required this.healthType,
      @required this.sportType,
      @required this.partyType,
      //@required this.onlineType,
      @required this.artType,
      @required this.faithType,
      @required this.studyType,
      @required this.othersType,
      @required this.dataType})
      : super(key: key);

  @override
  _OrganizationWidgetState createState() => _OrganizationWidgetState(
      healthType,
      sportType,
      partyType,
      //onlineType,
      artType,
      faithType,
      studyType,
      othersType,
      dataType);
}

class _OrganizationWidgetState extends State<OrganizationWidget> {
  String healthType;
  String sportType;
  String partyType;
  //String onlineType;
  String artType;
  String faithType;
  String studyType;
  String othersType;
  String dataType;

  _OrganizationWidgetState(
      this.healthType,
      this.sportType,
      this.partyType,
      //this.onlineType,
      this.artType,
      this.faithType,
      this.studyType,
      this.othersType,
      this.dataType);

  Color healthColor = Colors.white;
  Color sportColor = Colors.white;
  Color partyColor = Colors.white;
  //Color onlineColor = Colors.white;
  Color artColor = Colors.white;
  Color faithColor = Colors.white;
  Color studyColor = Colors.white;
  Color othersColor = Colors.white;

  Color dayColor = Colors.white;
  Color weekColor = Colors.white;
  Color monthColor = Colors.white;

  @override
  void initState() {
    if (healthType == 'Saúde e Bem-estar') {
      healthColor = Color.fromRGBO(249, 143, 155, 1);
    }
    if (sportType == 'Esporte e Lazer') {
      sportColor = Color.fromRGBO(148, 197, 151, 1);
    }
    if (partyType == 'Festas e Comemorações') {
      partyColor = Color.fromRGBO(152, 137, 206, 1);
    }
    // if (onlineType == 'Online') {
    //   onlineColor = Colors.cyan;
    // }
    if (artType == 'Arte e Cultura') {
      artColor = Color.fromRGBO(234, 108, 160, 1);
    }
    if (faithType == 'Fé e Espiritualidade') {
      faithColor = Color.fromRGBO(234, 196, 38, 1);
    }
    if (studyType == 'Acadêmico e Profissional') {
      studyColor = Color.fromRGBO(108, 159, 221, 1);
    }
    if (othersType == 'Outros') {
      othersColor = Color.fromRGBO(186, 186, 186, 1);
    }
    if (dataType == 'week') {
      weekColor = Color(0xFF4c84cd);
    }
    if (dataType == 'day') {
      dayColor = Color(0xFF4c84cd);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        moveBack();
        return null;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Organização e Filtros")),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                child: Text(
                  "Tipo de eventos:",
                  style: TextStyle(
                      color: kPrimaryColor, //Color(secondaryColor),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8.0,
                children: <Widget>[
                  CustomFilterButton(
                    text: 'Saúde e Bem-estar',
                    image: 'assets/health.png',
                    color: healthColor,
                    standardColor: Color.fromRGBO(249, 143, 155, 1),
                    onPressed: () {
                      setState(() {
                        if (healthType == "Saúde e Bem-estar") {
                          healthType = "X";
                          healthColor = Colors.white;
                        } else {
                          healthType = "Saúde e Bem-estar";
                          healthColor = Color.fromRGBO(249, 143, 155, 1);
                        }
                      });
                    },
                  ),
                  CustomFilterButton(
                    text: 'Esporte e Lazer',
                    image: 'assets/sports.png',
                    color: sportColor,
                    standardColor: Color.fromRGBO(148, 197, 151, 1),
                    onPressed: () {
                      setState(() {
                        if (sportType == "Esporte e Lazer") {
                          sportType = "X";
                          sportColor = Colors.white;
                        } else {
                          sportType = "Esporte e Lazer";
                          sportColor = Color.fromRGBO(148, 197, 151, 1);
                        }
                      });
                    },
                  ),
                  CustomFilterButton(
                    text: 'Festas e Comemorações',
                    image: 'assets/party.png',
                    color: partyColor,
                    standardColor: Color.fromRGBO(152, 137, 206, 1),
                    onPressed: () {
                      setState(() {
                        if (partyType == "Festas e Comemorações") {
                          partyType = "X";
                          partyColor = Colors.white;
                        } else {
                          partyType = "Festas e Comemorações";
                          partyColor = Color.fromRGBO(152, 137, 206, 1);
                        }
                      });
                    },
                  ),
                  CustomFilterButton(
                    text: 'Arte e Cultura',
                    image: 'assets/art.png',
                    color: artColor,
                    standardColor: Color.fromRGBO(234, 108, 160, 1),
                    onPressed: () {
                      setState(() {
                        if (artType == "Arte e Cultura") {
                          artType = "X";
                          artColor = Colors.white;
                        } else {
                          artType = "Arte e Cultura";
                          artColor = Color.fromRGBO(234, 108, 160, 1);
                        }
                      });
                    },
                  ),
                  CustomFilterButton(
                    text: 'Fé e Espiritualidade',
                    image: 'assets/faith.png',
                    color: faithColor,
                    standardColor: Color.fromRGBO(234, 196, 38, 1),
                    onPressed: () {
                      setState(() {
                        if (faithType == "Fé e Espiritualidade") {
                          faithType = "X";
                          faithColor = Colors.white;
                        } else {
                          faithType = "Fé e Espiritualidade";
                          faithColor = Color.fromRGBO(234, 196, 38, 1);
                        }
                      });
                    },
                  ),
                  CustomFilterButton(
                    text: 'Acadêmico e Profissional',
                    image: 'assets/graduation.png',
                    color: studyColor,
                    standardColor: Color.fromRGBO(108, 159, 221, 1),
                    onPressed: () {
                      setState(() {
                        if (studyType == "Acadêmico e Profissional") {
                          studyType = "X";
                          studyColor = Colors.white;
                        } else {
                          studyType = "Acadêmico e Profissional";
                          studyColor = Color.fromRGBO(108, 159, 221, 1);
                        }
                      });
                    },
                  ),
                  CustomFilterButton(
                    text: 'Outros',
                    image: 'assets/others.png',
                    color: othersColor,
                    standardColor: Color.fromRGBO(186, 186, 186, 1),
                    onPressed: () {
                      setState(() {
                        if (othersType == "Outros") {
                          othersType = "X";
                          othersColor = Colors.white;
                        } else {
                          othersType = "Outros";
                          othersColor = Color.fromRGBO(186, 186, 186, 1);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                child: Text(
                  "Datas dos eventos:",
                  style: TextStyle(
                      color: kPrimaryColor, //Color(secondaryColor),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
              child: Wrap(
                children: <Widget>[
                  CustomFilterButton(
                    text: 'Eventos acontecendo hoje',
                    image: 'assets/events.png',
                    color: dayColor,
                    standardColor: Color(0xFF4c84cd),
                    onPressed: () {
                      setState(() {
                        if (weekColor == Color(0xFF4c84cd) ||
                            monthColor == Color(0xFF4c84cd)) {
                          weekColor = Colors.white;
                          monthColor = Colors.white;
                          dayColor = Color(0xFF4c84cd);
                        } else if (dayColor == Colors.white) {
                          dayColor = Color(0xFF4c84cd);
                        } else {
                          dayColor = Colors.white;
                        }
                      });
                    },
                  ),
                  CustomFilterButton(
                    text: 'Eventos nos próximos 7 dias',
                    image: 'assets/events.png',
                    color: weekColor,
                    standardColor: Color(0xFF4c84cd),
                    onPressed: () {
                      setState(() {
                        if (dayColor == Color(0xFF4c84cd) ||
                            monthColor == Color(0xFF4c84cd)) {
                          dayColor = Colors.white;
                          monthColor = Colors.white;
                          weekColor = Color(0xFF4c84cd);
                        } else if (weekColor == Colors.white) {
                          weekColor = Color(0xFF4c84cd);
                        } else {
                          weekColor = Colors.white;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              padding: EdgeInsets.all(12.0),
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Text("Aplicar",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: () async {
                bool req = await applyConfigs();
                if (req) {
                  //Push main with the types:

                  Navigator.pushReplacementNamed(context, '/main', arguments: {
                    'routeIndex': '1',
                    'requisiton': 'true',
                    'healthType': healthType,
                    'sportType': sportType,
                    'partyType': partyType,
                    //'onlineType' : onlineType,
                    'artType': artType,
                    'faithType': faithType,
                    'studyType': studyType,
                    'othersType': othersType,
                    'dataType': dataType
                  });
                } else {
                  Navigator.pushReplacementNamed(context, '/main',
                      arguments: {'routeIndex': '1', 'requisiton': 'false'});
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void moveBack() {
    Navigator.of(context).pushReplacementNamed("/main", arguments: {
      'healthType': healthType,
      'sportType': sportType,
      'partyType': partyType,
      //'onlineType' : onlineType,
      'artType': artType,
      'faithType': faithType,
      'studyType': studyType,
      'othersType': othersType,
      'dataType': dataType
    });
  }

  Future<bool> applyConfigs() async {
    //Map Headers
    bool req = false;

    if (healthColor != Colors.white) {
      healthType = "Saúde e Bem-estar";
      req = true;
    } else {
      healthType = "X";
    }

    if (sportColor != Colors.white) {
      sportType = "Esporte e Lazer";
      req = true;
    } else {
      sportType = "X";
    }
    if (partyColor != Colors.white) {
      partyType = "Festas e Comemorações";
      req = true;
    } else {
      partyType = "X";
    }

    // if (onlineColor != Colors.white) {
    //   onlineType = "Online";
    //   req = true;
    // } else {
    //   onlineType = "X";
    // }

    if (artColor != Colors.white) {
      artType = "Arte e Cultura";
      req = true;
    } else {
      artType = "X";
    }

    if (faithColor != Colors.white) {
      faithType = "Fé e Espiritualidade";
      req = true;
    } else {
      faithType = "X";
    }

    if (studyColor != Colors.white) {
      studyType = "Acadêmico e Profissional";
      req = true;
    } else {
      studyType = "X";
    }
    if (othersColor != Colors.white) {
      othersType = "Outros";
      req = true;
    } else {
      othersType = "X";
    }

    //If all is X:
    if ((healthType == "X") &&
        (sportType == "X") &&
        (partyType == "X") &&
        //(onlineType == "X") &&
        (artType == "X") &&
        (faithType == "X") &&
        (studyType == "X") &&
        (othersType == "X")) {
      healthType = " ";
    }

    if ((healthColor == Colors.white) &&
        (sportColor == Colors.white) &&
        (partyColor == Colors.white) &&
        (artColor == Colors.white) &&
        (faithColor == Colors.white) &&
        (studyColor == Colors.white) &&
        (othersColor == Colors.white)) {
      healthType = "Saúde e Bem-estar";
      sportType = "Esporte e Lazer";
      partyType = "Festas e Comemorações";
      artType = "Arte e Cultura";
      faithType = "Fé e Espiritualidade";
      studyType = "Acadêmico e Profissional";
      othersType = "Outros";
    }

    if (dayColor != Colors.white) {
      dataType = "day";
      req = true;
    } else if (weekColor != Colors.white) {
      dataType = "week";
      req = true;
    } else {
      dataType = "all";
      req = true;
    }

    return req;
  }
}

class CustomFilterButton extends StatelessWidget {
  //final String subject;
  final String text;
  final String image;
  final VoidCallback onPressed;
  final Color color;
  final Color standardColor;

  const CustomFilterButton(
      { //this.subject,
      this.text,
      this.image,
      this.onPressed,
      this.color,
      this.standardColor});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onPressed,
      elevation: 0,
      backgroundColor: standardColor == color ? standardColor : Colors.white,
      shape: StadiumBorder(side: BorderSide(color: standardColor, width: 1.5)),
      label: Text(text),
      labelStyle: TextStyle(
          color: standardColor == color ? Colors.white : standardColor),
      padding: EdgeInsets.all(4.0),
      avatar: ImageIcon(
        AssetImage(image),
        color: standardColor == color ? Colors.white : standardColor,
        size: 25,
      ),
    );
  }
}
