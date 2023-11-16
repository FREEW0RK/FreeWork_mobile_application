
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../user/domain/user_collection.dart';
import 'field_padding.dart';
import 'utils.dart';

/// A text field to input garden photo file name found in images subdirectory.
class EditorsField extends StatelessWidget {
  const EditorsField(
      {super.key,
      required this.fieldKey,
      required this.userCollection,
      this.currEditors});

  final String? currEditors;
  final UserCollection userCollection;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Editors';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currEditors,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'An optional, comma separated list of usernames.',
        ),
        validator: (val) {
          if (val is String) {
            return validateUserNamesString(userCollection, val);
          }
          return null;
        },
      ),
    );
  }
}


/* import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../user/domain/user.dart';
import 'field_padding.dart';
import 'utils.dart';

/// A text field to input garden photo file name found in images subdirectory.
class EditorsField extends StatelessWidget {
  const EditorsField(
      {super.key,
      required this.fieldKey,
      required this.user,
      this.currEditors});

  final String? currEditors;
  final User user;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Editors';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currEditors,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'An optional, comma separated list of usernames.',
        ),
        validator: (val) {
          if (val is String) {
            return validateUserNamesString(user, val);
          }
          return null;
        },
      ),
    );
  }
}
 */