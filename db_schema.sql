CREATE TABLE `accounts` (
  `id` int PRIMARY KEY,
  `username` varchar(255) UNIQUE,
  `email` varchar(255) UNIQUE,
  `avatar_uri` varchar(255),
  `role` ENUM ('admin', 'user'),
  `modified_at` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `books` (
  `id` int PRIMARY KEY,
  `title` varchar(255),
  `author` varchar(255),
  `description` varchar(10000),
  `modified_at` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `categories` (
  `id` int PRIMARY KEY,
  `name` varchar(255),
  `description` varchar(10000),
  `modified_at` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `book_category` (
  `book_id` int,
  `category_id` int,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `bookmarks` (
  `id` int PRIMARY KEY,
  `book_id` int,
  `account_id` int,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `rates` (
  `id` int PRIMARY KEY,
  `book_id` int,
  `account_id` int,
  `modified_at` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `comments` (
  `id` int PRIMARY KEY,
  `content` varchar(1000),
  `book_id` int,
  `created_by` int,
  `modified_at` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `feedbacks` (
  `id` int PRIMARY KEY,
  `content` varchar(1000),
  `created_by` int,
  `message` varchar(1000),
  `status` ENUM ('processing', 'resolved', 'not_resolved'),
  `modified_at` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE `book_category` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_category` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `bookmarks` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `bookmarks` ADD FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

ALTER TABLE `rates` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `rates` ADD FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`created_by`) REFERENCES `accounts` (`id`);

ALTER TABLE `feedbacks` ADD FOREIGN KEY (`created_by`) REFERENCES `accounts` (`id`);

CREATE INDEX `accounts_index_0` ON `accounts` (`username`);

CREATE INDEX `accounts_index_1` ON `accounts` (`email`);

CREATE INDEX `books_index_2` ON `books` (`author`);

CREATE INDEX `books_index_3` ON `books` (`modified_at`);

CREATE INDEX `categories_index_4` ON `categories` (`name`);

CREATE INDEX `book_category_index_5` ON `book_category` (`book_id`);

CREATE INDEX `book_category_index_6` ON `book_category` (`category_id`);

CREATE UNIQUE INDEX `book_category_index_7` ON `book_category` (`book_id`, `category_id`);

CREATE INDEX `bookmarks_index_8` ON `bookmarks` (`book_id`);

CREATE INDEX `bookmarks_index_9` ON `bookmarks` (`account_id`);

CREATE UNIQUE INDEX `bookmarks_index_10` ON `bookmarks` (`book_id`, `account_id`);

CREATE INDEX `comments_index_11` ON `comments` (`book_id`);

CREATE INDEX `comments_index_12` ON `comments` (`created_by`);
