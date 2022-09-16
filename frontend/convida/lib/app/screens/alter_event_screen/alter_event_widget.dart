import 'package:convida/app/screens/alter_event_screen/alter_event_controller.dart';
import 'package:convida/app/shared/DAO/util_requisitions.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/util/text_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const int MAX_STRING = 100;

class AlterEventWidget extends StatefulWidget {
  final Event event;
  AlterEventWidget({Key key, @required this.event}) : super(key: key);
  @override
  _AlterEventWidgetState createState() => _AlterEventWidgetState(event);
}

class _AlterEventWidgetState extends State<AlterEventWidget> {
  Event event;
  _AlterEventWidgetState(this.event);
  final alterEventController = AlterEventController();

  bool created = false;
  final DateTime now = DateTime.now();

  var hrStartMask = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var hrEndMask = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var dateStartMask = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var dateEndMask = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var subStartMask = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var subEndMask = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  //Dates:

  final DateFormat postFormat = new DateFormat("yyyy-MM-ddTHH:mm:ss");
  final DateFormat hour = new DateFormat("HH:mm");
  final DateFormat date = new DateFormat("dd/MM/yyyy");

  // String showHrStart = "";
  // String showHrEnd = "";
  // String showDateStart = "";
  // String showDateEnd = "";
  // String showSubStart = "";
  // String showSubEnd = "";

  // DateTime selectedHrEventStart = DateTime.now();
  // DateTime selectedHrEventEnd = DateTime.now();
  // DateTime selectedDateEventStart = DateTime.now();
  // DateTime selectedDateEventEnd = DateTime.now();
  // DateTime selectedSubEventStart = DateTime.now();
  // DateTime selectedSubEventEnd = DateTime.now();

  //Events Types
  var _dropDownMenuItemsTypes = [
    "Saúde e Bem-estar",
    "Esporte e Lazer",
    "Festas e Comemorações",
    // "Online",
    "Arte e Cultura",
    "Fé e Espiritualidade",
    "Acadêmico e Profissional",
    "Outros",
  ];

  String _currentType;
  //Switch:
  bool isSwitchedSubs = false;

  // //Controllers:
  // final TextEditingController _eventNameController =
  //     new TextEditingController();
  // final TextEditingController _eventTargetController =
  //     new TextEditingController();
  // final TextEditingController _eventDescController =
  //     new TextEditingController();
  // final TextEditingController _eventLinkController =
  //     new TextEditingController();
  // final TextEditingController _eventAddressController =
  //     new TextEditingController();
  // final TextEditingController _eventComplementController =
  //     new TextEditingController();

  @override
  void initState() {
    alterEventController.alterEvent.name = event.name;
    alterEventController.alterEvent.target = event.target;
    alterEventController.alterEvent.desc = event.desc;
    alterEventController.alterEvent.link = event.link;
    alterEventController.alterEvent.address = event.address;
    alterEventController.alterEvent.complement = event.complement;
    alterEventController.alterEvent.online = event.online;

    _currentType = event.type;

    DateTime parsedHrStart;
    DateTime parsedHrEnd;
    DateTime parsedDateStart;
    DateTime parsedDateEnd;
    DateTime parsedSubStart;
    DateTime parsedSubEnd;

    if (event.hrStart != null) {
      parsedHrStart = postFormat.parse(event.hrStart);
      alterEventController.alterEvent.hrStart = hour.format(parsedHrStart);
    }
    if (event.hrEnd != null) {
      parsedHrEnd = DateTime.parse(event.hrEnd);
      alterEventController.alterEvent.hrEnd = hour.format(parsedHrEnd);
    }
    if (event.dateStart != null) {
      parsedDateStart = DateTime.parse(event.dateStart);
      alterEventController.alterEvent.dateStart = date.format(parsedDateStart);
    }
    if (event.dateEnd != null) {
      parsedDateEnd = DateTime.parse(event.dateEnd);
      alterEventController.alterEvent.dateEnd = date.format(parsedDateEnd);
    }
    if (event.startSub != null) {
      parsedSubStart = DateTime.parse(event.startSub);
      alterEventController.alterEvent.subStart = date.format(parsedSubStart);
    }
    if (event.endSub != null) {
      parsedSubEnd = DateTime.parse(event.endSub);
      alterEventController.alterEvent.subEnd = date.format(parsedSubEnd);
    }

    if (event.startSub == null) {
      isSwitchedSubs = false;
    } else
      isSwitchedSubs = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).popAndPushNamed("/main");
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: kPrimaryColor),
            ),
            centerTitle: true,
            title: Text(
              "Alterar Evento",
              style: TextStyle(
                  color: Colors.black, //Color(secondaryColor),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white),
        body: ListView(
          children: <Widget>[
            //Tittle
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.center,
              ),
            ),

            //Event Name:
            //eventNameInput(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldInitialValue(
                    initialValue: alterEventController.alterEvent.name,
                    labelText: "Nome do Evento:",
                    icon: Icons.event_note,
                    onChanged: alterEventController.alterEvent.setName,
                    maxLength: MAX_STRING,
                    errorText: alterEventController.validateName);
              }),
            ),
            //Event Target
            //eventTargetInput(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldInitialValue(
                    initialValue: alterEventController.alterEvent.target,
                    labelText: "Público alvo:",
                    icon: Icons.person_pin_circle,
                    onChanged: alterEventController.alterEvent.setTarget,
                    maxLength: MAX_STRING,
                    errorText: alterEventController.validateTarget);
              }),
            ),
            //Event Description
            //eventDescInput(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldLines(
                    maxLines: 3,
                    initialValue: alterEventController.alterEvent.desc,
                    labelText: "Descrição:",
                    icon: Icons.note,
                    onChanged: alterEventController.alterEvent.setDesc,
                    maxLength: 300,
                    errorText: alterEventController.validateDesc);
              }),
            ),

            //Online Event
            SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: eventSwitchOnline()),

            //eventAddressInput(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldInitialValue(
                    initialValue: alterEventController.alterEvent.address,
                    labelText: "Endereço:",
                    icon: Icons.location_on,
                    onChanged: alterEventController.alterEvent.setAddress,
                    maxLength: MAX_STRING,
                    errorText: alterEventController.validateAddress);
              }),
            ),
            //eventComplementInput(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldInitialValue(
                    initialValue: alterEventController.alterEvent.complement,
                    labelText: "Complemento:",
                    icon: Icons.location_city,
                    onChanged: alterEventController.alterEvent.setComplement,
                    maxLength: MAX_STRING,
                    errorText: alterEventController.validateComplement);
              }),
            ),
            //Event Link or Email:
            //eventLinkInput(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldInitialValue(
                    initialValue: alterEventController.alterEvent.link,
                    labelText: "Link ou Email:",
                    icon: Icons.location_city,
                    onChanged: alterEventController.alterEvent.setLink,
                    maxLength: 300,
                    errorText: alterEventController.validateLink);
              }),
            ),

            //Event Hour Start:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldMask(
                    maskFormatter: hrStartMask,
                    keyboardType: TextInputType.datetime,
                    labelText: "Hora de Início:",
                    icon: Icons.watch_later,
                    initialValue: alterEventController.alterEvent.hrStart,
                    onChanged: alterEventController.alterEvent.setHrStart,
                    maxLength: 5,
                    errorText: alterEventController.validadeHourStart);
              }),
            ),

            //Event Hour End:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldMask(
                    maskFormatter: hrEndMask,
                    keyboardType: TextInputType.datetime,
                    labelText: "Hora de Fim:",
                    icon: Icons.watch_later,
                    initialValue: alterEventController.alterEvent.hrEnd,
                    onChanged: alterEventController.alterEvent.setHrEnd,
                    maxLength: 5,
                    errorText: alterEventController.validadeHourEnd);
              }),
            ),

            //Event Date Start:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldMask(
                    maskFormatter: dateStartMask,
                    keyboardType: TextInputType.datetime,
                    labelText: "Data de Início:",
                    icon: Icons.calendar_today,
                    initialValue: alterEventController.alterEvent.dateStart,
                    onChanged: alterEventController.alterEvent.setDateStart,
                    maxLength: 10,
                    errorText: alterEventController.validadeDateStart);
              }),
            ),

            //Date End Event:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(builder: (_) {
                return textFieldMask(
                    maskFormatter: dateEndMask,
                    keyboardType: TextInputType.datetime,
                    labelText: "Data de Fim:",
                    icon: Icons.calendar_today,
                    initialValue: alterEventController.alterEvent.dateEnd,
                    onChanged: alterEventController.alterEvent.setDateEnd,
                    maxLength: 10,
                    errorText: alterEventController.validadeDateEnd);
              }),
            ),

            //Event Category
            Padding(
              padding: const EdgeInsets.fromLTRB(47, 8.0, 8.0, 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        decoration: containerDecorationCategory(),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                              child: new Text(
                                "Tipo do evento: ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 5, 20, 5),
                              child: DropdownButton<String>(
                                items: _dropDownMenuItemsTypes
                                    .map((String dropDownStringIten) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringIten,
                                      child: Text(dropDownStringIten));
                                }).toList(),
                                onChanged: (String newType) {
                                  setState(() {
                                    _currentType = newType;
                                  });
                                },
                                value: _currentType,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //Event Switch Subscriptions:
            SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: eventSwitchSubs()),

            Container(
                child: isSwitchedSubs == true
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            //Subscriptions Start:
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Observer(builder: (_) {
                                return textFieldMask(
                                    maskFormatter: subStartMask,
                                    keyboardType: TextInputType.datetime,
                                    labelText: "Data de Início:",
                                    icon: Icons.calendar_today,
                                    initialValue: alterEventController
                                        .alterEvent.subStart,
                                    onChanged: alterEventController
                                        .alterEvent.setSubStart,
                                    maxLength: 10,
                                    errorText:
                                        alterEventController.validadeSubStart);
                              }),
                            ),

                            //Subscriptions End:
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Observer(builder: (_) {
                                return textFieldMask(
                                    maskFormatter: subEndMask,
                                    keyboardType: TextInputType.datetime,
                                    labelText: "Data de Fim:",
                                    icon: Icons.calendar_today,
                                    initialValue:
                                        alterEventController.alterEvent.subEnd,
                                    onChanged: alterEventController
                                        .alterEvent.setSubEnd,
                                    maxLength: 10,
                                    errorText:
                                        alterEventController.validadeSubEnd);
                              }),
                            ),
                          ],
                        ),
                      )
                    : nothingToShow()),

            //Buttons:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.all(12),
                        onPressed: alterEventController.loading
                            ? null
                            : () async {
                                if (created) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                                if (created == false) {
                                  //* Check all Inputs
                                  bool ok = alterEventController.checkAll(
                                      context, isSwitchedSubs);

                                  if (ok) {
                                    String error = "";

                                    error = alterEventController
                                        .datesValidations(isSwitchedSubs);
                                    if (error != "") {
                                      showError(
                                          "Data Incorreta", "$error", context);
                                    } else {
                                      int statusCode =
                                          await alterEventController.putEvent(
                                              _currentType,
                                              isSwitchedSubs,
                                              event,
                                              context);
                                      if ((statusCode == 200) ||
                                          (statusCode == 201)) {
                                        showConfirm(
                                            title: "Alterado com Sucesso!",
                                            content:
                                                "Seu evento foi alterado com sucesso, deseja voltar ao seus eventos?",
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            context: context);
                                      } else {
                                        errorStatusCode(statusCode, context,
                                            "Erro ao Alterar Evento");
                                      }
                                      created = true;
                                    }
                                  }
                                }
                              },
                        color: kPrimaryColor,
                        child: Text(
                          "Alterar",
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Observer(builder: (_) {
                  return alterEventController.loading
                      ? LinearProgressIndicator()
                      : SizedBox();
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Scaffold withoutLogin(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //Botao Entrar
            Container(
                margin: const EdgeInsets.all(4.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                      child: Image.asset(
                        //Image:
                        "assets/logos/logo-ufprconvida.png",
                        width: 400.0,
                        height: 400.0,
                        //color: Colors.white70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed("/login");
                        },
                        padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
                        child: Text('Fazer Login',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          //When press Signup:
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed("/signup");
                        },
                        padding: EdgeInsets.fromLTRB(43, 12, 43, 12),
                        child: Text('Fazer Cadastro',
                            //Color(primaryColor),(secondaryColor)
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    SizedBox(height: 50),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.all(12),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed("/main");
                      },
                      color: kPrimaryColor,
                      child: Text(
                        "Voltar",
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                    ),
                    SizedBox(height: 30)
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Padding eventSwitchOnline() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(47, 8.0, 8.0, 8.0),
      child: Row(
        children: <Widget>[
          Text("Seu evento é Online ?",
              style: TextStyle(fontSize: 16, color: Colors.black54)),
          Switch(
              value: alterEventController.alterEvent.online,
              onChanged: (value) {
                setState(() {
                  alterEventController.alterEvent.online = value;
                });
              }),
        ],
      ),
    );
  }

  Padding eventSwitchSubs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(47, 8.0, 8.0, 8.0),
      child: Row(
        children: <Widget>[
          Text("Seu evento tem datas de inscrições?",
              style: TextStyle(fontSize: 16, color: Colors.black54)),
          Switch(
              value: isSwitchedSubs,
              onChanged: (value) {
                setState(() {
                  isSwitchedSubs = value;
                });
              }),
        ],
      ),
    );
  }

  Container nothingToShow() {
    return Container(
      child: SizedBox(width: 0),
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4.5),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ));
  }

  BoxDecoration containerDecorationCategory() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4.5),
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ));
  }
}
