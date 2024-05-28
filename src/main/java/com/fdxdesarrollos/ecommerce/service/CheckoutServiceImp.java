package com.fdxdesarrollos.ecommerce.service;

import java.util.Set;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.fdxdesarrollos.ecommerce.dao.CustomerRepository;
import com.fdxdesarrollos.ecommerce.dto.Purchase;
import com.fdxdesarrollos.ecommerce.dto.PurchaseResponse;
import com.fdxdesarrollos.ecommerce.entity.Customer;
import com.fdxdesarrollos.ecommerce.entity.Order;
import com.fdxdesarrollos.ecommerce.entity.OrderItem;

import jakarta.transaction.Transactional;


@Service
public class CheckoutServiceImp implements CheckoutService {
	
	private CustomerRepository customerRepository;
	
	public CheckoutServiceImp(CustomerRepository customerRepository) {
		this.customerRepository = customerRepository;
	}

	@Override
	@Transactional
	public PurchaseResponse placeOrder(Purchase purchase) {
		// retrieve the order info from dto
		Order order = purchase.getOrder();
		
		// generate tracking number
		String orderTrackingNumber = generateOrderTrackingNumber();
		order.setOrderTrackingNumber(orderTrackingNumber);
		
		// populate order with orderItems
		Set<OrderItem> orderItems = purchase.getOrderItems();
		orderItems.forEach(item -> order.add(item));
		
		// populate order with billingAddress and shippingAddress
		order.setBillingAddress(purchase.getBillingAddress());
		order.setShippingAddress(purchase.getShippingAddress());
		
		// populate customer with order
		Customer customer = purchase.getCustomer();
		customer.add(order);
		
		// save to the database
		customerRepository.save(customer);
		
		// return a response
		return new PurchaseResponse(orderTrackingNumber);
	}
	
	private String generateOrderTrackingNumber() {
		// generate a random UUID number 
		return UUID.randomUUID().toString();
	}

}
