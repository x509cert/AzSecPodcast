document.addEventListener("DOMContentLoaded", function() {

   var container = document.getElementById("episodes-container");
   if (!container) return;

   var INITIAL_BATCH = 15;

   function renderEpisode(ep, idx) {
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
         + '<span style="font-weight:bold">Episode ' + n + '</span> - ' + ep.date + ' - [<span id="' + anchorId + '">' + ep.title + '</span>] '
         + '<a href="#' + anchorId + '" title="Link to this section"><i class="fa-solid fa-link" style="font-size: 0.8em; color: #666;"></i></a>'
         + '</h3>'
         + '<div class="EpisodeContent" id="' + contentId + '"' + hidden + '>'
         + ep.contentHtml
         + '</div>'
         + '</div></div></article>';
   }

   function scrollToHash() {
      var hash = window.location.hash;
      if (hash) {
         var target = document.getElementById(hash.substring(1));
         if (target) target.scrollIntoView();
      }
   }

   // Event delegation: single listener handles all expand/collapse clicks
   container.addEventListener("click", function(e) {
      var h3 = e.target.closest("h3.Heading");
      if (!h3) return;

      var contentId = "Content-" + h3.id;
      var iconId = "ColExp-" + h3.id;
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

   fetch("data/episodes.json")
      .then(function(r) {
         if (!r.ok) throw new Error("HTTP " + r.status);
         return r.json();
      })
      .then(function(data) {
         var episodes = data.episodes || [];
         if (episodes.length === 0) return;

         // Phase 1: render the first batch immediately so the page is usable fast
         var firstBatch = episodes.slice(0, INITIAL_BATCH);
         container.innerHTML = firstBatch.map(renderEpisode).join('\n');

         // Eager-load the newest episode's player since it's visible by default
         var firstIframe = container.querySelector('article:first-child iframe');
         if (firstIframe) firstIframe.removeAttribute('loading');

         scrollToHash();

         // Phase 2: render remaining episodes after the browser paints the first batch
         var remaining = episodes.slice(INITIAL_BATCH);
         if (remaining.length > 0) {
            setTimeout(function() {
               var temp = document.createElement('div');
               temp.innerHTML = remaining.map(function(ep, idx) {
                  return renderEpisode(ep, idx + INITIAL_BATCH);
               }).join('\n');

               var fragment = document.createDocumentFragment();
               while (temp.firstChild) {
                  fragment.appendChild(temp.firstChild);
               }
               container.appendChild(fragment);

               scrollToHash();
            }, 0);
         }
      })
      .catch(function(err) {
         console.error("Failed to load episodes:", err);
         container.innerHTML = '<div class="row add-bottom"><div class="nine columns offset-2"><p>Failed to load episodes. Please refresh.</p></div></div>';
      });
});
