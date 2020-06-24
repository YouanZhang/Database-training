from DAO.SKU import *
from DAO.shop import *

def addSKUbyemail(name, desc, price, SpuID, qty, city, email):
    NULL, data = find_shop_by_email(email)
    shop_id = data[0][0]
    addSKU(name, desc, price, SpuID, qty, city, shop_id)

#addSKUbyemail('华为P40Pro 8GB+128GB 红色','华为P40Pro，5G协议，存储量128GB, 红色', 5988, 3, 100, '广州', '2879156336@qq.com')
