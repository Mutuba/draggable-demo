class Todo < ApplicationRecord
  before_create :set_priority

  private

  def set_priority
    self.order_priority = (Todo.maximum(:order_priority) || 0) + 1
  end
end
