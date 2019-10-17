-- Normalise a vector
-- Input: a list of integers
-- Output: a list of integers
function normalise(list)
  local mag = magnitude(list)
  for i = 1, table.getn(list), 1 do
    list[i] = list[i]*(1/mag)
  end
  return list
end

-- Find the magnitude of a vector
-- Input: a list of integers
-- Output: an integer
function magnitude(list)
  local mag = 0
  for i = 1, table.getn(list), 1 do
    mag = mag + list[i]*list[i]
  end
  mag = mag^0.5
  return mag
end

-- Given the positions (x,y) and (u,v), generates a direction vector
-- between these points
function direction(x, y, u, v)
  local dir = {x-u, y-v}
  return dir
end

-- Finds the dot product of two vectors
-- Note: list1 & list2 must have same size
function dot(list1, list2)
	local product = 0
	for i = 1, table.getn(list1), 1 do
		product = product + list1[i]*list2[i]
	end

	return product
end

-- Returns the angle between two vectors
function angle(a, b)
	--local mag1 = magnitude(list1)
	--local mag2 = magnitude(list2)

	local angle = math.atan2(a, b)

	return angle+math.pi/2
end
