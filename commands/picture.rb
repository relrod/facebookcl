require 'optparse'

module FacebookCommands; class << self
  public

  def picture(*args)
    if (args.first == 'help')
      puts 'picture <friend>'
      PICTURE_PARAMS.each { |param|
        puts "  -#{param[0,1]}, --#{param} #{param.upcase}"
      }
      return
    end

    if (`which jp2a`.strip.empty?)
      puts 'ERROR: You need jp2a: http://csl.sublevel3.org/jp2a/'
      return
    end

    user = args.empty? || args.first[0,1] == '-' ? FacebookCL.uid : args.shift

    parameters, option_parser = Hash.new, OptionParser.new
    PICTURE_PARAMS.each { |param|
      short = "-#{param[0,1]}"
      long = "--#{param} #{param.upcase}"
      option_parser.on(short, long) { |value|
        parameters[param] = value
      }
    }
    option_parser.parse(args)
    jp2a_options = parameters.map{|key, value| "--#{key}=#{value}"}

    puts `jp2a #{jp2a_options} http://graph.facebook.com/#{user}/picture`
  end

  private

  PICTURE_PARAMS = ['width',
                    'height']
end; end