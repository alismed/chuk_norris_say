require 'rest-client'
require 'json'
require 'find'

  def call_api
    apis = {
	    icndb: "http://api.icndb.com/jokes/random",
	    yomomma: "http://api.yomomma.info/" }
    api = apis.to_a.sample
    response = RestClient.get(api.last)
    json     = JSON.parse(response)

    if api.include? :icndb
      joke = json.fetch("value").fetch("joke")
    else
      joke = json.fetch("joke")
    end

    joke.gsub(/'/, "\\\\'")
  end 

  animals = []
  regx = /.+?(?=\.cow)/
  Dir.foreach("/usr/share/cowsay/cows/") do |file|
    if regx.match(file)
      animals << regx.match(file)
    end
  end

system "cowsay -f #{animals.sample} #{call_api}"

