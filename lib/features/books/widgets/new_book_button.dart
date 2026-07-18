import 'package:flutter/material.dart';

import '../../../shared/widgets/primary_button.dart';

class NewBookButton extends StatelessWidget {
  const NewBookButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: 'New Book',
      icon: Icons.add,
      onPressed: onPressed,
    );
  }
}