import 'package:bloc/bloc.dart';

import '../screens/home_page.dart';
import '../screens/home_page.dart';
import '../screens/login.dart';

enum NavigationEvents {
  HomePageClickEvent,
  LogoutClickEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  // TODO: implement initialState
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickEvent:
        yield HomePage();
        break;
      case NavigationEvents.LogoutClickEvent:
        yield LoginPage();
        break;
      default:
    }
  }
}
