// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption/blocs/pet/pet_bloc.dart';
import 'package:pet_adoption/blocs/theme/theme_bloc.dart';

import 'package:pet_adoption/main.dart';
import 'package:pet_adoption/models/pet.dart';
import 'package:pet_adoption/views/home/home.dart';
import 'package:pet_adoption/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('HomeScreen displays pets', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PetProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Verify initial loading state
    expect(find.byType(ShimmerLoader), findsOneWidget);

    // Load mock data
   Pet mockPet =   Pet(
     id: '1',
     name: 'Buddy',
     breed: 'Golden Retriever',
     age: 3,
     price: 500.0,
     imageUrl: 'assets/golden.png',
     gender: 'M',
     description: '',
     characteristics: [],
   );
   await tester.pump();


    // Verify pets are displayed
    expect(find.text(mockPet.name), findsOneWidget);
  });
}