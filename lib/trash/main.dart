import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:math';

import '../pages/feed.dart' as feed;
import '../pages/search.dart' as search;
import '../pages/profile.dart' as profile;
// import '../services/image_service.dart';

void main() {
  return runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: const App(),
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.redAccent),
      debugShowCheckedModeBanner: false,
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> _pages = const [
    search.Search(), // 0
    feed.Feed(), // 1
    profile.Profile(), //2
  ];
  var random = Random();
  int _selectedIndex = 0; // feed page as start page
  // bool _isLoading = false;
  // final _scrollController = ScrollController();

  void _onPageTap(int index) {
    setState(() => _selectedIndex = index);
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onPageTap,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search_outlined), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Feed'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

}



//   @override
//   void initState() {
//     super.initState();
//     _loadImages();
//     _scrollController.addListener(_scrollListener);
//   }

//   void _scrollListener() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       _loadImages();
//     }
//   }

//   Future<void> _loadImages() async {
//     if (_isLoading) return;

//     setState(() => _isLoading = true);
//     // int next = random.nextInt(10);
//     _page = random.nextInt(100);

//     try {
//       final newImages = await ImageService.fetchImages(page: _page);
//       setState(() {
//         _photos.addAll(newImages);
//         _page += 1;
//       });
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pinterest Clone')),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           setState(() {
//             _photos.clear();
//             _page = 1;
//           });
//           await _loadImages();
//         },
//         child: MasonryGridView.count(
//           controller: _scrollController,
//           crossAxisCount: 2,
//           itemCount: _photos.length,
//           mainAxisSpacing: 8,
//           crossAxisSpacing: 8,
//           padding: const EdgeInsets.all(8),
//           itemBuilder: (context, index) {
//             final photo = _photos[index];
//             final url = photo['urls']['small'];

//             return ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: CachedNetworkImage(
//                 imageUrl: url,
//                 placeholder: (context, _) =>
//                     Container(color: Colors.grey.shade200, height: 150),
//                 errorWidget: (context, _, __) =>
//                     const Icon(Icons.error, color: Colors.red),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
