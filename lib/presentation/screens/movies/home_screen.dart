import 'package:flutter/material.dart';
import 'package:tapitafilms/presentation/views/views.dart';
import 'package:tapitafilms/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // <----- categorias
    FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavbar(currentIndex: pageIndex),
    );
  }
}
