// lib/features/documents/presentation/helpers/custom_fields_definitions.dart
import '../../../../core/database/models/document_type.dart';
import '../../../../core/database/models/custom_field.dart';

/// Defines custom fields for each document subtype
class CustomFieldsDefinitions {
  static const Map<SubType, List<CustomFieldDefinition>> _definitions = {
    // Identification Documents
    SubType.passport: [
      CustomFieldDefinition(
        key: 'passportNumber',
        label: 'Passport Number',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Enter your passport number',
      ),
      CustomFieldDefinition(
        key: 'country',
        label: 'Issuing Country',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Country that issued the passport',
      ),
      CustomFieldDefinition(
        key: 'issuedDate',
        label: 'Issue Date',
        type: CustomFieldType.date,
        isRequired: false,
        hint: 'When the passport was issued',
      ),
    ],
    
    SubType.nationalId: [
      CustomFieldDefinition(
        key: 'idNumber',
        label: 'ID Number',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Your national ID number',
      ),
      CustomFieldDefinition(
        key: 'country',
        label: 'Country',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Country of issue',
      ),
    ],
    
    SubType.driversLicense: [
      CustomFieldDefinition(
        key: 'licenseNumber',
        label: 'License Number',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Your driver\'s license number',
      ),
      CustomFieldDefinition(
        key: 'licenseClass',
        label: 'License Class',
        type: CustomFieldType.select,
        isRequired: false,
        hint: 'Type of license',
        options: ['Class A', 'Class B', 'Class C', 'CDL', 'Motorcycle', 'Other'],
      ),
      CustomFieldDefinition(
        key: 'restrictions',
        label: 'Restrictions',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Any license restrictions',
      ),
    ],
    
    SubType.birthCertificate: [
      CustomFieldDefinition(
        key: 'certificateNumber',
        label: 'Certificate Number',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Birth certificate number',
      ),
      CustomFieldDefinition(
        key: 'placeOfBirth',
        label: 'Place of Birth',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'City/location of birth',
      ),
    ],

    // Vehicle Documents
    SubType.carRegistration: [
      CustomFieldDefinition(
        key: 'plateNumber',
        label: 'License Plate',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Vehicle license plate number',
      ),
      CustomFieldDefinition(
        key: 'vin',
        label: 'VIN',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Vehicle Identification Number',
      ),
      CustomFieldDefinition(
        key: 'make',
        label: 'Make',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Vehicle manufacturer',
      ),
      CustomFieldDefinition(
        key: 'model',
        label: 'Model',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Vehicle model',
      ),
      CustomFieldDefinition(
        key: 'year',
        label: 'Year',
        type: CustomFieldType.number,
        isRequired: false,
        hint: 'Vehicle year',
      ),
    ],
    
    SubType.carInsurance: [
      CustomFieldDefinition(
        key: 'policyNumber',
        label: 'Policy Number',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Insurance policy number',
      ),
      CustomFieldDefinition(
        key: 'provider',
        label: 'Insurance Provider',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Name of insurance company',
      ),
      CustomFieldDefinition(
        key: 'vehicleModel',
        label: 'Vehicle',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Year, make, and model of vehicle',
      ),
      CustomFieldDefinition(
        key: 'deductible',
        label: 'Deductible',
        type: CustomFieldType.number,
        isRequired: false,
        hint: 'Insurance deductible amount',
      ),
    ],

    // Financial Documents
    SubType.creditCard: [
      CustomFieldDefinition(
        key: 'lastFourDigits',
        label: 'Last 4 Digits',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Last 4 digits of card number',
      ),
      CustomFieldDefinition(
        key: 'bankName',
        label: 'Bank/Issuer',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Card issuing bank',
      ),
      CustomFieldDefinition(
        key: 'cardType',
        label: 'Card Type',
        type: CustomFieldType.select,
        isRequired: false,
        hint: 'Type of credit card',
        options: ['Visa', 'Mastercard', 'American Express', 'Discover', 'Other'],
      ),
      CustomFieldDefinition(
        key: 'creditLimit',
        label: 'Credit Limit',
        type: CustomFieldType.number,
        isRequired: false,
        hint: 'Card credit limit',
      ),
    ],
    
    SubType.bankStatement: [
      CustomFieldDefinition(
        key: 'accountNumber',
        label: 'Account Number (Last 4)',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Last 4 digits of account number',
      ),
      CustomFieldDefinition(
        key: 'bankName',
        label: 'Bank Name',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Name of the bank',
      ),
      CustomFieldDefinition(
        key: 'accountType',
        label: 'Account Type',
        type: CustomFieldType.select,
        isRequired: false,
        hint: 'Type of bank account',
        options: ['Checking', 'Savings', 'Business', 'Other'],
      ),
      CustomFieldDefinition(
        key: 'statementPeriod',
        label: 'Statement Period',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'e.g., January 2025',
      ),
    ],
    
    SubType.taxDocument: [
      CustomFieldDefinition(
        key: 'taxYear',
        label: 'Tax Year',
        type: CustomFieldType.number,
        isRequired: true,
        hint: 'Tax year (e.g., 2024)',
      ),
      CustomFieldDefinition(
        key: 'documentType',
        label: 'Document Type',
        type: CustomFieldType.select,
        isRequired: false,
        hint: 'Type of tax document',
        options: ['W-2', '1099', 'Tax Return', 'Receipt', 'Other'],
      ),
      CustomFieldDefinition(
        key: 'employer',
        label: 'Employer/Payer',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Name of employer or payer',
      ),
    ],

    // Travel Documents
    SubType.visa: [
      CustomFieldDefinition(
        key: 'visaNumber',
        label: 'Visa Number',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Visa identification number',
      ),
      CustomFieldDefinition(
        key: 'country',
        label: 'Country',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Country the visa is for',
      ),
      CustomFieldDefinition(
        key: 'visaType',
        label: 'Visa Type',
        type: CustomFieldType.select,
        isRequired: false,
        hint: 'Type of visa',
        options: ['Tourist', 'Business', 'Student', 'Work', 'Transit', 'Other'],
      ),
      CustomFieldDefinition(
        key: 'entries',
        label: 'Entries',
        type: CustomFieldType.select,
        isRequired: false,
        hint: 'Number of entries allowed',
        options: ['Single', 'Multiple'],
      ),
    ],
    
    SubType.boardingPass: [
      CustomFieldDefinition(
        key: 'flightNumber',
        label: 'Flight Number',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Flight number',
      ),
      CustomFieldDefinition(
        key: 'airline',
        label: 'Airline',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Airline name',
      ),
      CustomFieldDefinition(
        key: 'departure',
        label: 'Departure Airport',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Departure airport code',
      ),
      CustomFieldDefinition(
        key: 'arrival',
        label: 'Arrival Airport',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Arrival airport code',
      ),
      CustomFieldDefinition(
        key: 'seat',
        label: 'Seat',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Seat number',
      ),
    ],
    
    SubType.hotelReservation: [
      CustomFieldDefinition(
        key: 'confirmationNumber',
        label: 'Confirmation Number',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Hotel confirmation number',
      ),
      CustomFieldDefinition(
        key: 'hotelName',
        label: 'Hotel Name',
        type: CustomFieldType.text,
        isRequired: true,
        hint: 'Name of the hotel',
      ),
      CustomFieldDefinition(
        key: 'location',
        label: 'Location',
        type: CustomFieldType.text,
        isRequired: false,
        hint: 'Hotel location/city',
      ),
      CustomFieldDefinition(
        key: 'checkInDate',
        label: 'Check-in Date',
        type: CustomFieldType.date,
        isRequired: false,
        hint: 'Check-in date',
      ),
      CustomFieldDefinition(
        key: 'checkOutDate',
        label: 'Check-out Date',
        type: CustomFieldType.date,
        isRequired: false,
        hint: 'Check-out date',
      ),
    ],

    // Generic document has no custom fields
    SubType.genericDocument: [],
  };

  /// Get custom field definitions for a specific subtype
  static List<CustomFieldDefinition> getFieldsForSubType(SubType? subType) {
    if (subType == null) return [];
    return _definitions[subType] ?? [];
  }

  /// Check if a subtype has custom fields
  static bool hasCustomFields(SubType? subType) {
    return getFieldsForSubType(subType).isNotEmpty;
  }

  /// Get all available subtypes that have custom fields
  static List<SubType> getSubTypesWithCustomFields() {
    return _definitions.entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => entry.key)
        .toList();
  }
}
