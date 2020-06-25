from DAO.order import *
from DAO.suborder import *
from Controller.cart_control import *
from DAO.SKU import *
import datetime

def createOrderFromCart(buyer_id, status, address, express_id):
    data = cart_detail(buyer_id)
    for row in data:
        user_qty = row[0][2]
        shop_qty = row[1][5]
        if user_qty > shop_qty:
            return False, 0, 0

    #创建父订单
    dt = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    OrderId = addNewOrder(buyer_id, dt, status, address)
    sumprice = 0

    for row in data:
        sku_id = row[0][1]
        user_qty = row[0][2]
        shop_qty = row[1][5]
        shop_id = row[1][7]
        price = row[1][3]
        money = price * user_qty
        addNewSubOrder(OrderId, sku_id, user_qty, shop_id, money, express_id)
        edit_SKU_QTY(sku_id, shop_qty - user_qty)
        sumprice += money

    return True, OrderId, sumprice

print(createOrderFromCart(1, 'paying', 'anqing', '222-333'))

