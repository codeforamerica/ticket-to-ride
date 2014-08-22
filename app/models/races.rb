
# This module has the fixed values used for races students may belong to.
# These values are not only what get stored in the database, but are
# also used to construct translation keys in the locale files.
# In other words, if you change something in here, make sure the
# the changes are updated in the database accordingly and that
# translation keys are updated.
module Races

  # Text description, but also used for translation and database storage
  BLACK = 'black'
  WHITE = 'white'
  ASIAN = 'asian'
  NATIVE_AMERICAN = 'native_american'
  PACIFIC_ISLANDER = 'pacific_islander'

  # All of the defined races
  ALL = [BLACK, WHITE, ASIAN, NATIVE_AMERICAN, PACIFIC_ISLANDER].sort

end