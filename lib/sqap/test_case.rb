require 'minitest/around/unit'

module Sqap
  module TestCase
    def around(&block)
      LogSubscriber.attach_to :active_record

      yield

      LogSubscriber.deattach_from :active_record
    end
  end
end
