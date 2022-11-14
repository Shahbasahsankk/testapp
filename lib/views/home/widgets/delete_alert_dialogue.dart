import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../providers/home_provider.dart';

class DeleteDialogue {
  deleteDialougue(context, id, HomeProvider searchProvider, text) {
    return AlertDialog(
      content: const Text('File will be Permenently deleted, Continue?'),
      actions: [
        TextButton(
          onPressed: () {
            searchProvider.delete(id);
            searchProvider.searchStudent(text);
            Fluttertoast.showToast(
                msg: 'User Deleted', backgroundColor: Colors.red);
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        )
      ],
    );
  }
}
