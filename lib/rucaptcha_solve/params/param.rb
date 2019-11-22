module RucaptchaSolve
  module Params
    class Param
      class Invalid < StandardError; end

      ##
      # Please read documentation for allowed values, only official api knows why
      # this values are allowed and what do they mean.
      #
      def new(name, type, value, required: false, allowed_values: nil)
        @name = name
        @type = type
        @value = value
        @required = required
        @allowed_values = cast_allowed_values(allowed_values, type)
      end

      def validate!
        # return true if can_be_empty? && blank?

        return false if required? && blank?
        return true if no_value_restriction?

        validate_type
        validate_value
      end

      def to_h
        { "#{name}": value }
      end

      def required?
        required
      end

      def blank?
        return true if value.is_a?(NilClass)
        return true if value.is_a?(String) && value.empty?
        return true if value.is_a?(Symbol) && value.to_sym == :""

        false
      end

      def can_be_empty?
        !required
      end

      def inspect
        "Param name: #{name}, type: #{type}, value: #{value}, required: #{required}, allowed_values: #{allowed_values}"
      end

      private

      attr_reader :allowed_values, :required

      def no_value_restriction?
        allowed_values.nil?
      end

      def cast_allowed_values(allowed_values, type)
        case type
        when String
          allowed_values.map(&:to_s)
        when Symbol
          allowed_values.map(&:to_sym)
        end
      end

      def validate_type
        value.is_a?(type)

        raise Invalid, "#{value} is not a #{type}"
      end

      def validate_value
        allowed_values.include?(value)

        raise Invalid, "#{value} not found in #{allowed_values}"
      end
    end
  end
end
