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

  animals = []
  regx = /.+?(?=\.cow)/

  if system "whereis cowsay > /dev/null"
    cowsay_folder = ""

    Open3.pipeline_r("whereis cowsay") do |o,e| 
      cowsay_folder = o.read.chomp.split(' ')[2]
    end 
     
    Dir.foreach(cowsay_folder + "/cows") do |file|
      if regx.match(file)
        animals << regx.match(file)
      end
    end

    system "cowsay -f #{animals.sample} #{call_api} | lolcat"
  elsif
    p "cowsay not found"
  end

