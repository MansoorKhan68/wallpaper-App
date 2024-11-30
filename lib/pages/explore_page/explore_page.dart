import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:panel_app/widgets/image_tile.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // Variable to hold the current index
  int _selectedSliderIndex = 0;

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
          setState(() {
            _isVisible = false;
          });
          // widget.afterScrollResult(_isVisible);
        }
      }
    if(_scrollController.position.userScrollDirection == ScrollDirection.forward){
      // result : true
      if(!_isVisible){
          setState(() {
            _isVisible = true;
          });
          // widget.afterScrollResult(_isVisible);
        }
    }
    });
  }

  // PageController to control the PageView
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // CREATE A LIST OF INDICATORS
    List<Widget> indicatorContainer = List.generate(5, (index) {
      return AnimatedContainer(
        duration: const Duration(microseconds: 300),
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedSliderIndex == index ? Colors.white : Colors.grey,
        ),
      );
    });

    return SafeArea(
      top: !_isVisible,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: NestedScrollView(
         
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              // IMAGE SLIDER
              SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  // PAGE VIEW TO SHOW IMAGE SLIDER ON TOP OF THE SCREEN
                  background: Stack(
                    children: [
                      // PAGE VIEW
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _selectedSliderIndex = index;
                          });
                        },
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              // NETWORK IMAGE
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://picsum.photos/500/1000?random=slide_$index",
                              ),
                              // CONTAINER FOR FADE COLOR
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [0.01, 1],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      // INDICATOR
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            // Spread the indicator list
                            ...indicatorContainer,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // SEARCH BUTTON
              MediaQuery.removePadding(
                context: context,
                removeTop:true,
               
                child: SliverAppBar(
                 
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  floating: true,
                  snap: true,
                  title: Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      label: const Text("Search"),
                      icon: const Icon(Icons.search_rounded),
                      style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.black),
                          iconSize: WidgetStatePropertyAll(32),
                          textStyle:
                              WidgetStatePropertyAll(TextStyle(fontSize: 16))),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            color: Colors.white,
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemBuilder: (context, index) {
                return ImageTile(
                  imageSource: 'https://picsum.photos/500/1000?random=img_$index',
                  index: index,
                  extent: (index % 2) == 0 ? 300 : 150,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
