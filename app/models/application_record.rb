class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Questionable

  def error
    errors.full_messages.join(", ")
  end
end
