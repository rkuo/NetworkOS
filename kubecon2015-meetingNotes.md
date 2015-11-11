# Kubecon 2015 meeting notes
rtk, 20151109 at SF

[schedule](https://kubecon.io/schedule/)

## Day 1 Keynote-Roadmap  
Brendan Burns, Google, roadmap   

* started one year before
* purpose of this project: 
	* to deploy apps easier, 
	* resilence to change, 
	* be able to handle scaling, 
	* no down time update
	
* v1.1 released today, features (iptable kube proxy, batch jobs, http load balancing, autoscaling, resource over commit). There is a ingress load balance.
	* Ingress object, Ingress Controller (GCE, HAProxy, ..)
	* Horizontal Pod Autoscaling, v1.0 (manual), v1.1 (auto scaling), create more pods. 
	* Job (new term) is inside of Kubernetes, from start to finish, we can define parallel tasks.
* The "flow" concept will be implemented in future.

	**See slides for json examples.**

New v1.1 Features:

* Memory Overcommit (Guaranteed, Burst, Best effort), use request and limit to define policy. 
* IPTable Proxy -> source address will be preserved, better performance.
* more kubectl commands
* Rolling update improvement, wait for a Pod to reach stable before move on

Future direction:  

* put the distribute control on the hand of app dev, for example, 

Plan for v1.2  

* pre-built applications
* Deis annouces Helm, github.com/deis/helm
* manage multiple clusters, openUX
* simplify config, simple config -> kubenetes object

## Go, Build it on a Cluster  
Even Brown, Google

**Discovery & Operation**

* farmer creates --> multiple buildlet 
* Discovery, google.defaultclient
* find out jq command.
* Use kubectl exec to get into container,
* Use kubectl proxy, to get into API master, use curl and swagger

**Efficiency & Hygiene**

* Use watch API to find out state
* Use context and ctxhttp especially with watch API

## Docker Swarm and Kubernetes
Sam Alba, Andrea Luzzardi, Docker  
Good slides, read them again. there are some sample codes <<-

* front end of many docker-machines, clustering, 
* scheduling  
* Swarm v1.0 released and production ready.
	* stateful via Volume
	* network micro-segmentation
	* any cloud provider, swarm as middle layer to support mesos, kubernetes,..
	* 30K container

* github.io/docker/swarm-frontends
* use Swarm to deploy to multiple providers

Swarm play the role as deployment manager.

## Rebasing onto Kubernetes  
Matt Butcher, Deis  
shifting from CoreOS toward Kubernetes  <<- this is to move abstraction higher

* Containerized PaaS
* objective: easy to use

Common components: controller, router, registry, logger, storage, builder on top of Docker,
coreos supports fleet, and etcd,

kubernetes replaces coreOS, reduces layers, and act as integrator

Lesson learned:   
 
* turtles all the way down
* Bartleby effect, Helm is package manager then use it like homebrew.
* key value to success -> use etcd
* docker is built one container in maid, kubernetes is designed with cluster in mind.
* the service is consumer

## Kubernetes on Mesos  
Karl Isenberg, Mesossphere

* Cloud Surfing 101 (survery landscape, stay high level, dive down when it needs, stay loose)
* Cloud Surfing 102 tool selection (no sighle tool, pick right tool for one job, prefer small, chain them together)
* Cloud Surfing 103, atomospheric layers

Demo

* There is a special version for Mesos and AWS
* UI is builtin
* find out what is Oinker 
* service and replication control yaml files can be combined as one file

* kubernetes manage: app service & job
* process and resource
* Mesos manage: frameworks

## Panel Discussion
5 people from Google
  
* realized the container will be the mainstream two years ago.
* they felt VM (Google Cloud Engine) is going to wrong direction
* orchestration (workflow), what if, automation is different, which covers more. Automation covers wider space, it is more in choreography or jazz, not all planned out.
* size of scalability needs to define its usefulness.
* SLA 99% API completes in 100ms
* Borg has too many features, too many api, very vertical integrated.
* Fun to work with outside, quality, faster feedback, volume and pr is bigger.
* open source is different from Google internal, more fun
* 40 contributors are work come from Google, 500 contributors, open source contributors are more honest too.
* Community knows where is going. 
* Do not want to be part of or become openstack, keep its identity. core needs to work everywhere,
* Identify the real problem, back track to the problem try to solve.
* no app is island, dynamic scheduling, need bridge between old and new technologies.   

## Cloud-native Development
Clayton Cleman, RedHat  

* Re-think PaaS for next generation
* OpenShift to build on top of Kube
* Enable org to use Kube
* Add app-dev workflow.

Ecosystem (run software on top of software)
Brook's Law

* there a large requirements for more users (Auth, user mgmet, ldap integration, ...)
* need to manage flows (rapid CI/CD)
	* source code -> build -> image -> deploy
	* Branch -> CI -> merge -> release
	* library -> integration -> promotion -> consume

Consider immutable

Openshift + Kubernetes
Openshift can run on Ubuntu

Demo - cakephp, 
Main message is to integrate the flows, condense steps

## Networking 
Eugene Yakubovich, CoreOS

* IP per Pod
* Pods in cluster can be addressed by their IP
* Need to work with provider's network abstraction

Options:
* Linux-bridge, macvlan, ipvlan, openvswitch, weave, flannel, project Calico

How to allocate IP address?  
- Fix block on a host,  
- dhcp, ..  

Mix match  
Order matters!

CNI (Container Network Interface)  

* container can join multiple networks  
* interface is described by Json

rkt natively support CNI, which different from docker

## Dark Art of Kubernetes 
Gianluca Borello, sysDig 			<< very good

* Kubernetes UI
* cAdvisor
* Heapster
* Kubedash
* Grafana
* ...

sysdig cloud << learn to use this tool, important but not first priority.
sysdig is different product.

## Kubernetes at eBay
eBay

* 1/2 million+ compute cores, 150k compute servier

* Why Kubenetes: 
	* opensource, 
	* container based runtime, 
	* declarative, 
	* app centric abstraction, 
	* watchable, 
	* updateable central state store,
	* well defined cloud provider and infrastructure plugin model, 
	* support various IaaS, e.g. openstack
	* large supportive community

Simplify the model (provision, deploy, monitoring remediy -> run)


## Policy
Apcera  		<< good slide get it and read it again

Policy for:   

* utilization, configuration regularitry, securing,  
* different cloud provider offers different security options.

It will be nice 

* Need to be available everywhere, pervasive
	* cup, memory,.. 
	* workload to workload connections: per port,not per container
	* ingress/Egress
	* External connectivity and routing
Explicit
automatic enforaced

Policy structure

* language
* namespace
* hirecheay

apply poslicy as close to the leaves in your namespace as policy
Apcera supports multi-cloud.

## Build big data beast on Kubernetes
Joe Dlokner, Pachyderm

* Distributed systems are hard
* copy on write, similar to Spark RDD
* git for huge data setes -> just get delta
* pipeline system - data-aware container scheduler
* incremental process to improve 

This one overlapped with many other open source packages, investigate more before use.


## Day 1 Closing Keynote, Federation of Kubernetes Clusters (Ubernetes)
Quinton Hoole, Google

* containers on different cloud providers
* Reason: 
	* high availability, 
	* application migration, 
	* policy enforcement, 
	* vendor lock-in avoidance
	* capacity overflow (utilization, cost, peformance)
* problem remains to be solved:
	* cross-cluster load balance
	* data aggregation
	* location affinity (strictly coupled, lossely couple, prefernentially coupled)
	* monitoring and auditing
* roadmap
	* lite (multiple zone) in alpha 4Q2015
	* proper (multiple cluster, federatied) Q12016
	* Google Container Engine 2Q2016 
	
	search ubernetesv2 for links 
	 
## Day 2 Keynote - Operation Dividends
Joe Beda, former Google << so so presentation, tried to theorize a common sense without proposed solution.

#### Dev

* Microservices
	* break an app to many blocks and allow individual development, allows byte code to be inject into production
	* SOA, 
	* Architecture boundaries, well defined interfaces.Hide language binding behind services, to gain velocity and responsibility
	* balance between micro and pico
	* scaling your organization, two pizza and conway's law
	* Mythical Person Month
* sharing 
	* shared artifact, private instance, template
	* shared instance
	* Big-S service
* Service Network

#### Ops

* Site reliability engineer (SRE) vs Ops 
* SRE-improve operation with tools, 2am calls

OS Ops (CoreOS, RancherOS,...), Cluster Ops (kubernetes,..), App Ops (bridge between Ops and App)

## Kubernetes Scaling
Bob Wise, Samsung SDS << **bad**, superficial, waste everyone's time

Goal:
* 1k nodes, 100 pods/sec, 99% api call in 1 sec, aws, gce and bare metal.

## Moving to Kubernetes
Tobias Schmdit, soundcloud

* Problem to solve: scale, inconsistent state, cumbersome new app setup, 
* Bazooka - home made tool for deployment, follow 12 factor applications. agent on every node, consensus store. quick deployment/rollback/scaling, orchestration is not in the critical path.
* learned: use a common integration service, choose right data store, resource isolation is important, automate everything, json, CI/CD from day 1, 
* why move: does not fit anymore, problem is too big for us alone, 
* why kubernetes: 
	* simmple domain objects (container, pod, service, rc), 
	* powerful networking (security, auditing, performance), 
	* pod scheduling, 
	* label system (grouping, discoverablility, resource contraints), 
	* commuity + support
* future: logging, and monitoring and alternative 

## Migrate from home grown 'cluster' to Kubernetes
Yuvi Panda, Wikimedia Foundation  

* Wikimedia tool lab, PaaS, 1300 tools/bots, free, http://tools.wmflabs.org/hay/directory/ 

Solution should 
* not require users who do not want to change to change.
* allows people to use modern tools
* allows people to use new features
* Have a upstream to help us to fix problems.
* interOp with current setup and can rollback
* less on fire all the time

#### Backwards compatibility Layer

* pre-build docker image that match current gridengine exec nodes
* Shim our werapper around the gridengine commend to call kubernetes instead

#### Workflow

* ssh to bastion host
* write code on nfs in a welll know localtion
* use our warpper commend to manulpulate jobs
* Allow direct access k8s API  (a token, a quota and free roam)

## Framework-Agnostic Discovery
Tim Gross, Joyent << few good tips to learn from, there are scripts in slides, work with consul

* single or multiple process container
* first class citizen in network
* not to manage VM
* Treat DC as a single Docker host

* human and machine readable doc
* fix dependency issue
* interface base
* NAT kill network performance, one solution -> DNS 
* Push network solution to application: registration, self-introspect, looking for change, response to change,
* Application-aware health check

ContainerBuddy: registration to consul on startup, self defined health check

Not dependent on orchestration.

## Panel Discussion

* mass innovation in progress, 
* merge Google app engine and cloud compute -> container and kubernetes
* reduce rigidity of technology 
* PaaS evolve into a composible component, make orchestration transparent.
* some people likes control, it may stay. flexibility is key.
* redefine PaaS, formalize interface with code, deployment, services
* what are the oppinions need to relax or to enforce -> allow flexiblity to connect,  operational specialization. centralized policy with local override.  

## Stupid Ideas for Many Computers
Aja Hammerly, Google  <<crazy, not everyone works in Google, has computing resource to waste, statement complete fall apart. **snub!** Make sure I do not it.

* sentiment analysis: hard to use words only, Emoji, is not deterministic << consider fuzzy logic
* Linda (distribute Tuple)
* design pattern: fetcher -> analysis -> reducer

to solve Latin square  
which is created by Eular  
use --> use Seive (prime number)  

## Hoverboard, Jetpacks, Cluster and Flux Capacitors
Connor Doyle, .. Intel

First wave: public cloud 
    
* Amazon, MS, Google, ..: use image, Serices, cost is correlated to fine gramin allocation.
Second wave: private cloud
* Facebook, Apple, Twitter
* Computing can float
* Form factor is different this time

-> hybrid cloud 

#### Predication
* cloud computing will be commodity
* Grid computer return
* Declarative config won't be enough by itself, conflict in multi-diamension, need communication between layers

allows interface to involve

## Lithium Journey to Microservices
Lachlan Evenson, Lithium

Demo Video record, 
day-1-openstack

Networking is major hurdle. 

* out of the box networking does not work
* not just Kubernetes, we have other things
* we are not in green field

### Challenge  
* Security
* Multi-tenancy
* Scalable
* Reduncent
* Auditing
* Compliance

OpenContrail answered the call  

* no extra knowgs or buttons
* Network polocy defined by kubernetes manifest
* Updatreaming network chage
* Thriving communit

### Wisdom  
* incremental implementation
* do not get hung up on requirements
* get it out there and have your customers use it

look into slack.opencontrail.org, OpenContrail has chaining, subnet isolation.  
Load balance has public IP, possible FW too,   
Use deploy workflow (dev, staging, production, ..)  

## Kubernetes is for monoliths too
Steve Reed, 

* Pods and Services are the interface between your infrastructure and application
* Containerize:
	* magaPod? Podolith?
		* sometimes, you just do not want to touch the code
		* dependencies are secified, enforced
	* Refactor
		* Database, SMTP
			* needs to scale indepenently
		* Hardcode stuff
			* Service host name are guaranteed
		* "services without selectors"
		* reverse proxy "adapter" container
		* pgpool to postgres
		* "sematic pipelines"
		* secrets for certs, auth credentials
		* default ports
		* replace crond with sidecars, jobs
	* Volume mounts where possible
		 
## Continuously Delievery Microservice in Kubernetes 
Sandeep Parikh, Google

* CI, fail fast and early
	* Jenkin, circleci, Teamcity, Bamboo
* start kubernetes then Jenkin
* Microservices
* Workflow, package push create service  <<good slides, read it again, Jenkin code

## Unleashing K8S to reduce complexity of middleware Platform
Afkham Azeez, WSO2

* core components on osgi,
* Multitenancy: user management, data isolation, Execution isolation
* Shared process multitenency in Carbon

health monitoring (tcp socker, container exec, http)
secret sharing: into container
user management (in progress, LDAP)

Microservie server (MSS) has high thru-put

## Kubernetes on AWS
Daniel Nelson, vungle

* Docker Dev environment, 
* Production still a pile of Chef
* Moving to SOA architecture
* More services, more services

Goal:
prod uses same docker images as dev/QA
easy to add/remove machine

for OS:
Minimal, simple update, community (CoreOS, Racher OS)

for cluster:
mesos, fleet, docker Swarm, amazon ECS, kubernetes

Learned:  
* can not use kube-up.sh   
* can not use ELB   
* CloudFormation template get big    
* Use Nginx for load balance   
* Assume machine will go down  
* Allow users to manage AWS resource better to save $.


## Closing Keynotes
Kelsey Hightower, Google  <<very good, learn from him

* Kubernete is an open source project and community focused on improving application infrastructure
* No competition so far.
* is an artifact of experience that can use to create your own.

## Day 3 Hackathon

### Fabric8  
[presentation slides](http://christianposta.com/slides/kubecon/generated/talk.html#/cover)

* focus on services, what effects the deliver the services?
* Balance efficiency and flexibility
* organization needs to be structured to deliver the service

#### What are microservices
* single, self contained, ...
* domain driven, distributed

Organization

* autonomous, self-directed team
* Transparency
* Small in size

Domain Driven Design

* Establish domain language
* Understanding the links between domain system
* Developing a model (conceptual, implementation, feedback)
* Boundaries
* abstraction

Distributed Systems

* network is unreliable
* Design time coupling
* Unintented, run-time binding
* ...

Challenge

* Lock of tooling,
* complexity
* mult database, transcation
* when use it 
* org mis-match
...

Platforem is like shopping mall, which has basic structure and utilities, to host various stores.

### OpenShift v3, developer platform

* developer focused workflow
* source 2 image builds
* build and deploye as first-class citizen
* SDN
* Docker native format/packaging, run
* CLI/Web based tooling
* authentication, LDAP,

#### Platform for microservices

* service discovery
* configuration
* immutable infrastructure
* CI/CD build promotion
* API management
* logging, metrics
* Chaos monkey

### Fabric8.io
* osgi can co-exist with Docker/Kubernetes.
* nicer visualizations of kubernetes via web console
* built-in chaos monkeys
* prepackaged apps (1 click CI/CD, API, logging)

learn to use ohawt.io << general web io for many apps

There is a Docker maven plugin to assist the build, watch, apply,...

gogs:
gogsadmin	
RedHat$1
gogsadmin@fabric8.local


## Vendors
Questions for:

- CoreOS, find out how to how to kill/restart a node - Done
- Redhat, find out jBoss training about Fuse - Done
- Mesos, talk to Karl about self-healing, why both - Done
- Sysdig, review their demo to speedup learning - Done
- jBoss - Done 
- OpenContrail workshop - Done