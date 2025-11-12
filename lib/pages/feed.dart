import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:math';

import '../services/image_service.dart';

// import '../pages/profile.dart' as profile;
// import '../pages/search.dart' as search;
// import '../pages/feed.dart' as feed;

// void main() => runApp(const Feed());

// class Feed extends StatelessWidget {
//   const Feed({super.key});

//   @override
//   Widget build(BuildContext context) {
//
//     throw UnimplementedError();
//   }
// }

class Feed extends StatefulWidget {
  const Feed({super.key});
  @override
  State<Feed> createState() => FeedState();
}

class FeedState extends State<Feed> {
  final List<dynamic> _photos = [];
  var random = Random();
  int _page = 1;
  bool _isLoading = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadImages();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadImages();
    }
  }

  Future<void> _loadImages() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    // int next = random.nextInt(10);
    _page = random.nextInt(100);
    String url = 'https://api.unsplash.com/photos';

    try {
      final newImages =
          await ImageService.fetchImages(page: _page, baseUrl: url);
      setState(() {
        _photos.addAll(newImages);
        _page += 1;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }


  // int _selectedIndex = 1;

  // void _onPageTap(int index) {
  //   setState(() => _selectedIndex = index);
  // }

   // ignore: prefer_final_fields
  //  List<Widget> _pages =  [
  //   const search.Search(), // 0
  //   const Feed(), // 1
  //   const profile.Profile(), // 2
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('pin feed')),
      // body: _pages[_selectedIndex],
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _photos.clear();
            _page = 1;
          });
          await _loadImages();
        },
        child: MasonryGridView.count(
          controller: _scrollController,
          crossAxisCount: 2,
          itemCount: _photos.length,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final photo = _photos[index];
            final url = photo['urls']['small'];

            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, _) =>
                    Container(color: Colors.grey.shade200, height: 150),
                errorWidget: (context, _, __) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            );
          },
        ),
      ),

      // bottomNavigationBar: NavigationBar(
      //   selectedIndex: _selectedIndex,
      //   onDestinationSelected: _onPageTap,
      //   destinations: const [
      //     NavigationDestination(
      //         icon: Icon(Icons.search_outlined), label: 'Search'),
      //     NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Feed'),
      //     NavigationDestination(
      //         icon: Icon(Icons.person_outline), label: 'Profile'),
      //   ],
      // ),
      
    );
  }
}
