import 'package:flutter/material.dart';
import 'package:flutter_bookapp/colors.dart';
import 'package:flutter_bookapp/controllers/book_controller.dart';

import 'package:flutter_bookapp/views/detail_book_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;

  @override
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.warna1,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Book Catalouge"),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/notification.svg"))
        ],
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controller, child) => Container(
          child: bookController!.bookList == null
              ? child
              : ListView.builder(
                  itemCount: bookController!.bookList!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook = bookController!.bookList!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailBookPage(
                              isbn: currentBook.isbn13!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 180,
                        width: double.maxFinite,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(5),
                          elevation: 5,
                          child: Row(
                            children: [
                              Image.network(
                                currentBook.image!,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentBook.title!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currentBook.subtitle!,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 68,
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  Uri uri = Uri.parse(controller
                                                      .detailBook!.url!);
                                                  try {
                                                    await (canLaunchUrl(uri))
                                                        ? launchUrl(uri)
                                                        : debugPrint(
                                                            "TIDAK BERHASIL NAVIGASI");
                                                  } catch (e) {
                                                    debugPrint("error");
                                                  }
                                                },
                                                child: const Text(
                                                  'Buy Now',
                                                  style: TextStyle(fontSize: 8),
                                                )),
                                          ),
                                          Text(
                                            "Price : ${currentBook.price!}",
                                            style: TextStyle(
                                                color: Colors.amber[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
