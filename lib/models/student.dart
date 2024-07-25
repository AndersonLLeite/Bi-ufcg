// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Student {
  String registration;
  String citizenId;
  String name;
  int age;
  String email;
  String gender;
  String maritalStatus;
  String nationality;
  String? placeOfBirth;
  String status;
  String statusTerm;
  String inactivityReason;
  String admissionType;
  String admissionTerm;
  String affirmativePolicy;
  String secondarySchoolType;
  String? secondarySchoolGraduationYear;
  String courseCode;
  String curriculumCode;
  bool active;
  bool alumnus;
  bool inactive;

  Student({
    required this.registration,
    required this.citizenId,
    required this.name,
    required this.age,
    required this.email,
    required this.gender,
    required this.maritalStatus,
    required this.nationality,
    this.placeOfBirth,
    required this.status,
    required this.statusTerm,
    required this.inactivityReason,
    required this.admissionType,
    required this.admissionTerm,
    required this.affirmativePolicy,
    required this.secondarySchoolType,
    this.secondarySchoolGraduationYear,
    required this.courseCode,
    required this.curriculumCode,
    required this.active,
    required this.alumnus,
    required this.inactive,
  });

  Student copyWith({
    String? registration,
    String? citizenId,
    String? name,
    int? age,
    String? email,
    String? gender,
    String? maritalStatus,
    String? nationality,
    String? placeOfBirth,
    String? status,
    String? statusTerm,
    String? inactivityReason,
    String? admissionType,
    String? admissionTerm,
    String? affirmativePolicy,
    String? secondarySchoolType,
    String? secondarySchoolGraduationYear,
    String? courseCode,
    String? curriculumCode,
    bool? active,
    bool? alumnus,
    bool? inactive,
  }) {
    return Student(
      registration: registration ?? this.registration,
      citizenId: citizenId ?? this.citizenId,
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      nationality: nationality ?? this.nationality,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      status: status ?? this.status,
      statusTerm: statusTerm ?? this.statusTerm,
      inactivityReason: inactivityReason ?? this.inactivityReason,
      admissionType: admissionType ?? this.admissionType,
      admissionTerm: admissionTerm ?? this.admissionTerm,
      affirmativePolicy: affirmativePolicy ?? this.affirmativePolicy,
      secondarySchoolType: secondarySchoolType ?? this.secondarySchoolType,
      secondarySchoolGraduationYear:
          secondarySchoolGraduationYear ?? this.secondarySchoolGraduationYear,
      courseCode: courseCode ?? this.courseCode,
      curriculumCode: curriculumCode ?? this.curriculumCode,
      active: active ?? this.active,
      alumnus: alumnus ?? this.alumnus,
      inactive: inactive ?? this.inactive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registration': registration,
      'citizenId': citizenId,
      'name': name,
      'age': age,
      'email': email,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'nationality': nationality,
      'placeOfBirth': placeOfBirth,
      'status': status,
      'statusTerm': statusTerm,
      'inactivityReason': inactivityReason,
      'admissionType': admissionType,
      'admissionTerm': admissionTerm,
      'affirmativePolicy': affirmativePolicy,
      'secondarySchoolType': secondarySchoolType,
      'secondarySchoolGraduationYear': secondarySchoolGraduationYear,
      'courseCode': courseCode,
      'curriculumCode': curriculumCode,
      'active': active,
      'alumnus': alumnus,
      'inactive': inactive,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      registration: map['registration'] as String,
      citizenId: map['citizenId'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
      gender: map['gender'] as String,
      maritalStatus: map['maritalStatus'] as String,
      nationality: map['nationality'] as String,
      placeOfBirth: map['placeOfBirth'] as String?,
      status: map['status'] as String,
      statusTerm: map['statusTerm'] as String,
      inactivityReason: map['inactivityReason'] as String,
      admissionType: map['admissionType'] as String,
      admissionTerm: map['admissionTerm'] as String,
      affirmativePolicy: map['affirmativePolicy'] as String,
      secondarySchoolType: map['secondarySchoolType'] as String,
      secondarySchoolGraduationYear:
          map['secondarySchoolGraduationYear'] as String?,
      courseCode: map['courseCode'] as String,
      curriculumCode: map['curriculumCode'] as String,
      active: map['active'] as bool,
      alumnus: map['alumnus'] as bool,
      inactive: map['inactive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return 'Student(registration: $registration, citizenId: $citizenId, name: $name, age: $age, email: $email, gender: $gender, maritalStatus: $maritalStatus, nationality: $nationality, placeOfBirth: $placeOfBirth, status: $status, statusTerm: $statusTerm, inactivityReason: $inactivityReason, admissionType: $admissionType, admissionTerm: $admissionTerm, affirmativePolicy: $affirmativePolicy, secondarySchoolType: $secondarySchoolType, secondarySchoolGraduationYear: $secondarySchoolGraduationYear, courseCode: $courseCode, curriculumCode: $curriculumCode, active: $active, alumnus: $alumnus, inactive: $inactive)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.registration == registration &&
        other.citizenId == citizenId &&
        other.name == name &&
        other.age == age &&
        other.email == email &&
        other.gender == gender &&
        other.maritalStatus == maritalStatus &&
        other.nationality == nationality &&
        other.placeOfBirth == placeOfBirth &&
        other.status == status &&
        other.statusTerm == statusTerm &&
        other.inactivityReason == inactivityReason &&
        other.admissionType == admissionType &&
        other.admissionTerm == admissionTerm &&
        other.affirmativePolicy == affirmativePolicy &&
        other.secondarySchoolType == secondarySchoolType &&
        other.secondarySchoolGraduationYear == secondarySchoolGraduationYear &&
        other.courseCode == courseCode &&
        other.curriculumCode == curriculumCode &&
        other.active == active &&
        other.alumnus == alumnus &&
        other.inactive == inactive;
  }

  @override
  int get hashCode {
    return registration.hashCode ^
        citizenId.hashCode ^
        name.hashCode ^
        age.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        maritalStatus.hashCode ^
        nationality.hashCode ^
        placeOfBirth.hashCode ^
        status.hashCode ^
        statusTerm.hashCode ^
        inactivityReason.hashCode ^
        admissionType.hashCode ^
        admissionTerm.hashCode ^
        affirmativePolicy.hashCode ^
        secondarySchoolType.hashCode ^
        secondarySchoolGraduationYear.hashCode ^
        courseCode.hashCode ^
        curriculumCode.hashCode ^
        active.hashCode ^
        alumnus.hashCode ^
        inactive.hashCode;
  }
}
