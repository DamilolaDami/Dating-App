part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends ImageEvent {}

class UpdateImages extends ImageEvent {
  final List<dynamic> imageUrls;

  const UpdateImages({required this.imageUrls});

  @override
  List<Object> get props => [imageUrls];
}
