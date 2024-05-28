package com.fdxdesarrollos.ecommerce.service;

import com.fdxdesarrollos.ecommerce.dto.Purchase;
import com.fdxdesarrollos.ecommerce.dto.PurchaseResponse;

public interface CheckoutService {
	PurchaseResponse placeOrder(Purchase purchase);
}
