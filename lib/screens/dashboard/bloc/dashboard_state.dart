import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class ScreenLoading extends DashboardState {
  @override
  String toString() => "ScreenLoading";
}

class HomeScreenLoaded extends DashboardState {}

class SearchScreenLoaded extends DashboardState {}

class CommentScreenLoaded extends DashboardState {}

class ProfileScreenLoaded extends DashboardState {}
