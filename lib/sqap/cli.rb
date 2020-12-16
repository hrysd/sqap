require 'sqap/storage'

module Sqap
  class CLI
    attr_reader :before, :after

    def initialize(before, after)
      @before = before
      @after = after
    end

    def run
      before_storage = Storage.new(before)
      after_storage = Storage.new(after)

      before_storage.files.each do |this|
        basename = File.basename(this)

        that = after_storage.files.find {|file|
          File.basename(file) == basename
        }

        if that.nil?
          puts "#{this} does not exist in #{after}"
          next
        end

        diff = difference(parse(this), parse(that))

        unless diff.empty?
          puts "=== #{basename} ==="
          pp diff.to_a
          puts "=== /#{basename} ==="
        end
      end
    end

    private def parse(file_path)
      JSON.parse(File.read(file_path))
    end

    private def difference(a, b)
      Set.new(a) ^ Set.new(b)
    end
  end
end
