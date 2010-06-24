require 'readline'
require 'shellwords'

require 'lib/FacebookCL.rb'
Dir.glob("commands/*.rb").each { |src| require src }

FacebookCL.authorize

HISTORY_FILENAME = "#{ENV['HOME']}/.FacebookCLHistory"
if (File.exists?(HISTORY_FILENAME))
  history_text = File.open(HISTORY_FILENAME, 'r'){|file| file.read}
  saved_history = JSON.parse(history_text)
  saved_history.each { |historical_event|
    Readline::HISTORY.push(historical_event)
  }
end

at_exit {
  File.open(HISTORY_FILENAME, 'w') { |file|
    file.puts Readline::HISTORY.to_a.to_json
  }
}

METHODS = FacebookCommands.singleton_methods - ['method_missing']
Readline.completion_proc = proc {|s|
  METHODS.grep(/^#{Regexp.escape(s)}/)
}

while line = Readline::readline('[FacebookCL] ', true)
  args = Shellwords.shellwords(line)
  FacebookCommands.send(args.shift, *args)
end