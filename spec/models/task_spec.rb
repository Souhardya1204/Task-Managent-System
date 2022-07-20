# frozen_string_literal: true

require "rails_helper"
RSpec.describe Task, type: :model do
  describe "associations" do
    it { should have_many(:subtasks).dependent(:destroy) }
    it { should belong_to(:user) }
  end
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:employee_id) }
    it { should validate_presence_of(:priority) }
  end

  it "check default values" do
    user = create(:user)
    task = create(:task, user: user)
    expect(task.status).to eq("Pending")
    expect(task.acceptance).to eq("Pending")
  end
end
