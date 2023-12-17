# frozen_string_literal: true

class MainService
  include Dry::Transaction

  def self.call(*args, &block)
    new.call(*args, &block)
  end

  def format_errors(errors)
    messages = errors.map { |field, field_errors| format_field_error(field, field_errors) }
    { message: messages.join(" #{I18n.t('dry_validation.errors.link.article')} ") }
  end

  private

  def format_field_error(field, field_errors)
    "#{translate_field(field)} #{field_errors.map { I18n.t('dry_validation.errors.missing') }.join(' ')}"
  end

  def translate_field(field)
    I18n.t("dry_validation.errors.fields.#{field}", default: field.to_s.humanize)
  end
end
