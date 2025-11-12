// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import 'dart:math';

// import 'services/image_service.dart';

// void main() => runApp(const PinterestCloneApp());

// class PinterestCloneApp extends StatelessWidget {
//   const PinterestCloneApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pinterest CloneZ',
//       theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.redAccent),
//       home: const HomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final List<dynamic> _photos = [];
//   var random = Random();
//   int _page = 1;
//   bool _isLoading = false;
//   final _scrollController = ScrollController();

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
