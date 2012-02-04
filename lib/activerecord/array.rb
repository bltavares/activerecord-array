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
            out &= me.send(key) == value
          }
        end
      end
    end

  end
end
