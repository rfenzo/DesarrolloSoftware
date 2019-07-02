# frozen_string_literal: true

module DateHelper
  def get_date(datetime)
    datetime.strftime('%d/%m/%Y')
  end
end
