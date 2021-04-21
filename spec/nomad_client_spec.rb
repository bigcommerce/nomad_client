# frozen_string_literal: true

require 'spec_helper'

describe NomadClient do
  it 'has a version number' do
    expect(NomadClient::VERSION).not_to be_nil
  end
end
