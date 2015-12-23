require 'rest-client'
require 'json'
require 'find'
require 'pry'

  def call_api
    apis = { icndb: "http://api.icndb.com/jokes/random", yomomma: "http://api.yomomma.info/" }
    api = apis.to_a.sample
    response = RestClient.get(api[1])
    json     = JSON.parse(response)
    if api.include? :icndb
      joke = json.fetch("value").fetch("joke")
    else
      joke = json.fetch("joke")
    end
    joke
  end 

  animals = []
  Dir.foreach("/usr/share/cowsay/") do |file|
    if /.+?(?=\.cow)/.match(file)
      animals << /.+?(?=\.cow)/.match(file)
    end
  end

system "cowsay -f #{animals.sample} #{call_api}"


