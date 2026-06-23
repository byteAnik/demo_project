import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gps_tracking_system_app/helpers/di.dart';

class CustomerProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _defaultCustomers = [
    {
      "avatarText": "আ",
      "name": "আলী সিকদার",
      "phone": "+880 1744 888 999",
      "statusText": "৭ দিন ওভারডিউ",
      "amount": "৳5,100",
      "amountLabel": "বকেয়া",
      "isPaid": false,
      "imagePath": "",
      "address": "",
      "note": "",
    },
    {
      "avatarText": "রহ",
      "name": "রহিম মিয়া",
      "phone": "+880 1712 345 678",
      "statusText": "৩ দিন বাকি",
      "amount": "৳3,450",
      "amountLabel": "বকেয়া",
      "isPaid": false,
      "imagePath": "",
      "address": "",
      "note": "",
    },
    {
      "avatarText": "না",
      "name": "নাজমা বেগম",
      "phone": "+880 1922 111 222",
      "statusText": "",
      "amount": "৳1,200",
      "amountLabel": "বকেয়া",
      "isPaid": false,
      "imagePath": "",
      "address": "",
      "note": "",
    },
    {
      "avatarText": "সু",
      "name": "সুমন আহমেদ",
      "phone": "+880 1819 000 001",
      "statusText": "পরিশোধ",
      "amount": "৳0",
      "amountLabel": "ক্লিয়ার",
      "isPaid": true,
      "imagePath": "",
      "address": "",
      "note": "",
    },
    {
      "avatarText": "কা",
      "name": "কামাল হোসেন",
      "phone": "+880 1600 555 777",
      "statusText": "",
      "amount": "৳800",
      "amountLabel": "বকেয়া",
      "isPaid": false,
      "imagePath": "",
      "address": "",
      "note": "",
    },
  ];

  List<Map<String, dynamic>> _customers = [];

  List<Map<String, dynamic>> get customers => _customers;

  CustomerProvider() {
    loadCustomers();
  }

  void loadCustomers() {
    try {
      final stored = appData.read<String>('saved_customers');
      if (stored != null) {
        final List<dynamic> decoded = jsonDecode(stored);
        _customers = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        _customers = List.from(_defaultCustomers);
      }
    } catch (e) {
      _customers = List.from(_defaultCustomers);
    }
    notifyListeners();
  }

  void addCustomer(Map<String, dynamic> customer) {
    _customers.insert(0, customer);
    saveToStorage();
    notifyListeners();
  }

  void saveToStorage() {
    try {
      appData.write('saved_customers', jsonEncode(_customers));
    } catch (e) {
      // Handle errors silently
    }
  }
}
