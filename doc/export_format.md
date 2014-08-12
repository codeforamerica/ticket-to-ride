# Ticket to RIDE Export Format

In what is guaranteed to be the must-read of the year, this document outlines the [CSV](http://en.wikipedia.org/wiki/Comma-separated_values) export format from Ticket to RIDE. This document is intended to help map data from Ticket to RIDE to an [SIS](http://en.wikipedia.org/wiki/Student_information_system).

Stay posted for the movie adaptation. :wink:

## How to Read

Each subsection of the **Fields** section starts with a `[ number | letter ]` annotation. The number is the column index (base 0, i.e. 0 is the first number) and the letter is the column heading as if you opened it in Google Spreadsheets or Microsoft Excel. If the field is optional, this will also be indicated in the annotation. Note that optional fields, when not filled in, will still be a field in the CSV file, just with no value. Example for middle name left out (note the double comma): `Jack,,Johnson``.

Following the annotation is the name of the field, followed by the type in parenthesis. Types are defined as the following:

- boolean : A true/false field. 0 is false, 1 is true.
- date : A date by the Gregorian calendar. Format is `YYYY-MM-DD` (year-month-day of month)
- string : Alphanumeric characters
- number : Numeric digits

After the type, there will be a description of the field.

## Fields

### Student

#### [ 1 | A ] Student first name (string)

The student's first name as it appears on the birth certificate.

#### [ 2 | B | optional ] Student middle name (string)

The student's middle name as it appears on the birth certificate.

#### [ 3 | C ] Student last name (string)

The student's last name as it appears on the birth certificate.

#### [ 4 | D ] Student birthday (date)

The student's birth date as it appears on the birth certificate.

#### [ 5 | E ] Student primary language (string)

This is the student's primary language, or what the student is most accustomed to speaking and reading/writing. The following languages are options in the application, but also an language can be written in.

- ENGLISH
- SPANISH
- PORTUGUESE
- ITALIAN
- FRENCH
- MON-KHMER 
- (fill-in)

#### [ 6 | F | optional ] Student second language (string)

This is the student's secondary language, or what is commonly spoken at home. The following languages are options in the application, but also an language can be written in.

- ENGLISH
- SPANISH
- PORTUGUESE
- ITALIAN
- FRENCH
- MON-KHMER 
- (fill-in)

#### [ 7 | G | optional ] Student prior school (string)

The name of the school that the student went to prior to this registration. In other words, the school he/she is coming from. Will often contain the school name, as well as the city and state the school was in.

Example:

`Classical High School-Providence-RI`

#### [ 8 | H ] IEP (boolean)

True if the student has an [individualized education program](http://en.wikipedia.org/wiki/Individualized_Education_Program).

#### [ 9 | I ] 504 Plan (boolean)

True is the student has [special needs](http://kidshealth.org/parent/positive/learning/504-plans.html).


#### [ 10 | J ] Graduation year (number)

The student's estimated graduation year (assuming grades Pre-Kindergarten through 12th). The format a 4 digit year (`YYYY`).

#### [ 11 | K ] Student home street address - Line 1 (string)

The first line of the student's home address where he/she resides.

#### [ 12 | L | optional] Student home street address - Line 2 (string)

The second line of the student's home address where he/she resides.

#### [ 13 | M ] Student home city (string)

The city in which the student resides.

#### [ 14 | N ] Student home state (string)

The state in which the student resides.

#### [ 15 | O ] Student home ZIP code (string)

The ZIP code in which the student resides. 

#### [ 16 | P ] Student mailing street address - Line 1 (string)

The first line of the student's mailing address where school mailings can be received via postal mail.

#### [ 17 | Q ] Student mailing street address - Line 2 (string)

The second line of the student's mailing address where school mailings can be received via postal mail.

#### [ 18 | R ] Student mailing city (string)

The city in which the student can receive postal mail.

#### [ 19 | S ] Student mailing state (string)

The state in which the student can receive postal mail.

#### [ 20 | T ] Student mailing ZIP code (string)

The ZIP code at which students can receive postal mail.

#### [ 21 | U ] Student gender (string)

Current options include MALE and FEMALE(, but in the future could include OTHER).

#### [ 22 | V ] Student races (string)

The student's ethnicities. For the first version, this software supports the races that [RIDE](http://www.ride.ri.gov/) acknowledges:

- ASIAN_OR_PACIFIC_ISLANDER
- BLACK
- NATIVE_AMERICAN_OR_ALASKAN
- WHITE

If possible, it would be ideal to treat this as a string in your SIS since there should be a great deal of options available, as the current list is quite limited.

#### [ 23 | W ] Student birth place (string)

The place that the student was born. This is largely a free form string, but may look something like: `Providence-RI-USA`.

### Contact Person #1

This is always a legal guardian.

#### [ 24 | X ] Contact person #1 - First name (string)

The first name of the contact.

#### [ 25 | Y ] Contact person #1 - Last name (string)

The last name of the contact.

#### [ 26 | Z ] Contact person #1 - Street address - Line #1  (string)

The home street address of the contact. 

#### [ 27 | AA | optional ] Contact person #1 - Street address - Line #2 (string)

The second line of the contact's home street address.

#### [ 28 | AB ] Contact person #1 - City (string)

The city of the contact's home address.

#### [ 29 | AC ] Contact person #1 - State (string)

The state of the contact's home address.

#### [ 30 | AD ] Contact person #1 - ZIP code (string)

The ZIP code of the contact's home address.

#### [ 31 | AE ] Contact person #1 - Phone number #1 (string)

The primary phone number for the contact person.

#### [ 32 | AF ] Contact person #1 - Permission to send SMS - Phone #1 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 33 | AG ] Contact person #1 - Phone number #2 (string)

The secondary phone number for the contact person.

#### [ 34 | AH ] Contact person #1 - Permission to send SMS - Phone #2 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 35 | AI ] Contact person #1 - Phone number #3 (string)

Another phone number for the contact person. This is often a work phone number, but not necessarily.

#### [ 36 | AJ ] Contact person #1 - Permission to send SMS - Phone #3 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 37 | AK ] Contact person #1 - Email Address (string)

An e-mail address that the contact can be reached at.

#### [ 38 | AL ] Contact person #1 - Lives with student (boolean)

`1` if the student lives with this contact person. `0` otherwise.

#### [ 39 | AM  ] Contact person #1 - Has custody of the student (boolean)

`1` if the student lives with this contact person. `0` otherwise.

#### [ 40 | AN ] Contact person #1 - Can receive grade notifications (boolean)

`1` if the contact can receive information about the student's grades and class performance. `0` otherwise.

#### [ 41 | AO ] Contact person #1 - Can receive conduct notifications (boolean)

`1` if the contact can receive conduct or behavioral notifications. `0` otherwise.

#### [ 42 | AP ] Contact person #1 - Can receive other mailings (boolean)

`1` if the contact can receive other mailings (newsletters, non-sensitive updates, etc). `0` otherwise.

#### [ 43 | AQ ] Contact person #1 - Contact person employer name (string)

The name of the company/organization that the contact works for.

#### [ 44 | AR ] Contact person #1 - Relationship to student (string)

The following options are how a contact person might be related to a student:

- COURTSYSTEM
- AUNT
- FATHER
- FOSTERPARENT
- GRANDPARENT
- LEGALGUARDIAN
- MOTHER
- OTHER
- RESIDES
- STEPFATHER
- STEPMOTHER
- UNCLE

#### [ 45 | AS | optional ] Contact person #1 - Military status (string)

This describes the contact person's relationship to the military. There are the following options:

- ACTIVE
- NOT_ACTIVE (i.e off active duty)
- CIVILIAN  (i.e. someone that works for the military, but is not enlisted...not super clear)
- FOREIGN (i.e. is a foreign military officer)

If this field is left blank, it can be assumed that the contact person has no known association with a military.

#### [ 46 | AS ] Contact person #1 - Is legal guardian (boolean)

Is always `1` for this contact. 

### Contact Person #2

This may or may not be a legal guardian.

#### [ 47 | AT ] Contact person #2 - First name (string)

The first name of the contact.

#### [ 48 | AU ] Contact person #2 - Last name (string)

The last name of the contact.

#### [ 49 | AV ] Contact person #2 - Street address - Line #1  (string)

The home street address of the contact. 

#### [ 50 | AW | optional ] Contact person #2 - Street address - Line #2 (string)

The second line of the contact's home street address.

#### [ 51 | AX ] Contact person #2 - City (string)

The city of the contact's home address.

#### [ 52 | AY ] Contact person #2 - State (string)

The state of the contact's home address.

#### [ 53 | AZ ] Contact person #2 - ZIP code (string)

The ZIP code of the contact's home address.

#### [ 54 | BA ] Contact person #2 - Phone number #1 (string)

The primary phone number for the contact person.

#### [ 55 | BB ] Contact person #2 - Permission to send SMS - Phone #1 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 56 | BC ] Contact person #2 - Phone number #2 (string)

The secondary phone number for the contact person.

#### [ 57 | BD ] Contact person #2 - Permission to send SMS - Phone #2 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 58 | BE ] Contact person #2 - Phone number #3 (string)

Another phone number for the contact person. This is often a work phone number, but not necessarily.

#### [ 59 | BF ] Contact person #2 - Permission to send SMS - Phone #3 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 60 | BG ] Contact person #2 - Email Address (string)

An e-mail address that the contact can be reached at.

#### [ 61 | BH ] Contact person #2 - Lives with student (boolean)

`1` if the student lives with this contact person. `0` otherwise.

#### [ 61 | BI  ] Contact person #2 - Has custody of the student (boolean)

`1` if the student lives with this contact person. `0` otherwise.

#### [ 62 | BJ ] Contact person #2 - Can receive grade notifications (boolean)

`1` if the contact can receive information about the student's grades and class performance. `0` otherwise.

#### [ 63 | BK ] Contact person #2 - Can receive conduct notifications (boolean)

`1` if the contact can receive conduct or behavioral notifications. `0` otherwise.

#### [ 64 | BL ] Contact person #2 - Can receive other mailings (boolean)

`1` if the contact can receive other mailings (newsletters, non-sensitive updates, etc). `0` otherwise.

#### [ 65 | BM ] Contact person #2 - Contact person employer name (string)

The name of the company/organization that the contact works for.

#### [ 66 | BN ] Contact person #2 - Relationship to student (string)

The following options are how a contact person might be related to a student:

- COURTSYSTEM
- AUNT
- FATHER
- FOSTERPARENT
- GRANDPARENT
- LEGALGUARDIAN
- MOTHER
- OTHER
- RESIDES
- STEPFATHER
- STEPMOTHER
- UNCLE

#### [ 67 | BO | optional ] Contact person #2 - Military status (string)

This describes the contact person's relationship to the military. There are the following options:

- ACTIVE
- NOT_ACTIVE (i.e off active duty)
- CIVILIAN  (i.e. someone that works for the military, but is not enlisted...not super clear)
- FOREIGN (i.e. is a foreign military officer)

If this field is left blank, it can be assumed that the contact person has no known association with a military.

#### [ 68 | BP ] Contact person #2 - Is legal guardian (boolean)

`1` if this contact is a legal guardian or `0` if not.

### Contact Person #3

This may or may not be a legal guardian, but is often *not*.

#### [ 69 | BQ ] Contact person #3 - First name (string)

The first name of the contact.

#### [ 70 | BR ] Contact person #3 - Last name (string)

The last name of the contact.

#### [ 71 | BS ] Contact person #3 - Street address - Line #1  (string)

The home street address of the contact. 

#### [ 72 | BT | optional ] Contact person #3 - Street address - Line #2 (string)

The second line of the contact's home street address.

#### [ 73 | BU ] Contact person #3 - City (string)

The city of the contact's home address.

#### [ 74 | BV ] Contact person #3 - State (string)

The state of the contact's home address.

#### [ 75 | BW ] Contact person #3 - ZIP code (string)

The ZIP code of the contact's home address.

#### [ 76 | BX ] Contact person #3 - Phone number #1 (string)

The primary phone number for the contact person.

#### [ 77 | BY ] Contact person #3 - Permission to send SMS - Phone #1 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 78 | BZ ] Contact person #3 - Phone number #2 (string)

The secondary phone number for the contact person.

#### [ 79 | CA ] Contact person #3 - Permission to send SMS - Phone #2 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 80 | CB ] Contact person #3 - Phone number #3 (string)

Another phone number for the contact person. This is often a work phone number, but not necessarily.

#### [ 81 | CC ] Contact person #3 - Permission to send SMS - Phone #3 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 82 | CD ] Contact person #3 - Email Address (string)

An e-mail address that the contact can be reached at.

#### [ 83 | CE ] Contact person #3 - Lives with student (boolean)

`1` if the student lives with this contact person. `0` otherwise.

#### [ 84 | CF  ] Contact person #3 - Has custody of the student (boolean)

`1` if the student lives with this contact person. `0` otherwise.

#### [ 85 | CG ] Contact person #3 - Can receive grade notifications (boolean)

`1` if the contact can receive information about the student's grades and class performance. `0` otherwise.

#### [ 86 | CH ] Contact person #3 - Can receive conduct notifications (boolean)

`1` if the contact can receive conduct or behavioral notifications. `0` otherwise.

#### [ 87 | CI ] Contact person #3 - Can receive other mailings (boolean)

`1` if the contact can receive other mailings (newsletters, non-sensitive updates, etc). `0` otherwise.

#### [ 88 | CJ ] Contact person #3 - Contact person employer name (string)

The name of the company/organization that the contact works for.

#### [ 89 | CK ] Contact person #3 - Relationship to student (string)

The following options are how a contact person might be related to a student:

- COURTSYSTEM
- AUNT
- FATHER
- FOSTERPARENT
- GRANDPARENT
- LEGALGUARDIAN
- MOTHER
- OTHER
- RESIDES
- STEPFATHER
- STEPMOTHER
- UNCLE

#### [ 90 | CL | optional ] Contact person #3 - Military status (string)

This describes the contact person's relationship to the military. There are the following options:

- ACTIVE
- NOT_ACTIVE (i.e off active duty)
- CIVILIAN  (i.e. someone that works for the military, but is not enlisted...not super clear)
- FOREIGN (i.e. is a foreign military officer)

If this field is left blank, it can be assumed that the contact person has no known association with a military.

#### [ 91 | CM ] Contact person #3 - Is legal guardian (boolean)

`1` if this contact is a legal guardian or `0` if not.

### Contact Person #4 (optional)

This may or may not be a legal guardian, but is often *not*. This contact is entirely optional, so the end of the file may end at the prior field.

#### [ 92 | CN ] Contact person #4 - First name (string)

The first name of the contact.

#### [ 93 | CO ] Contact person #4 - Last name (string)

The last name of the contact.

#### [ 94 | CP ] Contact person #4 - Street address - Line #1  (string)

The home street address of the contact. 

#### [ 95 | CQ | optional ] Contact person #4 - Street address - Line #2 (string)

The second line of the contact's home street address.

#### [ 96 | CR ] Contact person #4 - City (string)

The city of the contact's home address.

#### [ 97 | CS ] Contact person #4 - State (string)

The state of the contact's home address.

#### [ 98 | CT ] Contact person #4 - ZIP code (string)

The ZIP code of the contact's home address.

#### [ 99 | CU ] Contact person #4 - Phone number #1 (string)

The primary phone number for the contact person.

#### [ 100 | CV ] Contact person #4 - Permission to send SMS - Phone #1 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 101 | CW ] Contact person #4 - Phone number #2 (string)

The secondary phone number for the contact person.

#### [ 102 | CX ] Contact person #4 - Permission to send SMS - Phone #2 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 103 | CY ] Contact person #4 - Phone number #3 (string)

Another phone number for the contact person. This is often a work phone number, but not necessarily.

#### [ 104 | CZ ] Contact person #4 - Permission to send SMS - Phone #3 (boolean)

`1` if the contact person can receive text messages (SMS) at this number. If not, `0` is the value.

#### [ 105 | DA ] Contact person #4 - Email Address (string)

An e-mail address that the contact can be reached at.

#### [ 106 | DB ] Contact person #4 - Lives with student (boolean)

`1` if the student lives with this contact person. `0` otherwise.

#### [ 107 | DC  ] Contact person #4- Has custody of the student (boolean)

`1` if the student lives with this contact person. `0` otherwise.

#### [ 108 | DD ] Contact person #4 - Can receive grade notifications (boolean)

`1` if the contact can receive information about the student's grades and class performance. `0` otherwise.

#### [ 109 | DE ] Contact person #4 - Can receive conduct notifications (boolean)

`1` if the contact can receive conduct or behavioral notifications. `0` otherwise.

#### [ 110 | DF ] Contact person #4 - Can receive other mailings (boolean)

`1` if the contact can receive other mailings (newsletters, non-sensitive updates, etc). `0` otherwise.

#### [ 111 | DG ] Contact person #4 - Contact person employer name (string)

The name of the company/organization that the contact works for.

#### [ 112 | DH ] Contact person #4 - Relationship to student (string)

The following options are how a contact person might be related to a student:

- COURTSYSTEM
- AUNT
- FATHER
- FOSTERPARENT
- GRANDPARENT
- LEGALGUARDIAN
- MOTHER
- OTHER
- RESIDES
- STEPFATHER
- STEPMOTHER
- UNCLE

#### [ 113 | DI | optional ] Contact person #4 - Military status (string)

This describes the contact person's relationship to the military. There are the following options:

- ACTIVE
- NOT_ACTIVE (i.e off active duty)
- CIVILIAN  (i.e. someone that works for the military, but is not enlisted...not super clear)
- FOREIGN (i.e. is a foreign military officer)

If this field is left blank, it can be assumed that the contact person has no known association with a military.

#### [ 114 | DJ ] Contact person #4 - Is legal guardian (boolean)

`1` if this contact is a legal guardian or `0` if not.