import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:freework/features/places/presentation/form-fields/submit_button.dart';
import 'package:freework/features/places/presentation/form-fields/editors_field.dart';
import 'package:freework/features/places/presentation/form-fields/photo_field.dart';
import 'package:freework/features/places/presentation/form-fields/reset_button.dart';
import 'package:freework/features/places/presentation/form-fields/location_field.dart';
import 'package:freework/features/places/presentation/form-fields/placetype_dropdown_field.dart';


import '../../help/presentation/help_button.dart';
//import '../../data_model/chapter_db.dart';

import '../domain/places_db.dart';
import '../data/places_provider.dart';


import 'package:freework/features/user/data/user_providers.dart';
import '../../user/domain/user..dart';


import 'form-fields/chapter_dropdown_field.dart';
import 'form-fields/description_field.dart';
import 'form-fields/place_name_field.dart';
import 'form-fields/utils.dart';
import 'form-fields/visitors_field.dart';
import 'places_view.dart';

/// Create a new Garden.
class AddPlacesView extends ConsumerWidget {
  AddPlacesView({Key? key}) : super(key: key);

  static const routeName = '/addPlacesView';
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _descriptionFieldKey = GlobalKey<FormBuilderFieldState>();
  final _locationFieldKey = GlobalKey<FormBuilderFieldState>();
  final _placeTypeFieldKey = GlobalKey<FormBuilderFieldState>();
  //final _chapterFieldKey = GlobalKey<FormBuilderFieldState>();
  final _photoFieldKey = GlobalKey<FormBuilderFieldState>();
  final _editorsFieldKey = GlobalKey<FormBuilderFieldState>();
  final _visitorsFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
/*     //final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    //List<String> chapterNames = chapterDB.getChapterNames();
 */
    final UserDB userDB = ref.watch(userDBProvider);
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
 
    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      // Since validation passed, we can safely access the values.
      String name = _nameFieldKey.currentState?.value;
      String description = _descriptionFieldKey.currentState?.value;
      String location = _locationFieldKey.currentState?.value;
      String placeType = _placeTypeFieldKey.currentState?.value;
      String imageFileName = _photoFieldKey.currentState?.value;
      String editorsString = _editorsFieldKey.currentState?.value ?? '';
      List<String> editorIDs = usernamesToIDs(userDB, editorsString);
      String visitorsString = _visitorsFieldKey.currentState?.value ?? '';
      List<String> visitorIDs = usernamesToIDs(userDB, visitorsString);

      // Obtain an instance of PlacesDB using ref.watch
      final placesDB = ref.watch(placesDBProvider);

      // Add the new nice spot using the obtained instance
      placesDB.addPlace(
        name: name,
        description: description,
        location: location,
        placeType: placeType,
        imageFileName: imageFileName,
        editorIDs: editorIDs,
        ownerID: currentUserID,
        visitorIDs: visitorIDs,
      );
      // Return to the list places page
      Navigator.pushReplacementNamed(context, PlacesView.routeName);
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Nice FW Spot'),
          actions: const [HelpButton(routeName: AddPlacesView.routeName)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      PlaceNameField(fieldKey: _nameFieldKey),
                      DescriptionField(fieldKey: _descriptionFieldKey),
                      LocationField(fieldKey: _locationFieldKey),
                      PlaceTypeDropdownField(fieldKey: _placeTypeFieldKey),
                     /*  ChapterDropdownField(
                          fieldKey: _chapterFieldKey,
                          chapterNames: chapterNames), */
                      PhotoField(fieldKey: _photoFieldKey),
                      EditorsField(fieldKey: _editorsFieldKey, userDB: userDB),
                      VisitorsField(fieldKey: _visitorsFieldKey, userDB: userDB),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SubmitButton(onSubmit: onSubmit),
                    ResetButton(onReset: onReset),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

final placeTypesProvider = Provider<List<String>>((ref) {
  return ["Public", "Community", "AirNiceFWSpot","Remote", "Super Remote"];
});