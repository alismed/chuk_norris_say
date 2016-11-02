require 'rest-client'
require 'json'
require 'find'
require 'open3'
require 'lolcat'

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

  if system "whereis cowsay > /dev/null"
    animals_files = nil 

    Open3.pipeline_r('for i in $(cowsay -l); do echo "$i.cow"; done') do |o,e| 
      animals_files = o.read.chomp
      animals_files = animals_files.split("\n")
    end

    system "cowsay -f #{animals_files.sample.gsub('.cow', '')} #{call_api} | lolcat"
  elsif
    p "cowsay not found"
  end

