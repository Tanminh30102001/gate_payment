-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for alaba_test


-- Dumping structure for table alaba_test.addons
CREATE TABLE IF NOT EXISTS `addons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.addons: ~0 rows (approximately)

-- Dumping structure for table alaba_test.admins
CREATE TABLE IF NOT EXISTS `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verify_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verify_code` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.admins: ~0 rows (approximately)
INSERT INTO `admins` (`id`, `name`, `email`, `email_verify_token`, `phone`, `photo`, `status`, `password`, `remember_token`, `role`, `verify_code`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin@gmail.com', '', '09000000', '18454587891642651833.jpg', 1, '$2a$12$XL0y.w8hk1XyIiXoq3IZk.RTAtyZiEViTxhqsTOBYuXBqkCL7Zj1y', 'tW7nwmuXYjPz7uCZxnCgNhqoYjhasrrWMmA3WWfavPaaCi0YU2bvfA5cv1Oz', 'super-admin', 726094, NULL, '2022-02-14 22:11:28');

-- Dumping structure for table alaba_test.agents
CREATE TABLE IF NOT EXISTS `agents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `zip` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1 => ''active'', 0 => ''banned'' , 2 => ''agent request''',
  `email_verified` tinyint(1) DEFAULT NULL,
  `verify_code` int DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_fa_status` tinyint(1) NOT NULL DEFAULT '0',
  `two_fa` tinyint(1) DEFAULT '0',
  `two_fa_code` int DEFAULT NULL,
  `nid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nid_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.agents: ~0 rows (approximately)

-- Dumping structure for table alaba_test.api_creds
CREATE TABLE IF NOT EXISTS `api_creds` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int NOT NULL,
  `access_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mode` tinyint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.api_creds: ~0 rows (approximately)
INSERT INTO `api_creds` (`id`, `merchant_id`, `access_key`, `mode`, `created_at`, `updated_at`) VALUES
	(1, 1, '152c507b-3f0d-49ff-bd3b-784e09c16584', 1, '2023-09-20 01:48:36', '2023-09-27 03:52:46'),
	(2, 2, '2fe6b081-38c0-42bb-9fca-c8dd2e222e86', 0, '2024-06-18 20:58:12', '2024-06-18 20:58:12');

-- Dumping structure for table alaba_test.api_deposits
CREATE TABLE IF NOT EXISTS `api_deposits` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `txn_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `charge` double DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `payment_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `method` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `txn_details` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table alaba_test.api_deposits: ~0 rows (approximately)

-- Dumping structure for table alaba_test.api_payment_processes
CREATE TABLE IF NOT EXISTS `api_payment_processes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pay_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `method_id` int NOT NULL,
  `wallet_id` int NOT NULL,
  `currency_id` int NOT NULL,
  `amount` decimal(18,8) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.api_payment_processes: ~0 rows (approximately)

-- Dumping structure for table alaba_test.blogs
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `views` int NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.blogs: ~3 rows (approximately)
INSERT INTO `blogs` (`id`, `category_id`, `title`, `slug`, `photo`, `description`, `views`, `status`, `created_at`, `updated_at`) VALUES
	(66, 8, 'Simplify Your Financial Lifes with Alaba Pay', 'simplify-your-financial-lifes-with-alaba-pay', '9222363811644728965.jpg', '<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">In an increasingly digital world, the way we handle money has transformed significantly. Digital wallets offer unparalleled convenience and security, with Alaba Pay leading the way. Here’s why Alaba Pay is the ultimate choice for managing your finances.</span></p>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">What Sets Alaba Pay Apart?</span></p>\r\n\r\n<ol><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">User-Centric Design</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Our intuitive interface makes Alaba Pay accessible to everyone, regardless of tech-savviness. Every feature is crafted for a seamless experience.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Comprehensive Payment Solutions</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Alaba Pay supports various payment methods, from QR code payments to instant money transfers and bill payments, covering all your financial needs.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Exceptional Security Measures</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Security is a top priority at Alaba Pay. We use advanced encryption and multi-factor authentication to safeguard your financial data, providing peace of mind with every transaction.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Cost-Effective Transactions</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Alaba Pay offers some of the lowest transaction fees in the industry, helping you manage your finances more effectively without hidden charges.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Real-Time Support</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Our global 24/7 support team is always ready to assist you, ensuring timely and effective solutions to any issues or questions.</span></p></li></ol>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Conclusion</span></p>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">Alaba Pay is more than just a digital wallet; it’s a comprehensive financial tool designed to simplify and enhance your transactions. With its user-friendly design, robust security, cost-effective transactions, and exceptional customer support, Alaba Pay stands out as the ultimate choice for your digital wallet needs. Experience the future of financial management with Alaba Pay and take control of your finances with ease and confidence.</span></p>\r\n\r\n<p style="text-align:justify;"><span><br></span></p>', 1, 1, '2022-02-12 23:09:25', '2024-06-20 23:42:21'),
	(67, 9, 'Simplify Your Financial Life with Alaba Pay', 'simplify-your-financial-life-with-alaba-pay', '16948648621645511038.jpg', '<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">In today\'s fast-paced world, managing finances efficiently is more important than ever. Digital wallets have become essential tools for simplifying financial transactions, and Alaba Pay stands out as a leading choice. Here’s how Alaba Pay can make your financial life easier and more convenient.</span></p>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Key Benefits of Alaba Pay</span></p>\r\n\r\n<ol><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Effortless Payments</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Say goodbye to carrying cash or multiple cards. With Alaba Pay, make quick and easy payments with just a tap, saving you time and effort.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Comprehensive Financial Management</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Alaba Pay is a powerful tool for managing your finances. Track spending, set budgets, and monitor your financial health all in one place with our intuitive interface.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Instant Money Transfers</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Send money to friends or family in real-time. With low fees and competitive exchange rates, transferring money has never been more affordable and efficient.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Secure and Private</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Security is a cornerstone of Alaba Pay. We use advanced encryption and multi-factor authentication to protect your data and ensure your transactions are secure.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Rewards and Cashback</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Earn points with every payment and redeem them for discounts or special offers. Get more value from your spending with Alaba Pay.</span></p></li></ol>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Conclusion</span></p>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">From easy payments and instant transfers to robust security and valuable rewards, Alaba Pay offers a comprehensive solution for modern financial management. Embrace the convenience and efficiency of Alaba Pay today.</span></p>\r\n\r\n<p style="text-align:justify;"><span><br></span></p>', 1, 1, '2022-02-12 23:11:32', '2024-06-20 23:41:33'),
	(68, 10, 'Embracing the Future of Finance with Alaba Pay', 'embracing-the-future-of-finance-with-alaba-pay', '609659891645511084.jpg', '<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">The digital revolution has transformed the way we handle money, and digital wallets are at the forefront of this change. Alaba Pay is leading the way, offering a secure, convenient, and efficient platform for all your financial needs. In this blog post, we explore the numerous benefits of using Alaba Pay and how it can enhance your financial experience.</span></p>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Why Choose Alaba Pay?</span></p>\r\n\r\n<ol><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Unparalleled Security</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> At Alaba Pay, your security is our top priority. We employ state-of-the-art encryption and stringent security measures to ensure your financial data is always protected.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Seamless Transactions</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Gone are the days of waiting for transactions to process. With Alaba Pay, enjoy instant transfers and payments, whether you\'re sending money to a friend or paying for a service.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Global Reach</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Traveling or conducting business abroad? Alaba Pay supports international transactions, allowing you to send and receive money across borders with ease. Our competitive exchange rates and low fees make global financial interactions simpler and more affordable.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">User-Friendly Interface</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> Navigating financial apps can sometimes be daunting, but Alaba Pay\'s intuitive interface makes it easy for users of all ages and tech-savviness levels.</span></p></li><li><p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">24/7 Customer Support</span><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;"> We understand that financial queries can arise at any time. That’s why Alaba Pay offers round-the-clock customer support to assist you with any issues or questions you might have.</span></p></li></ol>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:700;font-style:normal;text-decoration:none;">Conclusion</span></p>\r\n\r\n<p><span style="font-size:11pt;font-family:Arial, sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">Alaba Pay is more than just a digital wallet; it’s a comprehensive financial solution designed to make your life easier. With unmatched security, instant processing, global coverage, and exceptional customer support, Alaba Pay is your trusted partner in navigating the digital financial landscape. Join the millions of satisfied users and embrace the future of finance with Alaba Pay today.</span></p>\r\n\r\n<p style="text-align:justify;"><span><br></span></p>', 11, 1, '2022-02-22 00:24:44', '2024-06-21 01:04:49');

-- Dumping structure for table alaba_test.blog_categories
CREATE TABLE IF NOT EXISTS `blog_categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table alaba_test.blog_categories: ~3 rows (approximately)
INSERT INTO `blog_categories` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
	(8, 'News', 'news', 1, NULL, NULL),
	(9, 'Announces', 'announces', 1, NULL, NULL),
	(10, 'Statistics', 'statistics', 1, NULL, NULL);

-- Dumping structure for table alaba_test.charges
CREATE TABLE IF NOT EXISTS `charges` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `charges_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.charges: ~10 rows (approximately)
INSERT INTO `charges` (`id`, `name`, `slug`, `data`, `created_at`, `updated_at`) VALUES
	(1, 'Transfer Money', 'transfer-money', '{"percent_charge":"2","fixed_charge":"2","minimum":"1","maximum":"1000","daily_limit":"2000","monthly_limit":"5000"}', '2021-12-20 06:20:33', '2022-03-02 23:32:23'),
	(2, 'Exchange Money', 'money-exchange', '{"percent_charge":"1","fixed_charge":"2","minimum":"10","maximum":"1000"}', '2021-12-20 06:20:33', '2021-12-20 03:06:30'),
	(3, 'Request Money', 'request-money', '{"percent_charge":"1","fixed_charge":"2","minimum":"10","maximum":"2000"}', '2021-12-20 06:20:33', '2022-03-03 00:30:39'),
	(4, 'Merchant Payment', 'merchant-payment', '{"percent_charge":"5","fixed_charge":"2"}', '2021-12-20 06:20:33', '2022-03-02 23:32:43'),
	(5, 'Create Voucher', 'create-voucher', '{"percent_charge":"2","fixed_charge":"2","minimum":"10","maximum":"2000","commission":"10"}', '2021-12-20 06:20:33', '2022-03-03 00:51:53'),
	(6, 'Create Invoice', 'create-invoice', '{"percent_charge":"5","fixed_charge":"2"}', '2021-12-20 06:20:33', '2022-03-02 23:33:11'),
	(8, 'Make Escrow', 'make-escrow', '{"percent_charge":"5","fixed_charge":"2"}', '2021-12-20 06:20:33', '2022-03-02 23:33:06'),
	(9, 'API Merchant Payment', 'api-payment', '{"percent_charge":"5","fixed_charge":"2"}', '2021-12-20 06:20:33', '2022-03-02 23:33:17'),
	(10, 'Agent Cash In', 'cashin', '{"minimum":"10","maximum":"2000","commission":"10"}', '2021-12-20 06:20:33', '2021-12-20 02:15:39'),
	(11, 'User Cash Out', 'cashout', '{"percent_charge":"1","fixed_charge":"10","minimum":"10","maximum":"2000","daily_limit":"2500","monthly_limit":"25000"}', '2021-12-20 06:20:33', '2021-12-20 02:15:39');

-- Dumping structure for table alaba_test.countries
CREATE TABLE IF NOT EXISTS `countries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `unique_key` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dial_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` int NOT NULL,
  `flag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.countries: ~6 rows (approximately)
INSERT INTO `countries` (`id`, `unique_key`, `name`, `code`, `dial_code`, `currency_id`, `flag`, `created_at`, `updated_at`) VALUES
	(1, 190, 'United States', 'US', '+1', 1, 'https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/US.svg', '2022-03-02 21:39:20', '2022-03-02 21:39:20'),
	(2, 67, 'Germany', 'DE', '+49', 4, 'https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DE.svg', '2022-03-02 21:39:30', '2022-03-02 21:39:30'),
	(3, 189, 'United Kingdom', 'GB', '+44', 5, 'https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GB.svg', '2022-03-02 21:39:42', '2022-03-02 21:39:42'),
	(4, 135, 'Nigeria', 'NG', '+234', 13, 'https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NG.svg', '2022-03-02 21:39:55', '2022-03-02 21:39:55'),
	(5, 15, 'Bangladesh', 'BD', '+880', 6, 'https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BD.svg', '2022-03-02 21:40:06', '2022-03-02 21:40:06'),
	(6, 92, 'Japan', 'JP', '+81', 11, 'https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/JP.svg', '2022-03-02 21:40:23', '2022-03-02 21:40:23'),
	(7, 194, 'Vietnam', 'VN', '+84', 15, 'https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/VN.svg', '2024-06-18 20:51:07', '2024-06-18 20:51:07');

-- Dumping structure for table alaba_test.currencies
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `default` int unsigned NOT NULL COMMENT '1 => default, 0 => not default',
  `symbol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `curr_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int unsigned NOT NULL COMMENT '1 => fiat, 2 => crypto',
  `status` int unsigned NOT NULL COMMENT '1 => active, 0 => inactive',
  `rate` decimal(20,10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currencies_symbol_unique` (`symbol`),
  UNIQUE KEY `currencies_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.currencies: ~8 rows (approximately)
INSERT INTO `currencies` (`id`, `default`, `symbol`, `code`, `curr_name`, `type`, `status`, `rate`, `created_at`, `updated_at`) VALUES
	(1, 0, '$', 'USD', 'United State Dollar', 1, 1, 1.0000000000, '2021-12-20 04:12:58', '2024-06-18 20:50:32'),
	(4, 0, '€', 'EUR', 'European Currency', 1, 1, 0.8790350000, '2021-12-20 04:12:58', '2022-02-16 03:02:35'),
	(5, 0, '£', 'GBP', 'Greate British Pound', 1, 1, 0.7376150000, '2021-12-21 00:45:51', '2022-02-16 03:02:35'),
	(6, 0, '৳', 'BDT', 'Bangladeshi Taka', 1, 1, 85.9261900000, '2021-12-21 00:48:53', '2022-02-16 03:02:35'),
	(9, 0, '₿', 'BTC', 'Bitcoin', 2, 1, 0.0000225947, '2021-12-21 00:48:53', '2022-02-16 03:02:36'),
	(10, 0, '₹', 'INR', 'Indian Rupee', 1, 1, 75.0096000000, '2022-01-26 02:28:23', '2022-02-16 03:02:35'),
	(11, 0, '¥', 'JPY', 'Japanese Yen', 1, 1, 115.6425010000, '2022-01-26 02:30:04', '2022-02-16 03:02:35'),
	(13, 0, '₦', 'NGN', 'Nigerian naira', 1, 1, 415.7594650000, '2022-02-06 05:41:35', '2022-02-16 03:02:35'),
	(15, 1, 'đ', 'VND', 'Việt Nam đồng', 1, 1, 25300.0000000000, '2024-06-18 20:50:32', '2024-06-18 20:50:32');

-- Dumping structure for table alaba_test.deposits
CREATE TABLE IF NOT EXISTS `deposits` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_type` tinyint(1) NOT NULL,
  `user_info` text COLLATE utf8mb4_general_ci,
  `status` varchar(111) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `txn_id` varchar(222) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `method` int NOT NULL,
  `currency_id` int NOT NULL,
  `invoice` int DEFAULT NULL,
  `currency_info` text COLLATE utf8mb4_general_ci NOT NULL,
  `trx_details` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `charge` decimal(20,10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table alaba_test.deposits: ~0 rows (approximately)

-- Dumping structure for table alaba_test.disputes
CREATE TABLE IF NOT EXISTS `disputes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `escrow_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.disputes: ~0 rows (approximately)

-- Dumping structure for table alaba_test.email_templates
CREATE TABLE IF NOT EXISTS `email_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_type` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_subject` mediumtext COLLATE utf8mb3_unicode_ci,
  `email_body` longtext COLLATE utf8mb3_unicode_ci,
  `sms` text COLLATE utf8mb3_unicode_ci,
  `codes` text COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table alaba_test.email_templates: ~23 rows (approximately)
INSERT INTO `email_templates` (`id`, `email_type`, `email_subject`, `email_body`, `sms`, `codes`, `status`) VALUES
	(1, 'transfer_money', 'Money has been transferred successfully.', '<p>Hello <b>{name}</b>,</p><p>Transfer money <b>{amount} {curr}</b> to <b>{trans_to}</b> is successful.</p><p><b><u><font color="#000000" style="background-color: rgb(255, 255, 0);">Transfer details:</font></u></b></p><ul><li style="margin-left: 25px;">Amount :&nbsp; <b>{amount} {curr}</b></li><li style="margin-left: 25px;">Charge: <b>{charge} {curr}</b></li><li style="margin-left: 25px;">Remaining Balance : <b>{after_balance} {curr}</b></li><li style="margin-left: 25px;">Transaction ID : <b>{trnx}</b></li></ul><p>Time : {date_time}</p><p><br></p>', 'Hello {name},\n\nTransfer money {amount} {curr} to {trans_to} is successful.\n\nTransfer details:\n\nAmount :  {amount} {curr}\nCharge: {charge} {curr}\nRemaining Balance : {after_balance} {curr}\nTransaction ID : {trnx}\nTime : {date_time}\n\n', '{"name":"User name","trnx":"Transaction Id","amount":"Amount","curr":"currency code","charge":"transfer charge","after_balance":"remaining balance","trans_to":"transfer to whom","date_time":"Date and Time"}', 1),
	(2, 'received_money', 'Money received successfully', '<p>Hello&nbsp;<span style="font-weight: bolder;">{name}</span>,</p><p>Received money&nbsp;<span style="font-weight: bolder;">{amount} {curr}</span>&nbsp; from&nbsp;&nbsp;<span style="font-weight: bolder;">{trans_from}</span>&nbsp;is successful.</p><p><span style="font-weight: bolder;"><u><font color="#000000" style="background-color: rgb(255, 255, 0);">Transfer details:</font></u></span></p><ul><li style="margin-left: 25px;">Amount :&nbsp;&nbsp;<span style="font-weight: bolder;">{amount} {curr}</span></li><li style="margin-left: 25px;">Charge:&nbsp;<span style="font-weight: bolder;">{charge} {curr}</span></li><li style="margin-left: 25px;">Remaining Balance :&nbsp;<span style="font-weight: bolder;">{after_balance} {curr}</span></li><li style="margin-left: 25px;">Transaction ID :&nbsp;<span style="font-weight: bolder;">{trnx}</span></li></ul><p>Time : {date_time}</p><p><br></p>', 'Hello {name},\n\nReceived money {amount} {curr}  from  {trans_from} is successful.\n\nTransfer details:\n\nAmount :  {amount} {curr}\nCharge: {charge} {curr}\nRemaining Balance : {after_balance} {curr}\nTransaction ID : {trnx}\nTime : {date_time}', '{"trnx":"Transaction Id","amount":"Amount","curr":"currency code","charge":"transfer charge","after_balance":"remaining balance","trans_from":"received from whom","date_time":"Date and Time"}', 1),
	(6, 'exchange_money', 'Money exchanged successfully', '<p>Hello&nbsp;<span style="font-weight: bolder;">{name}</span>,</p><p>Currency Exchange <span style="font-weight: bolder;">{from_amount} {from_curr}</span>&nbsp; to <b>{to_amount}</b>&nbsp;<span style="font-weight: 700;">{to_curr}</span>&nbsp;is successful.</p><p><span style="font-weight: bolder;"><u><font color="#000000" style="background-color: rgb(255, 255, 0);">Exchange details:</font></u></span></p><ul><li style="margin-left: 25px;">Amount&nbsp; from&nbsp;<span style="font-weight: 700;">{from_curr}</span>:&nbsp;&nbsp;<span style="font-weight: bolder;"><span style="font-weight: bolder;">{from_amount}</span>&nbsp;{from_curr}</span></li><li style="margin-left: 25px;">Amount from <b>{to_curr}&nbsp; &nbsp; :&nbsp;&nbsp;</b><span style="font-weight: bolder;">{to_amount}</span>&nbsp;<span style="font-weight: 700;">{to_curr}</span></li><li style="margin-left: 25px;">Charge:&nbsp;<span style="font-weight: bolder;">{charge} {from_curr}</span></li></ul><p>Time : {date_time}</p><p><br></p>', 'Hello {name},\n\nCurrency Exchange {from_amount} {from_curr}  to {to_amount} {to_curr} is successful.\n\nExchange details:\n\nAmount  from {from_curr}:  {from_amount} {from_curr}\nAmount from {to_curr}    :  {to_amount} {to_curr}\nCharge: {charge} {from_curr}\nTime : {date_time}', '{"from_curr":"from currency","to_curr":"to currency","from_amount":"from currency amount","to_amount":"to currency amount","charge":"exchange charge","data_time":"data and time"}', 1),
	(7, 'accept_request_money', 'Money request accepted', '<p>Hello&nbsp;<span style="font-weight: bolder;">{name}</span>,</p><p>Your money request <b>{amount}</b> <b>{curr}</b> to <b>{to_user}</b> has been accepted. Check your new balance.&nbsp;</p><p><span style="font-weight: bolder;"><u><font color="#000000" style="background-color: rgb(255, 255, 0);">Transaction details:</font></u></span></p><ul><li style="margin-left: 25px;">Amount&nbsp; :&nbsp;&nbsp;<span style="font-weight: bolder;"><span style="font-weight: bolder;">{amount}</span>&nbsp;{curr}</span></li><li style="margin-left: 25px;">Charge:&nbsp;<span style="font-weight: bolder;">{charge} {curr}</span></li><li style="margin-left: 25px;">Transaction ID : <b>{trnx}</b></li></ul><p>Time : {date_time}</p><p><br></p>', 'Hello {name},\n\nYour money request {amount} {curr} to {to_user} has been accepted. Check your new balance. \n\nTransaction details:\n\nAmount  :  {amount} {curr}\nCharge: {charge} {curr}\nTransaction ID : {trnx}\nTime : {date_time}', '{"amount":"request amount","trnx":"transaction id","to_user":"to whom request sent","charge":"charge","date_time":"date and time","curr":"currency"}', 1),
	(8, 'make_payment', 'Make Payment', '<p>Hello&nbsp;<span style="font-weight: bolder;">{name}</span>,</p><p>Your payment of&nbsp;<b>{amount}</b> <b>{curr}</b> to <b>{to_merchant}</b> is successful. .&nbsp;</p><p><span style="font-weight: bolder;"><u><font color="#000000" style="background-color: rgb(255, 255, 0);">Payment details:</font></u></span></p><ul><li style="margin-left: 25px;">Amount&nbsp; :&nbsp;&nbsp;<span style="font-weight: bolder;"><span style="font-weight: bolder;">{amount}</span>&nbsp;{curr}</span></li><li style="margin-left: 25px;">Transaction ID : <b>{trnx}</b></li><li style="margin-left: 25px;">Remaining balance<b> : {after_balance}</b></li></ul><p>Time : {date_time}</p><p><br></p>', 'Hello {name},\n\nYour payment of {amount} {curr} to {to_merchant} is successful. . \n\nPayment details:\n\nAmount  :  {amount} {curr}\nTransaction ID : {trnx}\nRemaining balance : {after_balance}\nTime : {date_time}', '{"amount":"payment amount","trnx":"Transaction ID","to_merchant":"To merchant","curr":"currency","after_balance":"after payment remaining balance","data_time":"date and time"}', 1),
	(9, 'receive_payment', 'Receive Payment', '<p>Hello&nbsp;<span style="font-weight: bolder;">{name}</span>,</p><p>You have received payment of&nbsp;<b>{amount}</b> <b>{curr}</b>&nbsp;from&nbsp;<b>{from_user}</b>&nbsp; successfully. .&nbsp;</p><p><span style="font-weight: bolder;"><u><font color="#000000" style="background-color: rgb(255, 255, 0);">Payment details:</font></u></span></p><ul><li style="margin-left: 25px;">Amount&nbsp; :&nbsp;&nbsp;<span style="font-weight: bolder;"><span style="font-weight: bolder;">{amount}</span>&nbsp;{curr}</span></li><li style="margin-left: 25px;">Transaction ID : <b>{trnx}</b></li><li style="margin-left: 25px;">New balance<b> : {after_balance}</b></li></ul><p>Time : {date_time}</p><p><br></p>', 'Hello {name},\n\nYou have received payment of {amount} {curr} from {from_user}  successfully. . \n\nPayment details:\n\nAmount  :  {amount} {curr}\nTransaction ID : {trnx}\nNew balance : {after_balance}\nTime : {date_time}', '{"amount":"payment amount","trnx":"Transaction ID","from_user":"From user","curr":"currency","after_balance":"after geting payment remaining balance","data_time":"date and time","charge":"charge"}', 1),
	(11, 'received_invoice_payment', 'Received Invoice Payment', '<p>Hello {name},\r\n</p><p>\r\nYou have received an invoice ({inv_num}) payment of {amount} {curr} from {from_user}  successfully. . </p><p><b>\r\n\r\nPayment details:</b></p><ul><li>\r\nInvoice Number : {inv_num}</li><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}</li><li>\r\nNew balance : {after_balance}</li></ul><p>Time : {date_time}</p>', 'Hello {name},\r\n\r\nYou have received an invoice ({inv_num}) payment of {amount} {curr} from {from_user}  successfully. . \r\n\r\nPayment details:\r\nInvoice Number : {inv_num}\r\nAmount  :  {amount} {curr}\r\nCharge  : {charge} {curr}\r\nTransaction ID : {trnx}\r\nNew balance : {after_balance}\r\nTime : {date_time}', '{"amount":"payment amount","trnx":"Transaction ID","from_user":"From user","curr":"currency","after_balance":"after geting payment remaining balance","data_time":"date and time","charge":"charge","inv_num":"invoice number"}', 1),
	(12, 'add_balance', 'Balance added by system', '<p>Hello {name},\r\n</p><p>\r\nBalance added {amount} {curr} in your wallet ({curr}) by system successfully.\r\n</p><p>\r\nTransaction details:\r\n</p><ul><li>Amount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li>New balance : {after_balance}\r\n</li><li>Time : {date_time}</li></ul>', 'Hello {name},\r\n\r\nBalance added {amount} {curr} in your wallet ({curr}) from system successfully.\r\n\r\nTransaction details:\r\nAmount  :  {amount} {curr}\r\nTransaction ID : {trnx}\r\nNew balance : {after_balance}\r\nTime : {date_time}', '{"amount":"payment amount","trnx":"Transaction ID","curr":"currency","after_balance":"after geting payment remaining balance","data_time":"date and time"}', 1),
	(13, 'subtract_balance', 'Balance subtracted by system', '<p>Hello {name},\r\n</p><p>\r\nBalance subtracted {amount} {curr} from your wallet ({curr}) by system successfully.\r\n</p><p>\r\nTransaction details:\r\n</p><ul><li>Amount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li>New balance : {after_balance}\r\n</li><li>Time : {date_time}</li></ul>', 'Hello {name},\r\n\r\nBalance subtracted {amount} {curr} from your wallet ({curr}) by system successfully.\r\n\r\nTransaction details:\r\nAmount  :  {amount} {curr}\r\nTransaction ID : {trnx}\r\nNew balance : {after_balance}\r\nTime : {date_time}', '{"amount":"payment amount","trnx":"Transaction ID","curr":"currency","after_balance":"after geting payment remaining balance","data_time":"date and time"}', 1),
	(14, 'accept_withdraw', 'Withdraw request accepted', '<p>Hello <b>{name}</b>,\r\n</p><p>\r\nYour withdraw request <b>{amount} {curr}</b> is accepted via <b>{method}</b>.\r\n</p><p>\r\nWithdraw details:\r\n</p><ul><li>Amount  :  {amount} {curr}\r\n</li><li>Charge  : {charge}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li>Withdraw Method : {method}\r\n</li><li>Time : {date_time}</li></ul>', 'Hello {name},\r\n\r\nYour withdraw request {amount} {curr} is accepted via {method}.\r\n\r\nWithdraw details:\r\nAmount  :  {amount} {curr}\r\nCharge  : {charge}\r\nTransaction ID : {trnx}\r\nWithdraw Method : {method}\r\nTime : {date_time}', '{"amount":"payment amount","trnx":"Transaction ID","curr":"currency","data_time":"date and time","charge":"charge","method":"Withdraw method"}', 1),
	(15, 'reject_withdraw', 'Withdraw request rejected', '<p>Hello {name},\r\n</p><p>\r\nYour withdraw request {amount} {curr} is rejected. The withdraw amount {amount} {curr} has been returned to your balance.</p><p>\r\nWithdraw details:\r\n</p><ul><li>Amount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li>Withdraw Method : {method}\r\n</li></ul><p><u>\r\nRejection reason </u>:\r\n</p><p>{reason}\r\n</p><p>\r\nTime : {date_time}\r\n</p>', 'Hello {name},\n\nYour withdraw request {amount} {curr} is rejected.\n\nWithdraw details:\nAmount  :  {amount} {curr}\nTransaction ID : {trnx}\nWithdraw Method : {method}\n\nRejection reason :\n{reason}\n\nTime : {date_time}\n', '{"amount":"payment amount","trnx":"Transaction ID","curr":"currency","data_time":"date and time","method":"Withdraw method","reason":"reject reason"}', 1),
	(16, 'escrow_return', 'Escrow fund returned', '<p>Hello {name},\r\n</p><p>\r\nYour escrow fund {amount} {curr} has been added to your balance.\r\n</p><p>\r\nTransaction details:\r\n</p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx} .</li><li>Time : {date_time}\r\n</li></ul>', 'Hello {name},\r\n\r\nYour escrow fund {amount} {curr} has been returned to your balance.\r\n\r\nTransaction details:\r\n\r\nAmount  :  {amount} {curr}\r\nTransaction ID : {trnx}\r\nTime : {date_time}\r\n', '{"amount":"return  amount","trnx":"Transaction ID","curr":"currency","data_time":"date and time"}', 1),
	(17, 'deposit_approve', 'Approve Deposit', '<p>Hello {name},\r\n</p><p>\r\nYour deposit request {amount} {curr} via {method} is approved.\r\n</p><p><b>\r\nTransaction details:\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Charge  : {charge} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li>New Balance  : {new_balance} {curr}</li></ul><p>Time : {date_time}\r\n</p>', 'Hello {name},\n\nYour deposit request {amount} {curr} via {method} is approved.\n\nTransaction details:\n\nAmount  :  {amount} {curr}\nCharge  : {charge} {curr}\nTransaction ID : {trnx}\nNew Balance  : {new_balance}\nTime : {date_time}\n', '{"amount":"deposit amount","trnx":"Transaction ID","curr":"currency","data_time":"date and time","method":"deposit method name","new_balance":"New balance","charge":"Charge"}', 1),
	(18, 'deposit_reject', 'Reject Deposit', '<p>Hello {name},\r\n</p><p>\r\nYour deposit request {amount} {curr} via {method} is rejected.\r\n</p><p><b>\r\nTransaction details:\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li>Charge  : {charge}\r\n</li><li>\r\nReject Reason :\r\n{reject_reason}\r\n</li></ul><p>\r\nTime : {date_time}\r\n</p>', 'Hello {name},\r\n\r\nYour deposit request {amount} {curr} via {method} is rejected.\r\n\r\nTransaction details:\r\n\r\nAmount  :  {amount} {curr}\r\nTransaction ID : {trnx}\r\nCharge  : {charge}\r\n\r\nRject Reason :\r\n{reject_reason}\r\n\r\nTime : {date_time}\r\n', '{"amount":"deposit amount","trnx":"Transaction ID","curr":"currency","data_time":"date and time","method":"deposit method name","charge":"charge","reject_reason":" reason of reject"}', 1),
	(19, 'api_payment_user', 'Payment confirmation', '<p>Hello {name},\r\n</p><p>\r\nYour payment {amount} {curr} to {merchant} is successful.\r\n</p><p><b>\r\nTransaction details:\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li>Charge  : {charge}\r\n</li><li> Time : {date_time}\r\n\r\n</li></ul>', 'Hello {name},\n\nYour payment {amount} {curr} to {merchant} is successful.\n\nTransaction details:\n\nAmount  :  {amount} {curr}\nTransaction ID : {trnx}\nTime : {date_time}\n', '{"amount":"deposit amount","trnx":"Transaction ID","curr":"currency","data_time":"date and time","merchant":"merchant"}', 1),
	(20, 'api_payment_merchant', 'Payment confirmation', '<p>Hello {name},\r\n</p>\r\n\r\n<p>\r\nYour have successfully received payment {amount} {curr} from {user}.\r\n</p>\r\n\r\n<p><b>\r\nTransaction details:\r\n</b></p>\r\n\r\n<ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li>Charge  : {charge}\r\n</li><li><p> Time : {date_time}</p>\r\n\r\n</li></ul>', 'Hello {name},\n\nYour have successfully received payment {amount} {curr} from {user}.\n\nTransaction details:\n\nAmount  :  {amount} {curr}\nTransaction ID : {trnx}\nCharge  : {charge}\nTime : {date_time}\n', '{"amount":"payment amount","trnx":"Transaction ID","curr":"currency","data_time":"date and time","charge":"charge","user":"from user"}', 1),
	(21, 'fund_accept', 'Fund Request Accept', '<p>Hello {name},\r\n</p><p>\r\nYour fund request has been accepted {amount} {curr}.\r\n</p><p><b>\r\nTransaction details:\r\n\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Fund Unique ID : {u_id}\r\n</li><li>Transaction ID : {trnx}\r\n</li><li> Time : {date_time}\r\n\r\n</li></ul>', 'Hello {name},\r\n\r\nYour fund request has been accepted {amount} {curr}.\r\n\r\nTransaction details:\r\n\r\nAmount  :  {amount} {curr}\r\nFund Unique ID : {u_id}\r\nTransaction ID : {trnx}\r\nTime : {date_time}\r\n\r\n', '{"amount":"fund amount","trnx":"Transaction ID","curr":"currency","data_time":"date and time","u_id":"fund unique id"}', 1),
	(22, 'fund_reject', 'Fund Request Reject', '<p>Hello {name},\n</p><p>\nYour fund request has been rejected {amount} {curr}.\n</p><p><b>\nFund details:\n\n</b></p><ul><li>\nAmount  :  {amount} {curr}\n</li><li>Fund Unique ID : {u_id}\n</li>\n</li><li> Time : {date_time}\n\n</li>\n<li> Reject Reason </li>\n<p> {reject_reason} </p>\n</ul>', 'Hello {name},\n\nYour fund request has been accepted {amount} {curr}.\n\nFund details:\n\nAmount  :  {amount} {curr}\nFund Unique ID : {u_id}\nTime : {date_time}\n\nReject Reason\n{reject_reason}\n\n', '{"amount":"fund amount","curr":"currency","data_time":"date and time","u_id":"fund unique id","reject_reason":"Reject Reason"}', 1),
	(23, 'cash_in_user', 'User Cash In', '<p>Hello {name},\r\n</p><p>\r\nCash In {amount} {curr} from {agent}.\r\n</p><p><b>\r\nTransaction details:\r\n\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li>\r\n</li><li>New balance : {balance} {curr}\r\n</li>\r\n</li><li> Time : {date_time}\r\n\r\n</li>\r\n\r\n</ul>', 'Hello {name},\r\n\r\nCash In {amount} {curr} from {agent}.\r\n\r\nTransaction details:\r\n\r\nAmount  :  {amount} {curr}\r\nTransaction ID : {trnx}\r\nNew balance : {balance} {curr}\r\nTime : {date_time}\r\n\r\n\r\n', '{"amount":"cash in amount","curr":"currency","data_time":"date and time","trnx":"Transaction ID","balance":"new balance","agent":"agent email"}', 1),
	(24, 'cash_in_agent', 'Agent Cash In', '<p>Hello {name},\r\n</p><p>\r\nCash In {amount} {curr} to {user} successfull.\r\n</p><p><b>\r\nTransaction details:\r\n\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li>\r\n</li><li>New balance : {balance} {curr}\r\n</li>\r\n</li><li> Time : {date_time}\r\n\r\n</li>\r\n\r\n</ul>', 'Hello {name},\r\n\r\nCash In {amount} {curr} to {user} successfull.\r\n\r\nTransaction details:\r\n\r\nAmount  :  {amount} {curr}\r\nTransaction ID : {trnx}\r\nNew balance : {balance} {curr}\r\nTime : {date_time}\r\n\r\n\r\n', '{"amount":"cash in amount","curr":"currency","data_time":"date and time","trnx":"Transaction ID","balance":"new balance","user":"User email"}', 1),
	(25, 'cash_in_commission', 'Cash In Commission', '<p>Hello {name},\r\n</p><p>\r\nCash In commission {amount} {curr} received successfull.\r\n</p><p><b>\r\nTransaction details:\r\n\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li><li>Transaction ID : {trnx}\r\n</li>\r\n</li><li>New balance : {balance} {curr}\r\n</li>\r\n</li><li> Time : {date_time}\r\n\r\n</li>\r\n\r\n</ul>', 'Hello {name},\r\n\r\nCash In commission  {amount} {curr} received successfully.\r\n\r\nTransaction details:\r\n\r\nAmount  :  {amount} {curr}\r\nTransaction ID : {trnx}\r\nNew balance : {balance} {curr}\r\nTime : {date_time}\r\n\r\n\r\n', '{"amount":"cash in amount","curr":"currency","data_time":"date and time","trnx":"Transaction ID","balance":"new balance"}', 1),
	(26, 'cash_out_user', 'User Cash Out', '<p>Hello {name},\r\n</p><p>\r\nCash out {amount} {curr} to {agent} successfull.\r\n</p><p><b>\r\nTransaction details:\r\n\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li>\r\n<li>\r\nCharge:  {charge} {curr}\r\n</li>\r\n<li>Transaction ID : {trnx}\r\n</li>\r\n</li><li>New balance : {balance} {curr}\r\n</li>\r\n</li><li> Time : {date_time}\r\n\r\n</li>\r\n\r\n</ul>', 'Hello {name},\r\n\r\nCash out {amount} {curr} to {agent} successfull.\r\n\r\nTransaction details:\r\n\r\nAmount  :  {amount} {curr}\r\nCharge:  {charge} {curr}\r\nTransaction ID : {trnx}\r\nNew balance : {balance} {curr}\r\nTime : {date_time}\r\n\r\n\r\n', '{"amount":"cash out amount","curr":"currency","data_time":"date and time","trnx":"Transaction ID","balance":"new balance","agent":"agent email","charge":"cashout charge"}', 1),
	(27, 'cash_out_agent', 'Agent Cash Out', '<p>Hello {name},\r\n</p><p>\r\nCash out {amount} {curr} from {user} successfull.\r\n</p><p><b>\r\nTransaction details:\r\n\r\n</b></p><ul><li>\r\nAmount  :  {amount} {curr}\r\n</li>\r\n<li>Transaction ID : {trnx}\r\n</li>\r\n</li><li>New balance : {balance} {curr}\r\n</li>\r\n</li><li> Time : {date_time}\r\n\r\n</li>\r\n\r\n</ul>', 'Hello {name},\r\n\r\nCash out {amount} {curr} from {user} successfull.\r\n\r\nTransaction details:\r\n\r\nAmount  :  {amount} {curr}\r\nTransaction ID : {trnx}\r\nNew balance : {balance} {curr}\r\nTime : {date_time}\r\n\r\n\r\n', '{"amount":"cash out amount","curr":"currency","data_time":"date and time","trnx":"Transaction ID","balance":"new balance","user":"user email"}', 1);

-- Dumping structure for table alaba_test.escrows
CREATE TABLE IF NOT EXISTS `escrows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trnx` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `recipient_id` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(20,10) NOT NULL,
  `pay_charge` tinyint(1) NOT NULL COMMENT '1 = sender pay charge, 0 = receiver pa charge',
  `charge` decimal(20,10) NOT NULL,
  `currency_id` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = on-hold, 1 = release, 3 = disputed\r\n',
  `dispute_created` int DEFAULT NULL,
  `returned_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.escrows: ~0 rows (approximately)

-- Dumping structure for table alaba_test.exchange_money
CREATE TABLE IF NOT EXISTS `exchange_money` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trnx` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_currency` int NOT NULL,
  `to_currency` int NOT NULL,
  `user_id` int NOT NULL,
  `charge` decimal(20,10) NOT NULL,
  `from_amount` decimal(20,10) NOT NULL,
  `to_amount` decimal(20,10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.exchange_money: ~0 rows (approximately)

-- Dumping structure for table alaba_test.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table alaba_test.fund_requests
CREATE TABLE IF NOT EXISTS `fund_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agent_id` int unsigned NOT NULL,
  `unique_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int NOT NULL,
  `amount` decimal(18,8) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `collect` tinyint NOT NULL DEFAULT '0',
  `reject_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.fund_requests: ~0 rows (approximately)

-- Dumping structure for table alaba_test.generalsettings
CREATE TABLE IF NOT EXISTS `generalsettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `curr_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `curr_sym` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '$',
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `header_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loader` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `smtp_host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_port` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_pass` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_encryption` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_tawk` tinyint NOT NULL DEFAULT '0',
  `tawk_id` varchar(222) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verify` tinyint DEFAULT '0',
  `is_cookie` tinyint NOT NULL DEFAULT '0',
  `cookie_btn_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cookie_text` text COLLATE utf8mb4_unicode_ci,
  `is_maintenance` tinyint DEFAULT '0',
  `maintenance` text COLLATE utf8mb4_unicode_ci,
  `registration` tinyint(1) NOT NULL DEFAULT '1',
  `kyc` tinyint(1) NOT NULL DEFAULT '1',
  `sms_notify` tinyint(1) NOT NULL DEFAULT '1',
  `email_notify` tinyint(1) NOT NULL DEFAULT '1',
  `allowed_email` text COLLATE utf8mb4_unicode_ci,
  `contact_no` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recaptcha` tinyint(1) NOT NULL DEFAULT '0',
  `recaptcha_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recaptcha_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fiat_access_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `crypto_access_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cookie` text COLLATE utf8mb4_unicode_ci,
  `two_fa` tinyint(1) NOT NULL DEFAULT '1',
  `menu` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.generalsettings: 1 rows
/*!40000 ALTER TABLE `generalsettings` DISABLE KEYS */;
INSERT INTO `generalsettings` (`id`, `curr_code`, `curr_sym`, `logo`, `header_logo`, `favicon`, `title`, `loader`, `smtp_host`, `mail_type`, `smtp_port`, `smtp_user`, `smtp_pass`, `mail_encryption`, `from_email`, `from_name`, `theme_color`, `is_tawk`, `tawk_id`, `is_verify`, `is_cookie`, `cookie_btn_text`, `cookie_text`, `is_maintenance`, `maintenance`, `registration`, `kyc`, `sms_notify`, `email_notify`, `allowed_email`, `contact_no`, `recaptcha`, `recaptcha_key`, `recaptcha_secret`, `fiat_access_key`, `crypto_access_key`, `cookie`, `two_fa`, `menu`) VALUES
	(1, 'VND', 'đ', '1571567292logo.png', '1558572841646281442.png', '5480339181644482400.png', 'Genius Wallet', '1564224328loading3.gif', 'sandbox.smtp.mailtrap.io', 'php_mailer', '2525', '77c8df7c3e0779', '509dc95e1382f5', 'tls', 'geniustest11@gmail.com', 'GeniusTest', '5B53F1', 0, '6124fa49d6e7610a49b1c136/1fds73cxyZ', 0, 0, 'cookie_btn_text', NULL, 0, 'Site Down', 1, 1, 0, 0, NULL, '+88000000000', 0, '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI', NULL, 'e02535b70998cade1035fbe04e50b8dd', '91b63a445b659202b6449e8611f231f9', '{"status":"1","button_text":"Allow Cookie","cookie_text":"Our site use cookies when you visit our website, including any other media form, mobile website, or mobile application related or connected to help customize the site and improve your experience."}', 1, '{"Home":{"title":"Home","dropdown":"no","href":"\\/","target":"self"},"About":{"title":"About","dropdown":"yes","href":"\\/about","target":"self"},"API":{"title":"API","dropdown":"yes","href":"\\/api-documentation","target":"self"},"Blogs":{"title":"Blogs","dropdown":"yes","href":"\\/blogs","target":"self"},"Contact":{"title":"Contact","dropdown":"yes","href":"\\/contact","target":"self"}}');
/*!40000 ALTER TABLE `generalsettings` ENABLE KEYS */;

-- Dumping structure for table alaba_test.invoices
CREATE TABLE IF NOT EXISTS `invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int NOT NULL,
  `invoice_to` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge` decimal(20,10) NOT NULL,
  `final_amount` decimal(20,10) NOT NULL,
  `get_amount` decimal(20,10) NOT NULL,
  `payment_status` tinyint NOT NULL DEFAULT '0' COMMENT '1 => paid, 0 => not paid',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '1 => published, 0 => not published , 2 => cancel',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.invoices: ~0 rows (approximately)

-- Dumping structure for table alaba_test.inv_items
CREATE TABLE IF NOT EXISTS `inv_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(20,10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.inv_items: ~0 rows (approximately)

-- Dumping structure for table alaba_test.kyc_forms
CREATE TABLE IF NOT EXISTS `kyc_forms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint NOT NULL,
  `type` int NOT NULL COMMENT '1 = input, 2 = file, 3 = textarea',
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` int NOT NULL COMMENT '1 = yes, 0 = no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.kyc_forms: ~7 rows (approximately)
INSERT INTO `kyc_forms` (`id`, `user_type`, `type`, `label`, `name`, `required`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 'NID', 'nid', 1, '2022-01-04 04:54:19', '2022-01-04 23:44:04'),
	(2, 1, 2, 'NID Screenshot', 'nid_screenshot', 0, '2022-01-04 04:56:07', '2022-01-04 04:56:07'),
	(3, 1, 3, 'Description of address', 'description_of_address', 1, '2022-01-04 04:58:14', '2022-01-04 04:58:14'),
	(4, 2, 1, 'Business Name', 'business_name', 1, '2022-01-04 05:04:01', '2022-01-04 05:04:01'),
	(6, 2, 1, 'Trade License', 'trade_license', 1, '2022-02-02 00:25:05', '2022-02-02 00:25:05'),
	(7, 2, 2, 'License Screenshot', 'license_screenshot', 1, '2022-02-02 00:25:22', '2022-02-02 00:25:22'),
	(8, 2, 3, 'Adress of your Business Institute', 'adress_of_your_business_institute', 1, '2022-02-02 00:25:44', '2022-02-02 00:25:44');

-- Dumping structure for table alaba_test.languages
CREATE TABLE IF NOT EXISTS `languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `language` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(10) NOT NULL,
  `file` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Dumping data for table alaba_test.languages: ~4 rows (approximately)
INSERT INTO `languages` (`id`, `is_default`, `language`, `code`, `file`) VALUES
	(12, 0, 'English', 'en', 'en.json'),
	(18, 1, 'Vietnamese', 'vi', 'vi.json'),
	(19, 0, 'Korean', 'kr', 'kr.json');

-- Dumping structure for table alaba_test.login_logs
CREATE TABLE IF NOT EXISTS `login_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `merchant_id` int DEFAULT NULL,
  `agent_id` int DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Unknown',
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Unknown',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.login_logs: ~4 rows (approximately)
INSERT INTO `login_logs` (`id`, `user_id`, `merchant_id`, `agent_id`, `ip`, `country`, `city`, `created_at`, `updated_at`) VALUES
	(106, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, '2024-06-18 20:54:24', '2024-06-18 20:54:24'),
	(107, 13, NULL, NULL, '127.0.0.1', NULL, NULL, '2024-06-18 20:57:39', '2024-06-18 20:57:39'),
	(108, NULL, 2, NULL, '127.0.0.1', NULL, NULL, '2024-06-18 20:57:58', '2024-06-18 20:57:58'),
	(109, 2, NULL, NULL, '127.0.0.1', NULL, NULL, '2024-06-18 21:02:55', '2024-06-18 21:02:55');

-- Dumping structure for table alaba_test.merchants
CREATE TABLE IF NOT EXISTS `merchants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `business_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `zip` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `email_verified` tinyint(1) DEFAULT NULL,
  `verification_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verify_code` int DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kyc_status` tinyint(1) NOT NULL DEFAULT '0',
  `kyc_info` text COLLATE utf8mb4_unicode_ci,
  `kyc_reject_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_fa_status` tinyint(1) NOT NULL DEFAULT '0',
  `two_fa` tinyint(1) DEFAULT '0',
  `two_fa_code` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.merchants: ~0 rows (approximately)
INSERT INTO `merchants` (`id`, `business_name`, `name`, `email`, `photo`, `phone`, `country`, `city`, `address`, `zip`, `status`, `email_verified`, `verification_link`, `verify_code`, `password`, `remember_token`, `kyc_status`, `kyc_info`, `kyc_reject_reason`, `access_key`, `secret_key`, `two_fa_status`, `two_fa`, `two_fa_code`, `created_at`, `updated_at`) VALUES
	(1, 'merchant', 'merchant', 'merchant@gmail.com', NULL, '+88001728332009', 'Bangladesh', NULL, 'Munshinogor,Delduar,Tangail,Dhaka,Bangladesh', NULL, 1, 0, NULL, NULL, '$2y$10$Ny1onDOojHfLeA2aUdV0w.LSKzEqeLIP0RfWL23Adsjim77pi/w9O', NULL, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2023-09-18 21:46:32', '2023-10-01 16:55:55'),
	(2, 'Pi gaming', 'Pi gaming', 'pigaming@gmail.com', NULL, '+84338386701', 'Vietnam', NULL, '4-6-8 Calmette', NULL, 1, NULL, NULL, NULL, '$2y$10$AdpEaGuQOueL0XVyp8wxyubGKVjcvms3YnaTForfkEe0KBSDtfTUS', NULL, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2024-06-18 20:53:19', '2024-06-18 20:53:19');

-- Dumping structure for table alaba_test.merchant_payments
CREATE TABLE IF NOT EXISTS `merchant_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `merchant_id` int NOT NULL,
  `currency_id` int NOT NULL,
  `amount` decimal(20,10) NOT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `web_hook` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cancel_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `success_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `mode` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.merchant_payments: ~0 rows (approximately)

-- Dumping structure for table alaba_test.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.migrations: ~31 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2021_09_25_053316_create_admins_table', 2),
	(6, '2021_12_19_042602_create_site_contents_table', 3),
	(7, '2021_12_20_032716_create_currencies_table', 4),
	(8, '2021_12_20_041453_create_wallets_table', 5),
	(9, '2021_12_20_061743_create_charges_table', 6),
	(10, '2021_12_21_041624_create_countries_table', 7),
	(11, '2021_12_21_095225_create_transactions_table', 8),
	(12, '2021_12_22_044221_create_request_money_table', 9),
	(13, '2021_12_23_053336_create_exchange_money_table', 10),
	(14, '2021_12_28_083959_create_modules_table', 11),
	(15, '2021_12_29_035701_create_vouchers_table', 12),
	(16, '2021_12_30_050418_create_withdraws_table', 13),
	(17, '2021_12_30_111614_create_withdrawals_table', 14),
	(18, '2022_01_02_102323_create_payments_table', 15),
	(19, '2022_01_03_032851_create_invoices_table', 16),
	(20, '2022_01_03_034414_create_inv_items_table', 17),
	(21, '2022_01_04_092638_create_k_y_c_s_table', 18),
	(22, '2022_01_04_103906_create_kyc_forms_table', 18),
	(23, '2022_01_09_035144_create_escrows_table', 19),
	(24, '2022_01_09_064757_create_disputes_table', 20),
	(25, '2022_01_16_053729_create_api_creds_table', 21),
	(26, '2022_01_16_060854_create_merchant_payments_table', 22),
	(27, '2022_01_17_100203_create_permission_tables', 23),
	(28, '2022_01_20_050330_create_sms_gateways_table', 24),
	(29, '2022_01_30_031517_create_login_logs_table', 25),
	(30, '2022_02_02_091116_create_support_tickets_table', 26),
	(31, '2022_02_02_091130_create_ticket_messages_table', 26);

-- Dumping structure for table alaba_test.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.model_has_permissions: ~0 rows (approximately)

-- Dumping structure for table alaba_test.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.model_has_roles: ~4 rows (approximately)
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\Admin', 1),
	(3, 'App\\Models\\Admin', 2),
	(3, 'App\\Models\\Admin', 3),
	(4, 'App\\Models\\Admin', 4);

-- Dumping structure for table alaba_test.modules
CREATE TABLE IF NOT EXISTS `modules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `kyc` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `modules_module_unique` (`module`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.modules: ~10 rows (approximately)
INSERT INTO `modules` (`id`, `module`, `status`, `kyc`, `created_at`, `updated_at`) VALUES
	(1, 'transfer-money', 1, 0, NULL, '2023-10-01 15:07:55'),
	(2, 'request-money', 1, 0, NULL, '2023-09-13 05:38:14'),
	(3, 'exchange-money', 1, 0, NULL, '2023-09-13 05:38:16'),
	(4, 'make-payment', 1, 0, NULL, '2022-01-20 02:41:19'),
	(5, 'create-voucher', 1, 0, NULL, '2022-02-06 04:39:38'),
	(6, 'withdraw-money', 1, 0, NULL, '2022-02-02 00:03:33'),
	(7, 'create-invoice', 1, 0, NULL, '2023-09-13 05:38:20'),
	(8, 'make-escrow', 1, 0, NULL, '2022-01-11 05:46:09'),
	(9, 'deposit', 1, 0, NULL, '2022-02-02 00:04:29'),
	(10, 'cash-out', 1, 0, NULL, '2022-05-22 03:43:46');

-- Dumping structure for table alaba_test.pages
CREATE TABLE IF NOT EXISTS `pages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Dumping data for table alaba_test.pages: ~5 rows (approximately)
INSERT INTO `pages` (`id`, `title`, `slug`, `details`, `lang`) VALUES
	(13, 'About', 'about', '<p><span style="font-size:18pt;font-family:Arial, sans-serif;color:#595959;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">At Alaba Pay, our mission is to revolutionize the way you manage your finances. We are dedicated to providing a secure, efficient, and user-friendly platform for all your digital payment needs. Our commitment to innovation ensures that we stay ahead of the curve, continuously integrating the latest features to simplify your financial transactions.</span></p>\r\n\r\n<p><span style="font-size:18pt;font-family:Arial, sans-serif;color:#595959;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">Our team consists of industry experts who are passionate about technology and finance. We work tirelessly to incorporate advanced security measures, ensuring your data and transactions are always protected. From encryption to multi-factor authentication, our platform is designed to offer you peace of mind with every transaction.</span></p>\r\n\r\n<p><span style="font-size:18pt;font-family:Arial, sans-serif;color:#595959;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">Customer satisfaction is at the heart of everything we do. We strive to offer unparalleled support and a superior user experience. Whether it’s through our 24/7 customer service, intuitive app design, or comprehensive financial tools, we aim to make financial management effortless and stress-free. At Alaba Pay, we are committed to helping you achieve a seamless and secure digital wallet experience.</span></p>', 'en'),
	(14, 'Announcement', 'announcement', '<h3 style="margin: 15px 0px; padding: 0px; font-size: 14px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">The standard Lorem Ipsum passage, used since the 1500s</h3><p style="margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p><h3 style="margin: 15px 0px; padding: 0px; font-size: 14px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</h3><p style="margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"</p><h3 style="margin: 15px 0px; padding: 0px; font-size: 14px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">1914 translation by H. Rackham</h3><p style="margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"</p><h3 style="margin: 15px 0px; padding: 0px; font-size: 14px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</h3><p style="margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."</p>', 'en'),
	(16, 'About', 'about', '<p><span style="font-size:18pt;font-family:Arial, sans-serif;color:#595959;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">Tại Alaba Pay, sứ mệnh của chúng tôi là cách mạng hóa cách bạn quản lý tài chính của mình. Chúng tôi cam kết cung cấp một nền tảng an toàn, hiệu quả và thân thiện với người dùng cho mọi nhu cầu thanh toán kỹ thuật số của bạn. Sự tận tâm của chúng tôi đối với đổi mới đảm bảo rằng chúng tôi luôn đi đầu, liên tục tích hợp các tính năng mới nhất để đơn giản hóa các giao dịch tài chính của bạn.</span></p>\r\n\r\n<p><span style="font-size:18pt;font-family:Arial, sans-serif;color:#595959;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">Đội ngũ của chúng tôi bao gồm các chuyên gia trong ngành, đam mê công nghệ và tài chính. Chúng tôi làm việc không ngừng để tích hợp các biện pháp bảo mật tiên tiến, đảm bảo dữ liệu và giao dịch của bạn luôn được bảo vệ. Từ mã hóa đến xác thực đa yếu tố, nền tảng của chúng tôi được thiết kế để mang lại cho bạn sự yên tâm với mỗi giao dịch.</span></p>\r\n\r\n<p><span style="font-size:18pt;font-family:Arial, sans-serif;color:#595959;background-color:transparent;font-weight:400;font-style:normal;text-decoration:none;">Sự hài lòng của khách hàng là trung tâm của mọi việc chúng tôi làm. Chúng tôi nỗ lực cung cấp hỗ trợ vô song và trải nghiệm người dùng vượt trội. Cho dù đó là thông qua dịch vụ khách hàng 24/7, thiết kế ứng dụng trực quan hay các công cụ tài chính toàn diện, chúng tôi mong muốn làm cho việc quản lý tài chính trở nên dễ dàng và không căng thẳng. Tại Alaba Pay, chúng tôi cam kết giúp bạn đạt được trải nghiệm ví kỹ thuật số liền mạch và an toàn.</span></p>', 'vi'),
	(17, 'Announcement', 'announcement', '<h3 style="margin: 15px 0px; padding: 0px; font-size: 14px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">The standard Lorem Ipsum passage, used since the 1500s</h3><p style="margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p><h3 style="margin: 15px 0px; padding: 0px; font-size: 14px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</h3><p style="margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"</p><h3 style="margin: 15px 0px; padding: 0px; font-size: 14px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">1914 translation by H. Rackham</h3><p style="margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"</p><h3 style="margin: 15px 0px; padding: 0px; font-size: 14px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</h3><p style="margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;">"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."</p>', 'vi');

-- Dumping structure for table alaba_test.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.password_resets: ~0 rows (approximately)

-- Dumping structure for table alaba_test.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `gateway_id` int NOT NULL,
  `currency_id` int NOT NULL,
  `trnx` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway_trx` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(20,10) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.payments: ~0 rows (approximately)

-- Dumping structure for table alaba_test.payment_gateways
CREATE TABLE IF NOT EXISTS `payment_gateways` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subtitle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fixed_charge` decimal(20,10) DEFAULT NULL,
  `percent_charge` decimal(5,2) DEFAULT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('manual','automatic') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'manual',
  `information` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `keyword` varchar(191) DEFAULT NULL,
  `currency_id` varchar(191) NOT NULL DEFAULT '0',
  `checkout` int NOT NULL DEFAULT '1',
  `status` int NOT NULL DEFAULT '1',
  `subscription` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Dumping data for table alaba_test.payment_gateways: ~11 rows (approximately)
INSERT INTO `payment_gateways` (`id`, `subtitle`, `title`, `fixed_charge`, `percent_charge`, `details`, `name`, `type`, `information`, `keyword`, `currency_id`, `checkout`, `status`, `subscription`) VALUES
	(2, '(5 - 6 days)', 'Mobile Money', NULL, NULL, '<b>Payment Number: </b>69234324233423', 'Mobile Money', 'manual', NULL, 'mobile-money', '["4"]', 1, 1, 1),
	(7, NULL, NULL, NULL, NULL, NULL, 'Mercadopago', 'automatic', '{"public_key":"TEST-6f72a502-51c8-4e9a-8ca3-cb7fa0addad8","token":"TEST-6068652511264159-022306-e78da379f3963916b1c7130ff2906826-529753482","text":"Pay Via MercadoPago","sandbox_check":1}', 'mercadopago', '["1"]', 1, 1, 1),
	(8, NULL, NULL, NULL, NULL, NULL, 'Authorize.Net', 'automatic', '{"login_id":"76zu9VgUSxrJ","txn_key":"2Vj62a6skSrP5U3X","text":"Pay Via Authorize.Net","sandbox_check":1}', 'authorize', '["1","4"]', 1, 1, 1),
	(9, NULL, NULL, NULL, NULL, '', 'Razorpay', 'automatic', '{"key":"rzp_test_xDH74d48cwl8DF","secret":"cr0H1BiQ20hVzhpHfHuNbGri","text":"Pay via your Razorpay account."}', 'razorpay', '["10"]', 1, 1, 1),
	(11, NULL, NULL, NULL, NULL, '', 'Paytm', 'automatic', '{"merchant":"tkogux49985047638244","secret":"LhNGUUKE9xCQ9xY8","website":"WEBSTAGING","industry":"Retail","text":"Pay via your Paytm account.","sandbox_check":1}', 'paytm', '["10"]', 1, 0, 1),
	(12, NULL, NULL, NULL, NULL, '', 'Paystack', 'automatic', '{"key":"pk_test_162a56d42131cbb01932ed0d2c48f9cb99d8e8e2","email":"junnuns@gmail.com","text":"Pay via your Paystack account."}', 'paystack', '["5","13"]', 1, 1, 1),
	(13, NULL, NULL, NULL, NULL, '', 'Instamojo', 'automatic', '{"key":"test_172371aa837ae5cad6047dc3052","token":"test_4ac5a785e25fc596b67dbc5c267","text":"Pay via your Instamojo account.","sandbox_check":1}', 'instamojo', '["10"]', 1, 0, 1),
	(14, NULL, NULL, NULL, NULL, NULL, 'Stripe', 'automatic', '{"key":"pk_test_UnU1Coi1p5qFGwtpjZMRMgJM","secret":"sk_test_QQcg3vGsKRPlW6T3dXcNJsor","text":"Pay via your Credit Card."}', 'stripe', '["1","4"]', 1, 1, 1),
	(15, NULL, NULL, NULL, NULL, NULL, 'Paypal', 'automatic', '{"client_id":"AcWYnysKa_elsQIAnlfsJXokR64Z31CeCbpis9G3msDC-BvgcbAwbacfDfEGSP-9Dp9fZaGgD05pX5Qi","client_secret":"EGZXTq6d6vBPq8kysVx8WQA5NpavMpDzOLVOb9u75UfsJ-cFzn6aeBXIMyJW2lN1UZtJg5iDPNL9ocYE","sandbox_check":0,"text":"Pay via your PayPal account."}', 'paypal', '["1","4"]', 1, 1, 1),
	(19, '5-6 days', 'Wire Bank', 5.0000000000, 2.00, '<p>Description</p>', 'Wire Bank', 'manual', NULL, 'manual', '["1","4","6"]', 1, 1, 1),
	(20, '', 'Coin Gate', NULL, NULL, '<p>Wire bank&nbsp;</p><p>ACC NO. : 268653464646546465.</p><p>Deep branch</p>', 'Coin Gate', 'automatic', '{"secret_string":"kThvz8D2HsGzYPTUUi3TFETZnM66WMuwMqzEqRtG","text":"Pay via your Coin gate account."}', 'coingate', '["1","9"]', 1, 1, 1);

-- Dumping structure for table alaba_test.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=327 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.permissions: ~118 rows (approximately)
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(209, 'dashboard info', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(210, 'profit report', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(211, 'transactions', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(212, 'manage user', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(213, 'edit user', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(214, 'update user', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(215, 'user balance modify', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(216, 'user login', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(217, 'user login logs', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(218, 'manage merchant', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(219, 'edit merchant', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(220, 'update merchant', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(221, 'merchant balance modify', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(222, 'merchant login', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(223, 'merchant login logs', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(224, 'manage currency', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(225, 'add currency', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(226, 'edit currency', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(227, 'update currency', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(228, 'update currency api', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(229, 'manage charges', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(230, 'edit charge', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(231, 'update charge', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(232, 'manage country', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(233, 'add country', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(234, 'update country', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(235, 'manage modules', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(236, 'update module', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(237, 'manage kyc', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(238, 'manage kyc form', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(239, 'kyc form add', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(240, 'kyc form update', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(241, 'kyc form delete', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(242, 'kyc info', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(243, 'kyc details', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(244, 'kyc approve', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(245, 'kyc reject', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(246, 'manage escrow', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(247, 'escrow on-hold', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(248, 'escrow disputed', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(249, 'escrow details', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(250, 'dispute store', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(251, 'escrow return payment', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(252, 'escrow file download', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(253, 'escrow close', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(254, 'manage role', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(255, 'create role', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(256, 'edit permissions', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(257, 'update permissions', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(258, 'manage staff', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(259, 'add staff', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(260, 'update staff', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(261, 'general setting', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(262, 'general settings update', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(263, 'general settings logo favicon', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(264, 'general settings status update', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(265, 'menu builder', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(266, 'maintainance', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(267, 'email templates', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(268, 'template edit', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(269, 'template update', 'admin', '2022-02-16 23:31:25', '2022-02-16 23:31:25'),
	(270, 'email config', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(271, 'group email', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(272, 'sms gateways', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(273, 'sms gateway edit', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(274, 'sms gateway update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(275, 'sms templates', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(276, 'sms template edit', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(277, 'sms template update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(278, 'site contents', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(279, 'edit site contents', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(280, 'site content update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(281, 'site sub-content update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(282, 'section status update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(283, 'withdraw method', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(284, 'withdraw method search', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(285, 'withdraw method create', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(286, 'withdraw method edit', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(287, 'withdraw method update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(288, 'pending withdraw', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(289, 'accepted withdraw', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(290, 'rejected withdraw', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(291, 'withdraw accept', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(292, 'withdraw reject', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(293, 'manage payment gateway', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(294, 'add payment gateway', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(295, 'store payment gateway', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(296, 'edit payment gateway', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(297, 'update payment gateway', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(298, 'manage deposit', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(299, 'approve deposit', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(300, 'reject deposit', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(301, 'manage page', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(302, 'page create', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(303, 'page store', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(304, 'page edit', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(305, 'page update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(306, 'page remove', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(307, 'manage cookie', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(308, 'update cookie', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(309, 'manage blog-category', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(310, 'store blog-category', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(311, 'update blog-category', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(312, 'manage blog', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(313, 'blog create', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(314, 'blog store', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(315, 'blog edit', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(316, 'blog update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(317, 'blog destroy', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(318, 'manage language', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(319, 'manage ticket', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(320, 'reply ticket', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(321, 'seo settings', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(322, 'manage addon', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(323, 'system update', 'admin', '2022-02-16 23:31:26', '2022-02-16 23:31:26'),
	(324, 'manage agent list', 'admin', '2021-12-20 06:20:33', '2021-12-20 02:15:39'),
	(325, 'manage agent profile', 'admin', '2021-12-20 06:20:33', '2021-12-20 02:15:39'),
	(326, 'agent fund request', 'admin', '2021-12-20 06:20:33', '2021-12-20 02:15:39');

-- Dumping structure for table alaba_test.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `expires_at` timestamp NULL DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.personal_access_tokens: ~102 rows (approximately)
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `expires_at`, `last_used_at`, `created_at`, `updated_at`) VALUES
	(1, 'App\\Models\\User', 2, 'wallet', '0f7ba998a525a19e8f6a7cd3e51797131e36f636095406686dcdab7451357b1f', '["*"]', NULL, NULL, '2023-10-03 16:12:31', '2023-10-03 16:12:31'),
	(2, 'App\\Models\\User', 2, 'wallet', '5665672d162085312fca15a2dd3f67c216f684566a3950164aeff065e0283fa1', '["*"]', NULL, NULL, '2023-10-03 16:12:50', '2023-10-03 16:12:50'),
	(3, 'App\\Models\\User', 2, 'wallet', '7ea5597df9db315ca54a62a3709840a169aad45366ffd35a4a012aee24dcc004', '["*"]', NULL, '2023-10-04 05:15:03', '2023-10-03 16:16:16', '2023-10-04 05:15:03'),
	(4, 'App\\Models\\User', 2, 'wallet', 'a4ddada7d6a44a77828f0568e2a056f15a71ef891e3ab8e0e94a9dec2edbf4b4', '["*"]', NULL, NULL, '2023-10-03 16:54:23', '2023-10-03 16:54:23'),
	(5, 'App\\Models\\User', 3, 'wallet', 'f337e63e3e5ef6cfd13d58a2b49405815f977a91b018c190d2b5b9b10bcca578', '["*"]', NULL, NULL, '2023-10-03 16:55:14', '2023-10-03 16:55:14'),
	(6, 'App\\Models\\User', 2, 'wallet', '1b251e90fba07349a4dbcff6dd957bb546064ffdc20838ddbdf80ea3d17d9f25', '["*"]', NULL, '2023-10-03 17:00:40', '2023-10-03 17:00:39', '2023-10-03 17:00:40'),
	(7, 'App\\Models\\User', 2, 'wallet', 'db0ef71129d147b167c7043d0b15b1d78efc2cf2ae6f7d35a83c97de9ec8a825', '["*"]', NULL, '2023-10-03 18:14:19', '2023-10-03 18:14:17', '2023-10-03 18:14:19'),
	(8, 'App\\Models\\User', 4, 'wallet', 'e451c45b42791dae0ff14d3bd6d239a356e666d9156648fb4868e901282f58eb', '["*"]', NULL, '2023-10-03 19:22:47', '2023-10-03 19:22:45', '2023-10-03 19:22:47'),
	(9, 'App\\Models\\User', 2, 'wallet', '66bcf9c5cb1e6444555a580b7a21960e20b8fecf96a88c03e8ba3c52638c62c2', '["*"]', NULL, '2023-10-03 19:42:11', '2023-10-03 19:42:09', '2023-10-03 19:42:11'),
	(10, 'App\\Models\\User', 5, 'wallet', 'a1474f58009f9cc056e753b57770f7b99e6b26581e37653a3e4dcb16a7697a99', '["*"]', NULL, '2023-10-03 19:42:50', '2023-10-03 19:42:49', '2023-10-03 19:42:50'),
	(11, 'App\\Models\\User', 2, 'wallet', '4740a80c818c937620b21f1165d074b342648864e9a260ab8bf9d42dd9d95774', '["*"]', NULL, '2023-10-03 22:40:48', '2023-10-03 22:40:47', '2023-10-03 22:40:48'),
	(12, 'App\\Models\\User', 2, 'wallet', '189ab4b69206c959b64a3d4454adaf274e2c1a89b1dc8c8c63f77da61b6641c7', '["*"]', NULL, '2023-10-03 22:54:47', '2023-10-03 22:54:38', '2023-10-03 22:54:47'),
	(13, 'App\\Models\\User', 2, 'wallet', 'ac1f48e2331366aa3524f57bc208284920db6478031638551bf9ffaf323a2815', '["*"]', NULL, '2023-10-04 18:39:47', '2023-10-03 22:55:37', '2023-10-04 18:39:47'),
	(14, 'App\\Models\\User', 2, 'wallet', 'b85a4da696ee5756462b820be8427efd3bdd9135853473f6be899f824c4f87f1', '["*"]', NULL, '2023-10-04 12:52:43', '2023-10-04 12:46:34', '2023-10-04 12:52:43'),
	(15, 'App\\Models\\User', 2, 'wallet', '2cf512d92ad2934ff4cf00ed4748cd1ba65d7c7b4b3b69fe264729c16fe963ab', '["*"]', NULL, NULL, '2023-10-04 13:03:16', '2023-10-04 13:03:16'),
	(16, 'App\\Models\\User', 2, 'wallet', '78d3580c71690e8b4fabe9a2b4f135beacfdc703e1e1b43f76042b94e2494ecf', '["*"]', NULL, NULL, '2023-10-04 13:06:48', '2023-10-04 13:06:48'),
	(17, 'App\\Models\\User', 2, 'wallet', '8d3339b63325fd2a4906186e5601354f3bfe7e17da6dea5f7144f366f5cc0ae5', '["*"]', NULL, NULL, '2023-10-04 13:10:45', '2023-10-04 13:10:45'),
	(18, 'App\\Models\\User', 2, 'wallet', '203d8598af3f641fb13812a091bc5677bd76c006d2bce19f2f582592cb396e2e', '["*"]', NULL, '2023-10-05 04:21:29', '2023-10-04 13:11:43', '2023-10-05 04:21:29'),
	(19, 'App\\Models\\User', 2, 'wallet', '240a39287dbd8cb864f998d13288e66181dd5d4008f5f1e38f23a905919587af', '["*"]', NULL, NULL, '2023-10-04 13:14:04', '2023-10-04 13:14:04'),
	(20, 'App\\Models\\User', 2, 'wallet', 'c34f7724d7166d881cb504840bf2935503f508cc3cf4b6c378061d1b808d9501', '["*"]', NULL, NULL, '2023-10-04 13:14:11', '2023-10-04 13:14:11'),
	(21, 'App\\Models\\User', 2, 'wallet', 'c15b25d908eefbd1f2115ec004d957f5a47d301488fb08b9f631ffb25d6e2a3e', '["*"]', NULL, NULL, '2023-10-04 13:16:30', '2023-10-04 13:16:30'),
	(22, 'App\\Models\\User', 2, 'wallet', '9c19a5e62d7d511095d5f29dc7a79ab32509ff07667025bba08b9bd1fb942af1', '["*"]', NULL, NULL, '2023-10-04 22:45:37', '2023-10-04 22:45:37'),
	(23, 'App\\Models\\User', 2, 'wallet', '906ee2a5fb5b51670d99ea0cfd83f8fb1f2ff256bcf1fc688be918b514755f36', '["*"]', NULL, '2023-10-05 04:41:25', '2023-10-04 22:49:39', '2023-10-05 04:41:25'),
	(24, 'App\\Models\\User', 6, 'wallet', '979fe13976629153d1eeb5614febec121121bf0b946c3275a67bd50b7fe3ccb4', '["*"]', NULL, '2023-10-05 12:24:57', '2023-10-05 04:30:38', '2023-10-05 12:24:57'),
	(25, 'App\\Models\\User', 6, 'wallet', '4f2c0f16e16b2f02836abb32b1079799d05c9b4057445fceace65d59a03f76bb', '["*"]', NULL, '2023-10-05 04:49:04', '2023-10-05 04:44:26', '2023-10-05 04:49:04'),
	(26, 'App\\Models\\User', 2, 'wallet', '556199deb615880eef25d652ef4e2303a00bba0f172745e69544871c7cd70339', '["*"]', NULL, '2023-10-05 05:00:02', '2023-10-05 04:49:38', '2023-10-05 05:00:02'),
	(27, 'App\\Models\\User', 6, 'wallet', '094332fafffa1b93ed3d3b5babb3d7c2088d9e7de20a08aac339a0bb369927a9', '["*"]', NULL, '2023-10-05 05:00:53', '2023-10-05 05:00:41', '2023-10-05 05:00:53'),
	(28, 'App\\Models\\User', 2, 'wallet', '46e3c02359706a799b40a5bd29e4b16b267806dc04d0f100be4a3be7ad35e9b4', '["*"]', NULL, '2023-10-07 23:06:28', '2023-10-05 05:02:50', '2023-10-07 23:06:28'),
	(29, 'App\\Models\\User', 2, 'wallet', '8c5764cc5f38182d30c49148e7ef116881a211de585bf2517a84f6215916a60e', '["*"]', NULL, '2023-10-08 18:46:09', '2023-10-05 10:15:13', '2023-10-08 18:46:09'),
	(30, 'App\\Models\\User', 2, 'wallet', 'bb18de61974671433f78be7be9e20dc600d67a62e19e0ccd27fd2f1988e936f5', '["*"]', NULL, '2023-10-05 19:54:53', '2023-10-05 18:17:54', '2023-10-05 19:54:53'),
	(31, 'App\\Models\\User', 2, 'wallet', '74abb29fbc2ce4f964ad624d37f510e94a97ced6c5ae84af7f39e36fee9627e0', '["*"]', NULL, '2023-10-07 05:47:17', '2023-10-06 01:44:39', '2023-10-07 05:47:17'),
	(32, 'App\\Models\\User', 2, 'wallet', '8d719026985c1f380351c900c88f811858079c89c0600ac4431eaab71ce46c0d', '["*"]', NULL, '2023-10-08 18:18:32', '2023-10-07 16:29:02', '2023-10-08 18:18:32'),
	(33, 'App\\Models\\User', 2, 'wallet', 'e756d674493532e8e42ba36ca9c9a34376a4ade0b209247caa90d2478ddd37df', '["*"]', NULL, '2023-10-19 12:07:27', '2023-10-08 18:47:04', '2023-10-19 12:07:27'),
	(34, 'App\\Models\\User', 2, 'wallet', '73c937cebdcb45c141175767f188b1b23520f9e1b2fc2cbb14681237746d9d31', '["*"]', NULL, '2023-10-14 00:03:18', '2023-10-09 13:57:02', '2023-10-14 00:03:18'),
	(35, 'App\\Models\\User', 2, 'wallet', '0712d45a11249bf7788205f2c39353b5e2d5f7c373896df4b94fc642bede9ce1', '["*"]', NULL, '2023-10-13 12:44:14', '2023-10-09 14:04:45', '2023-10-13 12:44:14'),
	(36, 'App\\Models\\User', 8, 'wallet', '7f6310080c71c3bab4f297063fad6c5173e711d88326cc3a18d4cf04e88a63fb', '["*"]', NULL, '2023-10-13 15:18:45', '2023-10-13 12:44:06', '2023-10-13 15:18:45'),
	(37, 'App\\Models\\User', 2, 'wallet', '4a4e364333928544f340fe927c5f598c930d7c9fe255f31bea162ae9cde5c17a', '["*"]', NULL, '2023-10-17 14:19:30', '2023-10-13 15:18:55', '2023-10-17 14:19:30'),
	(38, 'App\\Models\\User', 2, 'wallet', '25adebe316dced97e7a9b11530db801761033d6c2d7643a168db1573d218932e', '["*"]', NULL, '2023-10-18 13:51:32', '2023-10-13 18:31:28', '2023-10-18 13:51:32'),
	(39, 'App\\Models\\User', 9, 'wallet', '49b3c7204ec277e0f936ec6e6de434bec26a97b2bccaf3d5dd09f9a4536663ea', '["*"]', NULL, '2023-10-14 00:23:41', '2023-10-14 00:23:40', '2023-10-14 00:23:41'),
	(40, 'App\\Models\\User', 2, 'wallet', 'ac2af4f607e8dca84d8afaf4567225b93c4871d583a7936fa8340b276f602407', '["*"]', NULL, '2023-10-14 00:36:37', '2023-10-14 00:36:36', '2023-10-14 00:36:37'),
	(41, 'App\\Models\\User', 9, 'wallet', '30e4cc9034d29911667ad76034b2792402553dd5b4dfb0518845e287df4a7b73', '["*"]', NULL, '2023-10-14 00:52:08', '2023-10-14 00:45:55', '2023-10-14 00:52:08'),
	(42, 'App\\Models\\User', 8, 'wallet', '55ae5844f8c8dce27ca2a7e3694acda0b8cf85ce340fe83a9f51586b2c3b8c8e', '["*"]', NULL, '2023-10-17 12:46:19', '2023-10-14 00:52:27', '2023-10-17 12:46:19'),
	(43, 'App\\Models\\User', 2, 'wallet', '32a60755eb1577a4d03db1af0085010efc05331c74cdd459415b9491bd559e85', '["*"]', NULL, '2023-10-25 03:24:13', '2023-10-17 12:50:52', '2023-10-25 03:24:13'),
	(44, 'App\\Models\\User', 2, 'wallet', '5b650ef2f32d488301fc5b910461e24d21d5c2b2eb79290ba97f03fa43e6cf61', '["*"]', NULL, '2023-10-17 18:33:06', '2023-10-17 18:30:13', '2023-10-17 18:33:06'),
	(45, 'App\\Models\\User', 2, 'wallet', '3c91fd99f2f9a127cffc3ba23cd330f226b9f0c4061d9508407950467f5a9180', '["*"]', NULL, '2023-10-18 16:52:37', '2023-10-18 13:40:32', '2023-10-18 16:52:37'),
	(46, 'App\\Models\\User', 10, 'wallet', '2adaa4edba31646dabc77f3146af523acde5017ebfa703f1abe1d48e67656b2e', '["*"]', NULL, '2023-10-18 13:49:47', '2023-10-18 13:47:01', '2023-10-18 13:49:47'),
	(47, 'App\\Models\\User', 10, 'wallet', '59aa9f922793742ad98f374ff1b86de53c1f17fbce39191ff9b5d55d253ab089', '["*"]', NULL, '2023-10-18 17:50:53', '2023-10-18 13:50:08', '2023-10-18 17:50:53'),
	(48, 'App\\Models\\User', 2, 'wallet', 'd5e833f39f91fa4158d8bdadd888f3efadd6cdb8844ec859711cfaeca92817ac', '["*"]', NULL, NULL, '2023-10-18 14:16:19', '2023-10-18 14:16:19'),
	(49, 'App\\Models\\User', 2, 'wallet', '1f6c9c221c1c40913fcf7832cf1502479d11ac2fbb33b9c232c06aa4b8f3d108', '["*"]', NULL, '2023-10-18 14:22:52', '2023-10-18 14:21:58', '2023-10-18 14:22:52'),
	(50, 'App\\Models\\User', 2, 'wallet', '8d00b98487a27bb14d2b83d49f674b5af1b5e7033a86657188e765ea8717d6bc', '["*"]', NULL, '2023-10-18 15:46:59', '2023-10-18 14:23:09', '2023-10-18 15:46:59'),
	(51, 'App\\Models\\User', 2, 'wallet', '68ddf95eb4eebd81b8e7b0b52f2be0c808577c750c8b9287e9193314253d6c05', '["*"]', NULL, '2023-10-18 15:47:33', '2023-10-18 15:47:06', '2023-10-18 15:47:33'),
	(52, 'App\\Models\\User', 2, 'wallet', '3c53a219755ab1155d0933af45d2bf6798c2a836e9a289c1a313edbe9957f55a', '["*"]', NULL, '2023-10-18 15:49:47', '2023-10-18 15:47:44', '2023-10-18 15:49:47'),
	(53, 'App\\Models\\User', 2, 'wallet', '3d0cd6515cfed12d28300aa8d8a3e9ffb95d4eebed1ba41586cd960b54fea93c', '["*"]', NULL, '2023-10-18 15:50:50', '2023-10-18 15:50:37', '2023-10-18 15:50:50'),
	(54, 'App\\Models\\User', 2, 'wallet', '77a2fd74f27a8323b4e805e53200ac4be4afd59dbafb29cd63aa844aa661d269', '["*"]', NULL, NULL, '2023-10-18 15:52:30', '2023-10-18 15:52:30'),
	(55, 'App\\Models\\User', 2, 'wallet', 'e6f88ac04fb108b55422117a8e6eebdcd9a5075938c11777a4c38ea68878dfa1', '["*"]', NULL, NULL, '2023-10-18 16:00:01', '2023-10-18 16:00:01'),
	(56, 'App\\Models\\User', 2, 'wallet', '3153874c89daa19500157688f52a594b784e5e29887c80ca5cc2ffd4cebf4aeb', '["*"]', NULL, NULL, '2023-10-18 16:00:11', '2023-10-18 16:00:11'),
	(57, 'App\\Models\\User', 2, 'wallet', 'be8106da7d8c8b95e905cb2ad632c3185f9c1df4f6facf83cc2dc16e4c058461', '["*"]', NULL, NULL, '2023-10-18 16:01:17', '2023-10-18 16:01:17'),
	(58, 'App\\Models\\User', 2, 'wallet', 'b45ef6d4367b20933f639d3bb19335ee413a4201ca074b954a82e5e1852fb975', '["*"]', NULL, NULL, '2023-10-18 16:01:38', '2023-10-18 16:01:38'),
	(59, 'App\\Models\\User', 2, 'wallet', 'b56556b0f5cb7b93ffa653f8d26921cd1f1470d2baef255c60b842229f5e2eec', '["*"]', NULL, '2023-10-18 16:51:55', '2023-10-18 16:01:45', '2023-10-18 16:51:55'),
	(60, 'App\\Models\\User', 8, 'wallet', '171759408ca8140ae2c95fd5ce2be6d92bc25499d2ea5d2b86cfb922ff766f91', '["*"]', NULL, NULL, '2023-10-18 16:58:22', '2023-10-18 16:58:22'),
	(61, 'App\\Models\\User', 8, 'wallet', 'a6d96c0b76c6004dc2c9b14f3ddada47aa2b6c7c8b7200d1d0060057d2adbfa9', '["*"]', NULL, '2023-10-18 17:12:49', '2023-10-18 17:00:34', '2023-10-18 17:12:49'),
	(62, 'App\\Models\\User', 2, 'wallet', '515a07112b9becf333dff3172d4c6511858fda08e548df319ae46c7702992fc5', '["*"]', NULL, '2023-10-18 17:48:32', '2023-10-18 17:12:58', '2023-10-18 17:48:32'),
	(63, 'App\\Models\\User', 2, 'wallet', '4b42830e5a2213a9630241e2cf7cffae73fda0d7197d772a2b53b594241acc65', '["*"]', NULL, '2023-10-26 11:53:58', '2023-10-18 19:36:38', '2023-10-26 11:53:58'),
	(64, 'App\\Models\\User', 2, 'wallet', '5357363af9410c1528e927993809e631637dcb4adaed0e47f3f8148578649208', '["*"]', NULL, '2023-10-18 19:45:58', '2023-10-18 19:44:44', '2023-10-18 19:45:58'),
	(65, 'App\\Models\\User', 2, 'wallet', 'b4d21dd2f204db7e47ac09d934a47cd425db5c5ec3d318c141f37bc485ac26e8', '["*"]', NULL, '2023-10-18 19:47:18', '2023-10-18 19:46:28', '2023-10-18 19:47:18'),
	(66, 'App\\Models\\User', 2, 'wallet', '79388cdc0fd54e618ca60b871c9a64847f82928ec67f3c7b55487e3807d2757f', '["*"]', NULL, NULL, '2023-10-18 19:46:28', '2023-10-18 19:46:28'),
	(67, 'App\\Models\\User', 2, 'wallet', 'b17b92942fc7e45f7b90a0a56ef5e2c075fff657368acfaa08cac910bce710c1', '["*"]', NULL, '2023-10-18 19:47:37', '2023-10-18 19:47:35', '2023-10-18 19:47:37'),
	(68, 'App\\Models\\User', 2, 'wallet', 'dc0f150391d5dcf49cfc800a31edc6d8ebd5b06adeb3576f7de6a3ad381c6262', '["*"]', NULL, '2023-10-19 16:28:49', '2023-10-18 19:47:47', '2023-10-19 16:28:49'),
	(69, 'App\\Models\\User', 2, 'wallet', '94702cc7ebc5a504b23a0ca79bca880a3d66b33ef98586365d1bf8d8c64e46fe', '["*"]', NULL, '2023-10-24 15:11:48', '2023-10-19 14:29:55', '2023-10-24 15:11:48'),
	(70, 'App\\Models\\User', 2, 'wallet', 'a45de37eb6e02e45038bdcaa2acf154b071cc91b629eed15392744f633fd3c1d', '["*"]', NULL, '2023-10-19 18:36:56', '2023-10-19 15:22:14', '2023-10-19 18:36:56'),
	(71, 'App\\Models\\User', 11, 'wallet', '729facadfd8ce9cfbc23ce40b15affdc05652a0822e09b1bfd7334f60be5953d', '["*"]', NULL, '2023-10-19 15:53:45', '2023-10-19 15:45:27', '2023-10-19 15:53:45'),
	(72, 'App\\Models\\User', 11, 'wallet', '849039432a1d1ce1e931a2e6280986d980a6d029b9647886a87552bc3f34ff79', '["*"]', NULL, '2023-10-19 16:58:17', '2023-10-19 16:01:28', '2023-10-19 16:58:17'),
	(73, 'App\\Models\\User', 11, 'wallet', '70e54fd214eed32c35acf397fc7260ed73acd3acc3c09d20d6d8bacfa48d6889', '["*"]', NULL, '2023-10-19 18:35:16', '2023-10-19 16:30:10', '2023-10-19 18:35:16'),
	(74, 'App\\Models\\User', 11, 'wallet', 'f890e5a64945301c84d20f3f95560bea6a0e95be73b4adf6ab18ffa6aee87e7b', '["*"]', NULL, '2023-10-19 18:35:26', '2023-10-19 16:34:10', '2023-10-19 18:35:26'),
	(75, 'App\\Models\\User', 11, 'wallet', 'd46eadc00deae3786da2501bc0cd6b4af8ce9e3cebc1cdb75dc08ada6fb98731', '["*"]', NULL, '2023-10-19 17:22:32', '2023-10-19 17:22:19', '2023-10-19 17:22:32'),
	(76, 'App\\Models\\User', 11, 'wallet', 'f751dba392aeac5a38b284481525faba91b58c9a7a4ed2a962c6142534ac3011', '["*"]', NULL, '2023-10-19 17:23:29', '2023-10-19 17:23:18', '2023-10-19 17:23:29'),
	(77, 'App\\Models\\User', 11, 'wallet', '22ba8b05a099d0d0eba32fc49accd7849f4c58ae5cb2e0696abcb1f8fd6cbdbf', '["*"]', NULL, '2023-10-19 17:32:42', '2023-10-19 17:30:10', '2023-10-19 17:32:42'),
	(78, 'App\\Models\\User', 2, 'wallet', 'aac146b842d5633f96b3c8d4fc37f0dcdaca62a3c37d70c3dcd366f215ffe5a7', '["*"]', NULL, '2023-10-19 17:33:37', '2023-10-19 17:33:17', '2023-10-19 17:33:37'),
	(79, 'App\\Models\\User', 11, 'wallet', '25eac4f35496bd55612f19f852f7aa47909ccf2e0878d57fe0388464add617a0', '["*"]', NULL, '2023-10-19 17:35:54', '2023-10-19 17:34:21', '2023-10-19 17:35:54'),
	(80, 'App\\Models\\User', 2, 'wallet', '34d7b08dfdef5d27e10549b65c880a2b3044e39ae39f307574ed0b257cafcccb', '["*"]', NULL, '2023-10-19 17:36:36', '2023-10-19 17:36:13', '2023-10-19 17:36:36'),
	(81, 'App\\Models\\User', 11, 'wallet', '3855c875252a4e8fc34496ec32da3a846564dd0b63dac106676d515d20a792bf', '["*"]', NULL, '2023-10-19 17:39:52', '2023-10-19 17:36:56', '2023-10-19 17:39:52'),
	(82, 'App\\Models\\User', 2, 'wallet', '7a4ee32cfcc20757ad25606b9c82b8f399cbfec4e2172d4bc7b7ecbdf621c1b1', '["*"]', NULL, '2023-10-26 12:12:59', '2023-10-19 17:40:21', '2023-10-26 12:12:59'),
	(83, 'App\\Models\\User', 2, 'wallet', 'c8a18e6a2d9cde888695f05c0fa4e0bd0c304937b0e1443b148d3f1774d28e40', '["*"]', NULL, '2023-10-19 18:35:46', '2023-10-19 18:35:41', '2023-10-19 18:35:46'),
	(84, 'App\\Models\\User', 2, 'wallet', '6d40e93bc7563b5d1584e8b565053cdc48c7c031d42db98b9067a99bcb9778bb', '["*"]', NULL, '2023-10-20 04:07:02', '2023-10-20 03:33:57', '2023-10-20 04:07:02'),
	(85, 'App\\Models\\User', 2, 'wallet', 'd3037cf1e9551f78d433ab25fd18f3e3a2f4ca106223817aecfaa902507b108f', '["*"]', NULL, '2023-10-20 18:03:36', '2023-10-20 18:00:39', '2023-10-20 18:03:36'),
	(86, 'App\\Models\\User', 2, 'wallet', '0b940e1ae0e3feaf228effeaa3af33e359fb6089b7510578fb6fad76eba59abf', '["*"]', NULL, '2023-10-20 18:03:20', '2023-10-20 18:03:03', '2023-10-20 18:03:20'),
	(87, 'App\\Models\\User', 2, 'wallet', '306be26880265eab58e1dbdc6878c67f1193d389f17988b010db9b13500bc8cd', '["*"]', NULL, '2023-10-21 02:19:09', '2023-10-21 02:17:31', '2023-10-21 02:19:09'),
	(88, 'App\\Models\\User', 12, 'wallet', '658bf7fb6950981c8844d27d0a425c3e17a4e41b28c4167e3b8916f98379c442', '["*"]', NULL, '2023-10-21 15:07:30', '2023-10-21 14:29:30', '2023-10-21 15:07:30'),
	(89, 'App\\Models\\User', 2, 'wallet', 'da17603d3186718fa2000ab6f88c93a9d7ef88c93c3397d70f8b35bcbffac094', '["*"]', NULL, '2023-10-25 11:00:06', '2023-10-24 15:12:13', '2023-10-25 11:00:06'),
	(90, 'App\\Models\\User', 2, 'wallet', '179b06764560b5cbc40b26afd4af219fb07495f4708e93491526af8fd57f787d', '["*"]', NULL, '2023-10-24 16:10:09', '2023-10-24 15:12:37', '2023-10-24 16:10:09'),
	(91, 'App\\Models\\User', 11, 'wallet', 'b08a4eb40a3aeeafbf69ce796ee3ea6e8127f5fbcff757775da3ed75cc9b740a', '["*"]', NULL, '2023-10-24 17:22:20', '2023-10-24 16:03:15', '2023-10-24 17:22:20'),
	(92, 'App\\Models\\User', 2, 'wallet', '032ceef123bbe0dceb68f0715cc4568cad509ea0e54ad36d3dcf07cb12aae22c', '["*"]', NULL, '2023-10-24 17:24:31', '2023-10-24 17:22:45', '2023-10-24 17:24:31'),
	(93, 'App\\Models\\User', 11, 'wallet', '52ecbfa5b0af7e1c65b6a90a9e6d3c488fab2c37a6825538a6649615f1186cb2', '["*"]', NULL, '2023-10-25 12:16:18', '2023-10-24 17:24:55', '2023-10-25 12:16:18'),
	(94, 'App\\Models\\User', 11, 'wallet', 'a8d0deebe4a9f282099194e53aa429a041e215171cfacf912c042dbe26ac69e9', '["*"]', NULL, '2023-10-25 22:41:03', '2023-10-25 03:24:56', '2023-10-25 22:41:03'),
	(95, 'App\\Models\\User', 11, 'wallet', 'f8ab80e8c954af68245e0d8641b2317694f8bb3788be32a31489d60825007732', '["*"]', NULL, '2023-10-25 03:28:48', '2023-10-25 03:26:49', '2023-10-25 03:28:48'),
	(96, 'App\\Models\\User', 2, 'wallet', '646794ef1a682506c7f4d180a604fa09dc0fb6f2ba880f9194ba2e7562f1c3c5', '["*"]', NULL, '2023-10-27 14:23:39', '2023-10-25 12:27:20', '2023-10-27 14:23:39'),
	(97, 'App\\Models\\User', 2, 'wallet', '5313e00920736f591b9fc5b88027d06ba362053c5f5a0d6ceaa72c970f4cec13', '["*"]', NULL, '2023-10-25 12:50:01', '2023-10-25 12:48:19', '2023-10-25 12:50:01'),
	(98, 'App\\Models\\User', 2, 'wallet', '38a6ec09031b465da8ea8fcab90dcd253b6f24b59bb6e39aa398380f3db9d992', '["*"]', NULL, '2023-10-26 13:21:54', '2023-10-26 04:44:19', '2023-10-26 13:21:54'),
	(99, 'App\\Models\\User', 2, 'wallet', '15bd59355b2d522f0a79e29807b8533d7329a139c36ef9be13eef8ef6f88d295', '["*"]', NULL, '2023-10-26 15:54:46', '2023-10-26 10:13:54', '2023-10-26 15:54:46'),
	(100, 'App\\Models\\User', 2, 'wallet', '328e7fbbc499b317cabc6276273373a2227737c8475e188371c368bb159858a6', '["*"]', NULL, '2023-10-28 21:36:46', '2023-10-28 21:32:15', '2023-10-28 21:36:46'),
	(101, 'App\\Models\\User', 10, 'wallet', 'af619dba21bd13da718c0aebe32701ab31d373bf944869c0ecd1721abcdc1551', '["*"]', NULL, '2023-10-29 17:02:46', '2023-10-29 14:23:25', '2023-10-29 17:02:46'),
	(102, 'App\\Models\\User', 2, 'wallet', '5c941bbe98850a67929caff2ba6bbea2f0a04c9a559513cc9b2498eabd6799db', '["*"]', NULL, '2023-10-30 11:12:17', '2023-10-30 10:13:08', '2023-10-30 11:12:17');

-- Dumping structure for table alaba_test.request_money
CREATE TABLE IF NOT EXISTS `request_money` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `currency_id` int NOT NULL,
  `request_amount` decimal(20,10) NOT NULL,
  `charge` decimal(20,10) NOT NULL,
  `final_amount` decimal(20,10) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0 => pending, 1 => accepted, 2 => rejected',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.request_money: ~0 rows (approximately)

-- Dumping structure for table alaba_test.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.roles: ~3 rows (approximately)
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin', '2022-01-17 04:25:50', '2022-01-17 04:25:50'),
	(3, 'moderator', 'admin', '2022-01-17 05:23:47', '2022-01-17 05:23:47'),
	(4, 'Ticket Handler', 'admin', '2022-02-16 23:55:38', '2022-02-16 23:55:38');

-- Dumping structure for table alaba_test.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.role_has_permissions: ~120 rows (approximately)
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(209, 1),
	(210, 1),
	(211, 1),
	(212, 1),
	(213, 1),
	(214, 1),
	(215, 1),
	(216, 1),
	(217, 1),
	(218, 1),
	(219, 1),
	(220, 1),
	(221, 1),
	(222, 1),
	(223, 1),
	(224, 1),
	(225, 1),
	(226, 1),
	(227, 1),
	(228, 1),
	(229, 1),
	(230, 1),
	(231, 1),
	(232, 1),
	(233, 1),
	(234, 1),
	(235, 1),
	(236, 1),
	(237, 1),
	(238, 1),
	(239, 1),
	(240, 1),
	(241, 1),
	(242, 1),
	(243, 1),
	(244, 1),
	(245, 1),
	(246, 1),
	(247, 1),
	(248, 1),
	(249, 1),
	(250, 1),
	(251, 1),
	(252, 1),
	(253, 1),
	(254, 1),
	(255, 1),
	(256, 1),
	(257, 1),
	(258, 1),
	(259, 1),
	(260, 1),
	(261, 1),
	(262, 1),
	(263, 1),
	(264, 1),
	(265, 1),
	(266, 1),
	(267, 1),
	(268, 1),
	(269, 1),
	(270, 1),
	(271, 1),
	(272, 1),
	(273, 1),
	(274, 1),
	(275, 1),
	(276, 1),
	(277, 1),
	(278, 1),
	(279, 1),
	(280, 1),
	(281, 1),
	(282, 1),
	(283, 1),
	(284, 1),
	(285, 1),
	(286, 1),
	(287, 1),
	(288, 1),
	(289, 1),
	(290, 1),
	(291, 1),
	(292, 1),
	(293, 1),
	(294, 1),
	(295, 1),
	(296, 1),
	(297, 1),
	(298, 1),
	(299, 1),
	(300, 1),
	(301, 1),
	(302, 1),
	(303, 1),
	(304, 1),
	(305, 1),
	(306, 1),
	(307, 1),
	(308, 1),
	(309, 1),
	(310, 1),
	(311, 1),
	(312, 1),
	(313, 1),
	(314, 1),
	(315, 1),
	(316, 1),
	(317, 1),
	(318, 1),
	(319, 1),
	(320, 1),
	(321, 1),
	(322, 1),
	(323, 1),
	(324, 1),
	(325, 1),
	(326, 1),
	(319, 4),
	(320, 4);

-- Dumping structure for table alaba_test.seo_settings
CREATE TABLE IF NOT EXISTS `seo_settings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `meta_tag` text COLLATE utf8mb4_general_ci,
  `meta_description` text COLLATE utf8mb4_general_ci,
  `meta_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table alaba_test.seo_settings: ~0 rows (approximately)
INSERT INTO `seo_settings` (`id`, `title`, `meta_tag`, `meta_description`, `meta_image`) VALUES
	(1, 'Genius Wallet - Advanced Wallet CMS with Payment Gateway API', 'wallet,wallet cms,Genius,Genius Wallet', 'Genius Wallet - Advanced Wallet CMS with Payment Gateway API', '15339411471646279600.png');

-- Dumping structure for table alaba_test.site_contents
CREATE TABLE IF NOT EXISTS `site_contents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `sub_content` longtext COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.site_contents: ~13 rows (approximately)
INSERT INTO `site_contents` (`id`, `name`, `slug`, `content`, `sub_content`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'banner', 'banner', '{"title":"Simple. Quick. Secure.","heading":"Make Online Banking Easier & Comfortable","sub_heading":"With Alaba Pay, you are not just making payments; you are unlocking a limitless world of premier financial experiences.","button_1_name":"Get Started","button_1_url":"\\/user\\/register","button_2_name":"Contact Us","button_2_url":"\\/contact","image_size":"1320x880","image":"7430732421644388266.jpg"}', NULL, 1, NULL, '2023-09-13 02:06:46'),
	(2, 'about\r\n', 'about', '{"title":"We Are Secure","heading":"We are Secure and Stable Platform","short_details":"At Alaba Pay, security is paramount. Using advanced encryption and rigorous security measures, we ensure your transactions and data are always protected. Our stable platform guarantees seamless service, offering peace of mind for all your financial activities. Trust Alaba Pay for secure, reliable payments","feature_1_icon":"fas fa-shipping-fast","feature_1_title":"Faster And Cheaper","feature_1_details":"Experience faster and cheaper transactions, ensuring efficiency and affordability for all your financial needs","feature_2_icon":"fas fa-user-shield","feature_2_title":"Trusted & Secure","feature_2_details":"Offers trusted and secure transactions, ensuring your data is always protected.","image_size":"700x570","image":"12626417021644473699.png"}', NULL, 1, NULL, '2024-06-21 00:15:15'),
	(3, 'service\r\n', 'service', '{"title":"Services","heading":"What We Serve to You","sub_heading":"Alaba Pay delivers a wide range of reliable and efficient financial services tailored to meet your every need seamlessly."}', '[{"icon":"fas fa-qrcode","title":"QR Code Payments:","details":"Use QR code payments for quick, contactless transactions at various merchants and retailers."},{"icon":"fas fa-store","title":"Secure Storage","details":"Store your financial information securely, ensuring your data is protected against unauthorized access."},{"icon":"far fa-hand-pointer","title":"One-Touch Payments","details":"Enjoy the convenience of one-touch payments for faster, hassle-free transactions anytime, anywhere"},{"icon":"fas fa-exchange-alt","title":"Instant Money Transfers","details":"Transfer money instantly to friends and family, both locally and internationally, with ease."},{"icon":"fas fa-history","title":"Bill Management","details":"Manage and pay your bills efficiently from one platform, keeping track of all due dates."},{"icon":"fas fa-award","title":"Rewards","details":"Earn and redeem loyalty rewards with every transaction, maximizing the value of your spending."}]', 1, NULL, '2024-06-21 00:19:46'),
	(4, 'how to\n', 'how', '{"title":"How To Start","heading":"With just a few simple steps!","sub_heading":"Getting started with Alaba Pay is quick and easy. Follow these simple steps to begin your seamless payment journey.","image_size":"720x700","image":"8838201231644403288.png"}', '[{"icon":"fas fa-user-plus","title":"Register to Alaba Pay","details":"Sign up for Alaba Pay easily by providing your basic information and creating a secure password."},{"icon":"fas fa-user-check","title":"Verify Your Account","details":"Verify your account quickly through email or SMS to enhance your security and access all features"},{"icon":"fas fa-exchange-alt","title":"Make Unlimited Transactions","details":"Enjoy the freedom to make unlimited transactions with no hidden fees, ensuring smooth and efficient financial management."}]', 1, NULL, '2024-06-21 00:23:11'),
	(5, 'Counter', 'counter', '{"title":"Our Statistics","heading":"Our Impressive Growth Metrics","sub_heading":"With Alaba Pay, experience unmatched growth. We boast millions of active users, thousands of daily transactions, and consistently high user satisfaction. Discover the benefits of our thriving platform here:","button_name":"Get Started","button_url":"\\/user\\/register"}', '[{"icon":"fas fa-users","title":"Happy Clients","counter":"890M"},{"icon":"fas fa-exchange-alt","title":"Total Transactions","counter":"96M"},{"icon":"fas fa-dollar-sign","title":"Total Deposit","counter":"$890M"},{"icon":"fas fa-money-check-alt","title":"Total Withdraw","counter":"$456M"}]', 1, NULL, '2024-06-20 21:04:35'),
	(6, 'Feature\r\n', 'feature', '{"title":"Your Benefits","heading":"Take The Stress Out Of Managing Your Wallet","sub_heading":"Alaba Pay simplifies your financial management with secure transactions, instant transfers, easy bill payments, and rewarding loyalty programs. Enjoy the peace of mind everyday."}', '[{"image_size":"128x128","title":"Global Coverage","details":"Alaba Pay provides seamless financial services across multiple countries, enabling you to make international transactions effortlessly and securely.","image":"11228532431644465552.png"},{"image_size":"128x128","title":"Lowest Fee","details":"Enjoy the most competitive rates with Alaba Pay, ensuring you save money on every transaction without hidden charges.","image":"9520810491646279362.png"},{"image_size":"128x128","title":"Simple Transfer Methods","details":"Easily transfer funds with just a few taps. Our user-friendly interface makes sending money fast, intuitive, and hassle-free.","image":"4080473251644466179.png"},{"image_size":"128x128","title":"Instant Processing","details":"Experience the convenience of instant processing, allowing your transactions to be completed in real-time with minimal delays.","image":"4808291231644466203.png"},{"image_size":"128x128","title":"Bank-level Security","details":"Trust in our advanced security protocols, which include encryption and fraud detection, ensuring your financial information remains safe.","image":"18431945771644466228.png"},{"image_size":"128x128","title":"Global 24\\/7 Support","details":"Our dedicated support team is available around the clock, providing you with assistance and resolving any issues no matter where you are.","image":"13995404631644466245.png"}]', 1, NULL, '2024-06-20 21:11:00'),
	(7, 'FAQs\r\n', 'faq', '{"title":"FAQs","heading":"Frequently Asked Questions","sub_heading":"Find quick answers to common questions about Alaba Pay. Our comprehensive FAQ section helps you resolve issues and understand our services better."}', '{"0":{"question":"How can I register an account on Alaba Pay?","answer":"Signing up for Alaba Pay is simple. Download our app from your app store, follow the on-screen instructions to create an account, and link your bank account or credit card."},"1":{"question":"Is my financial information secure with Alaba Pay?","answer":"Absolutely. Alaba Pay uses advanced encryption and bank-level security protocols to protect your financial data, ensuring every transaction is safe and secure"},"2":{"question":"Can I use Alaba Pay for international transactions?","answer":"Yes, Alaba Pay supports global transactions, allowing you to send and receive money internationally with ease and at competitive rates."},"3":{"question":"What should I do if I encounter an issue with my account?","answer":"Our global 24\\/7 support team is here to help. Contact us via the app, email, or phone, and we will resolve your issue promptly."},"4":{"question":"Are there any hidden fees with Alaba Pay?","answer":"No, Alaba Pay is transparent about its fees. We offer the lowest rates possible with no hidden charges, ensuring you know exactly what you\\u2019re paying."},"6":{"question":"Deserunt hic consequatur ex placeat?","answer":"First : Aut, expedita optio? Quis ab laudantium, facilis similique est alias, possimus expedita dolorum fugit mollitia, optio quo?\\r\\n\\r\\nSecond : Facilis similique est alias, possimus expedita dolorum fugit mollitia, optio quo? Dignissimos beatae officia repellat maiores!"},"7":{"question":"Deserunt hic consequatur ex placeat?","answer":"First : Aut, expedita optio? Quis ab laudantium, facilis similique est alias, possimus expedita dolorum fugit mollitia, optio quo?\\r\\n\\r\\nSecond : Facilis similique est alias, possimus expedita dolorum fugit mollitia, optio quo? Dignissimos beatae officia repellat maiores!"},"8":{"question":"Deserunt hic consequatur ex placeat?","answer":"First : Aut, expedita optio? Quis ab laudantium, facilis similique est alias, possimus expedita dolorum fugit mollitia, optio quo?\\r\\n\\r\\nSecond : Facilis similique est alias, possimus expedita dolorum fugit mollitia, optio quo? Dignissimos beatae officia repellat maiores!"},"9":{"question":"Deserunt hic consequatur ex placeat?","answer":"First : Aut, expedita optio? Quis ab laudantium, facilis similique est alias, possimus expedita dolorum fugit mollitia, optio quo?\\r\\n\\r\\nSecond : Facilis similique est alias, possimus expedita dolorum fugit mollitia, optio quo? Dignissimos beatae officia repellat maiores!"}}', 1, NULL, '2024-06-20 21:15:08'),
	(8, 'Testimonial', 'testimonial', '{"title":"Testimonials","heading":"What Clients Say About Us","sub_heading":"Read genuine feedback from satisfied Alaba Pay users. Discover how our reliable and efficient services have enhanced their financial experiences."}', '[{"image_size":"120x120","name":"Peter Parker","quote":"Using Alaba Pay has revolutionized how I handle my finances. The instant transfers and low fees make managing my money effortless and stress-free.","image":"17542701511644467352.png"},{"image_size":"120x120","name":"John Doe","quote":"Alaba Pay\'s secure platform gives me peace of mind. I love the convenience of one-touch payments and the seamless international transactions.","image":"17081516131644467428.png"},{"image_size":"120x120","name":"Stephen Rodrick","quote":"The customer support at Alaba Pay is exceptional. They resolved my issue quickly and professionally, making me feel valued and confident in their service.","image":"13860206431644467446.png"},{"image_size":"120x120","name":"Matt Damon","quote":"Alaba Pay makes bill payments so easy. The app\'s user-friendly interface and reliable services have saved me so much time and hassle.","image":"7314344801644467467.png"}]', 1, NULL, '2024-06-20 21:17:21'),
	(9, 'Blog', 'blog', '{"title":"Blog Posts","heading":"Our Latest News & Tips","sub_heading":"Stay updated with Alaba Pay\\u2019s latest news, helpful tips, and expert advice on managing your finances efficiently."}', NULL, 1, NULL, '2024-06-20 21:18:10'),
	(10, 'Sponsors', 'sponsors', '{"title":"Sponsors","heading":"Brand Sponsors","sub_heading":"We are proud to collaborate with leading brands and companies who share our vision. Our sponsors support us in delivering innovative financial solutions and exceptional services."}', '[{"image":"4506843581646279391.png","image_size":"260x200"},{"image":"4240436131646279399.png","image_size":"260x200"},{"image":"6956855071646279421.png","image_size":"260x200"},{"image":"3515199711644469859.png","image_size":"260x200"},{"image":"18874078061644469864.png","image_size":"260x200"},{"image":"5588095611644469870.png","image_size":"260x200"},{"image":"8676066221646279428.png","image_size":"260x200"},{"image":"13654331771646279436.png","image_size":"260x200"},{"image":"2093287281644469889.png","image_size":"260x200"}]', 1, NULL, '2024-06-20 21:19:15'),
	(11, 'Social Links', 'social', NULL, '[{"icon":"fab fa-facebook-f","url":"https:\\/\\/facebook.com"},{"icon":"fab fa-twitter","url":"https:\\/\\/twiiter.com"},{"icon":"fab fa-instagram","url":"https:\\/\\/instagram.com"},{"icon":"fab fa-linkedin-in","url":"https:\\/\\/linkedin.com"},{"icon":"fab fa-youtube","url":"https:\\/\\/youtube.com"}]', 1, NULL, '2022-02-13 02:49:01'),
	(12, 'Policies And Terms', 'policies', NULL, '[{"lang":"en","title":"Privacy","description":"<p><br><\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><strong>Lorem Ipsum<\\/strong>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><br><\\/p>"},{"lang":"en","title":"Terms and Condition","description":"<p><br><\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p>\\r\\n\\r\\n<p style=\\"text-align:justify;color:rgb(0,0,0);font-family:\'Open Sans\', Arial, sans-serif;\\"><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p>"},{"lang":"en","title":"Refund Policy","description":"<p>What is Lorem Ipsum?<br><\\/p><p><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p><p><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p><p><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p><p><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p><p>What is Lorem Ipsum?<\\/p><p><span style=\\"font-weight:bolder;\\">Lorem Ipsum<\\/span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p>"},{"lang":"bn","title":"Privacy","description":"<p><span style=\\"color:rgb(0,0,0);font-family:Inter, sans-serif;font-size:18px;text-align:justify;\\">\\u09aa\\u09cd\\u09b0\\u09be\\u099a\\u09c0\\u09a8 \\u0997\\u09cd\\u09b0\\u09bf\\u09b8\\u09c7\\u09b0 \\u09a8\\u09be\\u09ac\\u09bf\\u0995 \\u09ac\\u09be \\u099c\\u09c7\\u09b2\\u09c7\\u09b0\\u09be \\u0989\\u09a4\\u09cd\\u09a4\\u09be\\u09b2 \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0\\u09c7 \\u09aa\\u09cd\\u09b0\\u099a\\u09a3\\u09cd\\u09a1 \\u099d\\u09dc \\u09ac\\u09be \\u09a2\\u09c7\\u0989\\u09df\\u09c7\\u09b0 \\u0995\\u09ac\\u09b2\\u09c7 \\u09aa\\u09dc\\u09b2\\u09c7 \\u0995\\u09b0\\u099c\\u09cb\\u09dc\\u09c7 \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0-\\u09a6\\u09c7\\u09ac\\u09a4\\u09be \\u09aa\\u09b8\\u09be\\u0987\\u09a1\\u09a8\\u09c7\\u09b0 \\u09a8\\u09bf\\u0995\\u099f \\u09b8\\u09be\\u09b9\\u09be\\u09af\\u09cd\\u09af \\u09aa\\u09cd\\u09b0\\u09be\\u09b0\\u09cd\\u09a5\\u09a8\\u09be \\u0995\\u09b0\\u09a4\\u0964 \\u0995\\u09be\\u09b0\\u09a3, \\u0997\\u09cd\\u09b0\\u09bf\\u0995 \\u0989\\u09aa\\u0995\\u09a5\\u09be\\u09b0 \\u09ac\\u09bf\\u09b6\\u09be\\u09b2 \\u099c\\u09be\\u09df\\u0997\\u09be\\u099c\\u09c1\\u09dc\\u09c7 \\u09a8\\u09bf\\u099c\\u09c7\\u0995\\u09c7 \\u09ac\\u09bf\\u09b8\\u09cd\\u09a4\\u09c0\\u09b0\\u09cd\\u09a3 \\u099c\\u09b2\\u09b0\\u09be\\u09b6\\u09bf\\u09b0 \\u09ae\\u09a4\\u09cb \\u099b\\u09dc\\u09bf\\u09df\\u09c7 \\u09b0\\u09c7\\u0996\\u09c7\\u099b\\u09c7\\u09a8 \\u09aa\\u09b8\\u09be\\u0987\\u09a1\\u09a8\\u0964 \\u09aa\\u09a6 \\u0993 \\u09ac\\u09bf\\u09b6\\u09bf\\u09b7\\u09cd\\u099f\\u09a4\\u09be \\u0985\\u09a8\\u09c1\\u09b8\\u09be\\u09b0\\u09c7, \\u09a6\\u09c7\\u09ac\\u09b0\\u09be\\u099c \\u099c\\u09bf\\u0989\\u09b8\\u09c7\\u09b0 \\u09aa\\u09b0\\u0987 \\u09a4\\u09be\\u09b0 \\u0985\\u09ac\\u09b8\\u09cd\\u09a5\\u09be\\u09a8\\u0964 \\u099c\\u09bf\\u0989\\u09b8 \\u09af\\u09c7\\u09ad\\u09be\\u09ac\\u09c7 \\u09b8\\u09cd\\u09ac\\u09b0\\u09cd\\u0997\\u09c7\\u09b0 \\u09af\\u09be\\u09ac\\u09a4\\u09c0\\u09df \\u099c\\u09bf\\u09a8\\u09bf\\u09b8 \\u09b8\\u09be\\u09ae\\u09b2\\u09be\\u09a8, \\u09b9\\u09c7\\u09a1\\u09bf\\u09b8 \\u09af\\u09c7\\u09ad\\u09be\\u09ac\\u09c7 \\u09aa\\u09be\\u09a4\\u09be\\u09b2\\u09aa\\u09c1\\u09b0\\u09c0\\u09b0 \\u0998\\u09c1\\u099f\\u0998\\u09c1\\u099f\\u09c7 \\u0985\\u09a8\\u09cd\\u09a7\\u0995\\u09be\\u09b0\\u09c7 \\u0997\\u09c1\\u09b0\\u09c1\\u09a6\\u09be\\u09df\\u09bf\\u09a4\\u09cd\\u09ac \\u09aa\\u09be\\u09b2\\u09a8 \\u0995\\u09b0\\u09c7 \\u0986\\u09b8\\u099b\\u09c7\\u09a8, \\u09a4\\u09c7\\u09ae\\u09a8\\u09bf \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0\\u09c7\\u09b0 \\u098f\\u0995\\u099a\\u09cd\\u099b\\u09a4\\u09cd\\u09b0 \\u0985\\u09a7\\u09bf\\u09aa\\u09a4\\u09bf \\u09b9\\u09bf\\u09b8\\u09c7\\u09ac\\u09c7 \\u0985\\u09a5\\u09c8 \\u099c\\u09b2\\u09c7\\u09b0 \\u09a2\\u09c7\\u0989 \\u09ad\\u09c7\\u0999\\u09c7 \\u09a8\\u09bf\\u099c\\u09c7\\u09b0 \\u09b0\\u09be\\u099c\\u09a4\\u09cd\\u09ac \\u0995\\u09be\\u09df\\u09c7\\u09ae \\u09b0\\u09be\\u0996\\u09c7\\u09a8 \\u09aa\\u09b8\\u09be\\u0987\\u09a1\\u09a8\\u0964 \\u09a6\\u09c7\\u09ac\\u09a4\\u09be\\u09a6\\u09c7\\u09b0 \\u09ae\\u09a7\\u09cd\\u09af \\u09a4\\u09bf\\u09a8\\u09bf\\u0987 \\u09aa\\u09cd\\u09b0\\u09a5\\u09ae \\u0998\\u09cb\\u09dc\\u09be\\u0995\\u09c7 \\u09aa\\u09cb\\u09b7 \\u09ae\\u09be\\u09a8\\u09bf\\u09df\\u09c7\\u099b\\u09bf\\u09b2\\u09c7\\u09a8 \\u09ac\\u09b2\\u09c7 \\u09a4\\u09be\\u0995\\u09c7 \\u0998\\u09cb\\u09dc\\u09be\\u09b0 \\u09a6\\u09c7\\u09ac\\u09a4\\u09be \\u09ac\\u09b2\\u09c7\\u0993 \\u09a1\\u09be\\u0995\\u09be \\u09b9\\u09df\\u0964<\\/span><br><\\/p>\\r\\n\\r\\n<p><br><\\/p>\\r\\n\\r\\n<p style=\\"font-size:18px;color:rgb(0,0,0);font-family:Inter, sans-serif;text-align:justify;\\">\\u098f\\u099b\\u09be\\u09dc\\u09be\\u0993 \\u0997\\u09cd\\u09b0\\u09bf\\u0995 \\u09aa\\u09c1\\u09b0\\u09be\\u09a3\\u09c7 \\u09a4\\u09bf\\u09a8\\u09bf \\u09ac\\u09a8\\u09cd\\u09af\\u09be, \\u0996\\u09b0\\u09be, \\u0993 \\u09ad\\u09c2\\u09ae\\u09bf\\u0995\\u09ae\\u09cd\\u09aa\\u09c7\\u09b0 \\u09a6\\u09c7\\u09ac\\u09a4\\u09be \\u09b9\\u09bf\\u09b8\\u09c7\\u09ac\\u09c7\\u0993 \\u09b8\\u09c1\\u09aa\\u09b0\\u09bf\\u099a\\u09bf\\u09a4\\u0964 \\u099a\\u09cb\\u0996\\u09a7\\u09be\\u0981\\u09a7\\u09be\\u09a8\\u09cb \\u09b8\\u09c1\\u09ac\\u09bf\\u09b6\\u09be\\u09b2 \\u098f\\u0995 \\u09b0\\u09be\\u099c\\u09aa\\u09cd\\u09b0\\u09be\\u09b8\\u09be\\u09a6\\u09c7 \\u09a4\\u09be\\u09b0 \\u09b0\\u09be\\u099c\\u0995\\u09c0\\u09df \\u09ac\\u09b8\\u09ac\\u09be\\u09b8, \\u09af\\u09be \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0\\u09c7\\u09b0 \\u09a8\\u09bf\\u099a\\u09c7 \\u0985\\u09ac\\u09b8\\u09cd\\u09a5\\u09bf\\u09a4\\u0964 \\u09aa\\u09cd\\u09b0\\u09be\\u09b8\\u09be\\u09a6\\u09c7\\u09b0 \\u09ac\\u09c3\\u09b9\\u09ce \\u098f\\u0995 \\u0986\\u09b8\\u09cd\\u09a4\\u09be\\u09ac\\u09b2\\u09c7 \\u09a4\\u09be\\u09b0 \\u09b8\\u09be\\u09a6\\u09be \\u09b0\\u0999\\u09c7\\u09b0 \\u0998\\u09cb\\u09dc\\u09be\\u0997\\u09c1\\u09b2\\u09cb \\u09a4\\u09be\\u09ae\\u09be\\u099f\\u09c7 \\u0996\\u09c1\\u09b0 \\u09a8\\u09bf\\u09df\\u09c7 \\u09a0\\u09be\\u0981\\u0987 \\u09a6\\u09be\\u0981\\u09dc\\u09bf\\u09df\\u09c7 \\u09a5\\u09be\\u0995\\u09c7\\u0964 \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0 \\u09a8\\u09bf\\u099c\\u09c7\\u09b0 \\u0995\\u09cd\\u09b0\\u09cb\\u09a7 \\u09aa\\u09cd\\u09b0\\u0995\\u09be\\u09b6\\u09c7\\u09b0 \\u09ae\\u09be\\u09a7\\u09cd\\u09af\\u09ae\\u09c7 \\u0985\\u09b6\\u09be\\u09a8\\u09cd\\u09a4 \\u09b0\\u09c2\\u09aa \\u09a7\\u09be\\u09b0\\u09a3 \\u0995\\u09b0\\u09b2\\u09c7 \\u0998\\u09cb\\u09dc\\u09be\\u0997\\u09c1\\u09b2\\u09cb \\u09a8\\u09bf\\u09df\\u09c7 \\u098f\\u0995 \\u09b8\\u09cb\\u09a8\\u09be\\u09b2\\u09bf \\u09b0\\u09a5 \\u09aa\\u09cd\\u09b0\\u09b8\\u09cd\\u09a4\\u09c1\\u09a4 \\u0995\\u09b0\\u09c7\\u09a8 \\u09a4\\u09bf\\u09a8\\u09bf\\u0964 \\u09ae\\u09be\\u099b\\u09c7\\u09b0 \\u09ae\\u09a4\\u09cb \\u09b2\\u09c7\\u099c\\u09ac\\u09bf\\u09b6\\u09bf\\u09b7\\u09cd\\u099f \\u098f\\u0995\\u099c\\u09cb\\u09dc\\u09be \\u0998\\u09cb\\u09dc\\u09be \\u09a4\\u09be\\u09b0 \\u09b0\\u09a5 \\u099f\\u09be\\u09a8\\u09be\\u09b0 \\u09a6\\u09be\\u09df\\u09bf\\u09a4\\u09cd\\u09ac \\u09aa\\u09be\\u09b2\\u09a8 \\u0995\\u09b0\\u09c7\\u0964 \\u09b9\\u09be\\u0993\\u09df\\u09be\\u09b0 \\u09ac\\u09c7\\u0997\\u09c7 \\u099b\\u09c1\\u099f\\u09c7 \\u099a\\u09b2\\u09be \\u0998\\u09cb\\u09dc\\u09be\\u0997\\u09c1\\u09b2\\u09cb \\u09a6\\u09bf\\u09df\\u09c7 \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0\\u0995\\u09c7 \\u09b6\\u09be\\u09a8\\u09cd\\u09a4 \\u0995\\u09b0\\u09be\\u09b0 \\u099a\\u09c7\\u09b7\\u09cd\\u099f\\u09be \\u0995\\u09b0\\u09c7\\u09a8 \\u09a4\\u09bf\\u09a8\\u09bf\\u0964 \\u09ab\\u09c1\\u09b2\\u09c7-\\u09ab\\u09c7\\u0981\\u09aa\\u09c7 \\u0993\\u09a0\\u09be \\u09ac\\u09bf\\u09b6\\u09be\\u09b2 \\u099c\\u09b2\\u09b0\\u09be\\u09b6\\u09bf \\u09b6\\u09be\\u09a8\\u09cd\\u09a4 \\u09b9\\u09df\\u09c7 \\u0997\\u09c7\\u09b2\\u09c7\\u0987 \\u099c\\u09b2\\u099c \\u09aa\\u09cd\\u09b0\\u09be\\u09a3\\u09c0\\u09b0\\u09be \\u09b0\\u09a5\\u09c7\\u09b0 \\u09aa\\u09c7\\u099b\\u09a8\\u09c7 \\u0996\\u09c1\\u09b6\\u09bf\\u09a4\\u09c7 \\u09a1\\u0997\\u09ae\\u0997 \\u09b9\\u09df\\u09c7 \\u09a8\\u09c7\\u099a\\u09c7-\\u0997\\u09c7\\u09df\\u09c7 \\u0986\\u09a8\\u09a8\\u09cd\\u09a6 \\u09aa\\u09cd\\u09b0\\u0995\\u09be\\u09b6 \\u0995\\u09b0\\u09c7\\u0964<\\/p>\\r\\n\\r\\n<p><br><\\/p>\\r\\n\\r\\n<p style=\\"font-size:18px;color:rgb(0,0,0);font-family:Inter, sans-serif;text-align:justify;\\">\\u09aa\\u09cd\\u09b0\\u09be\\u099a\\u09c0\\u09a8 \\u0997\\u09cd\\u09b0\\u09bf\\u09b8\\u09c7\\u09b0 \\u09a8\\u09be\\u09ac\\u09bf\\u0995 \\u09ac\\u09be \\u099c\\u09c7\\u09b2\\u09c7\\u09b0\\u09be \\u0989\\u09a4\\u09cd\\u09a4\\u09be\\u09b2 \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0\\u09c7 \\u09aa\\u09cd\\u09b0\\u099a\\u09a3\\u09cd\\u09a1 \\u099d\\u09dc \\u09ac\\u09be \\u09a2\\u09c7\\u0989\\u09df\\u09c7\\u09b0 \\u0995\\u09ac\\u09b2\\u09c7 \\u09aa\\u09dc\\u09b2\\u09c7 \\u0995\\u09b0\\u099c\\u09cb\\u09dc\\u09c7 \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0-\\u09a6\\u09c7\\u09ac\\u09a4\\u09be \\u09aa\\u09b8\\u09be\\u0987\\u09a1\\u09a8\\u09c7\\u09b0 \\u09a8\\u09bf\\u0995\\u099f \\u09b8\\u09be\\u09b9\\u09be\\u09af\\u09cd\\u09af \\u09aa\\u09cd\\u09b0\\u09be\\u09b0\\u09cd\\u09a5\\u09a8\\u09be \\u0995\\u09b0\\u09a4\\u0964 \\u0995\\u09be\\u09b0\\u09a3, \\u0997\\u09cd\\u09b0\\u09bf\\u0995 \\u0989\\u09aa\\u0995\\u09a5\\u09be\\u09b0 \\u09ac\\u09bf\\u09b6\\u09be\\u09b2 \\u099c\\u09be\\u09df\\u0997\\u09be\\u099c\\u09c1\\u09dc\\u09c7 \\u09a8\\u09bf\\u099c\\u09c7\\u0995\\u09c7 \\u09ac\\u09bf\\u09b8\\u09cd\\u09a4\\u09c0\\u09b0\\u09cd\\u09a3 \\u099c\\u09b2\\u09b0\\u09be\\u09b6\\u09bf\\u09b0 \\u09ae\\u09a4\\u09cb \\u099b\\u09dc\\u09bf\\u09df\\u09c7 \\u09b0\\u09c7\\u0996\\u09c7\\u099b\\u09c7\\u09a8 \\u09aa\\u09b8\\u09be\\u0987\\u09a1\\u09a8\\u0964 \\u09aa\\u09a6 \\u0993 \\u09ac\\u09bf\\u09b6\\u09bf\\u09b7\\u09cd\\u099f\\u09a4\\u09be \\u0985\\u09a8\\u09c1\\u09b8\\u09be\\u09b0\\u09c7, \\u09a6\\u09c7\\u09ac\\u09b0\\u09be\\u099c \\u099c\\u09bf\\u0989\\u09b8\\u09c7\\u09b0 \\u09aa\\u09b0\\u0987 \\u09a4\\u09be\\u09b0 \\u0985\\u09ac\\u09b8\\u09cd\\u09a5\\u09be\\u09a8\\u0964 \\u099c\\u09bf\\u0989\\u09b8 \\u09af\\u09c7\\u09ad\\u09be\\u09ac\\u09c7 \\u09b8\\u09cd\\u09ac\\u09b0\\u09cd\\u0997\\u09c7\\u09b0 \\u09af\\u09be\\u09ac\\u09a4\\u09c0\\u09df \\u099c\\u09bf\\u09a8\\u09bf\\u09b8 \\u09b8\\u09be\\u09ae\\u09b2\\u09be\\u09a8, \\u09b9\\u09c7\\u09a1\\u09bf\\u09b8 \\u09af\\u09c7\\u09ad\\u09be\\u09ac\\u09c7 \\u09aa\\u09be\\u09a4\\u09be\\u09b2\\u09aa\\u09c1\\u09b0\\u09c0\\u09b0 \\u0998\\u09c1\\u099f\\u0998\\u09c1\\u099f\\u09c7 \\u0985\\u09a8\\u09cd\\u09a7\\u0995\\u09be\\u09b0\\u09c7 \\u0997\\u09c1\\u09b0\\u09c1\\u09a6\\u09be\\u09df\\u09bf\\u09a4\\u09cd\\u09ac \\u09aa\\u09be\\u09b2\\u09a8 \\u0995\\u09b0\\u09c7 \\u0986\\u09b8\\u099b\\u09c7\\u09a8, \\u09a4\\u09c7\\u09ae\\u09a8\\u09bf \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0\\u09c7\\u09b0 \\u098f\\u0995\\u099a\\u09cd\\u099b\\u09a4\\u09cd\\u09b0 \\u0985\\u09a7\\u09bf\\u09aa\\u09a4\\u09bf \\u09b9\\u09bf\\u09b8\\u09c7\\u09ac\\u09c7 \\u0985\\u09a5\\u09c8 \\u099c\\u09b2\\u09c7\\u09b0 \\u09a2\\u09c7\\u0989 \\u09ad\\u09c7\\u0999\\u09c7 \\u09a8\\u09bf\\u099c\\u09c7\\u09b0 \\u09b0\\u09be\\u099c\\u09a4\\u09cd\\u09ac \\u0995\\u09be\\u09df\\u09c7\\u09ae \\u09b0\\u09be\\u0996\\u09c7\\u09a8 \\u09aa\\u09b8\\u09be\\u0987\\u09a1\\u09a8\\u0964 \\u09a6\\u09c7\\u09ac\\u09a4\\u09be\\u09a6\\u09c7\\u09b0 \\u09ae\\u09a7\\u09cd\\u09af \\u09a4\\u09bf\\u09a8\\u09bf\\u0987 \\u09aa\\u09cd\\u09b0\\u09a5\\u09ae \\u0998\\u09cb\\u09dc\\u09be\\u0995\\u09c7 \\u09aa\\u09cb\\u09b7 \\u09ae\\u09be\\u09a8\\u09bf\\u09df\\u09c7\\u099b\\u09bf\\u09b2\\u09c7\\u09a8 \\u09ac\\u09b2\\u09c7 \\u09a4\\u09be\\u0995\\u09c7 \\u0998\\u09cb\\u09dc\\u09be\\u09b0 \\u09a6\\u09c7\\u09ac\\u09a4\\u09be \\u09ac\\u09b2\\u09c7\\u0993 \\u09a1\\u09be\\u0995\\u09be \\u09b9\\u09df\\u0964<\\/p>\\r\\n\\r\\n<p style=\\"font-size:18px;color:rgb(0,0,0);font-family:Inter, sans-serif;text-align:justify;\\"><br><\\/p>\\r\\n\\r\\n<p style=\\"font-size:18px;color:rgb(0,0,0);font-family:Inter, sans-serif;text-align:justify;\\">\\u098f\\u099b\\u09be\\u09dc\\u09be\\u0993 \\u0997\\u09cd\\u09b0\\u09bf\\u0995 \\u09aa\\u09c1\\u09b0\\u09be\\u09a3\\u09c7 \\u09a4\\u09bf\\u09a8\\u09bf \\u09ac\\u09a8\\u09cd\\u09af\\u09be, \\u0996\\u09b0\\u09be, \\u0993 \\u09ad\\u09c2\\u09ae\\u09bf\\u0995\\u09ae\\u09cd\\u09aa\\u09c7\\u09b0 \\u09a6\\u09c7\\u09ac\\u09a4\\u09be \\u09b9\\u09bf\\u09b8\\u09c7\\u09ac\\u09c7\\u0993 \\u09b8\\u09c1\\u09aa\\u09b0\\u09bf\\u099a\\u09bf\\u09a4\\u0964 \\u099a\\u09cb\\u0996\\u09a7\\u09be\\u0981\\u09a7\\u09be\\u09a8\\u09cb \\u09b8\\u09c1\\u09ac\\u09bf\\u09b6\\u09be\\u09b2 \\u098f\\u0995 \\u09b0\\u09be\\u099c\\u09aa\\u09cd\\u09b0\\u09be\\u09b8\\u09be\\u09a6\\u09c7 \\u09a4\\u09be\\u09b0 \\u09b0\\u09be\\u099c\\u0995\\u09c0\\u09df \\u09ac\\u09b8\\u09ac\\u09be\\u09b8, \\u09af\\u09be \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0\\u09c7\\u09b0 \\u09a8\\u09bf\\u099a\\u09c7 \\u0985\\u09ac\\u09b8\\u09cd\\u09a5\\u09bf\\u09a4\\u0964 \\u09aa\\u09cd\\u09b0\\u09be\\u09b8\\u09be\\u09a6\\u09c7\\u09b0 \\u09ac\\u09c3\\u09b9\\u09ce \\u098f\\u0995 \\u0986\\u09b8\\u09cd\\u09a4\\u09be\\u09ac\\u09b2\\u09c7 \\u09a4\\u09be\\u09b0 \\u09b8\\u09be\\u09a6\\u09be \\u09b0\\u0999\\u09c7\\u09b0 \\u0998\\u09cb\\u09dc\\u09be\\u0997\\u09c1\\u09b2\\u09cb \\u09a4\\u09be\\u09ae\\u09be\\u099f\\u09c7 \\u0996\\u09c1\\u09b0 \\u09a8\\u09bf\\u09df\\u09c7 \\u09a0\\u09be\\u0981\\u0987 \\u09a6\\u09be\\u0981\\u09dc\\u09bf\\u09df\\u09c7 \\u09a5\\u09be\\u0995\\u09c7\\u0964 \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0 \\u09a8\\u09bf\\u099c\\u09c7\\u09b0 \\u0995\\u09cd\\u09b0\\u09cb\\u09a7 \\u09aa\\u09cd\\u09b0\\u0995\\u09be\\u09b6\\u09c7\\u09b0 \\u09ae\\u09be\\u09a7\\u09cd\\u09af\\u09ae\\u09c7 \\u0985\\u09b6\\u09be\\u09a8\\u09cd\\u09a4 \\u09b0\\u09c2\\u09aa \\u09a7\\u09be\\u09b0\\u09a3 \\u0995\\u09b0\\u09b2\\u09c7 \\u0998\\u09cb\\u09dc\\u09be\\u0997\\u09c1\\u09b2\\u09cb \\u09a8\\u09bf\\u09df\\u09c7 \\u098f\\u0995 \\u09b8\\u09cb\\u09a8\\u09be\\u09b2\\u09bf \\u09b0\\u09a5 \\u09aa\\u09cd\\u09b0\\u09b8\\u09cd\\u09a4\\u09c1\\u09a4 \\u0995\\u09b0\\u09c7\\u09a8 \\u09a4\\u09bf\\u09a8\\u09bf\\u0964 \\u09ae\\u09be\\u099b\\u09c7\\u09b0 \\u09ae\\u09a4\\u09cb \\u09b2\\u09c7\\u099c\\u09ac\\u09bf\\u09b6\\u09bf\\u09b7\\u09cd\\u099f \\u098f\\u0995\\u099c\\u09cb\\u09dc\\u09be \\u0998\\u09cb\\u09dc\\u09be \\u09a4\\u09be\\u09b0 \\u09b0\\u09a5 \\u099f\\u09be\\u09a8\\u09be\\u09b0 \\u09a6\\u09be\\u09df\\u09bf\\u09a4\\u09cd\\u09ac \\u09aa\\u09be\\u09b2\\u09a8 \\u0995\\u09b0\\u09c7\\u0964 \\u09b9\\u09be\\u0993\\u09df\\u09be\\u09b0 \\u09ac\\u09c7\\u0997\\u09c7 \\u099b\\u09c1\\u099f\\u09c7 \\u099a\\u09b2\\u09be \\u0998\\u09cb\\u09dc\\u09be\\u0997\\u09c1\\u09b2\\u09cb \\u09a6\\u09bf\\u09df\\u09c7 \\u09b8\\u09ae\\u09c1\\u09a6\\u09cd\\u09b0\\u0995\\u09c7 \\u09b6\\u09be\\u09a8\\u09cd\\u09a4 \\u0995\\u09b0\\u09be\\u09b0 \\u099a\\u09c7\\u09b7\\u09cd\\u099f\\u09be \\u0995\\u09b0\\u09c7\\u09a8 \\u09a4\\u09bf\\u09a8\\u09bf\\u0964 \\u09ab\\u09c1\\u09b2\\u09c7-\\u09ab\\u09c7\\u0981\\u09aa\\u09c7 \\u0993\\u09a0\\u09be \\u09ac\\u09bf\\u09b6\\u09be\\u09b2 \\u099c\\u09b2\\u09b0\\u09be\\u09b6\\u09bf \\u09b6\\u09be\\u09a8\\u09cd\\u09a4 \\u09b9\\u09df\\u09c7 \\u0997\\u09c7\\u09b2\\u09c7\\u0987 \\u099c\\u09b2\\u099c \\u09aa\\u09cd\\u09b0\\u09be\\u09a3\\u09c0\\u09b0\\u09be \\u09b0\\u09a5\\u09c7\\u09b0 \\u09aa\\u09c7\\u099b\\u09a8\\u09c7 \\u0996\\u09c1\\u09b6\\u09bf\\u09a4\\u09c7 \\u09a1\\u0997\\u09ae\\u0997 \\u09b9\\u09df\\u09c7 \\u09a8\\u09c7\\u099a\\u09c7-\\u0997\\u09c7\\u09df\\u09c7 \\u0986\\u09a8\\u09a8\\u09cd\\u09a6 \\u09aa\\u09cd\\u09b0\\u0995\\u09be\\u09b6 \\u0995\\u09b0\\u09c7\\u0964<\\/p>"}]', 1, NULL, '2023-09-13 02:07:36'),
	(13, 'Contact Us', 'contact', '{"title":"Contact Us","heading":"Get In Touch","sub_heading":"We are here to help! Reach out to Alaba Pay for support, inquiries, or feedback. Our team is available 24/7 to assist you.","phone":"+1 (631) 593-5927","email":"abc@gmail.com","address":"4-6-8 Calmette, District 1, Ho Chi Minh City"}', NULL, 1, NULL, '2022-02-14 05:08:24');

-- Dumping structure for table alaba_test.sms_gateways
CREATE TABLE IF NOT EXISTS `sms_gateways` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.sms_gateways: ~2 rows (approximately)
INSERT INTO `sms_gateways` (`id`, `name`, `config`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Twilio', '{\r\n"sid":"","token":"","from_number":""\r\n}', 0, NULL, '2022-01-19 23:56:26'),
	(2, 'Nexmo', '{"api_key":"f0842415","api_secret":"5FqSGPgFIKbf8nDr"}', 1, NULL, '2022-01-20 02:22:11');

-- Dumping structure for table alaba_test.support_tickets
CREATE TABLE IF NOT EXISTS `support_tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_type` tinyint(1) NOT NULL,
  `guest_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guest_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket_num` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = pending, 1 = replied. ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.support_tickets: ~0 rows (approximately)

-- Dumping structure for table alaba_test.ticket_messages
CREATE TABLE IF NOT EXISTS `ticket_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int NOT NULL,
  `ticket_num` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `user_type` tinyint(1) DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.ticket_messages: ~0 rows (approximately)

-- Dumping structure for table alaba_test.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trnx` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `user_type` tinyint NOT NULL,
  `currency_id` int NOT NULL,
  `wallet_id` int DEFAULT NULL,
  `charge` decimal(20,10) NOT NULL DEFAULT '0.0000000000',
  `amount` decimal(20,10) NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_num` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.transactions: ~2 rows (approximately)
INSERT INTO `transactions` (`id`, `trnx`, `user_id`, `user_type`, `currency_id`, `wallet_id`, `charge`, `amount`, `remark`, `type`, `details`, `invoice_num`, `created_at`, `updated_at`) VALUES
	(1, '88ITTDXYB2VA', 2, 1, 1, NULL, 2.4000000000, 20.0000000000, 'create_voucher', '-', 'Voucher created', NULL, '2024-06-18 21:03:19', '2024-06-18 21:03:19'),
	(2, '88ITTDXYB2VA', 2, 1, 1, NULL, 0.0000000000, 2.0000000000, 'voucher_commission', '+', 'Voucher commission', NULL, '2024-06-18 21:03:19', '2024-06-18 21:03:19');

-- Dumping structure for table alaba_test.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `zip` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `email_verified` tinyint(1) DEFAULT '0',
  `verification_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verify_code` int DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kyc_status` tinyint(1) DEFAULT '0',
  `kyc_info` text COLLATE utf8mb4_unicode_ci,
  `kyc_reject_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_fa_status` tinyint(1) NOT NULL DEFAULT '0',
  `two_fa` tinyint(1) NOT NULL DEFAULT '0',
  `two_fa_code` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.users: ~0 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `photo`, `phone`, `country`, `city`, `address`, `zip`, `status`, `email_verified`, `verification_link`, `verify_code`, `password`, `remember_token`, `kyc_status`, `kyc_info`, `kyc_reject_reason`, `two_fa_status`, `two_fa`, `two_fa_code`, `created_at`, `updated_at`) VALUES
	(2, 'John Doe', 'user@gmail.com', '18335353941697632725.jpg', '+8801456369852', 'Bangladesh', 'dhaka', 'Uttara', '1230', 1, 1, NULL, 316447, '$2y$10$4NGIC.vnYXYjiK2amxPyFOG6g9pairnmZOmlhzxPAH8VXPQ0SqEr6', NULL, 1, '{"nid":"22222222","details":{"description_of_address":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}}', 'test', 0, 0, 625268, '2023-09-25 23:53:55', '2023-10-30 10:13:08'),
	(13, 'pigaming', 'pigaming@gmail.com', NULL, '+84338386701', 'Vietnam', NULL, '8 Calmette', NULL, 1, 1, NULL, NULL, '$2y$10$fx2psNnORPAJv2jPJryVBecYAx76h7vGiAhzqA4r0.vmKdE/mUlha', NULL, 1, NULL, NULL, 0, 0, NULL, '2024-06-18 20:54:22', '2024-06-18 20:54:22');

-- Dumping structure for table alaba_test.vouchers
CREATE TABLE IF NOT EXISTS `vouchers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` int NOT NULL,
  `user_id` int NOT NULL,
  `amount` decimal(20,10) NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0 => unused, 1 => used',
  `reedemed_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.vouchers: ~0 rows (approximately)
INSERT INTO `vouchers` (`id`, `currency_id`, `user_id`, `amount`, `code`, `status`, `reedemed_by`, `created_at`, `updated_at`) VALUES
	(24, 1, 2, 20.0000000000, '2546732741-7738983617', 0, NULL, '2024-06-18 21:03:19', '2024-06-18 21:03:19');

-- Dumping structure for table alaba_test.wallets
CREATE TABLE IF NOT EXISTS `wallets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `user_type` tinyint(1) NOT NULL COMMENT '1 => user, 2 => ''merchant'', 3  => ''agent''',
  `currency_id` int NOT NULL,
  `balance` decimal(20,10) NOT NULL DEFAULT '0.0000000000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.wallets: ~6 rows (approximately)
INSERT INTO `wallets` (`id`, `user_id`, `user_type`, `currency_id`, `balance`, `created_at`, `updated_at`) VALUES
	(7, 2, 1, 6, 3859.4747000000, '2023-09-25 23:53:56', '2023-10-19 18:34:10'),
	(8, 2, 1, 1, 4661.0716378953, '2023-09-26 01:55:57', '2024-06-18 21:03:19'),
	(9, 2, 1, 10, 910.0000000000, '2023-10-01 13:28:07', '2023-10-28 21:36:15'),
	(13, 2, 1, 13, 100.0000000000, '2023-10-02 13:47:26', '2023-10-02 13:47:26'),
	(58, 2, 2, 15, 0.0000000000, '2024-06-18 20:53:19', '2024-06-18 20:53:19'),
	(59, 13, 1, 15, 0.0000000000, '2024-06-18 20:54:24', '2024-06-18 20:54:24');

-- Dumping structure for table alaba_test.withdrawals
CREATE TABLE IF NOT EXISTS `withdrawals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trx` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `merchant_id` int DEFAULT NULL,
  `agent_id` int DEFAULT NULL,
  `method_id` int NOT NULL,
  `currency_id` int NOT NULL,
  `amount` decimal(20,10) NOT NULL,
  `charge` decimal(20,10) NOT NULL,
  `total_amount` decimal(20,10) NOT NULL,
  `user_data` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0 => pending, 1 => accepted, 2 => rejected\r\n',
  `reject_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.withdrawals: ~0 rows (approximately)

-- Dumping structure for table alaba_test.withdraws
CREATE TABLE IF NOT EXISTS `withdraws` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `withdraw_instruction` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_amount` decimal(20,10) NOT NULL,
  `max_amount` decimal(20,10) NOT NULL,
  `fixed_charge` decimal(20,10) NOT NULL,
  `percent_charge` decimal(5,2) NOT NULL,
  `user_data` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alaba_test.withdraws: ~0 rows (approximately)
INSERT INTO `withdraws` (`id`, `currency_id`, `name`, `withdraw_instruction`, `min_amount`, `max_amount`, `fixed_charge`, `percent_charge`, `user_data`, `status`, `created_at`, `updated_at`) VALUES
	(5, 1, 'Demo -USD', '<p>Withdraw</p>', 30.0000000000, 1000.0000000000, 2.0000000000, 1.00, NULL, 1, '2022-03-07 02:21:57', '2023-09-13 05:48:31');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
