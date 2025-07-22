// lib/core/database/models/document_type.dart
import 'package:drift/drift.dart';

// --- ENUMS ---
// Define all possible main and sub types

enum MainType {
  identification,
  vehicle,
  financial,
  travel,
  legal,
  medical,
  other,
}

enum SubType {
  // Identification
  passport,
  nationalId,
  driversLicense,
  birthCertificate,
  
  // Vehicle
  carRegistration,
  carInsurance,
  
  // Financial
  creditCard,
  bankStatement,
  taxDocument,
  
  // Travel
  visa,
  boardingPass,
  hotelReservation,

  // ... add all other subtypes
  genericDocument, // A fallback for "other"
}

// --- HIERARCHY MAPPING ---
// This map is the "brain" that connects the enums. It's the single source of truth.
const Map<MainType, List<SubType>> documentTypeHierarchy = {
  MainType.identification: [
    SubType.passport,
    SubType.nationalId,
    SubType.driversLicense,
    SubType.birthCertificate,
  ],
  MainType.vehicle: [
    SubType.driversLicense, // Note: a subtype can belong to multiple main types
    SubType.carRegistration,
    SubType.carInsurance,
  ],
  MainType.financial: [
    SubType.creditCard,
    SubType.bankStatement,
    SubType.taxDocument,
  ],
  MainType.travel: [
    SubType.passport,
    SubType.visa,
    SubType.boardingPass,
    SubType.hotelReservation,
  ],
  MainType.legal: [], // Populate as needed
  MainType.medical: [], // Populate as needed
  MainType.other: [
    SubType.genericDocument,
  ],
};


// --- DRIFT TYPE CONVERTERS ---
// Boilerplate to allow Drift to store our enums as strings.

class MainTypeConverter extends TypeConverter<MainType, String> {
  const MainTypeConverter();
  @override
  MainType fromSql(String fromDb) => MainType.values.byName(fromDb);
  @override
  String toSql(MainType value) => value.name;
}

class SubTypeConverter extends TypeConverter<SubType, String> {
  const SubTypeConverter();
  @override
  SubType fromSql(String fromDb) => SubType.values.byName(fromDb);
  @override
  String toSql(SubType value) => value.name;
}