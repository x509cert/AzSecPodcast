Welcome to the Azure Security Podcast where we discussed topics relating to security, privacy, reliability and compliance on the Microsoft Cloud platform.

**Michael**: Welcome to episode number 10. We have a full House this week. We also have a special guest Tali Ash who will talk to us about Microsoft threat protection. But before that. Let's get stuck into the news Sarah what we got.

**Sarah**: First thing I want to talk about is topical and at the time we are recording this and it's very local to me over the last 10 days or so there's a number of New Zealand organizations that have been coming under quite a nasty D dos attack. So NZ Stock Exchange had to stop trading for a few days and that's still it still hasn't been fully resolved as of the time we're recording this and.
Of course, it's a very big deal down here. If you're in New Zealand and if you work for any of the organizations that have been impacted, but I think this is a really great reminder for everybody to go and have a look at their DDos capabilities of what you have and what your service provider gives you because D dos attacks. You know, I think it's something that everybody is familiar with it. It's something that happens relatively frequently but.
It's it's really kinda have some quite nasty effects on business and you know the capabilities of these attackers to increase the volume of and the sophistication of these attacks is always growing so I just wanted to mention that one that if you haven't reviewed your D dos capability recently. It's worth looking at and. Of course, you should make sure that everything that's external facing does have DDos protection and so.
Were throwing in there that you can the Azure platform? Of course has plenty of D dos protection. But we do also have something called Azure D dos standard, which is more advanced capability. That's tuned to your endpoints and so that's worth checking out if you're if you find that you're a little bit lacking in the D dos capability area so that's my first one that I wanted to talk about Secondly, we now putting on.
Ingestion volume rate limit into log Analytics. Now this was already in place for the wider Azure monitor platform. But we're now doing it. Within Log Analytics. So the limit is enforced on compressed data at about 6 gigabytes. A minute uncompressed now. The reason we're doing this 'cause you might say well. That sounds a little bit counterproductive. The reason we're doing this of course, is to balance our resource is across all of our customers and.
We have to put these limits in to protect customers from so that maybe one customer would have a huge ingestion spike and that could affect other customers who were also using the wider log. Analytics platform, so essentially, though nothing to worry about so although we will be enforcing a limit at 6. Giga minute uncompressed if you are. You will start getting alerts. If you start to reach about 80% of that going forward and if you do need to increase.
Your ingestion volume to more than 6 gig-a-minute, then you'll need to open a support request. So it's not that we won't allow it entirely. It's just that. We need to be able to plan for it again to keep the platform running for all of our customers. So it does one just to be mindful of and that's my news done so. I think I'll hand it over to Mark.
**Mark**: So yeah couple things caught my eye this week. Thank you Sarah One is.
Well, one was one that I actually presented which is I did a recording of the Open Group Zero Trust core principles and so that recording is out on YouTube. So will post that link in the show notes and a couple of interesting things kind of came about the first is that these are the near final ones. The final ones are going through the approval process right now.
And so that was sort of one of the things there is that you know, these are almost final there and we've found simpler ways to express it with axioms and so that will be out in the next couple of weeks, possibly by the time you hear this and then the the thing that was actually kind of cool as part of this project was that we got a really crisp concise view of kind of what security is if you're kind of looking at it from the showdown view and it really can be pretty simple. If you break it down in a certain way. And this really breaks down to sort of access control, which is how most people think about security is like.
The right people have the right access to the right resources and they're trustworthy etc. Kind of getting the zero trust kind of thing there and then the asset protection. So are you doing, special stuff to kind of take care of the out of band things like data in transit data at rest, etc. And then you know what? what I kind of casually referred to sometimes as a visibility sandwich of sort of the in the moment, something's happening. You know sort of security operations or sock view of the world, but then sort of the Longview, the longer term, governance piece where hey? Are we
keeping are we actually looking and finding all the right assets? Are we are. We actually sliding backwards in terms of security posture? Are we continuing to move forward with it and all the things related to that and so really you know, we have this nice simple view of security some from that sort of 4 different perspectives access assets governments and security operations.
And the second thing this was more of sort of a realization, so we're working on the Azure. Security benchmarks so the version 2. It will be out. Sometime soon can't promise that quite yet as we were working on this we're essentially merging the Azure. Security compass material was known as ash pretty compass with the Azure. Security benchmarks and really trying to get really crisp clear best practices. You know single source for Azure and the thing that we found in the information.
Protection space that we were working on this, this past week is you know really around kind of how closely related information protection and encryption and access control really are, and the way that we ended up structuring that section was kind of interesting which is we kind of divide it into in band and out of band so in band is your traditional access control. This is the past. People should take and we've got permissions access control lists all that kind of good stuff there.
Then there's the out of band and that's really where everybody likes to talk about data at rest and in transit and the reality is those are really, really good for out of band access for hey, someone got access to the disk without going through the access controls someone to access because we're going over open network to the raw packets. And so really. That's where encryptions role becomes very strong now encryption is also part of how access controls are enforced usefully but really their role is to protect against those unexpected paths and so it's kind of an interesting way that set of realizations as we discussed this and structured it and so.
I'll be seeing that as as we come out with the with the updated version of the Azure. Security benchmarks so Michael on over to you.
Few things peaked my interest this week, the first one was an issue in Azure sphere. So as your sphere is basically a hardware solution that's used in iot devices think of it as a mini TPMS trusted platform module. So you can store keys in there and it's kind of a root of trust. We issued a critical vulnerability. Just recently in this so the build is going to be billed 20.08 if you're using Azure sphere. You really need to take this update and the reason? Is there's a vulnerability fixed in there and Wolf SSL.
So Wolf SSL is an open source TLS library. There's many useful iot devices. I actually have played with I played with Wolf SSL on Arduinos If you're familiar with our do. We know devices works really, really nicely. But there's a really critical vulnerability. They just fixed for those of you? Who are interested. It is CV, 20224, 613. Again, I'll add the links to the notes, but the vulnerability essentially allows a attacker.
To impersonate a TLS 1.3 server.
Which is pretty catastrophic so this is a critical vulnerability please? Do make sure that you apply the Patch?
The Next One is in Azure Data Lake Storage. Gen 2 access control lists. We support Posix, one double 03 dot one. Ackles access control lists in Azure Data Lake Storage Gentoo. But The thing is, we made a change to an Apple it would only appear on that object so for example, you applied and Ackles or folder. It would only appear on that folder well now. You can inherit or do a recursive. Akal sort of roll down to objects below that folder if you wish.
Is available now in public preview?
Another one is in GitHub GitHub has this notion of things called actions and you can now do and as your policy compliance scan inside of a GitHub Workflow, so that's also in public preview. This is really fantastic because people are checking code in into GitHub. You can see how the code may be affected by Azure Azure policies that you're actually using some a huge fan of that particular that particular update the next one is one that.
The funny thing about this is I was working with a customer just recently.
They actually ran into this problem is actually fixed by this scenario.
So as you Kibale now has event grid integration and you can in your code, you can register for events that are coming out of Kibale. So for example, let's say a key is going to expire and say 30 days. As an example, let's hear let's say your application is using that key. Then you can get notification that the key is going to expire in 30 days.
So that way, when or even the key changes, you can get that notification as well so they can change. So let's say you get notified that a key is changed. You can now go and reach in and pull out the new key access controller side. This is a feature that a lot of customers have been asking for and that is in preview as well. So that's really great to see that, I think that solves some really serious customer customer pain points, especially when customers were rolling keys on a regular basis.
So yeah, will have notes for all of these in the show notes When we're done. Glad it's over too.
Thank you Michael for the first knew. I wanted to mention that now they are three ninja training available. Previously I had mentioned about Sentinel Ninja training. Now that we have defender ATP, an Azure security center, so these courses start from basic all away to advance courses, so I'm excited about this course is the next news that I wanted to mention is about the upcoming billing changes to Azure bastion.
These services are diploid across several data center, including government. So billing options are being extended. I recently started playing with this service on not that familiar with it, but what I have learned is that this service is a past service that provide secure RDP and SSH access. So in other words there few options to configure RDP for Azure VMS Number One.
Provide a public IP to the VM and expose it out, but there's some poorest scanning and other threats that may affect it. #2 you could use Azure Security Center. We just in time and only expose the public IP when you need it, but there's still some port scanning risk and other risks #3. You could use a jump server an expose only the IP of the jump server, but again, there's other risk.
In in here, so here the bastion service allows, which is maintained by Microsoft, and Harden allows you to connect directly from the Azure portal. So now you don't have to expose that external IP and you're being authenticated and you could have MF a conditional access or zero trust verification before they attempt access. Guys, do you know a little bit?
More about Azure bastion that you could add.
One of the things that we're actually really looking forward to using it in our our privileged access workstation architecture, where we?
Essentially, as we're transferring from sort of on premise domain joined or dedicated admin forest in the extreme case to the cloud based architecture where the workstation is managed and secured by the cloud for the admins that we really need a way to not only manage the cloud resources, but also be able to do kind of the reach back to the legacy on Prem resources in I as an on premises. And so we're actually looking at using Azure bastion to help with that. It's not the only option, it probably a couple choices in the architecture were still.
Working through that, but it's definitely a great secure option for providing that secure, secure administration of the legacy resources.
Well thanks everyone for the news. Let's switch tax now and go over to our guest Talia. She was a product manager for Microsoft threat protection with Microsoft in Israel. Tel hey, give us a give us a quick background on yourself. What do you do what you do for Microsoft? How long you've been with the company?
Hello and thank you for having me in this app podcast. I've been in Microsoft for almost three years. I started as a product manager in a Azure Advanced threat protection product or Azure ATP. I've been there for more than two years. I was the detection PM product manager in charge of the security of Azure ATP. In the investigation experience, we provide customers and six months ago I switched teams and join their Microsoft threat protection or empty P product team.
And today I'm leading the advanced hunting experience in Microsoft Word Protection.
Hi tally, can you give us a quick elevator pitch about Microsoft threat protection and how it relates to the rest of the threat protection products?
Yes, so Microsoft threat protection is an integrated cross domain through detection and response solution, it natively coordinates detection, prevention, investigation and response across the endpoints. Identity's, emails and cloud application.
It is actually a solution that is built on top of the security services Microsoft Office.
It includes Microsoft defender ATP, which covers the endpoints domain office ATP, which covers the emails and collaboration domain Azure ATP and Azure AAD identity.
Protection covers the identity's domains both on premise and and in the cloud and cloud app security which covers the cloud. The cloud application domains.
And Microsoft threat protection is eventually an experienced. Your security operation. Analysts can welcome until a year back. We have this different security services that I just mentioned is security services has it's own portal that you so analysts can use to investigate response and hand over threats in this specific domain. And as we know it's a lot of work and.
At the end, the tax are not are not limited to a single domain, so we came up with Microsoft threat protection, which is our Better Together solution. This is a unique experience where you can see all the different signals and data collected from these different services in one place. It includes unified incidents Q You can see all the different security alert signals raised by the different security solutions in one place.
And we're doing Smart Correlations we we are collecting the data from all the products and we know how to correlate the different signals into the same incident or story that describe specific attack. In addition to that we have automatic an investigation response capabilities on top of the different assets and domains and also unified hunting experience that you can use in a Microsoft credit protection.
So right there you have mentioned some of the benefits for the security, operation center or sock, but it could you explain how is different. Can you talk a little bit about the incident Q?
Yes, Sir, of course so.
Also, the only side incidents you, it's uh, it is built of the different security alerts collected by the different services, and we correlate them into what we call incident. An incident is representation of a specific attack that all alerts involved in this attack are part of the same.
For example, we have different faces of that tag, which is then only attacking chain most of the time it starts from the discovery phase going to 22 reconnaissance the credential, the lateral movement, persistent exfiltration. I think I covered all of them and the different products have coverage for the different attacking change sizes in their own domain, so discovery or.
Jax is most popular. Vector is a slow fishing campaign fishing gamers and this one officer 80 PM covers then at the in the credential access phase. Most of the time that I will try to get access into the network, they will try to get credential of someone in the organization so they can get into the different assets this account is using and have initial access into the organization.
This face different products covered in different domains, whether it's on the endpoint, whether it's through Azure ID or don't promise directory, and let's assume you will have one alert coming from office ATP of a suspicious or malicious even fishing I contain or phishing email against your organization. You have one alert in office ATP. Then during the credential access.
Just trying to get access into the environment are using both source and then for example Azure ATP race and you have another in MPP. We know to correlate this two different alerts.
It happens in 2 different domain. One is in the email and collaboration. One is in the identity domain came from different services. But we have the ability to know to learn both of them when they send their related and we provide you an incident that consists of these 2 alerts and more that will find later.
So during the same incident and you get the full the full story. I think that today. One of the most challenging thing that security. Analysts need to to face with the amount of alerts in each product. There are so many different security products each security plus product race.
Many many alerts and then humanise needs to monitor that and in empty P using the unified incident skill. We are trying to help them. We're trying to build a better story better frames so they will understand the connection between alerts and they will have more.
Convenient place and 11 single pane of glass to to look at when they starting their investigation.
So tell me can you dive into more detail about threat hunting I mean? I know a little bit about it, but I'll be honest with you, my expertise with it is, is minimal. So yeah, if you'd explain threat hunting with advanced threat hunting in NTP.
The advanced hunting is the platform you can use in empty P to do threat hunting on top of the different data. Microsoft collects in in the different domains. We just discussed.
There are 2 main scenarios for threat hunting the first one, is when you would like to proactively hand for threats. We know there are the alerts. That triggered by the different security products, but each organization in the end has its own scenarios. It's own thread that they would like to protect against because they are part of a specific sector. For example, we are in a specific period of time, like the COVID-19 that generated specific attacks that.
That you would like to to make sure that you know if they get to your organization, so you would like to proactively hand for them and in proactively hunting you're using the raw data. The different data collected by the security products on your organization on the different assets on endpoints on identity's on emails transactions and so on, and you and you're trying to find.
The unknown facts and make sure you're fighting by yourself. The suspicious activities. So this is the first scenario of a threat hunting. The second most common scenario for threatening is when you would like to handle this part of an ongoing investigation and alert was triggered and already incident started you investigating it and you would like to learn more about what is happening about the alerts that were triggered.
About the different entities that are involved in della and you can reach your investigation in advance in advance. Standing by doing threat hunting. You can find more information or related activities to the same incident or you can learn more about the activities. The different entities generated for example, if there are specific device involved or user involved in the incident and you would like to see what other activities they did.
I'll just get a picture or status about those entities you can hunt for that on top of the raw data.
I notice that in July and August this year. There was a series of 4 web casts about advanced hunting using Microsoft threat protection that were part of the security community will provide the links in the show notes, but could you provide some highlights about what things we talked about in those in those discussions.
In July and August we had the webcast series of tracking the adversary. The advanced hunting platform in Microsoft threat protection is based on top of kusto query language. We store all the different raw data collected by the different products in kusto clusters. So the way you can hand hunt on top of the data is using kusto query language or in short, KQL and.
It's very similar to SQL if some of you are familiar with it. It's eventually database provided by Microsoft and kick you all is language that enables you to do eventually any query would like on top of the data. Every query that comes to your mind and you would like to to run it to search for it too.
You can just do everything with kick you out, however you need to know kick you out, and you need to be familiar with its different functionalities and operators and also in advanced hunting specifically we have some different features and we wanted to make sure everyone is aware of it, so they can enjoy the hunting experience with providing entity. Therefore we build this webcast series 2 to help customers get on boarded.
2 hunting in empty this webcast is for everyone, even if you don't have any knowledge of KQL or hunting. You can watch. It includes a full episodes and the first episode is super super basic recover the basics of advanced hunting capabilities and also basically cake you'll syntax and operator. This is the episode one of QL fundamentals.
In the second half his odds, we get more advanced we cover the join operator, which is a super strong operator in KQL and it's also super valuable in hunting becausw as we already understand the power of hunting in empty P is that you have one place to hunt over the data of endpoint identity's emails. You don't need to go to different portals to run for those you have.
You only find handing experience and the join operators provide you the ability to hunt on this specific data and the the third episode. We're getting even more advanced with more advanced. Operators of summarizing and pivoting and we demonstrate how you can visualize the data. So, sometimes it is more convenient. It can help you generate some some reports and in the last episode.
We're hunting together and while we're hunting together with demonstrator different features you can use to make your hunting experience easier.
One of the features we demonstrate is the ability to create custom detection. Words on top of the raw data many times it can be super valuable if you're proactively hunting for thread and then you find common suspicious behavior would like to make sure you will get alerted next time you will see it in the organization. You can use the feature of custom detection works to make your query security alert so you can just get alerts on top of this.
Equally that you discover the using it the suspicious activity and I only recommend to everyone to to watch this series. If you already know KQL you can start from them all advanced app is all that there are some really, really good stuff over there.
This is awesome, so NTP correlate's all the information together, it does automatic analysis and provide a lot of custom focus information to the analysts. But with this, you're saying that they have access to the raw data correct.
Yes, that's correct.
NNTP what we do, we're getting the whole data collected by the different products and we are sharing it with the customers in a different Cousteau tables, so for example, all the raw data collected by Microsoft defender ATP on your end points will be in a section of device tables and all of the tables related for raw data collected.
On the device will start with the prefix device so it is very clear what is the domain this specific table covers and from where this raw data was collected?
So advanced hunting is using a schema reference. In order to provide this information. What type of information is provided within the reference.
Using this schema reference feature you can better understand what data we exposed as the different products are collecting data. We expose this data in advance hunting. We're talking on many, many different activities.
I just love the fact that you know that raw data is available and then you can query it through kusto query language. That's just awesome. I do have one question. I mean Microsoft protection with Sentinel.
This is where I start to get a little bit confused. So what's the difference here? You know, do they work together? Can you explain that?
The main difference between empty PN Sentinel is that Sentinel is a is a steam Sentinel is the Microsoft new generation seem, and it's you can connect to it every letter you would like not only Microsoft data. If you have security product of 3rd party you can connect this data to Sentinel as well and NTP focus.
Is on the data we collected by the different Microsoft security solutions, so all the information in empty all the raw data and all the security alerts?
Collected by Microsoft Microsoft services.
We we do have a plan to do an alignment between Sentinel an empty P for the Microsoft data because at the end both products generate incidents and exposed hunting experience. So we would like to make sure that at least we will have an alignment on how we display incident and raw data of Microsoft collected data and TP is the place for you to avoid.
And richness, I can say land, Richmond, we're doing on Microsoft data, but if you would like to correlate this Microsoft data with third party data, this is where you will pivot to Sentinel. And you can do this correlation with third party data as well.
Yeah, thanks. I think that really helped. I think it's really important that you know when people looking at the Microsoft Suites of security products that they do understand the differences between threat protection products and sends an all and Azure Security Center and some of these tools are sources. Some of them are sinks and choosing the appropriate appropriate technologies to help secure their environment.
If you had one item you would like everyone to know or be aware, what would it be?
I think that first it will be that you can access them deep experience by going to security dotmicrosoft.com and in order to have this experience enable you. You don't need to have all the different advanced threat protection services that I mentioned in the beginning. It is enough for you to have only one service enabled for example, you have only Microsoft defender ATP you can.
Use it in order to use the NTP experience so you don't need to have the entire Microsoft. Security suit to to have the empty experience in idle for you.
Will tell you thanks so much for joining us this week. I certainly learned a bunch of new things and with that. Hey let's bring this episode to a close.
Thanks for listening. We hope you found this useful stay safe and we'll see you next time.
Thanks for listening to the Azure Security podcast. You can find show notes and other resources at our website AzSecurityPodcast.net if you have any questions. Find us on Twitter @AzSecPod. Background music is from CCmixter.com and licensed under the Creative Commons license.
