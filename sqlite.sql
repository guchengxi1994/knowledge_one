/*
 Navicat Premium Data Transfer

 Source Server         : knowledge_sqlite
 Source Server Type    : SQLite
 Source Server Version : 3030001
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3030001
 File Encoding         : 65001

 Date: 19/02/2023 12:35:55
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for redis_stmt
-- ----------------------------
DROP TABLE IF EXISTS "redis_stmt";
CREATE TABLE "redis_stmt" (
  "redis_stmt_id" INTEGER NOT NULL COLLATE BINARY PRIMARY KEY AUTOINCREMENT,
  "content" TEXT
);

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "sqlite_sequence";
CREATE TABLE "sqlite_sequence" (
  "name",
  "seq"
);

PRAGMA foreign_keys = true;
