import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraSayfasi extends StatefulWidget {
  const CameraSayfasi({Key? key}) : super(key: key);

  @override
  State<CameraSayfasi> createState() => _CameraSayfasiState();
}

class _CameraSayfasiState extends State<CameraSayfasi> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    getAvailableCameras();
    initializeCameraController();

  }

  void initializeCameraController() async {
    await getAvailableCameras();
    _controller = CameraController(
      cameras.isNotEmpty ? cameras[1] : throw 'No cameras found',
      ResolutionPreset.max,
      enableAudio: true,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Fotoğraf çekmek için bir fonksiyon tanımlayın
  void _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      // Elde edilen fotoğrafı kullanın veya kaydedin

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Image.file(File(image.path)), // Fotoğrafı göstermek için Image.file() kullanıyoruz.
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
  void startRecording() async {
    try {
      await _controller.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    } on CameraException catch (e) {
      print('Error starting video recording: $e');
    }
  }

  void stopRecording() async {
    try {
      XFile videoFile = await _controller.stopVideoRecording();
      print('Video recorded at ${videoFile.path}');
      setState(() {
        _isRecording = false;
      });
    } on CameraException catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Card(
              child: Container(
                height: 70,
                width: 345,
                child: const Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(CupertinoIcons.exclamationmark_bubble),
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Aşşağıdaki butonları kullanarak video veya"),
                        Text(" fotoğraf çekebilirsiniz."),
                      ],
                    ),

                  ],
                ),
              ),
            ),
              /*ListView(
              children: [
                Column(
                  children: [

                  ],
                )
              ],
            ),*/
            Container(
              width: ekranGenisligi,
              height: 90,
              color: Colors.amber ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: (){_isRecording ? stopRecording : startRecording;},
                      icon: Icon( _isRecording ? Icons.stop : Icons.videocam_outlined,size: 55,) ),
                  IconButton(onPressed: (){
                    _takePicture();
                  }, icon: const Icon(Icons.camera,size: 55,)),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
