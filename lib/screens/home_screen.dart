import 'package:flutter/material.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/screens/tabs/products_tab.dart';
import 'package:my_app/screens/tabs/profile_tab.dart';
import 'package:my_app/screens/tabs/search_tab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        // ignore: use_build_context_synchronously
        Provider.of<ProductProvider>(context, listen: false).fetchProducts());
  }

  int _selectedIndex = 0;
  final List<String> _titles = ['Home', 'Search', 'Profile'];

  final List<Widget> _tabs = const [
    ProductsTab(),
    SearchTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.deepPurple.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: _tabs[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        elevation: 8,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
