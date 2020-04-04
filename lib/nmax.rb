require "nmax/version"
require "set"

module Nmax
  class Error < StandardError; end

  class Buffer
    def initialize
      @buf = ''
    end

    def <<(d)
      @buf << d
    end

    def flush
      @buf.tap { @buf.clear } if !@buf.empty?
    end
  end
  
  class Finder
    attr_reader :io, :n

    DIGITS = ('0'..'9').freeze

    def initialize(io, n)
      @io = io
      @n = n
    end

    def find
      buf = Buffer.new
      set = io.each_char.with_object(SortedSet.new) do |char, acc|
        if DIGITS.include?(char) 
          buf << char 
        else
          num_str = buf.flush
          acc << num_str.to_i if num_str
        end
      end
      p set
    end
  end
end
