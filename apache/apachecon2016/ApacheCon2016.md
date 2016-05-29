# [Apache Big-Data 2016][0]
Richard Kuo, May 9, 2016 at Vancouver

## Day-1
### Keynotes  
**Netflix**    
Having a dashboard for displaying all software development stage, a management view. We can learn this from open source foundation, like Apache, OpenStack, ... 
Evolving, measure the info, learn, innovation, grow.

**Big data in Enterprise**  
Luciano Resende, Spark Technology Center, IBM   

* Use Flink, Spark, ML, and Zeppelin leads to psudo Analytics Operating System (platform) <- define OS at SaaS level.
* IBM Open Sourced Apache SystemML, Apache Quarks and    
* bundled Spark with BrightInSight      
![ibm streaming architecture][15]   

* comments: his architecture can be improved; 
	* processes should be in series not in parallel, 
	* ETL at front and ETL process should learn from ML. 
	* Parsed datastream should be achived and process should be continueous. 
	* If we use Flink, batch process branch will be eliminated.
* Use cases: SystemML on Spark with HealthCare; Telecom with multiple channels, need a 360 degree view  
* [SystemML][16] is "SystemML provides declarative large-scale machine learning (ML) that aims at flexible specification of ML algorithms and automatic generation of hybrid runtime plans ranging from single-node, in-memory computations, to distributed computations on Apache Hadoop and Apache Spark." 

**IT takes a village (or ecosystems)**  
Amy Gaskins  

* Apply Big-data to various Use Cases: Military, Large Corp, gov agency; related to the factors for Big-data project management 
	* Military: timing and urgency
	* Healthcare Insurance Fraud: Gather the collective knowledge
	* Commericalize OpenData: domain knowledge is critical
	   
* Requirments for successful data analytics:
	* Buy-in
		* high-level leadership was supportive
		* mid-level converted
		* lower levels wanted to help
	* urgency
	* Transparency
	* Non-data science SMEs
	* Psychological Safety 

### Apache Kylin 麒麟
Intent: we need real-time streamming and OLAP for Big-Data.    
Do a search to compare Kylin to [Druid][24] later.
  
![Kylin Architecture][5]

* It mainly to use micro-batch, connect to Zeppelin for interface, also, Tableau, Excel, MS power BI.   
* Data source (micro batch, micor cube )   
* Data aggregation types (Hyperloglog count, topN, BitMap Precise count distinct (meituan.com), raw records(jd.com))   
![kylin roadmap][17]

* side notes: 
 	* here are many oversea activities in China too, they follow the progress very close and play major role too.
	* pay attention, Real-time streaming OLAP is coming, watch its use cases.   
	* Performance comes from cube data structure; star schema may not be the only solution. We want to build data flat during streaming and most of work are pushed to cluster.   
   
### Migrating Pipelines into Docker
from Spotify    

* from counting stream playbacks to recommendation  
* move server to Amazone then to docker (grow from 60 nodes to 2000 nodes)  
* Luigi developent starts (instances of Job, can have dependency, graph tree, declare dependency) gui display inter-relationship amony tasks.    
latest tool from python -> scala, scalding   

* Big bet on docker [helios][7] application space.

why docker?    
 
* useful abstraction  
* incremental dependency  
* artefact distribution, caching  

move creating maven project to uploading docker images  
**Execution as a Service** <- in a way, this is **Compute as a Service** with orchestration, scheduling, logging, billing, ... project name: stycks

### Accelerating Apache Drill with FPGA
Eric Fukuda,.. from University of Toronto

Referring to [Apache drill][8]    
Schema-free SQL Query Engine for Hadoop, NoSQL and Cloud Storage. 
MS Bing improved 95% of its performance by using FPGA <- you can view it is programmable device   
FPGA is sit between Application Specific Integrated Chip (ASIC) and ?.

* FPGA is used for off load some HLS tasks; Most of FPGA has its own board. This project tries to virtualize the FPGA: Intel's Altera and [IBM's Xilinz][19].   
* use OpenCL API + HLS    
![development environment][22]
* Put [FPGA in VM][20] like we do for NIC, we can have multiple FPGA in VM -> customized VM 
* There are 10 times performance improvement over standard VM.  
![performance increase][23]

### Dockerized Hadoop Platform and Recent Updates in Apache BigTop
Yu-hsin Yeh from Trend Micro
 
Copied from [bigtop][6]:
The primary goal of Bigtop is to build a community around the packaging, deployment and interoperability testing of Hadoop-related projects. This includes testing at various levels (packaging, platform, runtime, upgrade, etc...) developed by a community with a focus on the system as a whole, rather than individual projects.   

<insert flow slides here>

Integration with Docker Machine and Swarm (manage multiple docker machines, use zookeep for high availability management too,)

**download the speaker's slide, which has many code**

Prebuild docker images with BigTop, treat images are immutatable.

[OpenPower][1] to have common architecture for various chips

### Apache Zeppelin    
Trevor Grant from market6
https://trevorgrant.org/  
[blog for installation][2], good information, but use Vagrant is easier.   

why?
* version control   
* dynamic form   
* inline documentation  
* easy for collaboration and across languages   

* Alluxio formally called Tachyon in memory database
* use R to access GoogleViz

* ResourcePools-memory pools, which allows data sharing from different interpreters, small dataset.
* Link paragraphs
* can be used for ETL 

3 Levels: [business analyst], [know python, statistic], [be able to do wierd stuff].

### Graph Service
krlohnes@us.ibm.com

* easy to represent relationship (link) between entities (nodes)
* scale better
* based on Apache Tinkerpop

**this is good subject but very bad presentation, not enough depth, skip!!**

## Day-2
### Apache Kafka 
from Rocana,   
**good info** further investigate this: compare this to event bus and message bus and read [log what every shoftware engineer should know][3] and [tranformation][4]

* topic has partition, which has single leader
* producers, brokers, consumers will deal distributed computing problems. see slides for details.
* Kafka support the consistency across multiple nodes, default to AP, but can be configured to CP
Review logstaching.
<insert architecture flow diagram here> 

Developing every solution, like you are developing a platform product.   
Monitor the node, it will be difficult to catch up event.

### Apache Hive
Alan Gates from Hortonworks

* Current activities in general:
	* shifted from SQL to traditional data warehousing problems
	* added more backend, like Spark   
	* created a new branch for new features (HPLSQL, HBase as metastore)

* adding procedure SQL 
	* Oracle and Teradata
	* Compatible and re-use
	* JDBC
* speed up
	* persistent daemons
	* Data caching with as async i/o
	* operator can be executed inside LLAP
	* Parallel
* Hive with LLAP (beta now)
	* Tez only, add LLAP -> 50% to 90% performance improvement.
* metastore
	* Hive takes time to figure out how to run it. There is a big cost on access metadata.
	* HBase solves some relational database issues, but no transaction.
* Hive on Spark
	* self-join, self-union, and CTEs
	* vectorized map join    
* Cost Based Optimizer (CBO)
	* focus on stat collection and estimation stats

Hive 2.0
	recommand use Tez and Spark, deprecated MapReduce   
	replace beeline CLI with Hive CL   
	drop java-6  
	requires Hadoop 2.x
	
### Apache Eagle 
user: eBay and PayPal
too much marketing stuff, skip!! crazy!

### Kafka
Joey from LinkedIn
**very good presentation and slide design** <- learn from it.  

Agenda   
	* UseCases at LinkedIn
	* Resilient infor

* tracking  
* Service Metrics   
	* usage, alert    
* Data Deployment   
	* offline, stream  
* Queuing  

<insert architecture>

* Protection (security and quotas)
	* protect infrastructure first, monitor client's quota -> hold request at broker
	* infrastructure has a lot protection, authentication, authorization (SSL,...)
* Empower user
	* create schema
	* schema review
	* produce ,auto-create topic with default
	* consume
* Samza - click platform
	* merge stream
* Glene
	* search    

Nuage - make infrastructure "invisible", good reference design for tool design.
make user's job easier.

* Monitoring
	* what needs to monitor for both client and infrastructure
	* audit trail,
	* shared dashboard 
	
* Measure yourself
	* availability (when leader died, whether client cares or not)
	* QoS dashboard, daily, weekly, 
* Bill
	* cost trail, such as byte count
	* mandate topic ownership

### Geospatically Enable Hadoop, Spark, 
Robert from Azavea

geo server = Geo + Accumulo
spatical indexing (GeoTrellis, Geomesa, Geowave)  
**Very interesting, research the tech behind the scene**  
periodicity for unbunded dimension, transform N-dimension -> 1-dimension  
good driver-> locationtech, github->locationtech/sfcurve, github.com/geotrellis/grellis, azavea-remanuele

GTS -> GeoTools (geomesa, geowave)  
	-> GeoTrellis (use Spark)   
geoDocker for deployment   
standard -> OGC GeoServer   
GeoJson   
GDAL for GeoTiff   
TMS (tile service)   

todo-find out more about open street editor

### Keynotes
* Alan Gates from Hortonworks

ODPi (Open Data Platform inititive)
Data grows from 4ZB to 44ZB by 2020
Apache drives common software among contributors
Test once, run everywhere.

* Mark Shuttleworth
make things easy, reduce friction.
next 20years is AI, how to have more fun and less friction.

** todo: Install and learn juju and Ranch**   
MAAS is for physical,   
LXD -> container   
cloud   
Scarcity is in Ops, free software is free but Operation becomes relative expensive.

history = write your own -> buy a sql db -> open source sql db -> big-data

chef is 70; write your own,   
SaaS is really a buy decision,   
architecture and Ops drives complexity higher, reduce complexity

* Spark 2.0    
Ion Stoica from DataBrick

Why is successful:
* efficiency  
* computation graph, up to 100x faster   
* flexible api, and interactive shell -> 5x less code   
* unified compute engine   

* new in 2.0
	* from RDD to DataFrame(2015); from early adapter to dev
	*  dataFrame = setaset
	* streaming to structure more sematic

* Tungsten phase-2
	* whole-stage code generation
	* optimizaed input/output

* Simplify streaming
	* realtime processing is vital
	* complex programming model(data, processing, output)
	* add data frame to continuous

todo-try Spark 2.0 Community Edition in Databrick.

[s2graph]-high performance distributed graph database
[MADlib] distributed in-database ML

## Day-3

### Zeppelin for Flink and Spark Workshop
trover.d.grant@gmail.com

* Requirement: java, git, ssh, maven

* use Tachyon for data sharing
* z is sc in spark, python, r, markdown 
* there is a job tracking for Spark and Flink
* need port forwarding 8081 open and flink cluster running for flink ui. 
* spark://apachecon1:7077 for server and ui -> cluster setup "master" field value
* flink from local -> localhost, which assume server is on same local machine

### Zeppelin

%zarvis is a new plugin that load slides
Helium button in new version, Helium is in beta, Zeppelin-533 ->recommend applicaiton to be used

Zeppelin 548/549 has access control
Zeppelin 702/208 support r and sparkr

* Proposal:
	* UX design (Jerermy Anderson)
	* Isolated Interpreter per notebook (scope)
	* pass data with z.put("key", "value"), 

* interpreter process has interpret group has interpreter
	* metnod for interpreter -> open, close, interpret methods required
* jvm in different instance
* notebookRepoSync 
* Apache Shiro to do authentication
* mailling list, issue trader, github
 
### MLlib 
Databrick

1000 contributors, integrate into existing workflow
Algorithm coverage <insert slides>

Specify pipe line
re-run on new data

* Existing tool in Python
Scikit-learn   
R  
Pandas   

* misconception about spark
only for big data
only for dedicated, distributed libraries

* use spark as scheduler to distribute training/testing to various TF
* wishlist: 
	* use distributed data sources
	* use familiar API
	* distribute ML workload piece by piece

* example, sentiment analysis http://snap.stanford.edu 
* flow: load data -> extract features -> train model -> evaluate

# [ApacheCon2016][9]

### Keynotes
**State of Apache**   
Ross Gardler, President, Apache Software Foundation

* growth 
	* 9 new project last year = tool 289 project, 54 in incubator
	* 698 new committers -> total 5478 
	* 794 commits, by 275 different committers in 24 hours
	* lists.apache.org 30million emails over 21 years
	
* why growing
	* not defined by market
	* by the people who do the work -> no backroom deals 
	* for public good 501(c)(3) not (c)(6) which is a "a business league"
	
* Leads the way
	* HTTPd
	* Tomcat in java (at on point 98%) 
	* Hadoop lead the march into BigData
	* Managing scale with Mesos and friends
	* Streaming analytics
	
**Open Technology**
Todd Moore, VP

Next bets... in cognitive, cloud era  
	* dwOpen
		* SystemML
		* Toree (spark kernel)
		* Quarks

**Open Source is Positive-Sum Game**
Sam Ramji, CEO of Cloud Foundry Foundation
good slides, read it again

* find a way to promote sharing, create trust
<insert slides here>

**Join or Die**
RedMonk
very good talk

In 1998, things are simple.
Platform-ibm, bea
DB-Oracle, db2, sqlServer

Number of things need to know is less -> software is expensive
Developers as **afterthough**, building things for CIO
-> try it first, 

OpenSource creates **Unintended** consequences.
-> more choice, convenience, not need to talk to anyone,
Oracle < mySQL < AWS

Landscape Changed -> the difference between complexity and simple
what happen the competition is not complex anymore

Important to know the adjecent projects, not target to a single object, make friends, compete in a rapid changing environment, -> "Join or Die"

**Apache Milagro**
Brian Spector
very interesting!

provides Distributed Cryptosystem
Future is not secured

move Browser based traffic -> app based
Miracl 

5 CA are all in USA -> leads to problem
key is burned in

## Day-4

### Zeppelin Workshop
Instructor: [Felix][12], learn from his code and video. very good!

### Zest-Composite Oriented Programming Using Java
Niclas Hedhman

[zest][10] is not for speed, it is more flexibility.
IMO, the workflow does not really fit most of developers.

### [Angular and Apache UNOMI][11]
from jahia

GWT -> Amber -> ReactJS ->RiotJS -> Aurelia -> Angular
consider existing compoents like material design
leverage angular2
angular1 and angular2 have same view
component tree works

Web Components
Native interation with Angular2

### Apache Way
Jim from ASF

* incorporated in 1999, virtual world-wide, minimum layer
* review the slides for license categories
* there are different levels/types of membership, meritocracy

share set of value: peer-based review, community create code, all votes hold the same weight

### [finagle and twitter][13]
ver@buoyant.io [site][14]

very good slide.
Example:   
2010 football @Brazil   
2011 twitter   
2012 Apache    

* Problems:
	* Ruby performance
	* mysql scaling
	* memcache operability
	* deploys
	
* Event - things happens, unpredictable traffic surges the demand.
* Provisioning - need to ask someone to give you a HW

mesos abstract HW details    
marathon abstract service

* microservices increases complexity, need to reduce friction
* decompose the app and create a service composition and routining, use logic name.
* real-time composition

[0]: http://events.linuxfoundation.org/
[1]: http://openpowerfoundation.org/2015-summit/
[2]: https://trevorgrant.org/2015/11/03/apache-casserole-a-delicious-big-data-recipe-for-the-whole-family/comment-page-1/#comment-2   
[3]: https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying
[4]: http://www.slideshare.net/JoeyEcheverria/embeddable-data-transformation-for-real-time-streams
[5]: http://kylin.apache.org/assets/images/kylin_diagram.png
[6]: http://bigtop.apache.org/   
[7]: https://github.com/spotify/helios
[8]: https://drill.apache.org/
[9]: http://events.linuxfoundation.org/events/apachecon-north-america/program/schedule
[10]: https://zest.apache.org/
[11]: http://unomi.incubator.apache.org/
[12]: https://github.com/felixcheung
[13]: https://apachecon2016.sched.org/event/6OJA/finagle-linkerd-and-apache-mesos-twitter-style-microservices-at-scale-oliver-gould-buoyant#
[14]: https://github.com/BuoyantIO/linkerd
[15]: https://raw.githubusercontent.com/rkuo/NetworkOS/master/apache/apachecon2016/images/IMG_20160509_092951.jpg 
[16]: https://systemml.apache.org/
[17]: https://raw.githubusercontent.com/rkuo/NetworkOS/master/apache/apachecon2016/images/IMG_20160509_111251.jpg
[18]: https://raw.githubusercontent.com/rkuo/NetworkOS/master/apache/apachecon2016/images/IMG_20160509_141629.jpg
[19]: https://raw.githubusercontent.com/rkuo/NetworkOS/master/apache/apachecon2016/images/IMG_20160509_141440.jpg
[20]: https://raw.githubusercontent.com/rkuo/NetworkOS/master/apache/apachecon2016/images/IMG_20160509_141517.jpg
[21]: http://blog.rocana.com/reliable-collection-from-log-files
[23]: https://raw.githubusercontent.com/rkuo/NetworkOS/master/apache/apachecon2016/images/IMG_20160509_142307.jpg
[24]: http://druid.io/













	
 
  


















