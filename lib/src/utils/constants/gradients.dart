import 'colors.dart';
import 'package:flutter/material.dart';

const kRedGradient = RadialGradient(
    center: Alignment.bottomRight, radius: 2, colors: [kLightRed, kDarkRed]);

const kBlueGradient = LinearGradient(
    colors: [kDarkBlue, kLightBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

const kGreyGradient = LinearGradient(
    colors: [Colors.grey, Colors.white],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);
