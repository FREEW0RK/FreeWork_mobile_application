import 'package:flutter/material.dart';

import 'package:freework/features/places/presentation/form-fields/description_field.dart';
import 'package:freework/features/places/presentation/form-fields/editors_field.dart';
import 'package:freework/features/places/presentation/form-fields/place_name_field.dart';
import 'package:freework/features/places/presentation/form-fields/visitors_field.dart';
import 'package:freework/features/places/presentation/form-fields/submit_button.dart';
import 'package:freework/features/places/presentation/form-fields/photo_field.dart';
import 'package:freework/features/places/presentation/form-fields/reset_button.dart';
import 'package:freework/features/places/presentation/form-fields/location_field.dart';
import 'package:freework/features/places/presentation/form-fields/placetype_dropdown_field.dart';


import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../help/presentation/help_button.dart';
//import '../../data_model/chapter_db.dart';
import '../domain/places_db.dart';
import '../data/places_provider.dart';

import 'package:freework/features/user/data/user_providers.dart';
import '../../user/domain/user..dart';
import 'form-fields/utils.dart';
import 'places_view.dart';

/// Edit data for a specific garden.
class EditPlaceView extends ConsumerWidget {
  EditPlaceView({Key? key}) : super(key: key);

  static const routeName = '/editPlaceView';
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _descriptionFieldKey = GlobalKey<FormBuilderFieldState>();
  final _locationFieldKey = GlobalKey<FormBuilderFieldState>();  
  final _placeTypeFieldKey = GlobalKey<FormBuilderFieldState>();


  //final _chapterFieldKey = GlobalKey<FormBuilderFieldState>();
  final _photoFieldKey = GlobalKey<FormBuilderFieldState>();
  final _editorsFieldKey = GlobalKey<FormBuilderFieldState>();
  final _visitorFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    final UserDB userDB = ref.watch(userDBProvider);
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    String placeID = ModalRoute.of(context)!.settings.arguments as String;
    PlacesData placesData = placesDB.getPlace(placeID);
/*     List<String> chapterNames = chapterDB.getChapterNames();
    String currChapterName = chapterDB.getChapter(gardenData.chapterID).name; */
    String currEditors = placesData.editorIDs
        .map((userID) => userDB.getUser(userID).username)
        .toList()
        .join(', ');
    String currViewers = placesData.visitorIDs
        .map((userID) => userDB.getUser(userID).username)
        .toList()
        .join(', ');

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      // Valid so update the garden data.
      String name = _nameFieldKey.currentState?.value;
      String description = _descriptionFieldKey.currentState?.value;
      String location = _locationFieldKey.currentState?.value;
      String placeType = _placeTypeFieldKey.currentState?.value;


    /*   String chapterID =
          chapterDB.getChapterIDFromName(_chapterFieldKey.currentState?.value); */
      String imagePath = _photoFieldKey.currentState?.value;
      String editorsString = _editorsFieldKey.currentState?.value ?? '';
      List<String> editorIDs = usernamesToIDs(userDB, editorsString);
      String visitorString = _visitorFieldKey.currentState?.value ?? '';
      List<String> visitorIDs = usernamesToIDs(userDB, visitorString);
      // Update the garden data.
      placesDB.updatePlace(
          id: placeID,
          name: name,
          description: description,
          location: location,
          placeType: placeType,
          //chapterID: chapterID,
          imagePath: imagePath,
          editorIDs: editorIDs,
          ownerID: currentUserID,
          visitorIDs: visitorIDs);
      // Return to the list places page
      Navigator.pushReplacementNamed(context, PlacesView.routeName);
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Nice Spot'),
          actions: const [HelpButton(routeName: EditPlaceView.routeName)],
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
                      PlaceNameField(
                          fieldKey: _nameFieldKey, currName: placesData.name),
                      DescriptionField(
                          fieldKey: _descriptionFieldKey,
                          currDescription: placesData.description),
                      LocationField(
                          fieldKey: _locationFieldKey,
                          currLocation: placesData.location),
                          
                      PlaceTypeDropdownField(
                          fieldKey: _placeTypeFieldKey,
                          currPlacetype: placesData.placeType),       
                      /* ChapterDropdownField(
                          fieldKey: _chapterFieldKey,
                          chapterNames: chapterNames,
                          currChapter: currChapterName), */
                      PhotoField(
                          fieldKey: _photoFieldKey,
                          currPhoto: placesData.imagePath),
                      EditorsField(
                          fieldKey: _editorsFieldKey,
                          userDB: userDB,
                          currEditors: currEditors),
                      VisitorsField(
                          fieldKey: _visitorFieldKey,
                          userDB: userDB,
                          currViewers: currViewers),
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
