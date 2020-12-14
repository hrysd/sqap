require 'sqap/log_subscriber'
require 'sqap/pool'
require 'sqap/test_case'
require 'sqap/storage'

require 'sqap/version'

module Sqap
  extend self

  delegate :append, to: :@pool

  def enable!(directory)
    @enabled = true
    @pool = Pool.new
    @storage = Storage.new(directory)
  end

  def enabled?
    @enabled
  end

  def save
    pool.keys.each do |key|
      @storage.save(key, pool.delete(key))
    end
  end

  def pool
    @pool
  end

  def storage
    @storage
  end
end

ActiveSupport::TestCase.prepend Sqap::TestCase
