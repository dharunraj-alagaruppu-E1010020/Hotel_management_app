require 'rails_helper'

RSpec.describe User do
  subject { described_class.new(name: 'Dharun', phone_number: '9361320561', password: '1234567890Dh', role_id: '1')}
    describe "#display_name" do
      context "when display method call the rspec return name value" do
        it 'return name' do
          expect(subject.name).to eq('Dharun')
        end
      end

      context "when display method call the rspec return name value" do
        it 'invalid return name' do
          expect(subject.name).not_to eq('')
        end
      end
    end

    describe "#phone_number_valid?" do
      context "when phone number contains 10 digits" do
        it "returns true" do
          expect(subject.phone_number_valid?).to be_truthy
        end
      end
  
      context "when phone number contains less than 10 digits" do
        it "returns false" do
          user2 = described_class.new(phone_number: "123456789")
          expect(user2.phone_number_valid?).to be_falsey
        end
      end
  
      context "when phone number contains more than 10 digits" do
        it "returns false" do
          user3 = described_class.new(phone_number: "12345678901")
          expect(user3.phone_number_valid?).to be_falsey
        end
      end
  
      context "when phone number contains non-digit characters" do
        it "returns false" do
          user4 = described_class.new(phone_number: "123456789a")
          expect(user4.phone_number_valid?).to be_falsey
        end
      end
  
      context "when phone number is nil" do
        it "returns false" do
          user5 = described_class.new(phone_number: nil)
          expect(user5.phone_number_valid?).to be_falsey
        end
      end
    end

end
  