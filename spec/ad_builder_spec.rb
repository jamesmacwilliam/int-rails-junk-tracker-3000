require "rails_helper"

describe "AdBuilder" do
  describe "#create_ad" do
    let(:vehicle) { create(:vehicle, vehicle_type: vehicle_type, registration_id: registration_id) }
    let(:registration_id) { "415Hn3JTu7obqNj151gmuscoq0kWCy" }
    let(:vehicle_type) { create(:vehicle_type, name: type_name) }
    let(:type_name) { "Sedan" }
    let(:works) { create(:part_status, name: "Works") }
    let(:fixable) { create(:part_status, name: "Fixable") }
    let(:engine) { create(:part, name: "Engine") }

    it "includes Vehicle's nickname" do
      vehicle.nickname = "some nickname"

      expect(AdBuilder.create_ad(vehicle)).to include("some nickname")
    end

    describe "when vehicle is a Sedan" do
      before do
        vehicle.nickname = "2020 Honda Civic"
        vehicle.mileage = 5134
        vehicle.save
        create(:vehicle_part, vehicle: vehicle, part_status: works, part: engine)
        vehicle.reload
      end

      it "looks like this" do
        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          2020 Honda Civic
          Registration number: #{registration_id}
          Mileage: Low (5,134)
          Engine: Works
        AD
      end
    end

    describe "when vehicle is a Coupe" do
      let(:type_name) { "Coupe" }

      before do
        vehicle.nickname = "2021 Honda Civic"
        vehicle.mileage = 21_980
        vehicle.save
        create(:vehicle_part, vehicle: vehicle, part_status: works, part: engine)
        vehicle.reload
      end

      it "looks like this" do
        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          2021 Honda Civic
          Registration number: #{registration_id}
          Mileage: Medium (21,980)
          Engine: Works
        AD
      end
    end

    describe "when vehicle is a Mini-Van" do
      let(:type_name) { "Mini-Van" }

      before do
        vehicle.headline = "Looking for a Mini-Van? Look no further!"
        vehicle.nickname = "~~~ 2009 Dodge Caravan ~~~"
        vehicle.mileage = 5_134
        vehicle.save
        create(:vehicle_part, vehicle: vehicle, part_status: works, part: engine)
        create_list(:door, 2, vehicle: vehicle, is_sliding: true)
        create_list(:door, 2, vehicle: vehicle)
        vehicle.reload
      end

      it "looks like this" do
        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          Looking for a Mini-Van? Look no further!

          ~~~ 2009 Dodge Caravan ~~~

          Registration number: #{registration_id}
          Mileage: Low (5,134)
          Engine: Works
          Regular Doors: 2
          Sliding Doors: 2
        AD
      end
    end

    describe "when vehicle is a Motorcycle" do
      let(:type_name) { "Motorcycle" }
      let(:seat) { create(:part, name: "Seat") }

      before do
        vehicle.headline = "~~~ Motorcycle for Sale ~~~"
        vehicle.nickname = "2019 Ducati Sportbike Motorcycle PANIGALE V4 SPECIALE"
        vehicle.mileage = 105_777
        vehicle.stacked_ad = true
        vehicle.save
        create(:vehicle_part, vehicle: vehicle, part_status: works, part: engine)
        create(:vehicle_part, vehicle: vehicle, part_status: fixable, part: seat)
        vehicle.reload
      end

      it "looks like this" do
        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          ~~~ Motorcycle for Sale ~~~

          2019 Ducati Sportbike Motorcycle PANIGALE V4 SPECIALE

          Registration number:
          #{registration_id}

          Mileage:
          High (105,777)

          Engine:
          Works

          Seat:
          Fixable
        AD
      end
    end
  end
end
