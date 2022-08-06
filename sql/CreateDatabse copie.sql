
CREATE SEQUENCE public.seq_book;

CREATE TABLE public.book (
                book_id INTEGER NOT NULL DEFAULT nextval('public.seq_book'),
                book_title VARCHAR(256) NOT NULL,
                book_authors VARCHAR(256) NOT NULL,
                CONSTRAINT pk_book PRIMARY KEY (book_id)
);


ALTER SEQUENCE public.seq_book OWNED BY public.book.book_id;

CREATE SEQUENCE public.seq_person;

CREATE TABLE public.person (
                person_id INTEGER NOT NULL DEFAULT nextval('public.seq_person'),
                person_firstname VARCHAR(128) NOT NULL,
                person_lastname VARCHAR(128) NOT NULL,
                person_birthdate DATE,
                CONSTRAINT pk_person PRIMARY KEY (person_id)
);


ALTER SEQUENCE public.seq_person OWNED BY public.person.person_id;

CREATE SEQUENCE public.seq_borrow;

CREATE TABLE public.borrow (
                borrow_id INTEGER NOT NULL DEFAULT nextval('public.seq_borrow'),
                person_id INTEGER NOT NULL,
                book_id INTEGER NOT NULL,
                borrow_date DATE NOT NULL,
                borrow_return DATE,
                CONSTRAINT pk_borrow PRIMARY KEY (borrow_id)
);


ALTER SEQUENCE public.seq_borrow OWNED BY public.borrow.borrow_id;

TRUNCATE public.borrow CASCADE;
TRUNCATE public.person CASCADE;
TRUNCATE public.book CASCADE;

INSERT INTO public.person(person_id, person_firstname, person_lastname, person_birthdate) VALUES
(1, 'Pierre', 'KIMOUS', '2000-02-04'),
(2, 'Jean-Yves', 'MARTIN', '1963-08-12'),
(3, 'Jean-Marie', 'NORMAND', '1991-04-16')
;
SELECT pg_catalog.setval('seq_person', 3, true);


INSERT INTO public.book(book_id, book_title, book_authors) VALUES
(1, 'Astérix chez les Bretons', 'René Goscinny, Albert Uderzo'),
(2, 'La Foire aux immortels', 'Enki Bilal'),
(3, 'Les Passagers du Vent, Volume 1', 'François Bourgeon'),
(4, 'Fairy Tail, Vol 1', 'Hiro Mashima')
;
SELECT pg_catalog.setval('seq_book', 3, true);

INSERT INTO public.borrow(borrow_id, person_id, book_id, borrow_date, borrow_return) VALUES
(1, 2, 4, '2021-07-15', '2021-09-01'),
(2, 1, 2, '2021-08-01', NULL),
(3, 3, 3, '2021-10-01', NULL),
(4, 2, 1, '2021-10-02', NULL)
;
SELECT pg_catalog.setval('seq_borrow', 4, true);


ALTER TABLE public.borrow ADD CONSTRAINT book_borrow_fk
FOREIGN KEY (book_id)
REFERENCES public.book (book_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.borrow ADD CONSTRAINT person_borrow_fk
FOREIGN KEY (person_id)
REFERENCES public.person (person_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


