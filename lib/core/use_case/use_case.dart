import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart'; 
abstract class UseCase<Entity, Params> {

  Future<Either<String, Entity>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}




