import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class StageController extends GetxController {
  var stage = 'المرحلة الثانوية';
  void setStage(String newstage) {
    stage = newstage;
    update();
  }
}