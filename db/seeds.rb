# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'bcrypt'

DEFAULT_PASS = 'password'
DEFAULT_PASS_HASH = BCrypt::Password.create(DEFAULT_PASS).to_s

current_event = Gathering.create(
  name: 'RailsConf 2023',
  start_date: DateTime.new(2023, 04, 24),
  end_date: DateTime.new(2023, 04, 26),
  location: '210 Peachtree St. NW, Atlanta, Georgia, USA, 30303',

  # Manual for now, will sort that all out later
  latitude: BigDecimal('33.75911042963162'),
  longitude: BigDecimal('-84.38828143321112'),

  description: <<~TEXT
    RailsConf, hosted by Ruby Central, is the world's largest and longest-running gathering of Ruby on Rails enthusiasts, practitioners, and companies.
  TEXT
)

past_event = Gathering.create(
  name: 'RailsConf 2022',
  start_date: DateTime.new(2022, 04, 24),
  end_date: DateTime.new(2022, 04, 26),
  location: '210 Peachtree St. NW, Atlanta, Georgia, USA, 30303',

  latitude: BigDecimal('33.75911042963162'),
  longitude: BigDecimal('-84.38828143321112'),

  description: <<~TEXT
    RailsConf, hosted by Ruby Central, is the world's largest and longest-running gathering of Ruby on Rails enthusiasts, practitioners, and companies.
  TEXT
)

future_event = Gathering.create(
  name: 'RailsConf 2024',
  start_date: DateTime.new(2024, 04, 24),
  end_date: DateTime.new(2024, 04, 26),
  location: '210 Peachtree St. NW, Atlanta, Georgia, USA, 30303',

  # Manual for now, will sort that all out later
  latitude: BigDecimal('33.75911042963162'),
  longitude: BigDecimal('-84.38828143321112'),

  description: <<~TEXT
    RailsConf, hosted by Ruby Central, is the world's largest and longest-running gathering of Ruby on Rails enthusiasts, practitioners, and companies.
  TEXT
)

current_event_first_night_supper = current_event.outings.create(
  name: 'Day 1 Supper',
  start_time: DateTime.new(2023, 04, 24, 5),
  end_time: DateTime.new(2023, 04, 24, 9),
  description: 'Supper on the first night',
)

accounts = Account.create([
  {
    email: 'aaron@a.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Aaron', company: 'A' }
  }, {
    email: 'ashley@a.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Ashley', company: 'A' }
  }, {
    email: 'adrian@a.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Adrian', company: 'A' }
  }, {
    email: 'alice@a.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Alice', company: 'A' }
  }, {
    email: 'barry@b.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Barry', company: 'B' }
  }, {
    email: 'bernice@b.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Bernice', company: 'B' }
  }, {
    email: 'betsy@b.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Betsy', company: 'B' }
  }, {
    email: 'cammy@c.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Cammy', company: 'C' }
  }, {
    email: 'nicky@n.com',
    status: 2,
    password_hash: DEFAULT_PASS_HASH,
    profile_attributes: { name: 'Nicky', company: 'None' }
  },
])

current_event.accounts = accounts
current_event_first_night_supper.populate_lobby

admin = Role.create(name: 'admin')
me = Account.create(
  email: 'brandon@doesnotexist.com',
  status: 2,
  password_hash: DEFAULT_PASS_HASH,
  profile_attributes: { name: 'Brandon W', company: 'B' }
)

me.roles << admin
