import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiki/respositories/databerepository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? databaseSubscription;

  ImageBloc({
    required DatabaseRepository databaseRepository,
  })  : _databaseRepository = databaseRepository,
        super(ImagesLoading());

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    if (event is ImagesLoaded) {
      yield* _mapLoadImagesToState();
    }
    if (event is UpdateImages) {
      yield* _mapUpdateImagesToState(event);
    }
  }

  Stream<ImageState> _mapLoadImagesToState() async* {
    databaseSubscription?.cancel();

    _databaseRepository
        .getUser()
        .listen((user) => add(UpdateImages(imageUrls: user.imageUrls ?? [])));
  }

  Stream<ImageState> _mapUpdateImagesToState(UpdateImages event) async* {
    yield ImagesLoaded(imageUrls: event.imageUrls);
  }
}
