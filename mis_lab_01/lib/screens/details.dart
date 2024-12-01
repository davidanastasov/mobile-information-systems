import 'package:flutter/material.dart';
import 'package:mis_lab_01/models/product_model.dart';
import 'package:mis_lab_01/services/api_service.dart';
import 'package:mis_lab_01/widgets/common/app_bar.dart';
import 'package:mis_lab_01/widgets/details/product_actions.dart';
import 'package:mis_lab_01/widgets/details/product_image_gallery.dart';
import 'package:mis_lab_01/widgets/details/product_information.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Product? product;
  String id = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Product;
    id = arguments.id.toString();
    if (id.isNotEmpty) {
      getDetails(id);
    }
  }

  void getDetails(String id) async {
    ApiService.getProductDetailsFromAPI(id).then((response) {
      setState(() {
        product = Product.fromJson(response);
      });
    }).catchError((error) {
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = product == null;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageGallery(images: product!.images ?? []),
                  const SizedBox(height: 10),
                  ProductInformation(
                    title: product!.title,
                    price: product!.price,
                    description: product!.description,
                  ),
                  const SizedBox(height: 20),
                  const ProductActions()
                ],
              ),
            ),
    );
  }
}
