require 'spec_helper'

describe Comment do
  it {should validate_presence_of :context}
  it {should validate_presence_of :user}
  it {should validate_presence_of :product}
  it {should belong_to :line_item}
  it {should belong_to :product}
  it {should belong_to :user}
end
