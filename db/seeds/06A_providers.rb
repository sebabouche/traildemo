puts "> Creating providers........"


Provider.create!([
  {email: "jeanne@happhapp.com", password: "password", password_confirmation: "password", firstname: "Jeanne", lastname: "Happhapp"}
])

Address.create!([
  {addressable_id: 1, addressable_type: "Provider", name: "Happhapp", street_address: "31, boulevard de Clichy", zip_code: "75009", state: nil, city: "Paris", country: nil}
])

Phone.create!([
  {phonable_id: 1, phonable_type: "Provider", name: "Jeanne", number: "0684727784"}
])


puts "Providers saved!"
