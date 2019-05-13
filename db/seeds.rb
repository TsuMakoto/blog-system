# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MstStatus.create(status_name: '公開',   created_at: '2019-05-07',  updated_at: '2019-05-07')
MstStatus.create(status_name: '非公開', created_at: '2019-05-07',  updated_at: '2019-05-07')
MstStatus.create(status_name: '下書き', created_at: '2019-05-07',  updated_at: '2019-05-07')

