document.addEventListener("DOMContentLoaded", function() {

   var container = document.getElementById("episodes-container");
   if (!container) return;

   var episodesByNumber = {};
   var fullEpisodesPromise = null;

   function padEpisodeNumber(n) {
      return n >= 100 ? String(n).padStart(4, '0') : String(n).padStart(3, '0');
   }

   function getEpisodeFile(ep) {
      return ep.file || ('Episode' + padEpisodeNumber(ep.number) + '.json');
   }

   function renderEpisode(ep) {
      var n = ep.number;
      var p = padEpisodeNumber(n);
      var headingId = 'Ep' + p;
      var anchorId = 'ep' + p;
      var contentId = 'Content-' + headingId;

      return '<article>'
         + '<div class="row add-bottom">'
         + '<div class="nine columns offset-2">'
         + '<h3 class="Heading" id="' + headingId + '">'
         + '&nbsp;<img id="ColExp-' + headingId + '" class="ColExpIcon" width="16" height="16" src="images/Expand.png" alt=""> '
         + '<span style="font-weight:bold">Episode ' + n + '</span> - ' + ep.date + ' - [<span id="' + anchorId + '">' + ep.title + '</span>] '
         + '<a href="#' + anchorId + '" title="Link to this section"><i class="fa-solid fa-link" style="font-size: 0.8em; color: #666;"></i></a>'
         + '</h3>'
         + '<div class="EpisodeContent" id="' + contentId + '" hidden></div>'
         + '</div></div></article>';
   }

   function scrollToHash() {
      var hash = window.location.hash;
      if (hash) {
         var target = document.getElementById(hash.substring(1));
         if (target) target.scrollIntoView();
      }
   }

   function fetchJson(url) {
      return fetch(url).then(function(r) {
         if (!r.ok) throw new Error("HTTP " + r.status);
         return r.json();
      });
   }

   function loadFullEpisodes() {
      if (!fullEpisodesPromise) {
         fullEpisodesPromise = fetchJson("data/episodes.json").then(function(data) {
            (data.episodes || []).forEach(function(ep) {
               episodesByNumber[ep.number] = ep;
            });
            return data.episodes || [];
         });
      }

      return fullEpisodesPromise;
   }

   function loadEpisode(ep) {
      if (ep.contentHtml) return Promise.resolve(ep);
      if (ep.loadPromise) return ep.loadPromise;

      ep.loadPromise = fetchJson("data/" + getEpisodeFile(ep))
         .then(function(fullEpisode) {
            episodesByNumber[fullEpisode.number] = fullEpisode;
            ep.contentHtml = fullEpisode.contentHtml;
            return ep;
         })
         .catch(function(err) {
            console.warn("Falling back to episodes.json for episode " + ep.number + ":", err);
            return loadFullEpisodes().then(function() {
               var fullEpisode = episodesByNumber[ep.number];
               if (!fullEpisode || !fullEpisode.contentHtml) {
                  throw new Error("Episode " + ep.number + " content was not found.");
               }

               ep.contentHtml = fullEpisode.contentHtml;
               return ep;
            });
         });

      return ep.loadPromise;
   }

   function getEpisodeFromHeading(h3) {
      var number = parseInt(h3.id.replace(/^Ep/, ''), 10);
      return episodesByNumber[number];
   }

   function openEpisode(h3) {
      var content = document.getElementById("Content-" + h3.id);
      var icon = document.getElementById("ColExp-" + h3.id);
      var ep = getEpisodeFromHeading(h3);
      if (!content || !ep) return Promise.resolve();

      if (content.dataset.loaded === "true") {
         content.hidden = false;
         if (icon) icon.src = "images/Collapse.png";
         return Promise.resolve();
      }

      content.innerHTML = '<p>Loading episode...</p>';
      content.hidden = false;
      if (icon) icon.src = "images/Collapse.png";

      return loadEpisode(ep)
         .then(function(fullEpisode) {
            content.innerHTML = fullEpisode.contentHtml;
            content.dataset.loaded = "true";

            var iframe = content.querySelector('iframe');
            if (iframe && h3 === container.querySelector('h3.Heading')) {
               iframe.removeAttribute('loading');
            }
         })
         .catch(function(err) {
            console.error("Failed to load episode:", err);
            content.innerHTML = '<p>Failed to load this episode. Please refresh.</p>';
         });
   }

   function closeEpisode(h3) {
      var content = document.getElementById("Content-" + h3.id);
      var icon = document.getElementById("ColExp-" + h3.id);
      if (content) content.hidden = true;
      if (icon) icon.src = "images/Expand.png";
   }

   function getInitialHeading() {
      var hash = window.location.hash;
      if (hash) {
         var target = document.getElementById(hash.substring(1));
         if (target) {
            var heading = target.closest("h3.Heading");
            if (heading) return heading;
         }
      }

      return container.querySelector("h3.Heading");
   }

   // Event delegation: single listener handles all expand/collapse clicks
   container.addEventListener("click", function(e) {
      var h3 = e.target.closest("h3.Heading");
      if (!h3) return;

      var content = document.getElementById("Content-" + h3.id);
      if (!content) return;

      if (content.hidden) {
         openEpisode(h3);
      } else {
         closeEpisode(h3);
      }
   });

   fetchJson("data/episodes-index.json")
      .catch(function(err) {
         console.warn("Falling back to full episodes list:", err);
         return loadFullEpisodes().then(function(episodes) {
            return { episodes: episodes };
         });
      })
      .then(function(data) {
         var episodes = data.episodes || [];
         if (episodes.length === 0) return;

         episodes.forEach(function(ep) {
            episodesByNumber[ep.number] = ep;
         });

         container.innerHTML = episodes.map(renderEpisode).join('\n');

         var initialHeading = getInitialHeading();
         if (initialHeading) {
            openEpisode(initialHeading).then(scrollToHash);
         }
      })
      .catch(function(err) {
         console.error("Failed to load episodes:", err);
         container.innerHTML = '<div class="row add-bottom"><div class="nine columns offset-2"><p>Failed to load episodes. Please refresh.</p></div></div>';
      });
});
