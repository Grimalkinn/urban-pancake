// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import 'dart:math' as math;

import '../services/image_service.dart';
import '../services/relative_content.dart';

// import './view.dart' as view;

class View extends StatefulWidget {
  final dynamic image;
  final String related;
  const View({super.key, required this.image, required this.related});
  @override
  State<View> createState() => ViewState();
}

class ViewState extends State<View> {
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

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.image['urls']['small']; // Get the full size image URL
    return Scaffold(
      // todo:
      // back button with history
      // image view with zoom support
      // caption details and links
      // save and like button
      // related pictures in grid
/**/

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
            // if (relative.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Related Photos:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            // Example for related pictures in a grid
            MasonryGridView.count(
              controller: scroll,
              shrinkWrap: true, // Important for nested scrollables
              // physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
              crossAxisCount: 2,
              itemCount: relative.length,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final relatedPhoto = relative[index];
                final relatedUrl = relatedPhoto['urls']['small_s3'];
                String query = "cigarette";
                // if (widget.related.length > query.length) {
                  query = "cigarette";
                // } else {
                //   String desc = widget.image['description'];
                //   List<String> descList = desc.trim().split(" ");
                //   query = descList[
                //       math.Random().nextInt(((descList.length) / 2) as int)];
                // }

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          View(image: relatedPhoto, related: query),
                    ),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: relatedUrl,
                      placeholder: (context, _) =>
                          Container(color: Colors.grey.shade200, height: 100),
                      errorWidget: (context, _, __) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
            // ],
            if (loading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
