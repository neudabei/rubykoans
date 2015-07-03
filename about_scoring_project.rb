require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points DONE
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points. DONE
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice) 
  sum = 0 
  # You need to write this method

  #check for 1
  results1 = dice.select {|num| num <=1 }
    if results1.size == 3
      sum += 1000
    elsif results1.size == 4
      sum += 1000 + 100
    elsif results1.size == 5
      sum += 1000 + 200
    elsif results1.size < 3
      sum += results1.size * 100
    end

  #check for: A set of three numbers (other than ones) is worth 100 times the
  #number. (e.g. three fives is 500 points).
  triple_value = dice.detect{|num| dice.count(num) == 3}
  sum += triple_value * 100 unless (triple_value == nil) || (triple_value == 1)  # es sei denn tripe_value ist 1

  quadruple_value = dice.detect{|num| dice.count(num) == 4}
  sum += quadruple_value * 100 unless (quadruple_value == nil) || (quadruple_value == 1)  # es sei denn tripe_value ist 1

  # Check for 5: A five (that is not part of a set of three) is worth 50 points.
  if dice.include?(5) && unless (triple_value == 5) || (quadruple_value == 5)
      sum += 50 * (dice.count(5))
    end
  elsif dice.include?(5) && (quadruple_value == 5)
    sum += 50
  end
  
  sum
    
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
