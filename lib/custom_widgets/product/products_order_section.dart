import 'package:edufly/models/modelsFirebase/OrderedProduct.dart';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../data/firebase_firestore.dart';
import '../../pages/data_streams/data_stream.dart';
import '../../utile/size_config.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/section_tile.dart';
import 'nothingtoshow_container.dart';

class ProductsOrderSection extends StatelessWidget {
  final String sectionTitle;
  final DataStream productsStreamController;
  final String emptyListMessage;
  final Function onProductCardTapped;

  const ProductsOrderSection({
    Key? key,
    required this.sectionTitle,
    required this.productsStreamController,
    this.emptyListMessage = "No Products to show here",
    required this.onProductCardTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: kPrimaryExtraLightColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SectionTile(
            title: sectionTitle,
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Expanded(
            child: buildProductsList(),
          ),
        ],
      ),
    );
  }

  Widget buildProductsList() {
    return StreamBuilder<List<String>>(
      stream: productsStreamController.stream as Stream<List<String>>,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length == 0) {
            return Center(
              child: NothingToShowContainer(
                secondaryMessage: emptyListMessage,
              ),
            );
          }else {
            print('list of id products ${snapshot.data}');
            var listOfOrderedId = snapshot.data!;
            return buildProductGrid(listOfOrderedId);
          }

        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        return Center(
          child: NothingToShowContainer(
            iconPath: "assets/icons/network_error.svg",
            primaryMessage: "Something went wrong",
            secondaryMessage: "Unable to connect to Database",
          ),
        );
      },
    );
  }

  Widget buildProductGrid(List<String> productsId) {
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 1,
      ),
      itemCount: productsId.length,
      itemBuilder: (context, index) {
        return ProductCard(
          productId: productsId[index],
          press: () {
            onProductCardTapped.call(productsId[index]);
          },
        );
      },
    );
  }
  
  
  // Future<List<String>> getProductsID (List<String> listOfOrderedId) async{
  //   List<String> productsId = [];
  //   for (var order in listOfOrderedId) {
  //     OrderedProduct orderedProduct =
  //     await MyFirebaseFireStore.myFirebaseFireStore.getOrderedProductFromId(order);
  //     print('my Order orderedProducts :${orderedProduct.productUid}+${orderedProduct.orderDate}');
  //     productsId.add(orderedProduct.productUid!);
  //     print('list of history products in for each${productsId.toString()}');
  //
  //     // final myProducts = await MyFirebaseFireStore.myFirebaseFireStore.getProductWithID(orderedProduct.productUid!);
  //   }
  //   print('list of history products ${productsId.toString()}');
  //   return productsId;
  // }
}
