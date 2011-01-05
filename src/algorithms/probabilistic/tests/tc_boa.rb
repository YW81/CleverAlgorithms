# Unit tests for boa.rb

# The Clever Algorithms Project: http://www.CleverAlgorithms.com
# (c) Copyright 2010 Jason Brownlee. Some Rights Reserved. 
# This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 2.5 Australia License.

require "test/unit"
require File.expand_path(File.dirname(__FILE__)) + "/../boa"

class TC_BOA < Test::Unit::TestCase

  # test that the objective function behaves as expected
  def test_onemax
    assert_equal(0, onemax([0,0,0,0]))
    assert_equal(4, onemax([1,1,1,1]))
    assert_equal(2, onemax([1,0,1,0]))
  end

  # test basic construction of random bitstrings
  def test_random_bitstring
    assert_equal(10, random_bitstring(10).size)
    assert_equal(10, random_bitstring(10).select{|x| x==0 or x==1}.size)    
  end
  
  # test the approximate proportion of 1's and 0's
  def test_random_bitstring_ratio
    s = random_bitstring(1000)
    assert_in_delta(0.5, (s.select{|x| x==0}.size/1000.0), 0.05)
    assert_in_delta(0.5, (s.select{|x| x==1}.size/1000.0), 0.05)
  end

  # test that members of the population are selected
  def test_binary_tournament
    pop = Array.new(10) {|i| {:fitness=>i} }
    10.times {assert(pop.include?(binary_tournament(pop)))}  
  end

  # test if a path exists between two nodes
  def test_path_exists
    # no path
    assert_equal(false, path_exists?(0, 1, [{:out=>[]}, {:out=>[]}]) )
    # 1=>0 but not 0=>1
    assert_equal(false, path_exists?(0, 1, [{:out=>[]}, {:out=>[0]}]) )
    # cycle
    assert_equal(false, path_exists?(0, 1, [{:out=>[2]}, {:out=>[]}, {:out=>[0]}]) )
    # direct
    assert_equal(true, path_exists?(0, 1, [{:out=>[1]}, {:out=>[]}]) )
    # indirect
    assert_equal(true, path_exists?(0, 1, [{:out=>[2]}, {:out=>[]}, {:out=>[1]}]) )
  end

  # test if edges are connected
  def test_connected
    # not connected
    assert_equal(false, connected?(0, 0, [{:out=>[]}]))
    assert_equal(false, connected?(0, 1, [{:out=>[]}, {:out=>[]}]))
    assert_equal(false, connected?(0, 1, [{:out=>[2]}, {:out=>[2]}, {:out=>[0,1]}]))
    # 1 is connected to 0, but not the other way around
    assert_equal(false, connected?(0, 1, [{:out=>[]}, {:out=>[0]}]))
    # connected
    assert_equal(true, connected?(0, 1, [{:out=>[1]}, {:out=>[]}]))
  end

  # tests whether an edge can be added
  def test_can_add_edge
    # path, not connected
    assert_equal(false, can_add_edge?(0, 1, [{:out=>[]}, {:out=>[0]}]) )
    # already exists
    assert_equal(false, can_add_edge?(0, 1, [{:out=>[1]}, {:out=>[]}]) )
    # path and already exists
    assert_equal(false, can_add_edge?(0, 1, [{:out=>[1]}, {:out=>[0]}]) )
    # no path and does not exist
    assert_equal(true, can_add_edge?(0, 1, [{:out=>[]}, {:out=>[]}]) )
  end

  # test the collection of viable edges
  def test_get_viable_edges
    # all
    viable = get_viable_edges(0, [{:out=>[]}, {:out=>[]}, {:out=>[]}])
    assert_equal([1, 2], viable)
    # none
    viable = get_viable_edges(0, [{:out=>[2]}, {:out=>[0]}, {:out=>[]}])
    assert_equal(true, viable.empty?)
  end




  # test the calculation of gains
  def test_recompute_gains
#    fail("Test not written")
  end

  # test the construction of a network from a population
  def test_construct_network
#    fail("Test not written")
  end
  
  # test sampling from the network
  def test_sample_from_network
#    fail("Test not written")
  end  
  
  # helper for turning off STDOUT
  # File activesupport/lib/active_support/core_ext/kernel/reporting.rb, line 39
  def silence_stream(stream)
    old_stream = stream.dup
    stream.reopen('/dev/null')
    stream.sync = true
    yield
  ensure
    stream.reopen(old_stream)
  end   
  
  # test that the algorithm can solve the problem
  def test_search
    best = nil
#    silence_stream(STDOUT) do
#      best = search(64, 50, 50)
#    end  
#    assert_not_nil(best[:fitness])
#    assert_equal(64, best[:fitness])
  end
  
end
