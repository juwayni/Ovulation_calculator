import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import 'app_button.dart';

class MedicalDisclaimerModal extends StatelessWidget {
  final VoidCallback onAccept;
  const MedicalDisclaimerModal({super.key, required this.onAccept});

  static void show(BuildContext context, {required VoidCallback onAccept}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => MedicalDisclaimerModal(onAccept: onAccept),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Icon(Icons.info_outline, color: Colors.blue, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Medical Disclaimer',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'This app provides estimates based on typical cycle data and is not a medical diagnostic tool. Results should not be used for birth control or as a substitute for professional medical advice.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          AppButton(
            text: 'I Understand',
            onPressed: () {
              onAccept();
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
