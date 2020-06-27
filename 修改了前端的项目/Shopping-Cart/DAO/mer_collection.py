from DAO.link_database import *
from DAO.link_redis import *
from DAO.SKU import *
redislink = link_redis()
def addMerColletion(buyer_id, sku_id):
    conn = link_mysql()
    cur = conn.cursor()
    list = findMerCollectionByBuyerID(buyer_id)
    for x in list:
        if x == sku_id:
            return
    cur.execute('INSERT INTO MER_COLLECTION VALUES (%s,%s);', (buyer_id, sku_id))
    redislink.rpush(buyer_id, sku_id)
    conn.commit()
    cur.close()
    conn.close()

def findMerCollectionByBuyerID(buyer_id):
    #conn = link_mysql()
    #cur = conn.cursor()
    rdata = redislink.lrange(buyer_id, 0, -1)
    int_data = [int(x)for x in rdata]
    retlist = []
    for i in range(len(int_data)):
        valid, sku_info = findSKUbyid(int_data[i])
        if valid:
            retlist += sku_info
    #cur.execute('SELECT * FROM MER_COLLECTION WHERE `BUYER_ID` = %s',(buyer_id,))
    #data = cur.fetchall()
    #cur.close()
    #conn.close()
    return retlist

def dropMerCollection(buyer_id, sku_id):
    redislink.lrem(buyer_id, 0, sku_id)
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('DELETE FROM MER_COLLECTION WHERE buyer_id = %s AND sku_id = %s',(buyer_id, sku_id))
    print('Deletion successed!')
    conn.commit()
    cur.close()
    conn.close()

#addMerColletion(5, 3)
#print(findMerCollectionByBuyerID(233))
#dropMerCollection(5, 3)
