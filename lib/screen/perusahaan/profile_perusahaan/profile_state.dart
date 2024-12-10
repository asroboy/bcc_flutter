import 'package:flutter/material.dart';

class ProfileState extends InheritedWidget {
  const ProfileState({
    super.key,
    required this.data,
    required super.child,
  });

  final dynamic data;

  static ProfileState of(BuildContext context) {
    // This method looks for the nearest `MyState` widget ancestor.
    final result = context.dependOnInheritedWidgetOfExactType<ProfileState>();

    assert(result != null, 'No ProfileState found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(ProfileState oldWidget) => data != oldWidget.data;
}
