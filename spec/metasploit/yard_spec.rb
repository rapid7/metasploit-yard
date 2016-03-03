require 'spec_helper'

RSpec.describe Metasploit::Yard do
  context 'CONSTANTS' do
    context 'VERSION' do
      subject(:version) {
        described_class::VERSION
      }

      it 'is Metasploit::Yard::Version.full' do
        expect(version).to eq(Metasploit::Yard::version)
      end
    end
  end
end