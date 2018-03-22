BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `user` (
	`name`	TEXT NOT NULL UNIQUE,
	`email`	TEXT NOT NULL UNIQUE,
	`type`	TEXT NOT NULL DEFAULT 'user',
	`hash`	TEXT NOT NULL,
	`id`	INTEGER NOT NULL UNIQUE,
	`salt`	TEXT NOT NULL,
	PRIMARY KEY(`email`,`type`,`id`,`name`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `song_band` (
	`song_id`	INTEGER NOT NULL,
	`band_id`	INTEGER NOT NULL,
	FOREIGN KEY(`song_id`) REFERENCES `song`(`id`),
	PRIMARY KEY(`song_id`,`band_id`)
);
CREATE TABLE IF NOT EXISTS `song_album` (
	`album_id`	INTEGER NOT NULL,
	`song_id`	INTEGER NOT NULL,
	PRIMARY KEY(`album_id`,`song_id`),
	FOREIGN KEY(`song_id`) REFERENCES `song`(`id`),
	FOREIGN KEY(`album_id`) REFERENCES `album`(`id`)
);
CREATE TABLE IF NOT EXISTS `song` (
	`name`	TEXT NOT NULL,
	`songtext`	TEXT,
	`filepath`	TEXT NOT NULL UNIQUE,
	`coverpath`	TEXT UNIQUE,
	`year`	INTEGER,
	`mbid`	INTEGER UNIQUE,
	`length`	INTEGER,
	`id`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `show` (
	`name`	TEXT NOT NULL,
	`year`	INTEGER,
	`rating`	NUMERIC,
	`tmdbid`	INTEGER UNIQUE,
	`id`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `role` (
	`name`	INTEGER NOT NULL UNIQUE,
	`id`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(`name`,`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `person_role_movie` (
	`person_id`	INTEGER NOT NULL,
	`role_id`	INTEGER NOT NULL,
	`movie_id`	INTEGER NOT NULL,
	FOREIGN KEY(`role_id`) REFERENCES `role`(`id`),
	FOREIGN KEY(`person_id`) REFERENCES `person`(`id`),
	FOREIGN KEY(`movie_id`) REFERENCES `movie`(`id`),
	PRIMARY KEY(`person_id`,`role_id`,`movie_id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `person_role_episode` (
	`person_id`	INTEGER NOT NULL,
	`role_id`	INTEGER NOT NULL,
	`episode_id`	INTEGER NOT NULL,
	PRIMARY KEY(`person_id`,`role_id`,`episode_id`),
	FOREIGN KEY(`person_id`) REFERENCES `person`(`id`),
	FOREIGN KEY(`role_id`) REFERENCES `role`(`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `person_role_band` (
	`person_id`	INTEGER NOT NULL,
	`role_id`	INTEGER NOT NULL,
	`band_id`	INTEGER NOT NULL,
	FOREIGN KEY(`band_id`) REFERENCES `band`(`id`),
	PRIMARY KEY(`person_id`,`role_id`,`band_id`),
	FOREIGN KEY(`person_id`) REFERENCES `person`(`id`),
	FOREIGN KEY(`role_id`) REFERENCES `role`(`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `person` (
	`fname`	TEXT NOT NULL,
	`lname`	TEXT NOT NULL,
	`tmdbid`	INTEGER,
	`mbid`	INTEGER,
	`id`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `movie` (
	`title`	TEXT NOT NULL,
	`length`	INTEGER,
	`tmdbid`	INTEGER UNIQUE,
	`rating`	NUMERIC,
	`plot`	TEXT,
	`releasedate`	INTEGER,
	`path`	TEXT NOT NULL UNIQUE,
	`coverpath`	TEXT UNIQUE,
	`id`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(`title`,`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `episode_show` (
	`episode_id`	INTEGER NOT NULL,
	`show_id`	INTEGER NOT NULL,
	`season`	INTEGER NOT NULL,
	FOREIGN KEY(`episode_id`) REFERENCES `episode`(`id`),
	FOREIGN KEY(`show_id`) REFERENCES `show`(`id`),
	PRIMARY KEY(`show_id`,`episode_id`)
);
CREATE TABLE IF NOT EXISTS `episode` (
	`title`	TEXT NOT NULL,
	`length`	INTEGER,
	`rating`	INTEGER,
	`tmdbid`	INTEGER UNIQUE,
	`id`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `band_person` (
	`band_id`	INTEGER NOT NULL,
	`person_id`	INTEGER NOT NULL,
	PRIMARY KEY(`band_id`,`person_id`),
	FOREIGN KEY(`band_id`) REFERENCES `band`(`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `band` (
	`name`	TEXT NOT NULL,
	`mbid`	INTEGER UNIQUE,
	`year`	INTEGER,
	`id`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(`id`)
);
CREATE TABLE IF NOT EXISTS `album_band` (
	`album_id`	INTEGER NOT NULL,
	`band_id`	INTEGER NOT NULL,
	FOREIGN KEY(`album_id`) REFERENCES `album`(`id`),
	PRIMARY KEY(`album_id`,`band_id`),
	FOREIGN KEY(`band_id`) REFERENCES `band`(`id`)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS `album` (
	`title`	TEXT NOT NULL,
	`year`	INTEGER,
	`coverpath`	TEXT UNIQUE,
	`mbid`	INTEGER UNIQUE,
	`id`	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY(`id`)
) WITHOUT ROWID;
COMMIT;
