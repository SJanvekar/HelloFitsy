import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatelessWidget {
  Future<void> processPayment() async {
    // final paymentMethod =
    //     await Stripe.instance.paymentField.createPaymentMethod();
    // Handle the successful payment method creation.
    // You can now send the payment method to your server for further processing.
  }

  void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Make a Payment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              CardField(),
              SizedBox(height: 16),
              TextButton(
                onPressed: processPayment,
                child: Text('Pay'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stripe Payment Example'),
        ),
        body: Center(
            child: TextButton(
          onPressed: () => _showPaymentSheet(context),
          child: Text('Open Payment Sheet'),
        )));
  }
}
