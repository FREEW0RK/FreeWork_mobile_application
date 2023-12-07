
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:freework/features/place/presentation/form-fields/submit_button.dart';
import 'package:freework/features/place/presentation/form-fields/editors_field.dart';
import 'package:freework/features/place/presentation/form-fields/photo_field.dart';
import 'package:freework/features/place/presentation/form-fields/reset_button.dart';
import 'package:freework/features/place/presentation/form-fields/location_field.dart';
import 'package:freework/features/place/presentation/form-fields/placetype_dropdown_field.dart';
import 'form-fields/description_field.dart';
import 'form-fields/place_name_field.dart';
import 'form-fields/utils.dart';
import 'form-fields/visitors_field.dart';




import '../../help/presentation/help_button.dart';
//import '../../data_model/chapter_db.dart';
import '../domain/place.dart';
import '../domain/place_collection.dart';
import 'edit_place_controller.dart';


import '../../fw_error.dart';
import '../../fw_loading.dart';
import '../../all_data_provider.dart';
/* import '../../chapter/domain/chapter.dart';
import '../../chapter/domain/chapter_collection.dart'; */
import '../../global_snackbar.dart';

import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';

import 'places_view.dart';

/// Create a new sick place.
class AddPlaceView extends ConsumerWidget {
  AddPlaceView({Key? key}) : super(key: key);

  static const routeName = '/addPlaceView';
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
  //final ChapterDB chapterDB = ref.watch(chapterDBProvider);
  //List<String> chapterNames = chapterDB.getChapterNames();
  final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
  return asyncAllData.when(
    data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        places: allData.places,
        users: allData.users,
        //chapters: allData.chapters,
        ref: ref),
      loading: () => const FWLoading(),
      error: (error, stacktrace) =>
          FWError(error.toString(), stacktrace.toString()));
  }

  
  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      required List<Place> places,
      //required List<Chapter> chapters,
      required List<User> users,
      required WidgetRef ref}) {
    //ChapterCollection chapterCollection = ChapterCollection(chapters);
    //List<String> chapterNames = chapterCollection.getChapterNames();
    PlaceCollection placeCollection = PlaceCollection(places);
    UserCollection userCollection = UserCollection(users);


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
      String imageFileName = _photoFieldKey.currentState?.value;
      String editorsString = _editorsFieldKey.currentState?.value ?? '';
      List<String> editorIDs = usernamesToIDs(userCollection, editorsString);
      String visitorsString = _visitorsFieldKey.currentState?.value ?? '';
      int numPlaces = placeCollection.size();

      List<String> visitorIDs = usernamesToIDs(userCollection, visitorsString);
      String id = 'Sick Place-${(numPlaces + 1).toString().padLeft(3, '0')}';
      String imagePath = 'assets/images/$imageFileName';
      String lastUpdate = DateFormat.yMd().format(DateTime.now());
      // Add the new nice spot using the obtained instance
      Place place = Place(
        name: name,
        id: id,
        description: description,
        location: location,
        placeType: placeType,
        imagePath: imagePath,
        lastUpdate: lastUpdate,
        editorIDs: editorIDs,
        ownerID: currentUserID,
        visitorIDs: visitorIDs,);

        
    ref.read(editPlaceControllerProvider.notifier).updatePlace(
            place: place,
            onSuccess: () {
              Navigator.pushReplacementNamed(context, PlaceView.routeName);
              GlobalSnackBar.show('Nice Spot "$name" added.');
            },
          );
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

  Widget addPlaceForm() => ListView(
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
                      EditorsField(
                        fieldKey: _editorsFieldKey,
                        userCollection: userCollection),
                      VisitorsField(
                        fieldKey: _visitorsFieldKey,
                        userCollection: userCollection),
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
        title: const Text('Add Nice Spot'),
        actions: const [HelpButton(routeName: AddPlaceView.routeName)],
      ),
      body: asyncUpdate.when(
          data: (_) => addPlaceForm(),
          loading: () => const FWLoading(),
          error: (e, st) => FWError(e.toString(), st.toString())));

  }
}




final placeTypesProvider = Provider<List<String>>((ref) {
  return ["Public", "Community", "AirNiceFWSpot","Remote", "Super Remote"];
});

