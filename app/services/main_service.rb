# frozen_string_literal: true

class MainService
  include Dry::Transaction

  def self.call(*args, &block)
    new.call(*args, &block)
  end
end
