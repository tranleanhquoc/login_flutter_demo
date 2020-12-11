import 'package:example/commons/app_assets.dart';
import 'package:example/commons/utils/pref.dart';
import 'package:example/components/loading_widget.dart';
import 'package:example/components/square_button.dart';
import 'package:example/screens/authentication/bloc/authentication_bloc.dart';
import 'package:example/screens/authentication/bloc/bloc.dart';
import 'package:example/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../commons/app_assets.dart';
import 'bloc/bloc.dart';

enum TabBarIndex { home, search, add, comment, profile }

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key key}) : super(key: key);

  final _pref = LocalPref();

  void _onTapPage(BuildContext context, int index) {
    BlocProvider.of<DashboardBloc>(context).add(OnTapPage(pageIndex: index));
  }

  int _currentIndex(BuildContext context) {
    return BlocProvider.of<DashboardBloc>(context).currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return;
        },
        child: BlocProvider(
            create: (context) => DashboardBloc()..add(DashboardStarted()),
            child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
              return Scaffold(
                body: _showScreenByState(state, context),
                bottomNavigationBar: _bottomNavigationBar(state, context),
              );
            })));
  }

  Widget _bottomNavigationBar(DashboardState state, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex(context),
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsSVG.icHome), label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsSVG.icSearch), label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsSVG.icNew), label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsSVG.icComment), label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsSVG.icProfile), label: ''),
        ],
        onTap: (index) => _onTapPage(context, index),
      ),
    );
  }

  Widget _showScreenByState(DashboardState state, BuildContext context) {
    if (state is ScreenLoading) {
      return LoadingWidget();
    } else if (state is HomeScreenLoaded) {
      return HomeScreen();
    } else if (state is SearchScreenLoaded) {
      return Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          "Search Screen",
          style: GoogleFonts.roboto(fontSize: 36),
        ),
      );
    } else if (state is CommentScreenLoaded) {
      return Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          "Comment Screen",
          style: GoogleFonts.roboto(fontSize: 36),
        ),
      );
    } else if (state is ProfileScreenLoaded) {
      return Container(
        color: Colors.amber,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile Screen",
              style: GoogleFonts.roboto(fontSize: 36),
            ),
            SquareButton(
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogOutRequested());
                _pref.removeKey(PrefKey.accessToken);
              },
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              text: "LOG OUT",
              textStyle:
                  GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w900),
              boxBorder: Border.all(color: Colors.black, width: 2),
            )
          ],
        ),
      );
    }
    return LoadingWidget();
  }
}
