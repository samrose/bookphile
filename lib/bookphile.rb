require 'sinatra/base'

class Bookphile < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :haml, {:format => :html5 }
  
  get '/' do
    'Hello Bookphile!'
  end
  
  get '/new' do
    haml :new_project
  end
end
