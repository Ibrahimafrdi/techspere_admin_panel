import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/models/addon.dart';
import 'package:kabir_admin_panel/core/models/item.dart';
import 'package:kabir_admin_panel/core/models/variation.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/services/database_storage_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';
import 'package:cross_file/cross_file.dart';
import 'dart:html';
import 'package:image_cropper/image_cropper.dart';

class FoodDetailsProvider extends BaseViewModal {
  DatabaseServices _databaseServices = DatabaseServices();
  DatabaseStorageServices _databaseStorageServices = DatabaseStorageServices();

  bool dragging = false;

  String? imagePath;

  File? file;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController cautionController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String featured = 'Yes';
  String selectedStatus = activeString;
  String? selectedCategory;

  Item item = Item();
  List<Variation> variations = [];
  List<Addon> selectedAddons = [];
  bool initCalled = false;

  var itemId;

  initItem(Item item) {
    if (!initCalled) {
      this.item = item;
      nameController.text = item.title ?? '';
      priceController.text = item.price?.toString() ?? '';
      cautionController.text = item.caution ?? '';
      descController.text = item.description ?? '';
      featured = item.isFeatured ?? false ? 'Yes' : 'No';
      selectedStatus = item.isAvailable ?? true ? activeString : inActiveString;
      selectedCategory = item.categoryId;
      variations = item.variations ?? [];
      selectedAddons = item.addons ?? [];
      print(imagePath);
      imagePath = imagePath ?? item.imageUrl;
      print(imagePath);
      initCalled = true;
    }
  }

  addItem() async {
    item.title = nameController.text;
    item.price = double.parse(priceController.text);
    item.caution = cautionController.text;
    item.description = descController.text;
    item.isFeatured = featured == 'Yes';
    item.isAvailable = selectedStatus == activeString;
    item.categoryId = selectedCategory;
    item.variations = variations;
    item.addons = selectedAddons;

    if (file != null) {
      print('file not null');
      try {
        item.imageUrl =
            await _databaseStorageServices.uploadHtmlFileToFirebase(file!);
        print('uploaded');
      } catch (e) {
        print('Error uploading file: $e');
      }
    }

    await _databaseServices.addItem(item);
    notifyListeners();
  }

  loadImage(files, context) async {
    if (files is List<XFile>) {
      var file = File([await files[0].readAsBytes()], '');

      // Create a temporary URL for the blob
      final blobUrl = Url.createObjectUrlFromBlob(file);

      // Open image cropper
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: blobUrl,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        // cropStyle: CropStyle.rectangle,
        compressQuality: 80,
        uiSettings: [
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.page,
            size: CropperSize(
              width: 520,
              height: 520,
            ),
            viewwMode: WebViewMode.mode_1,
            dragMode: WebDragMode.move,
            // viewPort: CroppieViewPort(
            //   width: 480,
            //   height: 270,
            // ),
            cropBoxResizable: false,
            zoomable: true,
            movable: true,
            zoomOnWheel: false,
            // showZoomer: true,
          ),
        ],
      );

      // Revoke the temporary URL
      Url.revokeObjectUrl(blobUrl);

      if (croppedFile != null) {
        this.file = File([await XFile(croppedFile.path).readAsBytes()], '');
        final reader = FileReader();
        reader.readAsDataUrl(this.file!);
        reader.onLoadEnd.listen((e) {
          imagePath = reader.result as String;
          notifyListeners();
        });
      }
    } else {
      if (files!.isEmpty) return;

      final blobUrl = Url.createObjectUrlFromBlob(files[0]);

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: blobUrl,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        // cropStyle: CropStyle.rectangle,
        compressQuality: 80,
        uiSettings: [
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.page,
            size: CropperSize(
              width: 520,
              height: 520,
            ),
            viewwMode: WebViewMode.mode_1,
            dragMode: WebDragMode.move,
            // viewPort: CroppieViewPort(
            //   width: 480,
            //   height: 270,
            // ),
            cropBoxResizable: false,
            zoomable: true,

            zoomOnWheel: false,
            // showZoomer: true,
          ),
        ],
      );

      Url.revokeObjectUrl(blobUrl);

      if (croppedFile != null) {
        this.file = File([await XFile(croppedFile.path).readAsBytes()], '');
        final reader = FileReader();
        reader.readAsDataUrl(this.file!);
        reader.onLoadEnd.listen((e) {
          imagePath = reader.result as String;
          notifyListeners();
        });
      }
    }
  }

  removeImage() {
    imagePath = null;
    notifyListeners();
  }

  toggleDragging(bool dragging) {
    this.dragging = dragging;
    notifyListeners();
  }

  addItemVariation() {
    variations.add(
      Variation(
        name: '',
        isRequired: false,
        options: [
          VariationOption(
            name: '',
            price: null,
          ),
        ],
      ),
    );
    notifyListeners();
  }

  updateVariation(Variation variation, index) {
    variations[index] = variation;
    notifyListeners();
  }

  removeVariation(index) {
    variations.removeAt(index);
    notifyListeners();
  }

  addSpec(Map<String, String> spec) {
    item.technicalSpecs!.addAll(spec);
    notifyListeners();
  }

  removeSpec(String key) {
    item.technicalSpecs!.remove(key);
    notifyListeners();
  }
}
