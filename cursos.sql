/*1. Users
    1. Name
    2. Email
    3. Password
    4. Age
2. Courses
    1. Title
    2. Description
    3. Level (Si es para principiantes, medios o avanzados)
    4. Teacher
3. Course Video
    1. Title
    2. Url
4. Categories
    1. Name
5. Roles
    1. Name (student, teacher, admin)
*/

DROP DATABASE IF EXISTS Courses;
CREATE DATABASE Courses;

CREATE TABLE IF NOT EXISTS categories(
    "id" serial PRIMARY KEY,
    "Name" varchar(25) not null
);

CREATE TABLE IF NOT EXISTS roles(
    "id" serial PRIMARY KEY,
    "Name" varchar(20) not null
);

create table if not exists users(
    "id" uuid primary key,
    "Name" varchar(50) not null,
    "Nick" varchar(20) not null unique,
    "Email" varchar(150) not null unique,
    "Password" varchar(50) not null,
    "Age" int8 not null,
    "Role" int8 not null,
    "Avatar" text,
    "Created_at" date default CURRENT_TIMESTAMP,
    "isActive" boolean,
    foreign key("Role") references "roles" ("id")
);

CREATE TABLE IF NOT EXISTS courses(
    "id" uuid PRIMARY KEY,
    "Title" varchar(100) not null,
    "Description" text,
    "Level" int8 not null,
    "Teacher" uuid not null,
    "Created_at" date DEFAULT CURRENT_TIMESTAMP,
    "isActive" boolean,
    FOREIGN KEY("Level") REFERENCES "categories" ("id"),
    FOREIGN KEY("Teacher") REFERENCES "users" ("id")
);

CREATE TABLE IF NOT EXISTS course_videos(
    "id" serial PRIMARY KEY,
    "Title" varchar(200) not null,
    "Url" text not null,
    "Course" uuid not null,
    "Thumbnails" text,
    FOREIGN KEY("Course") REFERENCES "courses" ("id")
);

DROP TABLE IF EXISTS users_courses;
create table users_courses(
    "id" serial primary key,
    "User" uuid not null,
    "Course" uuid not null,
    "Progress" float not null default 0.00,
    "Completed" boolean default false,
    foreign key("User") references "users" ("id"),
    foreign key("Course") references "courses" ("id")
);

/* Add value for default at isActive column */
alter table users alter column "isActive" set default true;
alter table courses alter column "isActive" set default true;

/* Create levels at categories entity */
insert into categories("Name") values('beginner'),('intermediate'),('advanced');

/* Create roles for users entity */
insert into roles("Name") values('student');
insert into roles("Name") values('teacher');
insert into roles("Name") values('admin');
insert into roles("Name") values('attendant');
insert into roles("Name") values('substitute');

/* Create new users and relate them to roles */
insert into users values('4485c922-65e1-11ed-9022-0242ac120002', 'Jose Carlos Delgado', 'jdf87', 'josedelgado1987@gmail.com', 'jcD23.', 35, 3, '', CURRENT_TIMESTAMP, true);
insert into users values('487609a4-65e9-11ed-9022-0242ac120002', 'Manuel Perez Maldonado', 'manuel_perez', 'mano_p67@gmail.com', 'enseres345.', 26, 2, '', CURRENT_TIMESTAMP, true);
insert into users values('0d02b692-65e9-11ed-9022-0242ac120002', 'Alan Alberto Almeida Torres', 'J45alan', 'alant_45@gmail.com', 'at45F_', 17, 1, '', CURRENT_TIMESTAMP, true);
insert into users values('b2fc3b72-65e9-11ed-9022-0242ac120002', 'Mariano Roman Valdez', 'MRV_19', 'romanM-@gmail.com', 'Roman876331t', 19, 1, '', CURRENT_TIMESTAMP, true);

/* Create courses */
insert into courses("id", "Title", "Description", "Level", "Teacher") values('a03ab51c-65ea-11ed-9022-0242ac120002', 'JavaScripts I','JavaScripst from scratch', 1, '487609a4-65e9-11ed-9022-0242ac120002');
insert into courses("id", "Title", "Description", "Level", "Teacher") values('7cc3cc1c-65eb-11ed-9022-0242ac120002', 'JavaScripts II','JavaScripst zero to hero', 2, '487609a4-65e9-11ed-9022-0242ac120002');
insert into courses("id", "Title", "Description", "Level", "Teacher") values('6137e92e-65eb-11ed-9022-0242ac120002', 'JavaScripts III','JavaScripst advanced', 3, '487609a4-65e9-11ed-9022-0242ac120002');

/* Create content */
insert into course_videos("Title", "Url", "Course") values('JavaScript: Introduction', './courses/media/videos/mp4/jsIntro4567323.mp4', 'a03ab51c-65ea-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: Variables', './courses/media/videos/mp4/jsIntro75567588.mp4', 'a03ab51c-65ea-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: Arrays', './courses/media/videos/mp4/jsIntro34679809.mp4', 'a03ab51c-65ea-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: Objects', './courses/media/videos/mp4/jsIntro89786756.mp4', 'a03ab51c-65ea-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: If Else', './courses/media/videos/mp4/jsIntro84765421.mp4', 'a03ab51c-65ea-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: Functions', './courses/media/videos/mp4/jsIntro547568.mp4', 'a03ab51c-65ea-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: Data Structures', './courses/media/videos/mp4/jsInter5685685.mp4', '7cc3cc1c-65eb-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: EMACScript6', './courses/media/videos/mp4/jsInter34534662.mp4', '7cc3cc1c-65eb-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: POO', './courses/media/videos/mp4/jsAdv547568345.mp4', '6137e92e-65eb-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: Async Await', './courses/media/videos/mp4/jsAdv5474326443.mp4', '6137e92e-65eb-11ed-9022-0242ac120002');
insert into course_videos("Title", "Url", "Course") values('JavaScript: APIs', './courses/media/videos/mp4/jsAdv45756835432.mp4', '6137e92e-65eb-11ed-9022-0242ac120002');

/* Relation users courses : cardinality N:M */
INSERT INTO users_courses("User", "Course", "Progress") values('0d02b692-65e9-11ed-9022-0242ac120002', 'a03ab51c-65ea-11ed-9022-0242ac120002', 10.50);
INSERT INTO users_courses("User", "Course") values('0d02b692-65e9-11ed-9022-0242ac120002', '7cc3cc1c-65eb-11ed-9022-0242ac120002');
INSERT INTO users_courses("User", "Course") values('b2fc3b72-65e9-11ed-9022-0242ac120002', '6137e92e-65eb-11ed-9022-0242ac120002');

/* Update the user to specify that completed a course */
update users_courses set "Completed" = true,  "Progress" = 100 where "id" = 1;

/* Show Different created tables */
select * from users;
select * from courses;
select * from users_courses;

/* This join together different kinds of entities and it relates to each other to query more information at a glance */
/* For example we can join the users entity and view more info relate to it */
select c."Title", c."Description", t."Name", u."Name" as Teacher, v."Url" as Video from courses as c inner join categories as t on c."Level" = t."id" inner join users as u on u."id" = c."Teacher" inner join course_videos as v on v."Course" = c.id limit 10 offset 0; 

/* Other example is to view information about users and how many courses they have */
select u."Name", u."Email", r."Name" as Role, s."Title" as Course, c."Progress", c."Completed" from users as u inner join users_courses as c on u."id" = c."User" inner join roles as r on u."Role" = r."id" inner join courses as s on c."Course" = s."id" order by u."Name", s."Title" limit 10 offset 0;

