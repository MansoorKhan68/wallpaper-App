import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:panel_app/widgets/collection_tile.dart';
import 'package:panel_app/widgets/image_tile.dart';

class MyHomePage extends StatefulWidget {
  final Function(bool) afterScrollResult;
  const MyHomePage({super.key, required this.afterScrollResult});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  // show scroll visibility
  bool _isVisible = true;
  @override
  void initState() {
    
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
        // result : false
        if(_isVisible){
          _isVisible = false;
          widget.afterScrollResult(_isVisible);
        }
      }
    if(_scrollController.position.userScrollDirection == ScrollDirection.forward){
      // result : true
      if(!_isVisible){
          _isVisible = true;
          widget.afterScrollResult(_isVisible);
        }
    }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              SliverAppBar(
                floating: true,
                snap: true,
                title: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.grey,shape: BoxShape.circle),
                ),
              bottom: const TabBar(
                indicatorColor: Colors.red,
                indicatorWeight: 4,
                tabs: [
                Tab(text:  'Suggested',),
                Tab(text:  'Liked',),
                Tab(text:  'Library',),
              ]),
              )
            ];
          },
          body: TabBarView(
            children: [
              // TAB -> 1
            MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemBuilder: (context, index) {
                return (index % 2) == 0 ? ImageTile(
                    imageSource: 'https://picsum.photos/500/1000?random=$index',
                    index: index,
                    extent: 300 )
                    : CollectionTile(index: index, extent: 150);
              },
            ),
            // TAB -> 2
            const SizedBox(),
            // TAB -> 3
            const SizedBox(),
            ]
          ),
        ),
      ),
    );
  }
  
}
