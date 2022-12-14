import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/constants/app_color.dart';
import 'package:rick_and_morty/constants/style.dart';
import 'package:rick_and_morty/model/character_model.dart';
import 'package:rick_and_morty/screen/Character/character_details.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  ScrollController _scrollController = ScrollController();
  List<Character> characters = <Character>[];
  bool loading = false;
  int pageNumber = 1;

  void getCharacters() async {
    Response response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character?page=$pageNumber'));

    Map<String, dynamic> map = await jsonDecode(response.body);
    List<dynamic> data = map['results'];
    print(data);

    setState(() {
      pageNumber++;
      for (var i = 0; i < data.length; i++) {
        Character char = Character();
        char.id = data[i]['id'];
        char.name = data[i]['name'];
        char.img = data[i]['image'];
        char.status = data[i]['status'];
        char.gender = data[i]['gender'];
        char.species = data[i]['species'];
        loading = true;
        characters.add(char);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCharacters();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        print('new data call');
        getCharacters();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? Center(
            child: SpinKitChasingDots(
              color: appColor.green600,
            ),
          )
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).backgroundColor,
                  Theme.of(context).scaffoldBackgroundColor
                ],
                tileMode: TileMode.mirror,
              )),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 40,
                      childAspectRatio: 1.8 / 2,
                      mainAxisSpacing: 40,
                    ),
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CharacterDetails(
                                        id: characters[index].id!,
                                        img: characters[index].img!,
                                        gender: characters[index].gender!,
                                        name: characters[index].name!,
                                        species: characters[index].species!,
                                        status: characters[index].status!,
                                      )));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: appColor.hexColor,
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(20),
                                        top: Radius.circular(20))),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    (characters[index].name!),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: googlefonts(),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                      characters[index].img.toString())),
                            ),
                          ]),
                        ),
                      );
                    }),
              ),
            ),
          );
  }
}
