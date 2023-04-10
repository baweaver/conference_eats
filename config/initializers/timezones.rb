require 'timezone'

Timezone::Lookup.config(:geonames) do |c|
  c.username = ENV.fetch('GEONAMES_USERNAME')
end
