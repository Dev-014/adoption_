import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/views/home/pet_grid_view.dart';
import 'package:provider/provider.dart';

import '../../blocs/pet/pet_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../models/pet.dart';
import '../details/detail_screen.dart';
import '../history/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 24),
            Expanded(
              child: PetGridView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find Your',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                'Friend',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
         Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             IconButton(
               icon: const Icon(Icons.history),
               onPressed: () => Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const HistoryScreen(),
                 ),
               ),
             ),
             IconButton(
               icon: Icon(themeProvider.themeMode == ThemeMode.dark
                   ? Icons.light_mode
                   : Icons.dark_mode),
               onPressed: () {
                 themeProvider.toggleTheme(themeProvider.themeMode == ThemeMode.light);
               },
             ),
           ],
         )
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search pets...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: (value) => context.read<PetProvider>().searchPets(value),
      ),
    );
  }
  
}
