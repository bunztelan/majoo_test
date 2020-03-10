import 'dart:async';

import 'package:majoo_test/bloc/bloc_provider.dart';
import 'package:majoo_test/model/PeopleResponse.dart';
import 'package:majoo_test/model/people.dart';
import 'package:majoo_test/repository/PeopleRepository.dart';

class PeopleBloc implements BlocBase {
  // Create a broadcast controller that allows this stream to be listened
  // to multiple times. This is the primary, if not only, type of stream you'll be using.
  final _peopleRepository = PeopleRepository();
  final _peopleController = StreamController<List<People>>.broadcast();

  StreamSink<List<People>> get _inPeople => _peopleController.sink;
  Stream<List<People>> get peoples => _peopleController.stream;

  final _addPeopleController = StreamController<People>.broadcast();
  StreamSink<People> get inAddPeople => _addPeopleController.sink;

  PeopleBloc() {
    getPeoples();
    fetchPeopleList();
    _addPeopleController.stream.listen(_handleAddPeople);
  }

  fetchPeopleList() async{
    PeopleResponse peopleResponse = await _peopleRepository.fetchPeopleList();
    peopleResponse.results.forEach((people) => _handleAddPeople(people));
    getPeoples();
  }

  _handleAddPeople(People people) async {
    _peopleRepository.insertPeople(people);
   getPeoples();
  }

  getPeoples() async{
    List<People> peoples = await _peopleRepository.getAllPeople();
    _inPeople.add(peoples);
  }

  updatePeopls(People people) async{
    await _peopleRepository.updatePeople(people);
    getPeoples();
  }

  deleteToById(int id) async{
    _peopleRepository.deletePeopleById(id);
    getPeoples();
  }

  // All stream controllers you create should be closed within this function
  @override
  void dispose() {
    _peopleController.close();
    _addPeopleController.close();
  }


}