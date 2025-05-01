import '../entities/vacancy.dart';

abstract class VacancyRepository {
  Future<void> createVacancy();
  Future<void> updateVacancy();
  Future<List<Vacancy>> getAllVacancies();
  Future<Vacancy?> getVacancyById(String vacancyId);
}