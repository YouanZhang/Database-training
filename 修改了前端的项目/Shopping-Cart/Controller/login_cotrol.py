from DAO.login import *

def getBuyerLoginDetails(email, password):
    vaild, data = buyer_login_info_valid(email, password)
    #print(data[0])
    if vaild:
        buyer_id = data[0][0]
        name = data[0][1]
        address = data[0][4]
    else:
        buyer_id = name = address = ' '
    return vaild, buyer_id, name, address

def getShopLoginDetails(email, password):
    vaild, data = shop_login_info_valid(email, password)
    #print(data[0])
    if vaild:
        shop_id = data[0][0]
        name = data[0][1]
        desc = data[0][2]
    else:
        shop_id = name = desc = ' '
    return vaild, shop_id, name, desc
#print(getBuyerLoginDetails('a.qq.com', '123456'))
#print(getShopLoginDetails('754032944@qq.com','123456'))