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


-- Dumping database structure for backend-mobile
-- CREATE DATABASE IF NOT EXISTS `backend-mobile` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
-- USE `backend-mobile`;

-- Dumping structure for table backend-mobile.failed_jobs
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

-- Dumping data for table backend-mobile.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table backend-mobile.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table backend-mobile.migrations: ~0 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2025_12_17_070146_create_products_table', 2),
	(6, '2025_12_17_073841_create_orders_table', 3),
	(7, '2025_12_17_083431_add_foto_to_products_table', 4),
	(8, '2025_12_17_092727_add_status_to_users_table', 5);

-- Dumping structure for table backend-mobile.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `total_barang` int NOT NULL,
  `balado` tinyint(1) NOT NULL DEFAULT '0',
  `keju` tinyint(1) NOT NULL DEFAULT '0',
  `pedas` tinyint(1) NOT NULL DEFAULT '0',
  `asin` tinyint(1) NOT NULL DEFAULT '0',
  `barbeque` tinyint(1) NOT NULL DEFAULT '0',
  `total_harga` decimal(12,2) NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menunggu antrian',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `orders_product_id_foreign` (`product_id`),
  CONSTRAINT `orders_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table backend-mobile.orders: ~0 rows (approximately)
INSERT INTO `orders` (`id`, `user_id`, `product_id`, `total_barang`, `balado`, `keju`, `pedas`, `asin`, `barbeque`, `total_harga`, `status`, `created_at`, `updated_at`) VALUES
	(2, 4, 2, 2, 1, 0, 1, 0, 1, 14000.00, 'diproses', '2025-12-17 01:10:05', '2025-12-17 02:12:39'),
	(3, 4, 5, 2, 0, 0, 1, 0, 1, 24000.00, 'menunggu antrian', '2025-12-17 03:57:23', '2025-12-17 03:57:23');

-- Dumping structure for table backend-mobile.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table backend-mobile.password_resets: ~0 rows (approximately)

-- Dumping structure for table backend-mobile.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table backend-mobile.personal_access_tokens: ~0 rows (approximately)
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
	(1, 'App\\Models\\User', 4, 'api-token', '294708525ea36b81d386011f019d032885be238dd64c3cac81ea0cb6e63eb1ca', '["*"]', '2025-12-17 01:10:05', '2025-12-17 01:00:13', '2025-12-17 01:10:05'),
	(2, 'App\\Models\\User', 2, 'api-token', '7afa09a937e3a03cc76822b19c4dc83c7c258d44e0c9d0e1f8da7c789436280d', '["*"]', '2025-12-17 03:44:59', '2025-12-17 01:18:48', '2025-12-17 03:44:59'),
	(3, 'App\\Models\\User', 2, 'api-token', 'f6e1898f30c34a2c3b8e068cd83db3426a7a37b3157a28c67748510bae60f7b3', '["*"]', NULL, '2025-12-17 01:50:40', '2025-12-17 01:50:40'),
	(4, 'App\\Models\\User', 2, 'api-token', '2395673d5dce8bed4989ecd0e6d5edb7f9af525dcc313eaaf1c2a930ef9c2978', '["*"]', NULL, '2025-12-17 02:10:38', '2025-12-17 02:10:38'),
	(5, 'App\\Models\\User', 2, 'api-token', '01e34ec6f8306277016f89261296736c279cd7424db09aaf17744af5aac696a3', '["*"]', '2025-12-17 02:12:39', '2025-12-17 02:12:05', '2025-12-17 02:12:39'),
	(6, 'App\\Models\\User', 2, 'api-token', 'd4984bbe8e35d291d300d891046db13c6744c15f5cdcf4083767d9476537d222', '["*"]', NULL, '2025-12-17 02:55:24', '2025-12-17 02:55:24'),
	(7, 'App\\Models\\User', 2, 'api-token', 'cdd366600dbe4935b2b654f97c0625fdf6dee3889724f365d2c922ef6d2bac30', '["*"]', '2025-12-17 03:25:48', '2025-12-17 03:03:32', '2025-12-17 03:25:48'),
	(8, 'App\\Models\\User', 2, 'api-token', '1e5f4dc9fe6d08b7522a12172d7fac94bc97e8b71ba86b7cd8e3f67aa8c0b3d3', '["*"]', NULL, '2025-12-17 03:07:43', '2025-12-17 03:07:43'),
	(9, 'App\\Models\\User', 2, 'api-token', '26d5d99e74efec57c139c291c2bfbcc3362d0f37e72382d27792b75acef5a4eb', '["*"]', '2025-12-17 03:27:14', '2025-12-17 03:25:58', '2025-12-17 03:27:14'),
	(10, 'App\\Models\\User', 2, 'api-token', 'ac8bbd7f90ad3e36f6fee617e59a625ad362e058d18f95b9d0c1c7a10f141e24', '["*"]', '2025-12-17 03:55:24', '2025-12-17 03:31:51', '2025-12-17 03:55:24'),
	(11, 'App\\Models\\User', 2, 'api-token', 'c9c5517937862e18aeb0010c462a28e887804dbff93046d3bda95f7787406920', '["*"]', '2025-12-17 03:46:51', '2025-12-17 03:45:52', '2025-12-17 03:46:51'),
	(12, 'App\\Models\\User', 2, 'api-token', '08401a97fc51aeb0fe2c8497f3341df7a4214a974fe06bec9d409fe458cdd9fe', '["*"]', '2025-12-17 03:54:25', '2025-12-17 03:51:33', '2025-12-17 03:54:25'),
	(13, 'App\\Models\\User', 4, 'api-token', '77b4ea80b437aa3b8919ea523d579d0649419250483c6c987fbb635a947bfe84', '["*"]', '2025-12-17 04:04:42', '2025-12-17 03:56:39', '2025-12-17 04:04:42'),
	(14, 'App\\Models\\User', 4, 'api-token', '92f911c3719def9c3d561221ba17c80849ae6abe7ac8339a7abc02f8d92265e9', '["*"]', '2025-12-17 04:05:48', '2025-12-17 04:05:29', '2025-12-17 04:05:48'),
	(15, 'App\\Models\\User', 2, 'api-token', 'e08722ba6a15300b54152b0855e848a5028a9c4661e809b5ec949ea5545c2b72', '["*"]', '2025-12-17 04:09:01', '2025-12-17 04:07:56', '2025-12-17 04:09:01'),
	(16, 'App\\Models\\User', 7, 'api-token', 'bbd00b735a6ec0fbebe7487f454bb288e3bd4b2706ac9e5a0a4784f18bce5d9e', '["*"]', NULL, '2025-12-17 04:09:53', '2025-12-17 04:09:53'),
	(17, 'App\\Models\\User', 2, 'api-token', '175e3de5aad0737f6944cf07e8d873f60888053a80052fbf32f0f9c6e228c937', '["*"]', '2025-12-17 05:20:33', '2025-12-17 05:13:56', '2025-12-17 05:20:33'),
	(18, 'App\\Models\\User', 2, 'api-token', '95047875f65fdd204f27d73e94482c1040b636f0c667a85ef220a32bce7412c6', '["*"]', '2025-12-17 05:39:54', '2025-12-17 05:30:55', '2025-12-17 05:39:54'),
	(19, 'App\\Models\\User', 2, 'api-token', '4b7c28f0c26cb7bcc0c6493db1c081295e62d9442608f156891f5b43a545fb95', '["*"]', NULL, '2025-12-17 06:53:51', '2025-12-17 06:53:51'),
	(20, 'App\\Models\\User', 4, 'api-token', '7a9fbb01876c5bcb4cb3c289f1403f70e8b039c0348e6d458efbf801fd49aa85', '["*"]', NULL, '2025-12-17 08:31:41', '2025-12-17 08:31:41'),
	(21, 'App\\Models\\User', 7, 'api-token', '6f28431a98989c2bba020d5eb8bca92d5b216ce5bce267cc5708837b00fd4cab', '["*"]', '2025-12-17 08:47:38', '2025-12-17 08:46:53', '2025-12-17 08:47:38'),
	(22, 'App\\Models\\User', 2, 'api-token', 'ad5fa342868a0e48f05964e279d3afeda75c3f25231d2131258a338d1466f19c', '["*"]', '2025-12-17 08:50:08', '2025-12-17 08:49:20', '2025-12-17 08:50:08'),
	(23, 'App\\Models\\User', 2, 'api-token', 'af4e9cea89fd3d89c703dcb21086bb3023ac61c0ed94ace5ed18b800c2502289', '["*"]', NULL, '2025-12-17 09:04:54', '2025-12-17 09:04:54'),
	(24, 'App\\Models\\User', 2, 'api-token', 'fb799bda23a8cbdd663182ac6436495e6158d806c8a935587cb46ff9488bdb96', '["*"]', NULL, '2025-12-17 09:09:31', '2025-12-17 09:09:31');

-- Dumping structure for table backend-mobile.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_produk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ketersediaan_stok` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `harga` decimal(10,2) NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table backend-mobile.products: ~0 rows (approximately)
INSERT INTO `products` (`id`, `nama_produk`, `ketersediaan_stok`, `description`, `harga`, `foto`, `created_at`, `updated_at`) VALUES
	(2, 'telor gulung jumbo', '12', 'telor gulung versi jumbo', 7000.00, 'products/q86mmz3dImrFHjprVxSOlQJ9VhmykoZVDr5uBIfl.jpg', '2025-12-17 00:15:52', '2025-12-17 01:57:32'),
	(4, 'telor gulung sosis', '12', 'telor gulung pakai sosis', 10000.00, 'products/HcplEhchifeUKCfEjbzjA7erhN2uOuDWhmWo9FaK.png', '2025-12-17 00:17:25', '2025-12-17 01:58:27'),
	(5, 'telor gulung bakso', '8', 'Telur gulung pake biji prabowo', 12000.00, 'products/VSyVaRviIfQvKEGf0DmVTVyhOPuOADUNOesBs1LK.jpg', '2025-12-17 01:41:45', '2025-12-17 03:57:23'),
	(6, 'telor gulung biji wowo', '10', 'Telur gulung pake super spesial', 100000.00, 'products/EAKNvVoMVkmtB8WfTDO0Yusol5IhSppioOdPyzsv.jpg', '2025-12-17 05:36:07', '2025-12-17 05:36:07');

-- Dumping structure for table backend-mobile.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menunggu_approval',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table backend-mobile.users: ~0 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'User Test', 'user@test.com', NULL, '$2y$10$ysUGnbpe2riHEy4Y3OnKLuvHIq2z1VTl1pFZq0kmTCLj0E96yXXVa', 'users', 'menunggu_approval', NULL, '2025-12-17 00:29:45', '2025-12-17 00:29:45'),
	(2, 'admin gulung', 'admin@test.com', NULL, '$2y$10$41F3HDXI59VW46todYqZoei4Uzw8P7mFd8g7RSHasNTOyRjU91V06', 'admin', 'approved', NULL, '2025-12-17 00:48:51', '2025-12-17 00:48:51'),
	(3, 'guling', 'guling@test.com', NULL, '$2y$10$JkJ045bLQz4HXHQVHslLg.d2Ewql66vZhhETs52/6dHCKVg57prJO', 'users', 'approved', NULL, '2025-12-17 00:50:51', '2025-12-17 03:54:03'),
	(4, 'yusron', 'yusron@test.com', NULL, '$2y$10$OWMlZb2jYJHJsbRzaJmU4urqLJAd6vvIq6L2tPqpAPUeBvTqK684m', 'users', 'approved', NULL, '2025-12-17 00:59:48', '2025-12-17 03:27:14'),
	(5, 'nana', 'nanauser@test.com', NULL, '$2y$10$ZUshTx9/RqxVJZc1uyg6kec33PQni5/6WI1BwUv3MVQwhcnLjKl.2', 'users', 'approved', NULL, '2025-12-17 02:43:31', '2025-12-17 05:39:54'),
	(6, 'apa', 'nanaapa@test.com', NULL, '$2y$10$buM2mUH4e/E148yqVgJqRulQ3/QCKezVxQzrZPN6Jm7HfHpP9dK1e', 'users', 'approved', NULL, '2025-12-17 02:53:57', '2025-12-17 03:54:25'),
	(7, 'ijul', 'ijul@test.com', NULL, '$2y$10$3eJgT4rPHTEMXw2VAEZ6oufsLeueD5avfT30ZJJ/xjsnpxJLDIIBy', 'users', 'approved', NULL, '2025-12-17 04:07:42', '2025-12-17 04:09:01');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
