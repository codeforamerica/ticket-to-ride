module ArmedServiceStatuses
  ACTIVE = 'active' # active duty
  NOT_ACTIVE = 'not_active' # off of active duty
  CIVILIAN = 'civilian' # someone that works for the military, but not enlisted
  FOREIGN = 'foreign' # works as a foreign military officer

  ALL = [ACTIVE, NOT_ACTIVE, CIVILIAN, FOREIGN]
end