import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:freework/features/user/domain/user..dart';

import 'package:freework/features/places/presentation/add_places_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'field_padding.dart';



class PlaceTypeDropdownField extends ConsumerWidget {
  const PlaceTypeDropdownField({super.key,
    required this.fieldKey,
    this.currPlacetype});

 final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  final String? currPlacetype;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> placeTypes = ref.watch(placeTypesProvider);

    String fieldName = 'Nice Spot Type';
    return FieldPadding(
      child: FormBuilderDropdown<String>(
        name: fieldName,
        initialValue: placeTypes.first, // Set an initial value from the list of place types
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
        ),
        validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
        items: placeTypes
            .map((name) => DropdownMenuItem(
                  alignment: AlignmentDirectional.centerStart,
                  value: name,
                  child: Text(name),
                ))
            .toList(),
        valueTransformer: (val) => val?.toString(),
      ),
    );
  }
}