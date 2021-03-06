require 'spec_helper'

describe BitField::DatabaseUser do
  before do
    ActiveRecord::Schema.define do
      create_table :database_users, force: true do |t|
        t.string  :name
        t.integer :bitfield
      end
    end
  end

  it "works" do
    BitField::DatabaseUser.create!(
      name: "Artem",
      bitfield: { first: true, second: false, last: true }
    )

    record = BitField::DatabaseUser.first
    expect(record.bitfield.first?).to eq true
    expect(record.bitfield.second?).to eq false
    expect(record.bitfield.last?).to eq true

    record.update!(record.attributes)

    expect(record.bitfield.first?).to eq true
    expect(record.bitfield.second?).to eq false
    expect(record.bitfield.last?).to eq true
  end

end
