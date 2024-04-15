import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';

class NextButton extends ConsumerWidget {
  final Widget? nextScreen;
  final String buttonName;
  final Widget? buttonIcon;
  final List<StateProvider>? isSelectedProvider;
  final List<Function>? validators;
  bool? checkSelected;
  bool isLoading;
  bool isReplacement;
  NextButton(
      {super.key,
      this.nextScreen,
      this.validators,
      required this.buttonName,
      this.isReplacement = false,
      this.isSelectedProvider,
      this.buttonIcon,
      this.checkSelected,
      this.isLoading = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(isSelectedProvider == null);
    bool isSelected = isSelectedProvider == null
        ? (checkSelected == null ? true : checkSelected!)
        : isSelectedProvider!.every((provider) =>
            (ref.watch(provider) != "" && ref.watch(provider) != null));

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: PRIMARY_COLOR_ORANGE_02,
            ),
          )
        : InkWell(
            onTap: () {
              isSelected
                  ? {
                      validators != null
                          ? {
                              validators!.forEach((function) async {
                                await function();
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
                                  : Navigator.of(context).push(
                                      (MaterialPageRoute(
                                          builder: (_) => nextScreen!))),
                    }
                  : {};
            },
            child: Container(
              // width: 296,
              height: 48,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected
                          ? PRIMARY_COLOR_ORANGE_02
                          : GRAYSCALE_GRAY_02),
                  borderRadius: BorderRadius.circular(10.0),
                  color:
                      isSelected ? PRIMARY_COLOR_ORANGE_02 : GRAYSCALE_GRAY_02),
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
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
