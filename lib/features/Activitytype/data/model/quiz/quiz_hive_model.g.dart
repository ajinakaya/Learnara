// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizHiveModelAdapter extends TypeAdapter<QuizHiveModel> {
  @override
  final int typeId = 7;

  @override
  QuizHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizHiveModel(
      quizId: fields[0] as String?,
      language: fields[1] as LanguageHiveModel,
      title: fields[2] as String,
      description: fields[3] as String,
      questions: (fields[4] as List).cast<QuizQuestionHiveModel>(),
      duration: fields[5] as int,
      difficulty: fields[6] as String,
      order: fields[7] as int,
      completionCriteria: fields[8] as QuizCompletionCriteriaHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, QuizHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.quizId)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.questions)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.difficulty)
      ..writeByte(7)
      ..write(obj.order)
      ..writeByte(8)
      ..write(obj.completionCriteria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuizQuestionHiveModelAdapter extends TypeAdapter<QuizQuestionHiveModel> {
  @override
  final int typeId = 9;

  @override
  QuizQuestionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizQuestionHiveModel(
      question: fields[0] as String,
      options: (fields[1] as List).cast<String>(),
      correctAnswer: fields[2] as String,
      explanation: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuizQuestionHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.correctAnswer)
      ..writeByte(3)
      ..write(obj.explanation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizQuestionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuizCompletionCriteriaHiveModelAdapter
    extends TypeAdapter<QuizCompletionCriteriaHiveModel> {
  @override
  final int typeId = 8;

  @override
  QuizCompletionCriteriaHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizCompletionCriteriaHiveModel(
      passingScore: fields[0] as int,
      attemptsAllowed: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuizCompletionCriteriaHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.passingScore)
      ..writeByte(1)
      ..write(obj.attemptsAllowed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizCompletionCriteriaHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
