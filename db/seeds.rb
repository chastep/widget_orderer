# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


type_info = [{ name: 'widget' }, { name: 'widget pro' }, { name: 'widget xtreme' }]
types = Type.create(type_info)
colors = ['red', 'yellow', 'blue']
dates = [Date.today + 1.weeks, Date.today + 2.weeks, Date.today + 3.weeks]

10.times do
  Order.create(
    {
      quantity: rand(1..100),
      color: colors.sample,
      deliver_by: dates.sample,
      type: types.sample
    }
  )
end

