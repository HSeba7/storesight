import 'package:aws_client/rekognition_2016_06_27.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:storesight/services/aws_service.dart';
import 'package:storesight/view_models/scan_cubit/scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanState());
  static ScanCubit get(context) => BlocProvider.of(context);
  final AwsDetector _awsDetector = AwsDetector();
  DetectLabelsResponse? detectLabelsResponse;
  XFile? productImage;

  Future<void> pickProductImage({required XFile value}) async {
    productImage = value;
    emit(ScanInitial());
  }

  Future<void> scanProduct() async {
    emit(ScanLoadingState());
    await _awsDetector.detectProduct(productImage: productImage!).then((value) {
      detectLabelsResponse = value;
      emit(ScanSuccessState());
    }).catchError((error) {
      printLn(error.toString());
      emit(ScanErrorState(error.toString()));
    });
  }
}
