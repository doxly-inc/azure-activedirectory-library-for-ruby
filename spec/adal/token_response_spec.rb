require_relative '../spec_helper'

OAUTH_FIXTURES = File.expand_path('../../fixtures/oauth', __FILE__)

describe ADAL::TokenResponse do
  let(:response) { File.read(File.expand_path(file_name, OAUTH_FIXTURES)) }

  describe '::parse' do
    context 'with a successful response' do
      context 'with an id token' do
        let(:file_name) { 'success_with_id_token.json' }

        it 'should not raise any errors' do
          expect { ADAL::TokenResponse.parse(response) }.to_not raise_error
        end

        describe 'response' do
          subject { ADAL::TokenResponse.parse(response) }

          it { is_expected.to be_instance_of ADAL::SuccessResponse }

          describe '#error?' do
            # RSpec does some metaprogramming voodoo; this calls subject.error?.
            it { is_expected.to_not be_error }
          end
        end
      end

      context 'without an id token' do
        let(:file_name) { 'success.json' }

        it 'should not raise any errors' do
          expect { ADAL::TokenResponse.parse(response) }.to_not raise_error
        end

        describe 'response' do
          subject { ADAL::TokenResponse.parse(response) }

          it { is_expected.to be_instance_of ADAL::SuccessResponse }

          describe '#error?' do
            it { is_expected.to_not be_error }
          end
        end
      end
    end

    context 'with an error response' do
      let(:file_name) { 'error.json' }

      it 'should not raise any errors' do
        expect { ADAL::TokenResponse.parse(response) }.to_not raise_error
      end

      describe 'response' do
        subject { ADAL::TokenResponse.parse(response) }

        it { is_expected.to be_instance_of ADAL::ErrorResponse }

        describe '#error?' do
          it { is_expected.to be_error }
        end
      end
    end
  end

  context 'with a successful response' do
    let(:file_name) { 'success.json' }

    describe '::parse' do
    end
  end

  context 'with an error response' do
    let(:file_name) { 'error.json' }

    describe '::parse' do
    end
  end
end
