import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnara/features/home/presentation/view/bottom_view/dashboard_view.dart';

class Goal {
  String goal;
  List<Level> levels;

  Goal({required this.goal, required this.levels});
}

class Level {
  String level;
  String description;

  Level({required this.level, required this.description});
}

class GoalController extends GetxController {
  var goals = <Goal>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchGoals();
  }

  void fetchGoals() {
    // goals.addAll([
    //   Goal(goal: "Learn Japanese", levels: [
    //     Level(level: "Beginner", description: "Basic learning "),
    //
    //   ]),
    //   Goal(goal: "Learn chinese", levels: [
    //     Level(level: "Phase 1", description: "Flashcard"),
    //
    //   ]),
    // ]);
  }

  void addGoal(String title, List<Level> levels) {
    goals.add(Goal(goal: title, levels: levels));
  }
}

class GoalScreen extends StatefulWidget {
  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final GoalController controller = Get.put(GoalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Goal Management"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DashboardView()),
            );
          },
        ),
      ),
      body: Obx(() {
        if (controller.goals.isEmpty) {
          return Center(child: Text("No goals found. Add a goal."));
        }
        return ListView.builder(
          itemCount: controller.goals.length,
          itemBuilder: (context, index) {
            final goal = controller.goals[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(goal.goal, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: goal.levels
                      .map((level) => Text("Level ${level.level}: ${level.description}"))
                      .toList(),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGoalDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    final TextEditingController goalController = TextEditingController();
    final TextEditingController levelController = TextEditingController();
    final List<Level> levels = [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create Goal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: goalController,
                decoration: InputDecoration(labelText: "Goal Title"),
              ),
              TextField(
                controller: levelController,
                decoration: InputDecoration(labelText: "Level Description"),
              ),
              ElevatedButton(
                onPressed: () {
                  levels.add(Level(level: "Custom", description: levelController.text));
                  levelController.clear();
                },
                child: Text("Add Level"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (goalController.text.isNotEmpty) {
                  controller.addGoal(goalController.text, levels);
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}