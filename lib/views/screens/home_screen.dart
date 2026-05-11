import 'package:flutter/material.dart';
import 'package:pixora/controllers/controllers.dart';
import 'package:pixora/views/screens/history_screen.dart';
import 'package:pixora/views/screens/image_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenController>(
      builder: (context, controller, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            backgroundColor: Colors.grey,
            showUnselectedLabels: true,
            currentIndex: controller.currentIndex,
            type: BottomNavigationBarType.fixed, // Essential for 4+ items
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade800,
            onTap: controller.setPage,
            elevation: 2,
            items: [
              BottomNavigationBarItem(
                label: 'Image',
                tooltip: 'Image Upload',
                activeIcon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.home, color: Colors.black)),
                icon: Icon(Icons.home, color: Colors.grey.shade800),
              ),
              BottomNavigationBarItem(
                label: 'History',
                tooltip: 'History of uploaded images',
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.list,
                    color: Colors.black,
                  ),
                ),
                icon: Icon(Icons.list, color: Colors.grey.shade800),
              ),
            ],
          ),
          body: PageView(
            controller: controller.pageController,
            onPageChanged: controller.setPage,
            children: const [
              ImageScreen(),
              HistoryScreen(),
            ],
          ),
        );
      },
    );
  }
}
