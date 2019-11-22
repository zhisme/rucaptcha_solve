module RucaptchaSolve
  module Params
    class ParamInvalid < StandardError; end

    class Base
      DEFAULT_PARAMS = {
        json: 1,
      }.freeze

      def new(params)
        [
          Param.new(:key, String, params[:key], required: true).validate!,
          Param.new(:method, String, params[:method], required: true).validate!,
          Param.new(:phrase, Numeric, params[:phrase], allowed_values: [0, 1]).validate!,
          Param.new(:regsense, Numeric, params[:regsense], allowed_values: [0, 1]).validate!,
          Param.new(:numeric, Numeric, params[:regsense], allowed_values: [0, 1]).validate!,
        ]
        # TODO:
      end

      def validate!
        ensure_api_key!
      end

      def to_h
        params.to_h
      end

      private

      attr_reader :params

      def ensure_api_key!
        return if params.api_key.is_a?(String) && params.api_key&.size.to_i > 1

        raise ParamInvalid, 'api_key not found!'
      end
    end
  end
end
