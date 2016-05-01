// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//
//

$(function() {
  if ($("#gamecontainer").attr("data-game-id")){
    //setTimeout(updateGame, 3000);
  }
});

function updateGame () {
  var game_id = $("#gamecontainer").data("game-id");
  var user_id = $("#gamecontainer").data("user-id");
  if (game_id) {
    $.getScript("/games/show.js?game_id=" + game_id + '&user_id=' + user_id);
    setTimeout(updateGame, 3000);
  }
}
