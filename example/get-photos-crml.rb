require 'rets'

client = Rets::Client.new({
  login_url: 'domainURL',
  username: 'username',
  password: 'password',
  version: 'RETS/1.7.2' 
})

begin
    client.login
rescue => e
    puts 'Error: ' + e.message
    exit!
end

puts 'We connected! Lets get all the photos for a property...'

photos = client.find (:first), {
  search_type: 'Media',
  class: 'Media',
  query: '(MediaType=Image)'

}

photos.each_with_index do |data, index|
  File.open("property-#{index.to_s}.jpg", 'w') do |file|
    file.write data.body
  end
end

puts photos.length.to_s + ' photos saved.'
client.logout
