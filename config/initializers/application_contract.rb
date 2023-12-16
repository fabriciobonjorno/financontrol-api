# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  config.messages.default_locale = :en
  config.messages.backend = :i18n

  def self.call(*args, &block)
    new.call(*args, &block)
  end
end
