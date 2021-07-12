FactoryBot.define do
  factory :rule_set, class: "RulesEngine::Set" do
    sequence(:name, "Rule Set 1")
    root { nil }
  end
end
