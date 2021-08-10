require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { described_class.new }

  let :existing_category do
    described_class.create(
      title: 'not a unique title',
      description: 'a' * 55
    )
  end

  let(:category_on_tasks) { Category.reflect_on_association(:tasks).macro }

  context 'When title is not present' do
    it do
      subject.title = nil
      expect(subject).to_not be_valid

      subject.title = ''
      expect(subject).to_not be_valid
    end
  end

  context 'When title is not unique' do
    it do
      existing_category
      subject.title = 'not a unique title'
      expect(subject).to_not be_valid
    end
  end

  context 'When title is unique' do
    it do
      subject.title = 'unique title'
      expect(subject).to_not be_valid
    end
  end

  context 'When description is not present' do
    it do
      subject.description = nil
      expect(subject).to_not be_valid

      subject.description = ''
      expect(subject).to_not be_valid
    end
  end

  context 'When description length is not within minimum and maximum' do
    it do
      subject.description = 'a' * 9
      expect(subject).to_not be_valid

      subject.description = 'a' * 101
      expect(subject).to_not be_valid
    end
  end

  context 'When description length is within minimum and maximum' do
    it do
      subject.description = 'a' * 10
      expect(subject).to_not be_valid

      subject.description = 'a' * 100
      expect(subject).to_not be_valid
    end
  end

  context 'When title and description are valid' do
    it do
      subject.title = 'unique title'
      subject.description = 'a' * 20
      expect(subject).to be_valid
    end
  end

  context 'Has many tasks' do
    it { expect(category_on_tasks).to eq :has_many }
  end
end
