FactoryBot.define do
  factory :task do
    name  { "Stand up" }
    employee_id { 2 }
    priority { 2 }
  end
end
