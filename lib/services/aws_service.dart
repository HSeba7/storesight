import 'package:aws_client/rds_data_2018_08_01.dart';
import 'package:aws_client/rekognition_2016_06_27.dart' as rekognition;
import 'package:aws_client/rekognition_2016_06_27.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storesight/infrastructure/utils.dart';

class AwsDetector {
  Future<DetectLabelsResponse?> detectProduct(
      {required XFile productImage}) async {
    DetectLabelsResponse? response;
    final client = rekognition.Rekognition(
      region: 'us-east-1', // Replace with your desired AWS region
      credentials: AwsClientCredentials(
          accessKey: "AKIA2UC3CHO3U4V5SCG6",
          secretKey: "bBvuSy9y7svaobN+8mqTswGimrC99CNSEyx42LAs"),
    );
    final imageBytes = await productImage.readAsBytes();

    // Call DetectLabels API
    try {
      response = await client.detectLabels(
        image: rekognition.Image(
          bytes: imageBytes,
        ),
        maxLabels: 1, // Maximum number of labels to return
        minConfidence: 70.0, // Minimum confidence level for returned labels
      );

      response.labels?.forEach((label) {
        printLn(
            '${label.name}: ${label.confidence} ${label.categories?[0].name}');
      });
    } catch (e) {
      printLn('Error detecting labels: $e');
    }
    return response;
  }
}
