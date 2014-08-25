# This module has the fixed values used for grades students may be in.
# These values are not only what get stored in the database, but are
# also used to construct translation keys in the locale files.
# In other words, if you change something in here, make sure the
# the changes are updated in the database accordingly and that
# translation keys are updated.

module Grades

  # Define all the available grades
  NONE = 'none'
  PRE_KINDERGARTEN = 'pre_k'
  KINDERGARTEN = 'kindergarten'
  GRADE_1 = '1'
  GRADE_2 = '2'
  GRADE_3 = '3'
  GRADE_4 = '4'
  GRADE_5 = '5'
  GRADE_6 = '6'
  GRADE_7 = '7'
  GRADE_8 = '8'
  GRADE_9 = '9'
  GRADE_10 = '10'
  GRADE_11 = '11'
  GRADE_12 = '12'

  # All of the grades
  #  The ordering of this list is intentional (same order most students would progress)
  ALL = [NONE,
         PRE_KINDERGARTEN,
         GRADE_1,
         GRADE_2,
         GRADE_3,
         GRADE_4,
         GRADE_5,
         GRADE_6,
         GRADE_7,
         GRADE_8,
         GRADE_9,
         GRADE_10,
         GRADE_11,
         GRADE_12
  ]

end