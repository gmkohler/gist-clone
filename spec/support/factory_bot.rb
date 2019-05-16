RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  FactoryBot.define { to_create(&:save) }
end
