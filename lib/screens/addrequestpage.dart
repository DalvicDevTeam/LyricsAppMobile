import 'package:dalvic_lyrics_sharing_app/blocs/lyricsbloc/lyrics.dart';
import 'package:dalvic_lyrics_sharing_app/models/lyrics.dart';
import 'package:dalvic_lyrics_sharing_app/screens/lyricsrequestdetailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';
import 'homepage.dart';
import 'lyricspage.dart';

class AddRequestPage extends StatefulWidget {
  @override
  _AddRequestPageState createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {
  final formkey = GlobalKey<FormState>();
  String artist, song,lyrics, url;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 65),
                    child: Text("Add Lyrics",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        )),
                  ),
                ],
              ),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Music Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: song,
                                onChanged: (value) {
                                  setState(() {
                                    song = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  fillColor: kPrimaryLight,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: kPrimary)),
                                ),

                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Artist Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                // The validator receives the text that the user has entered.
                                initialValue: artist,
                                onChanged: (value) {
                                  setState(() {
                                    artist = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  fillColor: kPrimaryLight,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: kPrimary)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Text('Lyrics',
                                style:
                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),SizedBox(height: 7),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: TextFormField(
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'please enter Lyrics!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      lyrics = value;
                                    });
                                  },
                                  keyboardType: TextInputType.multiline,
                                  minLines: 10,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor: kPrimaryLight),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "URL",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "(",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "optional",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    ")",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: url,
                                onChanged: (value) {
                                  setState(() {
                                    url = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  fillColor: kPrimaryLight,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: kPrimary)),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child:
                            BlocConsumer<LyricsBloc, LyricsState>(
                          listener: (context, state) {
                            if (state is CreatedSuccessState) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    'Lyrics request submitted successfully!'),
                                action: SnackBarAction(
                                  label: "see",
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LyricsRequestDetailPage(
                                                    request: state.request)));
                                  },
                                ),
                              ));
                              BlocProvider.of<LyricsBloc>(context)..add(GetAllLyrics());
                              setState(() {
                                artist = song = lyrics = url = "";
                              });
                              formkey.currentState.reset();
                            }
                          },
                          builder: (context, state) {
                            if (state is CreatingBusyState) {
                              return SpinKitWave(
                                size: 20,
                                color: kPrimary,
                              );
                            }
                            return FlatButton(
                                onPressed: () {
                                  if (formkey.currentState.validate()) {
                                    print('flat button pressed');
                                    BlocProvider.of<LyricsBloc>(context)
                                      ..add(CreateLyrics(
                                          lyricsRequest: Lyrics(
                                              musicName: song,
                                              artistName: artist,
                                              lyrics: lyrics,
                                              url: url)));
                                  }
                                },
                                minWidth: double.infinity,
                                height: 50,
                                color: kPrimary,
                                child: Text(
                                  "Add Lyrics",
                                  style: TextStyle(color: Colors.white),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
