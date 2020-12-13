require 'sqap/log_subscriber'
require 'sqap/pool'
require 'sqap/test_case'

require 'sqap/version'

module Sqap
  extend self

  delegate :append, to: :@pool

  def init
    @pool = Pool.new
  end

  def pool
    @pool
  end

  init
end

ActiveSupport::TestCase.prepend Sqap::TestCase
