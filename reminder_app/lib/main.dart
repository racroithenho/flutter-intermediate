import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  // Khởi tạo plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(ReminderApp(plugin: flutterLocalNotificationsPlugin));
}

class ReminderApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin plugin;
  const ReminderApp({Key? key, required this.plugin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ReminderHome(plugin: plugin),
    );
  }
}

class ReminderHome extends StatefulWidget {
  final FlutterLocalNotificationsPlugin plugin;
  const ReminderHome({Key? key, required this.plugin}) : super(key: key);

  @override
  State<ReminderHome> createState() => _ReminderHomeState();
}

class _ReminderHomeState extends State<ReminderHome> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDateTime;
  final List<Map<String, dynamic>> _reminders = [];

  Future<void> _scheduleNotification() async {
    if (_selectedDateTime == null || _titleController.text.isEmpty) return;

    final int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await widget.plugin.zonedSchedule(
      id,
      'Reminder',
      _titleController.text,
      tz.TZDateTime.from(_selectedDateTime!, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    setState(() {
      _reminders.add({
        'title': _titleController.text,
        'time': _selectedDateTime,
      });
      _titleController.clear();
      _selectedDateTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reminder scheduled!')),
    );
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminder App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Reminder Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDateTime == null
                        ? 'No time selected'
                        : DateFormat('yyyy-MM-dd – HH:mm')
                            .format(_selectedDateTime!),
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickDateTime,
                  child: const Text('Pick Time'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _scheduleNotification,
              icon: const Icon(Icons.alarm_add),
              label: const Text('Set Reminder'),
            ),
            const Divider(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final item = _reminders[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.notifications_active),
                      title: Text(item['title']),
                      subtitle: Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(item['time']),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
