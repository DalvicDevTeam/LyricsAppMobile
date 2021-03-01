import 'package:dalvic_lyrics_sharing_app/blocs/authenticationbloc/authenticationbloc.dart';
import 'package:dalvic_lyrics_sharing_app/blocs/homepagebloc/homepagebloc.dart';
import 'package:dalvic_lyrics_sharing_app/blocs/lyricsbloc/lyricsbloc.dart';
import 'package:dalvic_lyrics_sharing_app/blocs/authenticationbloc/authenticationevent.dart';
import 'package:dalvic_lyrics_sharing_app/blocs/lyricsrequestbloc/lyricsrequest.dart';
import 'package:dalvic_lyrics_sharing_app/blocs/signinbloc/signinbloc.dart';
import 'package:dalvic_lyrics_sharing_app/blocs/signupbloc/signup.dart';
import 'package:dalvic_lyrics_sharing_app/blocs/userbloc/userbloc.dart';
import 'package:dalvic_lyrics_sharing_app/constants.dart';
import 'package:dalvic_lyrics_sharing_app/data_provider/lyricsrequestdataprovider.dart';
import 'package:dalvic_lyrics_sharing_app/data_provider/data_provider.dart';
import 'package:dalvic_lyrics_sharing_app/data_provider/userdataprovider.dart';
import 'package:dalvic_lyrics_sharing_app/helper/localhelper.dart';
import 'package:dalvic_lyrics_sharing_app/models/Lyrics.dart';
import 'package:dalvic_lyrics_sharing_app/repository/homepagerepository.dart';
import 'package:dalvic_lyrics_sharing_app/repository/lyricsrequestrepository.dart';
import 'package:dalvic_lyrics_sharing_app/repository/userrepository.dart';
import 'package:dalvic_lyrics_sharing_app/screens/lyricsrequestspage.dart';
import 'package:dalvic_lyrics_sharing_app/repository/lyricsRepository.dart';
import 'package:dalvic_lyrics_sharing_app/repository/signinrepository.dart';
import 'package:dalvic_lyrics_sharing_app/screens/mylyricspage.dart';
import 'package:dalvic_lyrics_sharing_app/screens/updateprofile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/screens.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  LocalHelper localHelper = LocalHelper(sharedPreferences: _sharedPreferences);

  LyricsDataProvider _lyricsDataProvider = LyricsDataProvider(
    httpClient: http.Client(),
    localHelper: localHelper,
  );
  LyricsRequestRepository _lyricsRequestRepository =
      new LyricsRequestRepository(
          dataProvider:
              new LyricsRequestDataProvider(httpClient: http.Client(), localHelper: localHelper));
  SignUpRepository _signUpRepository =
      SignUpRepository(signUpDataProvider: new SignUpDataProvider());
  SignInRepository _signInRepository =
      SignInRepository(signInDataProvider: new SignInDataProvider());
  LyricsRepository lyricsRepository = LyricsRepository(
    dataProvider: _lyricsDataProvider,
  );
  HomePageBloc homePageBloc = HomePageBloc(homePageRepository: HomepageRepository(lyricsDataProvider: LyricsDataProvider(httpClient: http.Client(), localHelper: localHelper)))..add(HomepageEvent.GetLyrics);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) => SignUpBloc(signUpRepository: _signUpRepository)),
    BlocProvider(
        create: (context) =>
            LyricsRequestBloc(lyricsRequestRepository: _lyricsRequestRepository)
              ..add(GetAllRequest())),
    BlocProvider(
        create: (context) =>
            AuthenticationBloc(sharedPreferences: _sharedPreferences)
              ..add(InitEvent())),
    BlocProvider(
      create: (context) => UserBloc(userRepository: UserRepository(userDataProvider: UserDataProvider(localHelper: localHelper, httpClient:http.Client()))),
    ),
    BlocProvider(
        create: (context) => LyricsBloc(lyricsRepository: lyricsRepository)),
    BlocProvider(
        create: (context) => SignInBloc(signInRepository: _signInRepository)),
    BlocProvider(create: (context) => homePageBloc )], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: kPrimary,
      title: 'Lyrics Sharing',
      initialRoute: '/splash',
      routes: {
        '/': (context) => WelcomePage(),
        '/splash': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/addlyrics': (context) => AddLyricsPage(),
        '/addrequest': (context) => AddRequestPage(),
        '/profile': (context) => ProfilePage(),
        '/lyricsrequests': (context) => LyricsRequestsPage(),
        '/mylyrics':(context)=>MyLyricsPage(),
        '/updateprofile': (context)=>UpdateProfile()
      },
      onGenerateRoute: (settings){
        if(settings.name == LyricsPage.routeName){
          Lyrics arg = settings.arguments;
          return MaterialPageRoute(builder: (ctx) => LyricsPage(lyrics: arg));
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimary,
      ),
    );
  }
}
