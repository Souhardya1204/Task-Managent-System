# frozen_string_literal: true

require "rails_helper"
# rubocop:disable Metrics/BlockLength
RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:tasks).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe "validations" do
    subject { build(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "format validations for emails" do
    context "when format is invalid" do
      invalid_emails.each do |invalid_email|
        it { should_not allow_value(invalid_email).for(:email) }
      end
    end

    context "when format is valid" do
      valid_emails.each do |valid_email|
        it { should allow_value(valid_email).for(:email) }
      end
    end
  end

  it "check email is always lowercase" do
    email = "ABC@GMAIL.COM"
    user = create(:user, email: email)
    expect(user.email).to eq(email.downcase)
  end

  it "check name is titleize" do
    name = "SOUHARDYA MANDAL"
    user = create(:user, name: name)
    expect(user.name).to eq(name.titleize)
  end

  it "default role is employee" do
    user = create(:user)
    expect(user.role).to eq("employee")
  end

  it "is_admin? returns true only when user is admin" do
    user = create(:user, role: "admin")
    expect(user.is_admin?).to be true
  end

  it "is_hr? returns true when user is hrd" do
    user = create(:user, role: "hrd")
    expect(user.is_hr?).to be true
  end

  it "is_admin? and is_hr? returns false when user is employee " do
    user = create(:user)
    expect(user.is_admin?).to be false
    expect(user.is_hr?).to be false
  end
end
# rubocop:enable Metrics/BlockLength
