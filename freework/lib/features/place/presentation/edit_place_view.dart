
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'edit_place_controller.dart';
import '../../global_snackbar.dart';



import 'package:freework/features/place/presentation/form-fields/description_field.dart';
import 'package:freework/features/place/presentation/form-fields/editors_field.dart';
import 'package:freework/features/place/presentation/form-fields/place_name_field.dart';
import 'package:freework/features/place/presentation/form-fields/visitors_field.dart';
import 'package:freework/features/place/presentation/form-fields/submit_button.dart';
import 'package:freework/features/place/presentation/form-fields/photo_field.dart';
import 'package:freework/features/place/presentation/form-fields/reset_button.dart';
import 'package:freework/features/place/presentation/form-fields/location_field.dart';
import 'package:freework/features/place/presentation/form-fields/placetype_dropdown_field.dart';
import 'form-fields/utils.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../help/presentation/help_button.dart';
//import '../../data_model/chapter_db.dart';
import '../domain/place.dart';
import '../domain/place_collection.dart';


import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';

import 'places_view.dart';

import '../../fw_error.dart';
import '../../fw_loading.dart';
import '../../all_data_provider.dart';


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
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    //final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            currentUserID: allData.currentUserID,
            places: allData.places,
            users: allData.users,
            //chapters: allData.chapters,
            ref: ref),
        loading: () => const FWLoading(),
        error: (e, st) => FWError(e.toString(), st.toString()));
  }


  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      required List<Place> places,
      //required List<Chapter> chapters,
      required List<User> users,
      required WidgetRef ref}) {
    //ChapterCollection chapterCollection = ChapterCollection(chapters);
    PlaceCollection placeCollection = PlaceCollection(places);
    UserCollection userCollection = UserCollection(users);
    String placeID = ModalRoute.of(context)!.settings.arguments as String;
    Place placeData = placeCollection.getPlace(placeID);
    //List<String> chapterNames = chapterCollection.getChapterNames();
   /*  String currChapterName =
        chapterCollection.getChapter placeData.chapterID).name; */
    String currEditors = placeData.editorIDs
        .map((userID) => userCollection.getUser(userID).username)
        .toList()
        .join(', ');
    String currViewers = placeData.visitorIDs
        .map((userID) => userCollection.getUser(userID).username)
        .toList()
        .join(', ');



    GeoPoint _createGeoPointFromInput(String locationString) {
    // Split the location string into latitude and longitude
    List<String> locationValues = locationString.split(', ');
    double latitude = double.parse(locationValues[0]);
    double longitude = double.parse(locationValues[1]);

  return GeoPoint(latitude, longitude);
}
    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      // Since validation passed, we can safely access the values.
      String name = _nameFieldKey.currentState?.value;
      String description = _descriptionFieldKey.currentState?.value;
      //String chapterID = chapterCollection.getChapterIDFromName(_chapterFieldKey.currentState?.value);
      String locationString = _locationFieldKey.currentState?.value;
    	GeoPoint location = _createGeoPointFromInput(locationString); // Create GeoPoint
      String placeType = _placeTypeFieldKey.currentState?.value;
    /*   String chapterID =
          chapterDB.getChapterIDFromName(_chapterFieldKey.currentState?.value); */
      String imagePath = _photoFieldKey.currentState?.value;
      String editorsString = _editorsFieldKey.currentState?.value ?? '';
      List<String> editorIDs = usernamesToIDs(userCollection, editorsString);
      String visitorString = _visitorFieldKey.currentState?.value ?? '';
      List<String> visitorIDs = usernamesToIDs(userCollection, visitorString);
      String lastUpdate = DateFormat.yMd().format(DateTime.now());
      // Update the garden data.
      Place place = Place(
          id: placeID,
          name: name,
          description: description,
          location: location,
          placeType: placeType,
          //chapterID: chapterID,
          imagePath: imagePath,
          lastUpdate: lastUpdate,
          editorIDs: editorIDs,
          ownerID: currentUserID,
          visitorIDs: visitorIDs  );
      ref.read(editPlaceControllerProvider.notifier).updatePlace(
            place: place,
            onSuccess: () {
              Navigator.pushReplacementNamed(context, PlaceView.routeName);
              GlobalSnackBar.show('Nice Spot "$name" updated.');
            },
          );
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    Widget editPlaceForm() => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      PlaceNameField(
                          fieldKey: _nameFieldKey, currName: placeData.name),
                      DescriptionField(
                          fieldKey: _descriptionFieldKey,
                          currDescription: placeData.description),
                      LocationField(
                          fieldKey: _locationFieldKey,
                          currLocation: placeData.location),
                          
                      PlaceTypeDropdownField(
                          fieldKey: _placeTypeFieldKey,
                          currPlacetype: placeData.placeType),       
                      /* ChapterDropdownField(
                          fieldKey: _chapterFieldKey,
                          chapterNames: chapterNames,
                          currChapter: currChapterName), */
                      PhotoField(
                          fieldKey: _photoFieldKey,
                          currPhoto: placeData.imagePath),
                      EditorsField(
                          fieldKey: _editorsFieldKey,
                          userCollection: userCollection,
                          currEditors: currEditors),
                      VisitorsField(
                          fieldKey: _visitorFieldKey,
                          userCollection: userCollection,
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
        );
  AsyncValue asyncUpdate = ref.watch(editPlaceControllerProvider);

  return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Place'),
        actions: const [HelpButton(routeName: EditPlaceView.routeName)],
      ),
      body: asyncUpdate.when(
          data: (_) => editPlaceForm(),
          loading: () => const FWLoading(),
          error: (e, st) => FWError(e.toString(), st.toString())));

  }
}

