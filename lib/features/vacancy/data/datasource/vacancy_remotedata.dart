abstract class VacancyRemoteData{}


class VacancyRemoteDataImpl implements VacancyRemoteData {
  // final FirebaseFirestore firestore;
  // VacancyRemoteDataImpl({required this.firestore});

  // @override
  // Future<void> createVacancy(Vacancy vacancy) async {
  //   await firestore.collection('vacancies').add(vacancy.toJson());
  // }

  // @override
  // Future<void> updateVacancy(Vacancy vacancy) async {
  //   await firestore.collection('vacancies').doc(vacancy.id).update(vacancy.toJson());
  // }

  // @override
  // Future<List<Vacancy>> getAllVacancies() async {
  //   final snapshot = await firestore.collection('vacancies').get();
  //   return snapshot.docs.map((doc) => Vacancy.fromJson(doc.data())).toList();
  // }

  // @override
  // Future<Vacancy?> getVacancyById(String vacancyId) async {
  //   final doc = await firestore.collection('vacancies').doc(vacancyId).get();
  //   return doc.exists ? Vacancy.fromJson(doc.data()) : null;
  // }
}