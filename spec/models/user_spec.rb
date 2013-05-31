require 'spec_helper'

describe User do
  it{should have_one :store}
  it{should have_one :cart}
  it{should have_many :line_items}
  it{should have_many :orders}
end
