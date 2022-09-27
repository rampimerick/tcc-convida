import 'package:convida/app/screens/alter_profile_screen/alter_profile_controller.dart';
import 'package:convida/app/shared/DAO/util_requisitions.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:convida/app/shared/util/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AlterProfileWidget extends StatefulWidget {
  final User user;

  AlterProfileWidget({Key key, @required this.user}) : super(key: key);

  @override
  _AlterProfileWidgetState createState() => _AlterProfileWidgetState(user);
}

class _AlterProfileWidgetState extends State<AlterProfileWidget> {
  final profileController = AlterProfileController();
  User user;

  _AlterProfileWidgetState(this.user);

  bool created = false;
  var dateMask = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  final DateFormat formatter = new DateFormat("dd/MM/yyyy");
  final DateFormat postFormat = new DateFormat("yyyy-MM-ddTHH:mm:ss");
  String initialBirth;

  DateTime selectedDateUser = DateTime.now();

  //Controllers:
  final TextEditingController _userGrrController = new TextEditingController();
  bool isUFPR = false; //Email @ufpr
  bool isSwitchedPassword = false;
  bool isSignup = false;
  DateTime parsedBirth;

  @override
  void initState() {
    _userGrrController.text = user.login;

    if (user.birth != null) {
      parsedBirth = DateTime.parse(user.birth);
      initialBirth = formatter.format(parsedBirth);
    }
    if (user.login.contains("@ufpr.br")) {
      isUFPR = true;
      user.email = user.login;
    } else {
      isUFPR = false;
    }
    if (user.name == null) {
      isSignup = true;
    } else {
      isSignup = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: profileController.getProfile(user: user, context: context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data == true) {
          return WillPopScope(
            onWillPop: () {
              if (isSignup) {
                return null;
              }
              if (created) {
                Navigator.of(context).pushReplacementNamed("/login");
                return null;
              } else {
                Navigator.of(context).pushReplacementNamed("/main");
                return null;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("/main");
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    isSignup ? "Criando Perfil" : "Perfil",
                    style: TextStyle(
                        color: Colors.black, //Color(secondaryColor),
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        //Text:
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            alignment: Alignment.center,
                          ),
                        ),

                        //*User First name:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Observer(builder: (_) {
                            return textField(
                                labelText: "Nome:",
                                icon: Icons.person,
                                initialValue: user.name,
                                onChanged: profileController.profile.changeName,
                                maxLength: 25,
                                errorText: profileController.validateName);
                          }),
                        ),

                        //*User last name
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Observer(builder: (_) {
                            return textField(
                                labelText: "Sobrenome:",
                                icon: Icons.navigate_next,
                                initialValue: user.lastName,
                                onChanged:
                                profileController.profile.changeLastName,
                                maxLength: 25,
                                errorText: profileController.validadeLastName);
                          }),
                        ),

                        //*User GRR:
                        userGrr(isUFPR),

                        //*User Birthday
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Observer(builder: (_) {
                            return textFieldMask(
                                maskFormatter: dateMask,
                                labelText: "Data de Nascimento:",
                                keyboardType: TextInputType.datetime,
                                icon: Icons.calendar_today,
                                initialValue: profileController.profile.birth,
                                onChanged:
                                profileController.profile.changeBirth,
                                maxLength: 10,
                                errorText: profileController.validadeBirth);
                          }),
                        ),

                        //*User email:
                        isUFPR
                            ? SizedBox()
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Observer(builder: (_) {
                            return textField(
                                labelText: "E-mail:",
                                icon: Icons.email,
                                initialValue: user.email,
                                onChanged:
                                profileController.profile.changeEmail,
                                maxLength: 50,
                                errorText:
                                profileController.validadeEmail);
                          }),
                        ),

                        //!Revisar as senhas:
                        //*Switch passwords:
                        /* user.login.endsWith("@ufpr.br") == true
                            ? SizedBox(
                                width: 0,
                                height: 0,
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    47, 8.0, 8.0, 8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      Text("Deseja alterar sua senha?",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54)),
                                      Switch(
                                          value: isSwitchedPassword,
                                          onChanged: (value) {
                                            setState(() {
                                              //print("Executou um setState");
                                              isSwitchedPassword = value;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ), */

                        //Without Saving Password
                        /* Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Observer(builder: (_) {
                              return textFieldObscure(
                                  labelText: "Senha do SIGA ou @ufpr",
                                  icon: Icons.lock,
                                  onChanged:
                                      profileController.profile.changePassword,
                                  maxLength: 18,
                                  errorText:
                                      profileController.validadePassword);
                            }),
                          ),
                          //New Passwaord Implementation:
                          /*//Switch on:
                              ? Container(
                                  child: Column(
                                    children: <Widget>[
                                      //Old Password:
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Observer(builder: (_) {
                                          return textFieldObscure(
                                              labelText: "Senha:",
                                              icon: Icons.lock,
                                              onChanged: profileController
                                                  .profile.changePassword,
                                              maxLength: 18,
                                              errorText: profileController
                                                  .validadePassword);
                                        }),
                                      ),
                                      //New Password:
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Observer(builder: (_) {
                                          return textFieldObscure(
                                              labelText: "Nova senha:",
                                              icon: Icons.lock,
                                              onChanged: profileController
                                                  .profile.changeNewPassword,
                                              maxLength: 18,
                                              errorText: profileController
                                                  .validadeNewPassword);
                                        }),
                                      ),
                                      //Confirm New Password:
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Observer(builder: (_) {
                                          return textFieldObscure(
                                              labelText:
                                                  "Confirmar nova senha:",
                                              icon: Icons.lock,
                                              onChanged: profileController
                                                  .profile
                                                  .changeConfirmPassword,
                                              maxLength: 18,
                                              errorText: profileController
                                                  .validadeNewPassword);
                                        }),
                                      ),
                                    ],
                                  ),
                                )
                              //Switch off:
                              //Just the Password:
                              :  */
                        ), */

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Observer(builder: (_) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 10),
                                      ),
                                      onPressed: profileController.loading
                                          ? null
                                          : () async {
                                        //*Arrumar data:
                                        DateTime dateUser =
                                        DateFormat("dd/MM/yyyy")
                                            .parse(profileController
                                            .profile.birth);
                                        String datePost =
                                        postFormat.format(dateUser);

                                        if (created) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                              "/main");
                                        } else if ((user.name ==
                                            profileController
                                                .profile.name) &&
                                            (user.lastName ==
                                                profileController
                                                    .profile.lastName) &&
                                            (user.email ==
                                                profileController
                                                    .profile.email) &&
                                            (user.birth == datePost) &&
                                            (isSwitchedPassword ==
                                                false)) {
                                          String error = "Sem Alterações";
                                          String desc =
                                              "Não foi nada alterado";
                                          showError(error, desc, context);
                                        }

                                        //!Corrigir
                                        else if (created == false) {
                                          bool ok = profileController
                                              .checkAll(context);
                                          if (ok) {
                                            int statusCode;
                                            if (isSignup) {
                                              statusCode =
                                              await profileController
                                                  .postNewUser(
                                                  user: user,
                                                  dateUser:
                                                  datePost,
                                                  context:
                                                  context);
                                            } else {
                                              statusCode =
                                              await profileController
                                                  .putUser(
                                                  isSwitch:
                                                  isSwitchedPassword,
                                                  user: user,
                                                  dateUser:
                                                  datePost,
                                                  context:
                                                  context);
                                            }

                                            if ((statusCode == 200) ||
                                                (statusCode == 204) ||
                                                (statusCode == 201)) {
                                              showSuccess(
                                                  isSignup
                                                      ? "Usuário Criado com sucesso!"
                                                      : "Usuário Alterado com sucesso!",
                                                  isSignup
                                                      ? "/login"
                                                      : "/main",
                                                  context);
                                              created = true;
                                            } else {
                                              errorStatusCode(
                                                  statusCode,
                                                  context,
                                                  isSignup
                                                      ? "Erro ao cadastrar Usuário"
                                                      : "Erro ao alterar Usuário");
                                            }
                                          } else {
                                            //!Corrigir!
                                          }
                                        }
                                      },
                                      child: Text(
                                          isSignup ? "Cadastrar" : "Alterar",
                                          //Color(primaryColor),(secondaryColor)
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Observer(builder: (_) {
                              return profileController.loading
                                  ? LinearProgressIndicator()
                                  : SizedBox();
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Padding userGrr(bool isUFPR) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        enabled: false,
        controller: _userGrrController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: 50,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
          EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
          labelText: isUFPR ? "E-mail @ufpr" : "CPF:",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          //icon: Icon(Icons.navigate_next, color: Colors.grey[400]),
        ),
      ),
    );
  }
}