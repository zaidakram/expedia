module Expedia
  class Api

    # All method naming is done in correspondence with Expedia services and ruby conventions
    # see http://developer.ean.com/docs/read/hotels#.UMf_hiNDt0w

    def get_list(args)
      services('/ean-services/rs/hotel/v3/list', args)
    end

    def geo_search(args)
      services('/ean-services/rs/hotel/v3/geoSearch', args)
    end

    def get_availability(args)
      services('/ean-services/rs/hotel/v3/avail', args)
    end

    def get_room_images(args)
      services('/ean-services/rs/hotel/v3/roomImages', args)
    end

    def get_information(args)
      services('/ean-services/rs/hotel/v3/info', args)
    end

    def get_rules(args)
      services('/ean-services/rs/hotel/v3/rules', args)
    end

    def get_itinerary(args)
      services('/ean-services/rs/hotel/v3/itin', args)
    end

    def get_alternate_properties(args)
      services('/ean-services/rs/hotel/v3/altProps', args)
    end

    def get_reservation(args)
      HTTPService.make_request('/ean-services/rs/hotel/v3/res', args, :post, { :reservation_api => true, :use_ssl => true })
    end

    def get_payment_info(args)
      services('/ean-services/rs/hotel/v3/paymentInfo', args)
    end

    def get_cancel(args)
      services('/ean-services/rs/hotel/v3/cancel', args)
    end

    def get_ping(args)
      services('/ean-services/rs/hotel/v3/ping', args)
    end

    def get_static_reservation(args)
      get_reservation(args.merge!({:firstName => "Test Booking", :lastName => "Test Booking", :creditCardType => "CA",
                                   :creditCardNumber => 5401999999999999, :creditCardIdentifier => 123,
                                   :creditCardExpirationMonth => 11, :creditCardExpirationYear => Time.now.year + 2,
                                   :address1 => 'travelnow' }))
    end

    private

    def services(path, args)
      HTTPService.make_request(path, args, :get)
    end

  end
end
