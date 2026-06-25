import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';
import 'package:intl/intl.dart';

class TrackingHistoryScreen extends StatefulWidget {
  const TrackingHistoryScreen({super.key});

  @override
  State<TrackingHistoryScreen> createState() => _TrackingHistoryScreenState();
}

class _TrackingHistoryScreenState extends State<TrackingHistoryScreen> {
  String _selectedDateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Stream<QuerySnapshot<Map<String, dynamic>>>? _historyStream(String uid) {
    return FirebaseFirestore.instance
        .collection('active_vehicles')
        .doc(uid)
        .collection('tracking_history')
        .orderBy('timestamp', descending: true)
        .limit(300)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final currentUid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(20.h),
              _headerRow(context),
              UIHelper.verticalSpace(24.h),
              if (currentUid == null)
                const Expanded(
                  child: Center(child: Text('Driver not logged in!')),
                )
              else
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _historyStream(currentUid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Failed to load tracking history.'),
                        );
                      }

                      final docs = snapshot.data?.docs ?? [];
                      final availableDateKeys = _availableDateKeys(docs);

                      if (availableDateKeys.isNotEmpty &&
                          !availableDateKeys.contains(_selectedDateKey)) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(
                              () => _selectedDateKey = availableDateKeys.first,
                            );
                          }
                        });
                      }

                      final selectedDocs = docs.where((doc) {
                        final data = doc.data();
                        return data['dateKey']?.toString() == _selectedDateKey;
                      }).toList();

                      return Column(
                        children: [
                          _dateDropdown(availableDateKeys),
                          UIHelper.verticalSpace(24.h),
                          Expanded(
                            child: selectedDocs.isEmpty
                                ? _emptyState(availableDateKeys.isEmpty)
                                : _historyList(selectedDocs),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerRow(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: const Color(0xFF1A1A1A),
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const Spacer(),
        Text(
          'Tracking History',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const Spacer(),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _dateDropdown(List<String> dateKeys) {
    final items = dateKeys.isEmpty ? [_selectedDateKey] : dateKeys;
    final value = items.contains(_selectedDateKey)
        ? _selectedDateKey
        : items.first;

    return DropdownButtonFormField<String>(
      initialValue: value,
      dropdownColor: AppColors.cFFFFFF,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: const Color(0xFF7F8C8D),
        size: 22.sp,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: const Color(0xFF5F6368),
          size: 18.sp,
        ),
        filled: true,
        fillColor: AppColors.cFFFFFF,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFFE9ECEF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF2F6BFF)),
        ),
      ),
      style: TextStyle(
        fontSize: 14.sp,
        color: const Color(0xFF1A1A1A),
        fontWeight: FontWeight.w600,
      ),
      items: items.map((dateKey) {
        return DropdownMenuItem<String>(
          value: dateKey,
          child: Text(_formatDateLabel(dateKey)),
        );
      }).toList(),
      onChanged: dateKeys.isEmpty
          ? null
          : (value) {
              if (value == null) return;
              setState(() => _selectedDateKey = value);
            },
    );
  }

  Widget _historyList(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return ListView.builder(
      itemCount: docs.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index].data();
        final isLast = index == docs.length - 1;
        final isTop = index == 0;

        return IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: isTop
                          ? const Color(0xFF2F6BFF)
                          : const Color(0xFF27AE60),
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 1.5.w,
                        color: const Color(0xFFE9ECEF),
                      ),
                    ),
                ],
              ),
              UIHelper.horizontalSpace(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatTime(item['timestamp']),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                        Text(
                          'Speed: ${item['speed']?.toString() ?? '0 km/h'}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7F8C8D),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(4.h),
                    Text(
                      _formatLocation(item),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF5F6368),
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    if (!isLast)
                      const Divider(color: Color(0xFFF8F9FA), thickness: 1),
                    UIHelper.verticalSpace(8.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyState(bool hasNoHistoryYet) {
    return Center(
      child: Text(
        hasNoHistoryYet
            ? 'No tracking history found. Start tracking to create history.'
            : 'No tracking data found for this date.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF5F6368),
        ),
      ),
    );
  }

  List<String> _availableDateKeys(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final keys = <String>[];
    for (final doc in docs) {
      final key = doc.data()['dateKey']?.toString();
      if (key != null && key.isNotEmpty && !keys.contains(key)) {
        keys.add(key);
      }
    }
    return keys;
  }

  String _formatDateLabel(String dateKey) {
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(dateKey));
    } catch (_) {
      return dateKey;
    }
  }

  String _formatTime(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return DateFormat('hh:mm a').format(timestamp.toDate());
    }
    return '--:--';
  }

  String _formatLocation(Map<String, dynamic> item) {
    final latitude = (item['latitude'] as num?)?.toDouble();
    final longitude = (item['longitude'] as num?)?.toDouble();

    if (latitude == null || longitude == null) {
      return 'Location unavailable';
    }

    return 'Lat: ${latitude.toStringAsFixed(5)}, Lng: ${longitude.toStringAsFixed(5)}';
  }
}
