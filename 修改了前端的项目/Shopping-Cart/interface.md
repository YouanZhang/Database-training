注册接口

返回类型void register_buyer(name, password, email, address)

返回类型void register_shop(name, description, password,email)

登录接口

返回类型 bool,list buyer_login_info_valid(email, password)

返回类型 bool,list shop_login_info_valid(email, password)

加购物车接口

返回类型 bool addcart(buyer_id, sku_id, qty)

加仓库接口

返回类型 bool addstore(shop_id, sku_id, qty)