CREATE DATABASE `test` /*!40100 COLLATE 'utf8_general_ci' */;
USE test;
CREATE TABLE `users` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`login` VARCHAR(50) NOT NULL,
	`firstname` VARCHAR(50) NOT NULL,
	`lastname` VARCHAR(50) NOT NULL,
	`password` VARCHAR(200) NOT NULL,
	`salt` VARCHAR(200) NOT NULL,
	`created_at` DATETIME NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `login` (`login`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `bugs` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created_at` DATETIME NOT NULL,
	`short_description` VARCHAR(50) NOT NULL,
	`full_description` LONGTEXT NOT NULL,
	`user_id` INT(11) UNSIGNED NOT NULL,
	`status` VARCHAR(50) NOT NULL,
	`importance` VARCHAR(50) NOT NULL,
	`criticalness` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_user_id` (`user_id`),
	CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `bug_records` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`bug_id` INT(11) UNSIGNED NOT NULL,
	`action_date` DATETIME NOT NULL,
	`action` VARCHAR(50) NOT NULL,
	`comment` LONGTEXT NOT NULL,
	`user_id` INT(11) NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_bug_id` (`bug_id`),
	CONSTRAINT `FK_bug_id` FOREIGN KEY (`bug_id`) REFERENCES `bugs` (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `action_list` (
	`action` VARCHAR(50) NOT NULL,
	UNIQUE INDEX `action` (`action`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `criticalness_list` (
	`criticalness` VARCHAR(50) NOT NULL,
	UNIQUE INDEX `criticalness` (`criticalness`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `importance_list` (
	`importance` VARCHAR(50) NOT NULL,
	UNIQUE INDEX `importance` (`importance`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `status_list` (
	`status` VARCHAR(50) NOT NULL,
	UNIQUE INDEX `status` (`status`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE USER "test"@localhost IDENTIFIED BY "test";

GRANT ALL PRIVILEGES ON test.* TO 'test'@localhost;

INSERT INTO users(login, firstname, lastname, password, salt, created_at)
VALUES("admin", "bill", "murray", "C4B3A680FA81D5AB3F37590EB0791DF17D77D23456FD6A8C5A29E7A77C67EC69D9AF3A7738DEAB8BB6F4186B8C40E31A8AFE25A0B7859668D5FCFCDC13A428D9", "3C56E3CA41A0A62CAF3C499687EAF74C3409D24CA5EC22C2BC360750DD42B397E89A2F17A7017774CB04B93E0E26562F2C86FE07E62A4E5A954354EE0A651AA5", NOW());

INSERT INTO action_list (action) VALUES("closed");
INSERT INTO action_list (action) VALUES("created");
INSERT INTO action_list (action) VALUES("opened");
INSERT INTO action_list (action) VALUES("solved");

INSERT INTO criticalness_list (criticalness) VALUES("change request");
INSERT INTO criticalness_list (criticalness) VALUES("crash");
INSERT INTO criticalness_list (criticalness) VALUES("critical");
INSERT INTO criticalness_list (criticalness) VALUES("not critical");

INSERT INTO importance_list (importance) VALUES("not at all urgent");
INSERT INTO importance_list (importance) VALUES("not urgent");
INSERT INTO importance_list (importance) VALUES("urgent");
INSERT INTO importance_list (importance) VALUES("very urgent");

INSERT INTO status_list (status) VALUES("closed");
INSERT INTO status_list (status) VALUES("new");
INSERT INTO status_list (status) VALUES("open");
INSERT INTO status_list (status) VALUES("solved");

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 1",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 2",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 3",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 4",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 5",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 6",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 7",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 8",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 9",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 10",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 11",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 12",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 13",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 14",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My bug description 15",
"This bug is very annoying",
1,
"new",
"not urgent",
"change request"
);

INSERT INTO bugs(created_at, short_description, full_description, user_id, status, importance, criticalness)
VALUES(
NOW(),
"My shiny bug",
"Just another record",
1,
"new",
"very urgent",
"crash"
);


