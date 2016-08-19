# OSCON 2016
Richard Kuo, 20160516 in OSCON 2016, at Austin TX

## Reactive System Design
Hands on with Akka and Java/Scala   
Duncan K. DeVore from [Lightbend][1] formally Typesafe,   

internal download server http:172.16.0.20 and code is hosted on github.org/ironfish  
[presentation slide][2], a [2-days workshop was presented in OSCON2015][3]

### what is Reactive?
* distribute system
* [peppered moth][4]->moth's programming <- environment changes which demand adjustment. This is same as "Survival of the fittest".
* point2point, fire and forget, be able to react to environment changes on-the-fly -> react to load, to failure, to users, **Reactive Application**
* www.reactive manifesto.org, 
* Principles
	* responsiveness - always, whether is ok or failure
		* responsive to user
	* message-driven - loosely couple, no rpc, at high volume, REST will breakdown. 
		* asynchronous, not affected by the message progpagation
	* resilient - self healing, response and recover from failure
		* failure is expected, no hot spot.
	* elastic - rebalance, up and down,    
		* reactive to load, monitoring, and response. Some event are pre-determined, others unpredictable.
		
### Distributed Computing  
**paradigm shift**  

* 30-40 years ago, Google and Amazon do not exist. IBM was the industry. Mainframes used centralized computeing model.   
* Cloud Computing is another paradigm shift, which focus on economics. **software is business**.  
* Fast (not big) fishs eat slow fishs.   

### AKKA is Reactive
* Message Driven: elastice, resilient responsiveness  
* Elastic: responsive to varying workload  
* Resilient: system stays responisve in the face of failure  
* Responsive in timely manner  

Value: Native distributed  
 
* Single Unified Programming   
* Simpler concurrency  
* Simpler distribution   
* Simpler fault tolerance  

Distributed leads -> No-deterministic   
Actor model (processing = behavior, storage = state)      
review message pattern slide later, from messaging/mailbox/dequeue

Actor may have mutable state:  

* AKKA takes care of memory consisteccy
* Don't share mutalbe state
* actors exclusively communicate with message
* Message must be immutable.  
	
AKKA does not use any global state.   
AKKA system is like unix file structure, system plus multiple users

* for Java, actor is actor system.    
* for Scala, actor is in companion system.     

Follow codes in slides:  
 
* creating an Actor: create props first.     
* communiction: "this.coffeeHose.tell"    
* scala has case class helps message creation.  

Context:   

* each actor has a context

## Cloud Native Java 
Kenny Bastani (Pivotal), very knowledgeable person; he is co-authoring a book with Josh for O'reilly.  
[Lab instruction][5]   
**use 12 Factors as part of design pattern for microservice**

* Evolution:
Monolithic architecture -> Service-oriented architecture -> microservice architecture -> cloud-native application architecture (many small apps deployment using cloud platform)

* part of component is hard to scale
* SOA still has bottleneck
* Microservice: each app has its own database, problem needs to share info

We have data service, split out user service.
* For microservice integration, 
	* HTTP REST: HATEOAS
	* Bus/AMQP message (can broadcast, transaction) see Richardson Maturity Model

* Lab
	* preparation: learn intellij and Spring Boot 
	* [Spring Initializr][6]
	* follow [josh's workshop video][7] and [code][8]

* Spring Cloud
	* servie discovery
	* API gateway
	* config server
	* circuit breakers
	* distributed tracing like developer tool in Chrome.

* Two of 12-Factor Application Deployment 
	* one code base for all deployment
	* configuration is part of environment

* The Config Server
	* workflow: Spring Initializer -> generate code -> annotate -> run
	* see part-3 of lab instruction  
	
	**He talks too fast, only 1 out 80+ students can keep up with him, skip rest of it, use video as reference later**

* Service Registration and Discovery

* Edge Services: API gateways (circuit breakers, client-side load balancing)  

* To the Cloud!

## TensorFlow
Julia Ferraioli (Google), Amy Unruh (Google), Eli Bixby (Google)   
[syllabus][12], [preparation][9], [slide], [repo][]
The session is recorded. The presenters and supporting team are weak.

* flow: take data, go thru algorithm, gain insight
* eval() to get output, needs within the context of session, ???whether it will cache???
* view operation slides to get general functions

### lab 
* [exercise-1 modify the graph][13]  [answer-exercise-1][14], python tf_matrix_mu_add.py
"tf.add" is matrix add, only works for two compatible tf matrix.
* [exercise-2 word2vec][15], word embeddings, 
	* count based
	* predictive
* calculate Noise-contrastive estimation (NCE) loss
	* coutinuous Beg-ofWords (COBW), 
	* skip-gram: predicts words from source
	
	Get context from neighbor text. <- unsupervised learning
	
* [exercise-2 word2vec][15]
how to start a tensor board port 6006

* Convolutional for text fitting
A sliding filter for detecting edge.
Feature extraction using convolution
connecting one neural multiple times.

* [distributed TensorFlow][18]   
code: OBPN-RJXW-B4VT-0F97   
introduce different types of parallelize, similar to run docker
docker (red), POTS (blue), service (yellow)

dataflow and [beam in Apache][19] (more abstract) vs tensorflow.

## Data Exploration with R
[syllabus][11], [exercise][10]

R is language thinks about data first, either functional, nor object oriented

* R Ecosystem
* Datasets

Support, see
* Cran Project cran.r-project.org
* Quick-r
* r-bloggers
* cookbook for R
* [awesome][24]

<- is same as =, with global meaning   
Everything is vector.   
default csv reading is header exist.   

* plot
[basic graphs][25]   

* Read data json
sapply or lapply    

install package first - install.packages("rjson")   
library("rjson")   
from("rjsonText")   

## Keynotes

### Incremental Revolution
Siman from Docker

Open = inclusive, help each other, share.   
	* tools for mass innovation    
	* programmable Internet: program all of them at the same time
	* Docker is building a stack of tools to program internet
	* docker has 50+ repo, 2000+ contributor, 18000 github issue, 1200+ patch per month,   
	* learned
		* no is temporary, you can change your mind later. yes is forever.   
		* open source is good for challengers:   
		* it is a David's slingshot, what you aim for is up to you.  

* problems of Docker on Mac:  

	* to complicated to install
	* file sharing does not work
	* network
	* virtualbox is buggy

	**Check Open Container**

* How -> make it seamless

unikernel 
Open source 
hyperkit
vpnkit
datakit

###  IBM
vp of cloud and technology
Angel Dias

understand the past, live in present, foresee future

cloud, cognitive, mobile, iot, data and analytics, 
building using and fixing at same time

evolve or die

today: cloud, openstack, [cncf][27]
unikernel
cloud interoperatable

security

programming and api, -> art,

hyperledger,
OpenWhisk-serverless without boundaries
how to start open source practise in corporate, set target
build a heatmap
act like a start up scale to the enterprise

ibm.com/devops/method
Master the art of computer science


Univ of Florida,
Kyla McMullen, **selling herself too much!! no message to gain from her talk** 


nice to newbie
wear your pride
find your tribe,
mentor someone different
minor makes our different, major thing we are the same.

==
Sanqi Li, Hauwei
very good slide

ict cloud transformation
device IoT gateway,
- network sdn, nfv, 
- cloud
- service (open developer ecosystem, open collaborative and sharing)

Hauwai (contribution is major opensource project, )
open forum, leverage the open 
open telecom cloud with Deutch 

cloudify 
software company 
surrending city

individual contributor, 

Cloud Foundry, sam Ramji
-> positive sum game, open sources
violent competition
collateral damage
minimize this

ethics, community are defined by
what kind of community
commitment doctor Hippocrates oath included in
should have different opiions, whole and open ecosystem 
co-develop standard interface
lights, socket is standard

oci image, container
cni kubernetes, and cloud foundary
storage docker volume plugin,
service broker api cloud foundary, cncf

11:45 uniKernel


unreable effectiveness of open
Hanney's voorwerp

sloan digital sky survery
sql 
open data - citizen science
crowdsourcing the universe
galaxy zoo

not a spectator
sport anymore

open source medicine

share the possible cure of cancer

cell slider, play to cure,
revers the odds, impossible line, trailblazer

decoding brain signals, competition
search "decoding brain signals"
mind reading, open ML

cloud amplifieds open

open data, science, source, cloud , completion,
unreasonably open

### Go Unikernel
Ian Eyberg from [DeferPanic][28]

cross-compile existing applications down into small light weight application??
single address and single space

why did virtualization win?
containerization is different? is not virtualization.

it - systems admin - devops - sre
don't code, devops code, probably codes
should ithis even exist? not
what is config mgmt really? mechnical turk -> serverless framework
IoT, we need server, --
400 million new server by 2020

new paradim
config software not system

unikernel spectrum
posix
	osv
	rump kernel
language specific
	mirage, ....
domain specific
	clickos


clive, pooka, <- research this

netbsd

import "syscall"
import "liquor"

stuck at 1.5

build tag, auto-generated, 

from multi-address to single address

memory "protection" a.k.a 40% performance tax
goroutines - threading
testing is hard, 

go
dynamic libraries
single address,
single statically compiled 
no fork
sudo apt-got gorump

future
- no confidence on merging
- deferpanic.net
- rumpkernel.org
- github

need 
kvm 

fix black mac, 


### Unikernels and Docker:
Richard From Revolution 
to Evolution

Next Trillion CPUs -> Trillion Problems
- inherit exist system issues
- no profession magmt
- connected to netwrok

Must to intrinsically robust, New Devices, old software

### get his slide study it

Derbian 5 has 65 million line
linux 25million code

no fat kernel 

retarget tool chain to different platform
benefit - reduced attack surface
reduce resource use
prdicatable scheduling

OCaml, or Go, Haskell, javascript

try unikernel with docker
raspberry pi

Unikernels steps remain
- management, life cycle mgmt
- deployment, cloud, image mag
- ease of build

github.com/docker/hyperkit, vpnkit, datakit

cloud9, everything is file 
att lab

everything is a library

get r-tutorial notebook
get python-tutorial notebook
learning Flink syntax


<Links>
[1]:http://www.lightbend.com/
[2]:https://github.com/ironfish/presentations
[3]:https://github.com/ironfish/reactive-restaurant-student
[4]:https://en.wikipedia.org/wiki/Peppered_moth_evolution
[5]:https://github.com/joshlong/cloud-native-workshop
[6]:http://start.spring.io/
[7]:https://www.youtube.com/watch?v=fxB0tVnAi0I
[8]:https://github.com/joshlong/cloud-native-workshop
[9]:https://gist.github.com/amygdala/7a5d8f9fcb0a27ddf2fea3ed6a3696fb
[10]:https://github.com/BasiaFusinska/RDataAnalysis
[11]:http://conferences.oreilly.com/oscon/open-source-us/public/schedule/detail/48804
[12]:http://conferences.oreilly.com/oscon/open-source-us/public/schedule/detail/48997
[13]:https://github.com/amygdala/tensorflow-workshop/tree/master/workshop_sections/starter_tf_graph
[14]:https://github.com/amygdala/tensorflow-workshop/blob/master/workshop_sections/starter_tf_graph/tf_matrix_mul_add.py
[15]:https://github.com/amygdala/tensorflow-workshop/tree/master/workshop_sections/intro_word2vec
[16]:http://colah.github.io/posts/2014-07-Conv-Nets-Modular/
[17]:colah.github.io/posts/2014-07-Conv-Nets_Modular
[18]:bit.ly/tensorflow-k8s
[19]:http://beam.incubator.apache.org/
[20]:https://archive.ics.uci.edu/ml/datasets.html
[21]:oreillymedia/doing_data_science
[22]:https://www.kaggle.com/
[23]:http://archive.ics.uci.edu/ml/datasets.html
[24]:https://github.com/qinwf/awesome-R
[25]:http://www.harding.edu/fmccown/r/
[26]:https://github.com/amygdala/tensorflow-workshop
[27]:https://cncf.io/
[28]:https://deferpanic.net/
[29]:






