-- The database for term project CMPE 138
drop database if exists Train_Project;
create database Train_Project;
use Train_Project;

SET SQL_SAFE_UPDATES = 0;
#SET foreign_key_checks = 0;

create table Accident_Reports
(	time_	 time(0),  
	location varchar(20),
	status_    varchar(15),
	incident_no numeric(4,0),
	train_no     integer,
	primary key( incident_no) 
);


create table station
(
	location  varchar(20),
	primary key(location)
);

create table staff -- disjoint superclass
(	E_id     numeric(9,0),
	primary key (E_id)
);
create table station_staff -- disjoint subclass
(
	S_id  numeric(9,0),
	foreign key (S_id) references staff(E_id) on delete set null 
);
create table conductor -- disjoint subclass
(
	C_id  numeric(9,0),
	foreign key (C_id) references staff(E_id) on delete set  null 
);
create table train_staff -- disjoint subclass 
(
	T_id  numeric(9,0),
	foreign key (T_id) references staff(E_id) on delete set null 
);

create table monitored_by
(
	s_location varchar(20),
	M_id numeric(9,0),
	foreign key (s_location) references station(location) on delete set  null,
	foreign key(M_id) references staff(E_id) on delete set  null 
);
create table passengers
(
	P_id  numeric(9,0),
	Fname  varchar(20) check (Fname != NULL),
	Lname  varchar(20) check (Lname != NULL),
	date_     date, 
	purchaseTime  time(0),
	destination   varchar(15), 
	primary key(P_id)
);
create table buy
(

	purchaseTime time(0), 
	destination varchar(15)
	
	
);
create table verifies_ticket
(
	V_id numeric(9,0),
	pa_id numeric(9,0),

	foreign key(V_id) references staff(E_id) on delete set  null,
	foreign key(pa_id) references passengers(P_id) on delete set null
);
create table tickets
(
	
	destination   varchar(15), 
	ticket_no     integer
	

);


create table train
(
	cabin_temp		numeric(4,2), 
	train_no		integer, 
	max_cap			integer, 
	status_			varchar(15),
	last_known_loc	varchar(15),
	primary key(train_no)
);
create table files
(
	F_id numeric(9,0),
	train_no integer,
	incident_no numeric(4,0),

	foreign key(F_id) references staff(E_id),
	foreign key( incident_no)references Accident_Reports(incident_no),
	foreign key(train_no) references train(train_no)
); 

create table arrive 
(
	scheduled_arrival_time	time(0),
	
	location  varchar(20), 
	train_no  integer,
	
	foreign key(location) references station(location) on delete set  null,
	foreign key(train_no) references train(train_no) on delete set  null
); 
create table depart
(

	scheduled_departure_time time(0),
	location  varchar(20), 
	train_no  integer,
	
	foreign key(location) references station(location) on delete set  null,
	foreign key(train_no) references train(train_no) on delete set  null
); 
create table ride
(
	rtrain_no integer,
	R_id numeric(9,0),
	foreign key(rtrain_no) references train(train_no) on delete set  null, 

	foreign key(R_id) references passengers(P_id) on delete set  null
	
	


);


create table controlled_by
(
	ctrain_no integer, 
	B_id     numeric(9,0),
	foreign key(ctrain_no) references train(train_no) on delete set null,
	foreign key(B_id) references staff(E_id) on delete set null
	
	
	
	
); 

create table run_by
(
	btrain_no integer,
	U_id     numeric(9,0),
	foreign key(btrain_no) references train(train_no) on delete set  null,
	foreign key(U_id) references staff(E_id) on delete set  null 
	
);




delete from run_by;
delete from controlled_by;
delete from ride;
delete from depart;
delete from arrive;
delete from files;
delete from train;
delete from tickets;
delete from verifies_ticket;
delete from buy;
delete from passengers;
delete from monitored_by;
delete from train_staff;
delete from conductor;
delete from station_staff;
delete from staff; 
delete from station;
delete from Accident_Reports; 


insert into Accident_Reports values('12:15:18', 'Pawnee', 'Repairing', '01', '15'); -- parks and rec
insert into Accident_Reports values('14:45:00', 'New York', 'Repaired', '02', '7'); -- Mad men 
insert into Accident_Reports values('17:03:59', 'Gotham', 'Out of Service', '03', '11'); -- DC
insert into Accident_Reports values('18:00:45', 'Olympia', 'Repaired', '04', '1'); -- feminist train 

insert into station values('Pawnee');
insert into station values('New York');
insert into station values('Gotham');
insert into station values('Olympia');
insert into station values('Washington DC');

insert into staff values('474319932'); -- station staff
insert into staff values('475888943'); -- station staff
insert into staff values('309552569');
insert into staff values('184287649');
insert into staff values('410018282');
insert into staff values('311074797'); -- conductor
insert into staff values('756908364');
insert into staff values('099943631');
insert into staff values('077168969');
insert into staff values('070564689');
insert into staff values('812734282'); -- train staff 
insert into staff values('199587861');
insert into staff values('747750344');

insert into station_staff values('474319932');-- of W train
insert into station_staff values('475888943'); -- of pawnee train
insert into station_staff values('309552569'); -- gotham train 
insert into station_staff values('184287649'); -- mad men train 
insert into station_staff values('410018282'); -- marvel train 

insert into conductor values('311074797'); -- of W train 
insert into conductor values('756908364'); -- of Pawnee train
insert into conductor values('099943631');-- of Gotham train
insert into conductor values('077168969'); -- of mad men train
insert into conductor values('070564689');-- of marvel train 

insert into train_staff values('812734282'); -- train staff 
insert into train_staff values('199587861');
insert into train_staff values('747750344');

insert into monitored_by values('Olympia', '474319932'); 
insert into monitored_by values('Pawnee', '475888943');
insert into monitored_by values('Gotham', '309552569'); 
insert into monitored_by values('New York', '184287649');  
insert into monitored_by values('Washington DC', '410018282'); 

insert into passengers values('007363335', 'Diana', 'Prince', '2015-04-16', '15:20:01', 'Gotham');-- Olympus Train 
insert into passengers values('514257547', 'Olivia', 'Pope', '2015-04-16', '16:01:31', 'Washington DC');
insert into passengers values('543718883', 'Abby', 'Whelan', '2015-04-16', '16:02:05', 'Washington DC');
insert into passengers values('104572807', 'Mellie', 'Grant', '2015-04-16', '16:05:00', 'Washington DC');
insert into passengers values('944700359', 'Cristina', 'Yang', '2015-04-16', '16:17:23', 'New York');
insert into passengers values('942551538', 'Meredith', 'Grey', '2015-04-16', '16:17:30', 'New York');
insert into passengers values('403973604', 'Joan',  'Holloway', '2015-04-16', '16:30:12', 'New York');
insert into passengers values('896386824', 'Hermione', 'Granger', '2015-04-16', '16:36:00', 'Pawnee');
insert into passengers values('549975567',  'Luna', 'Lovegood', '2015-04-16', '17:43:00', 'Pawee'); 

insert into passengers values('669842436',  'Leslie', 'Knope', '2015-04-16', '05:43:00', 'Washington DC'); -- Pawnee Train 
insert into passengers values('291240430',  'Ben', 'Wyatt', '2015-04-16', '05:43:00', 'Washington DC');
insert into passengers values('421044894',  'April', 'Ludgate', '2015-04-16', '06:15:20', 'Washington DC');
insert into passengers values('914122837',  'Andy', 'Dwyer', '2015-04-16', '06:15:20', 'Washington DC');
insert into passengers values('136942594',  'Ann', 'Perkins', '2015-04-16', '06:22:50', 'New York');
insert into passengers values('295805849',  'Chris', ' Traeger', '2015-04-16', '06:22:50', 'New York');
insert into passengers values('594665917',  'Ron', 'Swanson', '2015-04-16', '07:00:00', 'Washington DC');
insert into passengers values('347498946', 'Donna', 'Meagle', '2015-04-16', '07:30:00', 'Washington DC');
insert into passengers values('309541694', 'Tom', 'Havaford', '2015-04-16', '09:30:00', 'Washington DC');
insert into passengers values('911717312', 'Jean-Ralphio', 'Saperstein', '2015-04-16', '10:30:00', 'Washington DC');
insert into passengers values('569457203', 'Mona Lisa',  'Saperstein', '2015-04-16', '11:45:00', 'Washington DC'); 

insert into passengers values('247765883', 'Don', 'Draper', '2015-04-16', '07:15:00', 'Gotham'); -- Mad Men train
insert into passengers values('707654622', 'Roger', 'Sterling', '2015-04-16', '07:30:00', 'Gotham');
insert into passengers values('841045194', 'Peggy', 'Olson', '2015-04-16', '07:45:00', 'New York');
insert into passengers values('210965927', 'Betty', 'Draper', '2015-04-16', '08:00:00', 'New York'); 
insert into passengers values('874512624', 'Bobby', 'Draper', '2015-04-16', '08:00:00', 'New York'); 
insert into passengers values('190155474', 'Sally', 'Draper',  '2015-04-16', '08:00:00', 'New York'); 
insert into passengers values('006468445', 'Megan', 'Draper', '2015-04-16', '08:15:00', 'New York');

insert into passengers values('002087219', 'Bruce', 'Wayne', '2015-04-16', '12:15:00', 'New York'); -- DC train 
insert into passengers values('940193423', 'Clark', 'Kent', '2015-04-16', '01:15:10', 'New York');
insert into passengers values('324794477', 'Jim', 'Gordon', '2015-04-16', '02:00:10', 'New York');
insert into passengers values('833128703', 'Selina', 'Kyle', '2015-04-16', '02:01:10', 'Olympia');
insert into passengers values('896168318', 'Barry', 'Allen', '2015-04-16', '02:07:00', 'Pawnee');
insert into passengers values('186026511', 'Oliver', 'Queen', '2015-04-16', '02:07:00', 'Pawnee');
insert into passengers values('156111049', 'Jack',  'Napier', '2015-04-16', '07:07:07', 'Gotham');
insert into passengers values('943548203', 'Shiera',  'Hall', '2015-04-16', '08:07:10', 'Olympia');
insert into passengers values('720948119',  'Dinah', 'Lance', '2015-04-16', '08:10:10', 'Olympia');
insert into passengers values('795905967',  'Helena', ' Bertinelli', '2015-04-16', '08:35:18', 'Olympia');

insert into passengers values('597359298', 'Tony', 'Stark', '2015-04-16', '12:51:03', 'Washington DC'); -- Avenger's train 
insert into passengers values('096351016', 'Steve', 'Rogers', '2015-04-16', '01:00:00', 'Washington DC');
insert into passengers values('333383043', 'Bruce', 'Banner', '2015-04-16', '01:10:01', 'Pawnee');
insert into passengers values('680067207', 'Clint' ,'Barton','2015-04-16', '01:25:30', 'New York'); 
insert into passengers values('837285986', 'Thor' ,'Odinson','2015-04-16', '01:30:30', 'New York');  
insert into passengers values('391547463', 'Natasha' ,'Romanova','2015-04-16', '01:45:03', 'Olympia');  

insert into buy values( '15:20:01', 'Gotham'); -- W Train 
insert into buy values( '16:01:31', 'Washington DC');
insert into buy values( '16:02:05', 'Washington DC');
insert into buy values( '16:05:00', 'Washington DC');
insert into buy values( '16:17:23', 'New York');
insert into buy values( '16:17:30', 'New York');
insert into buy values( '16:30:12', 'New York');
insert into buy values(  '16:36:00', 'Pawnee');
insert into buy values( '17:43:00', 'Pawee'); 

insert into buy values( '05:43:00', 'Washington DC'); -- Pawnee Train 
insert into buy values('05:43:00', 'Washington DC');
insert into buy values( '06:15:20', 'Washington DC');
insert into buy values( '06:15:20', 'Washington DC');
insert into buy values('06:22:50', 'New York');
insert into buy values( '06:22:50', 'New York');
insert into buy values( '07:00:00', 'Washington DC');
insert into buy values( '07:30:00', 'Washington DC');
insert into buy values(  '09:30:00', 'Washington DC');
insert into buy values('10:30:00', 'Washington DC');
insert into buy values( '11:45:00', 'Washington DC'); 

insert into buy values( '07:15:00', 'Gotham'); -- Mad Men train
insert into buy values( '07:30:00', 'Gotham');
insert into buy values( '07:45:00', 'New York');
insert into buy values( '08:00:00', 'New York'); 
insert into buy values( '08:00:00', 'New York'); 
insert into buy values( '08:00:00', 'New York'); 
insert into buy values( '08:15:00', 'New York');

insert into buy values('12:15:00', 'New York'); -- DC train 
insert into buy values('01:15:10', 'New York');
insert into buy values('02:00:10', 'New York');
insert into buy values('02:01:10', 'Olympia');
insert into buy values('02:07:00', 'Pawnee');
insert into buy values('02:07:00', 'Pawnee');
insert into buy values('07:07:07', 'Gotham');
insert into buy values('08:07:10', 'Olympia');
insert into buy values('08:10:10', 'Olympia');
insert into buy values('08:35:18', 'Olympia');

insert into buy values('12:51:03', 'Washington DC'); -- Avenger's train 
insert into buy values('01:00:00', 'Washington DC');
insert into buy values('01:10:01', 'Pawnee');
insert into buy values('01:25:30', 'New York'); 
insert into buy values('01:30:30', 'New York');  
insert into buy values('01:45:03', 'Olympia');  

insert into verifies_ticket values('812734282', '007363335'); -- W train
insert into verifies_ticket values('812734282', '514257547');
insert into verifies_ticket values('812734282','543718883');
insert into verifies_ticket values('812734282','104572807');
insert into verifies_ticket values('812734282', '944700359');
insert into verifies_ticket values('812734282', '942551538');
insert into verifies_ticket values('812734282', '403973604');
insert into verifies_ticket values('812734282', '896386824');
insert into verifies_ticket values('812734282', '549975567');

insert into verifies_ticket values('812734282', '669842436'); -- Pawnee train 
insert into verifies_ticket values('812734282', '291240430');
insert into verifies_ticket values('812734282', '421044894');
insert into verifies_ticket values('812734282', '914122837');
insert into verifies_ticket values('812734282', '136942594');
insert into verifies_ticket values('812734282', '295805849');
insert into verifies_ticket values('812734282', '594665917');
insert into verifies_ticket values('812734282', '347498946');
insert into verifies_ticket values('812734282', '309541694');
insert into verifies_ticket values('812734282', '911717312');
insert into verifies_ticket values('812734282', '569457203');

insert into verifies_ticket values('199587861', '247765883');-- Mad Men train 
insert into verifies_ticket values('199587861', '707654622');
insert into verifies_ticket values('199587861', '841045194');
insert into verifies_ticket values('199587861', '210965927');
insert into verifies_ticket values('199587861', '874512624');
insert into verifies_ticket values('199587861', '190155474');
insert into verifies_ticket values('199587861', '006468445');

insert into verifies_ticket values('199587861', '002087219'); -- DC Train
insert into verifies_ticket values('199587861', '940193423');
insert into verifies_ticket values('199587861', '324794477');
insert into verifies_ticket values('199587861', '833128703');
insert into verifies_ticket values('199587861', '896168318');
insert into verifies_ticket values('199587861', '186026511');
insert into verifies_ticket values('199587861', '156111049');
insert into verifies_ticket values('199587861', '943548203');
insert into verifies_ticket values('199587861', '720948119');
insert into verifies_ticket values('199587861', '795905967');

insert into verifies_ticket values('747750344', '597359298');-- Avenger's Train 
insert into verifies_ticket values('747750344', '096351016');
insert into verifies_ticket values('747750344', '333383043');
insert into verifies_ticket values('747750344', '680067207');
insert into verifies_ticket values('747750344', '837285986');
insert into verifies_ticket values('747750344', '391547463');

insert into tickets values('Olympia', '1');-- W Train 
insert into tickets values('Olympia', '2');
insert into tickets values('Pawnee', '3');
insert into tickets values('Pawnee', '4');
insert into tickets values('Gotham', '5');
insert into tickets values('Washigton Dc', '6');
insert into tickets values('Washington DC', '7');
insert into tickets values('Olympia', '8');
insert into tickets values('New York',  '9'); 

insert into tickets values('Pawnee', '1'); -- Pawnee Train 
insert into tickets values('Pawnee',  '2');
insert into tickets values('Pawnee', '3');
insert into tickets values('Pawnee', '4');
insert into tickets values('Gotham', '5');
insert into tickets values('Gotham',  '6');
insert into tickets values('New York',  '7');
insert into tickets values('Olympia', '8');
insert into tickets values('New York',  '9');
insert into tickets values('New York', '10');
insert into tickets values('New York', '11'); 

insert into tickets values('New York', '1'); -- Mad Men train
insert into tickets values('New York', '1');
insert into tickets values('Washington DC', '3');
insert into tickets values('Pawnee', '4'); 
insert into tickets values('Pawnee', '5'); 
insert into tickets values('Pawnee', '6'); 
insert into tickets values('Washington DC', '7');

insert into tickets values('Gotham', '1'); -- DC train 
insert into tickets values('Washington DC', '2');
insert into tickets values('Gotham', '3');
insert into tickets values('Gotham', '4');
insert into tickets values('New York', '5');
insert into tickets values('New York', '6');
insert into tickets values('New York', '7');
insert into tickets values('Washington DC', '8');
insert into tickets values('New York',  '9');
insert into tickets values('Gotham', '10');

insert into tickets values('New York', '1'); -- Avenger's train 
insert into tickets values('New York', '2');
insert into tickets values('New York', '3');
insert into tickets values('Pawnee', '4'); 
insert into tickets values('Washington DC', '5');  
insert into tickets values('New York', '6');  

insert into train values('73.04', '1', '250', 'On-Time', 'Gotham'); -- W train 
insert into train values('74.00', '2', '200', 'On-Time', 'New York'); -- Parks and rec train
insert into train values('73.04', '3', '275', 'Delayed', 'New York'); -- Gotham Train -> DC Train 
insert into train values('73.00', '4', '300', 'Behind', 'New York'); -- Mad Men Train
insert into train values('73.04', '5', '200', 'Ahead', 'Pawnee'); -- Averengers Train 

insert into monitored_by values('Olympia', '812734282'); 
insert into monitored_by values('Pawnee', '812734282');
insert into monitored_by values('New York', '199587861');  
insert into monitored_by values('Gotham', '199587861'); 
insert into monitored_by values('Washington DC', '747750344');

 

insert into files values('311074797', '1', '1'); -- of W train
insert into files values('812734282', '1', '2'); 
insert into files values('756908364', '2', '1'); -- of Pawnee train 
insert into files values('199587861', '3', '1'); -- dc train
insert into files values('099943631', '3', '2'); 
insert into files values('309552569', '3', '3');
insert into files values('184287649', '4', '1'); -- mad men train 
	
insert into arrive values('11:30:00',  'Pawnee', '1'); -- W train 
insert into arrive values('03:00:00',  'Gotham', '1');
insert into arrive values('04:15:00',  'New York', '1');
insert into arrive values('21:45:00', 'Washington DC', '1');
insert into arrive values('17:00:00', 'Olympia', '1'); 

insert into arrive values('02:30:00', 'Gotham', '2');
insert into arrive values('03:45:00', 'New York', '2'); 
insert into arrive values('21:59:00', 'Washington DC', '2');
insert into arrive values('21:45:00', 'Olympia', '2'); 
insert into arrive values('23:00:00', 'Pawnee', '2'); 

insert into arrive values('10:00:00','New York', '3'); 
insert into arrive values('04:00:00','Washington DC',  '3'); 
insert into arrive values( '03:00:00', 'Olympia','3');
insert into arrive values('05:00:00','Pawnee',  '3');
insert into arrive values('07:30:00','Gotham',  '3'); 

insert into arrive values('07:30:00','Washington DC',  '4'); 
insert into arrive values( '06:00:00','Olympia', '4');
insert into arrive values('08:00:00','Pawnee',  '4'); 
insert into arrive values('10:10:00','Gotham',  '4'); 
insert into arrive values('11:20:00','New York',  '4');

insert into arrive values('13:00:00','Olympia',  '5');
insert into arrive values('15:00:00', 'Pawnee', '5'); 
insert into arrive values('17:30:00', 'Gotham', '5'); 
insert into arrive values('18:45:00', 'New York', '5');  
insert into arrive values('15:00:00', 'Washington DC', '5'); -- issue

insert into depart values('11:40:00', 'Olympia', '1');
insert into depart values('03:30:00', 'Pawnee', '1');
insert into depart values( '04:30:00', 'Gotham', '1');
insert into depart values( '22:00:00', 'New York', '1');
insert into depart values( '18:00:00', 'Washington DC', '1'); 

insert into depart values('12:00:00', 'Pawnee', '2'); 
insert into depart values('03:00:00', 'Gotham', '2'); 
insert into depart values('23:45:00', 'New York', '2'); -- issue
insert into depart values('01:00:00', 'Washington DC', '2'); 
insert into depart values ('22:00:00', 'Olympia', '2'); 

insert into depart values('08:45:00', 'Gotham', '3'); 
insert into depart values('10:15:00', 'New York', '3'); 
insert into depart values('03:15:00', 'Washington DC', '3');
insert into depart values('05:15:00', 'Olympia', '3'); 
insert into depart values('08:00:00', 'Pawnee', '3'); 

insert into depart values('08:30:00', 'New York', '4');
insert into depart values('07:45:00', 'Washington Dc', '4');
insert into depart values('06:15:00', 'Olympia', '4');
insert into depart values('08:15:00', 'Pawnee', '4');
insert into depart values('10:25:00', 'Gotham', '4');

insert into depart values('02:00:00', 'Washington DC', '5'); 
insert into depart values('13:15:00', 'Olympia', '5');
insert into depart values('15:15:00', 'Pawnee', '5'); 
insert into depart values('17:45:00', 'Gotham', '5'); 
insert into depart values('19:00:00', 'New York', '5'); 


insert into ride values('1', '007363335'); -- Olympus Train 
insert into ride values('1',' 514257547');
insert into ride values('1', '543718883');
insert into ride values('1', '104572807');
insert into ride values('1', '944700359');
insert into ride values('1', '944700359');
insert into ride values('1', '942551538');
insert into ride values('1', '403973604'); 
insert into ride values('1', '896386824');
insert into ride values('1', '549975567'); 

insert into ride values('2', '669842436');  -- Pawnee Train 
insert into ride values('2', '291240430');
insert into ride values('2','421044894');
insert into ride values('2', '914122837');
insert into ride values('2','136942594');
insert into ride values('2','295805849');
insert into ride values('2','594665917');
insert into ride values('2','347498946');
insert into ride values('2','309541694');
insert into ride values('2','911717312');
insert into ride values('2','569457203'); 

insert into ride values('3','002087219'); -- DC train 
insert into ride values('3','940193423');
insert into ride values('3','324794477');
insert into ride values('3','833128703');
insert into ride values('3','896168318');
insert into ride values('3','186026511');
insert into ride values('3','156111049');
insert into ride values('3','943548203');
insert into ride values('3','720948119');
insert into ride values('3','795905967');

insert into ride values('4', '247765883'); -- Mad Men train
insert into ride values('4', '707654622');
insert into ride values('4','841045194');
insert into ride values('4','210965927'); 
insert into ride values('4','874512624'); 
insert into ride values('4','190155474'); 
insert into ride values('4','006468445');

insert into ride values('5','597359298'); -- Avenger's train 
insert into ride values('5','096351016');
insert into ride values('5','333383043');
insert into ride values('5','680067207'); 
insert into ride values('5','837285986');  
insert into ride values('5','391547463');  

insert into controlled_by values('1', '311074797');
insert into controlled_by values('2', '756908364');
insert into controlled_by values('3', '099943631');
insert into controlled_by values('4', '077168969');
insert into controlled_by values('5', '070564689');

insert into run_by values('1', '812734282');
insert into run_by values('2', '812734282');
insert into run_by values('3', '199587861');
insert into run_by values('4', '199587861'); 
insert into run_by values('5', '747750344');


-- Query ready!!! 