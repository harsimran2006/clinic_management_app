import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  String imgPath = "";

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();

      controller = CameraController(cameras[0], ResolutionPreset.medium);

      await controller!.initialize();
      setState(() {});
    } catch (e) {
      debugPrint("Camera init error: $e");
    }
  }

  Future<void> capturePhoto() async {
    if (controller == null || !controller!.value.isInitialized) {
      debugPrint("Camera not ready");
      return;
    }

    try {
      final pic = await controller!.takePicture();
      setState(() {
        imgPath = pic.path;
      });
    } catch (e) {
      debugPrint("Error taking photo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera")),
      body: Column(
        children: [
          controller == null || !controller!.value.isInitialized
              ? const Text("Opening camera...")
              : Expanded(child: CameraPreview(controller!)),

          imgPath.isEmpty
              ? const Text("No photo taken")
              : Image.file(File(imgPath), height: 200),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: capturePhoto,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
