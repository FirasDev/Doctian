// Notes

import 'package:hello_world/ui/user/models/analysis.dart';
import 'package:hello_world/ui/user/models/appointment.dart';
import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/laboratory.dart';
import 'package:hello_world/ui/user/models/medicamentRequest.dart';
import 'package:hello_world/ui/user/models/medicamentResponse.dart';
import 'package:hello_world/ui/user/models/notes.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:hello_world/ui/user/models/perscription.dart';
import 'package:hello_world/ui/user/models/pharmacy.dart';
import 'package:hello_world/ui/user/models/session.dart';
import 'package:hello_world/ui/user/models/users.dart';

final _owner = User(
  email: 'x199103@gmail.com',
  password: '12345678',
  phoneNumber: '93 414 888',
  activated: true,
  address: 'Medenine Center, Tunisie',
  avatar: 'avatar.jpg',
  role: 'Patient',
  city: 'Medenine',
  zipCode: '4100',
);

final _doc1 = Doctor(
  name: 'Serin',
  lastName: ' JoleData',
  specialty: 'General',
  cin: '1253315',
  medicalLicenseNumber: '4515485NL',
  dispoHourEnd: DateTime.now(),
  dispoHourStart: DateTime.now(),
  nationality: 'Tunisia',
  fee: 55.0,
  workDays: 'Sunday',
  startWorkDate: DateTime.now(),
);

final _patient = Patient(
  name: 'SaifEddine',
  lastName: ' Rhouma',
  cin: '1253315',
  nationality: 'Tunisia',
);

/// Notes
final _notes1 = Notes(
    doctor: _doc1,
    patient: '_patient',
    ipfsUrl: 'http//www.google.com',
    notesDetails: 'Hello There This Note 1');
final _notes2 = Notes(
    doctor: _doc1,
    patient: '_patient',
    ipfsUrl: 'http//www.google.com',
    notesDetails: 'Hello 1');
final _notes3 = Notes(
    doctor: _doc1,
    patient: '_patient',
    ipfsUrl: 'http//www.google.com',
    notesDetails: 'Hello Tdzsqd Note 1');
final _notes4 = Notes(
    doctor: _doc1,
    patient: '_patient',
    ipfsUrl: 'http//www.google.com',
    notesDetails: 'Hello There This Note 142284');
final List<Notes> notes = [
  _notes1,
  _notes2,
  _notes3,
  _notes4,
];

//// Perscription
final _perscription1 = Perscription(
    doctor: _doc1,
    patient: "_patient",
    ipfsUrl: 'http//www.google.com',
    perscriptionDescription: 'Hello 1');
final _perscription2 = Perscription(
    doctor: _doc1,
    patient: "_patient",
    ipfsUrl: 'http//www.google.com',
    perscriptionDescription: 'Hello Tdzsqd Note 1');
final _perscription3 = Perscription(
    doctor: _doc1,
    patient: "_patient",
    ipfsUrl: 'http//www.google.com',
    perscriptionDescription:
        'Hello There This Note 142284 Hello There This Note 142284 , Hello There This Note 142284 , Hello There This Note 142284 , Hello There This Note 142284');
final List<Perscription> perscriptions = [
  _perscription1,
  _perscription2,
  _perscription3,
];
//// Laboratory

final _lab = Laboratory(
  name: 'FabLap',
  coverPicture: 'img.jpg',
  dispoHourEnd: DateTime.now(),
  dispoHourStart: DateTime.now(),
  workDays: 'Sunday',
  owner: _owner,
);

//// Pharmacy

final _pharmacy1 = Pharmacy(
  name: 'Pharmacy 1',
  dispoHourStart: '20 Mars 2020',
  dispoHourEnd: '21 Mars 2020',
  workDays: 'Sunday',
  owner: _owner,
);

final _pharmacy2 = Pharmacy(
  name: 'Pharmacy 23',
  dispoHourStart: '20 Mars 2020',
  dispoHourEnd: '21 Mars 2020',
  workDays: 'Sunday',
  owner: _owner,
);

//// Analysis

final _analyse1 = Analysis(
  description: 'Desc 1',
  category: 'DNA',
  status: 'Ended',
  dateAnalyse: DateTime.now(),
  doctor: _doc1,
  laboratory: _lab,
);

final _analyse2 = Analysis(
  description: 'Desc 21',
  category: 'Blood',
  status: 'Waiting',
  dateAnalyse: DateTime.now(),
  doctor: _doc1,
  laboratory: _lab,
);

final _analyse3 = Analysis(
  description: 'Desc 333sdqs',
  category: 'DNA',
  status: 'Started',
  dateAnalyse: DateTime.now(),
  doctor: _doc1,
  laboratory: _lab,
);

final List<Analysis> analyses = [
  _analyse1,
  _analyse2,
  _analyse3,
];

//// MedicamentRequest
final _medicamentRequest1 = MedicamentRequest(
  id: '5236D',
  medicament: 'Analgon , Panadole',
  patient: _patient,
  state: 'Pending',
  //medicamentResponses: medicamentResponses
);

final _medicamentRequest2 = MedicamentRequest(
    id: 'SQZ524D',
    //medicament: 'Analgon , Panadole',
    patient: _patient,
    state: 'Pending',
    perscription: _perscription1);

final _medicamentRequest3 = MedicamentRequest(
  //medicament: 'Analgon , Panadole',
  id: 'FE863M',
  patient: _patient,
  state: 'Pending',
  perscription: _perscription3,
  //medicamentResponses: [_medicamentResponse1,_medicamentResponse2]
);

final List<MedicamentRequest> medicamentRequests = [
  _medicamentRequest1,
  _medicamentRequest2,
  _medicamentRequest3,
];

//// MedicamentResponses







//// Appointment

final _appointment1 = Appointment(
  //appointmentDate: '2020 Mars 9 : 20:20',
  appointmentStatus: 'Accepted',
  detailsProvidedByPatient: 'Hello Doc',
  doctor: _doc1,
  //patient: 'User',
);

final _appointment2 = Appointment(
  //appointmentDate: '2020 Mars 9 : 20:20',
  appointmentStatus: 'Waiting',
  detailsProvidedByPatient: 'Hello Doc',
  doctor: _doc1,
  //patient: 'User',
);

final _appointment3 = Appointment(
  //appointmentDate: '2020 Mars 9 : 20:20',
  appointmentStatus: 'Waiting',
  detailsProvidedByPatient: 'Hello Doc',
  doctor: _doc1,
  //patient: 'User',
);

final List<Appointment> appointments = [
  _appointment1,
  _appointment2,
  _appointment3,
];

//// SessionEvent

final _sessionEv1 = SessionEvent(
  status: false,
  session: DateTime.now(),
);

final _sessionEv2 = SessionEvent(
  status: true,
  session: DateTime.now(),
);

final _sessionEv3 = SessionEvent(
  status: false,
  session: DateTime.now(),
);

final _sessionEv4 = SessionEvent(
  status: false,
  session: DateTime.now(),
);

final _sessionEv5 = SessionEvent(
  status: true,
  session: DateTime.now(),
);

final _sessionEv6 = SessionEvent(
  status: false,
  session: DateTime.now(),
);

final List<SessionEvent> sessions = [
  _sessionEv1,
  _sessionEv2,
  _sessionEv3,
  _sessionEv4,
  _sessionEv5,
  _sessionEv6,
];