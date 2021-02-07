/*
SQLyog Ultimate - MySQL GUI v8.2 
MySQL - 5.5.5-10.4.11-MariaDB : Database - smsm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`smsm` /*!40100 DEFAULT CHARACTER SET cp1256 */;

USE `smsm`;

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_07_20_034721_create_permission_tables',1),(4,'2019_07_20_034826_create_products_table',1),(6,'2021_02_06_103547_alter_users_add_type',2);

/*Table structure for table `model_has_permissions` */

DROP TABLE IF EXISTS `model_has_permissions`;

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  KEY `model_has_permissions_permission_id_foreign` (`permission_id`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `model_has_permissions` */

insert  into `model_has_permissions`(`permission_id`,`model_type`,`model_id`) values (1,'App\\User',2),(2,'App\\User',2),(3,'App\\User',2),(4,'App\\User',2);

/*Table structure for table `model_has_roles` */

DROP TABLE IF EXISTS `model_has_roles`;

CREATE TABLE `model_has_roles` (
  `role_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  KEY `model_has_roles_role_id_foreign` (`role_id`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `model_has_roles` */

insert  into `model_has_roles`(`role_id`,`model_type`,`model_id`) values (1,'App\\User',2),(3,'App\\User',8),(2,'App\\User',5),(5,'App\\User',4),(5,'App\\User',9);

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `permissions` */

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `permissions` */

insert  into `permissions`(`id`,`name`,`guard_name`,`created_at`,`updated_at`) values (1,'role-list','web','2021-02-06 08:24:39','2021-02-06 08:24:39'),(2,'role-create','web','2021-02-06 08:24:39','2021-02-06 08:24:39'),(3,'role-edit','web','2021-02-06 08:24:39','2021-02-06 08:24:39'),(4,'role-delete','web','2021-02-06 08:24:39','2021-02-06 08:24:39'),(13,'user-list','web','2021-02-06 08:24:39','2021-02-06 08:24:39'),(14,'user-create','web','2021-02-06 08:24:39','2021-02-06 08:24:39'),(15,'user-edit','web','2021-02-06 08:24:39','2021-02-06 08:24:39'),(16,'user-delete','web','2021-02-06 08:24:39','2021-02-06 08:24:39');

/*Table structure for table `role_has_permissions` */

DROP TABLE IF EXISTS `role_has_permissions`;

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  KEY `role_has_permissions_permission_id_foreign` (`permission_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `role_has_permissions` */

insert  into `role_has_permissions`(`permission_id`,`role_id`) values (13,2),(14,2),(16,2),(15,2),(13,3),(13,5),(1,1),(2,1),(4,1),(13,1),(14,1),(15,1),(16,1);

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `roles` */

insert  into `roles`(`id`,`name`,`guard_name`,`created_at`,`updated_at`) values (1,'Admin','web','2021-02-06 08:24:18','2021-02-06 08:24:18'),(2,'Sales Representative','web','2021-02-06 09:49:47','2021-02-06 09:49:47'),(3,'Contributor','web','2021-02-06 09:50:10','2021-02-06 09:50:10'),(5,'Customer','web','2021-02-06 13:45:27','2021-02-06 13:45:27');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` enum('Admin','SalesRep','Contributor','Customer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Customer',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`remember_token`,`created_at`,`updated_at`,`type`) values (2,'Abhishek Sharma','admin@gmail.com',NULL,'$2y$10$Kxh4ZcDeIHM4FLfOqBp1CuDhQ7g6WO.BamO874xGy9SKpyN4m.hza',NULL,'2021-02-06 08:24:18','2021-02-06 08:24:18','Admin'),(4,'abc','Abhisheks.midas1@gmail.com',NULL,'$2y$10$i45oEJTIkVfS9KAnLUOIWugf824f2PGhc7qRuM7xnOE.GD8CIHh.G',NULL,'2021-02-06 13:21:06','2021-02-07 06:35:40','Contributor'),(5,'Test Abc','mac.smith@dispostable.com',NULL,'$2y$10$HVC1CwHVryDAduro9DezSeduoLloMRlBH1ARIJ7bLcj.rV3TGUJW.',NULL,'2021-02-06 13:26:06','2021-02-06 13:26:06','SalesRep'),(8,'abc df','gunjanv@midaswebtech.com',NULL,'$2y$10$xXzlZOozcXRRkpjkSj5Wo.DzgDXiAfPjFl1O2FB2N5mbyA1hk6YSy',NULL,'2021-02-06 13:54:38','2021-02-06 13:54:38','Contributor'),(9,'abc df','mac.smith3@dispostable.com',NULL,'$2y$10$NXe9cjT.ux/1z79Tovq3/.F7bGxLP1Q5aDlWIoq4NJNxeaevgc/K6',NULL,'2021-02-07 06:50:35','2021-02-07 06:50:35','Customer');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
