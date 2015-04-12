FactoryGirl.define do
  factory :boi_airport, class: Hash do
    initialize_with do
      {
        code: 'BOI',
        ll: '43.5644, -116.2228'
      }
    end
  end

  factory :ord_airport, class: Hash do
    initialize_with do
      {
        code: 'ORD',
        ll: '41.9786, -87.9047'
      }
    end
  end

  factory :ord_to_boi, class: Hash do
    initialize_with do
      YAML.load_file(Rails.root + 'spec/yaml/ord_to_boi.yaml')
    end
  end

  factory :ord, class: Geokit::GeoLoc do
    accuracy     { 4                }
    city         { "Chicago"        }
    country      { "United States"  }
    country_code { "US"             }
    district     { "Cook County"    }
    full_address { "Chicago IL USA" }
    lat          { 41.8781136       }
    lng          { -87.6297982      }
    precision    { "city"           }
    provider     { "google"         }
    province     { "IL"             }
    state_code   { "IL"             }
    state_name   { "Illinois"       }
    success      { true             }
  end

=begin

    flight_path.origion
 @accuracy=4,
 @all=[#<Geokit::GeoLoc:0x00000007c2f5e0 ...>],
 @city="Boise",
 @country="United States",
 @country_code="US",
 @district="Ada County",
 @full_address="Boise, ID, USA",
 @lat=43.6187102,
 @lng=-116.2146068,
 @precision="city",
 @provider="google",
 @province="ID",
 @state=nil,
 @state_code="ID",
 @state_name="Idaho",

=end
end
