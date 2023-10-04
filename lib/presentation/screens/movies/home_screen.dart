import 'package:flutter/material.dart';
import 'package:tapitafilms/presentation/views/views.dart';
import 'package:tapitafilms/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

