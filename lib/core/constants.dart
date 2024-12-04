import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Priority { high, medium, low }

const priorityColor = {
  Priority.high: Color.fromRGBO(229, 115, 115, 1),
  Priority.medium: Color.fromRGBO(255, 204, 128, 1),
  Priority.low: Color.fromRGBO(129, 199, 132, 1),
};

const priorityIcon = {
  Priority.high: Icons.priority_high_rounded,
  Priority.medium: Icons.pending_actions_rounded,
  Priority.low: Icons.low_priority_rounded,
};

enum Status {completed, pending, incomplete}

const statusIcon = {
  Status.completed :  Icons.check,
  Status.pending :  Icons.pending_outlined,
  Status.incomplete :  Icons.warning_amber,
};

const statusColor = {
  Status.completed : Color.fromRGBO(129, 199, 132, 1),
  Status.pending :  Color.fromRGBO(255, 204, 128, 1),
  Status.incomplete : Color.fromRGBO(229, 115, 115, 1),
};