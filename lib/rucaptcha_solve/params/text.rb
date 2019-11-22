module RucaptchaSolve
  module Params
    module Text
      class Get < Base
        def validate!
          super
          ensure_method!
        end

        private
      end

      class Post < Base
        def validate!
          super
          ensure_method!
        end

        private

        def ensure_method!
          return if params.method.to_s.size > 1 &&
            (params.method.to_sym == :post) || (params.method.to_sym == :base64)

          raise ParamInvalid, ":method can only be :post or :base64 but given #{params.method}"
        end
      end
    end
  end
end
