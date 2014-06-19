# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#!/bin/env ruby
# encoding: utf-8

# Central requirements

CustomRequirement.create(
    name: 'Physical Exam',
    description: 'Checkup by a doctor',
    uri: 'http://www.health.ri.gov/forms/school/Physical.pdf',
    req_type: :url,
    authority_level: :central
)

# West Warwick School District

west_warick_district = District.create(
  name: 'West Warwick Public Schools',
  mailing_street_address_1: "10 Harris Ave",
  mailing_city: 'West Warwick',
  mailing_state: 'RI',
  mailing_zip_code: '02984',
  phone: '4018211180',
  active: true
)

WelcomeMessage.create(
    message: "<p>Welcome to West Warwick Public Schools!</p><p>Please register!</p>",
    language: 'en',
    district: west_warick_district
)

CustomRequirement.create(
    name: 'Release Authorization',
    description: 'Permission to release records',
    req_type: :file,
    district: west_warick_district,
    authority_level: :district
)

greenbush_elementary_school = School.create(
    name: 'Greenbush Elementary School',
    mailing_street_address_1: '127 Greenbush Road',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    phone: '4018228454',
    active: true,
    district: west_warick_district
)

john_f_horgan_elementary_school = School.create(
    name: 'John F Horgan Elementary School',
    mailing_street_address_1: '124 Providence St',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    phone: '4018028450',
    active: true,
    district: west_warick_district
)

wakefield_hills_elementary_school = School.create(
    name: 'Wakefield Hills Elementary School',
    mailing_street_address_1: '',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    phone: '4018228452',
    active: true,
    district: west_warick_district
)

john_f_deering_middle_school = School.create(
    name: 'John F. Deering Middle School',
    mailing_street_address_1: '2 Webster Knight Drive',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    phone: '4018228445',
    active: true,
    district: west_warick_district
)

west_warwick_high_school = School.create(
    name: '',
    mailing_street_address_1: '1 Webster Knight Dr',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    phone: '4018216596',
    active: true,
    district: west_warick_district
)

Admin.create(
    name: 'Jim Monti',
    district: west_warick_district,
    active: true
)

Admin.create(
    name: 'Toni Mouat',
    district: west_warick_district,
    active: true
)

guardian_complete_west_warwick_student = Student.create(
    first_name: 'Jimmy',
    middle_name: 'Michael',
    last_name: 'Miller',
    birthday: '2008-01-01',
    first_language: 'english',
    second_language: 'spanish',
    school_start_date: '2014-09-01',
    iep: true,
    p504: true,
    bus_required: true,
    birth_certificate_verified: false,
    residency_verified: false,
    lunch_provided: true,
    home_street_address_1: '60 Coit Ave',
    home_street_address_2: 'Apt 4',
    home_city: 'West Warwick',
    home_state: 'RI',
    home_zip_code: '02893',
    mailing_street_address_1: 'P.O. Box 14',
    mailing_street_address_2: 'Lockbox 18',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    school: greenbush_elementary_school,
    gender: :male,
    birth_city: 'West Warwick',
    birth_state: 'RI',
    birth_country: 'USA',
    is_hispanic: false,
    alt_home_street_address_1: '71 Coit Ave',
    alt_home_street_address_2: 'Backdoor',
    alt_home_city: 'West Warwick',
    alt_home_state: 'RI',
    alt_home_zip_code: '02893',
    nickname: 'Jimbo',
    guardian_complete_time: '2013-06-18',
    estimated_graduation_year: 2027,
    active: true,
    grade: :kindergarten
)

StudentRace.create(
    student: guardian_complete_west_warwick_student,
    race: :white,
    active: true
)

StudentRace.create(
    student: guardian_complete_west_warwick_student,
    race: :black,
    active: true
)

guardian_complete_west_warwick_guardian = Guardian.create(
    first_name: 'Linda',
    middle_name: 'Belinda',
    last_name: 'Miller',
    mailing_street_address_1: 'P.O. Box 14',
    mailing_street_address_2: 'Lockbox 18',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    cell_phone: '4011234567',
    alt_phone: '4018901234',
    alt_phone_type: :work,
    email: 'linda@codeisland.org',
    receive_emails: true,
    receive_sms: true,
    receive_postal_mail: true,
    receive_grade_notices: true,
    receive_conduct_notices: true,
    restricted: false,
    student: guardian_complete_west_warwick_student,
    active: true,
    relationship: 'mother'
)

ContactPerson.create(
    relationship: 'uncle',
    language: 'en',
    mailing_street_address_1: '95 Factory St',
    mailing_street_address_2: 'Back door',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    phone: '4019876543',
    can_pickup_child: true,
    guardian: guardian_complete_west_warwick_guardian,
    active: true,
    first_name: 'Terry',
    last_name: 'Mooler',
    email: 'terry@codeisland.org'
)

ContactPerson.create(
    relationship: 'aunt',
    language: 'en',
    mailing_street_address_1: '95 Factory St',
    mailing_street_address_2: 'Back door',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    phone: '4019876543',
    can_pickup_child: false,
    guardian: guardian_complete_west_warwick_guardian,
    active: true,
    first_name: 'Rita',
    last_name: 'Mooler',
    email: 'rita@codeisland.org'
)