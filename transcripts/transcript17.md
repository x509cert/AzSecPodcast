# Episode 17. Recorded November 25th, 2020 with Gary Buckmaster - Azure Datacenters

## Intro

Welcome to the Azure Security Podcast where we discuss topics relating to security, privacy, reliability and compliance on the Microsoft Cloud platform.

## Audio

**Michael**: Hello everybody, welcome to episode #17. This week it's just Sarah and I marking gladysr off this week because of the US Thanksgiving. We also have a special guest this week we have Gary Buckmaster going to talk to us about Azure data Centers but before we get to Gary, Sarah, what do we have in the news?

**Sarah**: Well, yeah, it's a pretty light newsweek this week. It's post ignite and it's Thanksgiving. But there's one thing that caught my eye, which is again, one of my favorite things. We have Azure monitor an now we have a health feature in Azure monitor for VM. So essentially it's a feature that will monitor the health of virtual machines and if any parameters Healthwise in your virtual machine that's being monitored is outside an acceptable or normal range.

It will actually fire you an alert off. Now that's something that you could have done before. Uh, in your machine, but now it's actually. It's now actually all built in a nice and configurable. So much easier and that is all I have this week.

**Michael**: Yeah I have a couple of interesting points. The first one is we made an announcement that we have committed to work with Intel on some of the next generation of confidential computing. 

We spoke some weeks ago to Aeva Black about the Confidential Computing initiative on Azure, and this is just taking it to the next level. So we're working really closely with Intel, primarily on the software guard extensions. There will be an update to all of this stuff available next year. This will unlock many, many more confidential computing scenarios for our customers. We already have someone available today in the likes of say SQL Server in I as we also have the ability to run containers.

Inside of what are called secure enclaves, and we also have the Open Enclave SDK. You can use specific kinds of virtual machines to build your own enclaves if you wish.

The other thing is, this is in preview, Azure Storage now has the ability to prevent shared keys. If you're not familiar, you can basically get to Azure Storage in two major ways, or the authorization you can use in two major ways. The first one is either using AAD, which is obviously authentication and authorization, and then the other one is by using a shared key. Some customers, don't like the idea of a shared key, so there's the ability to now to enforce the ability to not use shared keys at all as well. 

Another item that I notice I was reading through some of the confidential computing work we haven't really talked much about this, but a critical part of confidential computing is being able to verify that the Secure Enclave is actually the authentic Secure enclave and not a rogue, and we do that through the Azure Attestation service that's in preview right now.

It's kind of bespoke, but if you're building your own secure enclave using the Open Enclave SDK or you're using, say, secure SQL Server or using some of the other services that will come onstream you need to use an active station server and so that's a service that we have now available in Azure as well.

And the last point I want to bring up. Is that we now have Terraform support for Azure Firewall, so you can actually deploy an Azure firewall policy using Terraform. There are still a couple of areaswhere Terraform doesn't support everything that ARM templates do, but thankfully it looks like Hashicorp are filling that gap substantially.

**Michael**: So with that, let's change tax and let's turn attention to Gary, who's going to talk to us about Azure data centers. So Gary, why don't you spend a moment to introduce yourself, how long you been at Microsoft, and what you do?

**Gary**: Yeah, thanks; so I've been with Microsoft now for almost three years and prior to that I in fact I joined Microsoft while I was still living in Singapore and so I've had a lot of opportunity to travel for Microsoft, going to various countries and talking about Azure. Prior to that I was technical sales lead for the company that IBM bought and turned into IBM Cloud. So company that some of you may remember called SoftLayer. So I've spent a lot of time in and around big enterprise data Centers for quite awhile when I moved back to Australia, I joined an institution that we call the Microsoft Technology Centre and there's like 45 of these around the world and this is a place where we bring customers to do really deep technical engagements around anything to do with Microsoft technology. So it could be Azure. It could be Office 365, it could be power apps, it could be some combination thereof and will sit down with them, figure out what it is that they're trying to solve.

**Gary**: Or we have all the toys in the toy box, so I've got Azure stacks. I've got Holo lens is we've got every single Microsoft device here and we can create whatever the scenario is that the customer is trying to solve for and then we could rapid prototype, do some hands on hacking and ultimately hopefully deliver the outcome that they're looking for, so that then they can take it off and turn it into some sort of a production type deployment.

**Sarah**: Cool.

Wow, Gary, I've got here in my notes, "explain what a data center is!" Now I'm going to assume that quite a lot of people listening probably have an idea what a data center is, but maybe we should talk about data centers in cloud and cloud providers and how they're different.

**Gary**: Yeah, no, it is a good question Ann. I guess the conversation really changes depending on what kind of a data center we're talking about. 'cause in my career I started with like the first data center that I was looking after was quite literally a closet inside of an office that had a few AV cable racks and a bunch of old HP servers that were bolted into it. And then almost every job after that. The scale of the data center that I was looking after changed by an order of magnitude so it was really.

**Gary**: By opening when I you know started at software and we're talking about a pod that's like sort of two megawatts and 150 racks of servers. And that's one pod, and there's four per data center. And then coming and working in Azure and walking into an Azure data center, which was at that time it was one of the Singapore data centers, and it was ten stories tall. Anet had capacity for somewhere between 1:50 and 200,000 physical servers, and it was 72 megawatts. And that was one of the data centers.

**Gary**: That we operated on the island that I realized that everything that I had seen prior to that was a different animal, and it's not to say that everything that I'd seen prior to that was not as good. We were talking about a completely fundamentally different technology proposition when we're talking about a hyperscale data center.

**Sarah**: Yeah, that sounds a significantly significantly bigger, 'cause I also might. First job was working in a data center, but it was a lot smaller than that. It was just one floor in the UK.

**Sarah**: And yeah, a heck of a lot smaller and are there any other things that you would say are big differences between these hyper scale data centers and what a lot of people would traditionally associated with the datacenter aside from the scale?

**Gary**: Yeah.

**Gary**: It's been really on the front foot about is talking about energy efficiency and power usage and water usage when you're running these big hyperscale style data centers, there very power intensive. I mean they have.

**Gary**: They'll have the actual power substation right on the property, because that's the amount of power that they're drawing, and they need very reliable power. They use a lot of water for cooling, and that can potentially have a lot of impact on the environment and so designing the data Center for absolute efficiency to make sure that we're not wasting tons of power wasting tons of water as one of the design considerations and other one, is just when you go into an enterprise data center, you're going to have various sets of compute that you need to design for. So for instance.

**Gary**: I might be running in SAP HANA environment and there's going to be some specific compute that I need to stand that up for an. I'm going to have a power budget and I'm going to have some Rackspace budget that I need to accommodate for, but I also might have a really storage intensive workload and I need to have a couple of storage area network devices and those are going to have a power budget. Or I might have something that requires a lot of GPUs because I'm doing maybe some rendering or I'm doing a machine learning algorithm and so I'll have these little pockets of power that are allocated to one part of the data center Ann. I can't move them around.

**Gary**: And be flexible and then enterprise data center. Because I I'm tide to that particular workload. Whereas in a hyperscale facility you've got more homogeneous compute and you can move various services into and out of that compute based on demand based on end of life of hardware based on a lot of different things and that allows him to be a little bit more flexible with the design.

**Sarah**: That's really neat and how. How does that play into 'cause we talk a lot in Microsoft about all the different Azure regions that we talk about, the redundancy and of course traditional data center redundancy is just making sure you have some fairly physically separate locations, but when we talk about that on hyper scale on a global level, how does that work?

**Gary**: Yeah, no, it's it so there's there's three concepts that we use when we're describing a a data center environment for Azure, the 1st.

**Gary**: Terminology that we use is a geography origgio an more often than not. Now that is a country boundary, but for the purposes of discussion it just to be as inclusive as possible. A geography for us is basically going to be a data residency envelope, so it's going to be Australia for example, where there's going to be a data residency requirement around keeping certain types of data on shore at all times. But in the European Union, for example, we could have regions of data centers that are throughout the European Union, and they're going to respect the data, residency or data sovereignty requirements of the European Union so Geo is is the first one and then inside a Geo we will deploy one or more Azure regions and typically it's too Azure regions and a region is usually centered around a Metropolitan area like in Australia. It Sydney and Melbourne or the two. The two major public cloud regions an will have multiple data centers in that region that are used to deliver Azure services and so it's important to note that when we talk about an Azure region we're talking about multiple datacenters that sit inside that region to deliver Azure services.

**Gary**: And in some cases those are going to be multiple datacenters clustered on a single physical campus. But more often than not they are clusters of data centers that are geographically separated from each other inside of a latency envelope so that we can keep storage consistent, but they're separated enough that a localized instance like a power outage or a flood, or a fire or something like that is only going to impact one set of data centers and not the entire region.

**Sarah**: Nice thank you. Talk to you touching it a second ago. Um, these different sovereign clouds you mentioned the EU and of course we know GDPR is a huge thing for anyone who deals with EU citizens data. But can you talk a little bit more about these sovereign clouds and what they are?

**Gary**: Yeah, so there's Azure public Cloud and that's when you go on to the Azure portal and you sign up for a service and you can deploy into any of those regions and that number. By the way, changes almost on the daily. So we we just announced yesterday we announced Sweden is the latest region, so I think that brings us up to 67. We also have a couple of sovereign clouds and the one that most viewers or most listeners of the podcast here will be familiar with would be the United States Department of Defense.

**Gary**: Cluster of datacenters or regions that we supplied to the US government. But then there's also there's China and we have a set of Azure services that are delivered into China, but with respect to China's rules around how non Chinese companies can do business inside of China and then we have an additional sovereign cloud in Germany and there's some specific rules in Germany around how services like public cloud or delivered, and so there's a sovereign cloud environment that stood up in Germany that respects that particular set of rules.

**Michael**: So I have a question for you. So when I'm talking to customers and we're designing a system. Uh, invariably we talk about cryptographic defenses, and especially encryption of data at rest. So I take as an example, say SQL Server or say Azure storage and there's an option there to encrypt the data at rest.

**Michael**: And often when I'm talking to customers, I explain to them just be aware of what that is really trying to mitigate and what is there to mitigate is essentially a stall on hard drive is not there to mitigate an attacker coming in through the front door. Now if you are in the key to that, you can pull the key and the attacker just gets just get ciphertext.

**Michael**: But invariably when I say stolen hard drive or perhaps a hard drive that isn't destroyed when it fails in verbal, the customer will say well, well, hang on. So what happens to a hard drive when it fails? How do I know that my data is secure even though a data has been decided? Hard drive has been decommissioned and how do I notice someone isn't going to walk out the building with the hard drive?

**Gary**: Yeah, and that's such a good question and I I have very similar conversations with just about every customer who comes through the door and it partially comes from an enterprise and enterprise datacentre practice mindset, right? Having worked in enterprise data Centers for a long time, you know there's a set of security controls that you have to work through in order to get access to the data haul. Then once you're in the data Hall you can lay hands on servers. And yes, potentially you could pull hard, drive out and walk out the door with it.

**Gary**: And so if you're used to that enterprise mindset, you immediately map that into a public cloud environment. You think Oh well, hang on that risk exists. And So what are the controls that exist to mitigate that risk? And I need to be able to answer that question so.

**Gary**: There's a lot to unpack, an I guess the easy way to do that is, let's let's sort of paint a picture when somebody who is going to go into an Azure data center and there's only a very small portion of the Microsoft employee based that can actually go into any data center, even if you're cleared for access. Unless you have a specific reason to be there on that particular day, you don't go to the data center, you don't get on the property, so there's only the people who are cleared to have access to the data center an of that subset. There's only a subset of people who can actually go into the data halls.

**Gary**: Um, so let's assume that I have access. Let's assume that I work in the data center, 'cause the real risk is insider threat, right? So let's assume that I'm a datacenter technician, that I have a access to go into the data center in order for me to go into the data Hall, I have to go through metal detectors, and those metal detectors are man 24 by 7, 365 days, and they're looking for data bearing devices going into and out of the data Hall. There's very strong controls around actually putting hands on the compute.

**Gary**: Um, and there's a lot of monitoring around if you actually go and pull a drive out of a server, there's a process that we use where we monitor when that happens so.

**Gary**: In a normal enterprise data center.

**Gary**: You see a dead disk, for example. That's quite a critical incident. You need to go and replace that disk straight away, and so it becomes a process, and I've had to do this at 2:00 in the morning on Tuesday on a regular basis for my phone. I have had to go to the data center to go and replace dead disks.

**Gary**: If I'm a data center technician and I'm working in an enterprise data center, there's a subset of activities that I have to do is interrupt activities, and one of them is a storage device like a dead disk for example, that I need to go in and replace straight away because there's only so much redundancy that's there at Azure scale. We're talking about hundreds of thousands of physical disks in one data Hall, and so we have a lot of software that make sure that when one of those disks dies as they do.

**Gary**: Locate that data. When you put data into Azure, we immediately make 3 copies at minimum of that data and we spread that across multiple disks, multiple storage appliances throughout the Azure region, so there's a lot of physical redundancy that's in there, and then that redundancy is managed by software and so that means that when a disk dies in place, we leave it in place and we have a process around when we go and we reclaim those disks and how we deal with those disks and destroy them to ensure that.

**Gary**: Um number one that the data security requirements are kept in place, but also because it's very cost intensive. The requirements around how we go and we pull the disks out. How do we replace them? If we were to do that ad hoc it would be very expensive for us to do and be quite risky. So rather than going and replacing disks individually will actually go and call all of the disks at the same time. So one of the controls there is just that. In order to go and lay hands on the physical server in the first place.

**Gary**: It only happens at a time when we're reclaiming disks, and then there's a set of controls in place around.

**Gary**: That's done that there's multiple sets of eyes on how the disks are being pulled out, how they're being stored, how they're being taken through the data center, an ultimately how their shredded on site, and we do shredding onsite at every single one of the hundreds of data centers that we have around the world, so that by the time your data physically leaves that data center, it's in a physical form that simply can't be reclaimed. There's no way they're going to get the data off of it, so that's one set of controls, but then from a hyperscale perspective, there's another set of controls.

**Gary**: That's even probably more complicated.

**Gary**: When we're talking about three or more copies of data that's spread across multiple disks, we're actually talking about. Let's use a GB of data, for example. That GB of data is then broken into shards, and then those shards are spread across multiple disks, and there's three copies of each Shard. It would be nearly impossible for somebody who walks into an Azure data center to be able to look at a particular disk and say this disk contains the information that I'm.

**Gary**: Interested in that belongs to customer X and so this is the disk that I need to grab because of the actual scale of what we're talking about and how quickly data moves into and out of these devices. So there's there's the security controls that we have in place. And then there's also just the scale of a hyperscale data center facility trying to bring all of that together to go and find a particular bit of data that you're going after is beyond nontrivial. It's nearly impossible.

**Michael**: With the sheer number of hard drives that we have in in one specific Azure data center. You know, the even with a low percentage of failure that store a lot of hard drives. You know the old adage is a small percentage of a very large number is still a large number, so thanks for that. So just for the for the listeners out there.

**Michael**: I do a lot is compliance with customers, sort of building threat models for them for their applications.

**Michael**: I'm making sure that they have all the appropriate mitigations in place, including things like TDE - transparent data encryption.

**Michael**: But also, invariably, you know I'm looking at different programs. Let's talk about things like, well, you know, what are the physical protections on the datacenter water the HR policy's DLP policies around hiring and firing people? Well, there, obviously, outside of the scope of the application that we're designing, certainly outside of my scope. But the customer still has to worry about it because they need to prove to there.

**Michael**: Auditors that all the appropriate defenses and policies are in place and procedures in place.

**Michael**: And so, um, you know, oftentimes ends up being the customer has to look at SOC 1 and SOC 2 reports.

**Michael**: So for those of you who have building on Azure, you may be very familiar with, yeah, Responsibility model, which is some responsibilities lie with the customer or the tenant more accurately and some responsibilities lie with Azure itself and things like physical protections. As Gary alluded to, are really within the purview of the data centers themselves, so when it comes to building out the data that you need for a compliance program, you're probably going to have access to the SoC one and SoC 2 reports.

**Michael**: Those are available for all people who have an Azure subscription. There available in the trust portal. I'll put a link in the show notes, but yeah, if you're building out information to pass onto some auditors, you're probably going to want to have access to the SoC one and stop to reports.

**Sarah**: Yes, so um Gary, you've mentioned this to me before, but apparently you have been asked some pretty crazy questions about Azure data centers during your time doing tours. Other some of them that you can share with us. Or can you share your favorite one with us?

**Gary**: Yeah, so you mentioned and I should have mentioned this as part of my role with the Microsoft Technology Centre. Is that one of the things that we do and it's quite different from any other public cloud that I'm aware of is that we will actually take customers into some of our data centres and actually show them the facilities now in covid world. We obviously can't do that and so we've created a set of virtual experiences where we deliver a lot of that same content and we deliver it either behind closed doors and NDA type setting.

**Gary**: Or over  MS Teams for there's a lot of neat stuff that's in there, and some of it is some of the stuff that I just talked about. Some of it is things like for instance, some of the stuff that we're doing next round, datacenters like for example, we built a data center in a submarine tube and dropped it in the ocean and we ran it as a data center under the ocean for a year and a half. And so there's a lot of like future work that we're doing around datacenter technology. But yet doing doing actual tours of our data centres is one of the cooler things that I get to do.

**Gary**: And then, yeah, there's obviously a lot of questions in the team that I work on that does datacenter tours. We sort of keep a log of some of the most interesting questions that we get, and currently I think I'm still the record Holder for one of the most challenging questions that I was asked, and it was on a tour where I was showing some some instances of some of our data center sites and I think it was a picture of either Dublin or one of our Amsterdam campus is an the guy stopped me and he said, hey, 'Can you tell me where are the anti missile defense emplacements on the site?'

**Michael**: So Gary, one thing that we like to ask our guests as if you had one final point to make, what would it be?

**Gary**: So I'm going to be unbelievably rude and I'm going to take two if you don't mind. One of them. Is that the way that we approach public? Cloud is very different, so I'm talking largely about our big public cloud hyperscale datacenters. You know, these Big 32 and 64 MW bit barns that you can park Two 737 jet aircraft into and we've got bunches and lots of them. That's only one piece of the puzzle, and so we've started rolling out what we call.

**Gary**: Assistant security model Anna compliance model that's consistent for all of that environment. So when we're talking about digital transformation and what that looks like, it doesn't mean you need to go back a moving truck up to your data center. Unload all of your servers and drop him off inside Azure. You don't have to move everything into Azure Public Cloud in order to achieve what you're trying to get to. There's a much more nuanced approach, and then the other thing that I would say, and this is more of a plug if you are really interested in how we build datacenters, how we operate data centers.

**Gary**: What's coming next? Mark Russinovich, the CTO for Azure does a fantastic talk on inside Azure data centers, and there's there's going to be a link to it in the show notes and when he delivers this talk from Microsoft, it's standing room only and we're talking like multiple ballrooms inside of a hotel and everybody in Microsoft comes in watch. Is it because it's so fascinating? Some of the neat stuff that we're talking about what's coming next, and some of the demos that he does. A really fantastic so anyone who has an hour and a half free watch it because it's really, really engaging.

**Michael**: Hey thanks Gary. Thank you so much for joining us this week. No, I learned a few things. In fact, I think I learned about stuff I didn't know I didn't know clearly. Datacenter security is a critical component of our tenant security posture, and I urge all customers to take a look at the SoC one and SoC 2 reports as well, especially around the physical security that we that we have on our data centres. And also thanks to all of you for joining us this week. Stay safe and we'll see you next time.

## Outro

Thanks for listening to the Azure Security podcast. You can find show notes and other resources at our website <https://azsecuritypodcast.net>. If you have any questions, please find us on Twitter @azsecpod. Background music is from ccmixter.com and licensed under the Creative Commons license.
