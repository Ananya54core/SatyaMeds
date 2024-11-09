import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:external_path/external_path.dart';
import 'package:satyameds/mainscreen/edgeimpulse.dart';
import 'package:satyameds/mainscreen/scanner/medicineservice.dart';


class MainPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MainPage({super.key, required this.cameras});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  List<File> imagesList = [];
  bool isFlashOn = false;
  bool isRearCamera = true;

  final ImagePicker _picker = ImagePicker();
  final EdgeImpulseService _edgeImpulseService = EdgeImpulseService();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() {
    cameraController = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
    );
    cameraValue = cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<File> saveImage(XFile image) async {
    final downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('$downloadPath/$fileName');

    try {
      await file.writeAsBytes(await image.readAsBytes());
    } catch (e) {
      print("Error saving image: $e");
    }

    return file;
  }

  Future<void> takePicture() async {
    if (cameraController.value.isTakingPicture || !cameraController.value.isInitialized) {
      return;
    }

    if (isFlashOn) {
      await cameraController.setFlashMode(FlashMode.torch);
    } else {
      await cameraController.setFlashMode(FlashMode.off);
    }

    try {
      final image = await cameraController.takePicture();
      final file = await saveImage(image);

      setState(() {
        imagesList.add(file);
      });

      // Load media into gallery
      MediaScanner.loadMedia(path: file.path);

      // Detect plant using EdgeImpulseService
      final result = await _edgeImpulseService.detectMedicine(file);
      _showDetectionResult(result);
    } catch (e) {
      print("Error taking picture: $e");
    } finally {
      if (isFlashOn) {
        cameraController.setFlashMode(FlashMode.off);
      }
    }
  }

  void _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        imagesList.add(file);
      });

      MediaScanner.loadMedia(path: file.path);

      final result = await _edgeImpulseService.detectMedicine(file);
      _showDetectionResult(result);
    }
  }
  void _showDetectionResult(String detectedLabel) async {
    final medicineService = MedicineService();
    final extractedLabel = detectedLabel.split(' ')[1]; // Extracts the medicine name from the label.
    final medicine = await medicineService.getMedicineDetails(extractedLabel);

    if (medicine != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFB39DDB), // Customize background color
            title: Center(
              child: Text(
                medicine.commonName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display Medicine Image
                    if (medicine.path != null)
                      Center(
                        child: Image.asset(
                          medicine.path,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),

                    SizedBox(height: 16),
                    // Section: Scientific Name
                    _buildSectionTitle(context, 'Scientific Name'),
                    _buildContentText(medicine.scientificName),
                    Divider(color: Colors.white38),

                    // Section: Medicinal Values
                    _buildSectionTitle(context, 'Medicinal Values'),
                    _buildKeyValueRow('Health Benefits', medicine.medicinalValues.healthBenefits.join(", ")),
                    _buildKeyValueRow('Key Active Compounds', medicine.medicinalValues.keyActiveCompounds.join(", ")),
                    _buildKeyValueRow('Values', medicine.medicinalValues.values.join(", ")),
                    Divider(color: Colors.white38),

                    // Section: Usage and Preparation
                    _buildSectionTitle(context, 'Usage and Preparation'),
                    _buildKeyValueRow('Preparation Methods', medicine.usageAndPreparation.preparationMethods.join(", ")),
                    _buildKeyValueRow('Recommended Dosage', medicine.usageAndPreparation.recommendedDosage),
                    _buildKeyValueRow('Usage', medicine.usageAndPreparation.usage),
                    Divider(color: Colors.white38),

                    // Section: Disease Cures
                    _buildSectionTitle(context, 'Disease Cures'),
                    _buildContentText(medicine.diseaseCures.join(", ")),
                    Divider(color: Colors.white38),

                    // Section: Possible Side Effects
                    _buildSectionTitle(context, 'Possible Side Effects'),
                    _buildContentText(medicine.possibleSideEffects.join(", ")),
                    Divider(color: Colors.white38),

                    // Section: Interaction Warnings
                    _buildSectionTitle(context, 'Interaction Warnings'),
                    _buildContentText(medicine.interactionWarnings.join(", ")),
                    Divider(color: Colors.white38),

                    // Section: Recipes
                    _buildSectionTitle(context, 'Recipes'),
                    ...medicine.recipes.map((recipe) => _buildRecipeSection(recipe)),
                    Divider(color: Colors.white38),

                    // Section: Additional Information
                    _buildSectionTitle(context, 'Additional Information'),
                    _buildKeyValueRow('Manufacturer', medicine.manufacturer),
                    _buildKeyValueRow('Expiry Date', medicine.expiryDate),
                    _buildKeyValueRow('Prescription Required', medicine.prescriptionRequired ? 'Yes' : 'No'),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Medicine Not Found'),
            content: Text('No details found for the detected medicine.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

// Helper widget to style section titles consistently
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
      ),
    );
  }

// Helper widget for key-value rows with alignment
  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$key:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(color: Colors.white70),
            softWrap: true,
          ),
        ],
      ),
    );
  }

// Helper widget for recipe section with spacing and alignment
  Widget _buildRecipeSection( recipe) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildKeyValueRow('Ingredients', recipe.ingredients.join(", ")),
          _buildKeyValueRow('Preparation', recipe.preparation.join(", ")),
          _buildKeyValueRow('Benefits', recipe.benefits.join(", ")),
          Divider(color: Colors.white38), // Divider for visual separation
        ],
      ),
    );
  }

// Helper widget for plain text in sections
  Widget _buildContentText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.white70),
        softWrap: true,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Med Detector'),
        actions: [
          IconButton(
            icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_rear),
            onPressed: () {
              setState(() {
                isRearCamera = !isRearCamera;
                _initializeCamera();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: _pickImageFromGallery,
          ),
        ],
      ),
      body: FutureBuilder(
        future: cameraValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(cameraController);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takePicture,
        child: Icon(Icons.camera),
      ),
    );
  }
}
