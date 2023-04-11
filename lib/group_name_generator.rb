# While none of these terms are necessarily "bad" they may have implications which
# can make users of this application uncomfortable, so this generator seeks to
# avoid that as much as possible.
#
# If I missed something feel free to open a PR. If that PR is deleting this file
# or the avoided words I have no issues blocking people. Don't be that person.
module GroupNameGenerator
  AVOIDED_ADJECTIVES = [
    'combative', # Aggressive
    'faithful', # Potential religious
    'homely', # Not positive for everyone
    'inexpensive', # Not good idea for outings
    'quaint', # Not positive for everyone
    'rich', # Opposite problem of inexpensive
    'tender', # Feels off
    'tasty', # Feels off
    'zealous', # Also potentially religious
  ]

  AVOIDED_NAMES = [
    'ape', # Potentially racist
    'baboon', # Potentially racist
    'chimpanzee', # Potentially racist
    'cow', # Potentially sizist
    'monkey', # Potentially racist
    'panda',  # Potentially racist
    'pig',  # Potentially sizist
    'rat',  # Bad connotations
    'weasel', # Bad connotations
    'whale', # Potentially sizist
    'wolf', # Don't want the alpha bit
  ]

  AVOIDED_COLORS = [
    'black', # Potentially racist
    'white', # Potentially racist
    'yellow', # Potentially racist
    'tan', # Potentially racist
    'red', # Potentially racist
  ]

  def self.get_name
    color = Faker::Color.color_name.capitalize
    salt = SecureRandom.uuid.last(6).upcase

    "#{safe_adjective} #{safe_color} #{safe_animal_name} #{salt}"
  end

  def self.safe_adjective
    adjective = Faker::Adjective
      .positive
      .then { AVOIDED_ADJECTIVES.include?(_1) ? 'wonderous' : _1 }
      .capitalize
  end

  def self.safe_animal_name
    Faker::Creature::Animal
      .name
      .then { AVOIDED_NAMES.include?(_1) ? 'lemur' : _1 }
      .split
      .map(&:capitalize)
      .join(' ')
  end

  def self.safe_color
    Faker::Color
      .color_name
      .then { AVOIDED_COLORS.include?(_1) ? 'mauve' : _1 }
      .capitalize
  end
end
