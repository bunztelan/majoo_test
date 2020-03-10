import 'package:flutter/material.dart';
import 'package:majoo_test/bloc/bloc_provider.dart';
import 'package:majoo_test/bloc/people_bloc.dart';
import 'package:majoo_test/model/people.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Start Wars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        bloc: PeopleBloc(),
        child: PeoplePage(title: 'Star Wars App'),
      ),
    );
  }
}

class PeoplePage extends StatefulWidget {
  PeoplePage({
    Key key,
    this.title
  }) : super(key: key);

  final String title;

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  PeopleBloc _poepleBloc;

  @override
  void initState() {
    super.initState();
    _poepleBloc = BlocProvider.of<PeopleBloc>(context);
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<People>>(
                stream: _poepleBloc.peoples,
                builder: (BuildContext context, AsyncSnapshot<List<People>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Text('No people');
                    }

                    List<People> peoples = snapshot.data;

                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        People people = peoples[index];

                        return GestureDetector(
                          onTap: () {
                            _showToast(context);
                          },
                          child: Container(
                            height: 40,
                            child: Text(
                              people.name,
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}