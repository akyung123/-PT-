import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../services/exercise_routine_manager.dart';

class CalendarUserScreen extends StatefulWidget {
  final DateTime initialDate;

  const CalendarUserScreen({Key? key, required this.initialDate})
      : super(key: key);

  @override
  _CalendarUserScreenState createState() => _CalendarUserScreenState();
}

class _CalendarUserScreenState extends State<CalendarUserScreen> {
  late DateTime _selectedDate;
  List<Map<String, String>> _exerciseRoutines = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _loadRoutines();
  }

  Future<void> _loadRoutines() async {
    await ExerciseRoutineManager.loadExerciseRoutines();
    setState(() {
      _exerciseRoutines =
          ExerciseRoutineManager.getRoutinesForDate(_selectedDate);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _exerciseRoutines =
          ExerciseRoutineManager.getRoutinesForDate(_selectedDate);
    });
  }

  Future<void> _showAddRoutineDialog() async {
    String exerciseName = '';
    int weight = 0;
    int reps = 0;
    int sets = 0;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add Exercise Routine',
          style: TextStyle(color: Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => exerciseName = value,
              decoration: const InputDecoration(
                hintText: "Enter exercise name",
                hintStyle: TextStyle(color: Colors.grey),
                border: UnderlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16),
            _buildNumberInputRow("Weight (kg)", weight, (value) => weight = value),
            _buildNumberInputRow("Reps", reps, (value) => reps = value),
            _buildNumberInputRow("Sets", sets, (value) => sets = value),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              if (exerciseName.isNotEmpty) {
                ExerciseRoutineManager.addRoutine(
                    _selectedDate, exerciseName, weight, reps, sets);
                setState(() {});
              }
              Navigator.pop(context);
            },
            child: const Text('Add', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberInputRow(
      String label, int initialValue, Function(int) onChanged) {
    TextEditingController controller =
        TextEditingController(text: initialValue.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.black),
              onPressed: () {
                int newValue = (int.parse(controller.text) - 1).clamp(0, double.infinity).toInt();
                controller.text = newValue.toString();
                onChanged(newValue);
              },
            ),
            Container(
              width: 40,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  isDense: true,
                  border: UnderlineInputBorder(),
                ),
                onChanged: (value) =>
                    onChanged(int.tryParse(value) ?? initialValue),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                int newValue = (int.parse(controller.text) + 1).toInt();
                controller.text = newValue.toString();
                onChanged(newValue);
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> routines =
        ExerciseRoutineManager.getRoutinesForDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          TableCalendar(
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
              weekendTextStyle: const TextStyle(color: Colors.black),
              defaultTextStyle: const TextStyle(color: Colors.black),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.grey),
              weekdayStyle: TextStyle(color: Colors.black),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
            ),
            calendarFormat: CalendarFormat.month,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDate,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: _onDaySelected,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: routines.length,
              itemBuilder: (context, index) {
                final routine = routines[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading:
                        const Icon(Icons.fitness_center, color: Colors.black),
                    title: Text(
                      routine['exercise'] ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      routine['details'] ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        ExerciseRoutineManager.deleteRoutine(
                            _selectedDate, index);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoutineDialog,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
