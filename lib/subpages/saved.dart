// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import 'dart:math' as math;

import '../services/image_service.dart';
import '../services/relative_content.dart';

// import './view.dart' as view;

class Saved extends StatefulWidget {
  final dynamic image;
  final String related;
  const Saved({super.key, required this.image, required this.related});
  @override
  State<Saved> createState() => SavedState();
}

class SavedState extends State<Saved> {
  final List<dynamic> relative = [];
  int page = 1;
  bool loading = false;
  final scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    load();
    scroll.addListener(scrollListener);
  }

  void scrollListener() {
    if (scroll.position.pixels == scroll.position.maxScrollExtent) {
      load();
    }
  }


  Future<void> load() async {
    if (loading) return;
    setState(() => loading = true);
    String word = RelativeContent.getRelativeContent(
      titleDescription: widget.related
    ) as String;
    // api.unsplash.com/search/photos?query=wanderl
    // https://unsplash.com/s/photos/cigarette?order_by=curated&orientation=portrait&license=free
    // String url = 'https://api.unsplash.com/search/photos?query=cigarette';
    String url = 'https://api.unsplash.com/search/photos?query=$word?order_by=latest';
    // String url = 'https://api.unsplash.com/search/photos?query=kittens';
    // String url = 'https://api.unsplash.com/photos?page=30';
    // ?order_by=curated&orientation=portrait&license=free

    try {
      final newImages = await ImageService.fetchImages(baseUrl: url);
      var results = newImages["results"];

      // final newImages = await ImageService.fetchFeed(baseUrl: url);
      // var results = newImages;
      setState(() {
        relative.addAll(results);
        page += 1;
      });
    } finally {
      setState(() => loading = false);
    }
  }

  void download() {}
  void wallpaper() {}

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.image['urls']['small']; // Get the full size image URL
    return Scaffold(
      // todo:
      appBar: AppBar(
        title: Text(widget.image["description"] ?? 'Image Detail'),
        forceMaterialTransparency: true,
      ), // Display a title
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 0.0),
              width: 50,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: Text(widget.image['description'] ??
                  widget.image['alt_description'] ??
                  'No description available'),
            ),
            // You can add more details or the related images grid here
            
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Related Photos:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            
            Row(
              children :[
                Container(
                  padding: const EdgeInsets.all(32),
                  child: ElevatedButton(child: const Text("Save"), 
                  onPressed: () => download(),),
                ),
                Container(
                  padding: const EdgeInsets.all(32),
                  child: ElevatedButton(child: const Text("wallpaper"), 
                  onPressed: () => wallpaper(),),
                ),
              ]
            ),
            
            

            
          ],
        ),
      ),
    );
  }
}
