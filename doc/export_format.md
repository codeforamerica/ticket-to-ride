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

After the type, there will be a description of the field. Any enumerable fields will also have the list of available options.

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

#### [ 24 | X ] Contact person #1 - First name (string)

The first name of the contact.

#### [ 25 | Y ] Contact perso #1 - Last name (string)

The last name of the contact


#### [ 26 | Z ] Contact person  ()
#### [  |  ] ()