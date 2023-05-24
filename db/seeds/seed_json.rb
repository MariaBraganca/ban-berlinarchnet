class SeedJson
  BATCH_SIZE = 25

  attr_reader :type, :filepath

  def initialize(type:, filepath:)
    @type = type
    @filepath = filepath
  end

  def call(&creator)
    puts
    puts "===:::::::::::#{type}:::::::::::#{type}:::::::::::#{type}:::::::::::#{type}:::::::::::==="

    objects.each_slice(BATCH_SIZE) do |batch|
      creator.call(batch)
      print '.'
    end

    puts "=== #{objects.size} #{type} seeded ==="
    puts
  end

  private

  def objects
    @objects ||= JSON.parse(File.read(filepath))
  end
end
