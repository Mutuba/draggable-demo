require 'rails_helper'

RSpec.describe Todo, type: :model do

  describe 'schema' do
    subject(:todo) { build(:todo) }

    it "should have all columns" do
      should have_db_column(:title).of_type(:string)
      should have_db_column(:description).of_type(:string)
      should have_db_column(:order_priority).of_type(:integer)
    end
  end

  describe "validations" do
    subject(:todo) { build(:todo)}

    it "should validate presence of fields" do
      should validate_presence_of(:title)
    end
  end

  describe "callbacks" do
    subject(:todo) { build(:todo)}

    context "when no existing todo" do
      before { todo.save }

      it "creates and assigns order priority 1" do
        expect(todo.order_priority).to eq 1
      end
    end

    context "when another todo already exists" do
      before do
        create(:todo)
        todo.save
      end

      it "considers existing todo when setting order priority" do
        expect(todo.order_priority).to eq 2
      end
    end
  end
end
