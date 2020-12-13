module Sqap
  class Pool
    def initialize
      @pool = Hash.new {|h, k| h[k] = [] }
    end

    def append(key, sql)
      @pool[key].push sql
    end
  end
end
