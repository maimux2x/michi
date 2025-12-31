FactoryBot.define do
  factory :post do
    user

    title { "test" }
    body  { "This is a test post body." }
  end
end
