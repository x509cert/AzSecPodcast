# Episode 16. Recorded November 11th, 2020 with Nick Fadziewicz - Azure Policy

## Intro

Welcome to the Azure Security podcast where we discuss topics relating to security, privacy, reliability and compliance on the Microsoft Cloud platform.

## Audio

**Michael**
Hey everybody, welcome to episode #16, this week we have Sarah, Mark and myself. We also have a special guest Nick Fadziewicz to talk to us about Azure policy but before we get to before we get to Nick, let's get stuck into the news Mark when you take it away.

**Mark**
So couple things, a couple things to share this week. Um, with first is, uh, there's an updated version of we'd like to jokingly call a short pamphlet of 701 pages so the new addition for the Azure for Architects came out. This is a free ebook so you do have to do the registration wall thing and just throwing the name, fake email, whatever it is, and then you can download it. Real email. Sorry. Really? Email work for Microsoft and it's got a lot of really good information on well written.
Um, somewhere around page 244. I think it was is where the security stuff kicks in some good information there. So definitely well worth checking out. Lots and lots of good contexts on Azure all up.
So the next thing I was going to share with uh, around something that I've been working a lot lately, we have seen a significant uptick in human operated ransomware, and so we've seen a lot of adversary groups, especially ransomware, in many ways is growing up. It used to be kind of a catch, as catch can send out a bunch of malware or phishing email links and hope and see how many workstations came in, but we're seeing these groups evolved and they're using some of the same techniques that.

I've been talking about for probably at least a decade now around, you know, pass the hash credential theft in all the variations and all the modern ones. You know, gold, Silver tickets, all that kind of good stuff, but effectively the Mimecast toolkit is what we're seeing in a lot of these attacks, but effectively their human operator driven ransomware. Now there are no longer just automated him machine and go Ann, so we're seeing this expand quite a bit, and this is becoming a significant percentage of the customer incident response. Is that our teams help.
For customers with so becoming a very area of intense focus and so we're working on updating our guidance, consolidating, cleaning that up so that customers have a very specific, actionable, you know, as close as we can to here's the project plan. Take it and run. It's kind of the goal that we're shooting for, but definitely an area of focus and area of interest and a lot of attacker investment there. And we're going to include some links in the show notes of the guidance that we are going to be sort of linking to or updating as part of this.
Um, including are sort of rapid attack guidance around that. Notpetchya at Wanna Crypt sort of stuff 'cause in some way or if it's the same pattern, just the one piece of good news actually is that the human operated ransomware. It does give us time to respond in the cases of one or Krypton patchy. You just didn't have a chance. You had to prevent. You did not have human time to deal with it, but in the case of this new stuff there is a human operator that is click click clicking along if scripts and automation that they use, but it still does take that human time to do things so it gives your humans in your.

Security operations or SoC if you have one to a chance to actually deal with it. So that is one of the rapidattack stuff that privilege access. Rd Map is another one that we are addressing and updating secureworkstation guidance. Sort of updating our paw guidance to leverage all the new goodness from the cloud is going to be a part of that as well. And we're also looking at all the existing tenants from Microsoft in the various teams.

As well as some industry, it's on this as well to get folks the best of all these worlds as actionable as we possibly can. So that's it. For my part of the world.

**Sarah**
Cool, then I guess it's my turn to talk about things that have been happening so, uh, so couple of things that I wanted to talk about. So first thing is some things that are some new things in Azure Security Center and so for stop the vulnerability assessment will now work for Azure Arc enabled servers, so that's for servers in other clouds or on premise. So behind the scenes in our vulnerability assessment we using Qualys.
But that means that. So if you have any so you can use it as to see if your machines have any vulnerabilities. So of course that's just rounding out the whole vulnerability piece that you can do it on other servers as well. And if outside of Azure, and of course if you're using Azure arc, it ties in nicely because it means you can manage them and also do the vulnerability assessment altogether. So that's pretty cool. There's also some other updates in security center, those.
Firewall recommendation added. So if you've got virtual networks and they are not protected by a firewall, that security center can see it will now have that recommendation. In our hygiene. An as we know, hygiene is super important. We don't do that enough well. A lot of breaches could be stopped by hygiene, and people do forget that. And of course I could never go through an entire episode without mentioning some Kubernetes stuff. There are some additional recommendations for that as well.
They are around authorized IP ranges within your Kubernetes cluster, so similar to traditional application whitelisting you can actually list IP ranges that are allowed to connect your Kubernetes cluster. Again, a little tweak, but a really good hygiene piece as well.
Also a couple of other things and there's a few more security center ones. Uh, will link to them in the show notes, but they're the ones that really caught my eye. The other one, which is very cool is for Azure Backup, so we now have soft delete for SQL Server for V Ms and SAP partner, which is really cool because soft delete is essentially a feature we do already have an Azure for other products, but what it does is it will protect data after you've deleted it. So if you soft delete something.
The data is actually still retained for an additional 2 weeks, which means if someone makes a mistake or it's actually a saying malicious person trying to delete your data, we can actually recover it for two weeks and that doesn't incur any costs either. So definitely go look at that if you're using those products, and if this is the first time you've ever heard of soft delete, then please go and look that up because they definitely definitely recommend you have that turned on for.
You're using that support it because it's really helpful.
And then the last thing is some stuff actually no second to last thing. Penultimate actually is a DNS features in Azure Firewall. So the firewall thing I was talking about before was just a recommendation. But now we've got some features that were in public preview that are now GA, so I think the one that I found the coolest was custom DNS support. So originally Azure Firewall would only use Azure DNS and you couldn't change that. But now you can get a Azure firewall to use custom DNS. So if you've got your own DNS server.
You can you can.
Uh, which is really nice because it means it can do resolutions that couldn't be done on Azure DNS, so that makes it much more flexible. You can also proxy using Azure Firewall now as well. We can do a DNS proxying, which means you can actually actually protect your DNS server an it means that you can have a reliable FQDN, fully qualified domain name filtering in your network rules. So some cool things there as well. Again, I haven't actually gone through them.
Oh, but there's more stuff around just building out our DNS functionality, so have a look at that and then last but not least, uh, obviously my baby in Azure Sentinel this week we got we announced the public preview of the Microsoft Defender 365 Connector and this is the Roar Events connector. So it what it means is that you can now bring in those raw events from Azure Defender.
Or endpoints an it means you could do advance hunting and it will be stored in Azure Sentinel alongside your other telemetry. So a lot of customers I know from personal experience a lot of customers have been asking for that, so that is now available in public preview. Alongside that there is a billing benefit deal that's around I believe for about the next six months it's all again will link to it in the show notes. I don't want to talk too much about costings, but essentially if you're an E5 customer to ingest that RAW defended data you get a discount. So go and look it up and.
Have a look at that might apply to you 'cause I do know a lot of customers were waiting for that feature, and that's probably me done for today.

**Michael**
Alright, so the couple things piqued my interest over the last few weeks. The first one is HD Insight now supports private link and preview and as does Azure Batch. This is really cool. I know I mentioned this almost every week that we talk.

But the fact that more and more PaaS offerings moving to private link private endpoint the better because it allows you to essentially construct solutions that are essentially just an extension of your own, your own network, highly isolated from a network perspective. So yeah, so HD insight and Azure Batch to new features that have added to that list.
Another cool feature on Azure Storage and now allows you to select your minimum TLS version. This is another thing we're seeing happening.
But we have more control over the TLS version that passes services support. So for example, if you're building something that must be PCI compliance, then you need to really select TLS 1.2 and above, but you know you may be building something that had may have serious compatibility issues, so you may want to support TLS 1.1. I'm not saying it's a good idea will security standpoint, but at least you can now do it.

Something we talked about in September was that Azure Data Lake Storage Gen. 2 supported recursive access control lists, POSIX 100, three .1 controllers that was in preview in September that is now GA. There's now generally available, which is, which is great to see.
And the last one is, uh, I had an interview last week with the Azure Podcast. So for those of you who don't know the Azure Security Podcast, This podcast is really modeled on the Azure podcast, which is run by Sujit D�Mello and all his Co hosts. So I was interviewed a couple weeks ago for episode 352 talking about this podcast, but also about just about Azure security in general and trends that we're seeing across across the platform, so again.

So with that, let's change tacks and let's introduce our guest this week we have we have Nick Fadziewicz, who is a newly minted Principal Consultant in Azure and AI. So Nick, why don't you spend a couple of minutes? Just explain who you are, what you do, how long you been at Microsoft, and what excites you about Azure.

**Nick**
Yeah, thank you, Michael. I have been at Microsoft for coming up on the eight years in January. I was in industry before that doing mostly identity and access management actually played a small role in setting the civilian new S Department, US government's smart card standards. So the Department of Defense that's common access cards. The civilian government has with called an HSPD 12 or a PIV card, and I was on.

A lot of the committees that set up that technology and ultimately deployed some of those solutions to various customers. So when I was finished or mostly finished with that work, Microsoft reached out because I had made some Contacts or there and brought me on as an identity and access management consultant. So for the last eight years I've been deploying initially forefront Identity Manager Finn. Most recently Microsoft Identity Manager and then as Microsoft and the world have transitioned into the cloud. So have I.

Uh, started doing things like ADFS, Azure, Active Directory, and ultimately most recently Azure policy, which seems like a bit of a odd turn, Azure policy being a configuration management tool for managing resources in Azure, but when I take a look at the way that Azure, especially Azure Resource Manager, handles all of those resources.

Often times we're really doing is looking at an object or an identity with a bunch of properties and parameters and applying a bunch of workflow to those objects which is nearly identical to the identity synchronization work that I was doing previously.
So, uh, when I configure a storage account, I don't look at debts and I don't care much whether that's a SSD or a traditional spinning drive. When I see is a single object with a property that might say one terabyte of storage, and that's been very helpful in sort of moving by yourself into the cloud and a lot of the work that I'm doing with Azure policy.

**Michael**
Cool, so let's just assume that our listeners are not familiar with Azure policy. Could you give like and Azure policy 101 like where would you use it? Some of the potential pitfalls that people need to be aware of.

**Nick**
Yeah, so Azure policy is a service inside Azure that allows for configuration management. As I mentioned. It's a service that executes every time there's a change or a new resource is added to a subscription or a tenant or resource group and the Azure policy as a set of conditions. The policy rules that if those are Matt, there are actions that take place.

**Nick**
Those actions can be a audit action where the resources then reported as non compliant into the compliance Center for Azure Policy. Or the action could be denied which is stopped. That update or creation of the new research from happening and probably most powerfully the action can be make some change, append some new configuration, create an additional resource. So for example if you were to create a virtual network.

**Nick**
You may want to immediately create a subnet with a certain size. That's the type of thing that you can do in Azure policy. Ultimately, deploy an arm template.

**Nick**
Based on the resource that's being updated and enforce configurations which from a security perspective is really excellent, because we can automatically turn on that the minimum TLS version is 1.2 and anybody who tries to go around that gets flagged or outright denied if that's the policy given your example from before, so Azure policy is really a way to do that enforcement give visibility. It is an enterprise solution that.

**Nick**
Scales extremely well, uh. Azure Azure runs, it runs as platform as a service, so Azure handles all the load balancing and all of the behind. The scenes work of making Azure policy work and ultimately, it's a very familiar for anybody who's using ARM templates. It's a very familiar exercise because policies are written in JSON with policy action that policy rules the policy actions, and then ARM templates that you want to deploy. It's a little bit complicated at first, but if you do half a dozen policy's even the most simple ones, you'll be able to do motor. The more complex ones. So the ramp for getting updated educate.net and executing is is not particularly steep.

**Michael**
I can imagine that if someone were to roll out a whole bunch of policies that deny things off the bat that could be quite disruptive.

**Nick**
Yeah, absolutely could. There are a number of Azure policies very powerful. Any activity that one could execute through automation within ARM template can absolutely be done through Azure policy. So first of all, make sure you're protecting your policy definitions and who's allowed to edit those definitions, assign the definitions and so on. But more importantly, as you're going through the exercise, other customers going through the exercise of rolling out Azure policy, we strongly recommend.

Rolling these policies out in assigning them in audit mode to begin with that allows for compliance results to be looked at, analyzed, remediated, if appropriate, and for those places where there isn't remediation either leave the audit in place so that those items continue to show up, and when you move on to the next step to to assign enforcement policy. So deny or deployment policy's. Then you can create an exception or.

Count Azure policy to stop looking at those resources so they no longer show up as false positives because they bend, evaluate it. Any subsequent resources, of course, would would have to be evaluated in and handled going forward, but this allows for the rolling out of policies and existing environments before without having to cause any unforeseen circumstances like outage in certain IO service that are self inflicted.

**Michael**
Yeah, I know most of the customers that I work with tend to shy away from deny at the beginning. Get a feel for what the impact will be by setting things in audit mode and then selectively start turning on deny where it makes sense. That being said, I've seen at least one customer where they've had a security weakness sort of manifest itself in production because they did have something set to two.

They caught it because of the event was audited, but versus it being prevented by using deny.

On another topic. So when is this enforced? I mean you can change things through the portal. You can run PowerShell scripts. You can deploy an arm template. You can configure things from the Azure CLI, So what points is policy evaluated?

**Nick**
Well, the great news is because Azure policy runs as part of the fabric, Azure policy is actually evaluated during everyone of the cases. An ultimately all cases. So once the change once, Azure recognizes the change it begins to implement it. Azure policy will do its valuation against the policy rules, those conditions of compliance or non compliance, and at that point either allow or disallow the change so.

It really doesn't matter what automation tools or deployment tools of customers using, whether it's manually through the portal, pointing collected, deploy a new storage account or large mechanisms for deploying resources at scale. Azure policy will apply in all of those cases for any new resource or any change resource, and in addition, Azure policy is also constantly running on a cycle. The service level agreement today is that every policy will be.

We evaluated every 24 hours, so if something were to sneak through then of course won't help on a deny policy or a deployment policy because those policy is actually if it's not at the time of the the change being made then enforcement policy goes onto a list for remediation and there has to be a manual process to click the button to say, remediate or to send the command through the arm.

Uh, the REST API or some other mechanism to actually perform that remediation, but all the audience, for example, will start to show us and so Azure policy is sort of always running and also running whenever it changes made, whether that's a new resource or an update to an existing resource. So yeah.

**Michael**
So so does Azure come with built in policy's? Or is this something that I have to create from scratch me? Where do I find pauses? And can you give like a couple of examples? I mean, you gave one example of their storage account using TLS 1.2. Could give another couple of examples.

**Nick**
Yeah, I mean the pretty much any configuration of a resource you can do there is. There are some limits and Azure policy because of the way that the fabric works actually abstracts some of the properties from resources into what Azure called Azure policy calls an alias.

An alias is a, um, essentially a layer between the resource itself and Azure policy, and so that exists because Azure changing fairly regularly and Azure policy is need to continue to work, and so if the underlying resource changes because of that abstraction, the alias can act to bridge that gap while policy gets updated and and all the change management happens as far as what's available today, Microsoft.

Azure Actually provides a long list of built in policy's most of those policy czar in audit mode only. And in many cases are fairly purpose built. Meaning they're not intended to handle multiple complex situations. They're looking at one specific scenario for one specific purpose, typically aligned to some benchmark or security control. PCI compliance, for example, has a what's called a policy initiative.

**Nick**
Which is a group of policy's, and, um, when customer applies that they get to only apply that in audit mode. So yeah, we have provided Microsoft has provided a number of policies, and there are many, many, many of them turning on soft delete for storage accounts, virtual machines that have to have specific IP addresses, location only allow certain locations, all the types of things that you would expect somebody who was security minded would.

**Nick**
Would want to have in their environment. There's almost certainly an existing withheld built in policy, and if there isn't, there's going. There's likely to be something close for somebody who has to author a custom policy. Often you can go find the something that's close for one of the built in policy's use that as the starting point, and then go from there. That helps with accelerating that all.

**Nick**
Maybe someone tedious if if you're just getting started.

**Sarah**
So Nick, um, you sometimes get customers will say they've already got Azure Security Center in that has policies built into it, so why would if a customer's already using ASC? Why would they need policy on top of that? I know I've been asked that before and I know that you said when we were chatting before we started the show, that that's a question you get asked a lot.

**Nick**
Yeah, it's a great question and it is one that we get a lot at the end of the day. Azure Security Center is behind the scenes Azure policy and so Azure Security Center compliance results now as you can. Security center gets signal from lots of places, but in this particular case the place that they're getting that signal from is the Azure policy compliance results. If a customer decides if they want to add on to what Azure Security Center is doing or modify the existing Azure Security Center results.

**Nick**
In order to meet their business needs, they would do that through Azure policy and they could do that by customizing the existing policy's and then including them in policy initiatives.

**Nick**
And then registering those initiatives, their custom initiatives with Azure Security Center and then use the same single pane of glass that they're using today with Azure Security Center being where they go for their reporting.

**Nick**
And that's often the direction we see a lot of customers go. They don't. They see the way that Azure Security Center looks so they like it when you look at the compliance results in Azure policy, it looks much less user friendly and you can really get the customer can really get the best of both worlds by creating custom policy custom initiatives and then enrolling them in Azure Security Center and get a consistent experience.

**Michael**
Yeah, I think that explains a lot of the differences or similarities. I think between the two as I know I've certainly been a little confused by it.

**Michael**
But another question I have about as you policy is what do you see? Is some of the deficiencies. I mean, there are obviously gonna be some weaknesses. So where do you see some of those, those deficiencies?

**Nick**
Yeah, I touched a little bit on on a couple of them. The out of the box, the built in policy's are very purpose built. I would. I would suggest that we would be well served as a as a community of security minded individuals to have those policy's be built a little bit more broadly parameterized, for example. So allow for.

**Nick**
A more complex scenarios that perhaps the built in policy is targeted to one specific control in a particular bench**Mark** or baseline, but a customer may want to use that policy.
00:33:19.160 --> 00:33:23.440
**Nick**
And or very similar policy moving forward. I know I find myself.
00:33:24.390 --> 00:33:54.500
**Nick**
Essentially copying the built in policy is making one small tweak and then having this object. This technical object that I have to manage through source control and change management and all the other complex things because again Azure policy is very powerful. I don't want to just let anybody do that and I want to make sure I'm doing it correctly, so the that's one primary place where I would focus the Azure policy efforts. The other thing is it is a bit complex to have.
00:33:54.550 --> 00:33:57.800
**Nick**
A number of different Azure policy's. They start to.
00:33:58.490 --> 00:34:28.880
**Nick**
Get um very similar using the same sort of resources and ultimately we end up with the versioning problem, which is something that doesn't exist in Azure policy today, so we'd like to see some investment in Azure policy versions where we can have an initial version and then many customers are using agile development processes, iterating, making additions, and having versions of the different resources will be very helpful in order to support.
00:34:29.080 --> 00:34:36.110
**Nick**
That I'm going customization and tailoring to the different customers business. It's so those are the two I would focus on.
00:34:38.870 --> 00:34:53.400
**Mark**
Awesome hinder, so like I mean, let me just first my fanboy thing 'cause like I love Azure policy. It's one of those things that like Microsoft this massive investment into Azure Resource Manager Arm as we like to call it.
00:34:54.140 --> 00:35:08.030
**Mark**
And essentially turned the datacenter. You know software defined data center into something that's really sort of managed regular. Every service goes through that to do all their create, you know, remove, delete, change, modify all those kind of things.
00:35:08.690 --> 00:35:12.370
**Mark**
An you know, applying the policy to there. I mean I just I love that.
00:35:13.050 --> 00:35:35.000
**Mark**
I think I'm wondering, you know, especially, given the power of it that you're mentioning earlier, like what are the best practices for implementing it? Like you know, if I was going to like OK, I want to adopt Azure policy, what would what would be the sort of ways that you would recommend folks to say OK will use this. Do this and don't do this until your advanced and really get it kind of thing.
00:35:36.680 --> 00:36:06.510
**Nick**
So if we talk about sort of crawl run, crawl, walk, run, the first thing I would start with is recognize that Azure policy is a technical asset, just like every other technical asset it needs change management, it needs source control for the files and the configurations that Azure policy has. It really should be in a formal repository. Azure DevOps, an Azure repose or GitHub enterprise on the Microsoft Stack side are really great. They have a lot of built in.
00:36:06.580 --> 00:36:08.660
**Nick**
Mechanisms for managing policy.
00:36:09.900 --> 00:36:41.000
**Nick**
I would strongly recommend customers start there. There's already in getting up enterprise. There's Microsoft Product Group provided automation for changes to policy files and definitions and those actions automatically will push through the the GitHub Enterprise Action pipeline to make the change to the policy in whatever tenant subscription or other location you have for them. So I would I would start there.
00:36:41.220 --> 00:37:10.210
**Nick**
And 2nd is when you're deploying policy's it across an environment. Because they're so powerful, you really, you really do need to start in audit mode and then do that evaluation, and that could take a long time. It will take. It will take quite a bit of time to author policy is to settle on baseline configurations, even using built in policy's, it will take some time to evaluate them, to see if they apply, or when looking at the compliance results in audit mode, determining what's a false positive and.
00:37:10.810 --> 00:37:30.100
**Nick**
What actually requires remediation, and so take the time. I would suggest that folks that are deploying Azure policy take the time to really look at those compliance results and take them seriously. Because once you move into enforcement mode, you really need to make sure you're not having downstream effects on your applications so.
00:37:31.340 --> 00:37:41.820
**Nick**
Yeah, I I would strongly recommend customers put put their policies into some sort of source control and start with audit. Don't just jump right into enforcement policies.
00:37:44.410 --> 00:37:46.450
**Mark**
Cool now.
00:37:47.240 --> 00:38:00.480
**Mark**
No, is no. Azure policy. Is that something that like a workload owner like an Azure workload Underwood have exposure to or would only be the folks that are sort of managing the enterprise and all the workloads in aggregate?
00:38:02.400 --> 00:38:22.000
**Nick**
So Azure policy actually has the ability to act as an accelerator for deployments. Microsoft has a solution we call enterprise scale that sets up landing zones for different environments as sort of a hub and spoke environment for shared services.
00:38:22.750 --> 00:38:53.930
**Nick**
And Azure policy is used pretty heavily in that environment where when a new subscription is stood up inside the tenant, the Base services network storage monitoring key, vault secrets, secrets management, all that gets stood up as part of that deployment, and you could certainly use Azure policy to help drive that and accelerate that adoption for workloads that are moving into Azure so that they can spend more time focusing on their applications and less time focusing on.
00:38:54.250 --> 00:39:24.260
**Nick**
The decisions that need to make around the base infrastructure. Um, in that case, I would say that the general workloads will be heavily impacted. Ann and see policy as an accelerator on the other hand, policy can also be used by centralized security teams to put control enforcement in place, which then presumably takes away some of that flexibility from those application teams by enforcing certain configurations so you know there's always a balance.
00:39:24.430 --> 00:39:26.830
**Nick**
Security is always a balance between convenience and.
00:39:27.420 --> 00:39:37.550
**Nick**
And security and, uh, you know customer doing well with Azure policy will be able to find that balance between acceleration and control.
00:39:38.650 --> 00:39:46.040
**Mark**
Cool, so last question I had is can you talk a little bit about the difference between blueprints and policy on kind of when you would use each one?
00:40:07.780 --> 00:40:38.830
**Nick**
If a virtual network is created, then IP addresses get assigned Azure blueprints. When you deploy an Azure blueprint that has no such dependencies other than those that are built into the arm template or the number of ARM templates that are being deployed. So I typically look at Azure blueprints as the deployment mechanism and then most of the time when I see customers deploying Azure policy, they're doing it for a security control purposes and so I look at Azure Security as the control mechanism.
00:40:38.870 --> 00:41:09.610
**Nick**
The enforcement mechanism and the compliance reporting for certain security settings. So well they are similar and Azure blue point prints because it can deploy any arm template can absolutely be used to deploy and assign Azure policy. They are similar, but they are. They definitely serve and are intended to serve two different purposes. You can turn the screwdriver over and use it to hammer in a nail, but you probably better off going out and getting a hammer and hammering in a nail.
00:41:09.960 --> 00:41:12.790
**Nick**
And so you make sure using the right tool for the job.
00:41:17.800 --> 00:41:18.580
**Mark**
Awesome thanks.
00:41:18.370 --> 00:41:18.720
**Nick**
That's right.
00:41:19.300 --> 00:41:19.630
**Nick**
Yep.
00:41:25.380 --> 00:41:40.810
**Sarah**
So, uh, so Nick? How about ignite things? 'cause Ignite was pretty what wasn't too long ago. Anything you and cool and the world of policy that you can tell us about that people may not be aware of yet.
00:41:41.510 --> 00:42:14.630
**Nick**
Yeah, Ignite wasn't really exciting time for Azure policy, you no Azure policy has been sort of this quiet quiet service sitting in the corner. You know those of us that have been working with it for awhile. Very passionate about it, but it wasn't getting a whole lot of love and that changed with Ignite so there are a number of different features and capabilities of us in the policy community then looking forward to for a while one of them is policy exemptions so Azure policy is always had the ability to create exceptions.
00:42:14.940 --> 00:42:45.810
**Nick**
Which is a policy would apply to specific resources, and if that policy was an enforcement policy then you could create an exception at some level in your organization structure at the subscription management you know management Group, Resource Group, individual resources. You could create these exceptions and those exceptions. Those policies would no longer apply at those scopes, but the resources would constantly show up as non compliant.
00:42:45.870 --> 00:43:15.620
**Nick**
And, um, what this meant was the security team who like to see clean audit sheets would always have some number of resources that show that we're showing up is not compliant. Now, if the security team was looking at these reports all the time, they would know that 27 resources was the right number, and if the number went up to 28, then that was bad news. However, that's not always highly reliable and so.
00:43:16.160 --> 00:43:46.230
**Nick**
In, uh in ignite, Microsoft announced that there were going to allow policy exemptions, and when you assign a policy or configure a policy exemption as far as that Azure policy assignment is concerned, those resources don't exist. They don't show up on reports, they don't have any activity, they don't have enforcement actions taken in them. They don't exist, they're not reported as non compliant, which means that resources that.
00:43:46.490 --> 00:43:51.860
**Nick**
Are out of compliance, but that's OK and there may be other mitigating factors.
00:43:52.970 --> 00:44:22.750
**Nick**
Can be handled and clean up those reports, making them significantly more usable and for extremely large environments where Azure policy might be deployed broadly, that number of exemptions could reach into the hundreds in some cases, and it really does help keep everybody organized. The other exciting news for those of us that right, a lot of custom policy when a customer wanted policy a custom policy is written and you want to validate.
00:44:23.110 --> 00:44:43.430
**Nick**
Here in the authoring phase, we want to validate that the policy is providing the outcome that you're looking for. You might start off iteratively and create policy and just sort of take the first shot of it and and add it to Azure, submit it to Azure and then go into sign the policy against the resources and check to see what happens well.
00:44:44.330 --> 00:45:02.420
**Nick**
Because Azure policy is constantly running the brand newly assigned policy's can take up to 30 minutes from the time they get added to the queue until they actually get a valuated and you get results, which means UA or doing a lot more authoring before you're checking your work and B.
00:45:03.070 --> 00:45:09.330
**Nick**
Even when you're doing that, authoring 30 minutes is a long time to hit submit and then week.
00:45:10.030 --> 00:45:29.620
**Nick**
And so, uh, an exciting new development was that the Azure policy team actually created a add on an extension to Visual Studio that allows you to connect to your Azure environment, submit or submit a policy. It has to be, uh, created policy definition.
00:45:30.580 --> 00:45:41.060
**Nick**
And in some cases assigned that policy, if your policy definition has parameters that need to be set in order for it to work, and then pick resources from your environment and within Visual Studio.
00:45:41.650 --> 00:46:11.990
**Nick**
Click a button that says evaluate and get results immediately and so this accelerates the authoring by a significant margin because you can essentially do all of your policy evaluation and you're authoring inside Visual Studio. Other than submitting the policy in the 1st place, which can easily automate through PowerShell or other ways, you then can test. Your policy is very, very quickly. Get them to to to report the results that you're looking for.
00:46:12.150 --> 00:46:13.060
**Nick**
And off you go.
00:46:14.040 --> 00:46:44.730
**Nick**
In addition, um Azure policy historically and traditionally, has been highly focused and almost exclusively focused on the management plane of Azure. For those that aren't familiar, the management plane is the infrastructure configuration management layer, so go create an infrastructure resource or platform resource, set the basic settings to it, but that is all. So, for example, a storage account you can go in and create a storage account.
00:46:44.780 --> 00:47:15.470
**Nick**
Once the storage account is created, you can increase the size. You can attach it to various virtual machines, for example and so on. But what you can't do at the management plane is get access to the data in that storage account key vault. So you can create the key vault. You can configure the key vault, but you don't have access directly to the secrets in the key vault. And excitingly Azure policy started being able to manage at the next level down at the data layer. So for Kubernetes for example, you can actually manage the Kubernetes engine.
00:47:15.890 --> 00:47:46.050
**Nick**
For Azure key Vault, you can actually manage the certificates and secrets that are in the key vault by doing things like saying that you can't have circuit certificates have been issued for longer than X number of days in the key vault, or that the key legs need to be a certain size and that type of thing, and so that was really exciting coming out of coming out of Ignite. Finally, organizing organizing policies is really important. The way that we do that is grouping them into.
00:47:46.100 --> 00:47:57.580
**Nick**
What's called a policy initiative. A set of policies and then assigning that initiative so you might have a networking initiative. You might have a virtual machine initiative and so on down the line.
00:47:58.490 --> 00:48:06.400
**Nick**
Um, what? What was true is when you want to assign an initiative. If you had exceptions, and ultimately when you if you have example.
00:48:07.320 --> 00:48:10.000
**Nick**
Uh, you either had to accept.
00:48:11.330 --> 00:48:25.300
**Nick**
The entire resource from the you know the entire set of resources from that whole initiative for every single policy in the initiative or not, do an exception and have a false positives in your audit report.
00:48:26.100 --> 00:48:30.350
**Nick**
Well, good news, now you can inside an initiative created initiative Group.
00:48:30.930 --> 00:49:01.820
**Nick**
And you could say these are. This is my network initiative, but here is my firewall security policy and here's my IP security policy and here's my virtual network security policy and you can create those three groups, and if I resources only non compliant with the firewall policy's, you can create an exception that says only for this one particular group inside this initiative does this exception apply, and so again much more fine grained access to manage your resources so.
00:49:02.100 --> 00:49:13.210
**Nick**
Yeah, Ignite was extremely exciting. Lots of good activity at heard personally from the product groups that they're continuing to iterate and we look forward to what the future holds.
00:49:15.720 --> 00:49:17.930
**Michael**
So I think one other item that was, uh?
00:49:18.500 --> 00:49:20.820
**Michael**
From Ignite was using Ms graph.
00:49:22.450 --> 00:49:53.000
**Nick**
Yeah, that that's really awesome. So going, you know, in the past, if you had compliance results, you could ship those to Azure Security Center as we mentioned, but that was kind of it. There wasn't a really good way to send the results to an event hub or to a log analytics workspace and then file the rest of your data flows. There really wasn't a whole lot of automation to you can sort of get some surface level information. You know how many resources are non compliant.
00:50:10.880 --> 00:50:15.970
**Nick**
Or for a particular policy, which condition within that policy is the reason?
00:50:16.700 --> 00:50:17.270
**Nick**
It'll be here.
00:50:19.660 --> 00:50:20.240
**Nick**
Is that me?
00:50:20.870 --> 00:50:25.600
**Michael**
You know what that's may, I'm so sorry. Can we just do that sentence again? That's Maine.
00:50:26.270 --> 00:50:26.720
**Nick**
OK.
00:50:27.130 --> 00:50:30.850
**Michael**
Just give out five second delay. I'm so sorry that I should run on mute.
00:50:27.670 --> 00:50:28.040
**Nick**
Yeah.
00:50:29.760 --> 00:50:30.010
**Nick**
Yeah.
00:50:31.340 --> 00:50:31.620
**Nick**
Yep.
00:50:36.340 --> 00:50:37.830
**Nick**
So in the past.
00:50:38.680 --> 00:50:46.800
**Nick**
If you wanted to create an exception, oh, that's not the one we were answering the Ms Graph question. OK, 5 seconds, hold on.
00:50:46.080 --> 00:50:52.040
**Michael**
Yeah, let's just let's just take it from the top five seconds and then just say actually know what. Let me ask the question again.
00:50:48.810 --> 00:50:49.360
**Nick**
Yeah, yeah.
00:50:52.190 --> 00:51:00.620
**Mark**
Are you filled online? I do have to drop for a conflict. Um, Nick, it's been. Yeah, I know you're not quite done talking, but it's been fantastic having out here. Really appreciate it, man.
00:50:52.570 --> 00:50:52.890
**Nick**
OK.
00:51:00.930 --> 00:51:02.560
**Nick**
Sure, awesome problem.
00:51:01.880 --> 00:51:06.390
**Sarah**
Yeah, I gotta drop two guys. I'm a bit late for my next meeting, but thanks Nick.
00:51:04.500 --> 00:51:05.810
**Michael**
Tiger Tiger
00:51:05.780 --> 00:51:06.190
**Nick**
Yeah.
00:51:06.790 --> 00:51:07.570
**Nick**
You're welcome.
00:51:07.040 --> 00:51:11.310
**Michael**
alright so guys alright alright let's take him very top.
00:51:14.750 --> 00:51:18.960
**Michael**
So another announcements at Ignite was around using Microsoft Graph.
00:51:21.110 --> 00:51:50.620
**Nick**
Yeah, that was really exciting in the past. If you wanted to get compliance results out of out of Azure policy, you could either register your policy to and then use Azure Security Center and have the data flow downstream for whatever automation, or use the portal to look at the look at the results, but there really wasn't another good way to get those results programmatically and so.
00:51:52.120 --> 00:52:16.220
**Nick**
With this announcement opening up the the graph allows for much finer grained access to compliance and non compliance results, including which resources are non compliant and crucially which was almost impossible if not impossible to get before. Why those resources are not compliant. So if uh storage account didn't have soft delete turned on in the past, you might get nothing. You might.
00:52:16.880 --> 00:52:47.010
**Nick**
See that that storage account was out of compliance, but you might not. But you definitely wouldn't know why, and now you can actually go in and say the results will tell you which policy is non compliant and ultimately which property on the resources triggering the policy rule to identify noncompliance and so for customers that are maybe not using Azure Security Center fully but do have other dashboards or other power BI mechanisms or.
00:52:47.060 --> 00:52:59.710
**Nick**
Automation flows for pulling those results out. This opens up a world of possibilities for SoC integration, management reports and other things that didn't just didn't exist before, and so it's really, really exciting stuff.
00:53:00.700 --> 00:53:11.430
**Michael**
Yeah it is. I mean historically, always been a bit of a black box, so this is fantastic to see. We also have a prior episode on Microsoft Graph if anyone wants to learn a bit more little bit more about it.
00:53:11.990 --> 00:53:21.680
**Michael**
So Nick, one thing we'd like to do before we sign off is, uh, is one thing that you would leave our listeners with about Azure policy? What would it be?
00:53:23.960 --> 00:53:49.080
**Nick**
So Azure policy is big and complex. It can easily be scoped down to critical items going forward that customers can address right out of the box in many cases, and even the customizations with a small amount of engineering can be done fairly quickly. So the one thing that I would say is that is a lot of effort, however.
00:53:49.790 --> 00:53:59.440
**Nick**
If you're a large organization or even a medium organization, you have multiple workloads moving into Azure. Every one of them is trying to figure out how to be secure or should be tried to figure out how to be secure.
00:54:00.000 --> 00:54:31.280
**Nick**
Azure policy, the investment that you put into Azure policy can absolutely accelerate that move into Azure because oftentimes workloads and customers moving sensitive data and sensitive workloads are worried about the security implications and by using Azure policy to set that security baseline so that everybody is at the same level, you're no longer relying on just those engineers to make the right decision when they're deploying the resource that one time, it gives visibility it can give enforcement. It allows for continuous improvement.
00:54:31.640 --> 00:55:01.770
**Nick**
There really is no no better way to accelerate that compliance with security baselines in Azure and in the cloud then Azure policy. It's really the go to. So the thing that I would say take away is make the investment in Azure policy do it smartly, do it correctly and you will reap those benefits almost immediately. As you notice we that are out of compliance and new resources automatically being in compliance, which will really just reduce the deployment times.
00:55:01.890 --> 00:55:07.010
**Nick**
And those those modernization times drastically. So really good investment.
00:55:09.470 --> 00:55:26.060
**Michael**
Thanks so much for that. So yes and next thank you so much for joining us this week. Thank you for taking the time out. I know I learned a few things. Some of the gaps that I had in my knowledge about Azure policy of certain been filled. Thank you to everyone listening this week. Take care of their and we'll see you next time.
00:55:29.760 --> 00:55:31.030

## Outro

Thanks for listening to the Azure Security podcast. You can find show notes and other resources at our website <https://azsecuritypodcast.net>. If you have any questions, please find us on Twitter @azsecpod. Background music is from ccmixter.com and licensed under the Creative Commons license.
