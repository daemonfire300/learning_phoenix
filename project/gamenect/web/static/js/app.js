// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import "jqueryui"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

var AppSearchGame = {
    run: function(){
        let game_title_input = document.querySelector('#lobby_game');
        if(game_title_input){
            var dataList = [];
            $('#lobby_game').autocomplete({
                source: function(req, resp){
                        $.getJSON("/api/v1/game?q=" + req.term, function(data){
                            let games = data.games;
                            dataList = Array.from(games).map(function(v, i){
                                return {
                                    label: v.title,
                                    value: v.id
                                };
                            });
                            resp(dataList);
                        });
                }
            });
        }
    }
}

module.exports = {
  AppSearchGame: AppSearchGame
};