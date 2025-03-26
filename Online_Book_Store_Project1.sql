create database online_book_store;
use online_book_store;

drop table if exists Books;
create table Books (
Book_ID serial primary key,
Title varchar (100),
Author varchar (100),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int
);

Drop Table if exists Customers;
create table Customers (
Customer_id serial primary key,
Name varchar(100),
email varchar (100),
phone varchar (15),
city varchar(50),
country varchar(150)
);

Drop table if exists orders;
create table orders (
order_id serial primary key,
customer_id int references customers(customer_id),
book_id int references books(book_id),
order_date date,
quantity int,
total_amount numeric(10,2)
);

select * from books;
select * from customers;
select * from orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from books
where genre = "Fiction";

-- 2) Find books published after the year 1950:
select * from books
where published_year > 1950;

-- 3) List all customers from the canada:
select * from customers
where country = "canada";

-- 4)Show orders placed in November 2023:
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrive the Total stock of books available:
select sum(stock) as total_stock
from books;

-- 6) Find the details of the most expensive book:
select * from books
order by price desc
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders
where quantity > 1;

-- 8) Retrive all orders where the total amount exceeds $20:
select * from orders 
where total_amount > 20;

-- 9) List all genre available in the Books table:
select distinct genre 
from books;

-- 10) find the book with the lowest stock:
select * from books
order by stock asc
limit 1 ;

-- 11) calculate the total revenue generated from all orders:
select sum(total_amount) as total_revenue
from orders;

-- 12) Retrive the total number of books sold for each genre:
select b.genre, sum(o.quantity) as total_books_sold
from books b
join orders o on b.book_id = o.book_id
group by b.genre;

-- 13) Find the average price of books in the "Fantasy" genre:
select avg(price) as average_price
from books
where genre = "Fantasy";

-- 14) List customers who have placed at least 2 orders:
select customer_id, count(order_id) as order_count
from orders
group by customer_id
having count(order_id) >= 2;

-- OR BY USING JOIN 
select c.customer_id, c.name, count(o.order_id) as order_count
from orders o
join customers c on c.customer_id = o.customer_id
group by customer_id
having count(o.order_id)>=2;

-- 15) Find the most frequently ordered books:
select b.title, o.book_id, count(o.order_id) as order_count
from orders o
join books b on b.book_id = o.book_id
group by o.book_id , b.title
order by order_count desc
limit 1;

-- 16) Show the top 3 most expensive books of 'fantasy' Genre
select * from books
where genre = 'fantasy'
order by price desc 
limit 3 ;

-- 17) Retrieve the total quantity of books sold by each author
select b.author, sum(o.quantity) as total_quantity
from orders o
join books b on o.book_id = b.book_id
group by b.author;

-- 18) List the cities where customers who spent over $30 are located:
select distinct(c.city), o.total_amount 
from orders o
join customers c on o.customer_id = c.customer_id
where o.total_amount > '30';
 
 -- 19) Find the customer who spent the most on orders
 select c.customer_id, c.name , sum(o.total_amount) as total_amount
 from customers c
 join orders o on c.customer_id = o.customer_id
 group by c.customer_id;
 
 -- 20) Calculate the stock remaining after fulfilling all orders
 select b.book_id,b.title,b.stock, 
 coalesce(sum(o.quantity),0) as order_quantity,
 b.stock - coalesce(sum(o.quantity),0) as remaining_quantity
 from books b
 left join orders o on b.book_id = o.book_id
 group by b.book_id;




