import 'package:flutter/material.dart';

enum AppButtonStyle { filled, outlined, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonStyle style;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.style = AppButtonStyle.filled,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return switch (style) {
      AppButtonStyle.filled => _buildFilledButton(context),
      AppButtonStyle.outlined => _buildOutlinedButton(context),
      AppButtonStyle.text => _buildTextButton(context),
    };
  }

  Widget _buildFilledButton(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: _buildContent(context, Theme.of(context).colorScheme.onPrimary),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: _buildContent(context, Theme.of(context).colorScheme.primary),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: _buildContent(context, Theme.of(context).colorScheme.primary),
    );
  }

  Widget _buildContent(BuildContext context, Color color) {
    if (isLoading) {
      return SizedBox(
        height: 24.0,
        width: 24.0,
        child: CircularProgressIndicator(color: color),
      );
    }

    final textWidget = Text(text);

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8.0),
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}
