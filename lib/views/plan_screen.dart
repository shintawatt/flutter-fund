import '../models/data_layer.dart';
import '../provider/plan_provider.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;

  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => PlanScreenState();
}

class PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  Plan get _plan => widget.plan;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(_plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          Plan currentPlan = plans.firstWhere(
            (p) => p.name == _plan.name,
            orElse: () => _plan,
          );
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Plan currentPlan = _plan;
        int planIndex = planNotifier.value.indexWhere(
          (p) => p.name == currentPlan.name,
        );
        List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
          ..add(const Task());

        List<Plan> updatedPlans = List<Plan>.from(planNotifier.value);
        updatedPlans[planIndex] = Plan(
          name: currentPlan.name,
          tasks: updatedTasks,
        );

        planNotifier.value = updatedPlans;
      },
    );
  }

  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior: Theme.of(context).platform == TargetPlatform.iOS
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(plan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          Plan currentPlan = _plan;
          int planIndex = planNotifier.value.indexWhere(
            (p) => p.name == currentPlan.name,
          );

          List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
            ..[index] = Task(
              description: task.description,
              complete: selected ?? false,
            );

          List<Plan> updatedPlans = List<Plan>.from(planNotifier.value);
          updatedPlans[planIndex] = Plan(
            name: currentPlan.name,
            tasks: updatedTasks,
          );

          planNotifier.value = updatedPlans;
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          Plan currentPlan = _plan;
          int planIndex = planNotifier.value.indexWhere(
            (p) => p.name == currentPlan.name,
          );

          List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
            ..[index] = Task(
              description: text,
              complete: task.complete,
            );

          List<Plan> updatedPlans = List<Plan>.from(planNotifier.value);
          updatedPlans[planIndex] = Plan(
            name: currentPlan.name,
            tasks: updatedTasks,
          );

          planNotifier.value = updatedPlans;
        },
      ),
    );
  }
}