   $(document).ready(function() {

   // collapse all but the first episode
   $("div.EpisodeContent").hide();
   $("div.EpisodeContent:first").show();

   // set the correct expand/collapse icon
   $("img.ColExpIcon").attr('src','images/expand.png');
   $("img.ColExpIcon:first").attr('src','images/collapse.png');

   // toggle the cursor type when hovering over the episode header
   $('h3.Heading').css('cursor', 'pointer'); 
   
   // Handle click on a title - expand or collapse 
   $("h3.Heading").click(function() {
      const delay = 300;
      
      var h = "#Content-" + $(this).attr("id");
      var ec = "ColExp-"+ $(this).attr("id");

      if ($(h).is(":hidden")) {
         $(h).slideDown(delay);
         document.getElementById(ec).src="images/Collapse.png";
      }
      else { 
         $(h).slideUp(delay);
         document.getElementById(ec).src="images/Expand.png";
      }
      })
});
