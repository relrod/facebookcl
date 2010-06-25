module FacebookCommands; class << self
  def method_missing(command, *args)
    puts "#{command} is not supported"
  end
end; end