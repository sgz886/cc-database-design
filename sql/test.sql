USE hardcore_test;

DROP TABLE IF EXISTS vendor;
CREATE TABLE vendor
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `email`       varchar(64)         NOT NULL,
    `password`    varchar(64)         NOT NULL,
    `salt`        varchar(50)         NOT NULL,
    `create_time` datetime            NOT NULL,
    `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY `vendor_id` (`id`),
    UNIQUE KEY `vendor_email` (`email`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS vendor_detail;
CREATE TABLE vendor_detail
(
    `id`             bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `contact_name`   varchar(100)        NOT NULL,
    `company_name`   varchar(200)        NOT NULL,
    `ABN`            bigint(50) unsigned,
    `account_name`   varchar(100),
    `account_number` bigint(50) unsigned,
    `BSB`            varchar(6),
    `card_number`    varchar(50),

    PRIMARY KEY `vendor_detail_id` (`id`),
    FOREIGN KEY (`user_id`) REFERENCES customer (`id`)

);

DROP TABLE IF EXISTS quotation;
CREATE TABLE quotation
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `unit_price`  decimal(18, 2)      NOT NULL DEFAULT '0.00',
    `amount`      int(8)              NOT NULL DEFAULT '1',
    `total_price` decimal(18, 2)      NOT NULL DEFAULT '0.00',
    `create_time` datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `user_id`     bigint(20) unsigned NOT NULL,
    `valid`       boolean             NOT NULL DEFAULT 1 COMMENT '0-> deleted 1-> working',
    `active`      boolean             NOT NULL DEFAULT 0 COMMENT '0-> inactive, 1-> active',
    `vendor_id`   bigint(20) unsigned,

    PRIMARY KEY `quotation_id` (`id`),
    KEY `total_price` (`total_price`),
    FOREIGN KEY (`user_id`) REFERENCES customer (`id`),
    FOREIGN KEY (`vendor_id`) REFERENCES vendor (`id`)
);

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`
(
    `id`             bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `quotation_id`   bigint(20) unsigned NOT NULL,
    `payment_status` boolean             NOT NULL COMMENT '0-> unpaid, 1-> paid',
    `order_progress` tinyint(1)          NOT NULL COMMENT '0->wait for vendor  1->vendor accepted 2->vendor preparing 3-> vendor dispaching 4-> installing 5->wait for acceptance 6-> finish',
    `create_time`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`    datetime                     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `user_id`        bigint(20) unsigned NOT NULL,
    `vendor_id`      bigint(20) unsigned NOT NULL,
    PRIMARY KEY `order_id` (`id`),
    FOREIGN KEY (`quotation_id`) REFERENCES vendor (`id`)
);

DROP TABLE IF EXISTS order_detail;
CREATE TABLE order_detail
(
    `id`                     bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `order_description`      varchar(100)  DEFAULT NULL,
    `order_specification`    varchar(1000) DEFAULT NULL,
    `order_customer_comment` varchar(1000) DEFAULT NULL,
    `order_vendor_note`      varchar(1000) DEFAULT NULL,
    `order_id`               bigint(20) unsigned NOT NULL,
    PRIMARY KEY `od_id` (`id`),
    FOREIGN KEY (`order_id`) REFERENCES vendor (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8;





