import 'package:keyboard/core/abstracts/consumer.dart';

abstract class IRepository {
  final Consumer consumer;

  const IRepository(this.consumer);
}