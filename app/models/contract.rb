class Contract < ApplicationRecord
  belongs_to :project
  belongs_to :benefit
end
