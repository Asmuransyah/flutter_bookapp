import 'package:flutter/material.dart';
import 'package:flutter_bookapp/colors.dart';
import 'package:flutter_bookapp/controllers/book_controller.dart';
import 'package:flutter_bookapp/views/book_list_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primaryColor: AppColor.warna1,
          colorScheme: const ColorScheme.light(
            primary: AppColor.warna3,
            secondary: AppColor.warna4,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.warna1,
            foregroundColor: AppColor.warna2,
          ),
        ),
        home: const BookListPage(),
      ),
    );
  }
}
