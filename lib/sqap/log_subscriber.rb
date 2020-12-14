module Sqap
  class LogSubscriber < ActiveRecord::LogSubscriber
    IGNORE_EVENTS = ['SCHEMA', 'EXPLAIN']
    IGNORE_QUERYIES = [/ar_internal_metadata/]

    def sql(event)
      return unless Sqap.enabled?

      payload = event.payload

      return if payload[:name].nil?
      return if IGNORE_EVENTS.include?(payload[:name])
      return if IGNORE_QUERYIES.any? {|regex| payload[:sql].match?(regex) }

      sql = payload[:sql]

      Sqap.append hashing_source(extract_query_source_location(caller)), sql
    end

    private def hashing_source(source)
      Digest::MD5.hexdigest(source)
    end
  end
end
