require 'yaml'
Rails.application.config.middleware.use OmniAuth::Builder do
  API_KEYS = YAML.load_file('config/environments/development.yml')
  provider :twitter, API_KEYS['API_KEYS']['twitter']['key'], API_KEYS['API_KEYS']['twitter']['secret']
  provider :facebook, API_KEYS['API_KEYS']['facebook']['key'], API_KEYS['API_KEYS']['facebook']['secret']
  provider :vkontakte, API_KEYS['API_KEYS']['vkontakte']['key'], API_KEYS['API_KEYS']['vkontakte']['secret']
end
