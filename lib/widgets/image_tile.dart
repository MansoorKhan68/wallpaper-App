import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final double extent;
  final String imageSource;
  final int index;
  const ImageTile(
      {super.key,
      required this.imageSource,
      required this.index,
      required this.extent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
                showImageDetails(context, imageSource);
              },
      child: Container(
        height: extent,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(fit: StackFit.expand, children: [
          // Image.network(fit: BoxFit.cover, imageSource),
          CachedNetworkImage(fit: BoxFit.cover, imageUrl: imageSource),
          // POSITIONED ROW ON EACH IMAGE
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(.6),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Art $index",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () {
                          // change icon t filled heart
                          // manage state
                        },
                        icon: const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ]),
      ),
    );
  }
  // IMAGE SOURCE FUNCTION

  void showImageDetails(BuildContext context, String imageSource) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.9,
              child: Column(
                children: [
                  // IMAGE PREVIEW
                  CachedNetworkImage(
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: imageSource),
                  const SizedBox(
                    height: 15,
                  ),
                  //  TITLE TEXT
                  const Text(
                    "Image Title",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // DOWNLOAD BUTTON
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.black,
                    onPressed: () {},
                    child: const Text(
                      "Get Wallpaper",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 2),
                    ),
                  ),
                  // AUTHOR DETAILS
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            
                            width: 50,
                                height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              // borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                // THUMB NAIL IMAGE
                                  width: 50,
                                  height: 50,
                                  imageUrl: 'https://picsum.photos/50/50'),
                            ),
                          ),
                          // VERIFEID BADGE
                          Icon(Icons.check,color: Colors.blue,)
                        ],
                      ),
                      const SizedBox(width: 10,),
                      // author Name
                      const Text(
                      "Samuel Elkins",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 2),
                    ),


                    ],
                  )
                ],
              ));
        });
  }
}
