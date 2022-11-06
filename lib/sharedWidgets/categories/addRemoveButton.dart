import 'package:balance/sharedWidgets/categories/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class AddRemoveButton extends StatefulWidget {
  bool isAdd;
  AddRemoveButton({
    Key? key,
    required this.isAdd,
  }) : super(key: key);

  @override
  State<AddRemoveButton> createState() => _addRemoveButton();
}

var startColour = ocean;

class _addRemoveButton extends State<AddRemoveButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    upperBound: 0.125,
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 110.0, top: 10),
          child: ClipOval(
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: snow,
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(left: 114.0, top: 13),
            child: ClipOval(
              child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: startColour,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RotationTransition(
                      turns: Tween(begin: 0.00, end: 1.0).animate(_animation),
                      child: SvgPicture.asset(
                        'assets/icons/generalIcons/exit.svg',
                      ),
                    ),
                  )),
            ),
          ),
          onTap: () {
            setState(() {
              if (widget.isAdd == true) {
                _controller.forward(from: 0.0);
                print(widget.isAdd);

                startColour = strawberry;
              } else {
                _controller.reverse(from: 1.0);
                startColour = ocean;
                print(widget.isAdd);
              }
            });
          },
        ),
      ],
    );
  }
}
