part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImagesLoading extends ImageState {}

class ImagesLoaded extends ImageState {
  final List<dynamic> imageUrls;
  const ImagesLoaded({this.imageUrls = const []});

  @override
  List<Object> get props => [imageUrls];
}
