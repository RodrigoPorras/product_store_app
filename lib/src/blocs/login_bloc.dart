import 'dart:async';

import 'package:form_validation/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';


class LoginBloc with Validators{

  final _emailController     = BehaviorSubject<String>();
  final _passwordController  = BehaviorSubject<String>();

  //Recuperar datos de stream
  Stream<String> get emailStream => _emailController.stream.transform(validadEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validadPassword);

  Stream<bool> get formValidStream => 
    CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);


  //insertar valores al stream

  Function(String) get changueEmail => _emailController.sink.add;
  Function(String) get changuePassword => _passwordController.sink.add;

  //obtener el ultimo valor ingreaso a los streams

  String get email => _emailController.value;
  String get password => _passwordController.value;


  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}