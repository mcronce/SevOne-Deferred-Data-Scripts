SevOne-Deferred-Data-Scripts
============================
A collection of open-source deferred data scripts for SevOne



deferred-data-import
====================
This is the core script in the collection.  It is agnostic to the data being
supplied to it; in true Unix style, it simply reads data points from STDIN and
imports them to a SevOne appliance using the Deferred Data SOAP API mechanism.

Required information is supposed to deferred-data-import via command-line, as
follows:
	deferred-data-import 'SevOne name or IP' 'username' 'password' 'Device Name'

Data input should follow this format:
	"timestamp" "object name" "object type" ["indicator name 1" "indicator format 1" "indicator units 1" "indicator value 1" ["indicator name 2" "indicator format 2" "indicator units 2" "indicator value 2" [... etc]]]
"Indicator format" refers to "GAUGE", "COUNTER32", or "COUNTER64".  Most of
what you import via Deferred Data will be GAUGE.  Refer to the SevOne manual
for more information.  It does attempt to use quotes to allow spaces in text
fields, command-line style, but note that this mechanism is not perfect.
Non-numeric values will be treated as dropped polls.



mint
====
* Language:  Ruby
* Type:      Scraper
* Reference: http://www.mint.com/
* Usage:
	mint 'Mint registered E-mail address' 'Mint password'

This one requires special attention.  It is written in Ruby and, as such, has
special needs.  Before being able to run it, make sure Ruby and bundler
installed.  Once you do:
	cd processors/;
	bundle;
After that, the mint processor should work fine.

Known issues:
* Does not auto-refresh accounts
* Does not pull down details on individual investments, only whole accounts
