import 'package:image_picker/image_picker.dart';

abstract class BaseStroageRepository {
  Future<void> uploadImage(XFile image);
}
