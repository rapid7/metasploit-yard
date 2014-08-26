require 'spec_helper'

RSpec.describe Metasploit::Yard do
  context 'CONSTANTS' do
    context 'VERSION' do
      subject(:version) {
        described_class::VERSION
      }

      it { is_expected.to be_a String }
      it { is_expected.to match_regex(/\d+.\d+.\d+(-[a-zA-Z0-9]+)*/) }
    end
  end
end