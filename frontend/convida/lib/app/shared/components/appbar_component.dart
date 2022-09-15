import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSize {

  final BuildContext _context;
  final String title;
  final dynamic navigation;

  const AppBarComponent(this._context, {this.title, this.navigation});

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();


  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(255, 73, 51, 1),
                size: 32,
              ),
              onPressed: () =>
              {
                if( navigation == null){
                  Navigator.of(_context).pop(),
                }else{
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) =>  navigation
                      )
                  )
                }
              }
          );
        }),
        title:
        Image.asset("assets/logos/logo-ufprconvida.png", scale: 16),
      );
    }else{
      return AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(255, 73, 51, 1),
                size: 32,
              ),
              onPressed: () =>
              {
                if( navigation == null){
                  Navigator.of(_context).pop(),
                }else{
                  Navigator.of(context)
                  .push(
                  MaterialPageRoute(
                      builder: (context) =>  navigation
                    )
                  )
                }
              }
          );
        }),
        title: Text(
          title,
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 19.0,
              fontWeight: FontWeight.bold),
        ),
      );
    }
  }


}
