import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

   int getCurrentIndex(BuildContext context){
    final String location = GoRouterState.of(context).fullPath??'/';
    switch(location){
      case '/':
        return 0;

      case '/categories':
       return 1;

      case '/favorites':
        return 2;

      default:
      return 0;
    }
  }

  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
      //todo: categoria
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
         // value = [0,1,2]
        currentIndex: getCurrentIndex(context),
        onTap: (value) => onItemTap(context,value),
          
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.label_outline), label: 'Categorías'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
        ]);
  }
}
