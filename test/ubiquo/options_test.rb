require File.dirname(__FILE__) + '/../helper.rb'

class TestOptions < Test::Unit::TestCase

  def setup
    @defaults = {
      :database => :sqlite,
      :template => :stable,
      :profile  => :complete,
    }
    @databases = [ :postgresql, :mysql, :sqlite ]
    @templates = [ :stable, :edge ]
    @profiles  = [ :complete, :minimal ]
  end
  
  def test_should_set_the_default_options
    opts = Options.new(["appname"])
    @defaults.each { |k,v| assert_equal opts[k], v}
  end

  def test_should_be_able_to_set_options
    opts = Options.new(["--mysql", "--edge", "--minimal", "myapp"])
    assert_equal :mysql,   opts[:database]
    assert_equal :edge,    opts[:template]
    assert_equal :minimal, opts[:profile]
    assert_equal "myapp",  opts[:app_name]
  end

  def test_should_merge_options
    opts = Options.new(%w[ --mysql myapp ])
    env_opts = Options.new(%w[ --edge ])
    options = opts.merge(env_opts)
    assert_equal :mysql,    options[:database]
    assert_equal :edge,     options[:template]
    assert_equal :complete, options[:profile]
    assert_equal "myapp",   options[:app_name]
  end
end
