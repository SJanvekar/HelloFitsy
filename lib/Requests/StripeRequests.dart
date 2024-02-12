import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class StripeRequests {
  Dio dio = new Dio();

  //Create Stripe Account
  createStripeAccount() async {
    try {
      return await dio.post('$urlDomain/createStripeAccount',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print("Stripe Account Creation Error: ${e}");
    }
  }

  //Create Stripe Account
  createStripeAccountLink(String? stripeAccountID) async {
    try {
      return await dio.post('$urlDomain/createStripeAccountLink',
          data: {
            "account": stripeAccountID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print("Stripe Account Link Error: ${e}");
    }
  }

  //Retrieve account information
  retrieveStripeAccount(String? stripeAccountID) async {
    try {
      return await dio.get('$urlDomain/retrieveStripeAccountDetails',
          queryParameters: {
            'accountID': stripeAccountID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print("Stripe Account Retrival Error: ${e}");
    }
  }

  //Create payment intent
  newPaymentIntent(
    String? customerID,
    int paymentAmount,
    int fitsyFee,
    String? accountID,
    String userEmail,
  ) async {
    try {
      return await dio.post('$urlDomain/newPaymentIntent',
          data: {
            'customerID': customerID,
            'amount': paymentAmount,
            'fitsyFee': fitsyFee,
            'accountID': accountID,
            "receipt_email": userEmail,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(
        "Stripe Payment Intent Creation Error: ${e}",
      );
    }
  }
}
