# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#!/bin/env ruby
# encoding: utf-8

# Central items
SupplementalMaterial.create(
    name: 'Physical Exam',
    description: 'Checkup by a doctor',
    uri: 'http://www.health.ri.gov/forms/school/Physical.pdf',
    req_type: :url,
    authority_level: :central
)

AdminUser.create(
    name: 'Ed G',
    email: 'ed@ride.ri.gov',
    user_role: :central_admin,
    active: true
)

# West Warwick School District
west_warwick_district = District.create(
  name: 'West Warwick Public Schools',
  mailing_street_address_1: "10 Harris Ave",
  mailing_city: 'West Warwick',
  mailing_state: 'RI',
  mailing_zip_code: '02984',
  phone: '4018211180',
  active: true,
  welcome_message: "Welcome to West Warwick's registration",
  confirmation_message: "You're confirmed!"
)

SupplementalMaterial.create(
    name: 'Release Authorization',
    description: 'Permission to release records',
    req_type: :file,
    district: west_warwick_district,
    authority_level: :district
)

AdminUser.create(
    name: 'Jim M',
    email: 'jim@westwarwick.ed',
    user_role: :district_admin,
    district: west_warwick_district,
    active: true
)

AdminUser.create(
    name: 'Toni M',
    email: 'toni@westwarwick.ed',
    user_role: :district_admin,
    district: west_warwick_district,
    active: true
)

guardian_complete_west_warwick_student = Student.create(
    first_name: 'Jimmy',
    middle_name: 'Michael',
    last_name: 'Miller',
    birthday: '2008-01-01',
    first_language: 'english',
    home_language: 'spanish',
    iep: true,
    p504: true,
    birth_certificate_verified: false,
    residency_verified: false,
    home_street_address_1: '60 Coit Ave',
    home_street_address_2: 'Apt 4',
    home_city: 'West Warwick',
    home_state: 'RI',
    home_zip_code: '02893',
    gender: :male,
    birth_city: 'West Warwick',
    birth_state: 'RI',
    birth_country: 'USA',
    is_hispanic: false,
    guardian_complete_time: DateTime.now,
    estimated_graduation_year: 2027,
    prior_school_name: 'Lighthouse Montessori',
    prior_school_city: 'West Warwick',
    prior_school_state: 'RI',
    previous_grade: 'pre_k',
    district: west_warwick_district,
    confirmation_code: 'ABC123'
)

StudentRace.create(
    race: 'black',
    student_id: guardian_complete_west_warwick_student.id
)

StudentRace.create(
    race: 'asian',
    student_id: guardian_complete_west_warwick_student.id
)

guardian_complete_west_warwick_guardian = ContactPerson.create(
    first_name: 'Linda',
    last_name: 'Miller',
    mailing_street_address_1: 'P.O. Box 14',
    mailing_street_address_2: 'Lockbox 18',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    email: 'linda@codeisland.org',
    receive_other_mail: true,
    receive_grade_notices: true,
    receive_conduct_notices: true,
    restricted: false,
    student: guardian_complete_west_warwick_student,
    active: true,
    relationship: 'mother',
    language: 'english',
    can_pickup_child: true,
    lives_with_student: true,
    has_custody: true,
    has_court_order: false,
    main_phone: '401-111-1111'
)

guardian2_west_warwick = ContactPerson.create(
    relationship: 'father',
    mailing_street_address_1: '95 Factory St',
    mailing_street_address_2: 'Back door',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    can_pickup_child: true,
    student: guardian_complete_west_warwick_student,
    active: true,
    first_name: 'Terry',
    last_name: 'Mooler',
    email: 'terry@codeisland.org',
    can_pickup_child: true,
    receive_other_mail: true,
    receive_grade_notices: true,
    receive_conduct_notices: true,
    lives_with_student: false,
    has_custody: false,
    has_court_order: false,
    main_phone: '401-222-2222'
)

contact1_west_warwick = ContactPerson.create(
    relationship: 'aunt',
    mailing_street_address_1: '95 Factory St',
    mailing_street_address_2: 'Back door',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    can_pickup_child: true,
    receive_grade_notices: true,
    receive_conduct_notices: false,
    receive_other_mail: false,
    student: guardian_complete_west_warwick_student,
    active: true,
    first_name: 'Rita',
    last_name: 'Mooler',
    email: 'rita@codeisland.org',
    main_phone: '401-333-3333'
)

contact2_west_warwick = ContactPerson.create(
    relationship: 'uncle',
    mailing_street_address_1: '95 Factory St',
    mailing_street_address_2: 'Back door',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    can_pickup_child: true,
    receive_grade_notices: true,
    receive_conduct_notices: false,
    receive_other_mail: false,
    student: guardian_complete_west_warwick_student,
    active: true,
    first_name: 'Howard',
    last_name: 'Mooler',
    email: 'howie@codeisland.org',
    main_phone: '401-444-4444'
)

