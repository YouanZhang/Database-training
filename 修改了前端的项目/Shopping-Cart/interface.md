注册接口

返回类型void register_buyer(name, password, email, address)

返回类型void register_shop(name, description, password,email)

返回类型 vaild, buyer_id, name, address getBuyerLoginDetails(email, password)

返回类型 vaild, shop_id, name, desc getShopLoginDetails(email, password)

登录接口

返回类型 bool,list buyer_login_info_valid(email, password)

返回类型 bool,list shop_login_info_valid(email, password)

加购物车接口

返回类型 bool addcart(buyer_id, sku_id, qty)

加仓库接口

返回类型 bool addstore(shop_id, sku_id, qty)

查询用户 

返回类型 bool, list find_buyer_by_id(id)

返回类型 bool, list find_buyer_by_email(id)

查询商家

返回类型 bool, list find_shop_by_id(id)

返回类型 bool, list find_shop_by_email()

加购物车

返回类型 bool addcart(buyer_id, sku_id, qty)

查询购物车

返回类型 list findcart(buyer_id, sku_id)

查询SPU

返回类型 bool, list findSPUbyid(id)

返回类型 bool, list findSPUbyname(name)

查询SKU

返回类型 bool, list findSKUbyid(id)

返回类型 bool, list findSKUbyname(name)

返回buyer_id, sku_id, qty, sku_name, sku_desc, price, SpuID, qty, city
 cart_detail(buyer_id):
 
 添加SKU addSKU(name, desc, price, SpuID, qty, city, shop_id)
 添加SPU addSPU(name, desc, second_class_id)
