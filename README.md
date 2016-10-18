SevOne-Deferred-Data-Scripts
============================
A collection of open-source deferred data scripts for SevOne



Setup
=====
To get any of the adapters going that you haven't run before, run the script
and pipe it to deferred-data-import, pointed to a SevOne appliance and device
that you want to have own the objects.  After it completes, discover that
device within SevOne; after discovery completes, rerun the script again.  You
should have your first data points on that object.



deferred-data-import
====================
This is the core script in the collection.  It is agnostic to the data being
supplied to it; in true Unix style, it simply reads data points from STDIN and
imports them to a SevOne appliance using the Deferred Data SOAP API mechanism.

Required information is supplied to deferred-data-import via command-line, as
follows:

    deferred-data-import 'SevOne name or IP' 'username' 'password' 'Device Name'

Data input should follow this format:

    "timestamp" "object name" "object type" "object description" ["indicator name 1" "indicator format 1" "indicator units 1" "indicator value 1" ["indicator name 2" "indicator format 2" "indicator units 2" "indicator value 2" [... etc]]]

Note that the units can be just a single unit for both measurement and display,
or it can be of the format "measurement units//display units"

"Indicator format" refers to "GAUGE", "COUNTER32", or "COUNTER64".  Most of
what you import via Deferred Data will be GAUGE.  Refer to the SevOne manual
for more information.  It does attempt to use quotes to allow spaces in text
fields, command-line style, but note that this mechanism is not perfect.
Non-numeric values will be treated as dropped polls.

All the processors are executable; provided you have the proper language
interpreters installed, simply running them with the following syntax should
get your data imported fine:

    ./processors/[processor and args] | ./defererd-data-import [args]



deferred-data-backfill
======================
This works exactly the same way as deferred-data-import, but is optimized for
backfilling a large volume of historical data by making use of the multi-row
insert functionality in SevOne's plugin_deferred_insertDataRows() API function.
It further optimizes for large data volume by caching, in memory, metadata that
would otherwise be retrieved from the SevOne appliance for every input line;
object types, indicator types, objects, and indicators.



bamboo-rest
===========
* Language:  Python
* Type:      API
* Reference: http://www.atlassian.com/software/bamboo
* Usage:



    bamboo-rest -u username -p password [options]

Provided you have Python and the dependencies installed, this one is easy. I'll
list the depdencies below.

Python dependencies:
* getopt
* urllib2
* calendar
* json
* datetime



process-mileage
===============
* Language:  PHP
* Type:      Local file
* Refernece: None
* Usage:



    process-mileage /path/to/csv     # Accepts a filename as a parameter
    process-mileage < /path/to/csv   # Also accepts data over STDIN

This one processes gas mileage data, imported to a file manually from fuel
receipts.  It expects CSV files in the following format:

    Time, name of station, octane rating ((RON + MON) / 2), price per gallon, volume in gallons, total price, distance travelled in mile

Special considerations:
* Time will be converted to a timestamp using strftime().  It's magic.
      Don't worry about how it works.
* * This was tested in the following format: "Y-m-d H:i:s Z"
* Each gas station you use will be a separate object, in addition to an
      object that contains data points for all the others.  This is mainly
      intended for comparing fuel quality from one brand to the next.  In
      the distant future (the year 2000), there will be a command-line
      switch to disable the separate stations in order to save elements on
      the SevOne appliance it's being imported to
* Any numeric fields that are found to contain a non-numeric value will
      have a NULL inserted for that indicator at that data point

Known issues:
* Can consume a lot of elements; need to have an option to not save individual
      fuel branding objects



mint
====
* Language:  Python
* Type:      Screen scraper + API
* Reference: http://www.mint.com/
* Usage:


    mint 'Mint registered E-mail address' 'Mint password'

Known issues/caveats:
* For this to work, you MUST run python3 setup.py build and
      python3 setup.py install as root in processors/libraries/mintapi
* Does not pull down details on individual investments, only whole accounts
* Auto-refreshes accounts at the end of the script, rather than the beginning



wordpress
=========
* Language:  Python
* Type:      Database processor
* Reference: http://www.wordpress.org/
* Usage:


    wordpress [options] mysql-host 'MySQL user' 'MySQL password' 'MySQL db'

This processor connects to a MySQL database backing a Wordpress instance, does
some processing, and exports some statistics about posts, metadata, comments,
categories, and tags.

Python dependencies:
* calendar
* datetime
* MySQLdb
* optparse
* time



alexa
=====
* Language:  Python
* Type:      Screen scraper
* Reference: http://www.alexa.com/
* Usage:


    alexa domain-name

This processor scrapes the page on alexa.com for the given domain name for
rank, reach, and other data.

Python dependencies:
* calendar
* datetime
* lxml
* mechanize
* optparse
* time



raspberry-pi
============
* Language: bash
* Type:     System poller
* Usage:


    raspberry-pi sshuser@ip.or.hostname [/path/containing/vcgencmd]

This processor connects to a Raspberry Pi running one of the many flavors of
Linux that support the little computer.  

The statistics this exports include current temperature, clocks, voltages, and
system load.

Note that passwordless SSH from the system running this poller to the Raspberry
Pi must be enabled; also, the vcgencmd binary must be present somewhere on the
Raspberry Pi's filesystem.  By default, this looks for vcgencmd in the path
that OpenELEC places it in (/usr/bin); if your vcgencmd binary is elsewhere,
you must pass that path in (e.g. "/opt/vc/bin" for Debian Wheezy) as the second
parameter.



ampache
=======
* Language:  Python
* Type:      Database processor
* Reference: http://www.ampache.org/
* Usage:


    ampache [options] mysql-host 'MySQL user' 'MySQL password' 'MySQL db'

This processor connects to a MySQL database backing an Ampache instance, does
some processing, and exports some statistics about posts, metadata, comments,
categories, and tags.

Python dependencies:
* calendar
* datetime
* MySQLdb
* optparse
* time



plex-media-server
=================
* Language:  Python
* Type:      API
* Reference: http://www.plexapp.com/
* Usage:


    plex-media-server [options] plex-host

This processor connects to a system running Plex Media Server and scrapes
statistics about the various libraries using the REST API.

It should be noted that Plex Media Server seems to hit the CPU on its host hard
while this scraper is running.

Python dependencies:
* calendar
* datetime
* lxml
* optparse
* time



jira-board
==========
* Language:  CasperJS
* Type:      Screen scraper
* Reference: https://www.atlassian.com/software/jira
* Usage:


    jira-board 'board URL' 'Jira username' 'Jira password'

This processor logs into a Jira server, navigates to an Agile board, and
exports some statistics about the issues on that Agile board.



jira-filter
===========
* Language:  Python
* Type:      API
* Reference: http://www.atlassian.com/software/bamboo
* Usage:


    jira-filter -u username -p password [options] "filter-ID-or-JQL"

Provided you have Python and the dependencies installed, this one is easy. I'll
list the depdencies below.

Python dependencies:
* getopt
* urllib2
* calendar
* json
* datetime



polldaddy
=========
* Language:  Python
* Type:      Screen scraper
* Reference: http://www.polldaddy.com/
* Usage:


    polldaddy poll-id

This processor scrapes a given poll on PollDaddy for vote statistics.

Python dependencies:
* calendar
* datetime
* lxml
* mechanize
* optparse
* time



honeywell-thermostat
====================
* Language:  CasperJS
* Type:      Screen scraper
* Reference: http://www.mytotalconnectcomfort.com/
* Usage:


    honeywell-thermostat email password

This processor logs into Honeywell's "My Total Connect Comfort" site and reads
data from your thermostats.  Each thermostat is an object, with several
indicators about the indoor/outdoor state and state of the system.



games/path-of-exile
===================
* Language:  Python
* Type:      Screen scraper
* Reference: http://www.pathofexile.com/
* Usage:


    path-of-exile Account_Name

This processor scrapes a player's account data for a free-to-play game called
Path of Exile.

Python dependencies:
* calendar
* datetime
* lxml
* mechanize
* optparse
* time



linux-disk
==========
* Language:  bash
* Type:      System poller
* Usage:


    linux-disk

This processor uses `df` and `mount` to scrape usage data about the mounted
filesystems on a Linux machine.  SNMP would normally be used for this, but if
SNMP is impossible, this utility will provide an easy workaround.  This may
work with other flavors of Unix, but is untested.



killing-floor
=============
* Language:  Python
* Type:      Screen scraper
* Reference: http://www.killingfloorthegame.com/
* Usage:


    killing-floor server.hostname.or.ip Admin_username Admin_password

This processor scrapes the webadmin interface for a Killing Floor server and
retrieves server/player statistics

Python dependencies:
* calendar
* datetime
* lxml
* mechanize
* optparse
* time



linux-nvidia
============
* Language:  bash
* Type:      System poller
* Usage:


    linux-nvidia X_Display_ID
    # Ex: linux-nvidia :0.0

This processor uses the `nvidia-settings` CLI utility to scrape data about an
NVidia graphics card; metadata and utilization statistics alike.  An xAgent
net-snmp plugin would be nicer for this purpose, but that doesn't seem to
currently exist.



minerd-journalctl
=================
* Language:  Python
* Type:      Log parser
* Reference: http://sourceforge.net/projects/cpuminer/
* Usage:


    minerd-journalctl systemd-service-name sevone.ip.or.hostname sevone-username sevone-password sevone-device-name

This processor uses journalctl to read the log coming out of a minerd or
compatible cryptocurrency miner (such as cpuminer or cudaminer) either live as
it's written or into the past if --backfill is passed.

This processor is unique in that it runs for an extended period of time,
typically as a daemon, when not in backfil mode.  It spins up journalctl and
deferred-data-import as subprocesses and keeps them alive as long as it runs.

A systemd unit file is included: /utilities/deferred-minerd@.service - it will
need to be modified before installation.  Most users should only need to modify
the capitalized text.

Note that this processor currently inserts a data point for, basically, every
log entry.  Eventually it will perform aggregation-on-the-fly, but for now, be
careful, as you could end up with a _lot_ of data on your disk.

Python dependencies:
* datetime
* json
* optparse
* subprocess
* sys
* time



cgminer
=======
* Language:  Python
* Type:      API
* Reference: https://github.com/ckolivas/cgminer
* Usage:


    cgminer [options] cgminer.ip.or.hostname

This processor connects to the API on a cgminer process to scrape stats.  It
can currently scrape whole process stats and stats about GPUs; it doesn't yet
support USB devices like ASICs.

Python dependencies:
* datetime
* json
* optparse
* socket
* sys
* time



wemineltc
=========
* Language:  CasperJS
* Type:      Screen scraper
* Reference: http://www.wemineltc.com/
* Usage:


    wemineltc Username Password

This processor logs into a We Mine LTC account and scrapes data about the LTC
network as a whole, the We Mine LTC pool, the user's account, and the user's
individual workers.



wemineftc
=========
* Language:  CasperJS
* Type:      Screen scraper
* Reference: http://www.wemineftc.com/
* Usage:


    wemineftc Username Password

This processor logs into a We Mine FTC account and scrapes data about the ftc
network as a whole, the We Mine FTC pool, the user's account, and the user's
individual workers.



switchercoin
============
* Language:  CasperJS
* Type:      Screen scraper
* Reference: http://switchercoin.com/
* Usage:


    switchercoin Username Password

This processor logs into a Switchercoin account and scrapes data about the
Switchercoin multipool, the user's account, and the user's individual workers.



bitcoin-blockchain
==================
* Language:  bash
* Type:      API
* Reference: https://blockchain.info/
* Usage:


    bitcoin-blockchain address1 "Friendly name 1" [address2 "Friendly name 2" [... addressN "Friendly name N"]]

This processor uses the plain-text API on https://blockchain.info/ to pull the
BTC balance for a given address on the blockchain.  It can process an arbitrary
number of addresses per call.  Friendly names are just used as object
descriptions for SevOne; they can be anything you want.



wafflepool
==========
* Language:  Python
* Type:      Screen scraper
* Reference: http://www.wafflepool.com/
* Usage:


    wafflepool btc-address

This processor scrapes a specific miner's statistics from
http://www.wafflepool.com/ and imports them.  Objects exported by this
processor are fairly wide, with eight indicators per individual altcoin plus
some.



google-finance-tracker
======================
* Language:  Python
* Type:      API
* Reference: http://finance.google.com/
* Usage:


    google-finance-tracker ticker
    google-finance-tracker [exchange:]ticker
    google-finance-tracker [exchange1:]ticker1[,[exchange2]:ticker2[... ,[exchangeN]:tickerN]]

This processor uses the Google Finance REST API to pull down information
for an exchange-traded stock ticker - including current price, volume,
EPS, P/E, and others.



yahoo-weather
=============
* Language:  Python
* Type:      API
* Reference: https://developer.yahoo.com/yql/console/
* Usage:


    yahoo-weather WOEID
    yahoo-weather 12797352

This processor uses the Yahoo! Weather REST API to gather information about
the weather in a given location.

You must pass it a WOEID, which is a unique number assigned to a specific
location on Earth - WOEID stands for "Where On Earth IDentifier".  The example
WOEID, 12797352, is assigned to Newark, CA, United States.

To look up the WOEID for a location, you can use a third-party tool found at
the following URL:  http://woeid.rosselliot.co.nz/



owncloud
========
* Language:  Python
* Type:      Local filesystem
* Reference: http://www.owncloud.com/
* Usage:


    owncloud /path/to/owncloud/install
    owncloud /usr/share/webapps/owncloud

This processor looks at individual users' directories within an Owncloud data
directory; it provides statistics about number and size of files/directories
active, in trash, in version control, in cache, and in the gallery.



games/diablo-3
==============
* Language:  Python
* Type:      API
* Reference: http://us.battle.net/d3/en/
* Usage:


    diablo-3 Profile-ID
    diablo-3 Derp-1915

This processor scrapes statistics about a Diablo 3 character and account from
Blizzard's community stats REST API.

To find the Profile-ID for your account, look at the URL for your web profile;
as an example URL, we have the following:

    http://us.battle.net/d3/en/profile/Derp-1915/

"Derp-1915" would be the Profile-ID, in this case.



games/starcraft-2
==============
* Language:  Python
* Type:      API
* Reference: http://us.battle.net/sc2/en/
* Usage:


    starcraft-2 ProfilePath
    starcraft-2 8072831/1/Derp

This processor scrapes statistics about a Starcraft 2 profile from Blizzard's
community stats API.

To find the ProfilePath for your account, look at the URL for your web profile;
as an example URL, we have the following:

    http://us.battle.net/sc2/en/profile/8072831/1/Derp/

"8072831/1/Derp" would be the ProfilePath, in this case.



magelo-eq
=========
* Language:  Python 2.7
* Type:      Screen scraper
* Reference: http://eq.magelo.com/
* Usage:


    magelo-eq Profile-ID
    magelo-eq 665922

This processor scrapes web statistics about an EverQuest 1 character from
magelo.com's web interface.

To find the Profile-ID for your character, look at the URL for your web
profile; as an example URL, we have the following:

    http://eq.magelo.com/profile/665922

"665922" would be the Profile-ID, in this case.

Currently, you must run a separate script for each profile ID you wish to
poll.  That will change in the future.



pi-hole
=======
* Language:  Python 2.7
* Type:      API
* Reference: https://pi-hole.net/
* Usage:


    pi-hole hostname-or-IP
	pi-hole dns.localdomain
	pi-hole 192.168.1.201

This processor connects to a Pi-Hole DNS server's API and scrapes the
statistics that it exports.

You simply pass it the hostname or IP address of the Pi-Hole server.

