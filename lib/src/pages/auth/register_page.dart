import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homehealth/src/bloc/login_bloc.dart';
import 'package:homehealth/src/providers/provider.dart';
import 'package:homehealth/src/providers/usuario_provider.dart';
import 'package:homehealth/src/utils/utils.dart';
import 'package:homehealth/src/widgets/background.dart';

//import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  // String _nombre = "";
  // String _email = "";
  // String _password = "";

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final UsuarioProvider usuarioProvider = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    //esta variable bloc se hace para poder tener control de los datos mediante la estructura bloc
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Registraste en HomeHelp!",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              StreamBuilder(
                  stream: bloc.emailStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(29)),
                      child: TextField(
                        onChanged: (value) => bloc.changeEmail(value),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            icon: Icon(Icons.email_outlined,
                                color: Colors.black12),
                            hintText: "Correo Electronico",
                            border: InputBorder.none,
                            errorText: snapshot.error),
                      ),
                    );
                  }),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(29)),
                child: StreamBuilder<Object>(
                    stream: bloc.passwordStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => bloc.changePassword(value),
                        decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key_outlined,
                                color: Colors.black12),
                            hintText: "Contraseña",
                            border: InputBorder.none,
                            errorText: snapshot.error),
                        obscureText: true,
                      );
                    }),
              ),
              StreamBuilder(
                  stream: bloc.formValidStream,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                        onPressed: snapshot.hasData
                            ? () => _register(bloc, context)
                            : null,
                        child: Container(
                          child: Text(
                            'Registrar',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 19, horizontal: 100),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29)),
                            elevation: 0.0,
                            primary: Colors.deepPurple,
                            onPrimary: Colors.white));
                  }),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                child: Text('¿Ya tienes cuenta?'),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    final blocPR = Provider.registerProfile(context);
    Map info = await usuarioProvider.registerUser(bloc.email,
        bloc.password); //ahora en info incluye el valor de UID del usuario ***JSLR
    if (info['ok']) {
      blocPR.changeUid(info['Uid']);
      //se llaman dos bloc por lo que este que guarda el UID del siguiente formulario lo nombre distintio *** JSLR
      Navigator.pushReplacementNamed(context, 'register-profile');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }
  }
}
