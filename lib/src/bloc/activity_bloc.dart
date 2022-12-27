

import 'package:homehealth/src/bloc/validators.dart';
import 'package:homehealth/src/models/activity_model.dart';
import 'package:rxdart/rxdart.dart';

class ActivityBloc with Validators{
  final _nameController = new BehaviorSubject<String>();
  final _descriptionController = new BehaviorSubject<String>();
  final _priceController = new BehaviorSubject<String>();
  final _hoursController = new BehaviorSubject<String>();
  final _skillController = new BehaviorSubject<String>();
  final _dateController = new BehaviorSubject<String>();


  final _myactivitiesController = new BehaviorSubject<List<ActivityModel>>();

  Stream<String> get nameStream => _nameController.stream.transform(validateIsEmpty);
  Stream<String> get descriptionStream => _descriptionController.stream.transform(validateIsEmpty);
  Stream<String> get priceStream => _priceController.stream.transform(validateIsEmpty).transform(validateLengthPrice);
  Stream<String> get hoursStream => _hoursController.stream.transform(validateIsEmpty);
  Stream<String> get skillStream => _skillController.stream.transform(validateIsEmpty);
  Stream<String> get dateStream => _dateController.stream;

  get formValidStream => Rx.combineLatest6(
    nameStream,
    descriptionStream,
    priceStream,
    hoursStream,
    skillStream,
    dateStream,
    (a, b, c, d, e,f) => true
  );

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  Function(String) get changePrice => _priceController.sink.add;
  Function(String) get changeHours => _hoursController.sink.add;
  Function(String) get changeSkill => _skillController.sink.add;
  Function(String) get changeDate => _dateController.sink.add;

  String get name => _nameController.value;
  String get description => _descriptionController.value;
  String get price => _priceController.value;
  String get hours => _hoursController.value;
  String get skill => _skillController.value;
  String get date => _dateController.value;

  dispose() {
    _nameController.close();
    _descriptionController.close();
    _priceController.close();
    _hoursController.close();
    _skillController.close();
    _dateController.close();
  }

}