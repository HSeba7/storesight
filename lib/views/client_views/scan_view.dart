import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/components/custom_navigation.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:storesight/models/product_model.dart';
import 'package:storesight/view_models/scan_cubit/scan_cubit.dart';
import 'package:storesight/view_models/scan_cubit/scan_state.dart';
import 'package:storesight/views/client_views/widgets/back_widget.dart';
import 'package:storesight/views/common_views/product_details.dart';
import 'package:storesight/views/common_views/scan_details.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool _cameraInitialized = false;

  @override
  void initState() {
    super.initState();
    // Request camera permission and initialize camera
    _requestCameraPermission();
    startCamera();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      // Permission granted, proceed with camera access
    } else if (status == PermissionStatus.permanentlyDenied) {
      // Handle permanently denied permission (open settings)
      await Permission.camera.request();
    } else {
      // Handle other permission status (denied, etc.)
    }
  }

  void startCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(cameras[0], ResolutionPreset.high);

    print(" Camera controller : $cameraController");

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraInitialized =
            true; // updating the flag after camera is initialized
      }); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraInitialized && cameraController.value.isInitialized) {
      return BlocConsumer<ScanCubit, ScanState>(
        listener: (context, state) {
          if (state is ScanSuccessState) {
            if (ScanCubit.get(context).detectLabelsResponse!.labels![0].name ==
                "Wristwatch") {
              navigateTo(
                  view: ProductDetails(
                    productModel: StoreModel(
                      id: 3,
                      name: "Zegarek na rękę",
                      description:
                          "Zegarek na rękę to elegancki i funkcjonalny dodatek, który nie tylko pomaga śledzić czas, ale także podkreśla indywidualny styl użytkownika. Ten precyzyjnie wykonany zegarek jest idealnym wyborem dla osób ceniących zarówno wysoką jakość, jak i estetykę. Z jego solidną konstrukcją i wygodnym paskiem zapewnia nie tylko niezawodność, ale także komfort noszenia przez cały dzień.",
                      images: [
                        StoreImage(
                          id: 3,
                          dateCreated: DateTime.now(),
                          dateCreatedGmt: DateTime.now(),
                          dateModified: DateTime.now(),
                          dateModifiedGmt: DateTime.now(),
                          src:
                              "$baseUrl/media/product_images/WhatsApp_Image_2024-06-27_at_23.44.43_ro0grYN.jpeg",
                          name: "name",
                          alt: "alt",
                        ),
                      ],
                      categories: [
                        Category(
                          id: 1,
                          name: "Odzież i akcesoria",
                          slug: "Odzież i akcesoria",
                        ),
                      ],
                    ),
                  ),
                  context: context);
            } else {
              navigateTo(
                view: const ScanDetailsView(),
                context: context,
              );
            }
          }
        },
        builder: (context, state) {
          ScanCubit cubit = ScanCubit.get(context);
          return Scaffold(
            body: Stack(
              alignment: Alignment.topLeft,
              children: [
                ConditionalBuilder(
                  condition: state is! ScanLoadingState,
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  builder: (context) {
                    return CameraPreview(cameraController);
                  },
                ),
                Padding(
                  padding: padding,
                  child: const SafeArea(child: CircleBackWidget()),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.camera_alt),
              onPressed: () async {
                try {
                  XFile? image = await cameraController.takePicture();
                  cubit.pickProductImage(value: image);
                  await cubit.scanProduct();
                } catch (e) {
                  printLn('Error: $e');
                }
              },
            ),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
