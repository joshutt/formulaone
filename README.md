# Formula One Fantasy
Utility scripts to help with fantasy formula one, mostly for my own use but if you find it useful feel free to use for your own

----
## Files
* **drivers.csv** - all drivers, their cost and scores for each race
* **teams.csv** - all teams, their cost and scores for each race
* **optimizeTeams.r** - R source file will all of the functions
* **pickBestTeam.py** - Python script to help pick the optimal lineup (*In Progress*)
* **testPickBestTeam.py** - PyUnit tests for pickBestTeam.py

----
## Optimize Teams
The `optimizeTeam.r` scripts provide a number of useful functions for building your fantasy team.

* **loadDrivers** - This function will load the content in the drivers.csv and teams.csv and make available in a `drivers` and `teams`
data frames.  Each data frame will have a column for each race, the cost and then the average points per race, the median and the adjusted
average, which is the average after removing the highest and lowest scores.

* **calculateLineup** - This function will take a parameter for which column you want to optimize over, by default it uses `adj`.  The result
is a new data frame containing all of the combinations of 5 drivers and 1 team that can be afforded within the $100 million limit, ordered
by the optimized parameter

* **adjustLineup** - This function takes three parameters, the driver factor to consider, your current team and a vector of your current
drivers.  The function will consider your current team and the factor to optimize and give you back the list of possible changes you could
make to your team, when limited to a single change each race

* **findTeam** - Does something, I don't remember what.
