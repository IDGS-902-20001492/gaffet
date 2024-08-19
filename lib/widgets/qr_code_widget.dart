import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget generateQrCode(String data) {
  return Container(
    child: QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 250.0,
    ),
  );
}
