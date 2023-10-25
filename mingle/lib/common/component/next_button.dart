import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';

class NextButton extends ConsumerWidget {
  final Widget? nextScreen;
  final String buttonName;
  final Widget? buttonIcon;
  final List<StateProvider<String>>? isSelectedProvider;
  final List<Function>? validators;
  bool isReplacement;
  NextButton({
    super.key,
    this.nextScreen,
    this.validators,
    required this.buttonName,
    this.isReplacement = false,
    this.isSelectedProvider,
    this.buttonIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = isSelectedProvider == null
        ? true
        : isSelectedProvider!.every((provider) => ref.watch(provider) != "");

    return InkWell(
      onTap: () {
        isSelected
            ? {
                validators != null
                    ? {
                        validators!.forEach((function) {
                          function();
                        })
                      }
                    : nextScreen == null
                        ? Navigator.of(context).pop()
                        : isReplacement
                            ? {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst),
                                Navigator.of(context).pushReplacement(
                                    (MaterialPageRoute(
                                        builder: (_) => nextScreen!)))
                              }
                            : Navigator.of(context).push((MaterialPageRoute(
                                builder: (_) => nextScreen!))),
              }
            : {};
      },
      child: Container(
        // width: 296,
        height: 48,
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    isSelected ? PRIMARY_COLOR_ORANGE_02 : GRAYSCALE_GRAY_02),
            borderRadius: BorderRadius.circular(20.0),
            color: isSelected ? PRIMARY_COLOR_ORANGE_02 : GRAYSCALE_GRAY_02),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: buttonIcon != null
                    ? const EdgeInsets.only(right: 6.0)
                    : const EdgeInsets.all(0.0),
                child: buttonIcon != null ? buttonIcon! : Container(),
              ),
              Text(
                buttonName,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
