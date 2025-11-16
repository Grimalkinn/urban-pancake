import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:math' as math;

import '../services/image_service.dart';
import '../subpages/view.dart' as view;

class Lookup extends StatefulWidget {
  const Lookup({super.key, required String searched});
  @override
  State<Lookup> createState() => LookupState();
}

class LookupState extends State<Lookup> {
  var random = math.Random();
  List<dynamic> photos = [];
  bool loading = false;
  int page = 0;
  final scroll = ScrollController();

  Future<void> _loadImages() async {
    if (loading) return;

    setState(() => loading = true);
    page = random.nextInt(100);
    String url =
        'https://api.unsplash.com/search/photos?query=kittens?order_by=latest';
    try {
      // final newImages = await ImageService.fetchFeed(baseUrl: url);
      final newImages = await ImageService.fetchImages(baseUrl: url);
      var results = newImages["results"];
      // print(results['id']);
      setState(() {
        photos.addAll(results);
        page += 1;
      });
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 
      // titled searched term
      // search bar with search button
      // image grid with searched images

      // appBar: AppBar(title: const Text('pin feed')),
      backgroundColor:
          const Color.fromRGBO(44, 45, 49, 1), // #191e1f 25, 30, 31
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            photos.clear();
            page = 1;
          });
          await _loadImages();
        },
        child: MasonryGridView.count(
          controller: scroll,
          crossAxisCount: 2,
          itemCount: photos.length,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final photo = photos[index];
            final url = photo['urls']['small_s3'];
            String query = "";
            // if (photo.length > query.length) {
            query = "kittens";
            // } else {
            //   String desc = photo['description'];
            //   List<String> descList = desc.trim().split(" ");
            //   query = descList[
            //       math.Random().nextInt(((descList.length) / 2) as int)];
            // }

            return GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => view.View(
                            image: photo,
                            related: photo['description'] ?? "kittens"),
                      ),
                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    placeholder: (context, _) =>
                        Container(color: Colors.grey.shade200, height: 150),
                    errorWidget: (context, _, __) =>
                        const Icon(Icons.error, color: Colors.red),
                  ),
                ));
          },
        ),
      ),
    );
    // );
  }
}
