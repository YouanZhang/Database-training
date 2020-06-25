from DAO.cart import *
from DAO.SKU import *

#data格式
#[buyer_id, sku_id, qty], [sku_id, sku_name, sku_desc, price, SpuID, qty, city]
def cart_detail(buyer_id):
    data = findcart_by_buyerid(buyer_id)
    for i in range(len(data)):
        NULL, info = findSKUbyid(data[i][1])
        data[i] = [data[i]] + [info[0]]
        #print(data[i])
    return data

def cart_clean(buyer_id):

#print(cart_detail(1))
