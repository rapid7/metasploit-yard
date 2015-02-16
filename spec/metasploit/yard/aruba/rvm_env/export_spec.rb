require 'spec_helper'

RSpec.describe Metasploit::Yard::Aruba::RvmEnv::Export do
  context 'CONSTANTS' do
    context 'REGEXP' do
      subject(:regexp) {
        described_class::REGEXP
      }

      let(:name) {
        'rvm_env_string'
      }

      let(:set) {
        %Q{#{name}=#{quote}#{value}#{quote}}
      }

      let(:value) {
        'ruby-2.1.5@pro'
      }

      context 'with combined export and set' do
        let(:line) {
          %Q{export #{set}}
        }

        context 'with "' do
          let(:quote) {
            '"'
          }

          it 'matches groups correctly' do
            expect(regexp).to match(line)

            match = regexp.match(line)

            expect(match[:name]).to eq(name)
            expect(match[:value]).to eq(value)
          end
        end

        context "with '" do
          let(:quote) {
            "'"
          }

          it 'matches groups correctly' do
            expect(regexp).to match(line)

            match = regexp.match(line)

            expect(match[:name]).to eq(name)
            expect(match[:value]).to eq(value)
          end
        end
      end

      context 'with separate export and set' do
        let(:line) {
          %Q{export #{name} ; #{set}}
        }

        context 'with "' do
          let(:quote) {
            '"'
          }

          it 'matches groups correctly' do
            expect(regexp).to match(line)

            match = regexp.match(line)

            expect(match[:name]).to eq(name)
            expect(match[:value]).to eq(value)
          end
        end

        context "with '" do
          let(:quote) {
            "'"
          }

          it 'matches groups correctly' do
            expect(regexp).to match(line)

            match = regexp.match(line)

            expect(match[:name]).to eq(name)
            expect(match[:value]).to eq(value)
          end
        end
      end
    end
  end
end
