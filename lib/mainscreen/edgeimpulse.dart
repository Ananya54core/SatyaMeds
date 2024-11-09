import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class EdgeImpulseService {
  final String apiKey = 'ei_8461174bece84c3a473ff07014fd6c5b0742ed22c4fec6550ff23e980e7f76e7';

  Future<String> detectMedicine(File imageFile) async {
    // Step 1: Upload the image file to Edge Impulse
    final uploadUrl = 'https://ingestion.edgeimpulse.com/api/training/files';
    final uploadRequest = http.MultipartRequest('POST', Uri.parse(uploadUrl))
      ..headers['x-api-key'] = apiKey
      ..headers['Content-Type'] = 'multipart/form-data'
      ..files.add(await http.MultipartFile.fromPath('data', imageFile.path, filename: 'medicine_image.jpg'));

    print('Sending upload request to $uploadUrl');
    final uploadResponse = await uploadRequest.send();
    final uploadResponseBody = await http.Response.fromStream(uploadResponse);

    print('Upload response status code: ${uploadResponseBody.statusCode}');
    print('Upload response body: ${uploadResponseBody.body}');

    if (uploadResponseBody.statusCode == 200) {
      var uploadData = jsonDecode(uploadResponseBody.body);
      if (uploadData['success'] == true) {
        // Step 2: Use the model for medicine prediction
        final sampleId = uploadData['files'][0]['sampleId'];
        final projectId = uploadData['files'][0]['projectId'];
        final predictUrl = 'https://studio.edgeimpulse.com/v1/api/$projectId/classify/$sampleId';
        final predictResponse = await http.get(
          Uri.parse(predictUrl),
          headers: {
            'x-api-key': apiKey,
            'Content-Type': 'application/json',
          },
        );

        print('Prediction response status code: ${predictResponse.statusCode}');
        print('Prediction response body: ${predictResponse.body}');

        if (predictResponse.statusCode == 200) {
          var predictData = jsonDecode(predictResponse.body);
          var classifications = predictData['classifications'][0]['structuredResult'];

          if (classifications.isNotEmpty) {
            var result = '';
            for (var classification in classifications) {
              // Safely access labels and scores for medicine detection
              var labels = classification['labels'];
              var scores = classification['scores'];
              if (labels.isNotEmpty && scores.isNotEmpty) {
                var label = labels[0];
                var confidence = (scores[0] * 100).toStringAsFixed(2);
                result += 'Detected: $label with $confidence% confidence\n';
              } else {
                result += 'No labels or scores available for this classification.\n';
              }
            }
            return result.isNotEmpty ? result : 'No classifications were detected.';
          } else {
            return 'No classifications found in the prediction result.';
          }
        } else {
          return 'Prediction request failed with status: ${predictResponse.statusCode}';
        }
      } else {
        return 'File upload failed.';
      }
    } else {
      return 'Upload request failed with status: ${uploadResponseBody.statusCode}';
    }
  }
}
