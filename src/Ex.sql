--  1. Owner_лердин аттарынын арасынан эн коп символ камтыган owner_ди жана анын уйун(House) чыгар.
select house_type ,first_name,max(length(first_name)) from owners o inner join house h on o.id = h.owner_id group by house_type, first_name  limit 1 ;
-- - 2. Уйлордун баалары 1500, 2000 дин аралыгында бар болсо true чыгар, жок болсо false чыгар.
select exists( select 1 from house where price between 1500 and 2000) ;
-- - 3. id_лери 5, 6, 7, 8, 9, 10 го барабар болгон адресстерди жана ал адрессте кайсы уйлор бар экенин чыгар.
select a.id,a.city,a.region,h.description from addresses a inner join house h on a.id = h.address_id where a.id in (5,6,7,8,9,10);
-- - 4. Бардык уйлорду, уйдун ээсинин атын, клиенттин атын, агенттин атын чыгар.
select h.description,o.first_name,c.first_name,a.name from house h inner join rent_info ri on h.id = ri.house_id inner join owners o on ri.owner_id = o.id inner join customers c on ri.customer_id = c.id inner join agencies a on ri.agency_id = a.id;
-- - 5. Клиенттердин 10-катарынан баштап 1999-жылдан кийин туулган 15 клиентти чыгар.
select * from customers where date_of_birth < '1999.1.1' offset 10 limit 15;
-- - 6. Рейтинги боюнча уйлорду сорттоп, уйлордун тайптарын, рейтингин жана уйдун ээлерин чыгар. (asc and desc)
select h.house_type,h.rating,o.first_name from house h inner join rent_info ri on h.id = ri.house_id inner join owners o on ri.owner_id = o.id order by rating asc ;
-- - 7. Уйлордун арасынан квартиралардын (apartment) санын жана алардын баасынын суммасын чыгар.
select count(h.house_type),sum(h.price) from house h where house_type = 'Apartment';
-- - 8. Агентсволардын арасынан аты ‘My_House’ болгон агентсвоны, агентсвонын адресин жана анын бардык уйлорун, уйлордун  адрессин чыгар.
select a.name,h.house_type,ad.city,ad.street,h.description from agencies a inner join rent_info ri on a.id = ri.agency_id inner join addresses ad on a.address_id = ad.id inner join house h on ri.house_id = h.id where name = 'My House';
-- - 9. Уйлордун арасынан мебели бар уйлорду, уйдун ээсин жана уйдун адрессин чыгар.
select o.first_name,ad.street,h.furniture from house h inner join rent_info ri on h.id = ri.house_id inner join owners o on ri.owner_id = o.id inner join addresses ad on h.address_id = ad.id where furniture = true;
-- - 10.Кленти жок уйлордун баарын жана анын адрессин жана ал уйлор кайсыл агентсвога тийешелуу экенин чыгар.
select * from  house h left join rent_info ri on h.id = ri.house_id left  join addresses a on h.address_id = a.id left join  agencies ag on ri.agency_id = ag.id;
-- - 11.Клиенттердин улутуна карап, улутуну жана ал улуутта канча клиент жашайт санын чыгар.
-- ??????????????????????????
select c.first_name,nationality,description,count(c.nationality) from customers c inner join rent_info ri on c.id = ri.customer_id inner join house h on ri.house_id = h.id group by first_name,nationality,description;
-- - 12.Уйлордун арасынан рейтингтери чон, кичине, орточо болгон 3 уйду чыгар.
select description,max(h.rating),avg(h.rating),min(h.rating) from house h group by description limit 3;
-- - 13.Уйлору жок киленттерди, клиенттери жок уйлорду чыгар.
select c.first_name,h.description from house h full join rent_info ri on h.id = ri.house_id full  join customers c on ri.customer_id = c.id where ri.customer_id is null group by first_name,description ;
-- - 14.Уйлордун бааларынын орточо суммасын чыгар.
select avg(house.price) from house ;
-- - 15.‘A’ тамга менен башталган уйдун ээсинин аттарын, клиенттердин аттарын чыгар.
select o.first_name,c.first_name from owners o inner join rent_info ri on o.id = ri.owner_id inner join customers c on ri.customer_id = c.id where o.first_name like 'A%';
-- - 16.Эн уйу коп owner_ди жана анын уйлорунун санын чыгар.
select o.first_name,count(h.id) from owners o inner join rent_info ri on o.id = ri.owner_id inner join house h on ri.house_id = h.id  group by first_name  order by count(h.id) desc;
select o.first_name,count(*) from owners o inner join house h on o.id = h.owner_id group by first_name order by count(h.id) desc ;
-- - 17.Улуту Kyrgyzstan уй-булолу customerлерди чыгарыныз.
select * from customers c where c.marital_status = 'Married'  and nationality = 'Kyrgyz';
-- - 18.Эн коп болмолуу уйду жана анын адресин ал уй кайсыл ownerге таандык ошону чыгарыныз.
select  h.description,a.street,o.first_name,max(room) from house h inner join addresses a on h.address_id = a.id inner join owners o on h.owner_id = o.id group by description,street,first_name order by max(room) desc limit 3;
-- - 19.Бишкекте жайгашкан уйлорду жана клиентерин кошо чыгарыныз.
select h.description,c.first_name ,a.street from house h inner join rent_info ri on h.id = ri.house_id inner join customers c on ri.customer_id = c.id inner join addresses a on h.address_id = a.id where city = 'Bishkek';
-- - 20.Жендерине карап группировка кылыныз.
select o.gender,count(gender) from owners o where gender = 'Male' or gender ='Female' group by gender;
-- - 21.Эн коп моонотко ижарага алынган уйду чыгарыныз.
select max(check_out - check_in) from house h inner join rent_info ri on h.id = ri.house_id;
-- - 22.Эн кымбат уйду жана анын ээсин чыгарыныз.
select o.first_name,o.last_name,max(h.price) from owners o inner join house h on o.id = h.owner_id group by first_name,last_name order by max(price) desc limit 3;
-- - 23.Бир региондо жайгашкан баардык агентстволорду чыгарыныз
select ad.region,a.name from agencies a inner join addresses ad on a.address_id = ad.id;
-- - 24.Рейтинг боюнча эн популярдуу 5 уйду чыгар.
select h.description,max(h.rating) from house h group by description order by max(rating) desc limit 5;
-- - 25.Орто жаштагы owner_ди , анын уйун , уйдун адрессин чыгар.
select o.first_name,h.description,ad.street,avg(extract(year from date_of_birth)) from owners o inner join house h on o.id = h.owner_id inner join addresses ad on h.address_id = ad.id group by first_name,description,street ;
select o.first_name,h.description,ad.street,avg(extract(year from date_of_birth)) from owners o inner join rent_info ri on o.id = ri.owner_id inner join house h on ri.house_id = h.id inner join addresses ad on ad.id = h.address_id group by first_name,description,street ;