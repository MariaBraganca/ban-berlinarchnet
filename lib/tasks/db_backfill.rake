# Usage:
#
# bundle exec rake db_backfill:purge_event_photos
# bundle exec rake db_backfill:attach_event_photos

namespace :db_backfill do
  namespace :events do
    SEED_FILE = Rails.root.join('db', 'seeds', 'data', 'events.json').freeze
    seed_data = JSON.parse(File.read(SEED_FILE))

    desc 'Removes photos'
    task purge_photos: :environment do
      Event.find_each { |event| event.photo.purge_later }
      puts 'Done.'
    end

    desc 'Backfills photos'
    task attach_photos: :environment do
      IMAGE_DIRECTORY = Rails.root.join('lib', 'assets', 'images', 'events').freeze

      Benchmark.bmbm do |x|
        x.report {
          Event.find_each do |event|
            filename = "#{event.id}.jpeg"

            event.photo.attach(
                  io: File.open(IMAGE_DIRECTORY.join(filename)),
                  filename: filename,
                  content_type: "image/jpeg"
                )
          end
        }
      end
    end

    desc 'Backfill dates'
    task add_dates: :environment do
      Benchmark.bmbm do |x|
        x.report {
          Event.find_each.with_index do |event, index|
            # persists dates in utc
            event_time_utc = seed_data[index]["date"].in_time_zone('Berlin').utc
            event.update(date: event_time_utc)
          end
        }
      end
    end

    desc 'Backfill string columns'
    task :add_data_for_column, %i[bcf_column] => %i[environment] do |t, args|
      BACKFILL_COLUMNS = %w[title location meetup_id]

      unless BACKFILL_COLUMNS.include?(args.bcf_column)
        raise("Provide a valid backfill column. Choose one of: #{BACKFILL_COLUMNS}.")
      end

      bcf_column = args.bcf_column

      Benchmark.bmbm do |x|
        x.report {
          Event.find_each.with_index do |event, index|
            event.update("#{bcf_column}" => seed_data[index]["#{bcf_column}"])
          end
        }
      end
    end
  end
end
