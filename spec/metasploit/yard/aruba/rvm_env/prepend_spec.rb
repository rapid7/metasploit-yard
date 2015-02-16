require 'spec_helper'

RSpec.describe Metasploit::Yard::Aruba::RvmEnv::Prepend do
  context 'CONSTANTS' do
    context 'REGEXP' do
      subject(:regexp) {
        described_class::REGEXP
      }

      let(:name) {
        'PATH'
      }

      let(:prepend) {
        %Q{#{name}=#{quote}#{value}$#{name}#{quote}}
      }

      let(:value) {
        '/Users/bob/.rvm/gems/ruby-2.1.5@pro/bin:/Users/bob/.rvm/gems/ruby-2.1.5@global/bin:/Users/bob/.rvm/rubies/ruby-2.1.5/bin:/Users/bob/.rvm/bin:'
      }

      context 'with combined export and prepend' do
        let(:line) {
          %Q{export #{prepend}}
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

      context 'with separate export and prepend' do
        let(:line) {
          %Q{export #{name} ; #{prepend}}
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
