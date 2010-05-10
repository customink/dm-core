module DataMapper
  class Property
    class Object < Property
      primitive ::Object

      # @api semipublic
      def dump(value)
        return value if value.nil?

        if @type
          @type.dump(value, self)
        else
          Marshal.dump(value)
        end
      end

      # @api semipublic
      def load(value)
        if @type
          return @type.load(value, self)
        end

        case value
          when ::String
            Marshal.load(value)
          when ::Object
            value
          end
      end
    end
  end
end