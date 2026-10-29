import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/home/presentation/screens/home_screen.dart';
import 'package:bookia/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:bookia/features/cart/presentation/screens/cart_screen.dart';
import 'package:bookia/features/profile/presentation/screens/profile_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  /// The selected tab. Other pages can change it (e.g. "Back To Home" after an order).
  static final currentTab = ValueNotifier<int>(0);

  static const _pages = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentTab,
      builder: (context, index, _) => Scaffold(
        body: IndexedStack(index: index, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) {
            if (i == 2) context.read<CartCubit>().getCart(); // refresh the cart
            currentTab.value = i;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFBFA05A),
          unselectedItemColor: const Color(0xFF2F2F2F),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
