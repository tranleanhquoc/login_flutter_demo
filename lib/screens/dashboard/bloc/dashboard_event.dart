import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardStarted extends DashboardEvent {
  @override
  String toString() => "DashboardStarted";
}

class OnTapPage extends DashboardEvent {
  final int pageIndex;

  OnTapPage({this.pageIndex});

  @override
  List<Object> get props => [pageIndex];

  @override
  String toString() => 'PageTapped: $pageIndex';
}
