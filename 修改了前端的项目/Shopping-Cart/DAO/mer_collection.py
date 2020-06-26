from DAO.link_database import *

def addMerColletion(buyer_id, sku_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('INSERT INTO MER_COLLECTION VALUES (%s,%s);', (buyer_id, sku_id))
    conn.commit()
    cur.close()
    conn.close()

def findMerCollectionByBuyerID(buyer_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('SELECT * FROM MER_COLLECTION WHERE `BUYER_ID` = %s',(buyer_id,))
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data

def dropMerCollection(buyer_id, sku_id):
    conn = link_mysql()
    cur = conn.cursor()
    cur.execute('DELETE FROM MER_COLLECTION WHERE buyer_id = %s AND sku_id = %s',(buyer_id, sku_id))
    print('Deletion successed!')
    conn.commit()
    cur.close()
    conn.close()

#addMerColletion(5, 3)
#print(findMerCollectionByBuyerID(5))
#dropMerCollection(5, 3)
