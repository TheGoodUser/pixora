import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixora/controllers/controllers.dart';
import 'package:pixora/views/widgets/image_upload_dialog.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  /// [upload] manages the file upload and the retries
  Future<void> upload(BuildContext context,
      ImageUploadController uploadController, File image) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ImageUploadDialog(
            controller: uploadController,
          );
        });

    final uploaded = await uploadController.uploadImage(image: image);

    if (uploaded && context.mounted) {
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            onPressed: () {
              context.read<ScreenController>().setPage(1);
            },
            label: 'History',
            textColor: Colors.black,
            backgroundColor: Colors.blue.shade100,
          ),
          backgroundColor: Colors.greenAccent.shade400,
          content: const Text(
            "Successfully uploaded image!",
            style: TextStyle(color: Colors.white),
          )));

      // Remove image now
      context.read<ImagePreviewController>().removeImage();
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            onPressed: () async {
              await upload(context, uploadController, image);
            },
            label: 'Retry',
            textColor: Colors.white,
          ),
          backgroundColor: Colors.redAccent.shade400,
          content: const Text(
            "Failed uploading image",
            style: TextStyle(color: Colors.white),
          )));
    }

    // Close the popup
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ImagePickController, ImagePreviewController,
        ImageUploadController>(
      builder: (consumerContext, pickController, previewController,
          uploadController, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  if (previewController.hasImage)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 500,
                        child: Image(
                            errorBuilder: (context, error, stackTrace) {
                              return const Text('Invalid Format');
                            },
                            image: FileImage(previewController.image),
                            fit: BoxFit.contain),
                      ),
                    ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Selecttion Button
                      if (!previewController.hasImage)
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              elevation: 4,
                              backgroundColor: Colors.black),
                          onPressed: pickController.loading
                              ? null
                              : () async {
                                  final file = await pickController.pickImage();
                                  if (file == null) return;
                                  previewController.updateImage(file);
                                },
                          label: Text(
                            pickController.loading
                                ? "Selecting..."
                                : "Select Image",
                            style: const TextStyle(color: Colors.white),
                          ),
                          icon: pickController.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(
                                  Icons.file_upload_outlined,
                                  color: Colors.white,
                                ),
                        ),

                      // Removal Button
                      if (previewController.hasImage)
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              elevation: 4,
                              backgroundColor: Colors.redAccent),
                          onPressed: () => previewController.removeImage(),
                          label: const Text(
                            "Remove",
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.cancel_rounded,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),

                  // Error Messages
                  if (pickController.hasError)
                    Text(
                      pickController.error,
                      style: const TextStyle(
                          fontSize: 15, color: Colors.redAccent),
                    ),

                  // Upload Button
                  if (previewController.hasImage)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          elevation: 4,
                          backgroundColor: Colors.blueAccent),
                      onPressed: uploadController.loading
                          ? null
                          : () async {
                              await upload(context, uploadController,
                                  previewController.image);
                            },
                      label: Text(
                        uploadController.loading ? "Uploading..." : "Upload",
                        style: const TextStyle(color: Colors.white),
                      ),
                      icon: uploadController.loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.file_upload_outlined,
                              color: Colors.white,
                            ),
                    ),
                ]),
          ),
        );
      },
    );
  }
}
