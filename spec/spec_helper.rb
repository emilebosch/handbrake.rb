require 'bundler'
Bundler.setup

require 'rspec'

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'handbrake'

RSpec.configure do |config|
  # Captures everything printed to stdout during the block
  # and returns it as a string.
  def capture_stdout
    old_stdout, $stdout = $stdout, StringIO.new
    begin
      yield
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end

  def tmpdir(sub=nil)
    @tmpdir ||= begin
                  dirname = File.expand_path("../tmp", __FILE__)
                  mkdir_p dirname
                  dirname
                end
    if sub
      full = File.join(@tmpdir, sub)
      mkdir_p full
      full
    else
      @tmpdir
    end
  end
end
