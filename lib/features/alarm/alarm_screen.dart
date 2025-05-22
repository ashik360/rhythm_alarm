import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:rhythm_alarm/constants/app_constants.dart';
import 'package:rhythm_alarm/features/alarm/alarm_card_widget.dart';

class AlarmScreen extends StatefulWidget {
  final String location;
  const AlarmScreen({super.key, required this.location});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final List<DateTime> _alarms = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showToggleNotification(bool isOn) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'toggle_channel',
          'Toggle Notifications',
          channelDescription: 'Shows when alarm is toggled on/off',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      isOn ? 0 : 1,
      isOn ? 'Alarm Activated' : 'Alarm Deactivated',
      isOn ? 'Your alarm is now active' : 'Your alarm has been turned off',
      notificationDetails,
    );
  }

  Future<void> _showNewAlarmNotification(DateTime alarmTime) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'new_alarm_channel',
          'New Alarm Notifications',
          channelDescription: 'Shows when new alarm is created',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      alarmTime.millisecondsSinceEpoch ~/ 1000,
      'New Alarm Set',
      'Alarm set for ${alarmTime.hour}:${alarmTime.minute.toString().padLeft(2, '0')}',
      notificationDetails,
    );
  }

  void _addAlarm(DateTime newAlarm) {
    setState(() {
      _alarms.add(newAlarm);
    });
    _showNewAlarmNotification(newAlarm);
  }

  Future<void> _showDateTimePicker() async {
    final DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      isForce2Digits: true,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    );

    if (dateTime != null) {
      _addAlarm(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.selectedLoc,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(AppImages.location, width: 30),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.location.isNotEmpty
                                  ? widget.location
                                  : 'Location not available',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _showDateTimePicker,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.nightGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          AppStrings.addAlarm,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppStrings.alarm,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _alarms.isNotEmpty
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _alarms.length,
                      itemBuilder: (context, index) {
                        final alarm = _alarms[index];
                        String formattedTime =
                            "${alarm.hour.toString().padLeft(2, '0')}:${alarm.minute.toString().padLeft(2, '0')}";
                        String formattedDate =
                            "${alarm.day}/${alarm.month}/${alarm.year}";

                        return AlarmCardWidget(
                          timeString: formattedTime,
                          dateString: formattedDate,
                          initialToggleValue: true,
                          onToggle: (isOn) {
                            _showToggleNotification(isOn);
                          },
                        );
                      },
                    )
                    : SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          0.4, // adjust as needed
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.alarm_off_rounded,
                              size: 90,
                              color: AppColors.white,
                            ),
                            Text(
                              "No Alarm Found!!",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
