import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppExceptions {
  static void errorHandler(Object e) {
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout) {
        Fluttertoast.showToast(
            msg: 'Connection timed out', backgroundColor: Colors.red);
      } else if (e.type == DioErrorType.receiveTimeout) {
        Fluttertoast.showToast(
            msg: 'Server recieve timedout', backgroundColor: Colors.red);
      } else if (e.type == DioErrorType.cancel) {
        Fluttertoast.showToast(
            msg: 'Request cancelled', backgroundColor: Colors.red);
      } else if (e.type == DioErrorType.sendTimeout) {
        Fluttertoast.showToast(
            msg: 'Request timed out', backgroundColor: Colors.red);
      } else if (e.error is SocketException) {
        Fluttertoast.showToast(
            msg: 'No internet Connection', backgroundColor: Colors.red);
      } else if (e.type == DioErrorType.other) {
        Fluttertoast.showToast(
            msg: 'Something went wrong', backgroundColor: Colors.red);
      }
    }
  }
}
