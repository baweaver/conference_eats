require 'http'

# url = URI("https://api.yelp.com/v3/businesses/search?sort_by=best_match&limit=20")

module Yelp
  class Client
    API_HOST = 'https://api.yelp.com'.freeze

    def initialize(api_token: ENV.fetch('YELP_API_KEY'))
      @http = HTTP.auth("Bearer #{api_token}")
    end

    def get(url, *args) = @http.get("#{API_HOST}/#{url}", *args)
    def post(url, *args) = @http.post("#{API_HOST}/#{url}", *args)
    def put(url, *args) = @http.put("#{API_HOST}/#{url}", *args)
    def delete(url, *args) = @http.delete("#{API_HOST}/#{url}", *args)
  end

  module Types
    class Base
      def initialize(json)
        serializers.each do |key, serializer|
          value = json.fetch(key)
          serialized_value = serializer ? serializer.new(value) : value

          ivar = "@#{key}"
          instance_variable_set(ivar, new_value)
          define_method(key) { instance_variable_get(ivar) }
        end
      end

      def serializers
        {}
      end
    end

    class Business < Base
      def serializers
        return @serializers if defined?(@serializers)

        non_serialized_serializers = %i(display_phone distance id alias image_url is_closed name phone price rating review_count url transactions is_claimed photos)

        @serializers = {
          categories: Types::Categories,
          coordinates: Types::Coordinates,
          location: Types::Location,
          hours: Types::Hours,
        }.merge!(NON_SERIALIZED_serializerS.to_h { [_1, nil] })
      end
    end

    class Categories < Base
      def serializers
        @serializers ||= %i(alias title).to_h { [_1, nil] }
      end
    end

    class Coordinates < Base
      def serializers
        @serializers ||= %i(latitude longitude).to_h { [_1, nil] }
      end
    end

    class Hours < Base
      def serializers
        @serializers ||= %i(is_open_now hours_type open).to_h { [_1, nil] }
      end
    end

    class Location < Base
      def serializers
        @serializers ||= %i(city country address2 address3 state address1 zip_code cross_streets display_address).to_h { [_1, nil] }
      end
    end

    class OpenHours < Base
      def serializers
        @serializers ||= %i(day start end is_overnight).to_h { [_1, nil] }
      end
    end

    class Region < Base
      def serializers
        @serializers ||= { center: Types::Coordinates }
      end
    end

    class Reviews < Base
      def serializers
        @serializers ||= {
          user: Types::User
        }.merge!(%i(id rating text time_created url).to_h { [_1, nil] })
      end
    end

    class User < Base
      def serializers
        @serializers ||= %i(image_url name).to_h { [_1, nil] }
      end
    end
  end
end
