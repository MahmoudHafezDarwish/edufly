import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edufly/data/firebase_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

import 'package:logger/logger.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/widgets/async_progress_dialog.dart';
import '../../../custom_widgets/widgets/default_button.dart';
import '../../../models/modelsFirebase/Product.dart';
import '../../../utile/constants.dart';
import '../../../utile/size_config.dart';
import '../firestore_files_access/firestore_files_access_service.dart';
import '../local_files_access/local_files_access_service.dart';
import '../local_files_handling/image_picking_exceptions.dart';
import '../local_files_handling/local_file_handling_exception.dart';
import '../provider_models/ProductDetails.dart';

class EditProductForm extends StatefulWidget {
  Product? product;

  EditProductForm({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _basicDetailsFormKey = GlobalKey<FormState>();
  final _describeProductFormKey = GlobalKey<FormState>();
  final _tagStateKey = GlobalKey<TagsState>();

  final TextEditingController titleFieldController = TextEditingController();
  final TextEditingController variantFieldController = TextEditingController();
  final TextEditingController discountPriceFieldController =
      TextEditingController();
  final TextEditingController originalPriceFieldController =
      TextEditingController();
  final TextEditingController highlightsFieldController =
      TextEditingController();
  final TextEditingController desciptionFieldController =
      TextEditingController();
  final TextEditingController sellerFieldController = TextEditingController();

  bool newProduct = true;

  String productTypeValue = 'كتب جامعية';
  List<String> productTypeValuesList = [
    'كتب جامعية',
    'المرحلة الثانوية',
    'المرحلة الإعدادية',
    'رياض الأطفال',
  ];

  // late Product product;

  @override
  void dispose() {
    titleFieldController.dispose();
    variantFieldController.dispose();
    discountPriceFieldController.dispose();
    originalPriceFieldController.dispose();
    highlightsFieldController.dispose();
    desciptionFieldController.dispose();
    sellerFieldController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.product == null) {
      widget.product = Product(null);
      newProduct = true;
    } else {
      widget.product = widget.product;
      newProduct = false;
      final productDetails =
          Provider.of<ProductDetails>(context, listen: false);
      productDetails.initialSelectedImages = widget.product!.images!
          .map((e) => CustomImage(imgType: ImageType.network, path: e))
          .toList();
      productDetails.initialProductType = widget.product!.productType!;
      productDetails.initSearchTags = widget.product!.searchTags ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final column = Column(
      children: [
        buildBasicDetailsTile(context),
        SizedBox(height: getProportionateScreenHeight(10)),
        buildDescribeProductTile(context),
        SizedBox(height: getProportionateScreenHeight(10)),
        buildUploadImagesTile(context),
        SizedBox(height: getProportionateScreenHeight(20)),
        buildProductTypeDropdown(),
        SizedBox(height: getProportionateScreenHeight(20)),
        // buildProductSearchTagsTile(),
        SizedBox(height: 30),
        Container(
          height: 56,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              saveProductButtonCallback(context);
            },
            child: Text('Save Product'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontFamily: 'Besley-ExtraBold',
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.white,
              ),
              primary: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        // DefaultButton(
        //     text: "Save Product",
        //     press: () {
        //       saveProductButtonCallback(context);
        //     }),
        SizedBox(height: getProportionateScreenHeight(10)),
      ],
    );
    if (newProduct == false) {
      titleFieldController.text = widget.product!.title!;
      variantFieldController.text = widget.product!.variant!;
      discountPriceFieldController.text =
          widget.product!.discountPrice.toString();
      originalPriceFieldController.text =
          widget.product!.originalPrice.toString();
      highlightsFieldController.text = widget.product!.highlights!;
      desciptionFieldController.text = widget.product!.description!;
      sellerFieldController.text = widget.product!.seller!;
    }
    return column;
  }

  Widget buildProductSearchTags() {
    return Consumer<ProductDetails>(
      builder: (context, productDetails, child) {
        return Tags(
          key: _tagStateKey,
          horizontalScroll: true,
          heightHorizontalScroll: 80,
          textField: TagsTextField(
            lowerCase: true,
            width: 120,
            constraintSuggestion: true,
            hintText: "Add search tag",
            keyboardType: TextInputType.name,
            onSubmitted: (String str) {
              productDetails.addSearchTag(str.toLowerCase());
            },
          ),
          itemCount: productDetails.searchTags != null
              ? productDetails.searchTags.length ?? 0
              : 0,
          itemBuilder: (index) {
            final item = productDetails.searchTags[index] != null
                ? productDetails.searchTags[index]
                : '';
            return ItemTags(
              index: index,
              title: " ",
              active: true,
              activeColor: kPrimaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              alignment: MainAxisAlignment.spaceBetween,
              removeButton: ItemTagsRemoveButton(
                backgroundColor: Colors.white,
                color: kTextColor,
                onRemoved: () {
                  productDetails.removeSearchTag(index: index);
                  return true;
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildBasicDetailsTile(BuildContext context) {
    return Form(
      key: _basicDetailsFormKey,
      child: ExpansionTile(
        maintainState: true,
        title: Text(
          "التفاصيل الأساسية",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: fontFamilayTajawal,
          ),
        ),
        leading: Icon(
          Icons.shop,
        ),
        childrenPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20), horizontal: 10),
        children: [
          buildTitleField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildVariantField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildOriginalPriceField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildDiscountPriceField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildSellerField(),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }

  bool validateBasicDetailsForm() {
    if (_basicDetailsFormKey.currentState!.validate()) {
      _basicDetailsFormKey.currentState!.save();
      widget.product!.title = titleFieldController.text;
      widget.product!.variant = variantFieldController.text;
      widget.product!.originalPrice =
          double.parse(originalPriceFieldController.text);
      widget.product!.discountPrice =
          double.parse(discountPriceFieldController.text);
      widget.product!.seller = sellerFieldController.text;
      return true;
    }
    return false;
  }

  Widget buildDescribeProductTile(BuildContext context) {
    return Form(
      key: _describeProductFormKey,
      child: ExpansionTile(
        maintainState: true,
        title: Text(
          "وصف المنتج",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: fontFamilayTajawal,
          ),
        ),
        leading: Icon(
          Icons.description,
        ),
        childrenPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20), horizontal: 10),
        children: [
          buildHighlightsField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildDescriptionField(),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }

  bool validateDescribeProductForm() {
    if (_describeProductFormKey.currentState!.validate()) {
      _describeProductFormKey.currentState!.save();
      widget.product!.highlights = highlightsFieldController.text;
      widget.product!.description = desciptionFieldController.text;
      return true;
    }
    return false;
  }

  Widget buildProductTypeDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: kTextColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: Consumer<ProductDetails>(
        builder: (context, productDetails, child) {
          return DropdownButton(
            value: productTypeValue,
            items: productTypeValuesList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            // items: ProductType.values
            //     .map(
            //       (e) => DropdownMenuItem(
            //         value: e,
            //         child: Text(
            //           EnumToString.convertToString(e),
            //         ),
            //       ),
            //     )
            //     .toList(),
            hint: Text(
              "Chose Product Type",
            ),
            style: TextStyle(
              color: kTextColor,
              fontSize: 16,
            ),
            onChanged: (value) {
              productDetails.productType = value as String;
              setState(() {
                productTypeValue = value as String;
              });
            },
            elevation: 0,
            underline: SizedBox(width: 0, height: 0),
          );
        },
      ),
    );
  }

  Widget buildProductSearchTagsTile() {
    return ExpansionTile(
      title: Text(
        "كلمات مفتاحية للبحث",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: fontFamilayTajawal,
          color: Colors.black,
        ),
      ),
      leading: Icon(Icons.check_circle_sharp),
      childrenPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(20), horizontal: 20),
      children: [
        Text(
          "سيتم البحث عن منتجك عن طريق هذه الكلمات",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            fontFamily: fontFamilayTajawal,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
        buildProductSearchTags(),
      ],
    );
  }

  Widget buildUploadImagesTile(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Upload Images",
        style: Theme.of(context).textTheme.headline6,
      ),
      leading: Icon(Icons.image),
      childrenPadding:
          EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
              ),
              color: kTextColor,
              onPressed: () {
                addImageButtonCallback(index: 0);
              }),
        ),
        Consumer<ProductDetails>(
          builder: (context, productDetails, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  productDetails.selectedImages.length,
                  (index) => SizedBox(
                    width: 80,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          addImageButtonCallback(index: index);
                        },
                        child: productDetails.selectedImages[index].imgType ==
                                ImageType.local
                            ? Image.memory(
                                File(productDetails.selectedImages[index].path)
                                    .readAsBytesSync())
                            : Image.network(
                                productDetails.selectedImages[index].path),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget buildTitleField() {
    return TextFormField(
      controller: titleFieldController,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: fontFamilayTajawal,
        color: kPrimaryColor,
      ),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontFamily: fontFamilayTajawal,
          color: Colors.black.withOpacity(0.5),
        ),
        fillColor: kPrimaryColor,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontFamily: fontFamilayTajawal,
          color: kPrimaryColor,
        ),
        focusColor: kPrimaryColor,
        hintText: "مثل : منهج الصف الرابع الابتدائي الفصل الأول",
        labelText: "عنوان المنتج",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (titleFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildVariantField() {
    return TextFormField(
      controller: variantFieldController,
      keyboardType: TextInputType.name,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: fontFamilayTajawal,
        color: kPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText: "مثل : الصف الرابع",
        labelText: "التصنيف",
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          fontFamily: fontFamilayTajawal,
          color: Colors.black.withOpacity(0.5),
        ),
        fillColor: kPrimaryColor,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontFamily: fontFamilayTajawal,
          color: kPrimaryColor,
        ),
        focusColor: kPrimaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (variantFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildHighlightsField() {
    return TextFormField(
      controller: highlightsFieldController,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: fontFamilayTajawal,
        color: kPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText:
            "مثل: جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول..الخ",
        labelText: "مميزات",
        labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            fontFamily: fontFamilayTajawal,
            color: Colors.black.withOpacity(0.5),
            overflow: TextOverflow.fade),
        fillColor: kPrimaryColor,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontFamily: fontFamilayTajawal,
          color: kPrimaryColor,
        ),
        focusColor: kPrimaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (highlightsFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: null,
    );
  }

  Widget buildDescriptionField() {
    return TextFormField(
      controller: desciptionFieldController,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: fontFamilayTajawal,
        color: kPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText: "بوربوينت مميز وبشرح سلس ومبسط لكل درس بالمنهج.",
        labelText: "وصف المحتوى",
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          fontFamily: fontFamilayTajawal,
          color: Colors.black.withOpacity(0.5),
        ),
        fillColor: kPrimaryColor,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontFamily: fontFamilayTajawal,
          color: kPrimaryColor,
        ),
        focusColor: kPrimaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (desciptionFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: null,
    );
  }

  Widget buildSellerField() {
    return TextFormField(
      controller: sellerFieldController,
      keyboardType: TextInputType.name,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: fontFamilayTajawal,
        color: kPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText: "مثل : محمد محمود",
        labelText: "البائع",
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          fontFamily: fontFamilayTajawal,
          color: Colors.black.withOpacity(0.5),
        ),
        fillColor: kPrimaryColor,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontFamily: fontFamilayTajawal,
          color: kPrimaryColor,
        ),
        focusColor: kPrimaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (sellerFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildOriginalPriceField() {
    return TextFormField(
      controller: originalPriceFieldController,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: fontFamilayTajawal,
        color: kPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText: " مثل : 5999.0",
        labelText: "السعر الأصلي (بالريال السعودي)",
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          fontFamily: fontFamilayTajawal,
          color: Colors.black.withOpacity(0.5),
        ),
        fillColor: kPrimaryColor,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontFamily: fontFamilayTajawal,
          color: kPrimaryColor,
        ),
        focusColor: kPrimaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (originalPriceFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildDiscountPriceField() {
    return TextFormField(
      controller: discountPriceFieldController,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: fontFamilayTajawal,
        color: kPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText: "مثل : 5000.0",
        labelText: "سعر التخفيض (بالريال السعودي)",
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          fontFamily: fontFamilayTajawal,
          color: Colors.black.withOpacity(0.5),
        ),
        fillColor: kPrimaryColor,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontFamily: fontFamilayTajawal,
          color: kPrimaryColor,
        ),
        focusColor: kPrimaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (discountPriceFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> saveProductButtonCallback(BuildContext context) async {
    if (validateBasicDetailsForm() == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erros in Basic Details Form"),
        ),
      );
      return;
    }
    if (validateDescribeProductForm() == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Errors in Describe Product Form"),
        ),
      );
      return;
    }
    final productDetails = Provider.of<ProductDetails>(context, listen: false);
    if (productDetails.selectedImages.length < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Upload atleast One Image of Product"),
        ),
      );
      return;
    }
    if (productDetails.productType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select Product Type"),
        ),
      );
      return;
    }
    if (productDetails.searchTags.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Add atleast 3 search tags"),
        ),
      );
      return;
    }
    String productId = '';
    String snackbarMessage = '';
    try {
      widget.product!.productType = productDetails.productType;
      widget.product!.searchTags = productDetails.searchTags;
      final productUploadFuture = newProduct
          ? MyFirebaseFireStore.myFirebaseFireStore
              .addUsersProduct(widget.product!)
          : MyFirebaseFireStore.myFirebaseFireStore
              .updateUsersProduct(widget.product!);
      productUploadFuture.then((value) {
        productId = value;
      });
      await showDialog(
        context: context,
        builder: (context) {
          return AsyncProgressDialog(
            productUploadFuture,
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(15),
            ),
            onError: () {},
            progress: CircularProgressIndicator(),
            message:
                Text(newProduct ? "Uploading Product" : "Updating Product"),
          );
        },
      );
      if (productId != null) {
        snackbarMessage = "Product Info updated successfully";
      } else {
        throw "Couldn't update product info due to some unknown issue";
      }
    } on FirebaseException catch (e) {
      Logger().w("Firebase Exception: $e");
      snackbarMessage = "Something went wrong";
    } catch (e) {
      Logger().w("Unknown Exception: $e");
      snackbarMessage = e.toString();
    } finally {
      Logger().i(snackbarMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackbarMessage),
        ),
      );
    }
    if (productId == null) return;
    bool allImagesUploaded = false;
    try {
      allImagesUploaded = await uploadProductImages(productId);
      if (allImagesUploaded == true) {
        snackbarMessage = "All images uploaded successfully";
      } else {
        throw "Some images couldn't be uploaded, please try again";
      }
    } on FirebaseException catch (e) {
      Logger().w("Firebase Exception: $e");
      snackbarMessage = "Something went wrong";
    } catch (e) {
      Logger().w("Unknown Exception: $e");
      snackbarMessage = "Something went wrong";
    } finally {
      Logger().i(snackbarMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackbarMessage),
        ),
      );
    }
    List<String> downloadUrls = productDetails.selectedImages
        .map((e) => e.imgType == ImageType.network ? e.path : null)
        .toList() as List<String>;
    bool productFinalizeUpdate = false;
    try {
      final updateProductFuture = MyFirebaseFireStore.myFirebaseFireStore
          .updateProductsImages(
              productId, downloadUrls != null ? downloadUrls : <String>[]);
      productFinalizeUpdate = await showDialog(
        context: context,
        builder: (context) {
          return AsyncProgressDialog(
            updateProductFuture,
            message: Text("Saving Product"),
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(15),
            ),
            onError: () {},
            progress: CircularProgressIndicator(),
          );
        },
      );
      if (productFinalizeUpdate == true) {
        snackbarMessage = "Product uploaded successfully";
      } else {
        throw "Couldn't upload product properly, please retry";
      }
    } on FirebaseException catch (e) {
      Logger().w("Firebase Exception: $e");
      snackbarMessage = "Something went wrong";
    } catch (e) {
      Logger().w("Unknown Exception: $e");
      snackbarMessage = e.toString();
    } finally {
      Logger().i(snackbarMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackbarMessage),
        ),
      );
    }
    Navigator.pop(context);
  }

  Future<bool> uploadProductImages(String productId) async {
    bool allImagesUpdated = true;
    final productDetails = Provider.of<ProductDetails>(context, listen: false);
    for (int i = 0; i < productDetails.selectedImages.length; i++) {
      if (productDetails.selectedImages[i].imgType == ImageType.local) {
        print("Image being uploaded: " + productDetails.selectedImages[i].path);
        String downloadUrl = '';
        try {
          final imgUploadFuture = FirestoreFilesAccess().uploadFileToPath(
              File(productDetails.selectedImages[i].path),
              MyFirebaseFireStore.myFirebaseFireStore
                  .getPathForProductImage(productId, i));
          downloadUrl = await showDialog(
            context: context,
            builder: (context) {
              return AsyncProgressDialog(
                imgUploadFuture,
                message: Text(
                    "Uploading Images ${i + 1}/${productDetails.selectedImages.length}"),
                onError: () {},
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                progress: CircularProgressIndicator(),
              );
            },
          );
        } on FirebaseException catch (e) {
          Logger().w("Firebase Exception: $e");
        } catch (e) {
          Logger().w("Firebase Exception: $e");
        } finally {
          if (downloadUrl != null) {
            productDetails.selectedImages[i] =
                CustomImage(imgType: ImageType.network, path: downloadUrl);
          } else {
            allImagesUpdated = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text("Couldn't upload image ${i + 1} due to some issue"),
              ),
            );
          }
        }
      }
    }
    return allImagesUpdated;
  }

  Future<void> addImageButtonCallback({required int index}) async {
    final productDetails = Provider.of<ProductDetails>(context, listen: false);
    if (index == null && productDetails.selectedImages.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Max 3 images can be uploaded")));
      return;
    }
    String path = '';
    String snackbarMessage = '';
    try {
      path = await choseImageFromLocalFiles(context);
      if (path == null) {
        throw LocalImagePickingUnknownReasonFailureException();
      }
    } on LocalFileHandlingException catch (e) {
      Logger().i("Local File Handling Exception: $e");
      snackbarMessage = e.toString();
    } catch (e) {
      Logger().i("Unknown Exception: $e");
      snackbarMessage = e.toString();
    } finally {
      if (snackbarMessage != null) {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
    }
    if (path == null) {
      return;
    }
    if (index == null) {
      productDetails.addNewSelectedImage(
          CustomImage(imgType: ImageType.local, path: path));
    } else {
      productDetails.setSelectedImageAtIndex(
          CustomImage(imgType: ImageType.local, path: path), index);
    }
  }
}
