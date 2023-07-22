import 'dart:async';

class CategorySelectBloc {
  final _stateStreamController = StreamController<bool>();

  StreamSink<bool> get categorySelectedSink => _stateStreamController.sink;
  Stream<bool> get categorySelectedStream => _stateStreamController.stream;
}
