import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homehealth/src/pages/auth/login_page.dart';
import 'package:homehealth/src/pages/auth/register_page.dart';
import 'package:homehealth/src/utils/constants.dart';
import 'package:homehealth/src/widgets/background.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bienvenido a HomeHelp",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
                )
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => LoginPage()
                      )
                    ),
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => RegisterPage()
                      )
                    ),
                    child: Text("Registro"),
                    style: ElevatedButton.styleFrom(
                      primary: primaryLigthColor,
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
