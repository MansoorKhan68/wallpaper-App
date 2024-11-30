import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CollectionTile extends StatelessWidget {
  final int index;
  final double extent;
  const CollectionTile({super.key, required this.index, required this.extent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      height: extent,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 8,
                      spreadRadius: -6,
                      offset: Offset(0, 10)
                    )
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://picsum.photos/500/500?random=image_1$index')),
          ),
          Positioned(
            bottom: 15,
            left: 10,
            right: 10,
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://picsum.photos/500/500?random=image_2$index')),
          ),
          Positioned.fill(
            bottom: 30,
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://picsum.photos/500/500?random=image_3$index')),
          ),
          Positioned(
            bottom: 40,
            right: 5,
            child: Icon(Icons.star,color: Colors.white,))
        ],
      ),
    );
  }
}
