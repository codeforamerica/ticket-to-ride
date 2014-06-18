# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#!/bin/env ruby
# encoding: utf-8



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

west_warwick_admin = Admin.create(
    name: 'Jim Monti',
    active: true
)

west_warwick_clerk = Admin.create(
    name: 'Toni Mouat',
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
    mailing_street_address_1: '71 Coit Ave',
    mailing_street_address_2: 'Backdoor',
    mailing_city: 'West Warwick',
    mailing_state: 'RI',
    mailing_zip_code: '02893',
    school: greenbush_elementary_school,
    gender: :male,




)