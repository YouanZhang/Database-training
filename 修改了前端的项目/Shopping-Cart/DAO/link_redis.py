import redis

def link_redis():
    pool = redis.ConnectionPool(host='localhost', port=6379, decode_responses=True)
    r = redis.Redis(connection_pool=pool)
    return r

#r = link_redis()
#data = r.lrange(233, 0, -1)
#int_data = [int(x)for x in data]
#r.lpush(234, data)
#print(int_data)
#r.set('hello','world')
#print(r.keys())
#print(r.get('hello'))