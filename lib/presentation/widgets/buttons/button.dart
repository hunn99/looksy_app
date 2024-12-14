import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class LargeFillButton extends StatelessWidget {
  final String label;
  final double? width;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;

  const LargeFillButton({
    super.key,
    required this.label,
    this.width,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled || isLoading ? null : onPressed,
      child: Container(
        height: 48,
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: (isDisabled || isLoading) ? neutralTheme[300] : neutralTheme,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : Text(
                  label,
                  style: bodyBlack1.copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}

class LargeOutlineButton extends StatelessWidget {
  final String label;
  final double? width;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;

  const LargeOutlineButton({
    super.key,
    required this.label,
    this.width,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled || isLoading ? null : onPressed,
      child: Container(
        height: 48,
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color:
                (isDisabled || isLoading) ? neutralTheme[300]! : neutralTheme,
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : Text(
                  label,
                  style: bodyBlack1,
                ),
        ),
      ),
    );
  }
}

class LargeFillButtonWhite extends StatelessWidget {
  final String label;
  final double? width;
  final VoidCallback onPressed;
  final bool? isDisabled;

  const LargeFillButtonWhite(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled != true ? onPressed : null,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isDisabled != true ? Colors.white : neutralTheme[300],
        ),
        child: Center(
          child: Text(
            label,
            style: bodyBlack1.copyWith(color: neutralTheme),
          ),
        ),
      ),
    );
  }
}

class SmallFillButton extends StatelessWidget {
  final String label;
  final double? width;
  final VoidCallback onPressed;
  final bool? isDisabled;

  const SmallFillButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled != true ? onPressed : null,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isDisabled != true ? neutralTheme : neutralTheme[300],
        ),
        child: Center(
          child: Text(
            label,
            style: bodyBlack1.copyWith(color: neutralTheme),
          ),
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  final String label;
  final double? width;
  final VoidCallback onPressed;
  final bool? isDisabled;

  const CancelButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled != true ? onPressed : null,
      child: Container(
        // height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
              color: isDisabled != true ? redTheme[600]! : neutralTheme[300]!),
        ),
        child: Center(
          child: Text(
            label,
            style: bodyBlack1.copyWith(
                color: isDisabled != true ? redTheme[600] : neutralTheme[300]),
          ),
        ),
      ),
    );
  }
}
