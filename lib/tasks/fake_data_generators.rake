require 'faker'

namespace :data_generators do
  desc 'Generates users'
  task users: :environment, [:total, :batch_size] do |t, args|
    TOTAL = args.fetch(:total, 20_000)
    BATCH_SIZE = args.fetch(:batch_size, 10_000)

    TOTAL.times.each_slice(BATCH_SIZE) do |batch|
      users = batch.map do |i|
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name

        {
          first_name: first_name,
          last_name: last_name,
          email: "#{first_name}-#{last_name}-#{i}@email.com",
          password: SecureRandom.hex
        }
      end

      # TODOs:
      # 1. Address error handling for insert_all operation
      # 2. Log the success or failure of the batch insertions
      User.insert_all(users)
      puts "Created #{users.size} users."
    end
    # TODOs:
    # 1. Analyse DB table: users
    # 2. Measure results with benchmark
  end
end
