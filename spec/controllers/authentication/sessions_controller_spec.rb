require 'rails_helper'

describe Authentication::SessionsController do
  let (:ben_raspail) { customers(:ben_raspail) }
  let (:hannibal_lecter) { physicians(:hannibal_lecter) }

  describe '#current' do
    it 'returns Error message when User is not authorized' do
      get :current

      expect(response).to be_successful
      expect(json_response['error']).to be_present
    end

    it 'returns Identity with User model inside when User is authorized' do
      sign_in(hannibal_lecter)
      get :current

      expect(response).to be_successful
      expect(json_response['identity']).to be_present
      expect(json_response.dig('identity', 'user')).to be_present
    end

    it 'includes Subscription when User is authorized Customer' do
      sign_in(ben_raspail)
      get :current

      expect(response).to be_successful
      expect(json_response['identity']).to be_present
      expect(json_response.dig('identity', 'user')).to be_present
      expect(json_response.dig('identity', 'user', 'subscription')).to be_present
    end
  end
end
