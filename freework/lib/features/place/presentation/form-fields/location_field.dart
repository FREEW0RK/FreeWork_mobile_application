
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A text field to input garden photo file name found in images subdirectory.
class LocationField extends StatelessWidget {
  const LocationField(
      {super.key,
      required this.fieldKey,
      this.currLocation});

  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;
  final GeoPoint? currLocation;
  //final List<String>? currLocation;


  @override
  Widget build(BuildContext context) {
    String fieldName = 'Location Coordinates';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currLocation != null
            ? '${currLocation!.latitude}, ${currLocation!.longitude}'
            : null,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          (value) {
            // Custom validation logic for GeoPoint or separate latitude and longitude.
            var locationValues = value?.split(', ');
            if (locationValues != null &&
                locationValues.length == 2 &&
                double.tryParse(locationValues[0]) != null &&
                double.tryParse(locationValues[1]) != null) {
              return null; // Validation passed.
            }
            return 'Please enter valid latitude and longitude values.';
          },
        ]),
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Enter latitude and longitude (e.g., 37.7749, -122.4194)',
        ),
      ),
    );
  }
}

/*   @override
  Widget build(BuildContext context) {
    String fieldName = 'Location Coordinates';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currLocation,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Maps Coordinates of your new Nice FW spot.',
        ),
      ),
    );
  }
}
 */