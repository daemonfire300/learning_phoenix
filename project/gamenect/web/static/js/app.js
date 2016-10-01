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

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

/**
 * @param {Object} game
 */
function renderSingleGameEntry(game, selectCallback){
    let entry = document.createElement("li");
    entry.innerHTML = game.title;
    entry.setAttribute("data-game-id", game.id);
    entry.onclick = selectCallback
    return entry;
}

/**
 * @param {Element} elem
 */
function setInputValue(elem, value){
    elem.value = value;
}

/**
 * @param {string} anchor
 * @param {Object[]} games
 */
function renderGameSelection(anchor, games){
    let anchor_elem = document.querySelector(anchor);
    anchor_elem.innerHTML = "";
    let list = document.createElement("ul");
    games.forEach(function(v){
        list.appendChild(renderSingleGameEntry(v, function(ev){
            setInputValue(document.querySelector(gameSelectInputName), ev.originalTarget.innerHTML);
        }));
    });
    anchor_elem.appendChild(list);
}
var gameSelectionAnchorName = "div.game-list";
var gameSelectInputName = '#lobby_game';
var AppSearchGame = {
    run: function () {
        let game_title_input = document.querySelector(gameSelectInputName);
        if (game_title_input) {
            game_title_input.onkeypress = function () {
                $.getJSON("/api/v1/game?q=" + game_title_input.value, function (data) {
                    let games = Array.from(data.games);
                    renderGameSelection(gameSelectionAnchorName, games);
                });
            };
        }

    }
}

module.exports = {
    AppSearchGame: AppSearchGame
};