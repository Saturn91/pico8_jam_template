local code = {}

function sort(a)
	local temp = {}	
	for i=1,#a do
		temp[i] = a[i]
	end
    for i=1,#temp do
        local j = i
        while j > 1 and temp[j-1] > temp[j] do
            temp[j],temp[j-1] = temp[j-1],temp[j]
            j = j - 1
        end
    end
	return temp;
end

function code.sort(a)
    return (sort(a))
end

function abs(a) 
	return (a*a)^(1/2)
end

function code.abs(a)
	return abs(a)
end

function wrap_int(int, min_i, max_i, dir)
	if dir < -1 or dir > 1 then dir = dir/abs(dir) end
	if not dir then dir = 0 end
	local new_i = int+dir
	if new_i < min_i then return max_i end  
	if new_i > max_i then return min_i end
	return new_i
end

function code.wrap_int(int, min_i, max_i, dir)
    return wrap_int(int, min_i, max_i, dir)
end

return code