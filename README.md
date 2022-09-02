# MySQL-database-schema
Vehicle tracking MySQL database schema for a parcel delivery company 

# Scenario
A delivery company wants to build a system that is going to track its vehicles and drivers
throughout the working day - each vehicle is fitted with a GPS. At the start of any day, drivers are
assigned a vehicle and shift(morning/afternoon). Morning shift is 8 am - 11:55 am and afternoon shift is 12 pm - 4pm. There are 10 drivers, 5 vehicles and data is to be entered for a week.

## Company's requirements

1. Create a database with all appropriate tables, constraints, and relationships.
2. The database should be normalised to at least 2NF.
3. The tables should be populated.
4. Create SQL queries to:\
4.1 Get the location of any vehicle and its driver at any hour during the working day.\
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

# Queries implementation

The queries that have been implemented are:

-Listing of all drivers\
-Listing of all drivers that have only driven during morning hours\
-Number of parcels delivered by any specific driver during day’s work\
-The location of any vehicle and its driver at any hour during the working day\

### Listing of all drivers:

To get all the drivers. The build-in SELECT command has been used to get columns first_name and
last_name from drivers table. These two have been merged into one column called “Names” and
sorted by the first name and last_name respectively for an organised output.

Listing of all drivers that have only driven during morning hours: 

To get all the drivers that have only driven during morning hours the JOIN command had to be used
to join shift_id and weekly_shift tables. A common column has to be present to join two tables
together; shift_id shared driver_id with the drivers table; weekly_shift shared shift_id columns with
shift_id table. Now that 3 tables have been connected all information could be combined, drivers
first_name and last_name have been selected and merged as “Name”, date from weekly_shift table
and shift from weekly_shift. For the final result, the WHERE command has been used to filter the
output by shift being only Morning. Lastly, to make everything output nicely the ORDER command
has been used to sort the output by date, first name and last name respectively.

Number of parcels delivered by any specific driver during day’s work:

To get a number of parcels delivered by any specific driver during a day’s work, similarly to the query
above the following information had to be found out: Date, Vehicle_ID who’s driving that vehicle
and the count of parcels that they have delivered. These tables have been connected together
shift_id, weekly_shift, shift and driver to know who’s driving what vehicle at what day. After that, all
of these have been connected to the location_track table and the following columns have been
selected: date, first_name, last_name and delivered_status. Because each driver only had one parcel
per day, the count of delivered would be 1 if they have successfully delivered a parcel and 0 if they
did not. Everything has been ordered by location and then first_name to get an organised output.

The location of any vehicle and its driver at any hour during the working day:

To get the location of any vehicle and its driver at any hour during the working day the following had
to be found out: Who’s driving what car, at what day and what shift they’re doing. The last table
already had the time, vehicle_ID and Location. The first table connected was shift_id, to get the shift,
driver_id and vehicle_id this has been connected with weekly_shift and shift using primary keys that
they have all shared. These 3 tables gave most of the necessary information, now these had to be
connected to the drivers table to get the name of driver_id. Lastly, all of these have been connected
to location_track. Date, time, vehicle_id, first_name, last_name and locations have been selected
for the appropriate output. The WHERE command has been used to get the correct time depending
on the shift e.g. 9 o clock is between the hours of morning, so that would know it’s a morning shift
and only return drivers that are doing morning shift on that day. All have been ordered by location
and then time.


