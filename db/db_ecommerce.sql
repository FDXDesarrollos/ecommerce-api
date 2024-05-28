/*
 Navicat Premium Data Transfer

 Source Server         : LocalHost
 Source Server Type    : MariaDB
 Source Server Version : 100339
 Source Host           : 127.0.0.1:3366
 Source Schema         : db_ecommerce

 Target Server Type    : MariaDB
 Target Server Version : 100339
 File Encoding         : 65001

 Date: 28/05/2024 15:47:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of address
-- ----------------------------
BEGIN;
INSERT INTO `address` VALUES (1, 'sfdsf', 'Brazil', 'Acre', 'fsfsf', '19111');
INSERT INTO `address` VALUES (2, 'afasa', 'Canada', 'Alberta', 'afasa', 'afasa');
INSERT INTO `address` VALUES (3, 'manitoba', 'Canada', 'Manitoba', 'olivares', '56356');
INSERT INTO `address` VALUES (4, 'manitoba', 'Canada', 'Manitoba', 'olivares', '56356');
COMMIT;

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `id` smallint(5) unsigned NOT NULL,
  `code` varchar(2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of country
-- ----------------------------
BEGIN;
INSERT INTO `country` VALUES (1, 'BR', 'Brazil');
INSERT INTO `country` VALUES (2, 'CA', 'Canada');
INSERT INTO `country` VALUES (3, 'DE', 'Germany');
INSERT INTO `country` VALUES (4, 'IN', 'India');
INSERT INTO `country` VALUES (5, 'TR', 'Turkey');
INSERT INTO `country` VALUES (6, 'US', 'United States');
INSERT INTO `country` VALUES (7, 'MX', 'México');
COMMIT;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of customer
-- ----------------------------
BEGIN;
INSERT INTO `customer` VALUES (1, 'afasa', 'afasa', 'afasa@test.com');
INSERT INTO `customer` VALUES (2, 'susan', 'eriksson', 'susan.eriksson@gmail.com');
COMMIT;

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unit_price` decimal(19,2) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `K_order_id` (`order_id`),
  KEY `FK_product_id` (`product_id`),
  CONSTRAINT `FK_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of order_item
-- ----------------------------
BEGIN;
INSERT INTO `order_item` VALUES (1, 'assets/images/products/mousepads/mousepad-luv2code-1000.png', 1, 17.99, 1, 51);
INSERT INTO `order_item` VALUES (2, 'assets/images/products/coffeemugs/coffeemug-luv2code-1000.png', 1, 18.99, 1, 26);
INSERT INTO `order_item` VALUES (3, 'assets/img/products/coffeemugs/coffeemug-luv2code-1000.png', 1, 18.99, 2, 26);
INSERT INTO `order_item` VALUES (4, 'assets/img/products/books/book-luv2code-1004.png', 1, 18.99, 2, 5);
INSERT INTO `order_item` VALUES (5, 'assets/img/products/mousepads/mousepad-luv2code-1000.png', 1, 17.99, 2, 51);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_tracking_number` varchar(255) DEFAULT NULL,
  `total_price` decimal(19,2) DEFAULT NULL,
  `total_quantity` int(11) DEFAULT NULL,
  `billing_address_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `shipping_address_id` bigint(20) DEFAULT NULL,
  `status` varchar(128) DEFAULT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_billing_address_id` (`billing_address_id`),
  UNIQUE KEY `UK_shipping_address_id` (`shipping_address_id`),
  KEY `K_customer_id` (`customer_id`),
  CONSTRAINT `FK_billing_address_id` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FK_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` VALUES (1, '60787c63-135d-4357-86bd-a774e392a066', 36.98, 2, 1, 1, 2, NULL, '2024-05-27 19:25:09.842000', '2024-05-27 19:25:09.842000');
INSERT INTO `orders` VALUES (2, '0157ed64-1c45-4967-995d-80358c82a2ac', 55.97, 3, 3, 2, 4, NULL, '2024-05-28 15:41:15.254000', '2024-05-28 15:41:15.254000');
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `unit_price` decimal(13,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `active` bit(1) DEFAULT b'1',
  `units_in_stock` int(11) DEFAULT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `category_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of product
-- ----------------------------
BEGIN;
INSERT INTO `product` VALUES (1, 'BOOK-TECH-1000', 'Crash Course in Python', 'Learn Python at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 14.99, 'assets/img/products/books/book-luv2code-1000.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (2, 'BOOK-TECH-1001', 'Become a Guru in JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 20.99, 'assets/img/products/books/book-luv2code-1001.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (3, 'BOOK-TECH-1002', 'Exploring Vue.js', 'Learn Vue.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 14.99, 'assets/img/products/books/book-luv2code-1002.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (4, 'BOOK-TECH-1003', 'Advanced Techniques in Big Data', 'Learn Big Data at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 13.99, 'assets/img/products/books/book-luv2code-1003.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (5, 'BOOK-TECH-1004', 'Crash Course in Big Data', 'Learn Big Data at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 18.99, 'assets/img/products/books/book-luv2code-1004.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (6, 'BOOK-TECH-1005', 'JavaScript Cookbook', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 23.99, 'assets/img/products/books/book-luv2code-1005.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (7, 'BOOK-TECH-1006', 'Beginners Guide to SQL', 'Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 14.99, 'assets/img/products/books/book-luv2code-1006.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (8, 'BOOK-TECH-1007', 'Advanced Techniques in JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 16.99, 'assets/img/products/books/book-luv2code-1007.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (9, 'BOOK-TECH-1008', 'Introduction to Spring Boot', 'Learn Spring Boot at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 25.99, 'assets/img/products/books/book-luv2code-1008.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (10, 'BOOK-TECH-1009', 'Become a Guru in React.js', 'Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 23.99, 'assets/img/products/books/book-luv2code-1009.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (11, 'BOOK-TECH-1010', 'Beginners Guide to Data Science', 'Learn Data Science at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 24.99, 'assets/img/products/books/book-luv2code-1010.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (12, 'BOOK-TECH-1011', 'Advanced Techniques in Java', 'Learn Java at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 19.99, 'assets/img/products/books/book-luv2code-1011.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (13, 'BOOK-TECH-1012', 'Exploring DevOps', 'Learn DevOps at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 24.99, 'assets/img/products/books/book-luv2code-1012.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (14, 'BOOK-TECH-1013', 'The Expert Guide to SQL', 'Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 19.99, 'assets/img/products/books/book-luv2code-1013.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (15, 'BOOK-TECH-1014', 'Introduction to SQL', 'Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 22.99, 'assets/img/products/books/book-luv2code-1014.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (16, 'BOOK-TECH-1015', 'The Expert Guide to JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 22.99, 'assets/img/products/books/book-luv2code-1015.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (17, 'BOOK-TECH-1016', 'Exploring React.js', 'Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 27.99, 'assets/img/products/books/book-luv2code-1016.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (18, 'BOOK-TECH-1017', 'Advanced Techniques in React.js', 'Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 13.99, 'assets/img/products/books/book-luv2code-1017.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (19, 'BOOK-TECH-1018', 'Introduction to C#', 'Learn C# at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 26.99, 'assets/img/products/books/book-luv2code-1018.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (20, 'BOOK-TECH-1019', 'Crash Course in JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 13.99, 'assets/img/products/books/book-luv2code-1019.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (21, 'BOOK-TECH-1020', 'Introduction to Machine Learning', 'Learn Machine Learning at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 19.99, 'assets/img/products/books/book-luv2code-1020.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (22, 'BOOK-TECH-1021', 'Become a Guru in Java', 'Learn Java at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 18.99, 'assets/img/products/books/book-luv2code-1021.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (23, 'BOOK-TECH-1022', 'Introduction to Python', 'Learn Python at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 26.99, 'assets/img/products/books/book-luv2code-1022.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (24, 'BOOK-TECH-1023', 'Advanced Techniques in C#', 'Learn C# at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 22.99, 'assets/img/products/books/book-luv2code-1023.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (25, 'BOOK-TECH-1024', 'The Expert Guide to Machine Learning', 'Learn Machine Learning at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 16.99, 'assets/img/products/books/book-luv2code-1024.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 1);
INSERT INTO `product` VALUES (26, 'COFFEEMUG-1000', 'Coffee Mug - Express', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1000.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (27, 'COFFEEMUG-1001', 'Coffee Mug - Cherokee', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1001.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (28, 'COFFEEMUG-1002', 'Coffee Mug - Sweeper', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1002.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (29, 'COFFEEMUG-1003', 'Coffee Mug - Aspire', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1003.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (30, 'COFFEEMUG-1004', 'Coffee Mug - Dorian', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1004.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (31, 'COFFEEMUG-1005', 'Coffee Mug - Columbia', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1005.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (32, 'COFFEEMUG-1006', 'Coffee Mug - Worthing', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1006.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (33, 'COFFEEMUG-1007', 'Coffee Mug - Oak Cliff', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1007.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (34, 'COFFEEMUG-1008', 'Coffee Mug - Tachyon', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1008.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (35, 'COFFEEMUG-1009', 'Coffee Mug - Pan', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1009.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (36, 'COFFEEMUG-1010', 'Coffee Mug - Phase', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1010.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (37, 'COFFEEMUG-1011', 'Coffee Mug - Falling', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1011.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (38, 'COFFEEMUG-1012', 'Coffee Mug - Wispy', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1012.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (39, 'COFFEEMUG-1013', 'Coffee Mug - Arlington', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1013.png', b'1', 100, '2024-04-01 13:47:02.000000', NULL, 2);
INSERT INTO `product` VALUES (40, 'COFFEEMUG-1014', 'Coffee Mug - Gazing', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1014.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (41, 'COFFEEMUG-1015', 'Coffee Mug - Azura', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1015.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (42, 'COFFEEMUG-1016', 'Coffee Mug - Quantum Leap', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1016.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (43, 'COFFEEMUG-1017', 'Coffee Mug - Light Years', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1017.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (44, 'COFFEEMUG-1018', 'Coffee Mug - Taylor', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1018.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (45, 'COFFEEMUG-1019', 'Coffee Mug - Gracia', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1019.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (46, 'COFFEEMUG-1020', 'Coffee Mug - Relax', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1020.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (47, 'COFFEEMUG-1021', 'Coffee Mug - Windermere', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1021.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (48, 'COFFEEMUG-1022', 'Coffee Mug - Prancer', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1022.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (49, 'COFFEEMUG-1023', 'Coffee Mug - Recursion', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1023.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (50, 'COFFEEMUG-1024', 'Coffee Mug - Treasure', 'Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!', 18.99, 'assets/img/products/coffeemugs/coffeemug-luv2code-1024.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 2);
INSERT INTO `product` VALUES (51, 'MOUSEPAD-1000', 'Mouse Pad - Express', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1000.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (52, 'MOUSEPAD-1001', 'Mouse Pad - Cherokee', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1001.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (53, 'MOUSEPAD-1002', 'Mouse Pad - Sweeper', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1002.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (54, 'MOUSEPAD-1003', 'Mouse Pad - Aspire', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1003.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (55, 'MOUSEPAD-1004', 'Mouse Pad - Dorian', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1004.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (56, 'MOUSEPAD-1005', 'Mouse Pad - Columbia', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1005.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (57, 'MOUSEPAD-1006', 'Mouse Pad - Worthing', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1006.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (58, 'MOUSEPAD-1007', 'Mouse Pad - Oak Cliff', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1007.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (59, 'MOUSEPAD-1008', 'Mouse Pad - Tachyon', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1008.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (60, 'MOUSEPAD-1009', 'Mouse Pad - Pan', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1009.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (61, 'MOUSEPAD-1010', 'Mouse Pad - Phase', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1010.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (62, 'MOUSEPAD-1011', 'Mouse Pad - Falling', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1011.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (63, 'MOUSEPAD-1012', 'Mouse Pad - Wispy', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1012.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (64, 'MOUSEPAD-1013', 'Mouse Pad - Arlington', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1013.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (65, 'MOUSEPAD-1014', 'Mouse Pad - Gazing', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1014.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (66, 'MOUSEPAD-1015', 'Mouse Pad - Azura', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1015.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (67, 'MOUSEPAD-1016', 'Mouse Pad - Quantum Leap', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1016.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (68, 'MOUSEPAD-1017', 'Mouse Pad - Light Years', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1017.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (69, 'MOUSEPAD-1018', 'Mouse Pad - Taylor', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1018.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (70, 'MOUSEPAD-1019', 'Mouse Pad - Gracia', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1019.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (71, 'MOUSEPAD-1020', 'Mouse Pad - Relax', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1020.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (72, 'MOUSEPAD-1021', 'Mouse Pad - Windermere', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1021.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (73, 'MOUSEPAD-1022', 'Mouse Pad - Prancer', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1022.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (74, 'MOUSEPAD-1023', 'Mouse Pad - Recursion', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1023.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (75, 'MOUSEPAD-1024', 'Mouse Pad - Treasure', 'Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!', 17.99, 'assets/img/products/mousepads/mousepad-luv2code-1024.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 3);
INSERT INTO `product` VALUES (76, 'LUGGAGETAG-1000', 'Luggage Tag - Cherish', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1000.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (77, 'LUGGAGETAG-1001', 'Luggage Tag - Adventure', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1001.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (78, 'LUGGAGETAG-1002', 'Luggage Tag - Skyline', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1002.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (79, 'LUGGAGETAG-1003', 'Luggage Tag - River', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1003.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (80, 'LUGGAGETAG-1004', 'Luggage Tag - Trail Steps', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1004.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (81, 'LUGGAGETAG-1005', 'Luggage Tag - Blooming', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1005.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (82, 'LUGGAGETAG-1006', 'Luggage Tag - Park', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1006.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (83, 'LUGGAGETAG-1007', 'Luggage Tag - Beauty', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1007.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (84, 'LUGGAGETAG-1008', 'Luggage Tag - Water Fall', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1008.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (85, 'LUGGAGETAG-1009', 'Luggage Tag - Trail', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1009.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (86, 'LUGGAGETAG-1010', 'Luggage Tag - Skyscraper', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1010.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (87, 'LUGGAGETAG-1011', 'Luggage Tag - Leaf', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1011.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (88, 'LUGGAGETAG-1012', 'Luggage Tag - Jungle', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1012.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (89, 'LUGGAGETAG-1013', 'Luggage Tag - Shoreline', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1013.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (90, 'LUGGAGETAG-1014', 'Luggage Tag - Blossom', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1014.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (91, 'LUGGAGETAG-1015', 'Luggage Tag - Lock', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1015.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (92, 'LUGGAGETAG-1016', 'Luggage Tag - Cafe', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1016.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (93, 'LUGGAGETAG-1017', 'Luggage Tag - Darling', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1017.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (94, 'LUGGAGETAG-1018', 'Luggage Tag - Full Stack', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1018.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (95, 'LUGGAGETAG-1019', 'Luggage Tag - Courtyard', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1019.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (96, 'LUGGAGETAG-1020', 'Luggage Tag - Coaster', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1020.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (97, 'LUGGAGETAG-1021', 'Luggage Tag - Bridge', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1021.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (98, 'LUGGAGETAG-1022', 'Luggage Tag - Sunset', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1022.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (99, 'LUGGAGETAG-1023', 'Luggage Tag - Flames', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1023.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
INSERT INTO `product` VALUES (100, 'LUGGAGETAG-1024', 'Luggage Tag - Countryside', 'This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!', 16.99, 'assets/img/products/luggagetags/luggagetag-luv2code-1024.png', b'1', 100, '2024-04-01 13:47:03.000000', NULL, 4);
COMMIT;

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of product_category
-- ----------------------------
BEGIN;
INSERT INTO `product_category` VALUES (1, 'Books');
INSERT INTO `product_category` VALUES (2, 'Coffee Mugs');
INSERT INTO `product_category` VALUES (3, 'Mouse Pads');
INSERT INTO `product_category` VALUES (4, 'Luggage Tags');
COMMIT;

-- ----------------------------
-- Table structure for state
-- ----------------------------
DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country_id` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_country` (`country_id`),
  CONSTRAINT `fk_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of state
-- ----------------------------
BEGIN;
INSERT INTO `state` VALUES (1, 'Acre', 1);
INSERT INTO `state` VALUES (2, 'Alagoas', 1);
INSERT INTO `state` VALUES (3, 'Amapá', 1);
INSERT INTO `state` VALUES (4, 'Amazonas', 1);
INSERT INTO `state` VALUES (5, 'Bahia', 1);
INSERT INTO `state` VALUES (6, 'Ceará', 1);
INSERT INTO `state` VALUES (7, 'Distrito Federal', 1);
INSERT INTO `state` VALUES (8, 'Espírito Santo', 1);
INSERT INTO `state` VALUES (9, 'Goiás', 1);
INSERT INTO `state` VALUES (10, 'Maranhão', 1);
INSERT INTO `state` VALUES (11, 'Mato Grosso do Sul', 1);
INSERT INTO `state` VALUES (12, 'Mato Grosso', 1);
INSERT INTO `state` VALUES (13, 'Minas Gerais', 1);
INSERT INTO `state` VALUES (14, 'Paraná', 1);
INSERT INTO `state` VALUES (15, 'Paraíba', 1);
INSERT INTO `state` VALUES (16, 'Pará', 1);
INSERT INTO `state` VALUES (17, 'Pernambuco', 1);
INSERT INTO `state` VALUES (18, 'Piaui', 1);
INSERT INTO `state` VALUES (19, 'Rio de Janeiro', 1);
INSERT INTO `state` VALUES (20, 'Rio Grande do Norte', 1);
INSERT INTO `state` VALUES (21, 'Rio Grande do Sul', 1);
INSERT INTO `state` VALUES (22, 'Rondônia', 1);
INSERT INTO `state` VALUES (23, 'Roraima', 1);
INSERT INTO `state` VALUES (24, 'Santa Catarina', 1);
INSERT INTO `state` VALUES (25, 'Sergipe', 1);
INSERT INTO `state` VALUES (26, 'São Paulo', 1);
INSERT INTO `state` VALUES (27, 'Tocantins', 1);
INSERT INTO `state` VALUES (28, 'Alberta', 2);
INSERT INTO `state` VALUES (29, 'British Columbia', 2);
INSERT INTO `state` VALUES (30, 'Manitoba', 2);
INSERT INTO `state` VALUES (31, 'New Brunswick', 2);
INSERT INTO `state` VALUES (32, 'Newfoundland and Labrador', 2);
INSERT INTO `state` VALUES (33, 'Northwest Territories', 2);
INSERT INTO `state` VALUES (34, 'Nova Scotia', 2);
INSERT INTO `state` VALUES (35, 'Nunavut', 2);
INSERT INTO `state` VALUES (36, 'Ontario', 2);
INSERT INTO `state` VALUES (37, 'Prince Edward Island', 2);
INSERT INTO `state` VALUES (38, 'Quebec', 2);
INSERT INTO `state` VALUES (39, 'Saskatchewan', 2);
INSERT INTO `state` VALUES (40, 'Yukon', 2);
INSERT INTO `state` VALUES (41, 'Baden-Württemberg', 3);
INSERT INTO `state` VALUES (42, 'Bavaria', 3);
INSERT INTO `state` VALUES (43, 'Berlin', 3);
INSERT INTO `state` VALUES (44, 'Brandenburg', 3);
INSERT INTO `state` VALUES (45, 'Bremen', 3);
INSERT INTO `state` VALUES (46, 'Hamburg', 3);
INSERT INTO `state` VALUES (47, 'Hesse', 3);
INSERT INTO `state` VALUES (48, 'Lower Saxony', 3);
INSERT INTO `state` VALUES (49, 'Mecklenburg-Vorpommern', 3);
INSERT INTO `state` VALUES (50, 'North Rhine-Westphalia', 3);
INSERT INTO `state` VALUES (51, 'Rhineland-Palatinate', 3);
INSERT INTO `state` VALUES (52, 'Saarland', 3);
INSERT INTO `state` VALUES (53, 'Saxony', 3);
INSERT INTO `state` VALUES (54, 'Saxony-Anhalt', 3);
INSERT INTO `state` VALUES (55, 'Schleswig-Holstein', 3);
INSERT INTO `state` VALUES (56, 'Thuringia', 3);
INSERT INTO `state` VALUES (57, 'Andhra Pradesh', 4);
INSERT INTO `state` VALUES (58, 'Arunachal Pradesh', 4);
INSERT INTO `state` VALUES (59, 'Assam', 4);
INSERT INTO `state` VALUES (60, 'Bihar', 4);
INSERT INTO `state` VALUES (61, 'Chhattisgarh', 4);
INSERT INTO `state` VALUES (62, 'Goa', 4);
INSERT INTO `state` VALUES (63, 'Gujarat', 4);
INSERT INTO `state` VALUES (64, 'Haryana', 4);
INSERT INTO `state` VALUES (65, 'Himachal Pradesh', 4);
INSERT INTO `state` VALUES (66, 'Jammu & Kashmir', 4);
INSERT INTO `state` VALUES (67, 'Jharkhand', 4);
INSERT INTO `state` VALUES (68, 'Karnataka', 4);
INSERT INTO `state` VALUES (69, 'Kerala', 4);
INSERT INTO `state` VALUES (70, 'Madhya Pradesh', 4);
INSERT INTO `state` VALUES (71, 'Maharashtra', 4);
INSERT INTO `state` VALUES (72, 'Manipur', 4);
INSERT INTO `state` VALUES (73, 'Meghalaya', 4);
INSERT INTO `state` VALUES (74, 'Mizoram', 4);
INSERT INTO `state` VALUES (75, 'Nagaland', 4);
INSERT INTO `state` VALUES (76, 'Odisha', 4);
INSERT INTO `state` VALUES (77, 'Punjab', 4);
INSERT INTO `state` VALUES (78, 'Rajasthan', 4);
INSERT INTO `state` VALUES (79, 'Sikkim', 4);
INSERT INTO `state` VALUES (80, 'Tamil Nadu', 4);
INSERT INTO `state` VALUES (81, 'Telangana', 4);
INSERT INTO `state` VALUES (82, 'Tripura', 4);
INSERT INTO `state` VALUES (83, 'Uttar Pradesh', 4);
INSERT INTO `state` VALUES (84, 'Uttarakhand', 4);
INSERT INTO `state` VALUES (85, 'West Bengal', 4);
INSERT INTO `state` VALUES (86, 'Andaman and Nicobar Islands', 4);
INSERT INTO `state` VALUES (87, 'Chandigarh', 4);
INSERT INTO `state` VALUES (88, 'Dadra and Nagar Haveli', 4);
INSERT INTO `state` VALUES (89, 'Daman & Diu', 4);
INSERT INTO `state` VALUES (90, 'Lakshadweep', 4);
INSERT INTO `state` VALUES (91, 'Puducherry', 4);
INSERT INTO `state` VALUES (92, 'The Government of NCT of Delhi', 4);
INSERT INTO `state` VALUES (93, 'Alabama', 6);
INSERT INTO `state` VALUES (94, 'Alaska', 6);
INSERT INTO `state` VALUES (95, 'Arizona', 6);
INSERT INTO `state` VALUES (96, 'Arkansas', 6);
INSERT INTO `state` VALUES (97, 'California', 6);
INSERT INTO `state` VALUES (98, 'Colorado', 6);
INSERT INTO `state` VALUES (99, 'Connecticut', 6);
INSERT INTO `state` VALUES (100, 'Delaware', 6);
INSERT INTO `state` VALUES (101, 'District Of Columbia', 6);
INSERT INTO `state` VALUES (102, 'Florida', 6);
INSERT INTO `state` VALUES (103, 'Georgia', 6);
INSERT INTO `state` VALUES (104, 'Hawaii', 6);
INSERT INTO `state` VALUES (105, 'Idaho', 6);
INSERT INTO `state` VALUES (106, 'Illinois', 6);
INSERT INTO `state` VALUES (107, 'Indiana', 6);
INSERT INTO `state` VALUES (108, 'Iowa', 6);
INSERT INTO `state` VALUES (109, 'Kansas', 6);
INSERT INTO `state` VALUES (110, 'Kentucky', 6);
INSERT INTO `state` VALUES (111, 'Louisiana', 6);
INSERT INTO `state` VALUES (112, 'Maine', 6);
INSERT INTO `state` VALUES (113, 'Maryland', 6);
INSERT INTO `state` VALUES (114, 'Massachusetts', 6);
INSERT INTO `state` VALUES (115, 'Michigan', 6);
INSERT INTO `state` VALUES (116, 'Minnesota', 6);
INSERT INTO `state` VALUES (117, 'Mississippi', 6);
INSERT INTO `state` VALUES (118, 'Missouri', 6);
INSERT INTO `state` VALUES (119, 'Montana', 6);
INSERT INTO `state` VALUES (120, 'Nebraska', 6);
INSERT INTO `state` VALUES (121, 'Nevada', 6);
INSERT INTO `state` VALUES (122, 'New Hampshire', 6);
INSERT INTO `state` VALUES (123, 'New Jersey', 6);
INSERT INTO `state` VALUES (124, 'New Mexico', 6);
INSERT INTO `state` VALUES (125, 'New York', 6);
INSERT INTO `state` VALUES (126, 'North Carolina', 6);
INSERT INTO `state` VALUES (127, 'North Dakota', 6);
INSERT INTO `state` VALUES (128, 'Ohio', 6);
INSERT INTO `state` VALUES (129, 'Oklahoma', 6);
INSERT INTO `state` VALUES (130, 'Oregon', 6);
INSERT INTO `state` VALUES (131, 'Pennsylvania', 6);
INSERT INTO `state` VALUES (132, 'Rhode Island', 6);
INSERT INTO `state` VALUES (133, 'South Carolina', 6);
INSERT INTO `state` VALUES (134, 'South Dakota', 6);
INSERT INTO `state` VALUES (135, 'Tennessee', 6);
INSERT INTO `state` VALUES (136, 'Texas', 6);
INSERT INTO `state` VALUES (137, 'Utah', 6);
INSERT INTO `state` VALUES (138, 'Vermont', 6);
INSERT INTO `state` VALUES (139, 'Virginia', 6);
INSERT INTO `state` VALUES (140, 'Washington', 6);
INSERT INTO `state` VALUES (141, 'West Virginia', 6);
INSERT INTO `state` VALUES (142, 'Wisconsin', 6);
INSERT INTO `state` VALUES (143, 'Wyoming', 6);
INSERT INTO `state` VALUES (144, 'Adıyaman', 5);
INSERT INTO `state` VALUES (145, 'Afyonkarahisar', 5);
INSERT INTO `state` VALUES (146, 'Ağrı', 5);
INSERT INTO `state` VALUES (147, 'Aksaray', 5);
INSERT INTO `state` VALUES (148, 'Amasya', 5);
INSERT INTO `state` VALUES (149, 'Ankara', 5);
INSERT INTO `state` VALUES (150, 'Antalya', 5);
INSERT INTO `state` VALUES (151, 'Ardahan', 5);
INSERT INTO `state` VALUES (152, 'Artvin', 5);
INSERT INTO `state` VALUES (153, 'Aydın', 5);
INSERT INTO `state` VALUES (154, 'Balıkesir', 5);
INSERT INTO `state` VALUES (155, 'Bartın', 5);
INSERT INTO `state` VALUES (156, 'Batman', 5);
INSERT INTO `state` VALUES (157, 'Bayburt', 5);
INSERT INTO `state` VALUES (158, 'Bilecik', 5);
INSERT INTO `state` VALUES (159, 'Bingöl', 5);
INSERT INTO `state` VALUES (160, 'Bitlis', 5);
INSERT INTO `state` VALUES (161, 'Bolu', 5);
INSERT INTO `state` VALUES (162, 'Burdur', 5);
INSERT INTO `state` VALUES (163, 'Bursa', 5);
INSERT INTO `state` VALUES (164, 'Çanakkale', 5);
INSERT INTO `state` VALUES (165, 'Çankırı', 5);
INSERT INTO `state` VALUES (166, 'Çorum', 5);
INSERT INTO `state` VALUES (167, 'Denizli', 5);
INSERT INTO `state` VALUES (168, 'Diyarbakır', 5);
INSERT INTO `state` VALUES (169, 'Düzce', 5);
INSERT INTO `state` VALUES (170, 'Edirne', 5);
INSERT INTO `state` VALUES (171, 'Elazığ', 5);
INSERT INTO `state` VALUES (172, 'Erzincan', 5);
INSERT INTO `state` VALUES (173, 'Erzurum', 5);
INSERT INTO `state` VALUES (174, 'Eskişehir', 5);
INSERT INTO `state` VALUES (175, 'Gaziantep', 5);
INSERT INTO `state` VALUES (176, 'Giresun', 5);
INSERT INTO `state` VALUES (177, 'Gümüşhane', 5);
INSERT INTO `state` VALUES (178, 'Hakkâri', 5);
INSERT INTO `state` VALUES (179, 'Hatay', 5);
INSERT INTO `state` VALUES (180, 'Iğdır', 5);
INSERT INTO `state` VALUES (181, 'Isparta', 5);
INSERT INTO `state` VALUES (182, 'İstanbul', 5);
INSERT INTO `state` VALUES (183, 'İzmir', 5);
INSERT INTO `state` VALUES (184, 'Kahramanmaraş', 5);
INSERT INTO `state` VALUES (185, 'Karabük', 5);
INSERT INTO `state` VALUES (186, 'Karaman', 5);
INSERT INTO `state` VALUES (187, 'Kars', 5);
INSERT INTO `state` VALUES (188, 'Kastamonu', 5);
INSERT INTO `state` VALUES (189, 'Kayseri', 5);
INSERT INTO `state` VALUES (190, 'Kırıkkale', 5);
INSERT INTO `state` VALUES (191, 'Kırklareli', 5);
INSERT INTO `state` VALUES (192, 'Kırşehir', 5);
INSERT INTO `state` VALUES (193, 'Kilis', 5);
INSERT INTO `state` VALUES (194, 'Kocaeli', 5);
INSERT INTO `state` VALUES (195, 'Konya', 5);
INSERT INTO `state` VALUES (196, 'Kütahya', 5);
INSERT INTO `state` VALUES (197, 'Malatya', 5);
INSERT INTO `state` VALUES (198, 'Manisa', 5);
INSERT INTO `state` VALUES (199, 'Mardin', 5);
INSERT INTO `state` VALUES (200, 'Mersin', 5);
INSERT INTO `state` VALUES (201, 'Muğla', 5);
INSERT INTO `state` VALUES (202, 'Muş', 5);
INSERT INTO `state` VALUES (203, 'Nevşehir', 5);
INSERT INTO `state` VALUES (204, 'Niğde', 5);
INSERT INTO `state` VALUES (205, 'Ordu', 5);
INSERT INTO `state` VALUES (206, 'Osmaniye', 5);
INSERT INTO `state` VALUES (207, 'Rize', 5);
INSERT INTO `state` VALUES (208, 'Sakarya', 5);
INSERT INTO `state` VALUES (209, 'Samsun', 5);
INSERT INTO `state` VALUES (210, 'Siirt', 5);
INSERT INTO `state` VALUES (211, 'Sinop', 5);
INSERT INTO `state` VALUES (212, 'Sivas', 5);
INSERT INTO `state` VALUES (213, 'Şanlıurfa', 5);
INSERT INTO `state` VALUES (214, 'Şırnak', 5);
INSERT INTO `state` VALUES (215, 'Tekirdağ', 5);
INSERT INTO `state` VALUES (216, 'Tokat', 5);
INSERT INTO `state` VALUES (217, 'Trabzon', 5);
INSERT INTO `state` VALUES (218, 'Tunceli', 5);
INSERT INTO `state` VALUES (219, 'Uşak', 5);
INSERT INTO `state` VALUES (220, 'Van', 5);
INSERT INTO `state` VALUES (221, 'Yalova', 5);
INSERT INTO `state` VALUES (222, 'Yozgat', 5);
INSERT INTO `state` VALUES (223, 'Zonguldak', 5);
INSERT INTO `state` VALUES (224, 'Aguascalientes', 7);
INSERT INTO `state` VALUES (225, 'Baja California', 7);
INSERT INTO `state` VALUES (226, 'Baja California Sur', 7);
INSERT INTO `state` VALUES (227, 'Campeche', 7);
INSERT INTO `state` VALUES (228, 'Chiapas', 7);
INSERT INTO `state` VALUES (229, 'Chihuahua', 7);
INSERT INTO `state` VALUES (230, 'Ciudad de México', 7);
INSERT INTO `state` VALUES (231, 'Coahuila', 7);
INSERT INTO `state` VALUES (232, 'Colima', 7);
INSERT INTO `state` VALUES (233, 'Durango', 7);
INSERT INTO `state` VALUES (234, 'Estado de México', 7);
INSERT INTO `state` VALUES (235, 'Guanajuato', 7);
INSERT INTO `state` VALUES (236, 'Guerrero', 7);
INSERT INTO `state` VALUES (237, 'Hidalgo', 7);
INSERT INTO `state` VALUES (238, 'Jalisco', 7);
INSERT INTO `state` VALUES (239, 'Michoacán', 7);
INSERT INTO `state` VALUES (240, 'Morelos', 7);
INSERT INTO `state` VALUES (241, 'Nayarit', 7);
INSERT INTO `state` VALUES (242, 'Nuevo León', 7);
INSERT INTO `state` VALUES (243, 'Oaxaca', 7);
INSERT INTO `state` VALUES (244, 'Puebla', 7);
INSERT INTO `state` VALUES (245, 'Querétaro', 7);
INSERT INTO `state` VALUES (246, 'Quintana Roo', 7);
INSERT INTO `state` VALUES (247, 'San Luis Potosí', 7);
INSERT INTO `state` VALUES (248, 'Sinaloa', 7);
INSERT INTO `state` VALUES (249, 'Sonora', 7);
INSERT INTO `state` VALUES (250, 'Tabasco', 7);
INSERT INTO `state` VALUES (251, 'Tamaulipas', 7);
INSERT INTO `state` VALUES (252, 'Tlaxcala', 7);
INSERT INTO `state` VALUES (253, 'Veracruz', 7);
INSERT INTO `state` VALUES (254, 'Yucatán', 7);
INSERT INTO `state` VALUES (255, 'Zacatecas', 7);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
