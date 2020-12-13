require 'minitest/around/unit'

module Sqap
  module TestCase
    def around(&block)
      LogSubscriber.attach_to :active_record

      yield

      LogSubscriber.detach_from :active_record
    end
  end
end
