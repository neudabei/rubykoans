# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  
  #conditions that make triangle impossible 0, 0, 0 || 3, 4, -5 || 1, 1, 3 || 2, 4, 2
  raise TriangleError, "This can't be a triangle" if a == 0 && b == 0 && c == 0
  raise TriangleError, "This can't be a triangle" if a <= 0 || b <= 0 || c <= 0
  raise TriangleError, "This can't be a triangle" if (a + b) <= c || (a + c) <= b || (c + b) <= a

  return :equilateral if a == b && b == c
  return :isosceles if (a == b && b != c) || (a != b && b == c) || (a != b && a == c)
  return :scalene if a != b && b != c && a != c
     
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
