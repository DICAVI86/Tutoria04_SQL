CREATE DATABASE tutobooks;

\c tutobooks;

CREATE TABLE books (
    id serial primary key,
    name varchar(255) unique not null,
    publishing_year int check (publishing_year > 1800)
);

CREATE TABLE genres (
    id serial primary key,
    name varchar(32) unique not null
);

CREATE TABLE bookgenre (
    book_id int references books (id),
    genre_id int references genres (id),
    primary key (book_id, genre_id)
);

INSERT INTO books (name, publishing_year) VALUES 
('The Lord of the Rings', 1954),
('One Hundred Years of Solitude', 1967),
('The Little Prince', 1943),
('1984', 1949),
('Moby Dick', 1851);

INSERT INTO genres (name) VALUES 
('Fantasy'),
('Classic'),
('Science Fiction'),
('Adventure'),
('Drama');

INSERT INTO bookgenre (book_id, genre_id) VALUES 
(1, 1), (1, 3), (1, 4),
(2, 2), (2, 5);

select b.name, count(bg.genre_id) as genre_count
from books b
left join bookgenre bg ON b.id = bg.book_id
group by b.name;

CREATE TABLE reviews (
    id serial primary key,
    comment varchar(255) check (length (comment)> 10),
    user_name varchar(255) unique not null,
    book_id int, 
    foreign key (book_id) references books(id)
);

select b.name, count(r.id) as review_count
from books b
left join reviews r ON b.id = r.book_id
group by b.name;

alter table books
add constraint name_min_length check (length (name)>= 3);

INSERT INTO books (name, publishing_year) VALUES 
('the', 1954);

delete from books where id=7;

ALTER TABLE reviews DROP CONSTRAINT reviews_book_id_fkey;
ALTER TABLE bookgenre DROP CONSTRAINT bookgenre_book_id_fkey;

ALTER TABLE reviews
ADD CONSTRAINT reviews_book_id_fkey
FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE;

ALTER TABLE bookgenre
ADD CONSTRAINT bookgenre_book_id_fkey
FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE;

delete from books where id=1;
