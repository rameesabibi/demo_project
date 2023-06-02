import 'package:flutter/material.dart';

class KoleksiData {
  final String nama;
  final int bilangan;
  final Color? warna;

  KoleksiData(
      {required this.nama, required this.bilangan, required this.warna});

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'bilangan': bilangan,
      'warna': warna,
    };
  }

  factory KoleksiData.fromMap(Map<String, dynamic> map) {
    return KoleksiData(
        nama: map['nama'] as String,
        bilangan: map['bilangan'] as int,
        warna: Color(map['warna']));
  }
}