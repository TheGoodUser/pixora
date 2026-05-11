import 'package:flutter/material.dart';
import 'package:pixora/controllers/controllers.dart';

class ImageUploadDialog extends StatelessWidget {
  final ImageUploadController controller;
  const ImageUploadDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: controller.loading
                      ? Colors.blue.shade50
                      : Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: controller.loading
                      ? const CircularProgressIndicator(
                          color: Colors.blueAccent,
                          strokeWidth: 3,
                        )
                      : const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                          size: 36,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                controller.loading ? "Uploading..." : "Upload Complete",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                controller.loading
                    ? "Please wait while we process your image"
                    : "Your image has been uploaded successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
