require_relative 'hello_world_interpreter'

input = ARGV.shift

if input.nil?
  loop{HelloWorld.interpret(input: StringIO.new(gets))}
elsif File.file?(input)
    HelloWorld.interpret(input: StringIO.new(File.read(input)))
else
  HelloWorld.interpret(input: StringIO.new(input))
end
