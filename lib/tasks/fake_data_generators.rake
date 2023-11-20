require 'faker'

namespace :data_generators do
  desc 'Generates users'
  task :users, [:total, :batch_size] => [:environment] do |t, args|
    TOTAL = args.fetch(:total, 20_000)
    BATCH_SIZE = args.fetch(:batch_size, 10_000)

    time = Benchmark.measure do
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
    puts "Analyze table...#{User.connection.execute('ANALYZE users')}"
    puts time
  end
end
