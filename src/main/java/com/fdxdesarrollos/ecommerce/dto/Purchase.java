package com.fdxdesarrollos.ecommerce.dto;

import java.util.Set;

import com.fdxdesarrollos.ecommerce.entity.Address;
import com.fdxdesarrollos.ecommerce.entity.Customer;
import com.fdxdesarrollos.ecommerce.entity.Order;
import com.fdxdesarrollos.ecommerce.entity.OrderItem;

import lombok.Data;

@Data
public class Purchase {
	private Customer customer;
	private Address shippingAddress;
	private Address billingAddress;
	private Order order;
	private Set<OrderItem> orderItems;
}
