-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `ChallengesOnContests`;
DROP TABLE IF EXISTS `RefreshToken`;
DROP TABLE IF EXISTS `Submission`;
DROP TABLE IF EXISTS `UsersOnContests`;
DROP TABLE IF EXISTS `Contest`;
DROP TABLE IF EXISTS `SubmittedFile`;
DROP TABLE IF EXISTS `User`;
DROP TABLE IF EXISTS `Challenge`;

CREATE TABLE `Challenge` (
	`id` VARCHAR(191) NOT NULL,
	`title` VARCHAR(191) NOT NULL,
	`description` VARCHAR(1000) NOT NULL,
	`constraints` VARCHAR(500) NOT NULL,
	`createdTime` DATETIME NOT NULL,
	`templateFile` BlOB NOT NULL,
	`difficulty` VARCHAR(191) NOT NULL,
	`testCasesFile` BlOB NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `User` (
	`id` VARCHAR(191) NOT NULL,
	`username` VARCHAR(191) NOT NULL,
	`fullname` VARCHAR(191) NOT NULL,
	`role` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `SubmittedFile` (
	`id` VARCHAR(191) NOT NULL,
	`fileName` VARCHAR(191) NOT NULL,
	`fileExtension` VARCHAR(191) NOT NULL,
	`file` BLOB NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `Contest` (
	`id` VARCHAR(191) NOT NULL,
	`title` VARCHAR(191) NOT NULL,
	`description` VARCHAR(1000) NOT NULL,
	`startTime` DATETIME NOT NULL,
	`endTime` DATETIME NOT NULL,
	`imageUrl` VARCHAR(191) NOT NULL,
	`moderatorId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_CONTEST_USER FOREIGN KEY(`moderatorId`) REFERENCES `User`(`id`),
	PRIMARY KEY(`id`)
);

CREATE TABLE `UsersOnContests` (
	`id` VARCHAR(191) NOT NULL,
	`registeredTime` DATETIME NOT NULL,
	`userId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_USERSONCONTESTS_USER FOREIGN KEY(`userId`) REFERENCES `User`(`id`),
	`contestId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_USERSONCONTESTS_CONTEST FOREIGN KEY(`contestId`) REFERENCES `Contest`(`id`),
	PRIMARY KEY(`id`)
);

CREATE TABLE `Submission` (
	`id` VARCHAR(191) NOT NULL,
	`submittedTime` DATETIME NOT NULL,
	`score` DOUBLE NOT NULL,
	`userId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_SUBMISSION_USER FOREIGN KEY(`userId`) REFERENCES `User`(`id`),
	`challengeId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_SUBMISSION_CHALLENGE FOREIGN KEY(`challengeId`) REFERENCES `Challenge`(`id`),
	`contestId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_SUBMISSION_CONTEST FOREIGN KEY(`contestId`) REFERENCES `Contest`(`id`),
	`submittedfileId` VARCHAR(191) UNIQUE NOT NULL,
	CONSTRAINT FK_SUBMISSION_SUBMITTEDFILE FOREIGN KEY(`submittedfileId`) REFERENCES `SubmittedFile`(`id`),
	PRIMARY KEY(`id`)
);

CREATE TABLE `RefreshToken` (
	`id` VARCHAR(191) NOT NULL,
	`token` VARCHAR(1000) NOT NULL,
	`userId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_REFRESHTOKEN_USER FOREIGN KEY(`userId`) REFERENCES `User`(`id`),
	PRIMARY KEY(`id`)
);

CREATE TABLE `ChallengesOnContests` (
	`id` VARCHAR(191) NOT NULL,
	`assignedTime` DATETIME NOT NULL,
	`challengeId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_CHALLENGESONCONTESTS_CHALLENGE FOREIGN KEY(`challengeId`) REFERENCES `Challenge`(`id`),
	`contestId` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_CHALLENGESONCONTESTS_CONTEST FOREIGN KEY(`contestId`) REFERENCES `Contest`(`id`),
	PRIMARY KEY(`id`)
);
