import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:example/screens/dashboard/dashboard_screen.dart';
import 'bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int currentIndex = 0;

  DashboardBloc() : super(ScreenLoading());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is DashboardStarted) {
      add(OnTapPage(pageIndex: currentIndex));
    }
    if (event is OnTapPage) {
      // yield ScreenLoading()
      currentIndex = event.pageIndex;

      if (currentIndex == TabBarIndex.home.index) {
        yield HomeScreenLoaded();
      } else if (currentIndex == TabBarIndex.search.index) {
        yield SearchScreenLoaded();
      } else if (currentIndex == TabBarIndex.comment.index) {
        yield CommentScreenLoaded();
      } else if (currentIndex == TabBarIndex.profile.index) {
        yield ProfileScreenLoaded();
      }
    }
  }
}
