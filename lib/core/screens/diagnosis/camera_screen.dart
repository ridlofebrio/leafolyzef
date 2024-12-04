import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/blocs/detection/detection_bloc.dart';
import 'package:leafolyze/blocs/detection/detection_event.dart';
import 'package:leafolyze/blocs/detection/detection_state.dart';
import 'package:leafolyze/core/widgets/diagnosis/save_dialog_widget.dart';
import 'package:leafolyze/services/object_detector.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafolyze/core/screens/diagnosis/result_screen.dart';

class CameraScreen extends StatefulWidget {
  final Map<String, dynamic>? extra;

  const CameraScreen({
    super.key,
    this.extra,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ObjectDetector _objectDetector = ObjectDetector();
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0;
  bool _isFlashOn = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        _initializeCamera();
      }
    } else if (status.isGranted) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _controller = CameraController(
          cameras![_selectedCameraIndex], ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: Platform.isAndroid
              ? ImageFormatGroup.nv21
              : ImageFormatGroup.bgra8888);
      try {
        await _controller!.initialize();
        if (Platform.isAndroid) {
          await _controller!.lockCaptureOrientation();
          await _controller!.setExposureMode(ExposureMode.auto);
          await _controller!.setFocusMode(FocusMode.auto);
        }
        setState(() {
          _isCameraInitialized = true;
        });
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera initialization error: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _flipCamera() async {
    if (cameras != null && cameras!.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras!.length;
      await _initializeCamera();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _processImage(image);
    }
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized ||
        _controller!.value.isTakingPicture) {
      return;
    }

    try {
      XFile picture = await _controller!.takePicture();
      _processImage(picture);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error taking picture: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _processImage(XFile image) async {
    setState(() {
      _isProcessing = true;
    });

    try {
      if (widget.extra != null && widget.extra!['isRegenerate'] == true) {
        if (!mounted) return;

        final String newImagePath = image.path;
        final detections = await _objectDetector.detectFromImage(image);

        if (detections.isEmpty) {
          if (!mounted) return;
          setState(() {
            _isProcessing = false;
          });
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Tidak Ada Penyakit Terdeteksi'),
              content: const Text(
                  'Tidak ada penyakit tanaman yang terdeteksi dalam gambar ini. Silakan coba lagi dengan gambar yang lebih jelas.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          return;
        }

        showDialog(
          context: context,
          builder: (context) => SaveDialogWidget(
            imagePath: newImagePath,
            diseaseIds: [widget.extra!['diseaseId'] ?? 3],
            initialTitle: widget.extra!['title'],
            onSave: (String title) {
              context.read<DetectionBloc>().add(
                    UpdateDetection(
                      id: widget.extra!['detectionId'],
                      title: title,
                      imagePath: newImagePath,
                      diseaseIds: [widget.extra!['diseaseId'] ?? 3],
                    ),
                  );
            },
          ),
        );
        return;
      }

      final detections = await _objectDetector.detectFromImage(image);

      if (detections.isEmpty) {
        if (!mounted) return;
        setState(() {
          _isProcessing = false;
        });
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Tidak Ada Penyakit Terdeteksi'),
            content: const Text(
                'Tidak ada penyakit tanaman yang terdeteksi dalam gambar ini. Silakan coba lagi dengan gambar yang lebih jelas.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      if (!mounted) return;

      final detection = detections[0];
      final disease = detection['class'] as String;
      final diseaseId = _mapDiseaseToId(disease);

      showDialog(
        context: context,
        builder: (context) => SaveDialogWidget(
          imagePath: image.path,
          diseaseIds: [diseaseId],
          onSave: (String title) {
            context.read<DetectionBloc>().add(
                  SaveDetection(
                    title: title,
                    imagePath: image.path,
                    diseaseIds: [diseaseId],
                  ),
                );
          },
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error memproses gambar: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      if (_controller!.value.flashMode == FlashMode.off) {
        await _controller!.setFlashMode(FlashMode.torch);
        setState(() {
          _isFlashOn = true;
        });
      } else {
        await _controller!.setFlashMode(FlashMode.off);
        setState(() {
          _isFlashOn = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to toggle flash'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  int _mapDiseaseToId(String disease) {
    final Map<String, int> diseaseIds = {
      'Bacterial Spot': 1,
      'Early_Blight': 2,
      'Healthy': 3,
      'Late_blight': 4,
      'Leaf Mold': 5,
      'Target_Spot': 6,
      'black spot': 7,
    };
    return diseaseIds[disease] ?? 3; // Default to 3 if not found
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetectionBloc, DetectionState>(
      listener: (context, state) {
        if (state is DetectionSuccess) {
          setState(() {
            _isProcessing = false;
          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                detectionId: state.detection?.id ?? 0,
                title: state.detection?.title ?? '',
                diseaseId: state.detection?.diseases?.firstOrNull?.id ?? 0,
                imageUrl: state.detection?.image?.path ?? '',
                description: 'Deskripsi untuk ${state.detection?.title ?? ''}',
                treatmentTitle: 'Pengobatan',
                treatments: [],
                pesticideTitle: 'Pestisida',
                pesticides: [],
                timestamp: DateTime.now().toString(),
              ),
            ),
          );
        } else if (state is DetectionError) {
          setState(() {
            _isProcessing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [
                !_isCameraInitialized
                    ? const Center(child: CircularProgressIndicator())
                    : CameraPreview(_controller!),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => context.go('/home'),
                        ),
                        IconButton(
                          icon: Icon(
                              _isFlashOn ? Icons.flash_on : Icons.flash_off,
                              color: Colors.black),
                          onPressed: _toggleFlash,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.photo_library,
                              color: Colors.black, size: 32),
                          onPressed: _pickImageFromGallery,
                        ),
                        GestureDetector(
                          onTap: _takePicture,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.camera,
                                color: Colors.black, size: 40),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.flip_camera_android,
                              color: Colors.black, size: 32),
                          onPressed: _flipCamera,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Memproses gambar...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
