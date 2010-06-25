require 'optparse'

module FacebookCommands; class << self
  def stream(*args)
    if args.empty?
      puts 'stream by itself does nothing'
      return
    end

    if (args.first == 'help')
      puts 'stream publish'
      PUBLISH_PARAMS.each { |param|
        puts "  -#{param[0,1]}, --#{param} #{param.upcase}"
      }
      puts 'stream read'
      return
    end

    Stream.send(args.shift, *args)
  end

  private

  PUBLISH_PARAMS = ['message',
                    'picture',
                    'name',
                    'link',
                    'caption',
                    'description',
                    'source']

  class Stream; class << self
    def publish(*args)
      url, parameters, option_parser = 'me/feed', Hash.new, OptionParser.new

      PUBLISH_PARAMS.each { |param|
        short = "-#{param[0,1]}"
        long = "--#{param} #{param.upcase}"
        option_parser.on(short, long) { |value|
          parameters[param] = value
        }
      }
      option_parser.on('--friend FRIEND') { |friend|
        url = "#{friend}/feed"
      }
      option_parser.parse(args)

      unless parameters.has_key?('message')
        puts 'MESSAGE is required'
        return
      end

      result = JSON.parse(FacebookCL.post(url, parameters).body)
      if (result.has_key?('id'))
        puts "Success!  Post id is: #{result['id']}"
      elsif (result.has_key?('error'))
        puts 'Bummer. Error:'
        puts result['error']['message']
      else
        puts 'Unknown error..'
      end
    end

    def read(*args)
      stream = FacebookCL.get('me/feed')['data']
      stream.each { |post|
        puts post['message']
        puts "\n------------------------------------------------------------\n"
      }
    end

    def method_missing(verb, *args)
      puts "#{verb} is not an action on stream"
    end
  end; end
end; end