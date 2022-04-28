require 'uri'
require 'net/http'
#require 'json'

def request(url, api_key = ENV['API_KEY'])
  url = URI("#{url}&api_key=#{api_key}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  request["cache-control"] = 'no-cache'
  request['app_key'] = ENV['API_KEY']
  response = http.request(request)
  JSON.parse(response.read_body)
end

data = request(ENV['URL_T'])

def build_web_page(data)
  photos = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
  photos.each do |photo|
    output += "\t<li><img src=\"#{photo["img_src"]}\"></li>\n"
  end
  output += "</ul>\n</body>\n</html>\n"
  File.write('output.html', output)
end

def photos_count(data)
  data['photos'].map{|x| x['camera']['name']}.group_by {|x| x}.map{|k,v| [k,
  v.count]}
end

build_web_page(data)
photos_count(data)
# [["CHEMCAM", 20], ["MAHLI", 2], ["NAVCAM", 4]]
