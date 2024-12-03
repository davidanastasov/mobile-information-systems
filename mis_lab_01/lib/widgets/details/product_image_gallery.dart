import 'package:flutter/material.dart';

class ProductImageGallery extends StatefulWidget {
  final List<String> images;

  const ProductImageGallery({super.key, required this.images});

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  String? selectedImage;

  @override
  void initState() {
    super.initState();
    selectFirstImage();
  }

  void selectFirstImage() async {
    selectedImage = widget.images.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            color: Colors.white,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(selectedImage!, loadingBuilder:
                  (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }, fit: BoxFit.contain, alignment: Alignment.center),
            )),
        const Divider(),
        SizedBox(
          height: 75,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              final image = widget.images[index];
              return Container(
                color: Colors.white,
                width: 75,
                height: 75,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedImage = image;
                    });
                  },
                  child: Image.network(
                    image,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator());
                    },
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(width: 20), // Add spacing here
          ),
        )
      ],
    );
  }
}
