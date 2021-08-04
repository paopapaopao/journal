require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    described_class.new
  end

  let :existing_category do
    described_class.create(name: 'Not a unique Name')
  end

  context 'Name is not present' do
    context "Name is nil" do
      it 'does not validate' do
        subject.name = nil
        expect(subject).to_not be_valid
      end
    end

    context 'Name is an empty string' do
      it 'does not validate' do
        subject.name = ''
        expect(subject).to_not be_valid
      end
    end
  end

  context 'Name is not unique' do
    it 'does not validate' do
      existing_category
      subject.name = 'Not a unique Name'
      expect(subject).to_not be_valid
    end
  end

  context 'Name is unique' do
    it 'does validate' do
      subject.name = 'Unique Name'
      expect(subject).to be_valid
    end
  end
end
