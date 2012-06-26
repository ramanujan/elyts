# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# --- Create admins ----

$PASSWORD = "super valid password"


user1 = Utente.new(name: "Domenico D'Egidio", 
                  email: "domenicodeg@gmail.com", 
                  password: $PASSWORD, 
                  password_confirmation: $PASSWORD)
user1.admin!
user1.confirm!
user1.save!

# -----------------------


user2 = Utente.new(name: "Domenico D'Egidio", 
                  email: "domenicodeg@live.it", 
                  password: $PASSWORD, 
                  password_confirmation: $PASSWORD)
user2.admin!
user2.confirm!

#-------------------------


user3 = Utente.new(name: "Domenico D'Egidio", 
                   email: "administrator@elyts.com", 
                   password: $PASSWORD, 
                   password_confirmation: $PASSWORD)
user3.admin!
user3.confirm!

# --- Create normal users --- 


user4 = Utente.new(name: "Domenico D'Egidio", 
                   email: "normal_user@elyts.com", 
                   password: $PASSWORD, 
                   password_confirmation: $PASSWORD)
user4.admin!
user4.confirm!
