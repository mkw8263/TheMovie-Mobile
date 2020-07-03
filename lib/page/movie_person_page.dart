import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themovie/blocs/movie_person_bloc.dart';
import 'package:themovie/models/person.dart';
import 'package:themovie/models/personeResponse.dart';
import 'package:themovie/style/theme.dart' as Style;

class MoviePersonListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviePersonListPage();
}

class _MoviePersonListPage extends State<MoviePersonListPage> {
  @override
  void initState() {
    super.initState();
    personMovieBloc.fetchPersonList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text("TRENDING PERSONS ON THIS WEEK",
              style: TextStyle(
                  color: Style.Colors.titleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0)),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<PersonResponse>(
            stream: personMovieBloc.personList,
            builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return _buildLoading();
            })
      ],
    );
  }

  Widget _buildList(PersonResponse data) {
    List<Person> persons = data.person;
    return Container(
      height: 130.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        itemCount: persons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 100.0,
            padding: EdgeInsets.only(top: 10.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                persons[index].profileImg == null
                    ? Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.Colors.secondColor),
                        child: Icon(Icons.supervised_user_circle,
                            color: Colors.white),
                      )
                    : Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200" +
                                        persons[index].profileImg),
                                fit: BoxFit.cover)),
                      ),
                SizedBox(height: 10.0),
                Text(persons[index].name,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.4,
                        fontSize: 9.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0),
          )
        ],
      ),
    );
  }
}
