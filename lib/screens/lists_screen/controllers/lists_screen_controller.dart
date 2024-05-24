import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/core/models/taskModel.dart';

import '../../../core/classes/controller_mixin.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../core/models/listModel.dart';
import '../../../core/routes/app_routes.dart';

class ListsScreenController extends GetxController with ControllerMixin {}
