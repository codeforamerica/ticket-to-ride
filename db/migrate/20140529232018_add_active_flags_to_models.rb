class AddActiveFlagsToModels < ActiveRecord::Migration
  def change
    ##
    # Rationale
    #
    # Wicked and Ruby forms require an object
    # to be created before the form is rendered.
    # This potentially creates a lot of dead objects in the
    # database. This adds an active flag so that a job
    # can go in an clear dead/inactive objects out of the
    # database after a certain amount of time.
    # There is probably a better way to do this.
    #


    # admins
    add_column :admins, :active, :boolean, default: false

    # clerks
    add_column :clerks, :active, :boolean, default: false

    # contact_people
    add_column :contact_people, :active, :boolean, default: false

    # districts
    add_column :districts, :active, :boolean, default: false

    # guardians
    add_column :guardians, :active, :boolean, default: false

    # schools
    add_column :schools, :active, :boolean, default: false

    # students
    add_column :students, :active, :boolean, default: false

    # welcome_messages
    add_column :welcome_messages, :active, :boolean, default: false

  end
end
