# Wireshark

## Introduction
* [Overview](http://wiresharkdownloads.riverbed.com/video/wireshark/introduction-to-wireshark/)
* [Wireshark main site](https://www.wireshark.org/)
* [Sample Capture](https://wiki.wireshark.org/SampleCaptures) and [Publicly available PCAP files](http://www.netresec.com/?page=PcapFiles)

## Tutorial
* [Introduction to Wireshark (Part 1 of 3)](https://www.youtube.com/watch?v=NHLTa29iovU)
	* The intent of this tutorial is to learn HTTP request, cookies, forms and FLV. 	* Since this tutorial uses Firefox (FF), we will install FF: `apt-get update` then `apt-get install firefox`, start `firefox` 
	* set start page to blank by clicking Setting/config button at upper right corner  
![Firefox preferences to blank page](http://note.io/1C8IiQS) to setup perference. 
This allows us to start FF without sending any request.
	* Start Wireshark, Capture > Interfaces then check `eth0` and click start.
	![select interface to capture](http://note.io/1B6xOKy)
	* Copy [Heaton Research](http://www.httprecipes.com) URL into FF; this will start the capture the communication between browser to website. 
	![capture](http://note.io/1F0ywiE)
	* There are 2 ways to filter the output: filter or expression. Click Expression, select http, then click Apply. ![use expression to filter http protocol](http://note.io/1KZOT43)
	For some reason, [SSDP details](https://wiki.wireshark.org/SSDP) "Simple Service Discovery Protocol (SSDP) The SSDP protocol can discover Plug & Play devices, with uPnP (Universal Plug and Play). SSDP uses unicast and multicast adress (239.255.255.250). SSDP is HTTP like protocol and work with NOTIFY and M-SEARCH methods." 
	* There are many good information in the ![capture](http://note.io/1KZT9AG). By selecting different hyperlinks, more detailed information will be highlighted in bottom panel.

* [Cookies and Grabbing Passwords with Wireshark (Part 2 of 3)](https://www.youtube.com/watch?v=7ezGTP99xSw) 
	* Learn to [set cookie on Heaton Research](http://www.httprecipes.com/1/2/cookies.php) by copying URL into FF and click set cookie, the server will ask the name of the cookie. This will ![set cookie to browser](http://note.io/1EdtHkt). In Wireshark, filtered by http, we can find cookie is set in the middle panel. 
	* Click the Get request, we can see the name of cookie is echoed in the middle panel. 
	* Webserver also received information for web form, such as password. Heaton Research also provides a [test page](http://www.httprecipes.com/1/2/forms.php) for learning the capture the data from a form.  
	* User's data is `post` via a form, including password. It is hard to read the information at the bottom of the Wireshark. A easy way is Analyze > Follow TCP Stream; a separate window will pop up. ![capture data in form](http://note.io/1NNcSlW) 
	
* [Data Mining using Wireshark (Part 3 of 3)](https://www.youtube.com/watch?v=2R1DRnu5CxQ) to download Youtube contents. *skip this, looks like protocol changed*

## Configuration
[Intro and about the Wireshark environment with Hansang Bae](https://www.youtube.com/watch?v=U0QABcTD-xc)
	* Edit > Preferences > User Interfaces > Columns
	Click Add > Select Type from drop down > Apply, then re-arrange the order of columns.
	![add columns](http://note.io/1x0sldk)	
	* Various configuration can be grouped a profile. 
	Edit > Configuration Profiles > Add
	* We can add any attribute in middle panel as column by right click the field and select Apply as Column.

* Read Wireshark Output
	* [How to read Wireshark Output](https://www.youtube.com/watch?v=-aTGL4M0db4)

	Download file from repository, then open the file. 
	![sample pcap file](http://note.io/1MwJQ8w)

