import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homehealth/src/bloc/login_bloc.dart';
import 'package:homehealth/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:homehealth/src/providers/provider.dart';
import 'package:homehealth/src/providers/usuario_provider.dart';
import 'package:homehealth/src/utils/utils.dart';
import 'package:homehealth/src/widgets/background.dart';

class LoginPage extends StatelessWidget {
  final UsuarioProvider usuarioProvider = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);
    //final prefs = new PreferenciasUsuario();
    //print(prefs.token);
    return Scaffold(
      body: Background(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bievenido a HomeHelp!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.05),
            StreamBuilder(
                stream: bloc.emailStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(29)),
                    child: TextField(
                      onChanged: (value) => bloc.changeEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          icon:
                              Icon(Icons.email_outlined, color: Colors.black12),
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
                      onPressed:
                          snapshot.hasData ? () => _login(bloc, context) : null,
                      child: Container(
                        child: Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 19, horizontal: 100),
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
                  Navigator.pushReplacementNamed(context, 'registro'),
              child: Text('¿No tienes cuenta?'),
              style: TextButton.styleFrom(primary: Colors.black),
            ),
          ],
        ),
      )),
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    final blocPR = Provider.registerProfile(context);
    Map info = await usuarioProvider.login(bloc.email, bloc.password);
    if (info['ok']) {
      blocPR.changeUid(info['Uid']); //agrega el valor de UID par e lgeneral.
      Navigator.pushReplacementNamed(context, 'main');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }
  }
}
