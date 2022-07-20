import 'dart:math' as _math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'circle_view.dart';

class JoystickView extends StatelessWidget {
  final double size;
  final Color iconsColor;
  final double opacity;
  final bool showArrows;

  JoystickView(
      {required this.size,
      this.iconsColor = Colors.white,
      required this.opacity,
      this.showArrows = true});

  @override
  Widget build(BuildContext context) {
    double actualSize = size != null
        ? size
        : _math.min(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height) *
            0.5;
    double innerCircleSize = actualSize / 2;
    Offset lastPosition = Offset(innerCircleSize, innerCircleSize);
    Offset joystickInnerPosition = _calculatePositionOfInnerCircle(
        lastPosition, innerCircleSize, actualSize, Offset(0, 0));

    DateTime? _callbackTimestamp;

    return Center(
      child: StatefulBuilder(
        builder: (context, setState) {
          Widget joystick = Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(25),
                  child: CircleView.joystickCircle(
                    actualSize,
                  )),
              Positioned(
                child: Draggable<CircleView>(
                  child: CircleView.joystickInnerCircle(
                    actualSize / 2,
                  ),
                  feedback: CircleView.joystickInnerCircle(
                    actualSize / 2,
                  ),
                  childWhenDragging: CircleView.joystickInnerchildCircle(
                    actualSize / 2,
                  ),
                ),
                top: joystickInnerPosition.dy + 25,
                left: joystickInnerPosition.dx + 25,
              ),
              if (showArrows) ...createArrows(),
            ],
          );

          return GestureDetector(
            onPanStart: (details) {},
            onPanEnd: (details) {
              joystickInnerPosition = _calculatePositionOfInnerCircle(
                  Offset(innerCircleSize, innerCircleSize),
                  innerCircleSize,
                  actualSize,
                  Offset(0, 0));
            },
            onPanUpdate: (details) {
              joystickInnerPosition = _calculatePositionOfInnerCircle(
                  lastPosition,
                  innerCircleSize,
                  actualSize,
                  details.localPosition);
            },
            child: (opacity != null)
                ? Opacity(opacity: opacity, child: joystick)
                : joystick,
          );
        },
      ),
    );
  }

  List<Widget> createArrows() {
    return [
      Positioned(
        child: Icon(
          Icons.arrow_drop_up,
          color: iconsColor,
          size: 40,
        ),
        top: -16.0,
        left: 0.0,
        right: 0.0,
      ),
      Positioned(
        child: Icon(
          Icons.arrow_left,
          color: iconsColor,
          size: 40,
        ),
        top: 0.0,
        bottom: 0.0,
        left: -16.0,
      ),
      Positioned(
        child: Icon(
          Icons.arrow_right,
          color: iconsColor,
          size: 40,
        ),
        top: 0.0,
        bottom: 0.0,
        right: -16.0,
      ),
      Positioned(
        child: Icon(
          Icons.arrow_drop_down,
          color: iconsColor,
          size: 40,
        ),
        bottom: -16.0,
        left: 0.0,
        right: 0.0,
      ),
    ];
  }

  Offset _calculatePositionOfInnerCircle(
      Offset lastPosition, double innerCircleSize, double size, Offset offset) {
    double middle = size + 25 / 2.0;

    double angle = _math.atan2(offset.dy - middle, offset.dx - middle);
    double degrees = angle * 180 / _math.pi;
    if (offset.dx < middle && offset.dy < middle) {
      degrees = 360 + degrees;
    }
    bool isStartPosition = lastPosition.dx == innerCircleSize &&
        lastPosition.dy == innerCircleSize;
    double lastAngleRadians =
        (isStartPosition) ? 0 : (degrees) * (_math.pi / 180.0);

    var rBig = size / 2;
    var rSmall = innerCircleSize / 2;

    var x = (lastAngleRadians == -1)
        ? rBig - rSmall
        : (rBig - rSmall) + (rBig - rSmall) * _math.cos(lastAngleRadians);
    var y = (lastAngleRadians == -1)
        ? rBig - rSmall
        : (rBig - rSmall) + (rBig - rSmall) * _math.sin(lastAngleRadians);

    var xPosition = lastPosition.dx - rSmall;
    var yPosition = lastPosition.dy - rSmall;

    var angleRadianPlus = lastAngleRadians + _math.pi / 2;
    if (angleRadianPlus < _math.pi / 2) {
      if (xPosition > x) {
        xPosition = x;
      }
      if (yPosition < y) {
        yPosition = y;
      }
    } else if (angleRadianPlus < _math.pi) {
      if (xPosition > x) {
        xPosition = x;
      }
      if (yPosition > y) {
        yPosition = y;
      }
    } else if (angleRadianPlus < 3 * _math.pi / 2) {
      if (xPosition < x) {
        xPosition = x;
      }
      if (yPosition > y) {
        yPosition = y;
      }
    } else {
      if (xPosition < x) {
        xPosition = x;
      }
      if (yPosition < y) {
        yPosition = y;
      }
    }
    return Offset(xPosition, yPosition);
  }
}
