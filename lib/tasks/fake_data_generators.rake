require 'faker'

namespace :data_generators do
  desc 'Generates users'
  task :users, [:total, :batch_size] => [:environment] do |t, args|
    args.with_defaults(total: 20_000, batch_size: 10_000)

    total = args.total.to_i
    batch_size = args.batch_size.to_i

    time = Benchmark.measure do
      total.times.each_slice(batch_size) do |batch|
        users = batch.map do |i|
          first_name = Faker::Name.first_name
          last_name = Faker::Name.last_name

          {
            first_name: first_name,
            last_name: last_name,
            email: "#{first_name}-#{last_name}-#{i}@email.com",
            encrypted_password: SecureRandom.hex
          }
        end

        begin
          User.insert_all(users)
          Rails.logger.info { "Successfully created #{users.size} users." }
        rescue ActiveRecord::RecordNotUnique => e
          Rails.logger.error { "Uniqueness constraint was violated: #{e.message}" }
        rescue StandardError => e
          Rails.logger.error e.message
          Rails.logger.error e.backtrace.take(5).join('\n')
        end
      end
    end
    puts time
  end
end
