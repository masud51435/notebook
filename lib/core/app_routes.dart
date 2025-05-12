import 'package:go_router/go_router.dart';

import '../pages/frontpage.dart/frontPage.dart';
import '../pages/home_page/home_page.dart';
import '../pages/home_page/widgets/add_note.dart';
import '../pages/home_page/widgets/note_detail.dart';
import '../pages/login/login.dart';
import '../pages/sign_up/sign_up.dart';
import '../pages/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String frontPage = '/frontPage';
  static const String splashScreen = '/splashScreen';
  static const String homePage = '/homePage';
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String addNote = '/addNote';
  static const String noteDetails = '/noteDetails';

  static final GoRouter router = GoRouter(
    initialLocation: frontPage,
    routes: [
      GoRoute(path: frontPage, builder: (context, state) => const Frontpage()),
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: homePage, builder: (context, state) => const HomePage()),
      GoRoute(path: signUp, builder: (context, state) => const SignUp()),
      GoRoute(path: login, builder: (context, state) => const Login()),
      GoRoute(path: addNote, builder: (context, state) => const AddNotePage()),
      GoRoute(
        path: noteDetails,
        builder: (context, state) {
          return NoteDetailPage();
        },
      ),
    ],
  );
}
