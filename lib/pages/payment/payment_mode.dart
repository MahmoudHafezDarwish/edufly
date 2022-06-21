import 'package:flutter/material.dart';

import '../../custom_widgets/widgets/payment_input_widget.dart';
import '../../custom_widgets/widgets/payment_mode_widget.dart';
import '../../utile/constants.dart';

class PaymentMode extends StatefulWidget {
  const PaymentMode({Key? key}) : super(key: key);

  @override
  _PaymentModeState createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'طريقة الدفع',
          style: TextStyle(
            fontFamily:  "Besley-Regular",
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Column(
        children: [
          PaymentCardWidget(),
          PaymentInput(),
        ],
      ),
    );
  }
}
