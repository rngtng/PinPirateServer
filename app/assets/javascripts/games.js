var request = function(gamesPath){
  $.ajax({
    url: gamesPath,
    dataType: 'json',
    success: function (data, status, xhr) {
      $('#games').removeClass('scheduled');
      updateGame(data);
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
  if( $(".player .name form").size() == 0 ) {
    $(".player .name").html('<span class="best_in_place" id="best_in_place_player_1_name" data-url="/players/' + game.player.id + '" data-object="player" data-attribute="name" data-type="input">' + game.player.name + '</span>');
    $('.best_in_place').best_in_place();
  }

  // if( $(".player .twitter form").size() == 0 ) {
  //   $(".player .twitter").html('<span class="best_in_place" id="best_in_place_player_1_twitter_handle" data-url="/players/' + game.player.id + '" data-object="player" data-attribute="twitter_handle" data-type="input">' + game.player.twitter_handle + '</span>');
  //   $('#best_in_place_player_1_twitter_handle').best_in_place();
  // }

  $(".player .slot").html(game.slot);
  $(".player .score").html(game.score);
  $(".player .digits span").each(function(index) {
    var $digit = $(this),
             d = game.score_s.substr(index, 1) || 0;
    $digit.attr('class', "d" + d);
  });
},
schedule = function(){
  $('#games:not(.scheduled)').each(function(){
    var gamesPath = $(this).data('games-path'),
        pullTime = $(this).data('pull-time');
    $('#games').addClass('scheduled');
    window.setTimeout(function(){
      request(gamesPath);
    }, window.parseInt(pullTime));
  });
};

$(function(){
  $('#games').each(function(){
    schedule();
  });
});