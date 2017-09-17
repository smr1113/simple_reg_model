require 'minitest/autorun'
require_relative "../lib/reg_block"
require_relative "../lib/register"

class TestBlockJson < MiniTest::Test
  include SRM
  def setup
    @user_spec = %Q(
RegBlock.new(name: "cpu_reg32") do |model|
  model << SRM::Register.new(name: "r1_reg") do |r|
                  r << SRM::Field.new(name: "field", nbits: 32, lsb_pos: 0, volatile: false, 
                                 hard: 0xdeadbeef, mbist: 0x0)
            end
end
)
  end

  def test_eval
    r1 = eval(@user_spec)
    assert_equal "cpu_reg32", r1.name
    assert_equal "r1_reg", r1.nodes[0].name
    assert_equal SRM::RegBlock, r1.class
    assert_equal SRM::Register, r1.nodes[0].class
  end

end

