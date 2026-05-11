import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pixora/controllers/controllers.dart';
import 'package:pixora/views/widgets/video_player_dialog.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoryController>().getHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            await context.read<HistoryController>().getHistory(),
        child: Consumer<HistoryController>(
          builder: (context, controller, child) {
            if (controller.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline_rounded,
                        size: 48, color: Colors.redAccent.shade200),
                    const SizedBox(height: 12),
                    Text(
                      controller.error,
                      style: const TextStyle(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (controller.loading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black87),
              );
            }

            if (!controller.hasHistory) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image_not_supported_outlined,
                        size: 56, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    Text(
                      "No uploads yet",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.history!.length,
              itemBuilder: (context, index) {
                final item = controller.history![index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => VideoPopup(
                        videoUrl: item.outputUrl!,
                        title: 'Project Result',
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),

                        // Image Thumbnail
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: Image.network(
                            item.imageUrl!,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 90,
                              width: 90,
                              color: Colors.grey.shade200,
                              child: Icon(Icons.broken_image_outlined,
                                  color: Colors.grey.shade400),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        // Details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Upload #${item.id}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.access_time_rounded,
                                        size: 13, color: Colors.grey.shade500),
                                    const SizedBox(width: 4),
                                    Text(
                                      DateFormat("dd MMM yyyy  HH:mm").format(
                                          DateTime.parse(item.createdAt!)),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.videocam_rounded,
                                          size: 13,
                                          color: Colors.blue.shade400),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Video ready",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.blue.shade400,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
