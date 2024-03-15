// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:final_project1/Screens/explore_screen.dart';
import 'package:final_project1/Screens/signin_screen.dart';
import 'package:final_project1/Screens/signup_screen.dart';
import 'package:final_project1/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:final_project1/main.dart';

void main() {
  //Welcome Screen
  testWidgets('find if log-in option is there',
          (tester) async{
            await tester.pumpWidget(
                MaterialApp(
                  home:WelcomeScreen(
                        title:'My App',
                    ),
                ),
            );
            final ctr=find.text('Log In');
            expect(ctr, findsOneWidget);
  },);
  testWidgets('find if sign-Up option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:WelcomeScreen(
            title:'My App',
          ),
        ),
      );
      final ctr=find.text('Sign Up');
      expect(ctr, findsOneWidget);
    },);
  testWidgets('find if sign-in button',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:WelcomeScreen(
            title:'My App',
          ),
        ),
      );
      final btn= find.byType(Container);
      expect(btn, findsNWidgets(2));
    },);
  //Sign-in screen
  testWidgets('find if username text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignInScreen(),
        ),
      );
      final ctr=find.text('Enter Username');
      expect(ctr, findsOneWidget);
    },);
  testWidgets('find if username icon text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignInScreen(),
        ),
      );
      final ctr=find.byIcon(Icons.person_outline);
      expect(ctr, findsAny);
    },);
  testWidgets('find if password text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignInScreen(),
        ),
      );
      final ctr=find.text('Enter Password');
      expect(ctr, findsOneWidget);
    },);
  testWidgets('find if password icon text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignInScreen(),
        ),
      );
      final ctr=find.byIcon(Icons.lock_outline);
      expect(ctr, findsAny);
    },);

  //SignUp Screen
  testWidgets('find if firstname text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignUpScreen(),
        ),
      );
      final ctr=find.text(" First Name");
      expect(ctr, findsAny);
    },);
  testWidgets('find if firstname icon text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignUpScreen(),
        ),
      );
      final ctr=find.byIcon(Icons.person_outline);
      expect(ctr, findsAny);
    },);
  testWidgets('find if email text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignUpScreen(),
        ),
      );
      final ctr=find.text(" Email");
      expect(ctr, findsOneWidget);
    },);
  testWidgets('find if email icon text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignUpScreen(),
        ),
      );
      final ctr=find.byIcon(Icons.mail_outline);
      expect(ctr, findsAny);
    },);
  testWidgets('find if password text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignUpScreen(),
        ),
      );
      final ctr=find.text(" Password");
      expect(ctr, findsOneWidget);
    },);
  testWidgets('find if password icon text field option is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home:SignUpScreen(),
        ),
      );
      final ctr=find.byIcon(Icons.lock_outline);
      expect(ctr, findsAny);
    },);
  //Explore Screen
  testWidgets('find if the search bar is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
         home: ExploreScreen(),
        ),
      );
      final btn= find.byType(Container);
      final ctr=find.text( "Search a trail ...");
      expect(btn,findsAny);
      expect(ctr, findsAny);
    },);
  testWidgets('find if the Mynydd Gelliwion Walk is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home: ExploreScreen(),
        ),
      );
      final ctr=find.text("Mynydd Gelliwion Walk");
      expect(ctr, findsAny);
    },);
  testWidgets('find if the Cwm Clydach Lake Walk is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home: ExploreScreen(),
        ),
      );
      final ctr=find.text("Cwm Clydach Lake Walk");
      expect(ctr, findsAny);
    },);
  testWidgets('find if the Darran Park Circular walk is there',
        (tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home: ExploreScreen(),
        ),
      );
      final ctr=find.text("Darran Park Circular walk");
      expect(ctr, findsAny);
    },);
}


