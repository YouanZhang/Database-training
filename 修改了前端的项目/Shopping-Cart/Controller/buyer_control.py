from DAO.buyer import *

def change_buyer_name(email, name):
    NULL, data = find_buyer_by_email(email)
    buyer_id = data[0][0]
    buyer_name = name
    password = data[0][2]
    address = data[0][4]
    update_buyer(buyer_id, buyer_name, password, address)

def change_buyer_password(email, password):
    NULL, data = find_buyer_by_email(email)
    buyer_id = data[0][0]
    buyer_name = data[0][1]
    address = data[0][4]
    update_buyer(buyer_id, buyer_name, password, address)

def change_buyer_address(email, address):
    NULL, data = find_buyer_by_email(email)
    buyer_id = data[0][0]
    buyer_name = data[0][1]
    password = data[0][2]
    update_buyer(buyer_id, buyer_name, password, address)

#change_buyer_name('754032944@qq.com', 'lulu')