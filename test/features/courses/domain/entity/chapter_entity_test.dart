import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';

void main() {
  group('ChapterEntity Tests', () {
    // Mock data for testing
    const String id = 'chapter-123';
    const String title = 'Introduction to Flutter';
    const String description = 'Learn the basics of Flutter framework';
    const int order = 1;
    final PreferredLanguageEntity language = PreferredLanguageEntity(
      languageId: 'en-US',
      languageName: 'English',
      languageImage: 'assets/images/en_flag.png',
    );
    final List<String> learningObjectives = [
      'Understand Flutter basics',
      'Create simple Flutter app',
    ];
    const int estimatedDuration = 60; // minutes
    const String status = 'draft';
    final List<SubLessonEntity> subLessons = []; // Empty for simplicity
    final List<ChapterEntity> prerequisites = []; // Empty for simplicity

    test('should create entity with correct properties', () {
      final chapter = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      expect(chapter.id, id);
      expect(chapter.title, title);
      expect(chapter.description, description);
      expect(chapter.order, order);
      expect(chapter.language, language);
      expect(chapter.learningObjectives, learningObjectives);
      expect(chapter.estimatedDuration, estimatedDuration);
      expect(chapter.status, status);
      expect(chapter.subLessons, subLessons);
      expect(chapter.prerequisites, prerequisites);
    });

    test('should create entity with default status when not provided', () {
      final chapter = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      expect(chapter.status, 'draft');
    });

    test('props should contain all properties for equality comparison', () {
      final chapter = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      expect(chapter.props.length, 10);
      expect(chapter.props.contains(id), true);
      expect(chapter.props.contains(title), true);
      expect(chapter.props.contains(description), true);
      expect(chapter.props.contains(order), true);
      expect(chapter.props.contains(language), true);
      expect(chapter.props.contains(learningObjectives), true);
      expect(chapter.props.contains(estimatedDuration), true);
      expect(chapter.props.contains(status), true);
      expect(chapter.props.contains(subLessons), true);
      expect(chapter.props.contains(prerequisites), true);
    });

    test('entities with same values should be equal', () {
      final chapter1 = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      final chapter2 = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      expect(chapter1, chapter2);
    });

    test('entities with different values should not be equal', () {
      final chapter1 = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      final chapter2 = ChapterEntity(
        id: 'different-id',
        title: 'Different Title',
        description: 'Different description',
        order: 2,
        language: PreferredLanguageEntity(
          languageId: 'fr-FR',
          languageName: 'French',
          languageImage: 'assets/images/fr_flag.png',
        ),
        learningObjectives: ['Different objective'],
        estimatedDuration: 90,
        status: 'published',
        subLessons: [],
        prerequisites: [],
      );

      expect(chapter1, isNot(chapter2));
    });

    test('entities with one different property should not be equal', () {
      final baseChapter = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      final differentId = ChapterEntity(
        id: 'different-id',
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      final differentTitle = ChapterEntity(
        id: id,
        title: 'Different Title',
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      final differentOrder = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: 2,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: status,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      final differentStatus = ChapterEntity(
        id: id,
        title: title,
        description: description,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        estimatedDuration: estimatedDuration,
        status: 'published',
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      expect(baseChapter, isNot(differentId));
      expect(baseChapter, isNot(differentTitle));
      expect(baseChapter, isNot(differentOrder));
      expect(baseChapter, isNot(differentStatus));
    });

    test('should handle null optional fields', () {
      final chapter = ChapterEntity(
        title: title,
        order: order,
        language: language,
        learningObjectives: learningObjectives,
        subLessons: subLessons,
        prerequisites: prerequisites,
      );

      expect(chapter.id, isNull);
      expect(chapter.description, isNull);
      expect(chapter.estimatedDuration, isNull);
      expect(chapter.status, 'draft');
    });
  });
}