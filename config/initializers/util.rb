# frozen_string_literal: true

module Util
  def self.capitalize_name(name)
    names = name.split(' ')
    names_capitalizes = names.map do |n|
      if %w[da de do dos das e].include?(n.downcase)
        n
      else
        n.capitalize
      end
    end

    names_capitalizes.join(' ')
  end

  def self.email_regex(email)
    email =~ /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  end

  def self.password_regex(password)
    password =~ /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)[^ ]{8,}\z/
  end
end
