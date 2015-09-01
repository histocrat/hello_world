require 'stringio'

class HelloWorld

  def self.interpret(**kwargs)
    new(**kwargs).interpret
  end

  def initialize(input: STDIN, output: STDOUT)
    @accumulator = 1
    @stack = []
    @input = input
    @output = output
  end

  def interpret(input = @input)
    input.each_char do |c|
      puts(" => %c: %p (%i)" % [c, @stack, @accumulator]) if ENV['VERBOSE']
      case c
      when 'c'
        @stack.push('' << (@stack.pop || ''))
      when 'h'
        @stack.push(get_user_input)
      when 'e'
        @stack.push(@stack.pop.to_i)
      when 'l'
        @stack.push(@stack.first)
      when 'o'
        x = @stack.pop
        if @looping && x == 0
          raise StopIteration
        elsif !@looping
          @looping = true
          branch = input.gets('o')
          loop{interpret(StringIO.new(branch))} rescue StopIteration
          @looping = false
        else
          @stack.push(@stack.last)
        end
      when ','
        @stack.push(@accumulator += 1)
      when '.'
        @stack.push(@accumulator -= 1)
      when ' '
        raise StopIteration if @stack.first == @accumulator
      when 'w'
        x = @stack.pop
        y = @stack.pop
        @stack.push(y % x)
      when 'm'
        x = @stack.pop
        y = @stack.pop
        @stack.push(x % y)
      when 'r'
        @stack.push(@stack.pop == 0 ? 1 : 0)
      when 'd'
        @stack.push(@stack.pop == 0 ? "false\n" : "true\n")
      when '!'
        @output.print @stack.pop
        return(0) if @stack.pop == 0
      when '0'..'9'
        x = @stack.pop
        if x.is_a?(Numeric) && x != 0
          @stack.push(x*10 + c.to_i)
        else
          @stack.push(x) if x
          @stack.push(c.to_i)
        end
      end
    end
    unless @looping
      raise 'Unexpected end of input. Please end programs with "!"'
    end
  end

  def get_user_input
    ARGV.shift || gets.chomp
  end

end
