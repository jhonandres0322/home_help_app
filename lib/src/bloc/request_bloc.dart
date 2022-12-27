


import 'package:homehealth/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class RequestBloc with Validators{

  final _requestbyController = BehaviorSubject<String>();
  final _activityController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();

  Stream<String> get requestbyStream =>
    _requestbyController.stream;
  Stream<String> get descriptionStream =>
    _descriptionController.stream.transform(validateIsEmpty);

  Stream<bool> get formValidStream => Rx.combineLatest2(
    requestbyStream, 
    descriptionStream, 
    (a, b) => true
  );

  Function(String) get changeRequestby => _requestbyController.sink.add; 
  Function(String) get changeActivity => _activityController.sink.add; 
  Function(String) get changeDescription => _descriptionController.sink.add; 

  String get requestby => _requestbyController.value; 
  String get activity => _activityController.value; 
  String get description => _descriptionController.value; 

  dispose(){
  _requestbyController.close();
  _activityController.close();
  _descriptionController.close();
  }

}