// ignore_for_file: unused_import

import 'dart:developer';

import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum WeightType {
  kg,
  lb,
}

extension WeightTypeExtension on WeightType {
  String get name {
    switch (this) {
      case WeightType.kg:
        return 'Kg';
      case WeightType.lb:
        return 'Lb';
    }
  }
}

class WeightSlider extends StatefulWidget {
  final double from;
  final double max;
  final double initialValue;
  final Function(double) onChanged;
  final WeightType type;

  const WeightSlider({
    required this.from,
    required this.max,
    required this.initialValue,
    required this.onChanged,
    required this.type,
    super.key,
  });

  @override
  State<WeightSlider> createState() => _WeightSliderState();
}

class _WeightSliderState extends State<WeightSlider> {
  PageController? numbersController;
  final itemsExtension = 1000;
  late double value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  void _updateValue() {
    value = ((((numbersController?.page ?? 0) - itemsExtension) * 10)
        .roundToDouble() /
        10)
        .clamp(widget.from, widget.max);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.initialValue >= widget.from &&
        widget.initialValue <= widget.max);
    return Column(
      children: [
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final viewPortFraction = 1 / (constraints.maxWidth / 10);
            numbersController = PageController(
              initialPage: itemsExtension + widget.initialValue.toInt(),
              viewportFraction: viewPortFraction * 10,
            );
            numbersController?.addListener(_updateValue);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                _Numbers(
                  itemsExtension: itemsExtension,
                  controller: numbersController,
                  start: widget.from.toInt(),
                  end: widget.max.toInt(),
                  updatedValue: value,
                ),
              ]
            );
          },
        ),
        const SizedBox(height: 10),
        SvgPicture.asset(BaseAssets.indicator),
        // SizedBox(
        //   height: 10,
        //   width: 11.5,
        //   child: CustomPaint(
        //     painter: TrianglePainter(),
        //   ),
        // ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BaseText(
              value: '${value.toInt()}',
              fontSize: 64,
              fontWeight: FontWeight.w700,
            ),
            Column(
              children: [
                BaseText(
                  value: widget.type.name,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: BaseColors.grey2,
                ),
                buildSizeHeight(20),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    numbersController?.removeListener(_updateValue);
    numbersController?.dispose();
    super.dispose();
  }
}

class _Numbers extends StatelessWidget {
  final PageController? controller;
  final int itemsExtension;
  final int start;
  final int end;
  final double updatedValue;

  const _Numbers({
    required this.controller,
    required this.itemsExtension,
    required this.start,
    required this.end,
    required this.updatedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
alignment: Alignment.center,
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            pageSnapping: false,
            controller: controller,
            physics: _CustomPageScrollPhysics(
              start: itemsExtension + start.toDouble(),
              end: itemsExtension + end.toDouble(),
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, rawIndex) {
              final index = rawIndex - itemsExtension;
              return Column(
                children: [
                  if(index >= start && index <= end)
                  Center(
                    child: BaseText(
                      value: '$index',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: updatedValue.toInt() == index ? BaseColors.black1: BaseColors.grey2.withOpacity(0.2),
                    ),
                  ),
                  if(index >= start && index <= end)
                    const _Dividers(),
                ],
              );
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height < 760 ? 55 : 66,
          child: Container(
            width: 2.5,
            height: 62,
            decoration: BoxDecoration(
              color: BaseColors.yellowGreen,
              borderRadius: BorderRadius.circular(2)
            ),
          ),
        ),
      ],
    );
  }
}

class _Dividers extends StatelessWidget {
  const _Dividers();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColors.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(10, (index) {
          double thickness = index == 5 ? 3 : 2;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 1.5),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: thickness == 2 ? 5.0 : 0.0),
                    child: Transform.translate(
                      offset: Offset(-thickness / 1, 0),
                      child: const VerticalDivider(
                        thickness: 2,
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _CustomPageScrollPhysics extends ScrollPhysics {
  final double start;
  final double end;

  const _CustomPageScrollPhysics({
    required this.start,
    required this.end,
    super.parent,
  });

  @override
  _CustomPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _CustomPageScrollPhysics(
      parent: buildParent(ancestor),
      start: start,
      end: end,
    );
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position,
      double velocity,
      ) {
    final oldPosition = position.pixels;
    final frictionSimulation =
    FrictionSimulation(0.4, position.pixels, velocity * 0.2);

    double newPosition = (frictionSimulation.finalX / 10).round() * 10;

    final endPosition = end * 10 * 10;
    final startPosition = start * 10 * 10;
    if (newPosition > endPosition) {
      newPosition = endPosition;
    } else if (newPosition < startPosition) {
      newPosition = startPosition;
    }
    if (oldPosition == newPosition) {
      return null;
    }
    return ScrollSpringSimulation(
      spring,
      position.pixels,
      newPosition.toDouble(),
      velocity,
      tolerance: tolerance,
    );
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 20,
    stiffness: 100,
    damping: 0.8,
  );
}