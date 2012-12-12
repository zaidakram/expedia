require 'spec_helper'

describe "Expedia::HTTPService" do

	it "has an API_SERVER Constant" do
	  Expedia::HTTPService.constants.should include(:API_SERVER)
	end

	it "has an RESERVATION_SERVER Constant" do
	  Expedia::HTTPService.constants.should include(:RESERVATION_SERVER)
	end

	describe "server" do
		
		it "return API server when no options are provided" do
			Expedia::HTTPService.server.should =~ Regexp.new(Expedia::HTTPService::API_SERVER)
		end

		it "return server with http when options[:use_ssl] are not provided" do
			Expedia::HTTPService.server.should eql "http://#{Expedia::HTTPService::API_SERVER}"
		end

		it "return RESERVATION server when options[:reservation_api]" do
			Expedia::HTTPService.server({ :reservation_api => true }).should =~ Regexp.new(Expedia::HTTPService::RESERVATION_SERVER)
		end

		it "return server with https when options[:use_ssl]" do
			Expedia::HTTPService.server( {:use_ssl => true }).should eql "https://#{Expedia::HTTPService::API_SERVER}"
		end

	end

	describe "signature and add_common_parameters" do

		before :each do
		  Expedia.cid = ''
		  Expedia.api_key =''
		  Expedia.shared_secret = ''

		end


		it "returns a ligit MD5 checksum" do
			Expedia::HTTPService.signature.should_not eql nil
			Expedia::HTTPService.signature.should_not eql ''
		end

		it "returns a hash containing common params" do
			Expedia::HTTPService.add_common_parameters.keys.should include(:cid)
			Expedia::HTTPService.add_common_parameters.keys.should include(:apiKey)
			Expedia::HTTPService.add_common_parameters.keys.should include(:sig)
			Expedia::HTTPService.add_common_parameters.keys.should include(:_type)
		end
	end

	describe "make_request" do

		# it "Gets an Expedia::HTTPService::Response object if everthing goes fine." do
		# 	Expedia::HTTPService.make_request("/ean-services/rs/hotel/v3/list",
		# 		{:propertyName => 'Hotel Moa Berlin', :destinationString => 'berlin'},
		# 		:get).class.to_s.should eql 'Expedia::HTTPService::Response'
		# end

		it "Gets an Expedia::APIError object if any exception occurs." do
			Expedia::HTTPService.make_request("/somthing", {}, :get).class.to_s.should eql 'Expedia::APIError'
		end

	end


end