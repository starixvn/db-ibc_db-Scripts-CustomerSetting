/*<info serverAlias="DBCUST-bodb_Credit"></info>*/
/*
	Created by: Helios
	Date: 6/6/2023 9:33:42 AM
	Task: Create new Database Structure in DBCUST [Redmine:#186502]	
	DB:	DBCUST-bodb_Credit
*/
USE [master]
GO

/****** Object:  Database [bodb_Credit]    Script Date: 6/6/2023 9:33:42 AM ******/
CREATE DATABASE [bodb_Credit]CONTAINMENT = NONEON  PRIMARY ( NAME = N'bodb_Credit', FILENAME = N'H:\USER_DB\bodb_Credit\bodb_Credit.mdf' , SIZE = 1GB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ) -- Edit path file by environment deployedLOG ON ( NAME = N'bodb_Credit_log', FILENAME = N'H:\USER_DB\bodb_Credit\bodb_Credit.ldf' , SIZE = 2GB , MAXSIZE = UNLIMITED , FILEGROWTH = 128MB)	   -- Edit path file by environment deployedWITH CATALOG_COLLATION = DATABASE_DEFAULTGO