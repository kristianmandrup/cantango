module CanTango
  module Filters
    class Filter
      attr_reader :item, :include_list

      def initialize item, list = nil
        @item         = item
        @include_list = list || []
      end

      def valid?
        return false if !in_include_list?
        return false if not_only?
        !excluded?
      end

      def in_include_list?
        return true if include_list.empty?
        include_list.include? item
      end

      def not_only?
        false
      end

      def excluded?
        false
      end
    end
  end
end



