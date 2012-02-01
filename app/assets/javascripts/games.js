var request = function(gamesPath){
  $.ajax({
    url: gamesPath,
    dataType: 'json',
    success: function (games, status, xhr) {
      updateSlots(games);
      $('#slots').removeClass('scheduled');
      schedule();
    },
    error: function (jqXHR, textStatus, errorThrown) {
      console.log(jqXHR);
      console.log("Error in request:" + textStatus + " - " + errorThrown);
      schedule();
    }
  });
},
updateSlot = function(game){
  var $slot = $(".slot#nr" + game.slot);
  $slot.removeClass('hidden current');
  $name = $slot.find(".name span");
  if ($name.html().indexOf("<form") == -1) {
    $name.attr('data-url', '/players/' + game.player.id);
    $name.html(game.player.name);
    $slot.find(".name").html($name.clone().best_in_place());
  }

  // if( $(".player .twitter form").size() == 0 ) {
  //   $(".player .twitter").html('<span class="best_in_place" id="best_in_place_player_1_twitter_handle" data-url="/players/' + game.player.id + '" data-object="player" data-attribute="twitter_handle" data-type="input">' + game.player.twitter_handle + '</span>');
  //   $('#best_in_place_player_1_twitter_handle').best_in_place();
  // }

  $slot.find(".score").html(game.score).end()
    .find(".digits span").each(function(index) {
      var $digit = $(this),
      d = game.score_s.substr(index, 1) || 0;
      $digit.attr('class', "d" + d);
    });
},
updateSlots = function(games){
  $.each(games, function(index, game) {
    updateSlot(game);
  })
  if( (game = games[0])) {
    $(".slot#nr" + game.slot).addClass('current');
    $(".no_games").addClass('hidden');
  }
  else {
    $(".no_games").removeClass('hidden');
  }
},
schedule = function(){
  $('#slots:not(.scheduled)').each(function(){
    var gamesPath = $(this).data('games-path'),
        pullTime = $(this).data('pull-time');
    $('#slots').addClass('scheduled');
    window.setTimeout(function(){
      request(gamesPath);
    }, window.parseInt(pullTime) * 1000);
  });
};

$(function(){
  $('#slots').each(function(){
    schedule();
  });
  $(".best_in_place").best_in_place();
  var $tabs = $('#scores').tabs();

  //var selected = $tabs.tabs('option', 'selected'); // => 0

});