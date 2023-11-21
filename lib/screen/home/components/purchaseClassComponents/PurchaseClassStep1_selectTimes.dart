import 'package:balance/Constants.dart';
import 'package:balance/screen/home/components/PurchaseClassSelectDates.dart';
import 'package:balance/sharedWidgets/LoginFooterButton.dart';
import 'package:balance/sharedWidgets/PageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';

class CupertinoBookingDetailsPopup extends StatelessWidget {
  final double storedClassPrice;
  final Function() onBook;
  final Function() onConfirmAndPurchase;
  final bool isStripeDetailsSubmitted;

  const CupertinoBookingDetailsPopup({
    Key? key,
    required this.storedClassPrice,
    required this.onBook,
    required this.onConfirmAndPurchase,
    required this.isStripeDetailsSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: snow,
        height: constraints.maxHeight * 0.4,
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: snow,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 5.0, right: 5.0, bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 10.0),
                    child: Text(
                      'Booking Details',
                      style: sectionTitlesH2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10.0),
                    child: Text(
                      'Selected time',
                      style: bodyTextFontBold60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                    child: Text(
                      Jiffy.parse(currentSelection.toString()).format(
                        pattern: "MMMM d y, h:mm a",
                      ),
                      style: classStartTime,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PageDivider(leftPadding: 10, rightPadding: 10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10.0),
                        child: Text(
                          'Subtotal',
                          style: bodyTextFontBold60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10.0),
                        child: Text(
                          'Taxes',
                          style: bodyTextFontBold60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 10.0),
                        child: Text(
                          'Total',
                          style: sectionTitlesH2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (storedClassPrice < 1)
            Flexible(
              child: BookingDetailsFooterButton(
                constraints: constraints,
                buttonText: 'Book',
                buttonColor: strawberry,
                textColor: snow,
                onTap: onBook,
              ),
            )
          else
            Flexible(
              child: BookingDetailsFooterButton(
                constraints: constraints,
                buttonText: isStripeDetailsSubmitted
                    ? 'Confirm & Purchase'
                    : 'Unavailable',
                buttonColor:
                    isStripeDetailsSubmitted ? strawberry : strawberry40,
                textColor: snow,
                onTap: isStripeDetailsSubmitted ? onConfirmAndPurchase : null,
              ),
            ),
        ]),
      );
    });
  }
}

class BookingDetailsFooterButton extends StatelessWidget {
  final BoxConstraints constraints;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onTap;

  const BookingDetailsFooterButton({
    Key? key,
    required this.constraints,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: bone, width: 1),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 14, bottom: 46, left: 26, right: 26),
        child: GestureDetector(
          onTap: onTap,
          child: FooterButton(
            buttonColor: buttonColor,
            buttonText: buttonText,
            textColor: textColor,
          ),
        ),
      ),
    );
  }
}
