# frozen_string_literal: true

module CurrencyHelper
  def currency_to_cl(number)
    number_to_currency(number, precision: 0, delimiter: '.') || '$0'
  end
end
