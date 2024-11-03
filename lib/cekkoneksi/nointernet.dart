import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  
  // Menyimpan referensi SnackBar
  SnackbarController? _snackBarController;
  
  // Flag untuk mengecek apakah SnackBar koneksi terputus sedang ditampilkan
  bool _isDisconnectedSnackbarVisible = false;

  @override
  void onInit() {
    super.onInit();
    // Mendengarkan perubahan konektivitas
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Jika mengeluarkan List, ambil hasil pertama
      if (results.isNotEmpty) {
        _updateConnectionStatus(results.first);
      }
    });
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // Tampilkan SnackBar jika tidak ada koneksi
      if (!_isDisconnectedSnackbarVisible) {
        _showSnackBar("Koneksi Terputus", "Silakan aktifkan internet Anda.", Colors.red);
        _isDisconnectedSnackbarVisible = true; // Tandai SnackBar sedang ditampilkan
      }
    } else {
      // Jika terhubung, hilangkan SnackBar
      _hideSnackBar();
      _showSnackBar("Koneksi Aktif", "Anda terhubung ke internet.", Colors.green);
      _isDisconnectedSnackbarVisible = false; // Reset status
    }
  }

  void _showSnackBar(String title, String message, Color color) {
    // Hilangkan SnackBar yang sudah ada
    _hideSnackBar();

    // Tampilkan SnackBar baru
    _snackBarController = Get.snackbar(
      title,
      message,
      backgroundColor: color,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      duration: Duration(days: 1), // Tampilkan SnackBar tanpa batas waktu
    );
  }

  void _hideSnackBar() {
    // Jika SnackBar sedang ditampilkan, hilangkan
    if (_snackBarController != null) {
      Get.back(); // Menghilangkan SnackBar dengan menggunakan Get.back()
      _snackBarController = null; // Reset controller SnackBar
    }
  }
}
