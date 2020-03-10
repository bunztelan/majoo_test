import 'package:majoo_test/dao/people_dao.dart';
import 'package:majoo_test/data/api/Api.dart';
import 'package:majoo_test/model/PeopleResponse.dart';
import 'package:majoo_test/model/people.dart';

class PeopleRepository {
  final peopleDao = PeopleDao();
  final ApiProvider apiProvider = ApiProvider();

  Future<PeopleResponse> fetchPeopleList() => apiProvider.fetchPeopleList();

  Future getAllPeople({String query}) => peopleDao.getPeople(query: query);

  Future insertPeople(People todo) => peopleDao.createPeople(todo);

  Future updatePeople(People todo) => peopleDao.updatePeople(todo);

  Future deletePeopleById(int id) => peopleDao.deletePeople(id);

  Future deleteAllPeoples() => peopleDao.deleteAllPeople();
}