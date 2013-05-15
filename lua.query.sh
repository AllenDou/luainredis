#/bin/sh
sha=`redis-cli -h ec2.dousl.com script load "
local set1
local set2
local ret={}
local i=1
set1 = redis.call('zrange','key',2,4)
set2 = redis.call('zrange','key1',0,2)
for k,v in pairs(set1) do 
	for k1,v1 in pairs(set2) do 
		if (v1 == v) then 
			ret[i] = tostring(v)
			i = i +1
		end 
	end 
end 
return ret"`
echo $sha
redis-cli -h ec2.dousl.com evalsha $sha 0
