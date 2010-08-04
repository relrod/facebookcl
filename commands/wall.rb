module FacebookCommands
  class << self
    def wall(*args)
      if args.empty?
        puts 'wall by itself does nothing'
        return
      end

      if (args.first == 'help')
        puts 'wall post <friend>'
        PUBLISH_PARAMS.each { |param|
          puts "  -#{param[0,1]}, --#{param} #{param.upcase}"
        }
        return
      end

      Wall.send(args.shift, *args)
    end

    private

    class Wall
      class << self
        def post(*args)
          if (args.empty?)
            puts 'wall post requires a <friend>'
            return
          end

          Stream.publish(*args.unshift('--friend'))
        end

        def method_missing(verb, *args)
          puts "#{verb} is not an action on wall"
        end
      end # end class
    end # end Wall 
  end # end class
end # end module