// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bookapp/colors.dart';
import 'package:flutter_bookapp/controllers/book_controller.dart';

import 'package:flutter_bookapp/views/image_view.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({
    Key? key,
    required this.isbn,
  }) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? controller;
  @override
  void initState() {
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetcDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Detail Book Page"),
      ),
      body: Consumer<BookController>(builder: (context, controller, child) {
        return controller.detailBook == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColor.warna1,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageView(
                                      imageUrl: controller.detailBook!.image!),
                                ),
                              );
                            },
                            child: Image.network(
                              controller.detailBook!.image!,
                              height: 180,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.detailBook!.title!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.warna2),
                                  ),
                                  Text(
                                    controller.detailBook!.authors!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: List.generate(
                                        5,
                                        (index) => Icon(
                                              Icons.star,
                                              size: 20,
                                              color: index <
                                                      int.parse(controller
                                                          .detailBook!.rating!)
                                                  ? Colors.amber[800]
                                                  : Colors.grey,
                                            )),
                                  ),
                                  Text(
                                    controller.detailBook!.subtitle!,
                                    style: const TextStyle(
                                        fontSize: 12, color: AppColor.warna2),
                                  ),
                                  Text(
                                    controller.detailBook!.price!,
                                    style: const TextStyle(
                                      color: AppColor.warna3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                Uri uri =
                                    Uri.parse(controller.detailBook!.url!);
                                try {
                                  await (canLaunchUrl(uri))
                                      ? launchUrl(uri)
                                      : debugPrint("TIDAK BERHASIL NAVIGASI");
                                } catch (e) {
                                  debugPrint("error");
                                }
                              },
                              child: const Text("Buy Now"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(controller.detailBook!.desc!),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  "Publisher : ${controller.detailBook!.publisher!} ${controller.detailBook!.year!}"),
                              Text(
                                  "Pages : ${controller.detailBook!.pages!} pages"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          controller.similiarBooks == null
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  height: 180,
                                  child: ListView.builder(
                                    //shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.similiarBooks!.books!.length,
                                    //physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final current = controller
                                          .similiarBooks!.books![index];
                                      return SizedBox(
                                        width: 100,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailBookPage(
                                                  isbn: current.isbn13!,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Image.network(
                                                current.image!,
                                                height: 120,
                                              ),
                                              Text(
                                                current.title!,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
