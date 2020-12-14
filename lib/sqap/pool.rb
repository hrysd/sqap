module Sqap
  class Pool
    attr_accessor :pool

    delegate :push, to: :pool

    def initialize
      @pool = []
    end

    def content
      @pool
    end

    def clear!
      @pool = []
    end
  end
end
