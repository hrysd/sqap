require 'json'
require 'fileutils'

module Sqap
  class Storage
    attr_reader :directory

    def initialize(directory)
      FileUtils.mkdir_p directory

      @directory = Dir.chdir(directory) { Dir.pwd }
    end

    def save(basename, content)
      # XXX: metadata
      File.write(File.join(directory, "#{basename}.json"), JSON.dump(content))
    end

    def files
      Dir.children(directory).map {|file|
        File.join(directory, file)
      }
    end
  end
end
