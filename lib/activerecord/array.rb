require "activerecord/array/version"
require "delegate"

module ActiveRecord
  module Array
    class Base < DelegateClass(::Array)

      def initialize (arg = nil)
        super arg.to_a
      end

      def where(hash)
        block = build_block_for_conditions hash
        self.find_all &block
      end


      private
      def build_block_for_conditions hash
        proc do |me|
          conditions = *hash
          conditions.inject(true) { |out, (key, value)| 
            current_value = me.send(key)
                 out &= if value.is_a?(::Array) || value.is_a?(Range)
                   value.include? current_value
                 elsif  value.is_a?(Hash) && !current_value.nil?
                   nested_proc = build_block_for_conditions(value)
                   nested_proc.call current_value
                 else
                   current_value == value
                 end
          }
        end
      end
    end

  end
end
