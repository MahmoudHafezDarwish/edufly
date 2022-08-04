
import 'package:edufly/pages/edit_product/provider_models/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/modelsFirebase/Product.dart';
import 'components/body.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/editProductScreen';

  Product? productToEdit ;

   EditProductScreen({Key? key,this.productToEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductDetails(),
      child: Scaffold(
        appBar: AppBar(),
        body: Body(
          // productToEdit: Provider.of<ProductDetails>(context).productToEdit,
          productToEdit: this.productToEdit,
        ),
      ),
    );
  }
}
