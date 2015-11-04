puts "> Creating person & event types........"



PersonType.create!([
  {title: "Moi !", main: true, priority: 4},
  {title: "Ma boîte", main: true, priority: 3},
  {title: "Ma copine", main: true, priority: 1},
  {title: "Mon copain", main: true, priority: 2}
])

EventType.create!([
  {title: "Dîner", main: true, priority: nil},
  {title: "Soirée", main: true, priority: nil},
  {title: "Pic-Nic", main: nil, priority: nil}
])


puts "Person & event types saved!"