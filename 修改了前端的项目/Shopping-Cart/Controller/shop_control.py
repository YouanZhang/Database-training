from DAO.shop import *

def change_shop_name(email, name):
    NULL, data = find_shop_by_email(email)
    shop_id = data[0][0]
    shop_name = name
    desc = data[0][2]
    password = data[0][3]
    update_shop(shop_id, shop_name, desc, password)

def change_shop_password(email, password):
    NULL, data = find_shop_by_email(email)
    shop_id = data[0][0]
    shop_name = data[0][1]
    desc = data[0][2]
    update_shop(shop_id, shop_name, desc, password)

def change_shop_descrip(email, desc):
    NULL, data = find_shop_by_email(email)
    shop_id = data[0][0]
    shop_name = data[0][1]
    password = data[0][3]
    update_shop(shop_id, shop_name, desc, password)

#change_buyer_name('754032944@qq.com', 'lulu')
#change_shop_name('754032944@qq.com', 'linlulu')