require 'sqap/pool'
require 'sqap/test_case'
require 'sqap/storage'
require 'sqap/log_subscriber'
require 'sqap/subscriber_ext'

require 'sqap/version'

module Sqap
  extend self

  def enable!(directory)
    @enabled = true
    @pool = Pool.new
    @storage = Storage.new(directory)
  end

  def enabled?
    @enabled
  end

  # XXX: Thread
  def append(sql)
    pool.push(sql)
  end

  def save(filename)
    storage.save(filename, pool.content)
    pool.clear!
  end

  def pool
    @pool
  end

  def storage
    @storage
  end
end

ActiveSupport::TestCase.prepend Sqap::TestCase

if ActiveSupport.version < Gem::Version.new('6.0.0')
  ActiveSupport::Subscriber.send :include, Sqap::SubscriberExt
end
