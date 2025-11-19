import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import '../services/image_service.dart';
import '../subpages/saved.dart' as saved;

import 'dart:math';

// stateful widget updates
class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => ProfileState();
} // file class

class ProfileState extends State<Profile> {
  var random = Random();
  List<dynamic> photos = [];
  // int page = 0;
  bool loading = false;
  final scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadImages();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        _loadImages();
      }
    });
  }

  Future<void> _loadImages() async {
    if (loading) return;

    setState(() {
      loading = true;
    });
    // page = random.nextInt(100);
    // String look = widget.searched;
    String url =
        'https://api.unsplash.com/search/photos?query=profile?order_by=latest';
    try {
      // final newImages = await ImageService.fetchFeed(baseUrl: url);
      final newImages = await ImageService.fetchImages(baseUrl: url);
      var results = newImages["results"];
      // print(results['id']);
      setState(() {
        photos.addAll(results);
        // page += 1;
      });
    } finally {
      setState(() => loading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("profile"),
      ),
      backgroundColor: const Color.fromRGBO(44, 45, 49, 1), // #191e1f 25, 30, 31
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            photos.clear();
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

            return GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => saved.Saved(
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
  }
}

//
