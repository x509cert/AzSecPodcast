document.addEventListener("DOMContentLoaded", function() {

   var container = document.getElementById("episodes-container");
   if (!container) return;

   fetch("data/episodes.json")
      .then(function(r) {
         if (!r.ok) throw new Error("HTTP " + r.status);
         return r.json();
      })
      .then(function(data) {
         var episodes = data.episodes || [];
         if (episodes.length === 0) return;

         container.innerHTML = episodes.map(function(ep, idx) {
            var n = ep.number;
            var p = n >= 100 ? String(n).padStart(4, '0') : String(n).padStart(3, '0');
            var headingId = 'Ep' + p;
            var anchorId = 'ep' + p;
            var contentId = 'Content-' + headingId;
            var isOpen = idx === 0;
            var icon = isOpen ? 'images/Collapse.png' : 'images/Expand.png';
            var hidden = isOpen ? '' : ' hidden';

            return '<article>'
               + '<div class="row add-bottom">'
               + '<div class="nine columns offset-2">'
               + '<h3 class="Heading" id="' + headingId + '">'
               + '&nbsp;<img id="ColExp-' + headingId + '" class="ColExpIcon" width="16" height="16" src="' + icon + '" alt=""> '
               + 'Episode ' + n + ' - ' + ep.date + ' - [<span id="' + anchorId + '">' + ep.title + '</span>] '
               + '<a href="#' + anchorId + '" title="Link to this section"><i class="fa-solid fa-link" style="font-size: 0.8em; color: #666;"></i></a>'
               + '</h3>'
               + '<div class="EpisodeContent" id="' + contentId + '"' + hidden + '>'
               + ep.contentHtml
               + '</div>'
               + '</div></div></article>';
         }).join('\n');

         // Wire up expand/collapse
         document.querySelectorAll("h3.Heading").forEach(function(h3) {
            h3.style.cursor = "pointer";
            h3.addEventListener("click", function() {
               var contentId = "Content-" + this.id;
               var iconId = "ColExp-" + this.id;
               var content = document.getElementById(contentId);
               var icon = document.getElementById(iconId);
               if (!content) return;

               if (content.hidden) {
                  content.hidden = false;
                  if (icon) icon.src = "images/Collapse.png";
               } else {
                  content.hidden = true;
                  if (icon) icon.src = "images/Expand.png";
               }
            });
         });
      })
      .catch(function(err) {
         console.error("Failed to load episodes:", err);
         container.innerHTML = '<div class="row add-bottom"><div class="nine columns offset-2"><p>Failed to load episodes. Please refresh.</p></div></div>';
      });
});
