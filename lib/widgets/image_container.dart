import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiki/respositories/storage_repository.dart';

import '../authentications_bloc/cubits/signup_cubit.dart';

class CustomImageContainer extends StatefulWidget {
  final String? imageUrl;
  const CustomImageContainer({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<CustomImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  @override
  Widget build(BuildContext context) {
    XFile? file;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: widget.imageUrl != null
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
            top: BorderSide(
              width: 1,
              color: widget.imageUrl != null
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
            left: BorderSide(
              width: 1,
              color: widget.imageUrl != null
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
            right: BorderSide(
              width: 1,
              color: widget.imageUrl != null
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: (widget.imageUrl == null)
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () async {
                    ImagePicker _picker = ImagePicker();
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      file = image;
                    });

                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("No image selected")));
                    } else {
                      StorageRepository().uploadImage(image);
                    }
                  },
                ),
              )
            : Image.network(
                widget.imageUrl ?? "",
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
