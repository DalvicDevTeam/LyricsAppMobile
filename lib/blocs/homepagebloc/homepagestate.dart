import 'package:dalvic_lyrics_sharing_app/models/Lyrics.dart';
import 'package:dalvic_lyrics_sharing_app/models/hompagestat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class HomepageState extends Equatable{}

class HomepageBusyState extends HomepageState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomepageSuccessState extends HomepageState{
  final List<Lyrics> lyrics;
  HomepageSuccessState({@required this.lyrics}):assert(lyrics!=null);

  @override
  // TODO: implement props
  List<Object> get props => [lyrics];
}

class HomepageFailureState extends HomepageState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomepageStatBusyState extends HomepageState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomepageStatSuccessState extends HomepageState{
  final HomepageStat stat;
  HomepageStatSuccessState({@required this.stat}):assert(stat!=null);

  @override
  // TODO: implement props
  List<Object> get props => [stat];
}

class HomepageStatFailedState extends HomepageState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}