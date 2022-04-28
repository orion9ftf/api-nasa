require "uri"
require "json"
require "net/http"

def request

  url = URI(address)
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  request = Net::HTTP::Get.new(url)
  request["Authorization"] = ENV['AUTORIZATION']
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
    "content": "prueba desde postman!",
    "user_id": 1
  })
  
  response = https.request(request)
  #puts response.read_body
  JSON.parse response.read_body
end


def build_web_page(address)
end

body = request(ENV['URL'])

# iterar ese arreglo
body.each do |post|
  puts post['']
end


def photos_count
  '
  <html>
    <head>
    </head>
      <body>
        <ul>
          <li><img src='CR0_398380645PRCLF0030000CCAM04010L1.PNG'></li>
          <li><img src='CR0_398380645PRCLF0030000CCAM04010L1.PNG'></li>
        </ul>
      </body>
  </html>'
end