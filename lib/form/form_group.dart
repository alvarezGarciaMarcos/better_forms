import 'package:flutter/cupertino.dart';
import 'package:form_framework/form/types/types.dart';

class BFFormGroup extends StatelessWidget implements IBFFormField {
  final List<IBFFormField> fields;
  final double horizontalSpacing;
  final double verticalSpacing;
  final int columns;
  final String title;

  BFFormGroup({
    this.fields = const [],
    this.columns = 2,
    this.horizontalSpacing = 30,
    this.verticalSpacing = 20,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    var chunks = _createChunks(fields, columns);
    return Column(
      children: [
        if (this.title != null) Text(this.title),
        ..._buildFormRow(chunks, horizontalSpacing, verticalSpacing, columns)
      ],
    );
  }
}

List<Widget> _buildFormRow(List<List<IBFFormField>> rows,
    double horizontalSpacing, double verticalSpacing, int numberOfColumns) {
  var newRows = rows
      .map((futureRow) => Row(
            children: futureRow
                .asMap()
                .entries
                .map((field) => _buildChild(
                    field.value,
                    verticalSpacing,
                    horizontalSpacing,
                    field.key,
                    futureRow.length,
                    numberOfColumns))
                .toList(),
          ))
      .toList();

  return newRows;
}

Widget _buildChild(
    IBFFormField field,
    double verticalSpacing,
    double horizontalSpacing,
    int currentIndex,
    int totalElements,
    int numberOfColumns) {
  var leftChild = Expanded(
    child: new Padding(
      padding: EdgeInsets.only(
        right: verticalSpacing,
        bottom: horizontalSpacing,
      ),
      child: field,
    ),
  );

  var rightChild = Expanded(
    child: new Padding(
      padding: EdgeInsets.only(
        left: verticalSpacing,
        bottom: horizontalSpacing,
      ),
      child: field,
    ),
  );

  var middleChild = Expanded(
    child: new Padding(
      padding: EdgeInsets.only(
        left: verticalSpacing,
        right: verticalSpacing,
        bottom: horizontalSpacing,
      ),
      child: field,
    ),
  );

  var singleChild = Expanded(
    child: new Padding(
      padding: EdgeInsets.only(
        bottom: horizontalSpacing,
      ),
      child: field,
    ),
  );

  if (currentIndex == 0 && currentIndex != totalElements - 1) {
    return leftChild;
  } else if (currentIndex > 0 && currentIndex < totalElements - 1) {
    return middleChild;
  } else if (currentIndex == totalElements - 1 &&
      numberOfColumns == totalElements) {
    return rightChild;
  } else {
    return singleChild;
  }
}

List<List<IBFFormField>> _createChunks(List<IBFFormField> fields, int columns) {
  int maxNumberOfElements = columns;
  List<List<IBFFormField>> chunks = [];
  List<IBFFormField> chunk = [];
  for (var i = 0; i < fields.length; i++) {
    if (chunk.length < maxNumberOfElements) {
      chunk.add(fields[i]);
      if (chunk.length == maxNumberOfElements) {
        chunks.add(chunk);
        chunk = [];
      } else if (i == fields.length - 1) {
        // This is the last element
        chunks.add(chunk);
      }
    }
  }

  return chunks;
}
