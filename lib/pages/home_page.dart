import 'package:flutter/material.dart';
import 'package:kitchen_helper/pages/conversions_page.dart';
import 'package:kitchen_helper/pages/recipes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _index = 0;
  final _pageController = PageController();

  final _titles = const [
    'Conversions',
    'Recipes',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles.elementAt(_index)),
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          ConversionsPage(),
          RecipesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_rounded),
            label: 'Conversions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: 'Recipes',
          ),
        ],
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
            _pageController.jumpToPage(value);
          });
        },
      ),
    );
  }
}
