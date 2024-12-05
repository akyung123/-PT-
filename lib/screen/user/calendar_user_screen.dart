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
        title: Text('Add Exercise Routine'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => exerciseName = value,
              decoration: InputDecoration(hintText: "Enter exercise name"),
            ),
            SizedBox(height: 16),
            _buildNumberInputRow(
                "Weight (kg)", weight, (value) => weight = value),
            _buildNumberInputRow("Reps", reps, (value) => reps = value),
            _buildNumberInputRow("Sets", sets, (value) => sets = value),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
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
            child: Text('Add'),
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
        Text(label),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.do_not_disturb_on),
              onPressed: () {
                int newValue = (int.parse(controller.text) - 5)
                    .clamp(0, double.infinity)
                    .toInt();
                controller.text = newValue.toString();
                onChanged(newValue);
              },
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                int newValue = (int.parse(controller.text) - 1)
                    .clamp(0, double.infinity)
                    .toInt();
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
                onChanged: (value) =>
                    onChanged(int.tryParse(value) ?? initialValue),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                int newValue = (int.parse(controller.text) + 1).toInt();
                controller.text = newValue.toString();
                onChanged(newValue);
              },
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                int newValue = (int.parse(controller.text) + 5).toInt();
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
        title: const Text('Calendar User Screen'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          TableCalendar(
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
                        const Icon(Icons.fitness_center, color: Colors.purple),
                    title: Text(routine['exercise'] ?? ''),
                    subtitle: Text(routine['details'] ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
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
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
