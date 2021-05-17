# frozen_string_literal: true

# Admin
User.create!(email: 'admin@example.com', name: 'Victor Pauk', password: 'password', password_confirmation: 'password')

Timecop.travel(Time.zone.today - 1.month) do
  # Grain Types
  %w[Wheat Millet Buckwheat Oats Sunflower].each { |name| GrainType::Operation::Create.call(params: { grain_type: { name: name } }) }

  # Storages
  10.times do |number|
    params = { storage: { name: "Storage #{number + 1}", capacity: rand(3..5) * 10_000 } }
    Storage::Operation::Create.call(params: params)
  end

  # Supplies
  100.times do
    params = { supply: { code: FFaker::IdentificationPL.id, weight: rand(16..24) * 1_000, grain_type_id: GrainType.ids.sample } }
    Timecop.travel(rand(1..30).days.from_now) { Supply::Operation::Create.call(params: params) }
  end


  # Exports
  50.times do
    params = { export: { code: FFaker::IdentificationPL.identity_card, amount: rand(8..12) * 1_000, grain_type_id: GrainType.ids.sample } }
    Timecop.travel(rand(1..30).days.from_now) { Export::Operation::Create.call(params: params) }
  end

  # Temporary Storage to Storage Transactions
  50.times do
    params = { transaction: { grain_type_id: GrainType.ids.sample, amount: rand(2..5) * 1_000, to: Storage.ids.sample } }
    Timecop.travel(rand(1..30).days.from_now) { Transaction::Operation::TemporaryToStorage.call(params: params) }
  end

  # Storage to Storage Transactions
  100.times do
    params = { transaction: { from: Storage.ids.sample, amount: rand(2..3) * 1_000, to: Storage.ids.sample } }
    Timecop.travel(rand(1..30).days.from_now) { Transaction::Operation::StorageToStorage.call(params: params) }
  end

  # Storage to Temporary Storage Transactions
  50.times do
    params = { transaction: { amount: rand(2..3) * 1_000, from: Storage.ids.sample } }
    Timecop.travel(rand(1..30).days.from_now) { Transaction::Operation::StorageToTemporary.call(params: params) }
  end
end
