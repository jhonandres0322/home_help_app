import 'dart:async';

class Validators {


  // VALIDACIONES DEL LOGIN Y REGISTRO INICIAL
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres. Por Favor');
    }
  });

  // VALIDACIONES DEL REGISTRO DEL PERFIL
  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 0) {
      sink.add(name);
    } else {
      print("sink error");
      sink.addError('Ingrese su nombre!');
    }
  });

  final validateAddress = StreamTransformer<String, String>.fromHandlers(
      handleData: (address, sink) {
    if (address.length > 0) {
      sink.add(address);
    } else {
      sink.addError('Ingrese su dirección!');
    }
  });

  final validateLastname = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastname, sink) {
    if (lastname.length > 0) {
      sink.add(lastname);
    } else {
      sink.addError('Ingrese su apellido!');
    }
  });

  final validateDocumentNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (document, sink) {
    if (document.length > 6) {
      sink.add(document);
    } else {
      sink.addError('Ingrese un número de documento valido!');
    }
  });

  final validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.length > 6) {
      sink.add(phone);
    } else {
      sink.addError('Ingrese un número valido!');
    }
  });
  
  final validateBirthDate = StreamTransformer<String, String>.fromHandlers(
      handleData: (birthdate, sink) {
    if (birthdate.isNotEmpty) {
      sink.add(birthdate);
    } else {
      sink.addError('Escoja su fecha de nacimiento!');
    }
  });
  
  final validateUid = StreamTransformer<String, String>.fromHandlers(
      handleData: (birthdate, sink) {
    if (birthdate.isNotEmpty) {
      sink.add(birthdate);
    } else {
      sink.addError('valor de UID del usuario esta vacio');
    }
  });

  // VALIDACIONES DE LA CREACIÓN DE ACTIVIADES

  final validateIsEmpty = StreamTransformer<String,String>.fromHandlers(
    handleData: (text,sink){
      if(text.isNotEmpty){
        sink.add(text);
      } else {
        sink.addError("Ingrese un valor valido");
      }
    }
  );


  final validateLengthPrice = StreamTransformer<String,String>.fromHandlers(
    handleData: (price,sink){
      if(price.length >= 4){
        sink.add(price);
      } else {
        sink.addError("El precio debe tener mas de 4 caracteres");
      }
    }
  );

}
