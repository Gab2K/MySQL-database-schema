# MySQL-database-schema
Vehicle tracking MySQL database schema for a parcel delivery company 

#Scenario
A delivery company wants to build a system that is going to track its vehicles and drivers
throughout the working day - each vehicle is fitted with a GPS. At the start of any day, drivers are
assigned a vehicle and shift(morning/afternoon). Morning shift is 8 am - 11:55 am and afternoon shift is 12 pm - 4pm.There are 10 drivers, 5 vehicles and data is to be entered for a week.

## Company's requirements

1. Create a database with all appropriate tables, constraints, and relationships.
2. The database should be normalised to at least 2NF.
3. The tables should be populated.
4. Create SQL queries to:
4.1 Get the location of any vehicle and its driver at any hour during the working day.
4.2 Get the number of parcels delivered by any specific driver during a day's work.

## Overview of the design process

A sufficient design had to be made because everything cannot be stored in one big table as that simply wouldn’t work.

The design process started off simply. Drivers table and vehicle tables have been created separately
that holds the most the basic information about each like name. Primary keys for each have been
added in form of an ID, this way an ID is given to each driver and each vehicle can be identified
by a number, this was necessary as 2 vehicles can be the same model or 2 people can have the same
name and surname, primary key allowed to separate that because the primary key is unique to each
row.

Next up, a table that will store the whole weeks’ worth of shifts, it needs to link driver_id and
vehicle_id together on a specific day and get the shift, from this it will be known which driver, drives
which vehicle on which day and what shift they’re doing, because the same driver can have 2 shifts
in one day in the same vehicle, therefore it needs to be differentiated what shift they’re on.

Shifts table has been created that is going to store 3 things: Shift, Shift_start and shift_end times,
this way the keyword “Morning” and “Afternoon” are going to hold the times of when they start and
finish, this table has been made to avoid repetition in the tables below.

Weekly_shift table has been created next, that is going to store Date and shift as a keyword, e.g.
01/09/2016 morning shift is going to be stored as “1M” and 01/09/2016 as “1A”

Lastly, shift_id table was now going to store all of that information. It has foreign key Date_shift_id
from weekly_shift table, then driver_id and vehicle_id respectively. From this, it’s going to be known
what date, what shift, which driver is going to be driving which vehicle. Because Date_shift_id can
constantly be repeated as there can be many drivers on the specific date and shift, therefore a
composite primary key was made, together date_shift_id and driver_id are going to identify what
vehicle is going to be driven.

Now, a table to store information about parcels has been created. That table is going to store the
address of the client and their name to know where it is supposed to be delivered, each parcel is
given a special ID because each parcel is unique.

Last and the biggest table has been created to track each driver at certain hours during the day, their
location and what parcel they’re currently carrying. The following columns have been created Date,
Time, Vehicle ID, Location, Parcel ID and delivered status. From time, date and vehicle_ID the driver
could be identified inside the specific vehicle because from other tables we know what driver is
driving what vehicle on which day and what shift they are doing. The delivered status is going to
know if they have delivered the parcel or not which can be added up to know how many parcels
they have delivered.


![image](https://user-images.githubusercontent.com/60928508/188202695-69baf74e-8528-4222-b808-d504c3ad734c.png)


