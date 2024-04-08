-- Who is the senior most employee based on the job title?

select * 
from employee
order by levels desc
limit 1;

-- Which country have the most Invoices?

-- This gives country and its total
select billing_country,
sum(total) as Total_invoice
from invoice
group by billing_country
order by Total_invoice desc
limit 1;

-- This gives country, count and its total
select billing_country,
count(billing_country),
sum(total) as Total_invoice
from invoice
group by billing_country
order by  Total_invoice desc
limit 1;


-- What are the top three values of total invoice?

select billing_country,
total 
from invoice
order by total desc
limit 3;

-- Which city has the best customers?
--(Returns 1 city that hAS the highest sum of the invoices totals.
--Return both the city name and the sum of all invoice totals)


select billing_city,
sum(total) as Total_invoice
from invoice
group by billing_city
order by Total_invoice desc
limit 1;

-- Who is the best customer?
-- Return the person who has spent the most money

select cust.customer_id,cust.first_name,cust.last_name,
sum(inv.total) as Total_invoice
from customer as cust
left join invoice as inv
on cust.customer_id = inv.customer_id
group by cust.customer_id
order by Total_invoice desc
limit 1;

-- Return the email, first name, last name and Genre of all Rock Music listeners.
-- Return the list alphabetically by email 

select DISTINCT email,first_name, last_name
from customer
join invoice
on customer.customer_id = invoice.invoice_id
join invoice_line as il
on il.invoice_id = invoice.invoice_id
where il.track_id in( 
	select track_id
	from track
	join genre
	on track.genre_id = genre.genre_id
	where genre.name LIKE 'Rock'
	)
order by email ;

--  Artist who have written the most rock music
-- Returns the Artist name and total count of the top 10 rock bands

select count(album.artist_id) as count, album.artist_id,artist.name
from album
left join artist
on album.artist_id = artist.artist_id
left join track 
on album.album_id = track.album_id
left join genre 
on track.genre_id = genre.genre_id
where genre.name = 'Rock'
group by album.artist_id, artist.name
order by count desc
limit 10;

-- Return all the track names that have a song length longer than the average song length.
-- Return the name and millisecond for each track. Order by the song length with the largest song list first.

select name, milliseconds
from track 
where milliseconds > (select avg(milliseconds)
					  from track )
order by milliseconds desc

-- How much amount spent by each customer on artist?
-- Return customer name, artist name and total spent

select sum(invoice_line.unit_price * invoice_line.quantity) as total_spent, artist.name, invoice.customer_id,
customer.first_name
from invoice
left join customer on customer.customer_id = invoice.customer_id
left join invoice_line on invoice_line.invoice_id = invoice.invoice_id
left join track on track.track_id = invoice_line.track_id
left join album on album.album_id = track.album_id
left join artist on artist.artist_id = album.artist_id
group by artist.name,invoice.customer_id, customer.first_name
order by total_spent desc;









