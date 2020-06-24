from DAO.order import *
from DAO.suborder import *
from Controller.cart_control import *

def createOrderFromCart(buyer_id):
    data = cart_detail(buyer_id)
    for row in data:
        