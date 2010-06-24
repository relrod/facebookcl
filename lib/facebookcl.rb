require 'rubygems'

require 'json'
require 'net/http'
require 'net/https'
require 'open-uri'
require 'socket'
require 'uri'

module FacebookCL; class << self
  public

  APP_ID = 119412046078
  SERVER_PORT = 6682
  GRAPH_URL = 'graph.facebook.com'
  NEXT_URL = 'http://www.dev.facebook.com/connect/facebook_cl.php'

  attr_accessor :uid

  def authorize
    if (File.exists?(config_filename))
      puts "Loading authentication data from #{config_filename}"
      data = JSON.parse(File.open(config_filename){|file| file.read})
      self.access_token = data['access_token']
      self.uid = data['uid']
    else
      auth_url = "https://#{GRAPH_URL}/oauth/authorize?client_id=#{APP_ID}&redirect_uri=#{NEXT_URL}&scope=publish_stream,create_event,offline_access,email,read_stream,read_mailbox"

      if (RUBY_PLATFORM.downcase.include?("darwin"))
        `open '#{auth_url}'`
      else
        puts %Q{
Welcome New User!  You need to auth this application.  So please visit here in your browser of choice:

#{auth_url}}
      end

      session = TCPServer.new('127.0.0.1', SERVER_PORT).accept
      session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
      request = session.gets.strip

      session.print 'Success! ' +
        'You can close this window and return to FacebookCL now.'
      session.close

      self.access_token = request.
        gsub(/^GET \/\?access_token=/, '').
        gsub(/ HTTP.*$/, '')

      self.uid = get('me')['id']

      puts "Saving authentication data to #{config_filename}"
      File.open(config_filename, 'w') { |file|
        data = {'access_token' => access_token,
                'uid' => uid}
        file.puts data.to_json
      }

      puts "Type 'help' for details."
    end
  end

  def get(url, parameters = {})
    url = "https://#{GRAPH_URL}/#{url}/?access_token=#{access_token}"
    parameters.each {|key, value|
      url += "&#{key}=#{value}"
    }
    data = JSON.parse(open(URI.parse(url)).read)
    return data
  end

  def post(url, parameters = {})
    parameters['access_token'] = access_token
    http = Net::HTTP.new(GRAPH_URL, 443)
    http.use_ssl = true
    http.post("/#{url}",
              parameters.map{|key, value|"#{key}=#{value}"}.join('&'))
  end

  private

  attr_accessor :access_token

  def config_filename
    "#{ENV['HOME']}/.FacebookCL"
  end

  def prompt_value(prompt, error_message)
    print prompt
    value = gets.strip
    if block_given? and not yield value
      puts error_message
      prompt_value(prompt, error_message)
    else
      value
    end
  end
end; end