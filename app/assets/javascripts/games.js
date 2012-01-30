var request = function(gamesPath){
  $.ajax({
    url: gamesPath,
    dataType: 'json',
    success: function (data, status, xhr) {
      $('#games').removeClass('scheduled');
      updateGames(data);
      schedule();
    },
    error: function (jqXHR, textStatus, errorThrown) {
      console.log(jqXHR);
      console.log("Error in request:" + textStatus + " - " + errorThrown);
      schedule();
    }
  });
},
updateGame = function(game){
  var $game = $(".game.slot" + game.slot);
  $game.find(".name form").each(function(){
    $game.find(".name").html('<span class="best_in_place" id="best_in_place_player_1_name" data-url="/players/' + game.player.id + '" data-object="player" data-attribute="name" data-type="input">' + game.player.name + '</span>');
    $game.find(".best_in_place").best_in_place();
  });

  // if( $(".player .twitter form").size() == 0 ) {
  //   $(".player .twitter").html('<span class="best_in_place" id="best_in_place_player_1_twitter_handle" data-url="/players/' + game.player.id + '" data-object="player" data-attribute="twitter_handle" data-type="input">' + game.player.twitter_handle + '</span>');
  //   $('#best_in_place_player_1_twitter_handle').best_in_place();
  // }

  $game.find(".slot").html(game.slot).end()
    .find(".number").html(game.score).end()
    .find(".digits span").each(function(index) {
    var $digit = $(this),
             d = game.score_s.substr(index, 1) || 0;
    $digit.attr('class', "d" + d);
  });
},
updateGames = function(games){
  $.each(games, function(index, game) {
    updateGame(game);
  })
},
schedule = function(){
  $('#games:not(.scheduled)').each(function(){
    var gamesPath = $(this).data('games-path'),
        pullTime = $(this).data('pull-time');
    $('#games').addClass('scheduled');
    window.setTimeout(function(){
      request(gamesPath);
    }, window.parseInt(pullTime) * 1000);
  });
};

$(function(){
  $('#games').each(function(){
   // schedule();
  });

  var $tabs = $('#score-table').tabs();

  //var selected = $tabs.tabs('option', 'selected'); // => 0

});