require "nmax/version"
require "set"

module Nmax
  class Error < StandardError; end
  
  class Finder
    attr_reader :io, :n

    DIGITS = ('0'..'9').freeze

    def initialize(io, n)
      @io = io
      @n = n
    end

    def find
      buf = ''
      set = io.each_char.with_object(SortedSet.new) do |char, acc|
        if DIGITS.include?(char) 
          buf << char
        elsif !buf.empty?
          acc << buf.to_i
          buf.clear
        end
      end
      set.to_a.last(n)
    end
  end
end
