class WelcomeMessage < ActiveRecord::Base
    t.string :message, null: false
    t.string :language
end
