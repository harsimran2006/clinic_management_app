# Clinic Management App
A Flutter‑based mobile application for managing clinics, patients, and appointments using a clean UI and a fully local SQLite database.

This project was completed as part of PROG2436 – Conestoga College.

## Overview
The Clinic Management App allows users to:

Register and log in

Add and view clinics

Add and view patients

Book appointments between patients and clinics

View appointment details with linked patient + clinic info

View clinic locations on Google Maps

Navigate through a simple, clean, and modular UI

The app uses SQLite for local data storage and follows a screen‑based modular architecture.

## Technologies Used
Flutter (Dart)

SQLite (sqflite package)

Google Maps Flutter

Material Design UI Components

## Database Structure
The app uses four main tables:

- Users
Stores login credentials

Fields: id, username, password

- Clinics
Stores clinic information

Fields: id, name, address, phone, description

phone is UNIQUE to prevent duplicates

- Patients
Stores patient information

Fields: id, name, age, phone, email

phone is UNIQUE

- Appointments
Links patients and clinics

Fields: id, patient_id, clinic_id, date, time, reason

Uses JOIN queries to display patient + clinic names in appointment lists

All tables use PRIMARY KEY AUTOINCREMENT.

## Key Features

- Authentication
Register new users
Login with validation
Secure navigation using pushReplacement

- Clinic Management
Add new clinics
View clinic details
View clinic location on Google Maps

- Patient Management
Add patients
View patient details
Validation for age, phone, and email

- Appointment Booking
Select patient
Select clinic
Pick date and time
Add appointment reason
View appointment details
JOIN query to show linked patient + clinic names

## Group Member Contributions
- Member 1 — Harsimranpreet Kaur
UI & Navigation

Built Home screen and navigation structure

Created Login and Register screens

Designed overall app layout and theme

- Member 2 — Lewis Moura
Forms & Validation

Implemented Add Clinic form

Implemented Add Patient form

Implemented Add Appointment form

Added validation for all forms

- Member 3 — Sainabou Samba Camara
Database (Core)

Set up SQLite using sqflite

Created all database tables

Implemented full CRUD operations

Added JOIN queries

Connected UI screens to the database

- Member 4 — Harsimrandeep Kaur
Native Features

Implemented Google Maps integration

Added location services

Displayed clinic location on map screen