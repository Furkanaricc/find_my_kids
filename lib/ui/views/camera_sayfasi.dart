import 'dart:io';
import 'package:camera/camera.dart';
import 'package:find_my_kids/ui/cubit/kamera_sayfa_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class CameraSayfasi extends StatefulWidget {
  const CameraSayfasi({Key? key}) : super(key: key);

  @override
  _CameraSayfasiState createState() => _CameraSayfasiState();
}

class _CameraSayfasiState extends State<CameraSayfasi> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  int _selectedCameraIdx = 0; // Ön kamera varsayılan olarak seçilmiş durumda

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Mevcut kameraları alma
    _cameras = await availableCameras();

    // Seçilen kamerayı başlatma
    _controller = CameraController(
      _cameras[_selectedCameraIdx],
      ResolutionPreset.medium,
    );

    // Kamerayı başlatma
    await _controller.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCamera() async {
    if (_controller.value.isInitialized) {
      // Mevcut kamerayı kapatma
      await _controller.dispose();

      // Seçilen kameranın indeksini değiştirme (ön kamera ise arka kameraya, arka kamera ise ön kameraya geçiş yapma)
      _selectedCameraIdx = (_selectedCameraIdx + 1) % _cameras.length;

      // Yeni kamerayı başlatma
      _controller = CameraController(
        _cameras[_selectedCameraIdx],
        ResolutionPreset.medium,
      );

      // Kamerayı başlatma
      await _controller.initialize();

      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Ekran'),
        actions: [
          IconButton(
            onPressed: _toggleCamera,
            icon: const Icon(Icons.switch_camera),
          ),
        ],
      ),
      body: CameraPreview(_controller),
    );
  }
}