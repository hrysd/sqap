module Sqap
  class Pool
    attr_reader :pool

    delegate :[], :keys, :delete, to: :pool

    def initialize
      @pool = Hash.new {|h, k| h[k] = [] }
    end

    def append(key, sql)
      pool[key].push sql
    end
  end
end
