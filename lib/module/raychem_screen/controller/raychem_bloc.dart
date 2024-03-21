import 'package:camera/camera.dart';
import 'package:ecart/_util/common_function.dart';
import 'package:ecart/module/raychem_screen/controller/raychem_event.dart';
import 'package:ecart/module/raychem_screen/controller/raychem_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RayChemBloc extends Bloc<RayChemEvent, RayChemState> {
  late CameraController controller;
  RayChemBloc() : super(RayChemState.initial()) {
    on<UploadImageEvent>(
      (event, emit) async {
        final camera = await availableCameras();
        final controller =
            CameraController(camera.last, ResolutionPreset.medium);
        await controller.initialize();
        final XFile image = await controller.takePicture();
        emit(state.copyWith(imagePath: image.path));
      },
    );
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
