pixel-game
==========

##About

A stupid pixel game, which I have coded in a few hours. A pixel, a sinusoid and physics...

This uses Haxe so it can be compile for the browser - HTML canvas and Flash, as iOS and Android native apps - uses openGL.

##License

WTFPL (Do What the Fuck You Want to Public License)

##Use

Requirements:

Haxe, OpenFl and lime, see [this guide to get started](https://medium.com/@premith/haxe-lime-openfl-ec9c2784aaa8).

Install and launch in the browser:

    git clone git@github.com:lexoyo/pixel-game.git
    cd pixel-game/
    lime test openfl.xml html5
    
Deploy and launch on ios (requires apple developer account and ```lime setup ios```)

    lime test openfl.xml ios

Deploy and launch on Android (requires ```lime setup android```)

    lime test openfl.xml android

