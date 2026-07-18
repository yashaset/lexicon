import 'package:flutter/material.dart';

import '../../../shared/widgets/primary_button.dart';

class NewEntryButton extends StatelessWidget {
  const NewEntryButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: 'New Entry',
      icon: Icons.add,
      onPressed: onPressed,
    );
  }
}