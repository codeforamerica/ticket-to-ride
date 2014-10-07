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
    link_url: 'http://www.health.ri.gov/forms/school/Physical.pdf',
    authority_level: :central,
    is_required: true
)

SupplementalMaterial.create(
    name: 'Free/Reduced Lunch Application',
    description: 'Anyone on food stamps eligible',
    link_url: 'http://www.food.ri.gov/forms/lunch.pdf',
    authority_level: :central,
    is_required: false
)

SupplementalMaterial.create(
    name: 'Birth certificate',
    description: "A child's proof of birth",
    bring_documentation: true,
    authority_level: :central,
    is_required: true
)

SupplementalMaterial.create(
    name: 'Proof of residency',
    description: "Examples are a current lease, mortgage payment, or utility bill.",
    bring_documentation: true,
    authority_level: :central,
    is_required: true
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
  street_address_1: "10 Harris Ave",
  city: 'West Warwick',
  state: 'RI',
  zip_code: '02984',
  phone: '4018211180',
  active: true,
  welcome_title: 'Welcome to West Warwick Public Schools!',
  welcome_message: "Dear parents,\nWe're so incredibly excited to have your child join our schools. West Warwick is among the finest districts in the entire universe and any human or non-human child is deeply valued.\nThis site will help us get to know you and your child better. We're team, you and us. In order to work together best we'll need to know a little bit about your child, but also those involved in your child's life (such as you).",
  welcomer_name: 'Jim Warwick',
  welcomer_title: 'Master of the Universe',
  confirmation_message: "You're confirmed!"
)

SupplementalMaterial.create(
    name: 'Release Authorization',
    description: 'Permission to release records',
    link_url: 'http://fakeurl.com.fakers/release_auth.pdf',
    district: west_warwick_district,
    authority_level: :district,
    is_required: true
)

SupplementalMaterial.create(
    name: 'Armed Servce Form',
    description: 'Evidence of being in the armed services',
    link_url: 'http://fakeurl.com.fakers/military.pdf',
    district: west_warwick_district,
    authority_level: :district,
    is_required: false
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
    street_address_1: '60 Coit Ave',
    street_address_2: 'Apt 4',
    city: 'West Warwick',
    state: 'RI',
    zip_code: '02893',
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
    street_address_1: 'P.O. Box 14',
    street_address_2: 'Lockbox 18',
    city: 'West Warwick',
    state: 'RI',
    zip_code: '02893',
    email: 'linda@codeisland.org',
    receive_other_mail: true,
    receive_grade_notices: true,
    receive_conduct_notices: true,
    student: guardian_complete_west_warwick_student,
    active: true,
    relationship: 'mother',
    can_pickup_child: true,
    lives_with_student: true,
    main_phone: '401-111-1111',
    is_guardian: true
)

guardian2_west_warwick = ContactPerson.create(
    relationship: 'father',
    street_address_1: '95 Factory St',
    street_address_2: 'Back door',
    city: 'West Warwick',
    state: 'RI',
    zip_code: '02893',
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
    main_phone: '401-222-2222',
    is_guardian: true
)

contact1_west_warwick = ContactPerson.create(
    relationship: 'aunt',
    street_address_1: '95 Factory St',
    street_address_2: 'Back door',
    city: 'West Warwick',
    state: 'RI',
    zip_code: '02893',
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
    street_address_1: '95 Factory St',
    street_address_2: 'Back door',
    city: 'West Warwick',
    state: 'RI',
    zip_code: '02893',
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

