import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  final List<File> _images = [];

  void _addImage(File pickedImage) {
    setState(() {
      _images.add(pickedImage);
    });
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _images.isEmpty) return;
    //salva os dados
  }

  void _openCamera() {
    //Mostra novamente o ImageInput ao clicar em "Avançar"
    showBottomSheet(context: context,
     builder: (_) => ImageInput(onSelectImage: _addImage),)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon()
                    ),
                    const SizedBox(height: 10),
                    const ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
