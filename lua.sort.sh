#/bin/sh
sha=`redis-cli -h ec2.dousl.com script load "
local vals
local ret
local cmp = function(a, b) 
	return tonumber(a) < tonumber(b)
end 

for k,v in pairs(KEYS) do 
	if 0 == redis.call('exists',v) then 
		return {err='key ['..v..'] is not exist.'}
	end

	if nil == tonumber(redis.call('get',v)) then
		return {err='key ['..v..']\'val is not a number.'}
	end
end

vals = redis.call('mget',unpack(KEYS))

table.sort(vals,cmp) 
return vals
"`
echo $sha
redis-cli -h ec2.dousl.com evalsha $sha 4 a c b d
