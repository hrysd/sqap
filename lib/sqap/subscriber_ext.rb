module Sqap
  module SubscriberExt
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def detach_from(namespace, notifier = ActiveSupport::Notifications)
        @namespace  = namespace
        @subscriber = find_attached_subscriber
        @notifier   = notifier

        return unless subscriber

        subscribers.delete(subscriber)

        # Remove event subscribers of all existing methods on the class.
        subscriber.public_methods(false).each do |event|
          remove_event_subscriber(event)
        end

        # Reset notifier so that event subscribers will not add for new methods added to the class.
        @notifier = nil
      end

      private

      def remove_event_subscriber(event)
        return if %w{ start finish }.include?(event.to_s)

        pattern = "#{event}.#{namespace}"

        return unless subscriber.patterns.include?(pattern)

        notifier.unsubscribe(pattern)
        subscriber.patterns.delete(pattern)
      end

      def find_attached_subscriber
        subscribers.find { |attached_subscriber| attached_subscriber.instance_of?(self) }
      end
    end
  end
end
