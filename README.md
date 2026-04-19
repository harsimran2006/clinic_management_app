# Clinic Management App
A mobile application built using flutter and SQLite for managing clinics, patients and appointments.

This project was completed as part of a group assigment for PROG2436 - Conestoga College

## Overview
The clinic management app allows users to:
- Register and log in
- Add and view clinics
- Book appointments between patients and clinics
- View appoinment details
- View locations on Google Maps
- Navigate through a clean simple UI
The app uses SQLite for local data storage and follows a modular screen-based architecture

## Technologies used
- Flutter (Dart)
- SQLite (sqflite package)
- Google Maps Flutter
- Material Design UI

## Database Structure
The app uses four main tables
- Users - Stores login credentials
- Clinics - Stores clinic info (name, address, phone, description)
- Patients - Stores patient info (name, age, phone, email)
- Appointments - Links patients + clinics with date and time
All tables use PRIMARY KEY AUTOINCREMENT, and phone numbers in clinics/patients are UNIQUE to prevent duplicate

## Key Features
Authentication
- Register new users
- Login with validation
- Secure navigation using push Replacement

Clinic Management
- Add new clinics
- View clinic details
- View clinic location on google maps

Patient Management
- Add aptients
- View patient details
- Validation for age. Phone and email

Appointment Booking
- Select Patient
- Select clinic
- Pick date
- Add reason
- View appointment details
- JOIN query to show patient + clinic names

## Group Member Contributions
Member 1 (Harsimranpreet Kaur) - UI & Navigation
- Built Homescreen and navigation structure
- Created Login + Register screens
- Designed overall app layout and theme

Member 2 (Lewis Moura) - Forms and Validation
- Add clinic
- Appointment
- Patient
- Implement validation

Member 3 (Sainabou Samba Camara) - Database (Core)
- Setup sqflite
- Create tables
- Implement CRUD

Member 4 (Harsimrandeep Kaur) - Native Features
- Location services
- Map display

## Screens Included
- Login
- Register
- Home
- Clinic List
- Clinic Details
- Add Clinic
- Patient List
- Patient Details
- Add Patient
- Appointment List
- Appointment Details
- Add Appointment
- Map SCreen
