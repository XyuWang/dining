require 'spec_helper'

describe Cart do
  it {should validate_presence_of :user}
  it {should have_many :line_items}
  it {should belong_to :user}
  it {should belong_to :store}
end
