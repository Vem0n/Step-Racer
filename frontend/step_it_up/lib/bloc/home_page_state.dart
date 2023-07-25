part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoadedNoDevice extends HomePageState {}

class HomePageLoadedSetDevice extends HomePageState {}
