# Episode 8 [Recorded August 5th, 2020 with Randy Johnson - Azure Network Isolation]

## Intro

Welcome to the Azure Security podcast where we discuss topics relating to security, privacy, reliability and compliance on the Microsoft Cloud platform.

## Michael

Hey, welcome to Episode #8. We have the gang here this week. We also have a special guest, Randy Campbell to talk to us about network isolation and private endpoints in Azure. But before that let's go to the news. Sarah, what we got?

## Sarah

I've got a couple of things this week to talk about. Firstly, in preview is OpenID Connect support for Azure App Services and Functions. So that means if you're using an OpenID Connect provider for authentication, you can now integrate that into Azure App service and Azure Functions. If you don't want to use Azure AAD (Azure Active Directory) I would ask you why you don't want to use Azure AD 'cause it's great but for some reason you need to use another OpenID Connect provider, you can now do that which is really cool.

Next I'm going back to my favorite 'cause we always have things to talk about in this space. We're talking about Azure Kubernetes Service (AKS) and now you can get secure AKS pods using policy. So it means that like Azure Policy in the rest of Azure.

You can actually deny on audit requests into a pod, so the 16 in-built options you can with those particular settings, you can either put them on audit or you can put them on deny so you can really really lock down the security of the pod and actually what happens within that pod. Because it's always about AKS with me as well. You can also now get managed Azure AD support that's generally available in AKS, which means you don't have to create client apps or service apps. It's all managed for you, so again, just making AK S well doing the right thing authentication-wise with AKS. Way, way easier which is again, I sound like a broken record, but very cool. And they're all my news bits this week.

## Gladys

The first one I selected for this week is related to Azure Monitor extending their support to containers.

Azure Monitor is now able to monitor containers' CPU, memory, disk usage and many others; in terms of security this provide another opportunity to detect security issues since they often cause performance impact.

This give us the opportunity to correlate those performance indicators with information from services like Azure Security Center, Sentinel, Defender ATP etc.

The next news that I'm really excited about is that Microsoft is launching a tech community page for Microsoft threat protection.

In previous podcasts, you may have heard me talking about the ability that our services have to interconnect and interoperate with other Microsoft Services and 3rd-party vendors, and that this provide protection at the door an enable the infrastructure necessary for strategies like Zero-trust, security, orchestration, automation and response, or SOAR.

Before going further, I want to come in to explain what I mean with "provide protection at the door" since I've been asked that question before.

When users and processes are authenticated and get authorized to perform some task only the information available to the identity provider is what is used to make the authentication and authorization decisions.

But what about if the entity provider had a way to get more information than what is stored in the directory itself. Basically by interconnecting data from other services could be available to be utilized to determine how risky a connection may be and then used as part of the authentication/authorization process.

In other words, it allows data to be available in almost real time. Hence this is what I mean when I said "it allows protection at the door." So going back to Microsoft threat protection, it builds upon our interconnection and inter-operation services story by allowing the aggregation of signals gathered by the different threat protection services into a single pane of glass.

Microsoft threat protection, or MTP, has an incident tab that shows a list of detection, so detected incidents and includes a summary of the extent of the impact caused by the incident in the environment. For example, if you see a credential theft, make sure the users that device is the data that was impacted throughout the environment and that information will come from the different services such as Azure advanced threat protection, or Azure ATP, Microsoft Defender ATP, Microsoft Cloud app security or EMCAS and others. In addition, the NTP Action Center has the capability to allowing that information to the Mitre attack framework.

Enable this because I have seen customers that own certain services and they don't have it enabled. 

The other cool thing about MTP is that it helps streamline the time to acknowledge and remediate incidents. Since now you have all the information centralized and more automation can be used to deal with all the attacks that are commonly seen in the environment. 

The last thing I want to talk about is this cool skilling initiative that Microsoft has put together to help people get the financial fluency needed in this day and age!

This is especially important now that people have lost their jobs due to the to COVID-19 financial impact and the more jobs required technology related skills. As part of this initiative Microsoft has enabled many LinkedIn training and there are available for free through March 2021. Also, Microsoft certification exams are being provided at a cost of $15.00.

Some of the role paths included through the training and the certification is data analyst, IT support, IT administrator and others. So if you guys are interested, please visit <https://aka.ms/jobseeker>.

## Mark

So a couple of Azure related things caught my eye this week. The first one I thought was really cool. Kind of just geeking out on non Azure topics, but Microsoft's really focused on kind of getting to zero waste and so we did. Some pilot programs. Can we take all the stuff that comes out of our data centers and you know find another use for it. So I thought this was pretty neat so got a little article there for folks to check out. The other thing that drop that's somewhat related to Azure is the windows baselines.

Actually, just recently released for the latest versions of Windows Server and Windows 10 and a couple of interesting things in there. Some adjustments to the new password length controls. Keep in mind that we really are pushing for passwordless future, but we recognize that there is an interim state of having to strengthen what you can do on the password side, but it's not necessarily always, you know passwords that you have to change all the time. You know if it's not changing, excuse me if it's not been compromised, we don't want to change it, but strong longer passwords can be stronger.

So a couple of different weeks and tuning in there let you let you all kind of read through that in the Azure world. I've been working a lot on the new version of the Azure security baselines. With that team and one of the things that we're really looking for feedback on. Very interested and find me on LinkedIn and Twitter is kind of how you're using Azure baselines and benchmarks. If you are already and any anything that we can do to improve it, Annie scenarios where it's where you know. Hey, this is helpful, but it's been really hard to apply these.

Settings recommendations. Really looking to kind of tweak and refine that. We've gotten really good solid feedback from customers, but always looking for how do we tune it a little bit better so that we're giving the guidance that people can kind of just go with.
Another thing is we recently bought a company named Cyber X IoT, an operational technology security. So Internet of Things, an operational technology OT OT and really really cool technology. Amazing capabilities to give you operational insights, but much more important. Cybersecurity insights on are we dealing with vulnerable devices? Generally, yes. Are we seeing any active threats? Are we seeing you know attack? You know how do we link that together in a timeline? What are the?

As an attacker could get in to our io, TN OT environments, so really some amazing stuff there and we know this is going to be a big learning curve as organizations kind of converged their IoT and it in OT practice is so very interested. Also in feedback you know what are the kind of things that you would want, you know as an IT person or an OT person or IoT person with that kind of background.
You know what are the what are the things that you would be interested in learning, and as you kind of go on that journey to learn how all these things come together so very interested in that. And then last on Azure Security Center, Bunch of different cool enhancements. Gotta couple links in there. Feel first is some enhancements to Azure threat protection for Azure storage. For those who are not familiar with it. Essentially machine learning based rules heavily that identify when things are going weird. Anomalous, you know potential risk, alert type of things.
In your storage accounts that hey, these things shouldn't be happening. These users don't normally do this, etc, so there's some enhancements to those rules. Also, the adaptive application controls in Azure Security Center also got some new recommendations and wild card support, and for those of you that aren't familiar with what that is, again, machine learning based very heavily, essentially application allow-listing that is generated based on the actual behavior of the VMs in the processes on them to help you write those rules to make sure that you're allowing the right applications.

So very very cool technology.

## Michael


And a couple things sort of piqued my interest this week. The first one was the use of double key encryption for Microsoft 365. This applies to  labeling documents so that a second key can be applied to that document. So there's a key managed by Microsoft, and there's a key that's managed by the tenant. And the nice thing there is that you apply it to a specific sensitivity level and automatically the policy engine applies double key encryption. Really good to see this, a lot of customers asking for more control over the keys rather than just keys that are managed by Azure.

The other thing that piqued my interest was Azure Active Directory Registration Service will be ending support for TLS 1.0 and 1.1. For Government Cloud that will be in August and for the rest of the commercial cloud that will be in October. As you can see, just about every service in Azure is moving to either totally deprecating prior versions of TLS older than 1.2 or allowing you to at least configure TLS 1.0, 1.1 and 1.2.

Interesting thing happened to me this week that I want to share with you guys.  I've seen this kind of thing before.

Back in the day when I was working on the Microsoft Security Development Lifecycle, on the SDL, we had this rule, which was if we ran a security tool over some code, say static analysis tool. We wouldn't just hand the developers a list of all the warnings because you really need to triage those warnings first. And frankly, if you give a developer 250 warnings and five of them are serious and the rest are not, the developers going to lose any interest in even listening to you let alone any trust in that particular tool.

So I've always sort of live by that idea for many, many years and never hand a list of bugs to somebody to look at. 

But that kinda happened this week, actually, with a customer; it was really interesting. The customer approached me and asked me for my opinion on some bugs and essentially what happened was the customer security team had run a scanning tool against an AKS (Azure Kubernetes Service) installation and it was running Ubuntu 1604 LTS, the long term support, and they found some bugs. Some unfixed vulnerabilities, and I use the word vulnerabilities very loosely.

To be honest, we looking at the list. It looked pretty bad. You look like there's quite a few vulnerabilities in there, but on closer inspection they they really weren't. So one of them was actually rated what's called the CVSS - the common vulnerability scoring system, which goes on a range of 1 to 10, where one is low and ten is basically the slow heat-death of the universe; 10 is catastrophic, I mean 10 is "drop what you're doing and you need to go and fix this now". Well there was one bug in there that was against a set of tools called binutils and they were command line tools that was raised at 9.4 and this immediately set off alarm bells.

So I started looking at this issue and like this is in command line tools. How can this be in 9.4 in command-line tools? They require a human to run them, they don't run as root, they don't make network connections, they don't access sensitive data. How can this be a 9.4. I had a look at the actual bugs themselves and I probably gave him like a 4.5-ish, something like that. There's no way they were a 9.4, but they were holding up this customer from deploying AKS. I did a bit more digging around and I talked to Michael Withrow. So Michael was on our podcast, I think episode 2 talking about container security. I talked to Michael about it, to ask his opinion. He said one thing would be really careful is that sometimes the vendor of the operating system, in this case Ubuntu, they may not actually have a patch for that specific service, and sure enough, there was actually no patch for Ubuntu 1604, but there was a patch on 1804, but the customer was using 1604.

I then looked a little bit further found that RedHat actually disagreed with the 9.4 rating and rated at a 4.4 which is close to my 4.5 and their fix was we're not fixing this at all!

So the moral of the story is that if your in security and you run scanning tools, please don't hand your developers or deployment people a wall of bugs that have to be addressed. You really need to perform some kind of pre-analysis using your own security expertise to frankly triage the bugs and also pick you battles. Again for the customer, this is really kind of pretty scary because they had this wall of issues to look at, none of them were serious.

And with that, let's change tacks and talk to our guest this week. We have Randy Campbell who works for Microsoft Services. Welcome Randy, you want to give us a quick blurb on what you do, how long you been Microsoft?

## Randy

Hello Michael, thanks for having me. I've been with Microsoft for, I am in my 23rd year, which is ranged from Technical Support, dedicated support, and now consulting for about the last 13 years.

## Michael

Nice! So your your main area of expertise is networking right? Specifically today anyway, Azure networking.

## Randy

Azure infrastructure as a whole, I do have a good bit of networking experience, yes.

## Michael

So one of the big topics that comes up constantly with customers is that of network isolation. I mean, obviously Azure is a public cloud and that means public endpoints, public IP addresses, services that are technically can be exposed to the Internet. Therefore potentially untrusted users. 

One of the buzzwords we hear thrown around quite often is this notion of network isolation. So from your perspective, what do customers want when they're talking about network isolation in the context of a cloud environment?

## Randy

So in my experience, I would say most of the time customers are looking for a way to be able to utilize Azure resources such as Azure storage, Azure SQL to store data that might have some very sensitive information, could contain Pi or Phi, anything like that, and they want to be able to utilize those in a way that remains on their private network while running in the cloud. We really need to differentiate here between pass.
And I, as right, we're talking. We talk about private, privately accessible services. We've always kind of been able to do that with the as. Is that correct path has always been the area where there's been public endpoints? Absolutely yeah, with as you're thinking about virtual machines and those are by default just they're going to be specific for your environment, and they're going to be deployed into a subnet, so they would get their own private IP address, their private for you.

When it comes to the path offerings really around the multi tenant kind, you know for a long time the Azure Cloud didn't have the capability to to be able to allow those to be accessed through private means only. They were the only way you could access them was over the Internet public endpoint.

So many pairs offering, so let's have an example, say as your storage or Azure SQL SQL database. They offer a firewall and I use the term firewall very loosely there like lower case F firewall that provide things like IP restrictions, perhaps even port restrictions in some cases, but that's not network isolation, right? That's right, Michael. So are things like storage accounts or Azure SQL or key vault. You can go to the firewall settings for that resource.

Hey, when you're looking to add IP address is there you can only add public IP addresses, so if you're needing to access something from on Prem but you want to try to do it in a somewhat secure manner, you can add those nated public IP addresses from your data center to the to the resource, but truly it's not really network isolation. At that point, it still is still traffic that leaves that's not confined to your private network, so over the years I mean Microsoft has moved.

Towards newer to network isolation technologies, do you want to just give us an idea of what those technologies are and what the sort of the patterns are that we see emerge across various services, right? So as more and more customers really demanded that some of our multi tenant pass services have this additional security features, we produced a feature called service endpoints. Yeah, so with service endpoints they allow you to lock down, so to speak, which Azure V net or subnet can access that Azure resource such as a storage account or.

For a Key Vault or or, see Azure SQL. And again I want to emphasize Azure virtual network because you cannot restrict traffic from on Prem through service endpoints. That is where one of the limitations for service endpoints comes into play.
And that's where we come in to our most recent offering, which is around private endpoints, and I'd like to take a step back and really talk about two really private pass patterns.

I tried to say that fast three times, so whenever 11 there's two main patterns. One is around the net injection and that is basically for dedicated pass resources. Examples might be something like Azure SQL MI Application Gateway, where it requires its own subnet.
Databricks where you deploy into where you can deploy into your own Vineet directly. Those are those are examples of net injection and by default since they are being injected they get private IPS so they are part of your virtual network.

Now the other pattern is private endpoints, and those really apply to multi tenant paths type resources. Again like Azure Storage or Azure SQL for key vault, things of that nature and basically when you enable private endpoint on one of those Azure resources that's creating a read only network interface for that pass resource. In bringing that into your Vineet. So again that allows for complete dataflow network flow between between resources.

In your private networks within Azure, that can also be utilized by resources from on Prem. If you've got express route set up, private peering, you've got a server on Prem that needs to talk to a storage account directly with private endpoints. You have that you have that capability now because it is part of your Vineet at that point.

And is it fair to say that both Vineet injected solutions, an private endpoint solutions the majority of time the networking architecture will be over express route? Yes, if your hybrid setup DS, that's most definitely the case.
Hybrid being you've got stuff on premises is not cloud native. Necessary stuff on premises that's communicating with stuff in the cloud that's correct.

A couple of really good examples. I mean, SQL managed instance is a good example of using venous injection and Azure SQL database which is a multi tenant environment that would use private endpoints instead.

Is it fair to say that as you're in general, where it makes sense, Azure is moving towards private endpoints and people should be learning about private endpoints? Yes, most definitely for my. For my understanding from my experience, product group is really focusing their efforts and investments on on the private link service, which powers private endpoints.

Service endpoints. They do have their place again, really along the lines of locking down access from an Azure VNet to an Azure PaaS Resource.

It's pretty easy to set up just to really, if you're doing this in the portal is really just a few clicks. Like I said, they have their place, but I think for the majority of folks, especially those that are in some of those industries where they want to have some of their data in the cloud and there are little apprehensive, then private endpoints really comes in quite positively in those situations.
So in the interest of Full disclosure, so you and I have been working on a healthcare solution or the last.
Last few months in the company in question actually has a policy right that says anything that is sensitive healthcare information. The hosting in Azure you must use private endpoints.

That's right, that's right. It's it's coming along that we're we've actually, I think, deployed a few apps if I'm not mistaken. More on the data analytics side of the of the house, but they are utilizing private endpoints for some of those features where they're going to have any type of sensitive data in a database or in a storage account.

So I'm gonna be honest with you. I have looked at the private endpoint stuff. You know my background is not networking, it is mainly application development and I do find it, it's not confusing but there are a few things that I sort of have to come to grips with. So one of the common issues that we see with private endpoints. But what would you expect customers possibly to run into in terms of resistance deploying private endpoints, I would say the biggest hurdle that a customer will need to overcome is correctly setting up DNS for name resolution because a lot of times you may have an app or.

Or or something like that that needs to connect via FQDN And if that if that storage account with its FQDN now has private endpoint enabled, it has a private IP so we need to be able to correctly, you know resolve that name so having DNS setup correctly, specially when it comes to a hybrid model like we were talking about. If you need to access some of those resources from on Prem then there is a little bit of work to do with on Prem DNS connecting to.

Possibly DNS servers running in Azure. I can assist in the resolution of those of the names of those endpoints. To me DNS is the big thing.
So on the topic of DNS there and this is my naivete coming through or lack of experience, that would be Azure private DNS or. Or is it public DNS? It is Azure private DNS that capability is there for you to host zones to host those records for any resource that you enable with private endpoint. The general idea is that especially from on Prem, the general idea again is you have conditional forwarder setup on your on Prem DNS servers.

And this is any like in a typical hub and spoke type of architecture running in the cloud where in the hub you may have several servers running DNS. It could be Windows DNS. Let's just say for this example they're running Windows DNS. So basically what you would do is you would enable or set up conditional forwarders on Prem to some to the zones that these Azure resources use for storing their DNS records you forward those wueries to your DNS servers running in the hub and at that point you would have specific forward or set up on those to go to an Azure specific IP address and all this is really is documented in some documentation that we're going to provide with this podcast, but once that happens you basically have resolution from on Prem and you can allow also disallows resolution from let's say various folks in the environment as well various various applications running in spokes that are.
Peer to your hub network. That's fantastic stuff I mean.
I'm really excited to see so many more pairs offerings move towards private endpoints. I think it gives a lot of customers greater degree of confidence that these services are essentially accessible as an extension of their own, their own infrastructure, which again just brings extra level of confidence running running services in the cloud. So random we always finish podcast by asking people one simple question, which is if you have to leave customers. Just thinking about one thing.
With relation to private endpoints, what would that be?

I would say if the customer has made the decision, you know if they're deciding between service endpoints or private endpoints and they've made the decision to go with private endpoints. I'm going to harp on it again. I'm going to say go to our article that we're going to provide that talks about DNS configuration. It has all the information that you'll need in there. We've relied on it with this customer that Michael and I have working on.
And it's a very important article, specially in a hybrid scenario. You'll want to follow that guidance very closely and then do some proper testing.

Well, Randy, thank you so much for coming on the podcast this week. I know I learned quite a few things along the way. Thank you everyone for listening, we'll make sure notes available on the on the website on <https://azsecuritypodcast.net> and with that thank you very much and we will see you next time.

## Outro

Thanks for listening to the Azure Security podcast. You can find show notes and other resources at our website <https://azsecuritypodcast.net>. If you have any questions, please find us on Twitter @azsecpod. Background music is from ccmixter.com and licensed under the Creative Commons license.
