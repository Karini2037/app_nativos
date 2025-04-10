import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {

  final void Function(File) onSelectImage;
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    final ImagePicker picker = ImagePicker();
    XFile imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    // Envia a imagem para o pai  que é o PlaceFormScreen
    widget.onSelectImage(_storedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text('Nenhuma imagem!'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Tirar Foto'),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
