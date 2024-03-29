# this class loads the contents of a file using a Thread so that it's running
# outside your main Thread.
#
# Usage:
#   tio = ThreadIO.new.read('/tmp/a_large_file.txt')  # read a file
#   ... do other stuff ...
#
#   # optional loop until the file is read
#   loop do
#     break if tio.ready?
#     sleep 1
#   end
#
#   tio.string    # contains the contents of the file as one large String
class ThreadIO
  attr_reader :string,
              :lines

  def initialize
    @ready = false
    @string = nil
    @lines = nil
  end

  # this method returns immediately and loads the file in the background
  #
  # path: the path to the file you want to read.
  def read(path)
    @ready = false
    Thread.new do
      @string = nil
      @string = IO.read(path)
      @ready = true

      nil
    end

    nil
  end

  def read_lines(path)
    @ready = false
    Thread.new do
      @lines = []
      File.open(path, 'r') {|f| f.each_line{|l| @lines << l.chomp } }
      @ready = true

      nil
    end

    nil
  end

  def ready?
    @ready
  end
end
