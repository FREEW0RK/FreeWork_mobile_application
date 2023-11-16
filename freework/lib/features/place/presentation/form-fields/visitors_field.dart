

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../user/domain/user_collection.dart';
import 'field_padding.dart';
import 'utils.dart';

/// A text field to input garden photo file name found in images subdirectory.
class ViewersField extends StatelessWidget {
  const ViewersField(
      {super.key,
      required this.fieldKey,
      required this.userCollection,
      this.currViewers});

  final String? currViewers;
  final UserCollection userCollection;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Visitors';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currViewers,
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
class VisitorsField extends StatelessWidget {
  const VisitorsField(
      {super.key,
      required this.fieldKey,
      required this.user,
      this.currViewers});

  final String? currViewers;
  final User user;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Visitors';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currViewers,
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