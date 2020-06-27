function getProductTotal(id, p) {
    var q = document.getElementById(id + "_quantity").value;
    document.getElementById(id + "_total").value = q * p/100;
    var cart_total = new Number;
    cart_total = 0;
    var list = document.getElementsByName("total");
    for (var i = 0; i < list.length; i++) {
        cart_total = Number(cart_total) + Number(list[i].value);
    }
    document.getElementById("cart_total").value = cart_total;
}