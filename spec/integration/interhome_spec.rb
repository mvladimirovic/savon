require "spec_helper"
class Interhome
  extend Savon::Model
  document "https://webservices.interhome.com/quality/partnerV3/WebService.asmx?WSDL"
  actions :availability
  client.config.soap_header = { 
    'ins0:ServiceAuthHeader' => { 
      'ins0:Username' => "",
      'ins0:Password' => "" 
    }
  }

  def self.check
    response = self.availability(:input_value => {"AccommodationCode" => "doesnotreallymatter",
                                                  "CheckIn"           => Date.parse("2020-01-01"),
                                                  "CheckOut"          => Date.parse("2020-01-31")}) 
  end 
end

describe "Email example" do

  it "should use client config" do
    response = Interhome.check
    error = response[:availability_response][:availability_result][:errors][:error][:description]	
    error.should_not == "Anonymous login not allowed"
  end

end
