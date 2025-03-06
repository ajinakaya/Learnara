import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Update this import path to match your project structure
import 'package:learnara/features/home/presentation/view_model/home_state.dart';

void main() {
  group('HomeState Tests', () {
    test('initial method should create default state', () {
      final state = HomeState.initial();
      
      expect(state.selectedIndex, 0);
      expect(state.views.length, 5);
      expect(state.views[0], isA<Center>());
      expect((state.views[0] as Center).child, isA<Text>());
      expect(((state.views[0] as Center).child as Text).data, 'Dashboard');
    });
    
    test('copyWith should only change specified properties', () {
      final initialState = HomeState.initial();
      final newViews = [
        const Center(child: Text('New View')),
      ];
      
      // Change only selectedIndex
      final stateWithNewIndex = initialState.copyWith(selectedIndex: 2);
      expect(stateWithNewIndex.selectedIndex, 2);
      expect(stateWithNewIndex.views, initialState.views);
      
      // Change only views
      final stateWithNewViews = initialState.copyWith(views: newViews);
      expect(stateWithNewViews.selectedIndex, initialState.selectedIndex);
      expect(stateWithNewViews.views, newViews);
      expect(stateWithNewViews.views.length, 1);
      
      // Change both properties
      final stateWithBothChanged = initialState.copyWith(
        selectedIndex: 3,
        views: newViews,
      );
      expect(stateWithBothChanged.selectedIndex, 3);
      expect(stateWithBothChanged.views, newViews);
    });
    
    test('props should contain all properties for equality comparison', () {
      final state1 = HomeState.initial();
      final state2 = HomeState.initial();
      final state3 = state1.copyWith(selectedIndex: 1);
      
      // Same states should be equal
      expect(state1, state2);
      
      // Different states should not be equal
      expect(state1, isNot(state3));
      
      // Verify props contains all properties
      expect(state1.props.length, 2);
      expect(state1.props.contains(state1.selectedIndex), true);
      expect(state1.props.contains(state1.views), true);
    });
    
    test('two instances with same values should be equal', () {
      final views1 = [
        const Center(child: Text('Test')),
      ];
      final views2 = [
        const Center(child: Text('Test')),
      ];
      
      final state1 = HomeState(selectedIndex: 1, views: views1);
      final state2 = HomeState(selectedIndex: 1, views: views2);
      
      // Even though views1 and views2 are different instances,
      // Equatable should consider them equal based on their values
      expect(state1, state2);
    });
  });
}