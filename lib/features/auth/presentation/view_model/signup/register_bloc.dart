import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:learnara/core/common/snack_bar/my_snackbar.dart';
import 'package:learnara/features/auth/domain/usecase/register_usecase.dart';
import 'package:learnara/features/auth/domain/usecase/upload_image_usecase.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterBloc({
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  :_registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<UploadImage>(_onLoadImage);

  }


  void _onRegisterEvent(
      RegisterUser event,
      Emitter<RegisterState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      fullname: event.fullname,
      email: event.email,
      image:event.image,
      username: event.username,
      password: event.password,
    ));

    result.fold(
          (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
          (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }
  void _onLoadImage(
      UploadImage event,
      Emitter<RegisterState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
          (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
          (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
